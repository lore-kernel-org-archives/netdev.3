Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72138470115;
	Sun, 20 Sep 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789922879; cv=none; b=q1ptCyKoNKRo2lUbstyjmQOQOBBja9r49tdjVIcZk3mJxEPQ9mHM7Zrcu4VhfFUYyD6rvWN1e7PgJtI4ffRQXRlhr2BtCbAKkMJUtyofpv2PR6Uc+Hn+YyJYfqgCrx9gYNab9Tz9eNl7wLmgK456A8+gDP0YNszHflSHtN3XcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789922879; c=relaxed/simple;
	bh=7CAMaNNal2labRdl0vE066aF1rMOIE01uCfEmYPftSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX3dIvxyXn5K5zP8lgG/azxgGodlH4/T9tsU9rvshWtxl70CzP3TZA7m2ojxlHwTRzra8sSGa003Jg+y00Jz8coQBn3Zq/1B5j4dcnk6gBRPwOHCQK33gafiZH1QVLfBo5YdZYyLqLNaznWD2jmbstPSJQR1VrMY7v4K0IL6qRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tIPyofj7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tIPyofj7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 56465C5CD5C;
	Sun, 20 Sep 2026 16:48:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FD366033F;
	Sun, 20 Sep 2026 16:47:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30A7D103290A7;
	Sun, 20 Sep 2026 18:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789922868; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=oNW4Miw3pDWhqdr2xavtmbzEWYItmw7DKF88Z5NqGVQ=;
	b=tIPyofj7I6s7VLp+ZNNxj7hQ5IHaVG6kIkfhABJuIG3+AvDCSO+X6ALG8tShYkWVeq0CWI
	LznjwAeZKFwMU59d6+ws2taCsXh1qcJR3pYVBJocRAY7RGtgypHzJUqkCtfyCX0eGroBrJ
	dKDJg0fo0WEDaZsPRTIDsuHgivNOUjP3PDPJ9IYheSzFIkqW3rWt98aW4pDyYdELStPG8h
	N8cxTqJY+HU2OlzwSQNPhyJLV2EY8qHJ/qHLt8XN7WV2mroBTpIlFd9fpsDl3thsrXxYPf
	bB7OgkTzWiBjVq5UFIcTzMrNGNB/41LKZf15BQjn1wl2UA59Utkb1CBRlQZBxg==
From: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 2/3] selftests: drv-net: pause: tests against a controllable link partner
Date: Sun, 20 Sep 2026 18:47:28 +0200
Message-ID: <20260920164732.349744-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Pause autonegotiation behaves differently than the regular link params
autonegotiation, in that the user intention may differ from the
negotiated pause parameters.

Introduce a test that validates we're correctly resolving pause
parameters according to 802.3.

The validation is done based on what the local interface reports in
terms of advertised and lp_advertised linkmodes.

If the remote can express what it sees in terms of its own advertised
and lp_advertised modes, validate the autoneg results on the peer as
well.

Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |   3 +-
 .../testing/selftests/drivers/net/hw/pause.py | 336 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   3 +-
 .../selftests/drivers/net/lib/py/ethtool.py   |  60 +++-
 4 files changed, 399 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index c79dacf3bfdf..b23f53bcd3b0 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -34,6 +34,7 @@ try:
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from drivers.net.lib.py import ethtool_ret, onoff, wait_for_link, wait_for_aneg, \
+        controllable_lp, require_controllable_lp, \
         forced_link_settings
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
@@ -52,7 +53,7 @@ try:
                "ksft_not_none", "ksft_not_none",
                "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
                "Remote", "Iperf3Runner",
