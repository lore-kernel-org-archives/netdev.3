Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497619;
	b=fws/aWRXDc2ZxWZz2JCztxa0WkFUTYn0Tk6euyzILQI+aZfW2k4GA5/al59zLfwEh5YB
	 C1ZMbfQCLQWYnEVbapKpF9BnLI9VjpDe1Y0FytmdwsIkiZ8pZdj3EaTmboqJSvOiJVvYL
	 NR3XQGOoxav8xO56bk3BoyOLoYpKWdi/x21nQTkqNxycdP++kk/Oa4wrTL9bmD1XVDuVG
	 i9ZZy1apUwd+7MYztz3DCnOx92aDVUf9X7zmE93caAUaO3ruMziDfJsOUOVsE4j4o2gwY
	 Xp1Qo4PV6NNZFjDD0lmZ8ipsh17wpVN7lUJA+D9TxXe0JYZYodFL0H+zHoFDKtxDgNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p+LcMtXkYJFxrrRpSU30o1iHuZmxD+UW9aeN6zEXvqE=;
	b=NS2fkQAMQb+lucy23G/siwN7w/2hAR5yGEWWAE8WFm4FnFrl0wiAiAFnxQgec8i7735G
	 zxXol/E8K1onjWlJO5wtZnsXq2RI3S8MMFQ5EKdvyk3rPqZ3skUks1OxwpKucy+w4u0Tp
	 Rc5RlDXYnjejMQib5l41nGKnzJzK/WXDIUiqZLAEp11BEpPz4CL+S8H6clmHp5uOOPVVL
	 JVXUPcsXcHTexzQrvdxjYGGqme2EZRzRQSW+TujxaMVy0l9IHzDVx7ZBNQ81DbpgNODGo
	 BM84yRJM9mN7FJuo0ibId/6/4mDrKAJHpCOV3TY+9fjPxHtjVHXKM7IiSfLfciUI/og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MFqta4Vw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAF606A881
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DAAF606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MFqta4Vw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso5125235e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497618; x=1795102418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+LcMtXkYJFxrrRpSU30o1iHuZmxD+UW9aeN6zEXvqE=;
        b=MFqta4VwxR+E9iahrgxAuhn8pUai+bvJy8Vgeebb23TKSSnV/4SSrnUoYczRI/tBj0
         yqtLc/6M2u3ixrP+fBt8sVxiEq+CqEWk1oPK07vrCsRvZxguJq82sDxMw+Q978AKQz3o
         6ZoncKO8MQErw5zKUlpnbdwwf0B8BzoAeceapc5KgmMxBgyfpOcgbhNjDEkNycKIM3yt
         lxSFZN5rlDsOdUGeLbaGzF917/UzaW1dwRj0yJlkC32pSCAQF3MfM4MDwWepdEu8iQ38
         mIaMIshHiib23TKmFXtUy8+pYZKh7C1wTR5t3dsF32sA9VUNNawHqBk6qyNsISbuvO4y
         uXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497618; x=1795102418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+LcMtXkYJFxrrRpSU30o1iHuZmxD+UW9aeN6zEXvqE=;
        b=MjnQk9qLArqnxsQKyOSeGPgXB6rSZ208bw/IiRWAyoHYK5y3eePt5PoCZ5gkAB4/k0
         /hFYg4siZ3efX4gzn3wdsEWzjZQsA/KLo0PELRWHrEliL1yCrMHmczxjF0UNq3pXxQ+a
         78lJ3VLjWVN4VxJqVxMEP6YhiJEHj/KMK71KjsJZzX7M8+1oBbT2sUSLYn9F44oT9en3
         Y5mRDFthaLp71v4XKIlNSoZt9MxDYJRJi0iQiABI6R7WPQeUXgNXq1otmtPXbgUsGkfO
         qtsXLWggzWmfT0wsIPAJd1tdU4IMzMpb52zUyVXto2oN+ibSi4kjwgJr1DeMpBeLihIb
         j/2w==
X-Gm-Message-State: APuU4Z87KJd56JTbPGnxbexErWXerGf0Jz3jsdPClqYfWnB6ph93ccgh
	6Ny1/QqqNTgU2++J4NnDoEH+8TscPbIkT2cX+JnMX03Dy1a5lXHYGNSe8cVu6Olx
