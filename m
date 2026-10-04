Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D673B9D8B;
	Sun,  4 Oct 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132183; cv=none; b=gl2EsXokXVcuJ01cKjCLmKPJsENQtA7HK1kK+ZFg4lsCAWCaVlMivCqlLyQ/eSk5METu9hpNxL0xvpxOHm8NS01Kz9IFrtKY9Oe9vFFE/Tz2Gacen4GT/R2CFl74bkvhSpiljG/Gw/6a2BPnCZrgukVSEolsgK749KOmhH7/wKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132183; c=relaxed/simple;
	bh=MtkHO6GTB69JT/fj6X5jsDlzk1wXqDY8AKZXbqww99U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrPWcay3bnCGuXFVcTBQXblezpMnJ+qlnu481lsRkwvMTE7LGJiRDEO5KtJwimcc7/IP/iIZBvxkMn2gbxs1D/ude3NzAtFS66ys54WSjnRYw6jUJFIol/I4Y05QxNaiO+dyCHgTIfnIrrZdqJuBbv0MIAuKR9Lhjz0VLacXrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=VJd7OoAK; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="VJd7OoAK"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 62228E8387F;
	Sun, 04 Oct 2026 18:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791132178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygYzxNVjp+9QGOrNX6yRys2Zn5MJjg4tOJhkd7o7p0Y=;
	b=VJd7OoAK59b3P8T2xDlGXd7LAbcc4tNUNeE6QY0T/K2r5rEhhI/p9n8lj9/GLprmHUPQ2g
	QfmIF93LOmla8PyXd1WvGgk1eKAc46wuRJHzqGRC014jmjIKehleAUbKnBZxO3mFBUZT7v
	oCysEihEhf6IXlLfKsYuKMOn5CWbNCSKIwUhLdXrgg8vFWoffMJauQPuCqPtJ+beDuZxqB
	diSUv2KLWIudc9ttjo1t1hjti5vWPLt6nMaaChSH7gtWYC/5zfMP3IvyxRuvGreqEpklOu
	nMnAom/G8L188fCecEIsyHiMgrPMnXnfwE+cXrHMQ84rilvXbQMvHrcgFZyzGQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 0yRKH4Zx9e7R; Sun,  4 Oct 2026 18:42:58 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-55.ip.tng.de [86.103.67.55])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 18:42:57 +0200 (CEST)
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
Subject: [PATCH net-next v8 7/7] net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook
Date: Sun,  4 Oct 2026 18:42:19 +0200
Message-ID: <20261004164219.1161294-8-github@szelinsky.de>
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

From: Corey Leavitt <corey@leavitt.info>

fwnode_mdiobus_register_phy() resolved the `pses` phandle during PHY
registration and stashed the result in phydev->psec. With a modular PSE
controller driver that lookup returns -EPROBE_DEFER until the module is
loaded, so the MDIO bus owner - a MAC or a DSA switch - keeps bouncing
off deferred probe, registering and removing the PHY each time. On some
boards that shows up as a boot-time probe-retry storm and PHYs that
never stay registered.

Transfer ownership of phydev->psec to phylib and drive it from the PSE
controller lifecycle notifier instead:

  - On PSE_REGISTERED: walk mdio_bus_type and attach phydev->psec for
    every registered phy whose psec is still NULL. This is the "phy was
    enumerated before the PSE controller loaded" case, the root cause
    of the retry storm.

  - On PSE_UNREGISTERED: walk it again and release every phydev->psec
    that targets the departing controller, before pse_release_pis()
    frees pcdev->pi. Without this a phy still holding a reference would
    cause a use-after-free in __pse_control_release()'s
    pcdev->pi[psec->id] access.

  - phy_device_register() attaches once for a controller that is
    already registered. The phydev->psec check in phy_try_attach_pse()
    makes the two paths idempotent.

fwnode_find_pse_control() and its call site go away, and fwnode_mdio
drops the PSE header. No PSE-originated -EPROBE_DEFER leaves the MDIO
layer any more, so the retry storm is gone.

The attach now covers every phy registered with a DT node, not only
those registered through fwnode_mdiobus_register_phy(). A phy found by
mdiobus_scan() on a bus registered with plain mdiobus_register() gets
its node from of_mdiobus_link_mdiodev(), and a `pses` property there is
now honoured too.

