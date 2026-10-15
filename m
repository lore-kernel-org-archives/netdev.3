Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FFB529417
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071864; cv=none; b=aJ0hZQGpHtAppZbeAHog31m8f3/d+Vne0B87037hKQH57a6jiaCiq8PlDAsPdZRZPL7kajZ8kw5+PTQrwdxsTJoEaUWmbISQA22/BfvQcvo2QgC6ZcW5Cr1p9CD2wjBUZZM78qYeueyeg71+8/JmT5Zmjmc+Cfm7buMWpQpGmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071864; c=relaxed/simple;
	bh=bzw3dkacUpcq/S8/smg8fmTLYEjlS7kLYegO+m1UDXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEI3wO6G1bfBoZSpn03rUx6CtdswI4lH5jOYnCe56cnplJl2uwjKghYygCUYwtpgRQc8+t+br4dXvJR1TlyTr6aLHarSLqtr9mqq2Cip4nBSTwk6eKGZlKJAvEjoWcMGCCWGOQcC5J/qyKOfrk6o5KTEMr/D28eA9FFczZurAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ctEgaWZu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ctEgaWZu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A5D8FC62203;
	Thu, 15 Oct 2026 13:45:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46A8E60360;
	Thu, 15 Oct 2026 13:44:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E86AD10328B3C;
	Thu, 15 Oct 2026 15:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792071855; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gbC5ys6dHrO7dKnBewstMtquBAk67vloVc7HQiiLEWM=;
	b=ctEgaWZuy8ohXqBsAG86GmHa4cxj9w4iQB/6kvlD/fWa60VITP4Dc/qIEWRbT4pm7zocx0
	SKdqcpFSQLUR4vyG+GJc847LcO8HcSeXdgHerjYNrd2yB9ys5sfiPNeUpbR+aTAbuvPhwi
	3isuwQAiFgnl2g4yV6+1FxGkTCaYIw7KPw1mIc82HrG4DOyw8ikkNOBzSWmn33glyRVMmm
	ctS/siAbsT0jbrNOXqFJAHZoVp715+OqmdBZ74IK0B5/+3HlUTjh2NoZSBG4DMjXXWrD/r
	jt+oRSrc6gyAgbJauWId9Dcfd1r2rwN/pRF6yWZdi/rF6s1LXG43WLOm6azEMQ==
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
Subject: [PATCH net-next v3 2/3] selftests: drv-net: pause: Validate the pause autonegotiation with a partner
Date: Thu, 15 Oct 2026 15:43:47 +0200
Message-ID: <20261015134350.629593-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015134350.629593-1-maxime.chevallier@bootlin.com>
References: <20261015134350.629593-1-maxime.chevallier@bootlin.com>
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
 .../testing/selftests/drivers/net/hw/pause.py | 308 ++++++++++++++++++
 1 file changed, 308 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index 854428e19f55..cd117296be33 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -84,6 +84,41 @@ def wait_for_aneg(cfg, link_drop=False, timeout=15):
 
     wait_for_link(cfg, timeout)
 
+def controllable_lp(cfg):
+    """ Whether the remote interface is the link partner of the local one.
+
+    For low level ethtool tests, we need to have the remote directly connected
+    to the local host (i.e. not through a switch).
+
+    This is tested by taking triggering a link renegotiation and checking the
+    carrier_changes counter on the partner.
+
+    :returns: True if the remote is our link partner
+    """
+    controllable = getattr(cfg, "lp_controllable", None)
+    if controllable is not None:
+        return controllable
+
+    before = int(cmd(f"cat /sys/class/net/{cfg.remote_ifname}/carrier_changes",
+                     host=cfg.remote).stdout)
+
+    ret, _ = ethtool_ret(f"-r {cfg.ifname}", is_get=False)
+    if ret != 0:
+        raise KsftSkipEx(f"ethtool -r {cfg.ifname} failed: {errno.errorcode.get(ret, ret)}")
+
+    wait_for_aneg(cfg, link_drop=True)
+
+    cfg.lp_controllable = int(cmd(f"cat /sys/class/net/{cfg.remote_ifname}/carrier_changes",
+                                  host=cfg.remote).stdout) > before
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
@@ -108,6 +143,10 @@ def _ethtool_pause_use_to_linkmodes(use):
     else:
         return []
 
