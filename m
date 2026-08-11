Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04212368D45;
	Tue, 11 Aug 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448757; cv=none; b=PK7jKfI3GUJDGIgYZossRt/H/YT+X5g0Iy1lXDfUvnKx2D6ygktKmxCA+6ydRjJTTvJMuPc2xy/8oj5ynSuQKAHkYbxM+F+1+NHn1jqF/8pt9UJdURJ2ahD76Kqbf94AYLNUn5HMjigms1iEFQVKLKrPMcl/JyOrgB6ul3KZ8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448757; c=relaxed/simple;
	bh=bL+dw7nZ4smpe5+bHljStvN1ejOmLM/lXKfbhLG7gMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPIaFp+QrV75wxc1K1UilyGBvCfurDQING+md/LK5lbe9hrAaAh0m18IknCT9rAF/GwNnQtzzihSIAmxsHWQ5N1yy7axn8uVDFosmOB2rxHtqqcGOUChoaqeBM1yKH8Zy2yCXLqOfu5qFHgtgeksXpjuVJXkjkZIwha/TWxY5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4MD9SMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4MD9SMG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA03AC2BCFA;
	Tue, 11 Aug 2026 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786448756;
	bh=bL+dw7nZ4smpe5+bHljStvN1ejOmLM/lXKfbhLG7gMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s4MD9SMGqMktRS8kt2K6Q22Fs1wZX4Hy/rURQ6hhjNVNqe1mPGU4sd0N1d6adXkXe
	 uW0i3EpyuWxDSm83JbEnxN3jzQYAj0wVnqn7l3sX18dLhejmN5fhVH/1OwGOV5/c8Q
	 x7JDKtGeDg45EmqyB4DaTumfsYEvSf9Q+adu3chb9pYzJmFY6Q4aT3UrD7q7QA2uy3
	 e+lLJwe8EaMLLDP5NBqCNeZ6j7KWNHlBHk3QFNzrUyAZngglfIzie/pcy8zvtoty1G
	 0Jf9uPWqf0npKAgqNYjB6A9SmPTDU9F6PAhe7Q41OgV7zer7QfI1jC6E/0Hl766G0V
	 cIvf9lXbu/FGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B122C5CFC1;
	Tue, 11 Aug 2026 11:45:56 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Tue, 11 Aug 2026 13:45:48 +0200
Subject: [PATCH net-next v8 2/3] net: dsa: mv88e6xxx: use the hw tx queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-net-next-mv88e6xxx-cbs-v8-2-10d0baab2905@luminex.be>
References: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
In-Reply-To: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786448754; l=11508;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=+d3GarFIv+8jgYa2BdKPESoxgq5Xh3C5c/F3WWG67NU=;
 b=udc3HLmCyDMr4KResFzuYujzL8yzPf3vWnbzj9Hu+TUguPoWm4X7LKg1iKYSIwsKHNFAc5h/e
 HLY0K5L1vdKBPeNNyCdZiuloEX6BNTw8x2UsWHS757pR5CzLDPmiUc5
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be

From: Cedric Jehasse <cedric.jehasse@luminex.be>

When transmitting fill in the PRI field in the dsa tag to select the
egress queue is sent to.
From the datasheets i've looked at these switches have 4 or 8 transmit
queues per port.
Note: skbs with skb->offload_fwd_mark set use the DSA_CMD_FORWARD
tag. These are processed as normal ingress frames, meaning the queue
they end up in can still be altered by other switch config. eg. priority
overrides, tcam policies.
This isn't done for vlan tagged frames because this would overwrite the
PCP value in the vlan tag (The PRI field in the dsa
tag is used as the PCP value in the vlan tag).

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 net/dsa/tag_dsa.c                | 11 ++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..47e531f24e5f2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3990,6 +3990,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 
 	chip->ds = ds;
 	ds->user_mii_bus = mv88e6xxx_default_mdio_bus(chip);
+	ds->num_tx_queues = chip->info->num_tx_queues;
 
 	/* Since virtual bridges are mapped in the PVT, the number we support
 	 * depends on the physical switch topology. We need to let DSA figure
@@ -5706,6 +5707,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		 */
 		.num_ports = 7,
 		.num_internal_phys = 2,
+		.num_tx_queues = 4,
 		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),
 		.max_vid = 4095,
 		.port_base_addr = 0x8,
@@ -5728,6 +5730,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 64,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -5750,6 +5753,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 10,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5774,6 +5778,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 11,
 		.num_internal_phys = 0,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
@@ -5795,6 +5800,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 11,
 		.num_internal_phys = 8,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5820,6 +5826,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 1024,
 		.num_ports = 3,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5845,6 +5852,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 8,
 		.num_internal_phys = 0,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
@@ -5867,6 +5875,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 6,
 		.num_internal_phys = 5,
 		.num_gpio = 11,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5892,6 +5901,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 1024,
 		.num_ports = 6,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5918,6 +5928,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 6,
 		.num_internal_phys = 0,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5943,6 +5954,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5969,6 +5981,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5994,6 +6007,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6020,6 +6034,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6045,6 +6060,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 10,
 		.num_internal_phys = 0,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
@@ -6068,6 +6084,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6093,6 +6110,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6117,6 +6135,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 16384,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6142,6 +6161,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.internal_phys_offset = 1,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6168,6 +6188,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 8,
 		.num_tcam_entries = 256,
 		.internal_phys_offset = 1,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6198,6 +6219,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 2,
 		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -6222,6 +6244,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6247,6 +6270,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 64,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -6271,6 +6295,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6299,6 +6324,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 2,
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6327,6 +6353,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 2,
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6354,6 +6381,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_ports = 6,
 		.num_gpio = 11,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6380,6 +6408,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6405,6 +6434,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6431,6 +6461,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6459,6 +6490,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.invalid_port_mask = BIT(1) | BIT(2) | BIT(8),
 		.num_internal_phys = 5,
 		.internal_phys_offset = 3,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6485,6 +6517,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6512,6 +6545,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6538,6 +6572,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.internal_phys_offset = 1,
 		.max_vid = 8191,
 		.max_sid = 63,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index f4894bdc21ba8..3a1d79a117dca 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -136,6 +136,7 @@ struct mv88e6xxx_info {
 	unsigned int num_internal_phys;
 	unsigned int num_gpio;
 	unsigned int num_tcam_entries;
+	unsigned int num_tx_queues;
 	unsigned int max_vid;
 	unsigned int max_sid;
 	unsigned int port_base_addr;
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index d5ffee35fbb53..2bb71cd343e79 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -179,8 +179,17 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 			dsa_header[2] &= ~0x10;
 		}
 	} else {
+		u16 queue = skb_get_queue_mapping(skb) & 0x7;
 		u16 vid;
 
+		/* The PRI field is 3 bits. According to the documentation the
+		 * 2 highest bits specify the egress queue in From_CPU DSA
+		 * tagged frames. On devices with 8 queues it's possible to
+		 * send to the 8 queues, which means the 3 bits are used.
+		 */
+		if (dp->ds->num_tx_queues == 4)
+			queue <<= 1;
+
 		vid = br_dev ? MV88E6XXX_VID_BRIDGED : MV88E6XXX_VID_STANDALONE;
 
 		skb_push(skb, DSA_HLEN + extra);
@@ -191,7 +200,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 
 		dsa_header[0] = (cmd << 6) | tag_dev;
 		dsa_header[1] = tag_port << 3;
-		dsa_header[2] = vid >> 8;
+		dsa_header[2] = (queue << 5) | vid >> 8;
 		dsa_header[3] = vid & 0xff;
 	}
 

-- 
2.43.0