The attach happens after device_add() has made the phy visible on
mdio_bus_type. Neither device_add() nor the attach that follows it may
take rtnl, for two reasons:

  - Binding a phy that itself provides an SFP cage reaches
    sfp_bus_add_upstream() via phy_probe() -> phy_setup_ports() ->
    phy_sfp_probe(), and that takes rtnl_lock(). Reported on RTL8214FC.

  - Some drivers register their MDIO bus from ndo_init - lantiq_etop
    via ltq_etop_init(), sni_ave via ave_init() - which
    register_netdevice() already calls under rtnl, and the bus
    registration reaches phy_device_register() from there
    (mdiobus_scan() for lantiq_etop, of_mdiobus_register_phy() for
    sni_ave).

phydev->psec is therefore serialised by a dedicated mutex, taken
through pse_phy_lock(). It lives in pse_core rather than phylib because
net/ethtool is always built into vmlinux while PHYLIB is tristate, so a
phylib export would be unresolved with CONFIG_PHYLIB=m or =n;
PSE_CONTROLLER is bool, so pse_core is always reachable. The notifier
walks change phydev->psec without rtnl, so the ethtool PSE paths take
the same mutex to keep a released handle from being dereferenced. Lock
order is rtnl -> pse_phy_mutex -> pse_list_mutex -> pcdev->lock.

phy_device_remove() releases phydev->psec synchronously, while the phy
is still on the bus. A phy that has been device_del()'d but is still
pinned - an attached netdev, or an SFP module phy waiting for
phy_device_free() - is off the mdio_bus_type klist and so invisible to
the PSE_UNREGISTERED walk, and a deferred release would then touch a
pcdev->pi[] the controller has already freed. Releasing before
device_del() means the walk and the release contend for the same mutex,
so whichever runs second sees NULL.

phydev->psec_detached closes two windows around that by telling
phy_try_attach_pse() to skip the phy. bus_for_each_dev() still reaches
a phy until bus_remove_device() takes it off the klist, well into
device_del(), so a PSE_REGISTERED walk could otherwise attach a fresh
handle just after the release, with nothing left to free it. The same
applies during registration: device_add() puts the phy on the bus
before its own later failure points, and its unwind takes it back off,
so a handle attached in that window would be missed by the
PSE_UNREGISTERED walk as well. The flag is therefore held until
registration has succeeded, and set again from phy_device_remove(). It
is a plain bool rather than another bit in the flags word: it is
written under pse_phy_lock(), while neighbours such as suspended and
sysfs_links are written under phydev->lock and rtnl, and a shared
storage unit would make those read-modify-write updates race.

A lookup error no longer fails anything. of_pse_control_get() reaches
the hardware - pse_pi_is_hw_enabled() calls pi_get_admin_state(), a bus
transaction on tps23881, si3474, pd692x0 and realtek-pse-mcu - and that
error used to propagate out of fwnode_mdiobus_register_phy() and fail
the whole MDIO bus registration. Now it leaves the port without PSE
until a controller registers again or the phy is re-registered, and is
reported with phydev_warn(). Because every PSE_REGISTERED walk retries
each phy that has no handle yet, a persistent error such as a
`#pse-cells` mismatch - which also trips the WARN_ON() in
of_pse_control_get() - is now reported again on each controller
registration rather than once.

-EPROBE_DEFER stays silent because the notifier retries it at
PSE_REGISTERED time, and the controller's vpwr supply check removes the
case where a registered controller keeps returning it for a provider
that has not appeared. It does not remove every source: the regulator
core still defers a supply whose provider is registered but not yet
bound. Such a PI is not retried until the next PSE_REGISTERED or a phy
re-registration.

The REGISTERED walk runs inside pse_controller_register(), so it
attaches handles part-way through the PSE driver's own probe. For a PI
the hardware already has powered, pse_control_get_internal() records
admin_state_enabled and takes the exclusive regulator. If that probe
then fails after registration - tps23881 requests its irq after
devm_pse_controller_register() - devres unwinds into the UNREGISTERED
walk, the last reference goes, and __pse_control_release() disables
the PI. A port that was up before the driver loaded is then powered
down when that driver fails to finish probing, the same as on a clean
unbind.

The UNREGISTERED walk does not help rmmod: pse_control_get_internal()
takes try_module_get(pcdev->owner) per handle, so while a phy holds one
the unload is refused before the module exit path runs. What the walk
covers is driver unbind and device removal, where
pse_controller_unregister() runs with the module loaded.