X-Gm-Gg: AYBFou2P3aIBcgUgj0pm5+erSA0PEKM7GAvkj5zvtORAtWXkfw7zD5SSBTdJdLqY2DC
	Bwz5lx9TWli0oy/k2xfw8jErQJg+n6mXrhpR2DquSFIVonU7kBHJNWw3Adc6e9ziP/K0Kp7S9ax
	FWO3g35LrGUfP6mj7qq2aebNi/6H9etosnDAG7q3alcVC7nztiFYTWS1Lxhyw08ILxwR5qJrRsP
	6pTZjY6stNIaeaPkWQbI8TOq4ACxm+3toZJGS80UUtTePlBPoRdUV5dkYN8fpGttYmaUR8AeULe
	KGtYDXTyPq+4GtOHxt5fNpTi/5qcTiKM0TfJ6Aq9HBOt9HtFykK17iLp1+b/14k1y2gVn2x2FUs
	+QRkF27Cgzkzb2R+DXpa/6hT5ha5jQ+rSx095QoSQq2I1T0/Px9UznF0YIaOjR2HzhT4LiFn/L3
	bbNjdas7WMLTv56liXnF5IosmT2LOv2snwUay1cVuLKbRkESC7iQevHPrbXxYzjN+wNIu2iO2aA
	rApFsyzeja092jopovH1zVGoSPdXzFud1ph7/o8UYJ438T3N+719zDRZyD/khlXUrjlD6rA4YfG
	7o7j9TutpbMfMMbU8QUqfcwi2xLbimHooxbleDdJ7b4MDt+ZeD27Fk1eOKKdM6FiOhRY32p2mFg
	BN0mcUe2xCUrGyBfp7+kwwg6q9M7UC7kh94c2E+6xzd/X4mkgzR1Ax5sa0KNWkDd4Vc1nCgW2yq
	nKrO13fiWt
X-Received: by 2002:a05:600d:8448:b0:4a1:e015:6441 with SMTP id 5b1f17b1804b1-4ba091a59aamr89080845e9.0.1794497617706;
        Thu, 12 Nov 2026 07:33:37 -0800 (PST)
