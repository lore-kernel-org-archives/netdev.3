Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463224D8DA2;
	Fri, 25 Sep 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360820; cv=none; b=Zk4P2d+rM53QQoj+WFYkjDEz+/9wEjUvmkHnl7yotm6wvOyQMfUDHHZNKHd/WciCi3XQ9u8qwgDefCkcQkUGqJfV8HbHK2aYVlC+Nv1s9XNNr8JcWfsvIAanB9nPo2e2bOuq862hTUFyylvIazmfEdL2swRsOcPt4EMKaRCA94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360820; c=relaxed/simple;
	bh=TGq7c5PvMmD6bs+uivBx9Y3O1JbFHrnD2Ll/bWXYfx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KS7+3/q4UQD2HPXtJbdPjtGVbd8hheVlI+DbbDOpBQRt/UGCV2wsFwWxGUEWbfClHrfWQPN/qmUwhxtizyQr+VWaYYsiEnZbaLhC8/KzJ7Qnp+G4+bcbN/ncOA8IHBkimpR8Unc0Gvlbe75akAUaMAIcTdIVKsJGBGY+4ktRS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dH6PgpOb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dH6PgpOb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 840AA1A1024;
	Fri, 25 Sep 2026 18:26:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5439E6073B;
	Fri, 25 Sep 2026 18:26:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52730102F1E2F;
	Fri, 25 Sep 2026 20:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790360810; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dh7BXUdPfSVVLzWI7eUFSXQcnuma86Xt8BqXIuKgdj0=;
	b=dH6PgpOb8nXp//yVVSeL+hJfr97Qv147FteAStzbgmEHepW1x8hdqa7hKbeXjgCxMjvSV3
	vHJEN2QX+oSwj9OFXcXwqbgMARkNfAOgadfoGmlxD7p+rJ2zRLrFhkj/C3xtsJEPNwp5X1
	hb4CTAkDNS8Rr06zw1oEpHVOUGEHbJ+AZ3yeP7Rp+9PDdUcQbHg9RWJp8mETRPaDbYAA/N
	gENFolpDTo1lmYnnZZ0HVH11ZuZxAe6aXGu9xOaLloaP5FSZUY4bAVUcmXYfhZL8zFlwWv
	mBNK6jg85CiIcPnH6tfqi5FIkQNg0JnUm/R5tYFWiZ5IM5oi7bhdPtRD+YCz9w==
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
Subject: [PATCH net-next v2 2/3] selftests: drv-net: pause: Validate the pause autonegotiation with a partner
Date: Fri, 25 Sep 2026 20:26:26 +0200
Message-ID: <20260925182628.214667-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925182628.214667-1-maxime.chevallier@bootlin.com>
References: <20260925182628.214667-1-maxime.chevallier@bootlin.com>
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
 .../testing/selftests/drivers/net/hw/pause.py | 350 ++++++++++++++++++
 1 file changed, 350 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index f07db3271500..96ee730074f8 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -124,6 +124,62 @@ def wait_for_link(cfg):
     # the remote to report link up, let's wait a bit less
     return wait_for_link_remote(cfg, timeout = 3)
 
+def controllable_lp(cfg):
+    """ Whether the remote interface is the link partner of the local one.
+
+    For low level ethtool tests, we need to have the remote directly connected
+    to the local host (i.e. not through a switch).
+
+    This is tested by taking the local link down and checking that the
+    remote's link drops.
+
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
+def require_controllable_lp(cfg):
+    """ Skip if the remote isn't directly controllable, e.g. accessed through
+        a switch
+    """
+    if not controllable_lp(cfg):
+        raise KsftSkipEx(f"{cfg.remote_ifname} is not directly connected to {cfg.ifname}")
+
 def forced_link_settings(cfg):
     """ Returns a string to pass to ethtool -s with speed/duplex corresponding
         to the current settings.
@@ -148,6 +204,10 @@ def _ethtool_pause_use_to_linkmodes(use):
     else:
         return []
 
+def pause_to_linkmodes(rx, tx):
+    """ Convert the bool rx/tx pause into Pause/Asym """
+    return pauseparams_to_linkmodes[rx][tx]["linkmodes"]
+
 def set_local_pauseparams(cfg, rx, tx, aneg):
     """ set pauseparams : ethtool -A
 
@@ -170,6 +230,33 @@ def get_local_pauseparams(cfg):
     """
     return ethtool_ret(f"-a {cfg.ifname}", is_get=True)
 
