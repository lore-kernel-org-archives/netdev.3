Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF53290A6
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789922879; cv=none; b=m28UYSk50MfHWKKfQKT7DHoHoPem8KJe/dn+RF0NDyvGbZc7iNWkTBJNv1rm9a7wXoyAsaouasRjqzOZ9x7nI1pFV/X5/HieoXYAG2caIP1LWKoxVyPHru9e6oO5I6QkQvTxSoAmml12I4CM/OPnLAQFrq7IiobNaEHXxSpBvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789922879; c=relaxed/simple;
	bh=dCJeVwCJtGyq4KQEHLn4KnvG5N+7aQ2twoboc80YdMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtEJp1dYf5BpEaNkYKug15ZxU9j4XoPBJQ30e5sP/vKJbXW1LbsuTjhAjDmbSX6YG6QccSaetztvIPLomxgEGNsrzTQ5CWvYVFO0zy2Rr6FXTpDD8Ez4oxym/uRELIWeNorBPw9pkd1CaWf6UkxtWnGpt8bor6VU29Ew2Xc7VBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W9NFZus1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W9NFZus1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 46A7BC51469;
	Sun, 20 Sep 2026 16:48:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F5B46033F;
	Sun, 20 Sep 2026 16:47:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64AA1103290A6;
	Sun, 20 Sep 2026 18:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789922873; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ye84wnF/Z0HFxmfZYw5UmurkxYZNKHfK7ubDzp+PuhU=;
	b=W9NFZus1gbVWxX2VuOnjMhk4IdYDo4/U+xTGUajnpeK/qEQlA9iPzvWRCeJybcpAb9jCTN
	3XytzDUEjq0R2MPowkfPSDYvhkGzolt1SF7hCcigyRTztRtA3qBMqzl50IRweNiNTKdAlZ
	bdSth6AwTJtSuJCY3Z+Gn0sfqM8yz7UN7g5DW4dCr/WoK/p6kk0QgQ59syakJJa7F5bvqB
	cIumhc9HZeugKAdq038VE0QLvR+kgT7cPFI0bz4+H/1Z+EYRqqg8nSRgCroV7nu8vTCn6G
	gm4AnITIzTNW+Nol8fg9Ua0qHv02jXWfLc8gQXs3MjDzSFDOU4dv9dWIjxrGqg==
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
Subject: [PATCH net-next 3/3] selftests: drv-net: pause: pause autoneg tests
Date: Sun, 20 Sep 2026 18:47:30 +0200
Message-ID: <20260920164732.349744-5-maxime.chevallier@bootlin.com>
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

Pause autonegotiation happens with the link partner using the same words
as the link negotiation, used for speed and duplex exchanges. However,
pause and link autonegotiation can be separately toggled :

ethtool -s eth0 autoneg on # Enable link negotiation
ethtool -A eth0 autoneg on # Enable Pause negotiation

Pause can't be negotiated if the link autoneg isn't enabled.

