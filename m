Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6336F91C;
	Fri,  3 Jul 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064818; cv=none; b=bJrm2oZAyYx73Mosd5FiNGVAXa/tk4gbGA5n4kXQuglbDHbLEgOYzXhsyeQbrSr6D0J8e8nFWx87+0xsuDye5+yEUgcLirTRuB15YUMgJvmAZ1yqM0GVA6yoyAj2HSJQWyGg7RJhiXxJiFmelUc08aaBJ3Qa0OzYETtAtuq1rWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064818; c=relaxed/simple;
	bh=RXxSh/FGF5UpQa8qPhHB2OrfpyHQf69zOk19WKUZpzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RA/97ZjTALfVdM+iWDnRIPCd9lOb8Bcn1HIgka0s15ELjj4ZctaQk9HU0swF8NggVDdh5RWq5sWQlWE8sc/4Bx0M34ugl10Cm1O2fWkHFdmv09gsJKQ6bF9d/2uFCfhxbfea6N9NZ3LcfM45PnAqfUqyIhVMSvliF77AF+bdDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=CLY3XlJR; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="CLY3XlJR"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 8246E60C04;
	Fri,  3 Jul 2026 03:46:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064816; bh=GJ3dvXaLB65xqU1Iw7DaqR5dOmnVhFaN89ELpZtqWL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CLY3XlJRgr2k7N/5S74t5UiBaiOE7GknSfCHXJR1JqTTfRLVq/2IquOuz13d2VImV
	 bDT8dV2kx7fyHac4nyfE2CoRVlHct2BpjFxsnodzipZrfPy40S8Tx8398yRVGnzUr+
	 UjgSq+1F6h83+Lw75Ce/6a9ihf3l5LjZFT5Q1H21+bo3wM9s/OjM8VnZ9qBMXkjLtI
	 uro1WMSHGaF7UGouPJLAwfTnQ5OGho19PGd4m0x325qFrVwbgxid41S5AnAO4JT2gs
	 wpih5jDsNxb1SVwMcBs2Iatj0Vcfitru7llO1KRO7wwbSXimQ5uXpAwvrxWFWtw9br
	 3luZklhTb7aDA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:37 +1000
Subject: [PATCH net-next 03/17] net: dsa: tag_dsa: Add helper to add DSA
 header to RMU frame
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-3-991a27d78bca@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=2212;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=aY1brdWS5/OK/25Pu3Z67vYSWACothxkbztRv8/38Jw=;
 b=VSFZigYDmu3E58WX6QNaaJpmR9b0ATPWXxIilC4VTfbclxDpcuUDsp0haE45lWtF6qkU2JPK5
 oSE7ZezLGUgAvkGaGjW60uf72LcazZCvGvSpB5M5Ex33ih9uCIlUHew
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

From: Andrew Lunn <andrew@lunn.ch>

A RMU frame sent to the switch needs a DSA header. Add a helper to the
tag driver to add such a header to an skbuff, and provide access to
the helper via the tagger data structure. This keeps most of the
details of the DSA header in the tag driver.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/dsa/mv88e6xxx.h |  3 +++
 net/dsa/tag_dsa.c             | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/dsa/mv88e6xxx.h b/include/linux/dsa/mv88e6xxx.h
index 1e9460d6f7782..74a885b3bc4cb 100644
--- a/include/linux/dsa/mv88e6xxx.h
+++ b/include/linux/dsa/mv88e6xxx.h
@@ -13,6 +13,9 @@ struct dsa_tagger_data {
 	void (*rmu_frame2reg)(struct dsa_switch *ds,
 			      struct sk_buff *skb,
 			      u8 seqno);
+	/* Add DSA header to frame to be sent to switch */
+	void (*rmu_reg2frame)(struct dsa_switch *ds,
+			      struct sk_buff *skb);
 };
 
 #define MV88E6XXX_VID_STANDALONE	0
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index 5a95873e87340..a23c3279c49bd 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -341,6 +341,29 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 	return skb;
 }
 
+static void dsa_rmu_reg2frame(struct dsa_switch *ds,
+			      struct sk_buff *skb)
+{
+	enum dsa_cmd cmd = DSA_CMD_FROM_CPU;
+	u8 tag_dev = ds->index;
+	u8 *dsa_header;
+
+	dsa_header = skb_push(skb, DSA_HLEN);
+	dsa_header[0] = (cmd << 6) | tag_dev;
+	dsa_header[1] = BIT(1) | 0x3e << 2;
+	dsa_header[2] = 6 << 5 | 0xf;
+	dsa_header[3] = 0; /* Sequence number is filled in later */
+
+	if (ds->dst->tag_ops->proto == DSA_TAG_PROTO_EDSA) {
+		u8 *edsa_header = skb_push(skb, 4);
+
+		edsa_header[0] = (ETH_P_EDSA >> 8) & 0xff;
+		edsa_header[1] = ETH_P_EDSA & 0xff;
+		edsa_header[2] = 0x00;
+		edsa_header[3] = 0x00;
+	}
+}
+
 static int dsa_tag_connect(struct dsa_switch *ds)
 {
 	struct dsa_tagger_data *tagger_data;
@@ -349,6 +372,7 @@ static int dsa_tag_connect(struct dsa_switch *ds)
 	if (!tagger_data)
 		return -ENOMEM;
 
+	tagger_data->rmu_reg2frame = dsa_rmu_reg2frame;
 	ds->tagger_data = tagger_data;
 
 	return 0;

-- 
2.43.0