+def set_peer_pauseparams(cfg, rx, tx, aneg):
+    """ set pauseparams : ethtool -A
+
+    Raise an error if the return is not 0 or EOPNOTSUPP
+    """
+    rx_param = onoff(rx)
+    tx_param = onoff(tx)
+    aneg_param = onoff(aneg)
+
+    ret, _ = ethtool_ret(f"-A {cfg.remote_ifname} rx {rx_param} tx {tx_param}"
+                         f" autoneg {aneg_param}",
+                         is_get = False, host=cfg.remote)
+
+    if ret != 0:
+        raise KsftSkipEx(f"Can't set pauseparams on peer: {errno.errorcode.get(ret, ret)}")
+
+    return ret
+
+def get_peer_pauseparams(cfg):
+    """ get pauseparams : ethtool -a
+
+    Raise an error if the return is not 0 or EOPNOTSUPP
+    """
+
+    return ethtool_ret(f"-a {cfg.remote_ifname}", is_get=True,
+                       host=cfg.remote)
+
 def get_local_pause_supported(cfg):
     """ Return the errcode and the local pause supported linkmodes """
 
@@ -188,6 +275,55 @@ def get_local_pause_advertising(cfg):
 
     return ret, _ethtool_pause_use_to_linkmodes(data["advertised-pause-frame-use"])
 
+def get_local_pause_lp_advertising(cfg):
+    """ Return the errcode and the local pause lp_advertised linkmodes,
+        if any.
+    """
+
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
+def get_peer_pause_supported(cfg):
+    """ Return the errcode and the remote pause supported linkmodes """
+
+    ret, data = ethtool_ret(f"{cfg.remote_ifname}", host = cfg.remote)
+    if ret != 0:
+        raise KsftFailEx(f"ethtool {cfg.remote_ifname} failed: {errno.errorcode.get(ret, ret)}")
+
+    return ret, _ethtool_pause_use_to_linkmodes(data["supported-pause-frame-use"])
+
+
+def get_peer_pause_advertising(cfg):
+    """ Return the errcode and the remote pause advertised linkmodes """
+
+    ret, data = ethtool_ret(f"{cfg.remote_ifname}", host = cfg.remote)
+    if ret != 0:
+        raise KsftFailEx(f"ethtool {cfg.remote_ifname} failed: {errno.errorcode.get(ret, ret)}")
+
+    return ret, _ethtool_pause_use_to_linkmodes(data["advertised-pause-frame-use"])
+
+def get_peer_pause_lp_advertising(cfg):
+    """ Return the errcode and the local pause lp_advertised linkmodes,
+        if any.
+    """
+
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
 def require_pause_supported_allof(cfg, linkmodes):
     """ Skip if local device doesn't support all of the passed modes """
 
@@ -200,6 +336,32 @@ def require_pause_supported_allof(cfg, linkmodes):
         if lm not in pause_support:
             raise KsftSkipEx(f"Local device doesn't support {lm}")
 
+def require_peer_pause_supported_anyof(cfg, linkmodes):
+    """ Skip if remote device doesn't support any of the passed modes """
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
+def require_peer_pause_supported_allof(cfg, linkmodes):
+    """ Skip if local device doesn't support all of the passed modes """
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
 def expect_pauseparams_set(ret, linkmodes, supported, note):
     """ Whether ethtool -A had to work or to be refused, given what the local
         device supports
@@ -371,6 +533,7 @@ def pause_advertising_test(cfg, pauseparams):
 
     require_pause_supported_allof(cfg, pauseparams["linkmodes"])
     pause_setup(cfg)
+    lp = controllable_lp(cfg)
 
     tx = pauseparams["tx"]
     rx = pauseparams["rx"]
@@ -398,11 +561,198 @@ def pause_advertising_test(cfg, pauseparams):
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
+def pause_aneg_resolution(cfg, settings):
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
+
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
+
 def main():
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.ethnl = EthtoolFamily()
         ksft_run([pause_test_support,
                   pause_advertising_test,
+                  pause_aneg_resolution,
                   ],
                  args=(cfg, ))
     ksft_exit()
-- 
2.55.0

