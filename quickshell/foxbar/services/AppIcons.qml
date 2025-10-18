import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton

Singleton {
    property var iconCache: ({})

    function getIcon(className: string): string {
        // console.log(className)
        if (!className) return null;

        const cls = className.toLowerCase();
        const cachedValue = iconCache[cls];
        if (cachedValue) return cachedValue;
        
        const desktopEntryResult = searchDesktopEntries(cls);
        if (desktopEntryResult.found) {
            iconCache[cls] = desktopEntryResult.icon;
            return iconCache[cls];
        }

        return null;
    }

    function searchDesktopEntries(term): var {
        // TODO: Improve search
        // for (let i = 0; i < desktopEntries.length; i++) {
        //     const entry = desktopEntries[i];
        //     if (term == entry.startupClass.toLowerCase() ||
        //         term == entry.id.toLowerCase() ||
        //         entry.name.toLowerCase().includes(term)) {
        //             return { found: true, icon: entry.icon };
        //         }
        // }

        const entry = DesktopEntries.heuristicLookup(term);
        if (entry) return { found: true, icon: entry.icon };

        return { found: false, icon: undefined };
    }
}