The walk relies on the teardown order pse_controller_unregister()
already has: the controller is off pse_controller_list and the
interrupt is off, so nothing new can reach the PI array; pcdev->pi and
the power domains are still live, which the release path needs because
dropping the last reference can disable a PI that is still energised;
and the notification worker is drained after the walk, both because
that release path can queue work and because the worker's transient
pse_control reference must not become the last one once the array has
been freed.

Now that the walk empties pcdev->pse_control_head on unregister, warn
if anything is still on it afterwards. Nothing can add one at that
point: the controller is off the list, the irq is off and the worker is
drained. It is quiet because of_pse_control_get() has a single caller
and the walk covers it, and it fires if a consumer that does not
subscribe is ever added. It could not be added earlier, while the
fwnode_mdio hook gave each matching phy a handle that nothing released
on controller unbind.

Reported-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Closes: https://lore.kernel.org/netdev/e00048dd-1ed3-40c3-9912-59bccf015ad5@gmail.com/
Reported-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Closes: https://lore.kernel.org/netdev/bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl/
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/netdev/20260703071025.100797-1-pabeni@redhat.com/
Signed-off-by: Corey Leavitt <corey@leavitt.info>
Co-developed-by: Carlo Szelinsky <github@szelinsky.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Tested-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/mdio/fwnode_mdio.c |  34 --------
 drivers/net/phy/phy_device.c   | 144 ++++++++++++++++++++++++++++++++-
 drivers/net/pse-pd/pse_core.c  |  68 ++++++++++++++++
 include/linux/phy.h            |   7 ++
 include/linux/pse-pd/pse.h     |  32 ++++++++
 net/ethtool/pse-pd.c           |  16 ++--
 6 files changed, 261 insertions(+), 40 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518265..7bd979b59f49 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -11,33 +11,11 @@
 #include <linux/fwnode_mdio.h>
 #include <linux/of.h>
 #include <linux/phy.h>
-#include <linux/pse-pd/pse.h>
 
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
 
-static struct pse_control *
-fwnode_find_pse_control(struct fwnode_handle *fwnode,
-			struct phy_device *phydev)
-{
-	struct pse_control *psec;
-	struct device_node *np;
-
-	if (!IS_ENABLED(CONFIG_PSE_CONTROLLER))
-		return NULL;
-
-	np = to_of_node(fwnode);
-	if (!np)
-		return NULL;
-
-	psec = of_pse_control_get(np, phydev);
-	if (PTR_ERR(psec) == -ENOENT)
-		return NULL;
-
-	return psec;
-}
-
 static struct mii_timestamper *
 fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 {
@@ -118,7 +96,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr)
 {
 	struct mii_timestamper *mii_ts = NULL;
-	struct pse_control *psec = NULL;
 	struct phy_device *phy;
 	bool is_c45;
 	u32 phy_id;
@@ -159,14 +136,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 			goto clean_phy;
 	}
 
