Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161634A3A5;
	Sun,  4 Oct 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132182; cv=none; b=hLXJoNjHHIzpFQKLiJMlmUoiZwBLcsXk3OO8HGG0KSj1ZUYpi7clUyoareK1pIIBMvfyEtfTY8gguU0Gzo+AgmFvDT01LmwBrtLCfzr9NI+kMgsw6PIcY9wiQF3hkiMLqAnixOTUli1MpuojONisyCMzWhuEwBJyReKbs283Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132182; c=relaxed/simple;
	bh=YqCW2tzt0821cR/Mt0sbnckWAjY8XERgLd8X5XvxoA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/2gSmxRfUtiiYCpHqVe1KRxUmEBsm8Ue38794EXMo0N3BK7CEq5bcQYyvXA88ARljwfyqYLvRIwy0pYwvL4UUSgpJRu7N2nJXTc0rjSpiMnbURfVpYKnQV6DcEf5MYEvINNzqVeZwyLPZWIMwcuz9U2bv6NJSsQbdP/qe0XWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=PpowFYmz; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="PpowFYmz"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 6358AE837F0;
	Sun, 04 Oct 2026 18:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791132177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcBTlOzbzWKZ2xoJU9IH/Zvwb/+STog+akwUTYwRc/g=;
	b=PpowFYmzZE+bTjvZ1uYCd4wZtI3lD7BRQNuA6AAKbgF+aZzJkg394d+Pl+7+xFHFAHKRaz
	4c6Mnude/N0WHT63VkZNmUQAPHtPTBlRU+8NGmx9cGD3Vq2MwX/InmnxrvpATOQbuGQmx0
	dBFm4uqMSD0DZlBxRIk2/zHK9YJpdJQFdsRNwql5FdArgqxHJ3mi2XtMztGiJjOx307zZz
	BV02CpRTwOWOUSeg01n7dRY7WqaKixh+oJmUi8yxnoFCCWbL4e9jC4ohqngfP6hVVh1ezY
	EW9RoG8au4owqfADTbZ4R5BEIv+Xs0zODy7t+QZwAu2oqxJR5iEC/fOU5AI3YA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 6NfBj853X7vP; Sun,  4 Oct 2026 18:42:57 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-55.ip.tng.de [86.103.67.55])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 18:42:56 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v8 6/7] of: property: do not let "pses" block a consumer's probe
Date: Sun,  4 Oct 2026 18:42:18 +0200
Message-ID: <20261004164219.1161294-7-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004164219.1161294-1-github@szelinsky.de>
References: <20261004164219.1161294-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fw_devlink treats "pses" as a supplier binding, so a PHY that
references a PSE PI has its driver probe held in
device_links_check_suppliers() until the PSE controller binds: by a
fwnode link to the PI node until then, and by a device link to the
controller once it has bound.

That is harmless while the PSE lookup itself defers the PHY:
fwnode_mdio registers it, fails the lookup and removes it again on
every retry, so it never stays registered long enough to be bound
early. Once phylib stops deferring on PSE and picks the handle up from
a notifier instead, the PHY is registered while its own driver is
still blocked, and a MAC or DSA switch attaching in that window binds
the generic driver:

  phy_attach_direct()
    if (!d->driver)
            d->driver = &genphy_driver.mdiodrv.driver;
    device_bind_driver()
      device_links_force_bind()

device_bind_driver() does not wait for suppliers:
device_links_force_bind() drops any managed supplier link that is not
available yet, and driver_bound() purges the PHY's remaining fwnode
supplier links. Nothing re-probes the PHY once the PSE controller shows
up, so the port keeps running on genphy until a rebind or a reboot.

The link is not needed for correctness. PSE is not a resource the
consumer must have before it probes: phylib looks a PI up when its
controller becomes available and releases it when the controller goes
away, and of_pse_control_get() is the only reader of the property.

Mark it FWLINK_FLAG_IGNORE, as post-init-providers already is. That
drops the dependency entirely: fw_devlink_create_devlink() returns
early, so no device link is made, the fwnode link is deleted at the
consumer's device_add() like any other that has been handled, and
fw_devlink neither gates probe on it nor uses it for cycle detection.

Two things ride on the link today, and both go with it, because it is
managed. of_link_property() passes no get_con_dev for parse_pses, so
the fwnode link sits on the PHY's own node, which is the PHY device's
fwnode by the time it is registered, and fw_devlink_create_devlink()
takes its first branch:

	if (con->fwnode == link->consumer)
		flags = fw_devlink_get_flags(link->flags);
	else
		flags = FW_DEVLINK_FLAGS_PERMISSIVE;

With link->flags clear that returns fw_devlink_flags, by default
FW_DEVLINK_FLAGS_RPM, which carries neither DL_FLAG_STATELESS nor
DL_FLAG_SYNC_STATE_ONLY, so device_link_add() makes it DL_FLAG_MANAGED.
Unbinding the PSE controller therefore releases the PHY's driver today,
and DL_FLAG_AUTOPROBE_CONSUMER probes the PHY once the controller
binds. Both are given up on purpose: phylib's notifier takes the PI
away on unbind and hands it back on bind without tearing the PHY driver
down, and with no deferral left there is nothing for an autoprobe to
wait for. DL_FLAG_PM_RUNTIME and the dpm_list reordering go without
consequence, since no PSE driver implements PM ops, .shutdown,
sync_state or runtime PM.

This change is not a no-op while fwnode_mdio still does the lookup.
fwnode_mdiobus_register_phy() registers the PHY before it looks the PI
up, so the device link is created regardless and becomes active as
soon as the controller is bound; the unbind cascade above goes away
from here on. The link also held the PHY's driver back on each of those
retries while the controller was unbound. Without it the driver probes
inside device_add() - phy drivers are PROBE_FORCE_SYNCHRONOUS - and is
removed again when the lookup defers, once per retry of the MDIO bus
owner, until the PSE controller binds or fwnode_mdio stops doing the
lookup.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/of/property.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 72cf12907de0..5ec0f05b87ac 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1564,7 +1564,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_backlight, },
 	{ .parse_prop = parse_panel, },
 	{ .parse_prop = parse_msi_parent, },
-	{ .parse_prop = parse_pses, },
+	{
+		.parse_prop = parse_pses,
+		.fwlink_flags = FWLINK_FLAG_IGNORE,
+	},
 	{ .parse_prop = parse_power_supplies, },
 	{ .parse_prop = parse_mmc_pwrseq, },
 	{ .parse_prop = parse_gpio_compat, },
-- 
2.43.0