Received: from L-022584.energy.envision.com (dynamic-093-130-172-139.93.130.pool.telefonica.de. [93.130.172.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08ddbe68sm229331185e9.0.2026.11.12.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:33:37 -0800 (PST)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	xiexinet@gmail.com,
	lukma@denx.de,
	fmancera@suse.de,
	danishanwar@ti.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net v9 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
Date: Thu, 12 Nov 2026 16:33:30 +0100
Message-ID: <20261112153333.20-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112153333.20-1-xiexinet@gmail.com>
References: <20261112153333.20-1-xiexinet@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR and PRP tag and de-duplicate each wire frame separately. GRO on a
member device merges several frames into one skb that cannot get valid
per-frame metadata, and userspace can turn GRO back on at any time.

Mark direct members (slave A/B, interlink) with a kernel role bit.
While it is set, __netdev_update_features() drops software GRO and
configurable GRO_HW from wanted_features as well as from the computed
features, before ndo_fix_features(). GRO_HW that the driver keeps on
is left alone. The request has to go too: veth adds and deletes its
NAPI instances according to wanted_features, so with GRO still
requested, closing an attached veth spins in napi_disable(), and
detaching a veth that was attached while down and then brought up hits
the BUG_ON() in napi_enable(). As for LRO disabled by an upper device,
GRO is not restored when the port leaves; ethtool can turn it back on.
The rule covers every direct member, PRP ports and ports with HSR
offload included: one simple rule is preferred to per-port exceptions,
at some cost in receive throughput.

The attach fails if software GRO stays active. A failed attach does
not restore the GRO request either. The next patch checks all ports
before any of them is changed, so only a failure at run time, for
example a driver that cannot turn GRO off or the upper device nesting
limit (-EMLINK), leaves a port with its GRO request dropped.
GSO skbs can still arrive, for example from a stacked member whose
lower device runs GRO; a later patch segments them.

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  8 +++
 net/core/dev.c                                | 15 ++++++
 net/hsr/hsr_slave.c                           | 54 +++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 8eceaa80b686..0d87e4d92a58 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -169,6 +169,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
+unsigned_long:1                     hsr_port
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
 struct udp_tunnel_nic_info*         udp_tunnel_nic_info
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 435be7880d7e..0d13c7ecdd1f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2110,6 +2110,7 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@hsr_port:	direct HSR/PRP member (slave A/B or interlink)
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2531,6 +2532,13 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	/* Direct HSR/PRP member: slave A/B or interlink. While set,
+	 * software GRO and configurable GRO_HW are dropped from the
+	 * request and before ndo_fix_features(); GRO_HW that the driver
+	 * keeps on is left alone. Kernel role state only; no user ABI or
+	 * offload capability.
+	 */
+	unsigned long		hsr_port:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index df1a840b0334..c8c2de212556 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11269,6 +11269,21 @@ int __netdev_update_features(struct net_device *dev)
 
 	features = netdev_get_wanted_features(dev);
 
+	/* A direct HSR/PRP port needs per-frame metadata. Drop software
+	 * GRO and configurable GRO_HW from the request as well as from the
+	 * features passed to ndo_fix_features(), as the core does for
+	 * upper-disabled features: drivers such as veth derive state from
+	 * wanted_features and need the requested and the active bit to
+	 * agree. Fixed-on or driver-required GRO_HW is left to the driver.
+	 */
+	if (dev->hsr_port) {
+		netdev_features_t gro = NETIF_F_GRO |
+					(dev->hw_features & NETIF_F_GRO_HW);
+
+		dev->wanted_features &= ~gro;
+		features &= ~gro;
+	}
+
 	if (dev->netdev_ops->ndo_fix_features)
 		features = dev->netdev_ops->ndo_fix_features(dev, features);
 
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index a546f70f9cc8..b7765a4bb992 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -11,6 +11,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_arp.h>
 #include <linux/if_vlan.h>
+#include <net/netdev_lock.h>
 #include "hsr_main.h"
 #include "hsr_device.h"
 #include "hsr_forward.h"
@@ -137,6 +138,37 @@ static int hsr_check_dev_ok(struct net_device *dev,
 	return 0;
 }
 
+/* Member role and feature policy.
+ * Setting the role makes __netdev_update_features() clear GRO
+ * and configurable GRO_HW from the request and before
+ * ndo_fix_features(). A macvlan follows GRO on its lower device,
+ * which can turn it back on later. Only the role and feature
+ * update run under the device ops lock; unlink, promiscuous
+ * updates and the master recompute stay outside.
+ */
+static void hsr_portdev_role_set(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	dev->hsr_port = true;
+	netdev_change_features(dev);
+	netdev_unlock_ops(dev);
+}
+
+static void hsr_portdev_role_clear(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	dev->hsr_port = false;
+	/* Recompute features without the role. GRO was dropped from
+	 * the request while the role was set and is not requested
+	 * again; the user can turn it back on with ethtool. A dying
+	 * device just drops the role, a netns move stays registered and
+	 * is recomputed.
+	 */
+	if (dev->reg_state == NETREG_REGISTERED)
+		netdev_change_features(dev);
+	netdev_unlock_ops(dev);
+}
+
 /* Setup device to be added to the HSR bridge. */
 static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 			     struct hsr_port *port,
@@ -169,6 +201,22 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	if (res)
 		goto fail_upper_dev_link;
 
+	/* Enable the member role and recompute before the RX handler
+	 * is published, so that software GRO on this device is off
+	 * before frames can arrive. This covers the direct member
+	 * only: a stacked member receives from a lower device that
+	 * may still run GRO and can deliver merged frames as GSO skbs.
+	 * A still-active software GRO rejects the port, a remaining
+	 * GRO_HW alone does not.
+	 */
+	hsr_portdev_role_set(dev);
+	if (dev->features & NETIF_F_GRO) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "software GRO still on after feature update, cannot join");
+		res = -EBUSY;
+		goto fail_role_policy;
+	}
+
 	res = netdev_rx_handler_register(dev, hsr_handle_frame, port);
 	if (res)
 		goto fail_rx_handler;
@@ -177,7 +225,12 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	return 0;
 
 fail_rx_handler:
+fail_role_policy:
+	/* Rollback order: unlink the upper, clear the role and
+	 * recompute, then undo this setup's promiscuous increment.
+	 */
 	netdev_upper_dev_unlink(dev, hsr_dev);
+	hsr_portdev_role_clear(dev);
 fail_upper_dev_link:
 	if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
 		dev_set_promiscuity(dev, -1);
@@ -248,6 +301,7 @@ void hsr_del_port(struct hsr_port *port)
 		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
 			vlan_vids_del_by_dev(port->dev, master->dev);
 		netdev_upper_dev_unlink(port->dev, master->dev);
+		hsr_portdev_role_clear(port->dev);
 		if (hsr->prot_version == PRP_V1 &&
 		    port->type == HSR_PT_SLAVE_B) {
 			eth_hw_addr_set(port->dev, port->original_macaddress);
-- 
2.53.0

