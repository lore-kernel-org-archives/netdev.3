Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAA3EFFBD
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787414005; cv=none; b=GKsqv+QPeyih4DHIYLXTYxq5ITDTPy4oUAHi/T5BYGik8t9d6eBFXND8sY7JSVEYdE95SVjOMUaIVZ4+8zXFq6quVFDzRXczNMn3qDliKyTJRWbM7fBAdI6I14zMZcrH9etM0CvD9gN//yVoZIcrcR7+Nco+dDN4OLYYMGF6dFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787414005; c=relaxed/simple;
	bh=dZIHWtcFQLBecZAhEuwWGEx82qTtwRuHcNk7vLDZ0H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oV+gS9hyPqqRfAbtkUnYSEHblpYrFeB4qfCgDEWPDDbGBfxd1ltw0ES2P+VTQNjcFvMxCFwZohsLzv87dMl13jj9a9vfA9m9JXAw513GuWqtYWX+maQiEFcrJGPF2wZHxQx0F+LLu7seqN+UbNRBeNkpUtNaOXAjTDc3ubUwta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=BAE2U5YA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="BAE2U5YA"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a3fda88184so3311149a12.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787413992; x=1788018792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7sx3EpEYcOkpXa9JzxMZLwohk3KOOS93sfAyPQWLR+Q=;
        b=BAE2U5YAKdkXQeBxmoX0BzzQUnvnjhgDQykZ5ZdSSvuq+0zh1cQnuMXqAbacrI44I0
         HtsDHIYDVq810B60ErpnBVL2hhRev+DNMOQcG0JSvpZtF0NL7ectoWU2Z5Gmr46vJKUc
         SUzXZZlkc1hHPdMFynXaWI7x8zK0rRuvnUERcpFAwh+qMEAUjK6xRYx4xAJdLos6F6XS
         UmVwTlupk4/7gNVQarjuyybXNwdFxs3yQvKK14aUFHRqUaMnhZK1gcOAbfjddQP4GE2T
         NVj8QECxoh8ODYd9hVKD7LdABsmoSbhB5Ht8Z6Uynqw7m/4bmEn+llps2sR/L1+zlwXA
         /+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787413992; x=1788018792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7sx3EpEYcOkpXa9JzxMZLwohk3KOOS93sfAyPQWLR+Q=;
        b=Z+ssM5oXnwnDDkXXeL+8mhL0Ku5TuNE2+R1tWRXTvanNqGlOGGe+nhqxy7BSZHdF/O
         2OQxbQ3oEpqmIbZIsgr+PdULGPKluVPCh5eANU/nnnNPx9Dtg8DQto8wb9A2rnTszPRo
         3LIzpSpsL7Su92ehIZfmC1dtVYpJTjjGV0Rmy2ZiNQn8PuHZnjdjxqpO5AxsDBERwlQ4
         Kc7ZF/ccIrh1Ha1Mar6bQbB2Wy+zUM8qT/s9NRM2OGbMaDmJn7Ly1VxGHslDcA9QE58C
         wl+ZkWp6A7lyh6KT0ig1oWBVzQjZ2EJdlsc21Z6gygpJ+qsTgv0fOZVt6pNhDz44Rkmj
         0umQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkP/tW2b75DrVz6ncl4Tl7wrkFdwGxHOQhRZWK07t3YqvIbH0ywXNgsJ0SaK9VLJUAe9TEWG8=@vger.kernel.org
X-Gm-Message-State: AFuF++nclH4q3pM1qSCdX5vuradxbqlall+YtDTsqYoR0TGJFnUawTem
	HEPRnObRz3pQDntIXzcqoY2IGH69Sv3VY+PQbK4AfbJO54spKw3VSF8f0mwOqpw74mw=
