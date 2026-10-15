Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3812529414
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071870; cv=none; b=qR/EAm8c5IRmIylHJHyc2p84JLpZwgaQlNcV2+ankvYmb22mrmSiO3MDCWcEiT8eBDTFd79RWSYd4tUOb2Gz9wLfWk1dQAYlpvUA48nKFHNCnOisTmbXIZfTN528GwurQjot6iY3vdy3iCOBsstO+Hg4+wInIooCklAEmMUzlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071870; c=relaxed/simple;
	bh=yXHPiRfuc+64QzYxYM5QJOO+PRUm1XCvgYjVRn5AOA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVCCkFWhFVf5kHZO0qJmrxGvF47fHZtvFJ1pPK/5IYUCA+rEz8u9BHzgC73tsOAVCCsYzhnejtw4ZwYIKanYTAue2T+eI9BTHNX7lzt41kLbz0bT/3kQTYtI1YlaxD8HSsrT2bExOQHmRdgYz6MhMxDZryj4pBM7avm8IivWSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ev1YhCwt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ev1YhCwt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4FA814E41260;
	Thu, 15 Oct 2026 13:44:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BB5860360;
	Thu, 15 Oct 2026 13:44:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EEB510328B9A;
	Thu, 15 Oct 2026 15:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792071862; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dLCPgpGiJfsTcmZBYtAIUIyQk+X0pDqsb2Fz5a/9Sb4=;
	b=Ev1YhCwtbqjEqsPr9I8yUTVBa9GzmnkLjIpPeGdv9wVdkFaVsapOAYvJGrkBB7u4LXwt3A
	/C6GaCIKw117E9iSwpiCT9bYlamNjFZ//9QKHd/hquT0ib+I6bk9RRaBZeIM7j0PXj2veL
	BFVOc3hSU/ZuS9U7kNoLTicX+t4dsYm7DVgt/E0zhONcW+dtyGrNBaMnM/OLAbA3YW1i8Z
	IpytQD+nkiEtBnbLPs9P5DoCQIsnFlJyDl1Das+w41jZnS9WT+GWNe96KuZFb0XSbPhY8y
	dUTxtK4JVlQDbnqe2mHE1TQ2kcJ/y34VqZZs7cC9TFsc0kupf59tdM8KCbtgmQ==
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
Subject: [PATCH net-next v3 3/3] selftests: drv-net: pause: Validate pause autoneg interactions with link autoneg
Date: Thu, 15 Oct 2026 15:43:48 +0200
Message-ID: <20261015134350.629593-4-maxime.chevallier@bootlin.com>
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
 .../testing/selftests/drivers/net/hw/pause.py | 269 +++++++++++++++++-
 1 file changed, 268 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index cd117296be33..ca4a55e59c30 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -119,6 +119,17 @@ def require_controllable_lp(cfg):
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
@@ -266,6 +277,20 @@ def get_peer_pause_lp_advertising(cfg):
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
 
@@ -290,8 +315,51 @@ def require_peer_pause_supported_allof(cfg, linkmodes):
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
 def expect_pauseparams_set(cfg, pauseparams, aneg, supported, note):
