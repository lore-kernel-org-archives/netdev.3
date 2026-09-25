Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D054D9F81
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360813; cv=none; b=Dv9V85gD4vmh9BcX3SQ/MTclUEqX5KVw4Ypgi1f97GO1Wa9IRhJgrBh++iX+E0RebRc7HJ8U5PrysgDeRBGaNKJDUQng6PylmBcS+iL1gJEs8Y4b19wmSWFIT4WOnfKoj5Ovl4T6rrkHrUv4Mo6alBt6FFjj7CdDUdbeH+HCifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360813; c=relaxed/simple;
	bh=dCCZ0eWOaShg0JIUq0FXHIj7YXZ69/K7RO6agqLIM6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok81/Xyhs+ZotwWRhR/irZFHjGqb9xf4iKSqQWIi4eFttiFcyP1ounpUTaicj4t84HCZtY3PIAoMxQsVYQh8m44rXK6FyEYdL/C8hsZGWx3GeRBjGFkCOuxd6cTs+jVfHS/8QeW3tmJ+YHLU+mGq3MWo1fFIGwOqYX3mwswMY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EtCG0dqv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EtCG0dqv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 349834E41076;
	Fri, 25 Sep 2026 18:26:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0447F6073B;
	Fri, 25 Sep 2026 18:26:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 353A3102F1E35;
	Fri, 25 Sep 2026 20:26:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790360803; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pe3R9Cu9x9A+QgopHdhEKuwZBCGIOvnxBLHy6sGCtPs=;
	b=EtCG0dqvmwqkO/Zxm7FfjqZiGdVLIkD8MWj4Gd09fF6j120nlNRfrnKgYOFJqvwLSbD5eQ
	NHBnBgnCF41/z2CyggYRyB2kSOdkWir+K+G9FFgVpWi0QDIJ+IMoacX13yaG0cYy0XsA0h
	WeHISiYnOZAeG+Ezc4RB077GoG3T/M0jnUZAzye7XBZKG/C7gk9LrFDSi9asrRTYPwfAOD
	uifA2YsCk8j7Ubs4eOC6RQfK1Xl8apBatHjj2RCpQ4tEb8gEmrU6MTtRRSba2x8KxMOJ5w
	FvK846W47nQrgx78AL02fMY5/1AkkUt1VDUBwvvrhZa/FLU5xV16nEyvKGenLg==
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
Subject: [PATCH net-next v2 1/3] selftests: drv-net: Introduce a selftest for ethtool flow control
Date: Fri, 25 Sep 2026 20:26:25 +0200
Message-ID: <20260925182628.214667-2-maxime.chevallier@bootlin.com>
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

Ethernet flow control is a tricky thing to get right, especially when it
comes to correctly handling the negotiation of the parameters with a
link partner.

On one hand, the userspace API talks in terms of the device's ability to
send Pause frames when the device is overwhelmed by ingress traffic (TX
pause) and the ability to stop sending traffic upon receiving Pause
frames (RX pause).

On the other hand, 802.3 explains that devices can exchange their
abilities over link negotiation, but instead of echanging TX and RX
abilities, they exchange Pause and Asymmetric Pause capabilities :

RX unable TX unable => None
RX able   TX unable => Pause + Asymmetric
RX unable TX able   => Asymmetric
RX able   TX able   => Pause

The reported Pause and Asym abilities depend both on the MAC, that
eventually sends and processes these frames, and the PHY, that
advertises these to the partner.

Both MAC and PHYs can have their own limitations, and getting the
correct set of supported Pause/Asym parameters is non-trivial, unless
the MAC uses phylink, which deals with the complexity.

Introduce a set of Pause selftests that verify that the local
interface's supported pause parameters reported from ethtool (in terms
of Pause + Asym ) match the accepted parameters from "ethtool -A",
corresponding to ethtool's .set_pauseparams() ops, expressed in TX and
RX abilities.

Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../testing/selftests/drivers/net/hw/pause.py | 411 ++++++++++++++++++
 2 files changed, 412 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/pause.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index bd3b8d2fa47e..f0aeb70c20fd 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -44,6 +44,7 @@ TEST_PROGS = \
 	nk_netns.py \
 	nk_qlease.py \
 	ntuple.py \