-	psec = fwnode_find_pse_control(child, phy);
-	if (IS_ERR(psec)) {
-		rc = PTR_ERR(psec);
-		goto unregister_phy;
-	}
-
-	phy->psec = psec;
-
 	/* phy->mii_ts may already be defined by the PHY driver. A
 	 * mii_timestamper probed via the device tree will still have
 	 * precedence.
@@ -176,9 +145,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	return 0;
 
-unregister_phy:
-	if (is_acpi_node(child) || is_of_node(child))
-		phy_device_remove(phy);
 clean_phy:
 	phy_device_free(phy);
 clean_mii_ts:
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5b13a74e2fa9..497cf179398b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/netdevice.h>
+#include <linux/notifier.h>
 #include <linux/phy.h>
 #include <linux/phylib_stubs.h>
 #include <linux/phy_led_triggers.h>
@@ -1012,9 +1013,116 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 }
 EXPORT_SYMBOL(get_phy_device);
 
+/* Best-effort attach of phydev->psec from a DT `pses = <&...>` phandle.
+ * Caller must hold pse_phy_lock(). A missing phandle (-ENOENT) is silent,
+ * and so is -EPROBE_DEFER. That mostly means the controller is not
+ * registered yet, which the notifier retries at PSE_REGISTERED time, but
+ * a registered controller returns it too while its vpwr provider is
+ * registered and not yet bound, and that is not retried until the next
+ * PSE_REGISTERED. Anything else is warned about and left non-fatal, so
+ * the phy still registers - it is not necessarily a broken binding, it
+ * can equally be -ENOMEM or the PI already being held, and nothing
+ * retries it until the next PSE_REGISTERED.
+ *
+ * A phy with psec_detached set is skipped: it is either not registered yet
+ * or on its way out, and nothing would release a handle attached now.
+ */
+static void phy_try_attach_pse(struct phy_device *phydev)
+{
+	struct pse_control *psec;
+	struct device_node *np;
+
+	pse_phy_lock_assert_held();
+
+	np = phydev->mdio.dev.of_node;
+	if (!np)
+		return;
+
+	if (phydev->psec || phydev->psec_detached)
+		return;
+
+	psec = of_pse_control_get(np, phydev);
+	if (IS_ERR(psec)) {
+		if (PTR_ERR(psec) != -EPROBE_DEFER && PTR_ERR(psec) != -ENOENT)
+			phydev_warn(phydev, "failed to get PSE control: %pe\n",
+				    psec);
+		return;
+	}
+
+	phydev->psec = psec;
+}
+
+static int phy_pse_attach_one(struct device *dev, void *data)
+{
+	pse_phy_lock_assert_held();
+
+	if (dev->type != &mdio_bus_phy_type)
+		return 0;
+
+	phy_try_attach_pse(to_phy_device(dev));
+	return 0;
+}
+
+static int phy_pse_detach_one(struct device *dev, void *data)
+{
+	struct pse_controller_dev *pcdev = data;
+	struct phy_device *phydev;
+	struct pse_control *psec;
+
+	pse_phy_lock_assert_held();
+
+	if (dev->type != &mdio_bus_phy_type)
+		return 0;
+
+	phydev = to_phy_device(dev);
+	psec = phydev->psec;
+	if (!psec || !pse_control_matches_pcdev(psec, pcdev))
+		return 0;
+
+	phydev->psec = NULL;
+	pse_control_put(psec);
+	return 0;
+}
+
+static int phy_pse_notifier_event(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	switch (event) {
+	case PSE_REGISTERED:
+		pse_phy_lock();
+		bus_for_each_dev(&mdio_bus_type, NULL, NULL,
+				 phy_pse_attach_one);
+		pse_phy_unlock();
+		return NOTIFY_OK;
+	case PSE_UNREGISTERED:
+		pse_phy_lock();
+		bus_for_each_dev(&mdio_bus_type, NULL, data,
+				 phy_pse_detach_one);
+		pse_phy_unlock();
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block phy_pse_notifier __read_mostly = {
+	.notifier_call = phy_pse_notifier_event,
+};
+
 /**
  * phy_device_register - Register the phy device on the MDIO bus
  * @phydev: phy_device structure to be added to the MDIO bus
+ *
+ * phydev->psec is attached after device_add() has made the phy visible on
+ * mdio_bus_type, so that a concurrent PSE notifier walk and the attach can
+ * never leave the phy unattached. Neither step takes rtnl: keeping
+ * device_add() out of rtnl avoids deadlocking when binding a phy that itself
+ * provides an SFP cage (phy_probe() -> phy_sfp_probe() ->
+ * sfp_bus_add_upstream() takes rtnl), and pse_phy_lock() rather than rtnl
+ * guards the attach so a bus registered from ndo_init (which already holds
+ * rtnl) does not recurse on it.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 int phy_device_register(struct phy_device *phydev)
 {
@@ -1034,12 +1142,25 @@ int phy_device_register(struct phy_device *phydev)
 		goto out;
 	}
 
+	/* Keep the PSE_REGISTERED walk off this phy until registration has
+	 * actually succeeded. device_add() puts the phy on the bus before its
+	 * own later failure points, and its unwind takes it back off, so a
+	 * handle attached in that window would be missed by the
+	 * PSE_UNREGISTERED walk as well and left with no owner.
+	 */
+	phydev->psec_detached = true;
+
 	err = device_add(&phydev->mdio.dev);
 	if (err) {
 		phydev_err(phydev, "failed to add\n");
 		goto out;
 	}
 
+	pse_phy_lock();
+	phydev->psec_detached = false;
+	phy_try_attach_pse(phydev);
+	pse_phy_unlock();
+
 	return 0;
 
  out:
@@ -1061,8 +1182,22 @@ EXPORT_SYMBOL(phy_device_register);
  */
 void phy_device_remove(struct phy_device *phydev)
 {
+	struct pse_control *psec;
+
 	unregister_mii_timestamper(phydev->mii_ts);
-	pse_control_put(phydev->psec);
+
+	/* Detach synchronously, before the phy leaves the bus, so the put cannot
+	 * outlive the PSE controller: an off-bus but still-pinned phy is missed
+	 * by the PSE_UNREGISTERED walk. pse_phy_lock() serialises against that
+	 * walk, and psec_detached keeps the PSE_REGISTERED walk from attaching a
+	 * new handle in the window before device_del() takes the phy off the bus.
+	 */
+	pse_phy_lock();
+	psec = phydev->psec;
+	phydev->psec = NULL;
+	phydev->psec_detached = true;
+	pse_control_put(psec);
+	pse_phy_unlock();
 
 	device_del(&phydev->mdio.dev);
 
@@ -3976,8 +4111,14 @@ static int __init phy_init(void)
 	if (rc)
 		goto err_c45;
 
+	rc = pse_register_notifier(&phy_pse_notifier);
+	if (rc)
+		goto err_genphy;
+
 	return 0;
 
+err_genphy:
+	phy_driver_unregister(&genphy_driver);
 err_c45:
 	phy_driver_unregister(&genphy_c45_driver);
 err_ethtool_phy_ops:
@@ -3994,6 +4135,7 @@ static int __init phy_init(void)
 
 static void __exit phy_exit(void)
 {
+	pse_unregister_notifier(&phy_pse_notifier);
 	phy_driver_unregister(&genphy_c45_driver);
 	phy_driver_unregister(&genphy_driver);
 	rtnl_lock();
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index e560833ad034..bfa025e2194b 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -25,8 +25,55 @@ static LIST_HEAD(pse_controller_list);
 static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
 static DEFINE_MUTEX(pse_pw_d_mutex);
 
+/* Serialises phydev->psec against the PSE controller lifecycle notifier and
+ * the ethtool PSE paths, in place of rtnl. The attach must not take rtnl: an
+ * MDIO bus registered from ndo_init (e.g. lantiq_etop) calls
+ * phy_device_register() with rtnl already held, so taking rtnl for the attach
+ * would deadlock. It lives here rather than in phylib because PSE_CONTROLLER
+ * is bool, so pse_core is always built into vmlinux and net/ethtool can call
+ * these directly; phylib is tristate and must not be linked against from
+ * built-in code. Lock order: rtnl -> pse_phy_mutex -> pse_list_mutex ->
+ * pcdev->lock.
+ */
+static DEFINE_MUTEX(pse_phy_mutex);
+
 static BLOCKING_NOTIFIER_HEAD(pse_controller_notifier);
 
+/**
+ * pse_phy_lock - serialise access to phydev->psec
+ *
+ * Held by the PSE controller lifecycle notifier, by the phy attach and detach
+ * paths and by the ethtool PSE paths. The PSE_UNREGISTERED walk clears
+ * phydev->psec and drops the phy's reference under this lock, so anything that
+ * attaches, detaches or dereferences phydev->psec must hold it across the
+ * whole access.
+ */
+void pse_phy_lock(void)
+{
+	mutex_lock(&pse_phy_mutex);
+}
+EXPORT_SYMBOL_GPL(pse_phy_lock);
+
+/**
+ * pse_phy_unlock - release the lock taken by pse_phy_lock()
+ */
+void pse_phy_unlock(void)
+{
+	mutex_unlock(&pse_phy_mutex);
+}
+EXPORT_SYMBOL_GPL(pse_phy_unlock);
+
+#ifdef CONFIG_LOCKDEP
+/**
+ * pse_phy_lock_assert_held - assert that pse_phy_lock() is held
+ */
+void pse_phy_lock_assert_held(void)
+{
+	lockdep_assert_held(&pse_phy_mutex);
+}
+EXPORT_SYMBOL_GPL(pse_phy_lock_assert_held);
+#endif
+
 /**
  * pse_register_notifier - register a callback for PSE controller events
  * @nb: notifier block to register
@@ -1345,6 +1392,13 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 	 */
 	cancel_work_sync(&pcdev->ntf_work);
 
+	/* Every handle should be gone here: subscribers drop theirs in the
+	 * event above, and the worker's transient one goes with the drain.
+	 * The controller is off the list and the irq is off, so nothing can
+	 * add one. Anything left is a holder nobody accounted for.
+	 */
+	WARN_ON(!list_empty(&pcdev->pse_control_head));
+
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
@@ -2206,3 +2260,17 @@ bool pse_has_c33(struct pse_control *psec)
 	return psec->pcdev->types & ETHTOOL_PSE_C33;
 }
 EXPORT_SYMBOL_GPL(pse_has_c33);
+
+/**
+ * pse_control_matches_pcdev - Test whether a pse_control targets a controller
+ * @psec: pse_control obtained from of_pse_control_get()
+ * @pcdev: PSE controller to compare against
+ *
+ * Return: %true if @psec was obtained from @pcdev, %false otherwise.
+ */
+bool pse_control_matches_pcdev(struct pse_control *psec,
+			       struct pse_controller_dev *pcdev)
+{
+	return psec->pcdev == pcdev;
+}
+EXPORT_SYMBOL_GPL(pse_control_matches_pcdev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c5098a0dd6c..ef5b5e6f4e0f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -666,6 +666,12 @@ struct phy_oatc14_sqi_capability {
  * @master_slave_state: Current master/slave configuration
  * @mii_ts: Pointer to time stamper callbacks
  * @psec: Pointer to Power Sourcing Equipment control struct
+ * @psec_detached: Set while phylib will not accept a PSE handle for this
+ *	phy, either because registration has not completed or because it has
+ *	already released @psec, so the PSE_REGISTERED notifier walk skips it.
+ *	Not a bitfield: once the phy is on the bus it is written under
+ *	pse_phy_lock() while other flags are written under phydev->lock or
+ *	rtnl, and they must not share a storage unit
  * @ports: List of PHY ports structures
  * @n_ports: Number of ports currently attached to the PHY
  * @max_n_ports: Max number of ports this PHY can expose
@@ -807,6 +813,7 @@ struct phy_device {
 	struct net_device *attached_dev;
 	struct mii_timestamper *mii_ts;
 	struct pse_control *psec;
+	bool psec_detached;
 
 	struct list_head ports;
 	int n_ports;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index bc5d36bcd993..16181f8a2c97 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -386,9 +386,23 @@ int pse_ethtool_set_prio(struct pse_control *psec,
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
 
+bool pse_control_matches_pcdev(struct pse_control *psec,
+			       struct pse_controller_dev *pcdev);
+
 int pse_register_notifier(struct notifier_block *nb);
 int pse_unregister_notifier(struct notifier_block *nb);
 
+void pse_phy_lock(void);
+void pse_phy_unlock(void);
+
+#ifdef CONFIG_LOCKDEP
+void pse_phy_lock_assert_held(void);
+#else
+static inline void pse_phy_lock_assert_held(void)
+{
+}
+#endif
+
 #else
 
 static inline struct pse_control *of_pse_control_get(struct device_node *node,
@@ -439,6 +453,12 @@ static inline bool pse_has_c33(struct pse_control *psec)
 	return false;
 }
 
+static inline bool pse_control_matches_pcdev(struct pse_control *psec,
+					     struct pse_controller_dev *pcdev)
+{
+	return false;
+}
+
 static inline int pse_register_notifier(struct notifier_block *nb)
 {
 	return 0;
@@ -449,6 +469,18 @@ static inline int pse_unregister_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline void pse_phy_lock(void)
+{
+}
+
+static inline void pse_phy_unlock(void)
+{
+}
+
+static inline void pse_phy_lock_assert_held(void)
+{
+}
+
 #endif
 
 #endif
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 757c9e0cc856..654325946aaa 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -71,7 +71,9 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
+	pse_phy_lock();
 	ret = pse_get_pse_attributes(phydev, info->extack, data);
+	pse_phy_unlock();
 
 	ethnl_ops_complete(dev);
 
@@ -281,9 +283,12 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
+
+	pse_phy_lock();
+
 	ret = ethnl_set_pse_validate(phydev, info);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (tb[ETHTOOL_A_PSE_PRIO]) {
 		unsigned int prio;
@@ -291,7 +296,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		prio = nla_get_u32(tb[ETHTOOL_A_PSE_PRIO]);
 		ret = pse_ethtool_set_prio(phydev->psec, info->extack, prio);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
@@ -301,7 +306,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		ret = pse_ethtool_set_pw_limit(phydev->psec, info->extack,
 					       pw_limit);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* These values are already validated by the ethnl_pse_set_policy */
@@ -319,10 +324,11 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		 */
 		ret = pse_ethtool_set_config(phydev->psec, info->extack,
 					     &config);
-		if (ret)
-			return ret;
 	}
 
+out:
+	pse_phy_unlock();
+
 	/* Return errno or zero - PSE has no notification */
 	return ret;
 }
-- 
2.43.0