-    """ ethtool -A must work or be refused depending on what the local
+    """ Whether ethtool -A had to work or to be refused, given what the local
         device supports
     """
     rx = pauseparams["rx"]
@@ -663,12 +731,211 @@ def pause_aneg_resolution(cfg, settings):
         ksft_eq(remote_pauseparams["negotiated"]["rx"], expected_lp_rx)
         ksft_eq(remote_pauseparams["negotiated"]["tx"], expected_lp_tx)
 
+@ksft_disruptive
+def pause_autoneg_state_adv(cfg):
+    """Validate that disabling pause autoneg keeps the advertised linkmodes
+
+    With pause autoneg disabled, the pause params are enforced as what the user
+    intended, but the advertising still follows the rx and tx pause params so
+    that the link partner resolves its own pause settings consistently.
+
+    Failing this test means that the MAC or PHY driver changes the
+    Pause / Asym_Pause advertising when pause autoneg is disabled.
+    """
+
+    require_pause_supported_anyof(cfg, ["Pause", "Asym_Pause"])
+    require_link_autoneg(cfg)
+
+    pause_setup(cfg)
+    require_controllable_lp(cfg)
+
+    set_peer_pauseparams(cfg, True, True, True)
+    wait_for_aneg(cfg)
+
+    rx, tx = supported_pauseparams(cfg)
+
+    # Enable all possible pauseparams with pause autoneg
+    ret = set_local_pauseparams(cfg, rx, tx, True)
+    ksft_eq(ret, 0)
+    wait_for_aneg(cfg)
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
+    wait_for_aneg(cfg)
+
+    ret, adv = get_local_pause_advertising(cfg)
+    ksft_eq(ret, 0)
+    ksft_eq(adv, pause_to_linkmodes(rx, tx))
+
+    ret, adv = get_peer_pause_lp_advertising(cfg)
+    if ret == errno.EOPNOTSUPP:
+        return
+
+    ksft_eq(ret, 0)
+    ksft_eq(adv, pause_to_linkmodes(rx, tx))
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
+    require_peer_pause_supported_allof(cfg, ["Pause"])
+    require_link_autoneg(cfg)
+    pause_setup(cfg)
+    require_controllable_lp(cfg)
+
+    # Set peer user intent to RX on TX on, with Pause autoneg on
+    set_peer_pauseparams(cfg, 1, 1, True)
+    wait_for_aneg(cfg)
+
+    # Set the local intent to RX on TX off with pause autoneg
+    ksft_eq(set_local_pauseparams(cfg, 1, 0, True), 0)
+    wait_for_aneg(cfg)
+
+    check_local_pauseparams(cfg, True, 1, 0)
+    check_local_advertising(cfg, ["Pause", "Asym_Pause"])
+    check_local_lp_advertising(cfg, ["Pause"])
+
+    # Disable pause autoneg
+    ksft_eq(set_local_pause_autoneg(cfg, False), 0)
+    wait_for_aneg(cfg)
+
+    # The pauseparams must still be what we configured before, and not the
+    # previously negotiated ones
+    check_local_pauseparams(cfg, False, 1, 0)
+
+    # Re-enable autoneg
+    ksft_eq(set_local_pause_autoneg(cfg, True), 0)
+    wait_for_aneg(cfg)
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
+    require_peer_pause_supported_allof(cfg, ["Pause"])
+    require_link_autoneg(cfg)
+    pause_setup(cfg)
+    require_controllable_lp(cfg)
+
+    rx, tx = supported_pauseparams(cfg)
+
+    # Enable pause autoneg with all the locally supported modes enabled
+    set_peer_pauseparams(cfg, 1, 1, True)
+    ksft_eq(set_local_pauseparams(cfg, rx, tx, True), 0)
+    wait_for_aneg(cfg)
+
+    # Disable Pause autoneg
+    ksft_eq(set_local_pauseparams(cfg, rx, tx, False), 0)
+    wait_for_aneg(cfg)
+    # Pause autoneg must read "disabled"
+    check_local_pauseparams(cfg, False, rx, tx)
+
+    set_peer_pauseparams(cfg, 0, 0, True)
+    wait_for_aneg(cfg)
+
+    ethtool(f"-r {cfg.ifname}")
+    wait_for_aneg(cfg, link_drop=True)
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
+    require_peer_pause_supported_allof(cfg, ["Pause"])
+    require_link_autoneg(cfg)
+    pause_setup(cfg)
+    require_controllable_lp(cfg)
+
+    rx, tx = supported_pauseparams(cfg)
+    adv = pause_to_linkmodes(rx, tx)
+
+    # Enable all possible pause modes and autoneg
+    set_peer_pauseparams(cfg, 1, 1, True)
+    ksft_eq(set_local_pauseparams(cfg, rx, tx, True), 0)
+    wait_for_aneg(cfg)
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
+    try:
+        wait_for_aneg(cfg)
+    except TimeoutError:
+        raise KsftSkipEx(f"No link when forced at {forced}")
+
+    # We must have pause autoneg still enabled, even if we don't negotiate pause
+    check_local_pauseparams(cfg, True, rx, tx)
+
+    # Re-enable autoneg
+    ethtool(f"-s {cfg.remote_ifname} autoneg on", host=cfg.remote)
+    ethtool(f"-s {cfg.ifname} autoneg on")
+    wait_for_aneg(cfg)
+
+    # Pause autoneg must still be on
+    check_local_pauseparams(cfg, True, rx, tx)
+    check_local_advertising(cfg, adv)
+    check_local_lp_advertising(cfg, ["Pause"])
+
 def main():
     """ Entry point """
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
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

