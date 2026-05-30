{ pkgs, lib, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxTranslations = true;
      DisableSetDefaultMailClient = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      SearchSuggestEnabled = false;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      BlockAboutConfig = false;
      BlockAboutProfiles = false;
      BlockAboutAddons = false;

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
          private_browsing = true;
        };
      };

      DataReporting = {
        SkipUpdateCheck = true;
        SkipFirstRunUse = true;
        SkipTelemetry = true;
      };

      Cookies = {
        Behavior = "reject-tracker";
        Locked = true;
      };

      HTTPSOnlyMode = "force_enabled";

      DNSoverHTTPS = {
        Enabled = true;
        Locked = true;
        Fallback = false;
      };

      Permissions = {
        Autoplay = {
          Default = "block-audio-video";
          Locked = true;
        };
        Camera = {
          BlockNewRequests = true;
          Locked = true;
        };
        Microphone = {
          BlockNewRequests = true;
          Locked = true;
        };
        Location = {
          BlockNewRequests = true;
          Locked = true;
        };
        Notifications = {
          BlockNewRequests = true;
          Locked = true;
        };
        VirtualReality = {
          BlockNewRequests = true;
          Locked = true;
        };
      };

      PrimaryPassword = false;

      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        History = true;
        Sessions = true;
        SiteSettings = true;
        OfflineApps = true;
        Downloads = true;
        FormData = true;
      };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = {
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        "privacy.resistFingerprinting.exemptedDomains" = "";
        "privacy.resistFingerprinting.letterboxing" = true;
        "privacy.resistFingerprinting.randomDataOnCanvasExtract" = true;

        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.socialtrack.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.lower_network_priority" = true;

        "privacy.firstparty.isolate" = true;
        "privacy.thirdparty.cookie.block" = true;
        "network.cookie.cookieBehavior" = 5;
        "network.cookie.thirdparty.sessionOnly" = true;
        "network.cookie.lifetimePolicy" = 2;
        "network.cookie.lifetime.days" = 1;

        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.functionality.enabled" = true;

        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "dom.security.https_only_mode_error_page_user_suggestions" = false;
        "security.ssl.enable_ocsp_must_staple" = true;
        "security.ssl.require_safe_negotiation" = true;
        "security.tls.enable_0rtt_data" = false;
        "security.certerrors.mitm.auto_enable_enterprise_roots" = false;
        "security.certerrors.recordEventTelemetry" = false;
        "security.pki.sha1_enforcement_level" = 1;

        "network.trr.mode" = 3;
        "network.trr.uri" = "https://dns.cloudflare.com/dns-query";
        "network.trr.custom_uri" = "https://dns.cloudflare.com/dns-query";
        "network.trr.default_provider_uri" = "https://dns.cloudflare.com/dns-query";
        "network.trr.bootstrappedAddresses" = "1.1.1.1,1.0.0.1";

        "media.peerconnection.enabled" = false;
        "media.peerconnection.ice.default_address_only" = true;
        "media.peerconnection.ice.obfuscate_host_addresses" = true;
        "media.peerconnection.ice.proxy_only" = true;
        "media.peerconnection.ice.no_host" = true;
        "media.peerconnection.ice.relay_only" = true;

        "webgl.disabled" = true;
        "webgl.enable-webgl2" = false;
        "dom.webgpu.enable" = false;
        "gfx.webrender.all" = false;
        "gfx.webrender.enabled" = false;
        "gfx.canvas.accelerated" = false;
        "gfx.canvas.accelerated.cache-items" = 0;
        "gfx.canvas.accelerated.cache-size" = 0;
        "gfx.content.azure.backends" = "cairo";
        "gfx.offscreencanvas.enabled" = false;

        "javascript.options.wasm" = false;

        "dom.serviceWorkers.enabled" = false;
        "dom.push.enabled" = false;
        "dom.push.connection.enabled" = false;
        "dom.webnotifications.enabled" = false;
        "dom.webnotifications.allowinsecure" = false;
        "dom.webnotifications.requireinteraction" = true;
        "dom.webnotifications.serviceworker.enabled" = false;

        "dom.battery.enabled" = false;
        "dom.vibrator.enabled" = false;
        "device.sensors.enabled" = false;
        "beacon.enabled" = false;
        "browser.send_pings" = false;
        "browser.send_pings.require_same_host" = true;
        "dom.storage.snapshot_limit" = 100;
        "dom.storage.snapshot_reusing" = false;
        "dom.gamepad.enabled" = false;
        "media.autoplay.enabled" = false;
        "media.autoplay.blocking_policy" = 2;
        "media.autoplay.default" = 5;
        "media.video_stats.enabled" = false;
        "media.hardware-video-decoding.enabled" = false;
        "media.webspeech.synth.enabled" = false;
        "media.webspeech.recognition.enable" = false;
        "dom.vr.enabled" = false;
        "dom.vr.require-gesture" = true;
        "dom.webauthn.attestation" = false;

        "network.prefetch-next" = false;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "network.http.speculative-parallel-limit" = 0;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.places.speculativeConnect.enabled" = false;

        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.cleanup" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.cachedClientID" = "";
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry.structuredIngestion" = false;
        "toolkit.telemetry.coverage.optout" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";

        "network.captive-portal-service.enabled" = false;
        "captivedetect.canonicalURL" = "";
        "network.connectivity-service.enabled" = false;

        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.referer.spoofSource" = true;
        "network.http.referer.trimmingPolicy" = 2;
        "network.http.referer.hideOnDomainSource" = true;

        "geo.enabled" = false;
        "geo.wifi.uri" = "";
        "geo.wifi.xpower" = false;
        "geo.wifi.logging.enabled" = false;
        "browser.region.network.scan" = 0;
        "browser.region.update.enabled" = false;
        "browser.region.logistics.backendsInUse" = "";
        "browser.region.local-geocoding" = false;

        "extensions.pocket.enabled" = false;
        "extensions.screenshots.disabled" = true;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.prerender" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.activity-stream.asrouter.providers.snippets" = "";
        "browser.newtabpage.activity-stream.asrouter.providers.cfr" = "";
        "browser.newtabpage.activity-stream.asrouter.providers.message-groups" = "";
        "browser.newtabpage.activity-stream.asrouter.providers.onboarding" = "";
        "browser.newtabpage.activity-stream.asrouter.providers.whats-new-panel" = "";
        "browser.discovery.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.quicksuggest.dataCollection.enabled" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.enable" = false;
        "browser.partnerlink.attribution" = false;
        "browser.tabs.firefox-view" = false;
        "browser.tabs.firefox-view-next" = false;
        "browser.privatebrowsing.autostart" = true;

        "extensions.autoDisableScopes" = 0;

        "permissions.default.autoplay" = 2;
        "permissions.default.camera" = 2;
        "permissions.default.microphone" = 2;
        "permissions.default.geo" = 2;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.xr" = 2;
        "permissions.default.shortcuts" = 2;
        "permissions.default.persistent-storage" = 2;
      };

      userChrome = ''
        :root {
          --toolbar-bgcolor: #000000 !important;
          --toolbar-color: #ffffce !important;
          --tabs-bg-color: #000000 !important;
          --tabs-text-color: #ffffce !important;
          --tab-hover-background-color: #111111 !important;
          --tab-active-background-color: #0a0a0a !important;
          --tab-selected-bgcolor: #111111 !important;
          --urlbar-bgcolor: #000000 !important;
          --urlbar-color: #ffffce !important;
          --urlbar-placeholder-color: #666666 !important;
          --nav-bar-bgcolor: #000000 !important;
          --sidebar-bg-color: #000000 !important;
          --sidebar-text-color: #ffffce !important;
          --panel-bg-color: #000000 !important;
          --panel-color: #ffffce !important;
          --panel-border-color: #222222 !important;
          --arrowpanel-background: #000000 !important;
          --arrowpanel-color: #ffffce !important;
          --arrowpanel-border-color: #222222 !important;
          --arrowpanel-dimmed: #111111 !important;
          --arrowpanel-dimmed-even-further: #0a0a0a !important;
          --menu-bgcolor: #000000 !important;
          --menu-color: #ffffce !important;
          --menuitem-hover-background-color: #111111 !important;
          --autocomplete-bg-color: #000000 !important;
          --autocomplete-color: #ffffce !important;
          --input-bgcolor: #0a0a0a !important;
          --input-color: #ffffce !important;
          --scrollbar-color: #222222 #000000 !important;
          --scrollbar-track-color: #000000 !important;
          --toolbarbutton-hover-background: #111111 !important;
          --toolbarbutton-active-background: #222222 !important;
          --lwt-toolbar-field-background-color: #0a0a0a !important;
          --lwt-toolbar-field-color: #ffffce !important;
          --lwt-toolbar-field-border-color: #222222 !important;
          --lwt-text-color: #ffffce !important;
          --lwt-accent-color: #000000 !important;
          --lwt-background-tab-text: #ffffce !important;
          --urlbar-separator-color: #222222 !important;
          --toolbar-field-border-color: #222222 !important;
          --panel-disabled-color: #555555 !important;
          --panel-description-color: #979797 !important;
          --chrome-content-separator-color: #111111 !important;
          --urlbar-box-bgcolor: #111111 !important;
          --urlbar-box-text-color: #ffffce !important;
          --urlbar-box-hover-bgcolor: #222222 !important;
          --urlbar-box-active-bgcolor: #333333 !important;
          --urlbar-box-focus-bgcolor: #111111 !important;
          --toolbar-field-focus-bgcolor: #0a0a0a !important;
          --toolbar-field-focus-color: #ffffce !important;
          --sidebar-border-color: #111111 !important;
        }

        #main-window,
        #navigation-bar,
        #nav-bar,
        #toolbar-menubar,
        #PersonalToolbar,
        #TabsToolbar,
        #sidebar-box,
        #sidebar,
        #browser,
        #appcontent,
        #tabbrowser-tabpanels,
        .browserContainer,
        .browserStack,
        #status-bar {
          background-color: #000000 !important;
          background-image: none !important;
        }

        #urlbar,
        #urlbar-background,
        .urlbar-input-box,
        #urlbar-input,
        #urlbar-results,
        .urlbarView-row,
        .urlbarView-body-inner {
          background-color: #000000 !important;
          color: #ffffce !important;
        }

        .urlbarView-row:hover,
        .urlbarView-row[selected] {
          background-color: #111111 !important;
        }

        .urlbarView-title {
          color: #ffffce !important;
        }
        .urlbarView-url {
          color: #cda074 !important;
        }
        .urlbarView-tags {
          color: #979797 !important;
        }

        .tabbrowser-tab .tab-content {
          color: #ffffce !important;
        }
        .tabbrowser-tab[selected] .tab-content {
          color: #fecf75 !important;
        }
        .tabbrowser-tab[selected] .tab-background {
          background-color: #111111 !important;
        }
        .tabbrowser-tab:hover .tab-content {
          background-color: #0a0a0a !important;
        }

        #alltabs-button,
        .tab-close-button {
          fill: #ffffce !important;
        }

        menupopup,
        panel,
        #PopupAutoComplete,
        #BMB_bookmarksPopup,
        #bookmarksMenuPopup,
        #toolbar-context-menu,
        #tabContextMenu,
        #contentAreaContextMenu,
        .panel-arrowcontent {
          background-color: #000000 !important;
          color: #ffffce !important;
          border: 1px solid #222222 !important;
        }

        menuitem,
        menu {
          color: #ffffce !important;
        }
        menuitem:hover,
        menu:hover,
        richlistitem[selected],
        .autocomplete-richlistitem[selected] {
          background-color: #111111 !important;
          color: #cda074 !important;
        }

        menuseparator {
          border-color: #222222 !important;
        }

        scrollbar {
          background-color: #000000 !important;
        }
        scrollbar thumb {
          background-color: #333333 !important;
          border-color: #000000 !important;
        }
        scrollbar thumb:hover {
          background-color: #555555 !important;
        }
        scrollbar track {
          background-color: #000000 !important;
        }

        #downloadsPanel,
        #downloadsListBox,
        .downloadDisplayName,
        .downloadProgress,
        .downloadDetails {
          background-color: #000000 !important;
          color: #ffffce !important;
        }

        #sidebar-search-container,
        #search-box,
        .search-box {
          background-color: #0a0a0a !important;
          color: #ffffce !important;
        }

        .bookmark-item {
          color: #ffffce !important;
        }
        .bookmark-item:hover {
          background-color: #111111 !important;
        }

        #statusbar,
        #statusBar {
          background-color: #000000 !important;
          color: #979797 !important;
        }

        #main-menubar > menu {
          color: #ffffce !important;
        }
        #main-menubar > menu:hover {
          background-color: #111111 !important;
        }

        .identity-box.security-connection .identity-icon {
          fill: #9e744d !important;
        }
        .identity-box.security-domain {
          color: #ffffce !important;
        }

        #page-action-buttons > toolbarbutton {
          fill: #ffffce !important;
          color: #ffffce !important;
        }

        .toolbarbutton-badge {
          background-color: #cda074 !important;
          color: #000000 !important;
        }

        #tracking-protection-icon-container {
          fill: #cda074 !important;
        }
        #tracking-protection-icon-container[hasException] {
          fill: #fecf75 !important;
        }

        #PanelUI-button,
        #PanelUI-menu-button {
          fill: #ffffce !important;
        }

        .subviewbutton {
          color: #ffffce !important;
        }
        .subviewbutton:hover {
          background-color: #111111 !important;
        }
        .subviewbutton[checked] {
          background-color: #1a1a1a !important;
        }
        toolbarseparator {
          border-color: #222222 !important;
        }
      '';

      # ── Dark content pages (userContent.css) ──
      userContent = ''
        @-moz-document url-prefix("about:"), url-prefix("chrome://") {
          :root {
            background-color: #000000 !important;
            color: #ffffce !important;
            scrollbar-color: #333333 #000000 !important;
          }
          body, html, * {
            background-color: #000000 !important;
            color: #ffffce !important;
          }
          a:link {
            color: #cda074 !important;
          }
          a:visited {
            color: #979797 !important;
          }
          a:hover {
            color: #fecf75 !important;
          }
          button, input, select, textarea {
            background-color: #0a0a0a !important;
            color: #ffffce !important;
            border-color: #222222 !important;
          }
          @media (prefers-color-scheme: light) {
            :root {
              background-color: #000000 !important;
              color: #ffffce !important;
            }
          }
        }
        @-moz-document url(about:blank), url(about:newtab), url(about:home) {
          body, .outer-wrapper, .search-wrapper, .search-handoff,
          .search-inner-wrapper, .logo, .content, .top-site-inner,
          .top-site-outer, .top-site-icon, .context-menu, .card,
          .section-title, .section-list, .collapsible-section {
            background-color: #000000 !important;
            color: #ffffce !important;
          }
          .search-handoff .fake-text {
            color: #666 !important;
          }
        }
        @-moz-document url(about:config) {
          #config-root, #about-config-container, table, tr, td, th,
          .button, input, .config-background {
            background-color: #000000 !important;
            color: #ffffce !important;
            border-color: #222222 !important;
          }
          tr:hover td {
            background-color: #111111 !important;
          }
          .config-field {
            background-color: #0a0a0a !important;
          }
        }
        @-moz-document url(about:addons) {
          .main-search, .category, .addon, .card, .category-name,
          .category-description, .addon-name, .addon-description {
            background-color: #000000 !important;
            color: #ffffce !important;
          }
          .category[selected] {
            background-color: #111111 !important;
          }
        }
        @-moz-document url(about:preferences) {
          .main-content, .subcategory, .groupbox, .checkbox-label,
          .radio-label, .description, .label, .indent, .menulist,
          .textbox, .numberbox, .search-box {
            background-color: #000000 !important;
            color: #ffffce !important;
          }
          .groupbox {
            border-color: #222222 !important;
          }
        }
      '';

      # ── Containers for maximum isolation ──
      containers = {
        "Personal" = {
          id = 1;
          color = "blue";
          icon = "fingerprint";
        };
        "Banking" = {
          id = 2;
          color = "green";
          icon = "dollar";
        };
        "Shopping" = {
          id = 3;
          color = "orange";
          icon = "cart";
        };
        "Work" = {
          id = 4;
          color = "purple";
          icon = "briefcase";
        };
        "Social" = {
          id = 5;
          color = "red";
          icon = "fence";
        };
        "Temp" = {
          id = 6;
          color = "yellow";
          icon = "circle";
        };
      };
      containersForce = true;

      # ── Privacy-respecting search engines ──
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
        engines = {
          "NixOS Packages" = {
            urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
            icon = "https://nixos.org/favicon.ico";
            definedAliases = [ "@np" "@nixpkg" ];
          };
          "NixOS Options" = {
            urls = [{ template = "https://search.nixos.org/options?query={searchTerms}"; }];
            icon = "https://nixos.org/favicon.ico";
            definedAliases = [ "@no" "@nixopt" ];
          };
          "Wikipedia" = {
            urls = [{ template = "https://en.wikipedia.org/wiki/{searchTerms}"; }];
            icon = "https://en.wikipedia.org/favicon.ico";
            definedAliases = [ "@wp" "@wiki" ];
          };
          "Brave" = {
            urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
            icon = "https://search.brave.com/favicon.ico";
            definedAliases = [ "@b" "@brave" ];
          };
        };
      };
    };
  };
}
