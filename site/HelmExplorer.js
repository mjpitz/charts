function HelmExplorer(repos, body) {
    const DEFAULT_ICON = "placeholder.png";

    const repoTemplate = ({ name, url }) => `
<div class="col-12">
    <pre><code>$ helm repo add ${name} ${url}</code></pre>
</div>
`;

    const chartTemplate = (name, { description, icon, version }) => `
<div class="col-12 col-sm-6 col-lg-3">
    <div class="card text-center">
        <div class="card-body">
            <p><img class="card-img-top" src="${icon}" alt="${name}" style="width: 125px; display: block; margin: auto;"></p>

            <h5 class="card-title"><a>${name}</a></h5>
            <p class="card-text">${description}</p>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">${version}</li>
            </ul>
        </div>
    </div>
</div>
`;
    const preface = repos.map(repoTemplate).join('')

    const promises = repos.map(async ({ name, url }) => {
        let suffix = "";
        if (!url.endsWith("index.yaml")) {
            suffix = "index.yaml" + suffix;
        }

        if (!url.endsWith("/")) {
            suffix = "/" + suffix;
        }

        url = url + suffix;

        const resp = await fetch(url);
        
        const data = await resp.text();

        const doc = jsyaml.load(data);

        const content = Object.keys(doc.entries).map((chartName) => {
            const entry = doc.entries[chartName][0];

            return chartTemplate(`${name}/${chartName}`, {
                description: entry.description,
                icon: entry.icon || DEFAULT_ICON,
                version: entry.version
            });
        });

        return content.join('');
    });

    Promise.all(promises)
        .then((content) => body.html(preface + content.join('')))
        .catch((err) => console.error(err));
}