Pause autoneg and link autoneg settings must not interfere with one
another when user is configuring them :
 - If Pause autoneg is on, it must stay on when link autoneg is disabled
   (even though Pause won't actually be negotiated)
 - If Pause autoneg is off, it must stay off when link autoneg is
   enabled

Introduce a set of tests to verify that pause and link autoneg are
behaving correctly, in particular that the user intent is correctly
cached when toggling link autoneg.

Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |   2 +-
 .../testing/selftests/drivers/net/hw/pause.py | 284 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/ethtool.py   |  14 +
 4 files changed, 301 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index b23f53bcd3b0..958af4beef38 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -34,7 +34,7 @@ try:
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from drivers.net.lib.py import ethtool_ret, onoff, wait_for_link, wait_for_aneg, \
-        controllable_lp, require_controllable_lp, \
+        controllable_lp, require_controllable_lp, require_link_autoneg, \
         forced_link_settings
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index e291c7d8583e..2358d41a7412 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -30,6 +30,7 @@ from lib.py import (
     ksft_variants,
     onoff,
     require_controllable_lp,
+    require_link_autoneg,
     wait_for_aneg,
     wait_for_link,
 )
@@ -242,6 +243,23 @@ def get_peer_pause_lp_advertising(cfg) -> tuple[int, list[str]]:
         ksft_pr(f"Warning: {cfg.remote_ifname} does not report the LP's advertising")
         return errno.EOPNOTSUPP, None
 
+def require_pause_supported_anyof(cfg, linkmodes) -> None:
+    """ Checks if the local device supports pause at all, by looking at the
+        supported bitfield. Raises a skip it's not supported.
+
+        :param cfg: test config
+    """
+    ret, _ = get_local_pauseparams(cfg)
+    if ret != 0:
+        raise KsftSkipEx("device doesn't allow getting pauseparams")
+
+    _, pause_support = get_local_pause_supported(cfg)
+    for lm in linkmodes:
+        if lm in pause_support:
+            return
+
+    raise KsftSkipEx(f"Local device doesn't support any of {linkmodes}")
+
 def require_pause_supported_allof(cfg, linkmodes) -> None:
     """ Checks if the local device supports the passed linkmodes
 
@@ -285,6 +303,51 @@ def require_peer_pause_supported_allof(cfg, linkmodes) -> None:
         if lm not in pause_support:
             raise KsftSkipEx(f"Remote device doesn't support {lm}")
 
+def supported_pauseparams(cfg) -> tuple[int, int]:
+    """ The rx/tx params covering every mode the local device supports """
+    _, pause_support = get_local_pause_supported(cfg)
+    if "Pause" in pause_support:
+        return 1, 1
+    if "Asym_Pause" in pause_support:
+        return 0, 1
+
+    raise KsftSkipEx("Local device doesn't support pause")
+
+def set_local_pause_autoneg(cfg, aneg) -> int:
+    """ Enable or disable pause autoneg """
+    ret, _ = ethtool_ret(f"-A {cfg.ifname} autoneg {onoff(aneg)}",
+                         is_get=False)
+    return ret
+
+def check_local_pauseparams(cfg, aneg, rx, tx) -> None:
+    """ Validates that the pauseparams reported from ethtool -a are
+        exactly the 3 passed parameters.
+    """
+    ret, params = get_local_pauseparams(cfg)
+    ksft_eq(ret, 0)
+    if ret != 0:
+        return
+
+    ksft_eq(params["autonegotiate"], bool(aneg), "pause autoneg")
+    ksft_eq(params["rx"], bool(rx), "rx pause")
+    ksft_eq(params["tx"], bool(tx), "tx pause")
+
+def check_local_advertising(cfg, linkmodes) -> None:
+    """ Verify that the local device advertises exactly the pause modes
+        passed as parameters
+    """
+    _, adv = get_local_pause_advertising(cfg)
+    ksft_eq(adv, linkmodes, "advertised pause modes")
+
+def check_local_lp_advertising(cfg, linkmodes) -> None:
+    """ Verify that the local device reports exactly the lp_advertised pause
+        modes passed as parameters
+    """
+
+    ret, adv = get_local_pause_lp_advertising(cfg)
+    if ret == 0:
+        ksft_eq(adv, linkmodes, "link partner advertised pause modes")
+
 def expect_pauseparams_set(ret, linkmodes, supported, note) -> None:
     """ Whether ethtool -A had to work or to be refused, given what the local
         device supports
@@ -674,6 +737,223 @@ def pause_aneg_resolution(cfg, settings) -> None:
         ksft_eq(remote_pauseparams["negotiated"]["rx"], expected_lp_rx)
         ksft_eq(remote_pauseparams["negotiated"]["tx"], expected_lp_tx)
 
+# Pause autoneg enable/disable vs advertised linkmodes
+@ksft_disruptive
+def pause_autoneg_state_adv(cfg) -> None:
+    """Validate that toggling pause advertising changes the advertised linkmodes
+
+    When disabling pause autoneg, we enforce the pause params based on what user
+    asks, instead of relying on the negociation process (which may not be what
+    the user asked for). In forced pause settings, we don't advertise pause and
+    asym_pause bits.
+
+    Failing this test means that .set_pauseparam in the MAC driver doesn't
+    forward to the PHY (in charge of advertising these bits) that we are in
+    fixed pause mode.
+    """
+
+    require_pause_supported_anyof(cfg, ["Pause", "Asym_Pause"])
+    require_controllable_lp(cfg)
+    pause_setup(cfg)
+
+    set_peer_pauseparams(cfg, True, True, True)
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    rx, tx = supported_pauseparams(cfg)
+
+    # Enable all possible pauseparams with pause autoneg
+    ret = set_local_pauseparams(cfg, rx, tx, True)
+    ksft_eq(ret, 0)
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    # Make sure we advertise them
+    ret, adv = get_local_pause_advertising(cfg)
+    ksft_eq(ret, 0)
+    ksft_eq(adv, pause_to_linkmodes(rx, tx))
+
+    # Disable pause autoneg
+    ret = set_local_pauseparams(cfg, rx, tx, False)
+    ksft_eq(ret, 0)
+
+    # This may trigger a link renegociation
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    # We shouldn't be advertising anything anymore
+    ret, adv = get_local_pause_advertising(cfg)
+    ksft_eq(ret, 0)
+    ksft_eq(adv, [])
+
+    # Validate on the LP that we aren't advertising anything
+    ret, adv = get_peer_pause_lp_advertising(cfg)
+    if ret == errno.EOPNOTSUPP:
+        return
+
+    ksft_eq(ret, 0)
+    ksft_eq(adv, [])
+
+# Pause autoneg : Negotiated pause params vs fixed pause params
+@ksft_disruptive
+def pause_autoneg_state_params(cfg) -> None:
+    """Validate the pause params when transitioning between fixed pause
+       params and negotiated ones. The goal is to make sure that user
+       intent on the RX and TX pause params are stored when user decides
+       to use negotiated parameters instead. The main gotcha lies on the
+       fact that when pause autoneg is used, the autoneg result may differ
+       from the user intent.
+
+    Failing this test means the MAC driver is overwriting the user intent
+    when switching to forced pause.
+    """
+
+    require_pause_supported_allof(cfg, ["Pause", "Asym_Pause"])
+    require_controllable_lp(cfg)
+    require_peer_pause_supported_allof(cfg, ["Pause"])
+    require_link_autoneg(cfg)
+    pause_setup(cfg)
+
+    # Set peer user intent to RX on TX on, with Pause autoneg on
+    set_peer_pauseparams(cfg, 1, 1, True)
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    # Set the local intent to RX on TX off with pause autoneg
+    ksft_eq(set_local_pauseparams(cfg, 1, 0, True), 0)
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    check_local_pauseparams(cfg, True, 1, 0)
+    # Peer advertisiong Pause + Asym and us advertising Pause means we are
+    # actually using RX on TX on here, which is different than the intent.
+    check_local_advertising(cfg, ["Pause", "Asym_Pause"])
+    check_local_lp_advertising(cfg, ["Pause"])
+
+    # Disable pause autoneg
+    ksft_eq(set_local_pause_autoneg(cfg, False), 0)
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    # The pauseparams must still be what we configured before, and not the
+    # previously negotiated ones
+    check_local_pauseparams(cfg, False, 1, 0)
+
+    # Re-enable autoneg
+    ksft_eq(set_local_pause_autoneg(cfg, True), 0)
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    check_local_pauseparams(cfg, True, 1, 0)
+    # We must be advertising our intent again, and not RX on TX on, which would
+    # be "Pause" only.
+    check_local_advertising(cfg, ["Pause", "Asym_Pause"])
+    check_local_lp_advertising(cfg, ["Pause"])
+
+# Pause autoneg vs Link autoneg
+
+@ksft_disruptive
+def pause_autoneg_off_while_link_autoneg_on(cfg) -> None:
+    """ Validate that when link autoneg is on but pause autoneg is off, we do
+        not use negotiated pause parameters.
+
+        - Skip if pause not supported.
+
+        - Requirements :
+        - Link partner: link up, link autoneg on, pause autoneg on,
+          pause tx and rx on
+        - Local device starting conditions : link on, link autoneg on,
+          pause autoneg on, pause tx <on if supported> rx <on if supported>
+
+        Failing this test means the MAC driver incorrectly accounts for the
+        negotiated pause parameters even with pause aneg off, likely due to
+        confusion between link autoneg and pause autoneg.
+    """
+    require_pause_supported_anyof(cfg, ["Pause", "Asym_Pause"])
+    require_controllable_lp(cfg)
+    require_peer_pause_supported_allof(cfg, ["Pause"])
+    require_link_autoneg(cfg)
+    pause_setup(cfg)
+
+    rx, tx = supported_pauseparams(cfg)
+
+    # Enable pause autoneg with all the locally supported modes enabled
+    set_peer_pauseparams(cfg, 1, 1, True)
+    ksft_eq(set_local_pauseparams(cfg, rx, tx, True), 0)
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    # Disable Pause autoneg
+    ksft_eq(set_local_pauseparams(cfg, rx, tx, False), 0)
+    ksft_eq(wait_for_aneg(cfg), True)
+    # Pause autoneg must read "disabled"
+    check_local_pauseparams(cfg, False, rx, tx)
+
+    set_peer_pauseparams(cfg, 0, 0, True)
+    ksft_eq(wait_for_aneg(cfg, link_drop=True), True)
+
+    ip(f"link set {cfg.remote_ifname} down", host=cfg.remote)
+    ip(f"link set {cfg.remote_ifname} up", host=cfg.remote)
+    ksft_eq(wait_for_aneg(cfg, link_drop=True), True)
+
+    # Pause autoneg must still be off even after a link renegotiation
+    check_local_pauseparams(cfg, False, rx, tx)
+
+@ksft_disruptive
+def pause_autoneg_link_autoneg(cfg) -> None:
+    """Validate pause autoneg and link autoneg interactions. The link autoneg's
+       admin status (i.e. do we autoneg link parameters or force them) must not
+       impact the pause autoneg status. While link autoneg is disabled, we don't
+       negotiate the pause params, however we must keep pause autoneg on as this
+       is the user intent. When link autoneg is re-enabled, pause params must be
+       derived from the negotiation.
+
+    Both ends are forced at the speed and duplex the link runs at. A link that
+    does not come back forced is a skip, not a verdict: 1000BASE-T resolves
+    master/slave through autoneg and rarely links without it.
+    """
+
+    require_pause_supported_anyof(cfg, ["Pause", "Asym_Pause"])
+    require_controllable_lp(cfg)
+    require_peer_pause_supported_allof(cfg, ["Pause"])
+    require_link_autoneg(cfg)
+    pause_setup(cfg)
+
+    rx, tx = supported_pauseparams(cfg)
+    adv = pause_to_linkmodes(rx, tx)
+
+    # Enable all possible pause modes and autoneg
+    set_peer_pauseparams(cfg, 1, 1, True)
+    ksft_eq(set_local_pauseparams(cfg, rx, tx, True), 0)
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    check_local_pauseparams(cfg, True, rx, tx)
+    check_local_advertising(cfg, adv)
+    check_local_lp_advertising(cfg, ["Pause"])
+
+    # Disable link autoneg, at the speed and duplex the link runs at
+    forced = forced_link_settings(cfg)
+    if not forced:
+        raise KsftSkipEx("Can't tell what to force the link at")
+
+    ret, _ = ethtool_ret(f"-s {cfg.remote_ifname} autoneg off {forced}",
+                         is_get=False, host=cfg.remote)
+    if ret != 0:
+        raise KsftSkipEx(f"Can't force the peer's link at {forced}")
+
+    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}",
+                         is_get=False)
+    if ret != 0:
+        raise KsftSkipEx(f"Can't force the link at {forced}")
+
+    if not wait_for_aneg(cfg):
+        raise KsftSkipEx(f"No link when forced at {forced}")
+
+    # We must have pause autoneg still enabled, even if we don't negotiate pause
+    check_local_pauseparams(cfg, True, rx, tx)
+
+    # Re-enable autoneg
+    ethtool(f"-s {cfg.remote_ifname} autoneg on", host=cfg.remote)
+    ethtool(f"-s {cfg.ifname} autoneg on")
+    ksft_eq(wait_for_aneg(cfg), True)
+
+    # Pause autoneg must still be on
+    check_local_pauseparams(cfg, True, rx, tx)
+    check_local_advertising(cfg, adv)
+    check_local_lp_advertising(cfg, ["Pause"])
+
 def main() -> None:
     """ The hardware pause tests, on the interface the env names """
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
@@ -681,6 +961,10 @@ def main() -> None:
         ksft_run([pause_test_support,
                   pause_advertising_test,
                   pause_aneg_resolution,
+                  pause_autoneg_state_adv,
+                  pause_autoneg_state_params,
+                  pause_autoneg_off_while_link_autoneg_on,
+                  pause_autoneg_link_autoneg,
                   ],
                  args=(cfg, ))
     ksft_exit()
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 0486405c5c70..ad0ba71b725a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -51,13 +51,13 @@ try:
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
     from .ethtool import ethtool_ret, onoff, wait_for_link, wait_for_aneg, \
