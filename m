Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043354D90DE
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360827; cv=none; b=lUGvoG1Wu3Ehqmk/ydFofzkXDeIAK1Hnv7Yrcd4bgHmHyWS2DSLfN+U+L+ONIBRxB8zjO2+tEp7J5l8a/Dzj9qasesuZRalg58G8bcj7yU7hiVjAfeBwODtFzP6GdU+W+FAZJXV2AgiJ4WHrjn+2yIb784Dgg+lYZjDbNRLrrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360827; c=relaxed/simple;
	bh=Js7HSdaQ+OZtG5cnS2C3PJPfn6VjJzQU7IlsZPrZaag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sE6IT+h8fg+mZSz0YyoW1ikgXWmBOzIzZwB/jI+7KBwe/ZjjNI5D5xu/UmoQalou2rKPc3ZJvHtn4iertCVXkrLlENXtl4yvVXwo2FAs2I/LBEeG3LWPjqVSNMGRF00XLc2S2jZB+UeYWIXOtlIzxmqUiAFg7pjAzqpTJFLo59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ViZiBCgv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ViZiBCgv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3A06AC63440;
	Fri, 25 Sep 2026 18:27:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41B3E6073B;
	Fri, 25 Sep 2026 18:27:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8D3D102F1E38;
	Fri, 25 Sep 2026 20:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790360818; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lFxqxKhM+l8Qc7HsDNKPF1hTySJ2G04UNq+JWH2Vg0A=;
	b=ViZiBCgveus1XPM4AC9b35lpElA8yeJ96QsXtRHi/wUoqr6K+Dkinq1FQnKSCevjCXvkUT
	A4oIGgw4bx6RrGctdaPJZrjhPayzn3HjeehhFEaSR3kg8qXL2spfLJBuFOswbLubg2Ves4
	K73Q49Zj8EBNk7yY6Sf6OQXJUROQyjGfdYo9wj923xHZzUNUnIuVmRy4i4FzFjxl7AW9or
	PlziP31TqqF8rqEDBblfiuOglcusZ1/PMiuZaGihYwfKtSGyu7nu6bHUFpE2iBavTeuHfY
	hy7fz7aPO/ygNDXobUs13veExfp7xLMV00Es9DrcLwwfjSxLABkN9D6X/euH/Q==
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
Subject: [PATCH net-next v2 3/3] selftests: drv-net: pause: Validate pause autoneg interactions with link autoneg
Date: Fri, 25 Sep 2026 20:26:27 +0200
Message-ID: <20260925182628.214667-4-maxime.chevallier@bootlin.com>
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
 .../testing/selftests/drivers/net/hw/pause.py | 274 ++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index 96ee730074f8..74bc21c60695 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -180,6 +180,17 @@ def require_controllable_lp(cfg):
     if not controllable_lp(cfg):
         raise KsftSkipEx(f"{cfg.remote_ifname} is not directly connected to {cfg.ifname}")
 
+def require_link_autoneg(cfg):
+    """ Skip if local or remote device don't support link aneg """
+    # Does local device support link aneg
+    if not ethtool(f"{cfg.ifname}", json=True)[0]["supports-auto-negotiation"]:
+        raise KsftSkipEx(f"{cfg.ifname} doesn't support link autoneg")
+
+    # Does remote device support link aneg
+    if not ethtool(f"{cfg.remote_ifname}",
+                   json=True, host=cfg.remote)[0]["supports-auto-negotiation"]:
+        raise KsftSkipEx(f"Remote {cfg.remote_ifname} doesn't support link autoneg")
+
 def forced_link_settings(cfg):
     """ Returns a string to pass to ethtool -s with speed/duplex corresponding
         to the current settings.
@@ -324,6 +335,20 @@ def get_peer_pause_lp_advertising(cfg):
         ksft_pr(f"Warning: {cfg.remote_ifname} does not report the LP's advertising")
         return errno.EOPNOTSUPP, None
 
+def require_pause_supported_anyof(cfg, linkmodes):
+    """ Skip if local device doesn't support any of the passed modes """
+
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
 def require_pause_supported_allof(cfg, linkmodes):
     """ Skip if local device doesn't support all of the passed modes """
 
@@ -362,6 +387,49 @@ def require_peer_pause_supported_allof(cfg, linkmodes):
         if lm not in pause_support:
             raise KsftSkipEx(f"Remote device doesn't support {lm}")
 
+def supported_pauseparams(cfg):
+    """ The rx/tx params covering every mode the local device supports """
+
+    _, pause_support = get_local_pause_supported(cfg)
+    if "Pause" in pause_support:
+        return 1, 1
+    if "Asym_Pause" in pause_support:
+        return 0, 1
+
+    raise KsftSkipEx("Local device doesn't support pause")
+
+def set_local_pause_autoneg(cfg, aneg):
+    """ Enable/Disable local pause autoneg """
+
+    ret, _ = ethtool_ret(f"-A {cfg.ifname} autoneg {onoff(aneg)}",
+                         is_get=False)
+    return ret
+
+def check_local_pauseparams(cfg, aneg, rx, tx):
+    """ Check that the local pauseparams are the passed parameters """
+
+    ret, params = get_local_pauseparams(cfg)
+    ksft_eq(ret, 0)
+    if ret != 0:
+        return
+
+    ksft_eq(params["autonegotiate"], bool(aneg), "pause autoneg")
+    ksft_eq(params["rx"], bool(rx), "rx pause")
+    ksft_eq(params["tx"], bool(tx), "tx pause")
+
+def check_local_advertising(cfg, linkmodes):
+    """ Check that the local advertised modes are the passed parameters """
+
+    _, adv = get_local_pause_advertising(cfg)
+    ksft_eq(adv, linkmodes, "advertised pause modes")
+
+def check_local_lp_advertising(cfg, linkmodes):
+    """ Check that the local lp_advertised modes are the passed parameters """
+
+    ret, adv = get_local_pause_lp_advertising(cfg)
+    if ret == 0:
+        ksft_eq(adv, linkmodes, "link partner advertised pause modes")
+
 def expect_pauseparams_set(ret, linkmodes, supported, note):
     """ Whether ethtool -A had to work or to be refused, given what the local
         device supports
@@ -747,12 +815,218 @@ def pause_aneg_resolution(cfg, settings):
         ksft_eq(remote_pauseparams["negotiated"]["rx"], expected_lp_rx)
         ksft_eq(remote_pauseparams["negotiated"]["tx"], expected_lp_tx)
 
+@ksft_disruptive
+def pause_autoneg_state_adv(cfg):
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
+@ksft_disruptive
+def pause_autoneg_state_params(cfg):
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
+@ksft_disruptive
+def pause_autoneg_off_while_link_autoneg_on(cfg):
+    """ Validate that when link autoneg is on but pause autoneg is off, we do
+        not use negotiated pause parameters.
+
+        Failing this test means the MAC driver incorrectly accounts for the
+        negotiated pause parameters even with pause aneg off, likely due to
+        confusion between link autoneg and pause autoneg.
+    """
+
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
+def pause_autoneg_link_autoneg(cfg):
+    """Validate pause autoneg and link autoneg interactions. The link autoneg's
+       admin status (i.e. do we autoneg link parameters or force them) must not
+       impact the pause autoneg status. While link autoneg is disabled, we don't
+       negotiate the pause params, however we must keep pause autoneg on as this
+       is the user intent. When link autoneg is re-enabled, pause params must be
+       derived from the negotiation.
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
 def main():
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.ethnl = EthtoolFamily()
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
-- 
2.55.0