+def pause_to_linkmodes(rx, tx):
+    """ Convert the bool rx/tx pause into Pause/Asym """
+    return pauseparams_to_linkmodes[rx][tx]["linkmodes"]
+
 def set_local_pauseparams(cfg, rx, tx, aneg):
     """ set pauseparams : ethtool -A """
     rx_param = onoff(rx)
@@ -127,6 +166,27 @@ def get_local_pauseparams(cfg):
     """ get pauseparams : ethtool -a """
     return ethtool_ret(f"-a {cfg.ifname}", is_get=True)
 
+def set_peer_pauseparams(cfg, rx, tx, aneg):
+    """ set pauseparams on peer : ethtool -A """
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
+    """ get pauseparams on peer : ethtool -a """
+
+    return ethtool_ret(f"-a {cfg.remote_ifname}", is_get=True,
+                       host=cfg.remote)
+
 def get_local_pause_supported(cfg):
     """ Return the errcode and the local pause supported linkmodes """
 
@@ -151,6 +211,61 @@ def get_local_pause_advertising(cfg):
 
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
+    if "supported-pause-frame-use" not in data:
+        raise KsftSkipEx(f"{cfg.remote_ifname} doesn't report its link modes")
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
+    if "advertised-pause-frame-use" not in data:
+        raise KsftSkipEx(f"{cfg.remote_ifname} doesn't report its link modes")
+
+    return ret, _ethtool_pause_use_to_linkmodes(data["advertised-pause-frame-use"])
+
+def get_peer_pause_lp_advertising(cfg):
+    """ Return the errcode and the peer pause lp_advertised linkmodes,
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
 
@@ -163,6 +278,18 @@ def require_pause_supported_allof(cfg, linkmodes):
         if lm not in pause_support:
             raise KsftSkipEx(f"Local device doesn't support {lm}")
 
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
 def expect_pauseparams_set(cfg, pauseparams, aneg, supported, note):
     """ ethtool -A must work or be refused depending on what the local
         device supports
@@ -330,6 +457,7 @@ def pause_advertising_test(cfg, pauseparams):
 
     require_pause_supported_allof(cfg, pauseparams["linkmodes"])
     pause_setup(cfg)
+    lp = controllable_lp(cfg)
 
     tx = pauseparams["tx"]
     rx = pauseparams["rx"]
@@ -356,11 +484,191 @@ def pause_advertising_test(cfg, pauseparams):
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
+    pause_setup(cfg)
+    require_controllable_lp(cfg)
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
+    wait_for_aneg(cfg)
+
+    set_peer_pauseparams(cfg, settings["lp_rx"], settings["lp_tx"], True)
+
+    # Wait for link to re-negotiate
+    wait_for_aneg(cfg)
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
+    ksft_eq(linkmodes, required_local_linkmodes,
+            f"local rx {settings['rx']} tx {settings['tx']} must advertise "
+            f"{required_local_linkmodes}")
+
+    _, linkmodes = get_peer_pause_advertising(cfg)
+    ksft_eq(linkmodes, required_remote_linkmodes,
+            f"remote rx {settings['lp_rx']} tx {settings['lp_tx']} must advertise "
+            f"{required_remote_linkmodes}")
+
+    # check lp_adv if available
+    _, linkmodes = get_local_pause_lp_advertising(cfg)
+    ksft_eq(linkmodes, required_remote_linkmodes,
+            f"local lp_adv must show the remote's {required_remote_linkmodes}")
+
+    # check lp_adv on remote
+    ret, linkmodes = get_peer_pause_lp_advertising(cfg)
+    if ret == 0:
+        ksft_eq(linkmodes, required_local_linkmodes,
+                f"remote lp_adv must show our {required_local_linkmodes}")
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
     """ Entry point """
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         ksft_run([pause_test_support,
                   pause_advertising_test,
+                  pause_aneg_resolution,
                   ],
                  args=(cfg, ))
     ksft_exit()
-- 
2.55.0