X-Gm-Gg: AR+sD10VnJFGnH39TylmcJwiujICwSjLEnnbhYs3GTtrFP6Gs7Pdb4ZR+T1/BULOb4G
	cQOYw+daMlTPem4UG9yDAbz4plK+xIczpxn2Z8hAPK1SGj1rgpl/5XnlY2VY9BHkNECBVASSWvn
	jks+pWZ3retTSCqPKniJsYaOHk6CxXP24FJPVKrEAAnRmEHbPbFY11ru2CQ2C+Sc6MmL/KR5ciE
	B2gsDjEej9y/wi2D7jagV/o+qupIWZJKK7nOQaSZx2/fwL/aqkyO1ZepRLS8M7tABxTSaYjTWGE
	HIHxIzaMwV68O28sbHJcRsVe5LnZz7hqfIsndDBuQFE3TAYI4nbwYWmvlgX++4WUlEVoAqvdIbU
	ansx4QOnPLRy84E+ZF2wd9xbUs4xIUDNb90af0zdqMreUIcaBdURZdUhoGFhdQ9RycLpwZBZ6Yc
	3US7BzencjN5i5+BtEBlKEmhWbXA6wXzlx7NFLp3Jx+f2zN6UIzpfnmSwARfLcLK30eTPVcQ==
X-Received: by 2002:a05:6402:1f02:b0:6a1:28d8:2306 with SMTP id 4fb4d7f45d1cf-6a42f0f7c19mr16106289a12.1.1787413991910;
        Sat, 22 Aug 2026 08:53:11 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c546sm12396250a12.21.2026.08.22.08.53.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 08:53:11 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next 3/3] net: dsa: connect a late-arriving PHY at ifup
Date: Sat, 22 Aug 2026 18:52:59 +0300
Message-ID: <20260822155259.87146-4-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822155259.87146-1-f@lex.la>
References: <20260822155259.87146-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY whose driver loads firmware at probe has no driver bound while
that module still sits in an unmounted rootfs. phy_attach_direct()
falls back to the generic driver, whose feature set lacks the modes the
port is wired for, and the port is dropped for the rest of the uptime:

  mt7530-mdio mdio-bus:1f lan4: validation of 2500base-x [...] failed: -EINVAL
  mt7530-mdio mdio-bus:1f lan4: error -22 setting up PHY for tree 0, switch 0, port 5

The same PHY wired to a MAC on the same SoC comes up. The difference is
when the connect happens: the MAC driver connects from ndo_open, DSA
connects during setup, at 1.9 s, before any rootfs exists.

Keep the port when the connect fails on a PHY that has no driver of its
own, and connect it from the open path instead, ahead of enabling the
port, so a port in MLO_AN_PHY mode is never started without a PHY. A
PHY whose driver bound in the meantime connects normally.

Deferring the switch probe instead does not converge. Every retry
re-runs the port setup and flaps the other user ports. Measured on an
MT7981B board at two deadlines: the probe gave up at 22.2 s and the
module arrived at 27.6 s with a 20 s deadline, 47.3 s and 52.7 s with a
45 s one. Arrival tracks the deadline at a constant offset, so raising
the deadline moves the target with it. The module is loaded by
userspace, and userspace is what the retries keep from running. The
hotplug traffic each retry generates is the suspected mechanism; that
part was not measured.

Building the PHY driver into the kernel does not help either. It loads
firmware with request_firmware_direct(), which does not fall back to
the usermode helper, and passes the error straight out of probe rather
than -EPROBE_DEFER, so a built-in driver fails once against the
unmounted rootfs and is never retried. Baking the blobs in through
CONFIG_EXTRA_FIRMWARE puts 144 KiB into every kernel built from that
configuration. That call belongs to whoever configures the kernel.

The driverless check races the driver arrival itself: the module can
bind between the failed connect and the check reading the driver
pointer. That failed attempt ran with the generic driver bound and
says nothing about the driver present now, so the connect is retried
once, and only for a PHY that had no driver when the attempt started.
A port whose PHY was bound all along keeps its single attempt, so no
port pays a second attach, reset toggle and validation warning for a
window it can never be in.

The predicate covers every PHY named in the port's description that the
generic driver serves, including ones that are not waiting for a
module. A port whose PHY cannot satisfy the configured phy-mode is
registered now instead of being dropped at setup, and each ifup on it
fails with a warning. Each failed ifup binds the generic driver,
re-reads its abilities over MDIO and releases it again. That cycle used
to run once at setup; on such a port it now runs per attempt, and a PHY
that declares a reset line sees it toggled each time.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Why not the existing phy_detach() path

