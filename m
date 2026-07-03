Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382C3546FF;
	Fri,  3 Jul 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064846; cv=none; b=O/MHOp7Qj0JSGPxLdT6rg7KsDnCN9t20bFN7I8cr18DtMCdGY/VSu2eDOFyYUmmS9+vwdrDmsSm4J4QoxaOUIAWHWf4+Cdn169YnbEDmSzY7NAhIQtyas/i+bbxK5c6HyO20XJlc70Peb82f8Vc3MF4WMlgix9y+EY2VsIOEEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064846; c=relaxed/simple;
	bh=rHqweq0CwiyzOhkY2treR0Z+SiSzYiKHhfoy27S2zPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I8IyaJiJ1cyKpHfkEjttUMP/wRnLz/bjp8tFSPxJecWNk6TMeYKGrK9Y6mRqOBoyFE1ID9lLSZ4MGy4fr0HWBIRU/wNGo6tgDS2EFKFdjAG1oYLSIMudTyrvV4gQVrcPUveAohUdAaSynwqzGNYd+6U8Pwk4xm5m1OdR+dv+GOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=TRB9rMSU; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="TRB9rMSU"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id D316960C04;
	Fri,  3 Jul 2026 03:47:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064843; bh=4q3DokfFU+uqx8Lm1URlkC6fhCe/+EG7Om2eYq7Sk2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TRB9rMSU7jvkCYpXez62QYTqNV23PFLG5ygSeVDz2sh0aiNMi3s2+0KMBcmABWWUj
	 o+szN9rKYb4hx0tzSAqKFf+IUgWH3IQI6t1xAOPbL2AAVu4oO0B9jk8ZJWqSwNzQZa
	 2z1rca0FkXPHH3aEdLcHD1iVBffOlQd9CbvJwQsLHa+XlJG56EYuRmW3kAPjFkrlzf
	 rD0rbI91PJ7uZyqXbVx+MSGcYMwsSIo60V934OYfLx/asD+xjEJjwLO0SyGleYraMa
	 TqpvGpEJrXyWky1YKr795IsXXxvXtM5KlN487HZ9Ac8q6fOY6pxL24IFKcojy3rdee
	 rZBREwVEb1ktg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:43 +1000
Subject: [PATCH net-next 09/17] net: dsa: mv88e6xxx: Get Product ID when
 enabling RMU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-9-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=8397;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=DXdCJ+i+DZyk+zxSfsDPsCvmwMxH0gP6tyJZMinCU3o=;
 b=asyTOEZeWKByc5ZKIOKqdGnhbcABPq3xGI4pfuuG/3HDmvlwZt1S3TsSuDlenDHXNNtdZg5jj
 4GYgOx5RotIA/4TTDWiuLASTKb1e6P8U8Sz+01EWypbbSmeK1y43z89
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

From: Andrew Lunn <andrew@lunn.ch>

When the RMU is enabled, it is recommended to get the product ID,
which identifies the switch. This is used as a test that communication
with the switch actually works and the RMU can be used. If successful,
mark the RMU usable.

This completes the general infrastructure to send a request and
process the response.

Co-developed: Mattias Forsblad <mattias.forsblad@gmail.com>
Signed-off-by: Mattias Forsblad <mattias.forsblad@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  10 +++
 drivers/net/dsa/mv88e6xxx/rmu.c  | 151 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/rmu.h  |  11 +++
 3 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 940ae698659fc..07300c25cbd36 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -346,6 +346,15 @@ struct mv88e6xxx_tcam {
 	struct list_head entries;
 };
 