+	pause.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
new file mode 100755
index 000000000000..f07db3271500
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -0,0 +1,411 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Driver-related behavior tests for Pause-based Flow Control.
+"""
+
+import errno
+import json
+import os
+import time
+
+from lib.py import KsftFailEx, KsftNamedVariant, KsftSkipEx
+from lib.py import NetDrvEpEnv, EthtoolFamily
+from lib.py import cmd, defer, ethtool, ip
+from lib.py import ksft_disruptive, ksft_variants, ksft_run
+from lib.py import ksft_eq, ksft_exit, ksft_in, ksft_not_in, ksft_pr
+
+# Linkmodes to Pause params :
+# Pause bit is set if rx == 1
+# Asym_Pause bit is set if rx != tx
+pauseparams_to_linkmodes = {
+    0: {0: {"rx": 0, "tx": 0, "linkmodes": []},
+        1: {"rx": 0, "tx": 1, "linkmodes": ["Asym_Pause"]}},
+    1: {0: {"rx": 1, "tx": 0, "linkmodes": ["Pause", "Asym_Pause"]},
+        1: {"rx": 1, "tx": 1, "linkmodes": ["Pause"]}},
+}
+
+def onoff(val):
+    """ Convert a bool to on/off """
+    return "on" if val else "off"
+
+pauseparams_variants = [
+    KsftNamedVariant(f"RX {onoff(p['rx'])} TX {onoff(p['tx'])}", p)
+    for by_tx in pauseparams_to_linkmodes.values() for p in by_tx.values()
+]
+
+_strerrors = {os.strerror(e): e for e in errno.errorcode}
+
+def ethtool_ret(command, is_get=True, host=None):
+    """ Execute an ethtool command, returns the return code and JSON content
+
+    :param command: the ethtool arguments
+    :param is_get: Is the command a get or a set. Get commands return the loaded
+                   JSON attributes
+    :param host: The host on which to run the command on. None means local host.
+    """
+    json_flag = "--json" if is_get else ""
+    cmd_res = cmd(f"ethtool {json_flag} {command}", host=host, fail=False)
+
+    if cmd_res.ret != 0:
+        # ethtool returns 1 upon error, not the netlink errcode. Try to get it
+        # by parsing the stderr output, which looks like :
+        # "netlink error: Operation not supported"
+        for line in cmd_res.stderr.splitlines():
+            err = _strerrors.get(line.rsplit(": ", 1)[-1].strip())
+            if err:
+                return err, None
+        return cmd_res.ret, None
+
+    # Not a get operation, we don't have any JSON output to parse
+    if not is_get:
+        return 0, None
+
+    return 0, json.loads(cmd_res.stdout)[0]
+
+def wait_for_aneg(cfg, link_drop=False, timeout=15):
+    """ Wait for a renegotiation to complete.
+
+    :param link_drop: Set to true if the link HAS to flap.
+    :returns: True if link is UP, False if timeout
+    """
+    deadline = time.monotonic() + timeout
+
+    # Link has 2 seconds to come back up
+    restart_by = time.monotonic() + 2
+
+    # The link may still be up for a short while when we trigger an autoneg
+    # restart, we need to wait for it to drop, then come back up again
+    while time.monotonic() < deadline:
+        if not ethtool(f"{cfg.ifname}", json=True)[0]["link-detected"]:
+            return wait_for_link(cfg)
+
+        if not link_drop and time.monotonic() > restart_by:
+            return wait_for_link(cfg)
+
+        time.sleep(0.1)
+
+    return False
+
+def wait_for_link_local(cfg, timeout=15):
+    """ Wait for the local link to be up """
+    deadline = time.monotonic() + timeout
+
+    while time.monotonic() < deadline:
+        link = ethtool(f"{cfg.ifname}", json=True)[0]["link-detected"]
+        if link:
+            return True
+
+        time.sleep(0.1)
+
+    return False
+
+def wait_for_link_remote(cfg, timeout=15):
+    """ Wait for the far end of the link to be up """
+    deadline = time.monotonic() + timeout
+
+    while time.monotonic() < deadline:
+        link = ethtool(f"{cfg.remote_ifname}", json=True,
+                       host=cfg.remote)[0]["link-detected"]
+        if link:
+            return True
+
+        time.sleep(0.1)
+
+    return False
+
+def wait_for_link(cfg):
+    """ Wait for both ends of the link to be up """
+    if not wait_for_link_local(cfg):
+        return False
+
+    # Local link is UP, we shouldn't have to wait for a whole 8 seconds for
+    # the remote to report link up, let's wait a bit less
+    return wait_for_link_remote(cfg, timeout = 3)
+
+def forced_link_settings(cfg):
+    """ Returns a string to pass to ethtool -s with speed/duplex corresponding
+        to the current settings.
+
+        Note that some devices don't return duplex info, so assume full duplex
+        in that case.
+    """
+    link = ethtool(f"{cfg.ifname}", json=True)[0]
+    if "speed" not in link:
+        return ""
+
+    return f"speed {link['speed']} duplex {link.get('duplex', 'Full').lower()}"
+
+def _ethtool_pause_use_to_linkmodes(use):
+    """ Convert the ethtool output for pause modes into pause linkmodes """
+    if use == "Symmetric":
+        return ["Pause"]
+    elif use == "Symmetric Receive-only":
+        return ["Pause", "Asym_Pause"]
+    elif use == "Transmit-only":
+        return ["Asym_Pause"]
+    else:
+        return []
+
+def set_local_pauseparams(cfg, rx, tx, aneg):
+    """ set pauseparams : ethtool -A
+
+    Raise an error if the return is not 0 or EOPNOTSUPP
+    """
+    rx_param = onoff(rx)
+    tx_param = onoff(tx)
+    aneg_param = onoff(aneg)
+
+    ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx_param} tx {tx_param}"
+                         f" autoneg {aneg_param}",
+                         is_get = False)
+
+    return ret
+
+def get_local_pauseparams(cfg):
+    """ get pauseparams : ethtool -a
+
+    Raise an error if the return is not 0 or EOPNOTSUPP
+    """
+    return ethtool_ret(f"-a {cfg.ifname}", is_get=True)
+
+def get_local_pause_supported(cfg):
+    """ Return the errcode and the local pause supported linkmodes """
+
+    ret, data = ethtool_ret(f"{cfg.ifname}")
+    if ret != 0:
+        raise KsftFailEx(f"ethtool {cfg.ifname} failed: {ret}")
+
+    return ret, _ethtool_pause_use_to_linkmodes(data["supported-pause-frame-use"])
+
+def get_local_pause_advertising(cfg):
+    """ Return the errcode and the local pause advertised linkmodes """
+
+    ret, data = ethtool_ret(f"{cfg.ifname}")
+    if ret != 0:
+        raise KsftFailEx(f"ethtool {cfg.ifname} failed: {ret}")
+
+    return ret, _ethtool_pause_use_to_linkmodes(data["advertised-pause-frame-use"])
+
+def require_pause_supported_allof(cfg, linkmodes):
+    """ Skip if local device doesn't support all of the passed modes """
+
+    ret, _ = get_local_pauseparams(cfg)
+    if ret != 0:
+        raise KsftSkipEx("device doesn't allow getting pauseparams")
+
+    _, pause_support = get_local_pause_supported(cfg)
+    for lm in linkmodes:
+        if lm not in pause_support:
+            raise KsftSkipEx(f"Local device doesn't support {lm}")
+
+def expect_pauseparams_set(ret, linkmodes, supported, note):
+    """ Whether ethtool -A had to work or to be refused, given what the local
+        device supports
+    """
+
+    # If supported is empty, ethtool -A must return -EOPNOTSUPP
+    if not supported :
+        ksft_eq(ret, errno.EOPNOTSUPP, note)
+    elif set(linkmodes).issubset(set(supported)) :
+        # The configured pauseparams are supposed to be supported,
+        #ethtool -A must have worked.
+        ksft_eq(ret, 0, note)
+    else :
+        # We tried to configure parameters that aren't supporteed,
+        # ethtool -A must have failed.
+        ksft_in(ret, (errno.EOPNOTSUPP, errno.EINVAL), note)
+
+def pause_setup(cfg):
+    """ The starting conditions every test counts on, restored on exit:
+        - both ports admin up
+        - link autoneg on on both sides ifsupported
+        - link actually up (carrier on)
+    """
+
+    # Get init pause parameters
+    ret, params = ethtool_ret(f"-a {cfg.ifname}")
+    if ret == 0:
+        defer(cmd, f"ethtool -A {cfg.ifname} rx {onoff(params['rx'])} "
+                   f"tx {onoff(params['tx'])} "
+                   f"autoneg {onoff(params['autonegotiate'])}")
+
+    # Get init link parameters
+    link = ethtool(f"{cfg.ifname}", json=True)[0]
+    if link["auto-negotiation"]:
+        defer(cmd, f"ethtool -s {cfg.ifname} autoneg on")
+    elif "speed" in link and "duplex" in link:
+        defer(cmd, f"ethtool -s {cfg.ifname} autoneg off speed {link['speed']} "
+                   f"duplex {link['duplex'].lower()}")
+
+    # Local interface admin up, link aneg on
+    ip(f"link set {cfg.ifname} up")
+    if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
+        ethtool(f"-s {cfg.ifname} autoneg on")
+
+    # Get remote pause params
+    ret, params = ethtool_ret(f"-a {cfg.remote_ifname}", host=cfg.remote)
+    if ret == 0:
+        defer(cmd, f"ethtool -A {cfg.remote_ifname} rx {onoff(params['rx'])} "
+                   f"tx {onoff(params['tx'])} "
+                   f"autoneg {onoff(params['autonegotiate'])}",
+                   host=cfg.remote)
+
+    # Get remote link params
+    link = ethtool(f"{cfg.remote_ifname}", json=True, host=cfg.remote)[0]
+    if link["auto-negotiation"]:
+        defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg on",
+              host=cfg.remote)
+    elif "speed" in link and "duplex" in link:
+        defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg off "
+                   f"speed {link['speed']} duplex {link['duplex'].lower()}",
+                   host=cfg.remote)
+
+    # Remote interface admin up, link aneg on
+    ip(f"link set {cfg.remote_ifname} up", host=cfg.remote)
+    if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
+        ethtool(f"-s {cfg.remote_ifname} autoneg on", host=cfg.remote)
+
+    # Wait for link to become up on both ends
+    if not wait_for_link(cfg):
+        raise KsftFailEx("No link before the test")
+
+# Pause support : Supported linkmodes vs ability to set/get pauseparams
+@ksft_variants(pauseparams_variants)
+@ksft_disruptive
+def pause_test_support(cfg, pauseparams):
+    """ Verify that the supported linkmodes Pause and Asym_Pause match the
+        ability to configure the rx and tx pauseparams.
+
+    Drivers are expected to reject pauseparams they don't support, and
+    accept the ones they support. The supported modes are exposed by
+    the MAC to the PHY layer through phylink mac_capabilities MAC_SYM_PAUSE
+    and MAC_ASYM_PAUSE, or through phylib directly with the
+    phy_support_sym_pause() and phy_support_asym_pause() helpers.
+
+    The expectation is for drivers to refuse setting pauseparams that don't
+    match the Pause and Asym_Pause bits in the supported linkmodes with a
+    -EOPNOTSUPP return value. Unsupported pause params must be rejected.
+
+    Failing this test likely means the MAC driver doesn't implement the
+    set/get_pauseparam, but still sets flow control as supported through
+    phylink mac_capabilities or phylib's pause API. Conversely, the MAC driver
+    may have omitted to indicate its supported Pause modes. Finally, the PHY
+    driver may incorrectly override the Pause and Asym_Pause bits in its
+    supported fields.
+
+    The sequence runs with link autoneg on, then with the link forced
+    (ethtool -s ethX autoneg off): the pause params are accepted or rejected
+    the same way in both cases, and both with pause autoneg off and on.
+    """
+
+    rx = onoff(pauseparams["rx"])
+    tx = onoff(pauseparams["tx"])
+    linkmodes = pauseparams["linkmodes"]
+
+    pause_setup(cfg)
+
+    forced = forced_link_settings(cfg)
+    _, supported = get_local_pause_supported(cfg)
+
+    # We check that what we can configure in the pause params matches what we
+    # support under various contditions : Link aneg on/off, pause aneg on/off
+    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg on", is_get = False)
+    if ret != 0:
+        ksft_pr("link autoneg on refused, not tested")
+    else:
+        ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx} tx {tx} autoneg off",
+                             is_get = False)
+        expect_pauseparams_set(ret, linkmodes, supported, "link autoneg on")
+
+        ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx} tx {tx} autoneg on",
+                             is_get = False)
+        expect_pauseparams_set(ret, linkmodes, supported, "link autoneg on")
+
+    if not forced:
+        ksft_pr("link speed unknown, the forced link is not tested")
+        return
+
+    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}", is_get = False)
+    if ret != 0:
+        ksft_pr(f"link autoneg off {forced} refused, not tested")
+        return
+
+    ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx} tx {tx} autoneg off",
+                         is_get = False)
+    expect_pauseparams_set(ret, linkmodes, supported, "link autoneg off")
+
+    ret, _ = ethtool_ret(f"-A {cfg.ifname} rx {rx} tx {tx} autoneg on",
+                         is_get = False)
+    expect_pauseparams_set(ret, linkmodes, supported, "link autoneg off")
+
+@ksft_variants(pauseparams_variants)
+@ksft_disruptive
+def pause_advertising_test(cfg, pauseparams):
+    """Pause advertisement
+
+    Validate that changing pause params through the ETHTOOL_MSG_PAUSE command
+    translates to a change in the advertised pause params, and that these
+    parameters are correct w.r.t the supported pause params and requested pause
+    params.
+
+    This exercises the .set_pauseparam() ethtool ops for MAC configuration,
+    as well as the reconfiguration of the PHY's advertising and negotiation.
+
+    On non-phylink MACs, the MAC should call phy_set_sym_pause() to update the
+    PHY's advertising, and restart a negotiation with phy_start_aneg() if
+    need be. Failure to do so will result in the wrong advertising parameters.
+
+    On phylink-enabled MACs, phylink deals with the PHY reconfiguration provided
+    the MAC driver calls phylink_ethtool_set_pauseparam().
+
+    Failing this test likely means that the PHY driver is not correctly
+    advertising pause settings, either due to the MAC not triggering a PHY
+    reconfiguration, a misconfiguration of the advertising registers by the PHY,
+    or by mis-handling the phydev->advertising bitmap in the PHY driver directly.
+
+    The validation is made by looking at the advertised modes locally, as well
+    as what the peer's 'lp_advertising' values report.
+    """
+
+    require_pause_supported_allof(cfg, pauseparams["linkmodes"])
+    pause_setup(cfg)
+
+    tx = pauseparams["tx"]
+    rx = pauseparams["rx"]
+    adv = pauseparams["linkmodes"]
+    not_adv = [ l for l in ["Pause", "Asym_Pause"] if l not in adv]
+
+    # It's OK to skip here, we're already validating the EOPNOTSUPP behaviour
+    # the pause_test_support test.
+    ret = set_local_pauseparams(cfg, rx, tx, True)
+    if ret == errno.EOPNOTSUPP:
+        raise KsftSkipEx(f"RX {rx} TX {tx} not supported")
+
+    # Wait for link parameters to re-negotiate and link to come back up. It must
+    # come back up, otherwise that means changing pauseparams can bring the
+    # link down.
+    ret = wait_for_aneg(cfg)
+    ksft_eq(ret, True)
+
+    _, linkmodes = get_local_pause_advertising(cfg)
+    for mode in adv:
+        ksft_in(mode, linkmodes,
+                f"rx {rx} tx {tx} aneg on must advertise {adv}")
+
+    for mode in not_adv:
+        ksft_not_in(mode, linkmodes,
+                    f"rx {rx} tx {tx} aneg on must not advertise {not_adv}")
+
+def main():
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        ksft_run([pause_test_support,
+                  pause_advertising_test,
+                  ],
+                 args=(cfg, ))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.55.0