phy_detach() already releases the generic driver so a real one can bind
later, and the obvious question is why DSA cannot use it. It is not
reachable here. dsa_port_setup_as_unused() never creates a netdevice
for the port, so there is no ndo_open to hook and no detach to trigger.
Turning that into create-then-detach is a larger and riskier change
than keeping the port and retrying the connect that already exists.

Why the check reads mdio.dev.driver and not phy_driver_is_genphy()

The flag behind that helper is set in phy_attach_direct() and cleared
in phy_detach(), which the failed connect has already run by the time
DSA looks, so it reads false on exactly the ports this patch is for.
Sampling before the connect does not work either: nothing is bound to
any PHY at that point, so the check would match every port. Reading
the bound driver from DSA is a reach into the device model. If that is
the wrong layer, a small phylib accessor fits here and I can add one.

Relation to earlier attempts

The 2021 RFC "Make the PHY library stop being so greedy when binding
the generic PHY driver" went at the same problem class from the phylib
side, adding device_pending_probe() so phy_attach_direct() could hold
off on the generic driver while a specific driver's probe was still
pending. It was turned down as belonging in the driver core rather
than in phylib, and nothing equivalent has landed since. This patch
stays out of that argument: it touches neither probe deferral nor
driver matching, and changes only what DSA does with a connect that
already failed.

The phy_port work does not cover this case. It represents port
topology and runs from phy_probe(), after a driver is bound; the
decision this patch depends on happens earlier, in the fallback inside
phy_attach_direct().

Blast radius

Ports whose PHY has a driver at setup time never take the new path.
Their connect succeeds and the branch is not reached.

A port kept across a failed connect is what makes patch 1 of this
series necessary: without it the failed bringup leaves a pointer to a
detached PHY behind, and the teardown of a port that was never opened
would detach that PHY a second time.

The retry doubles the connect attempt on ports that fail with a driver
already bound, including ports that end up dropped anyway. Each
attempt is a full attach/detach cycle, so the reset line is toggled
once more and phylink prints its validation warning twice.

phylink_bringup_phy() requests the PHY interrupt only after validation
succeeds. On a board whose interrupt description is wrong, that
description stays dormant as long as the connect always fails, and
goes live the moment this patch makes the connect work. The patch is
the trigger there, not the cause. Patch 2 of this series is what makes
a correct description survive to that point at all.

Testing

MT7981B board, mt7530 switch, Airoha EN8811H on port 5, driver in a
module on the rootfs. Without the patch the port is dropped at 1.9 s
and stays gone. With it the port survives setup, the PHY driver binds
at 6.3 s, and the port attaches it and joins the bridge on the first
ifup at 16.9 s. Boot time is unchanged, and the late connect leaves
the phylink instances of the other ports alone.

The retry taken when a driver binds during the failed connect closes
a window of microseconds; it cannot be exercised deliberately on
hardware and is compile-tested, as is this patch on net-next. The
hardware testing was done on a 6.18 backport carrying everything here
except that retry.
 net/dsa/user.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c..0cdc1c9b1 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -397,6 +397,49 @@ void dsa_user_host_uc_uninstall(struct net_device *dev)
 		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
 }
 
+/* Returns the port's PHY node with a reference taken, or NULL if the port has
+ * no PHY node. Looks at the same properties as phylink_fwnode_phy_connect().
+ */
+static struct fwnode_handle *dsa_user_phy_fwnode(const struct dsa_port *dp)
+{
+	struct fwnode_handle *phy_fwnode;
+
+	phy_fwnode = fwnode_get_phy_node(of_fwnode_handle(dp->dn));
+
+	return IS_ERR(phy_fwnode) ? NULL : phy_fwnode;
+}
+
+/* Connect a PHY that dsa_user_phy_setup() left behind because it had no
+ * driver of its own back then. Runs before the port is enabled, so that a
+ * port in MLO_AN_PHY mode is not started without its PHY.
+ */
+static int dsa_user_late_phy_connect(struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct fwnode_handle *phy_fwnode;
+	struct dsa_switch *ds = dp->ds;
+	u32 phy_flags = 0;
+	int err;
+
+	if (dev->phydev)
+		return 0;
+
+	phy_fwnode = dsa_user_phy_fwnode(dp);
+	if (!phy_fwnode)
+		return 0;
+
+	fwnode_handle_put(phy_fwnode);
+
+	if (ds->ops->get_phy_flags)
+		phy_flags = ds->ops->get_phy_flags(ds, dp->index);
+
+	err = phylink_of_phy_connect(dp->pl, dp->dn, phy_flags);
+	if (err)
+		netdev_warn(dev, "could not connect PHY: %pe\n", ERR_PTR(err));
+
+	return err;
+}
+
 static int dsa_user_open(struct net_device *dev)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