+enum mv88e6xxx_rmu_state {
+	MV88E6XXX_RMU_DISABLED = 0,
+	MV88E6XXX_RMU_ENABLED = 1,
+	/* Reserved: a future RMU-only mode (e.g. MV88E6XXX_RMU_ONLY_ENABLED)
+	 * may be added here to indicate a switch operating purely via RMU
+	 * without an MDIO bus.
+	 */
+};
+
 struct mv88e6xxx_chip {
 	const struct mv88e6xxx_info *info;
 
@@ -461,6 +470,7 @@ struct mv88e6xxx_chip {
 	/* Remote Management Unit state. */
 	struct net_device *rmu_conduit;
 	struct dsa_inband rmu_inband;
+	enum mv88e6xxx_rmu_state rmu_state;
 };
 
 #define TCAM_MATCH_SIZE 96
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
index 49d67d512fb0f..65e6bcf4ca938 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.c
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -6,11 +6,143 @@
  *
  */
 
+#include <linux/dsa/mv88e6xxx.h>
 #include <net/dsa.h>
 #include "chip.h"
 #include "global1.h"
 #include "rmu.h"
 
+static const u8 mv88e6xxx_rmu_dest_addr[ETH_ALEN] = {
+	0x01, 0x50, 0x43, 0x00, 0x00, 0x00
+};
+
+static void mv88e6xxx_rmu_create_l2(struct dsa_switch *ds,
+				    struct net_device *conduit,
+				    struct sk_buff *skb,
+				    bool edsa)
+{
+	struct dsa_tagger_data *tagger_data = ds->tagger_data;
+	struct ethhdr *eth;
+	u8 *header;
+
+	/* Create RMU L2 header. */
+	header = skb_push(skb, 2);
+	/* Two bytes of EtherType, which is ignored by the switch */
+	header[0] = 0;
+	header[1] = 0;
+
+	/* Ask tagger to add {E}DSA header */
+	tagger_data->rmu_reg2frame(ds, skb);
+
+	/* Insert RMU MAC destination address */
+	eth = skb_push(skb, ETH_ALEN * 2);
+	memcpy(eth->h_dest, mv88e6xxx_rmu_dest_addr, ETH_ALEN);
+	ether_addr_copy(eth->h_source, conduit->dev_addr);
+	skb_reset_network_header(skb);
+}
+
+static void mv88e6xxx_rmu_fill_seqno(struct sk_buff *skb, u32 seqno, int offset)
+{
+	u8 *dsa_header = skb->data + offset;
+
+	dsa_header[3] = seqno;
+}
+
+/* 2 MAC address, 2 byte Ethertype, 2 bytes padding, to DSA header */
+static void mv88e6xxx_rmu_fill_seqno_edsa(struct sk_buff *skb, u32 seqno)
+{
+	mv88e6xxx_rmu_fill_seqno(skb, seqno, ETH_ALEN * 2 + 2 + 2);
+}
+
+/* 2 MAC address, to DSA header */
+static void mv88e6xxx_rmu_fill_seqno_dsa(struct sk_buff *skb, u32 seqno)
+{
+	mv88e6xxx_rmu_fill_seqno(skb, seqno, ETH_ALEN * 2);
+}
+
+static int mv88e6xxx_rmu_request(struct mv88e6xxx_chip *chip,
+				 const void *req, int req_len,
+				 void *resp, unsigned int resp_len,
+				 int timeout_ms)
+{
+	struct net_device *conduit;
+	struct sk_buff *skb;
+	unsigned char *data;
+	bool edsa;
+
+	/* Capture conduit once: it can be cleared concurrently when the
+	 * conduit goes down (e.g. during reboot). Also guard against the
+	 * conduit being torn down out from under us, in which case its
+	 * dev_addr may already have been released.
+	 */
+	conduit = READ_ONCE(chip->rmu_conduit);
+	if (unlikely(!conduit || !conduit->dev_addr)) {
+		dev_err_ratelimited(chip->dev, "RMU: conduit device unavailable");
+		return -EINVAL;
+	}
+
+	skb = dev_alloc_skb(req_len + EDSA_HLEN + 2 * ETH_ALEN + 2);
+	if (!skb)
+		return -ENOMEM;
+
+	/* Insert RMU request message */
+	data = skb_put(skb, req_len);
+	memcpy(data, req, req_len);
+
+	edsa = chip->tag_protocol == DSA_TAG_PROTO_EDSA;
+
+	if (!chip->ds->tagger_data) {
+		kfree_skb(skb);
+		return -EOPNOTSUPP; /* can happen on teardown */
+	}
+
+	mv88e6xxx_rmu_create_l2(chip->ds, conduit, skb, edsa);
+	skb->dev = conduit;
+
+	return dsa_inband_request(&chip->rmu_inband, skb,
+				  (edsa ? mv88e6xxx_rmu_fill_seqno_edsa :
+				   mv88e6xxx_rmu_fill_seqno_dsa),
+				  resp, resp_len, timeout_ms);
+}
+
+static int mv88e6xxx_rmu_get_id(struct mv88e6xxx_chip *chip)
+{
+	const __be16 req[4] = {
+		MV88E6XXX_RMU_REQ_FORMAT_GET_ID,
+		MV88E6XXX_RMU_REQ_PAD,
+		MV88E6XXX_RMU_REQ_CODE_GET_ID,
+		MV88E6XXX_RMU_REQ_DATA};
+	struct mv88e6xxx_rmu_header resp;
+	int resp_len;
+	int ret = -1;
+
+	resp_len = sizeof(resp);
+	ret = mv88e6xxx_rmu_request(chip, req, sizeof(req),
+				    &resp, resp_len,
+				    MV88E6XXX_RMU_REQUEST_TIMEOUT_MS);
+	if (ret < 0) {
+		dev_dbg(chip->dev, "RMU: error for command GET_ID %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	if (ret < resp_len) {
+		dev_err(chip->dev, "RMU: GET_ID returned wrong length: rx %d expecting %d\n",
+			ret, resp_len);
+		return -EPROTO;
+	}
+
+	if (resp.code != MV88E6XXX_RMU_RESP_CODE_GOT_ID) {
+		dev_dbg(chip->dev, "RMU: GET_ID returned wrong code %d\n",
+			be16_to_cpu(resp.code));
+		return -EPROTO;
+	}
+
+	dev_dbg(chip->dev, "RMU: product ID %4x\n", be16_to_cpu(resp.prodnr));
+
+	return 0;
+}
+
 void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 					const struct net_device *conduit,
 					bool operational)
@@ -37,11 +169,22 @@ void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 
 		WRITE_ONCE(chip->rmu_conduit, (struct net_device *)conduit);
 
-		dev_dbg(chip->dev, "RMU: Enabled on port %d", port);
+		/* Get the device ID to prove that the RMU works */
+		ret = mv88e6xxx_rmu_get_id(chip);
+		if (ret < 0) {
+			dev_err(chip->dev, "RMU: initialization check failed %pe",
+				ERR_PTR(ret));
+			goto out;
+		}
+		chip->rmu_state = MV88E6XXX_RMU_ENABLED;
+
+		dev_info(chip->dev, "RMU: enabled on port %d via conduit device %s",
+			 port, chip->rmu_conduit->name);
 	} else {
 		if (chip->info->ops->rmu_disable)
 			chip->info->ops->rmu_disable(chip);
 
+		chip->rmu_state = MV88E6XXX_RMU_DISABLED;
 		WRITE_ONCE(chip->rmu_conduit, NULL);
 	}
 