-               "ethtool_ret", "onoff", "wait_for_link", "wait_for_aneg",
+               "ethtool_ret", "onoff", "wait_for_link", "wait_for_aneg", "controllable_lp", "require_controllable_lp",
                "require_link_autoneg", "forced_link_settings"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index 35cf47f4a742..e291c7d8583e 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -14,6 +14,7 @@ from lib.py import (
     KsftSkipEx,
     NetDrvEpEnv,
     cmd,
+    controllable_lp,
     defer,
     ethtool,
     ethtool_ret,
@@ -28,6 +29,7 @@ from lib.py import (
     ksft_run,
     ksft_variants,
     onoff,
+    require_controllable_lp,
     wait_for_aneg,
     wait_for_link,
 )
@@ -57,6 +59,11 @@ def _ethtool_pause_use_to_linkmodes(use) -> list[str]:
     else:
         return []
 
+def pause_to_linkmodes(rx, tx) -> list[str]:
+    """ Convert rx/tx pauseparams to the corresponding linkmodes
+    """
+    return pauseparams_to_linkmodes[rx][tx]["linkmodes"]
+
 def set_local_pauseparams(cfg, rx, tx, aneg) -> int:
     """ set pauseparams : ethtool -A
 
@@ -92,6 +99,45 @@ def get_local_pauseparams(cfg) -> tuple[int, bool, bool, bool]:
     """
     return ethtool_ret(f"-a {cfg.ifname}", is_get=True)
 
+def set_peer_pauseparams(cfg, rx, tx, aneg) -> int:
+    """ set pauseparams : ethtool -A
+
+    Raise an error if the return is not 0 or EOPNOTSUPP
+
+    :param cfg: test config
+    :param rx: rx pause enabled or disabled
+    :param tx: tx pause enabled or disabled
+    :param aneg: pause autoneg enabled or disabled
+    :returns: return code of the ethtool command
+    """
+    rx_param = onoff(rx)
+    tx_param = onoff(tx)
+    aneg_param = onoff(aneg)
+
+    ret, _ = ethtool_ret(
+                         f"-A {cfg.remote_ifname} rx {rx_param} tx {tx_param} autoneg {aneg_param}",
+                         is_get = False, host=cfg.remote)
+
+    if ret != 0:
+        raise KsftSkipEx(f"Can't set pauseparams on peer: {errno.errorcode.get(ret, ret)}")
+
+    return ret
+
+def get_peer_pauseparams(cfg) -> tuple[int, bool, bool, bool]:
+    """ get pauseparams : ethtool -a
+
+    Raise an error if the return is not 0 or EOPNOTSUPP
+
+    :param cfg: test config
+    :returns: tuple containing :
+              - return code of the ethtool command,
+              - rx status,
+              - tx status,
+              - aneg status
+    """
+    return ethtool_ret(f"-a {cfg.remote_ifname}", is_get=True,
+                       host=cfg.remote)
+
 def get_local_pause_supported(cfg) -> tuple[int, list[str]]:
     """ get the supported linkmodes on the local device
 
@@ -120,6 +166,82 @@ def get_local_pause_advertising(cfg) -> tuple[int, list[str]]:
 
     return ret, _ethtool_pause_use_to_linkmodes(data["advertised-pause-frame-use"])
 
+def get_local_pause_lp_advertising(cfg) -> tuple[int, list[str]]:
+    """ get the lp_advertised linkmodes on the local device
+
+    Raise an error if the return is not 0 or EOPNOTSUPP
+    Prints a warning if the local device doesn't report lp_advertising
+
+    :param cfg: test config
+    :returns: tuple containing :
+              - return code of the ethtool command
+              - list of linkmodes
+    """
+    ret, data = ethtool_ret(f"{cfg.ifname}")
+    if ret != 0:
+        raise KsftFailEx(f"ethtool {cfg.ifname} failed: {errno.errorcode.get(ret, ret)}")
+
+    if "link-partner-advertised-pause-frame-use" in data:
+        return ret, _ethtool_pause_use_to_linkmodes(data["link-partner-advertised-pause-frame-use"])
+    else:
+        ksft_pr(f"Warning: {cfg.ifname} does not report the LP's advertising")
+        return errno.EOPNOTSUPP, None
+
+def get_peer_pause_supported(cfg) -> tuple[int, list[str]]:
+    """ get the supported linkmodes on the link partner
+
+    returns ENODEV if there's no LP
+
+    :param cfg: test config
+    :returns: tuple containing :
+              - return code of the ethtool command
+              - list of linkmodes
+    """
+    ret, data = ethtool_ret(f"{cfg.remote_ifname}", host = cfg.remote)
+    if ret != 0:
+        raise KsftFailEx(f"ethtool {cfg.remote_ifname} failed: {errno.errorcode.get(ret, ret)}")
+
+    return ret, _ethtool_pause_use_to_linkmodes(data["supported-pause-frame-use"])
+
+
+def get_peer_pause_advertising(cfg) -> tuple[int, list[str]]:
+    """ get the advertised linkmodes on the link partner
+
+    returns ENODEV if there's no LP
+
+    :param cfg: test config
+    :returns: tuple containing :
+              - return code of the ethtool command
+              - list of linkmodes
+    """
+    ret, data = ethtool_ret(f"{cfg.remote_ifname}", host = cfg.remote)
+    if ret != 0:
+        raise KsftFailEx(f"ethtool {cfg.remote_ifname} failed: {errno.errorcode.get(ret, ret)}")
+
+    return ret, _ethtool_pause_use_to_linkmodes(data["advertised-pause-frame-use"])
+
+def get_peer_pause_lp_advertising(cfg) -> tuple[int, list[str]]:
+    """ get the lp_advertised linkmodes on the link partner
+
+    Raise an error if the return is not 0 or EOPNOTSUPP
+    returns ENODEV if there's no LP
+    Prints a warning if LP is present but doesn't report lp_advertising
+
+    :param cfg: test config
+    :returns: tuple containing :
+              - return code of the ethtool command
+              - list of linkmodes
+    """
+    ret, data = ethtool_ret(f"{cfg.remote_ifname}", host = cfg.remote)
+    if ret != 0:
+        raise KsftFailEx(f"ethtool {cfg.remote_ifname} failed: {errno.errorcode.get(ret, ret)}")
+
+    if "link-partner-advertised-pause-frame-use" in data:
+        return ret, _ethtool_pause_use_to_linkmodes(data["link-partner-advertised-pause-frame-use"])
+    else:
+        ksft_pr(f"Warning: {cfg.remote_ifname} does not report the LP's advertising")
+        return errno.EOPNOTSUPP, None
+
 def require_pause_supported_allof(cfg, linkmodes) -> None:
     """ Checks if the local device supports the passed linkmodes
 
@@ -135,6 +257,34 @@ def require_pause_supported_allof(cfg, linkmodes) -> None:
         if lm not in pause_support:
             raise KsftSkipEx(f"Local device doesn't support {lm}")
 
+def require_peer_pause_supported_anyof(cfg, linkmodes) -> None:
+    """ Checks if the remote device supports the passed linkmodes
+    """
+
+    ret, _ = get_peer_pauseparams(cfg)
+    if ret != 0:
+        raise KsftSkipEx("Remote device doesn't allow getting pauseparams")
+
+    _, pause_support = get_peer_pause_supported(cfg)
+    for lm in linkmodes:
+        if lm in pause_support:
+            return
+
+    raise KsftSkipEx(f"Local device doesn't support any of {linkmodes}")
+
+def require_peer_pause_supported_allof(cfg, linkmodes) -> None:
+    """ Checks if the remote device supports the passed linkmodes
+    """
+
+    ret, _ = get_peer_pauseparams(cfg)
+    if ret != 0:
+        raise KsftSkipEx("Remote device doesn't allow getting pauseparams")
+
+    _, pause_support = get_peer_pause_supported(cfg)
+    for lm in linkmodes:
+        if lm not in pause_support:
+            raise KsftSkipEx(f"Remote device doesn't support {lm}")
+
 def expect_pauseparams_set(ret, linkmodes, supported, note) -> None:
     """ Whether ethtool -A had to work or to be refused, given what the local
         device supports
@@ -311,6 +461,7 @@ def pause_advertising_test(cfg, pauseparams) -> None:
 
     require_pause_supported_allof(cfg, pauseparams["linkmodes"])
     pause_setup(cfg)
+    lp = controllable_lp(cfg)
 
     tx = pauseparams["tx"]
     rx = pauseparams["rx"]
@@ -338,6 +489,190 @@ def pause_advertising_test(cfg, pauseparams) -> None:
         ksft_not_in(mode, linkmodes,
                     f"rx {rx} tx {tx} aneg on must not advertise {not_adv}")
 
+    if not lp:
+        return
+
+    returncode, remote_linkmodes = get_peer_pause_lp_advertising(cfg)
+    if returncode == errno.EOPNOTSUPP:
+        return
+
+    for mode in adv:
+        ksft_in(mode, remote_linkmodes, f"PHY does not advertise {adv}")
+
+    for mode in not_adv:
+        ksft_not_in(mode, remote_linkmodes,
+                    f"PHY incorrectly advertises {not_adv}")
+
+
+# Pause autonegotiation resolution : Resolved pause settings vs configured
+# pauseparams on local device and link partner
+@ksft_variants([
+    # We advertise nothing, all off
+    KsftNamedVariant("local rx off tx off, remote rx off tx off",
+        {"rx": 0, "tx": 0, "lp_rx": 0, "lp_tx": 0, "neg_rx": 0, "neg_tx": 0}),
+
+    # We advertise nothing, all off
+    KsftNamedVariant("local rx off tx off, remote rx off tx on",
+        {"rx": 0, "tx": 0, "lp_rx": 0, "lp_tx": 1, "neg_rx": 0, "neg_tx": 0}),
+
+    # We advertise nothing, all off
+    KsftNamedVariant("local rx off tx off, remote rx on tx off",
+        {"rx": 0, "tx": 0, "lp_rx": 1, "lp_tx": 0, "neg_rx": 0, "neg_tx": 0}),
+
+    # We advertise nothing, all off
+    KsftNamedVariant("local rx off tx off, remote rx on tx on",
+        {"rx": 0, "tx": 0, "lp_rx": 1, "lp_tx": 1, "neg_rx": 0, "neg_tx": 0}),
+
+    # LP advertises nothing, all off
+    KsftNamedVariant("local rx off tx on, remote rx off tx off",
+        {"rx": 0, "tx": 1, "lp_rx": 0, "lp_tx": 0, "neg_rx": 0, "neg_tx": 0}),
+
+    # We advertise Asym, LP advertises Asym, all off
+    KsftNamedVariant("local rx off tx on, remote rx off tx on",
+        {"rx": 0, "tx": 1, "lp_rx": 0, "lp_tx": 1, "neg_rx": 0, "neg_tx": 0}),
+
+    # We advertise Asym, LP advertises Pause + Asym, tx on
+    KsftNamedVariant("local rx off tx on, remote rx on tx off",
+        {"rx": 0, "tx": 1, "lp_rx": 1, "lp_tx": 0, "neg_rx": 0, "neg_tx": 1}),
+
+    # Tricky case :
+    # We advertise Asym, LP advertises Pause, resolves to all off
+    KsftNamedVariant("local rx off tx on, remote rx on tx on",
+        {"rx": 0, "tx": 1, "lp_rx": 1, "lp_tx": 1, "neg_rx": 0, "neg_tx": 0}),
+
+    # LP advertises nothing, all off
+    KsftNamedVariant("local rx on tx off, remote rx off tx off",
+        {"rx": 1, "tx": 0, "lp_rx": 0, "lp_tx": 0, "neg_rx": 0, "neg_tx": 0}),
+
+    # We advertise Pause + Asym , LP advertises Asym, rx on
+    KsftNamedVariant("local rx on tx off, remote rx off tx on",
+        {"rx": 1, "tx": 0, "lp_rx": 0, "lp_tx": 1, "neg_rx": 1, "neg_tx": 0}),
+
+    # Also tricky: Only rx enabled on both ends, but we negotiate rx/tx
+    # We advertise Pause + Asym, LP advertises Pause + Asym, all on
+    KsftNamedVariant("local rx on tx off, remote rx on tx off",
+        {"rx": 1, "tx": 0, "lp_rx": 1, "lp_tx": 0, "neg_rx": 1, "neg_tx": 1}),
+
+    # We advertise Pause + Asym, LP advertises Pause, all on
+    KsftNamedVariant("local rx on tx off, remote rx on tx on",
+        {"rx": 1, "tx": 0, "lp_rx": 1, "lp_tx": 1, "neg_rx": 1, "neg_tx": 1}),
+
+    # LP advertises nothing, all off
+    KsftNamedVariant("local rx on tx on, remote rx off tx off",
+        {"rx": 1, "tx": 1, "lp_rx": 0, "lp_tx": 0, "neg_rx": 0, "neg_tx": 0}),
+
+    # Tricky case :
+    # We advertise Pause, LP advertises Asym, resolves to all off
+    KsftNamedVariant("local rx on tx on, remote rx off tx on",
+        {"rx": 1, "tx": 1, "lp_rx": 0, "lp_tx": 1, "neg_rx": 0, "neg_tx": 0}),
+
+    # We advertise Pause, LP advertises Pause + Asym, all on
+    KsftNamedVariant("local rx on tx on, remote rx on tx off",
+        {"rx": 1, "tx": 1, "lp_rx": 1, "lp_tx": 0, "neg_rx": 1, "neg_tx": 1}),
+
+    # We advertise Pause, LP advertises Pause, all on
+    KsftNamedVariant("local rx on tx on, remote rx on tx on",
+        {"rx": 1, "tx": 1, "lp_rx": 1, "lp_tx": 1, "neg_rx": 1, "neg_tx": 1}),
+])
+@ksft_disruptive
+def pause_aneg_resolution(cfg, settings) -> None:
+    """ Verify that rx and tx pause parameters are negotiated according to 802.3
+
+    802.3 dictates the rules for pause negotiation, all 16 cases are tested, one
+    for each combination of Pause and Asym_Pause advertising on the local device
+    and the link-partner.
+
+    This test also verifies that the peer resolved the parameters correctly,
+    to ensure the negotiation is triggered correctly.
+
+    Failing this test can happen if :
+     - The MAC accepts the pause parameters but doesn't trigger a link
+       renegotiation
+     - that the PHY driver manually overwrites the Pause negotiation result
+     - that the MAC driver ignores the Pause resolution and sets its own
+       pause parameters regardless
+    """
+    expected_local_rx = settings["neg_rx"]
+    expected_local_tx = settings["neg_tx"]
+
+    required_local_linkmodes = pause_to_linkmodes(settings["rx"],
+                                                  settings["tx"])
+    required_remote_linkmodes = pause_to_linkmodes(settings["lp_rx"],
+                                                   settings["lp_tx"])
+
+    require_pause_supported_allof(cfg, required_local_linkmodes)
+    require_peer_pause_supported_allof(cfg, required_remote_linkmodes)
+    require_controllable_lp(cfg)
+    pause_setup(cfg)
+
+    # There's symmetry between local device and LP on pause negotiation:
+    # - if local resolves all off or all on, LP must resolve the same
+    # - if local resolves RX only, remote must resolve to TX only
+    # - if local resolves TX only, remote must resolve to RX only
+    if expected_local_rx == expected_local_tx:
+        expected_lp_rx = expected_local_rx
+        expected_lp_tx = expected_local_tx
+    else:
+        expected_lp_rx = expected_local_tx
+        expected_lp_tx = expected_local_rx
+
+    # Set pauseparams
+    ret = set_local_pauseparams(cfg, settings["rx"], settings["tx"], True)
+    if ret == errno.EOPNOTSUPP:
+        raise KsftSkipEx(f"RX {settings['rx']} TX {settings['tx']} not supported")
+
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    set_peer_pauseparams(cfg, settings["lp_rx"], settings["lp_tx"], True)
+
+    # Wait for link to re-negotiate
+    ret = wait_for_aneg(cfg)
+
+    # Fail if it doesn't
+    ksft_eq(ret, True)
+
+    if get_local_pause_lp_advertising(cfg)[0] != 0:
+        raise KsftSkipEx("Local device doesn't report the LP's advertising")
+
+    ret, local_pauseparams = get_local_pauseparams(cfg)
+    if ret != 0 or "negotiated" not in local_pauseparams:
+        raise KsftSkipEx("Local device doesn't report the negotiated pause params")
+
+    # check adv
+    _, linkmodes = get_local_pause_advertising(cfg)
+    for mode in required_local_linkmodes:
+        ksft_in(mode, linkmodes,
+                f"local rx {settings['rx']} tx {settings['tx']} must advertise "
+                f"{required_local_linkmodes}")
+
+    _, linkmodes = get_peer_pause_advertising(cfg)
+    for mode in required_remote_linkmodes:
+        ksft_in(mode, linkmodes,
+                f"remote rx {settings['lp_rx']} tx {settings['lp_tx']} must advertise "
+                f"{required_remote_linkmodes}")
+
+    # check lp_adv if available
+    _, linkmodes = get_local_pause_lp_advertising(cfg)
+    for mode in required_remote_linkmodes:
+        ksft_in(mode, linkmodes,
+                f"local lp_adv must show the remote's {required_remote_linkmodes}")
+
+    # check lp_adv on remote
+    ret, linkmodes = get_peer_pause_lp_advertising(cfg)
+    if ret == 0:
+        for mode in required_local_linkmodes:
+            ksft_in(mode, linkmodes,
+                    f"remote lp_adv must show our {required_local_linkmodes}")
+
+    # Check resolution
+    _, local_pauseparams = get_local_pauseparams(cfg)
+    ksft_eq(local_pauseparams["negotiated"]["rx"], expected_local_rx)
+    ksft_eq(local_pauseparams["negotiated"]["tx"], expected_local_tx)
+
+    ret, remote_pauseparams = get_peer_pauseparams(cfg)
+    if ret == 0 and "negotiated" in remote_pauseparams:
+        ksft_eq(remote_pauseparams["negotiated"]["rx"], expected_lp_rx)
+        ksft_eq(remote_pauseparams["negotiated"]["tx"], expected_lp_tx)
 
 def main() -> None:
     """ The hardware pause tests, on the interface the env names """
@@ -345,6 +680,7 @@ def main() -> None:
         cfg.ethnl = EthtoolFamily()
         ksft_run([pause_test_support,
                   pause_advertising_test,
+                  pause_aneg_resolution,
                   ],
                  args=(cfg, ))
     ksft_exit()
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 6efb635c5bfa..0486405c5c70 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -51,11 +51,12 @@ try:
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
     from .ethtool import ethtool_ret, onoff, wait_for_link, wait_for_aneg, \
+        controllable_lp, require_controllable_lp, \
         forced_link_settings
 
     __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
                 "Remote", "Iperf3Runner",
-                "ethtool_ret", "onoff", "wait_for_link", "wait_for_aneg",
+                "ethtool_ret", "onoff", "wait_for_link", "wait_for_aneg", "controllable_lp", "require_controllable_lp",
                 "forced_link_settings"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
diff --git a/tools/testing/selftests/drivers/net/lib/py/ethtool.py b/tools/testing/selftests/drivers/net/lib/py/ethtool.py
index 438bf08ccab7..43e197ac12e5 100644
--- a/tools/testing/selftests/drivers/net/lib/py/ethtool.py
+++ b/tools/testing/selftests/drivers/net/lib/py/ethtool.py
@@ -9,7 +9,7 @@ import json
 import os
 import time
 
-from lib.py import cmd, ethtool
+from lib.py import KsftSkipEx, cmd, ethtool, ip, ksft_pr
 
 _strerrors = {os.strerror(e): e for e in errno.errorcode}
 
@@ -117,6 +117,64 @@ def wait_for_link(cfg) -> bool:
     # the remote to report link up, let's wait a bit less
     return wait_for_link_remote(cfg, timeout = 3)
 
+def controllable_lp(cfg) -> bool:
+    """ Whether the remote interface is the link partner of the local one.
+
+    For low level ethtool tests, we need to have the remote directly connected
+    to the local host (i.e. not through a switch).
+
+    This is tested by taking the local link down and checking that the
+    remote's link drops.
+
+    :param cfg: test config
+    :returns: True if the remote is our link partner
+    """
+    known = getattr(cfg, "lp_controllable", None)
+    if known is not None:
+        return known
+
+    # Set both ends up, wait for up
+    ip(f"link set {cfg.ifname} up")
+    ip(f"link set {cfg.remote_ifname} up", host=cfg.remote)
+
+    # No link established
+    if not wait_for_link(cfg):
+        ksft_pr(f"{cfg.remote_ifname} is not the link partner: no link with both ends up")
+        cfg.lp_controllable = False
+        return False
+
+    ip(f"link set {cfg.ifname} down")
+
+    deadline = time.monotonic() + 3
+    dropped = False
+    while time.monotonic() < deadline and not dropped:
+        dropped = not ethtool(f"{cfg.remote_ifname}", json=True,
+                              host=cfg.remote)[0]["link-detected"]
+        time.sleep(0.1)
+
+    ip(f"link set {cfg.ifname} up")
+
+    if not dropped:
+        ksft_pr(f"{cfg.remote_ifname} is not the link partner: "
+                f"it kept its link through {cfg.ifname} going down")
+        cfg.lp_controllable = False
+        wait_for_link(cfg)
+        return False
+
+    cfg.lp_controllable = wait_for_link(cfg)
+    if not cfg.lp_controllable:
+        ksft_pr(f"{cfg.remote_ifname} is not the link partner: "
+                f"no link back after {cfg.ifname} came up")
+    return cfg.lp_controllable
+
+def require_controllable_lp(cfg) -> None:
+    """ Skip if the remote isn't directly connected to the local device
+
+    :param cfg: test config
+    """
+    if not controllable_lp(cfg):
+        raise KsftSkipEx(f"{cfg.remote_ifname} is not directly connected to {cfg.ifname}")
+
 def forced_link_settings(cfg) -> str:
     """ Returns a string to pass to ethtool -s with speed/duplex corresponding
         to the current settings.
-- 
2.55.0