@@ -413,6 +456,10 @@ static int dsa_user_open(struct net_device *dev)
 	if (err)
 		goto out;
 
+	err = dsa_user_late_phy_connect(dev);
+	if (err)
+		goto out_del_host_uc;
+
 	err = dsa_port_enable_rt(dp, dev->phydev);
 	if (err)
 		goto out_del_host_uc;
@@ -2651,11 +2698,37 @@ static int dsa_user_phy_connect(struct net_device *user_dev, int addr,
 	return phylink_connect_phy(dp->pl, user_dev->phydev);
 }
 
+/* Whether the port's PHY is served by the generic driver rather than by one
+ * of its own. Only meaningful after a failed connect, which releases the
+ * generic driver again.
+ */
+static bool dsa_user_phy_lacks_driver(const struct dsa_port *dp)
+{
+	struct fwnode_handle *phy_fwnode;
+	struct phy_device *phydev;
+	bool lacks_driver;
+
+	phy_fwnode = dsa_user_phy_fwnode(dp);
+	if (!phy_fwnode)
+		return false;
+
+	phydev = fwnode_phy_find_device(phy_fwnode);
+	fwnode_handle_put(phy_fwnode);
+	if (!phydev)
+		return false;
+
+	lacks_driver = !READ_ONCE(phydev->mdio.dev.driver);
+	put_device(&phydev->mdio.dev);
+
+	return lacks_driver;
+}
+
 static int dsa_user_phy_setup(struct net_device *user_dev)
 {
 	struct dsa_port *dp = dsa_user_to_port(user_dev);
 	struct device_node *port_dn = dp->dn;
 	struct dsa_switch *ds = dp->ds;
+	bool had_driver, retried = false;
 	u32 phy_flags = 0;
 	int ret;
 
@@ -2678,6 +2751,8 @@ static int dsa_user_phy_setup(struct net_device *user_dev)
 	if (ds->ops->get_phy_flags)
 		phy_flags = ds->ops->get_phy_flags(ds, dp->index);
 
+	had_driver = !dsa_user_phy_lacks_driver(dp);
+connect:
 	ret = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
 	if (ret == -ENODEV && ds->user_mii_bus) {
 		/* We could not connect to a designated PHY or SFP, so try to
@@ -2686,6 +2761,29 @@ static int dsa_user_phy_setup(struct net_device *user_dev)
 		ret = dsa_user_phy_connect(user_dev, dp->index, phy_flags);
 	}
 	if (ret) {
+		if (dsa_user_phy_lacks_driver(dp)) {
+			/* Not known to be reachable from the internal MDIO bus
+			 * fallback, which assigns user_dev->phydev before it
+			 * connects, but do not hand the open path a leftover.
+			 */
+			user_dev->phydev = NULL;
+
+			netdev_info(user_dev,
+				    "PHY has no driver, connecting it at open\n");
+			return 0;
+		}
+
+		/* A driver that was not there before this attempt is one that
+		 * bound while it ran: the failure came from the generic driver
+		 * and says nothing about this one, so try once more. A port
+		 * that had its driver all along keeps the single attempt.
+		 */
+		if (!had_driver && !retried) {
+			had_driver = true;
+			retried = true;
+			goto connect;
+		}
+
 		netdev_err(user_dev, "failed to connect to PHY: %pe\n",
 			   ERR_PTR(ret));
 		dsa_port_phylink_destroy(dp);
-- 
2.43.0