-        controllable_lp, require_controllable_lp, \
+        controllable_lp, require_controllable_lp, require_link_autoneg, \
         forced_link_settings
 
     __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
                 "Remote", "Iperf3Runner",
                 "ethtool_ret", "onoff", "wait_for_link", "wait_for_aneg", "controllable_lp", "require_controllable_lp",
-                "forced_link_settings"]
+                "require_link_autoneg", "forced_link_settings"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/ethtool.py b/tools/testing/selftests/drivers/net/lib/py/ethtool.py
index 43e197ac12e5..00d6805ee942 100644
--- a/tools/testing/selftests/drivers/net/lib/py/ethtool.py
+++ b/tools/testing/selftests/drivers/net/lib/py/ethtool.py
@@ -175,6 +175,20 @@ def require_controllable_lp(cfg) -> None:
     if not controllable_lp(cfg):
         raise KsftSkipEx(f"{cfg.remote_ifname} is not directly connected to {cfg.ifname}")
 
+def require_link_autoneg(cfg) -> None:
+    """ Skip if local or remote don't support link autoneg
+
+    :param cfg: test config
+    """
+    # Does local device support link aneg
+    if not ethtool(f"{cfg.ifname}", json=True)[0]["supports-auto-negotiation"]:
+        raise KsftSkipEx(f"{cfg.ifname} doesn't support link autoneg")
+
+    # Does remote device support link aneg
+    if not ethtool(f"{cfg.remote_ifname}",
+                   json=True, host=cfg.remote)[0]["supports-auto-negotiation"]:
+        raise KsftSkipEx(f"Remote {cfg.remote_ifname} doesn't support link autoneg")
+
 def forced_link_settings(cfg) -> str:
     """ Returns a string to pass to ethtool -s with speed/duplex corresponding
         to the current settings.
-- 
2.55.0