@@ -58,6 +201,8 @@ void mv88e6xxx_rmu_frame2reg_handler(struct dsa_switch *ds,
 	struct net_device *conduit;
 	unsigned char *ethhdr;
 	u8 expected_seqno;
+	int resp_len;
+	int err = 0;
 
 	/* Check received destination MAC is the conduit MAC address */
 	conduit = READ_ONCE(chip->rmu_conduit);
@@ -86,13 +231,15 @@ void mv88e6xxx_rmu_frame2reg_handler(struct dsa_switch *ds,
 	}
 
 	rmu_header = (struct mv88e6xxx_rmu_header *)(skb->data + 4);
+	resp_len = skb->len - 4;
 	if (rmu_header->format != MV88E6XXX_RMU_RESP_FORMAT_1 &&
 	    rmu_header->format != MV88E6XXX_RMU_RESP_FORMAT_2) {
 		dev_dbg_ratelimited(ds->dev, "RMU: invalid format: rx %d\n",
 				    be16_to_cpu(rmu_header->format));
-		goto drop;
+		err = -EPROTO;
 	}
 
+	dsa_inband_complete(&chip->rmu_inband, rmu_header, resp_len, err);
 drop:
 	return;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.h b/drivers/net/dsa/mv88e6xxx/rmu.h
index 69cd3c2636f3d..a81af5a1ad762 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.h
+++ b/drivers/net/dsa/mv88e6xxx/rmu.h
@@ -9,9 +9,20 @@
 #ifndef _MV88E6XXX_RMU_H_
 #define _MV88E6XXX_RMU_H_
 
+#define MV88E6XXX_RMU_WAIT_TIME_MS		20
+#define MV88E6XXX_RMU_REQUEST_TIMEOUT_MS	50
+
+#define MV88E6XXX_RMU_REQ_FORMAT_GET_ID		htons(0x0000)
+#define MV88E6XXX_RMU_REQ_FORMAT_SOHO		htons(0x0001)
+#define MV88E6XXX_RMU_REQ_PAD			htons(0x0000)
+#define MV88E6XXX_RMU_REQ_CODE_GET_ID		htons(0x0000)
+#define MV88E6XXX_RMU_REQ_DATA			htons(0x0000)
+
 #define MV88E6XXX_RMU_RESP_FORMAT_1		htons(0x0001)
 #define MV88E6XXX_RMU_RESP_FORMAT_2		htons(0x0002)
 
+#define MV88E6XXX_RMU_RESP_CODE_GOT_ID		htons(0x0000)
+
 struct mv88e6xxx_rmu_header {
 	__be16 format;
 	__be16 prodnr;

-- 
2.43.0

