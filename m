Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6178392831
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491608; cv=none; b=Vb+OWgK3d1H8OspHV0dPRRGWxh4H62Un/MBIteQY+wlkpT/zSOPMcqhPIF5sdV8b+U7QQwJJh8FSh9r6F6nhu84ZX7/SdsknHV6zFHPty82kvpOxwsSgZAHSnXsmEMCD9Y3u3UX+JkxQlMr4BYw+iIUYKgK6D3eoIDahpjxTjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491608; c=relaxed/simple;
	bh=GBpz6l7+Z3Df5rjgNHSdxutWswE+H1HM5BIWxhtC1w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVwymx3LDNIC2YW5adgk78GkU+QVMf0B3uKhou0kUijz2qsJfazd4+J01vrnsc+RSo9AYwSQlWW61sL/4tjt2z8xC4FxPlB9pVIhU2p5z7d5x+32HzzThe/8YcxOxBOZw/kpxziJSTsp0XfSm8Xm7/3x3rckIU0SbuBxBuxm2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVqy9+pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVqy9+pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A361F00A3D;
	Fri, 22 May 2026 23:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491606;
	bh=ugVM9BoiyRwyKDkW7yNKjdj56fBFzNxVCs5BnD9WW20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVqy9+peSAocR6JiXud8qezDWLX755rHMO3BKS1Yz6IyeMgE/PG9U50Itaq2FoBP4
	 cH/Qx6J0bKoUXN9bGe6ssEXl6+0yLR/n67txji/+HcgqNdbHbumlR3rVtKXrpcGTY3
	 dx/oMowHqnThYewlOqaAYsOTPaTRj/icTxo+OnNMusnRNsOI2LsT3iwr/6hZeLNNKW
	 9nff0f5hJbqk+E33ZlbC74uH3LHepuzJIqLojL0LOLlDLBDmU7Qn718FE+e59YHi7z
	 +zxWleRuT/KDYl2thYWz7AYVw/iEorbp7bZ/G5FdRTG9qLGTFmjJ7xi9jWZLfayAl+
	 ddp7v5EdZjj4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	petrm@nvidia.com,
	o.rempel@pengutronix.de,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 5/9] ethtool: module: fix cleanup if socket used for flashing multiple devices
Date: Fri, 22 May 2026 16:13:08 -0700
Message-ID: <20260522231312.1710836-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522231312.1710836-1-kuba@kernel.org>
References: <20260522231312.1710836-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a single Netlink socket issues MODULE_FW_FLASH_ACT against multiple
devices, ethnl_sock_priv_set() overwrites sk_priv->dev on each call,
retaining only the last one. The socket priv is used on socket close,
to walk the global work list and mark the uncompleted flashing work
as "orphaned". Otherwise if another socket reuses the PID it will
unexpectedly receive the flashing notifications.

Don't record the device, record net pointer instead. The purpose of
the dev is to scope the work to a netns, anyway. If we store netns
the overrides are safe/a nop since all flashed devices must be in
the same netns as the socket.

Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: danieller@nvidia.com
CC: petrm@nvidia.com
---
 net/ethtool/netlink.h | 4 ++--
 net/ethtool/module.c  | 9 ++++-----
 net/ethtool/netlink.c | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index aaf6f2468768..fd2198e45d2b 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -318,12 +318,12 @@ enum ethnl_sock_type {
 };
 
 struct ethnl_sock_priv {
-	struct net_device *dev;
+	struct net *net;
 	u32 portid;
 	enum ethnl_sock_type type;
 };
 
-int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
+int ethnl_sock_priv_set(struct sk_buff *skb, struct net *net, u32 portid,
 			enum ethnl_sock_type type);
 
 /**
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 5b49004ddf60..ea4fb2a76650 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -291,11 +291,9 @@ void ethnl_module_fw_flash_sock_destroy(struct ethnl_sock_priv *sk_priv)
 
 	spin_lock(&module_fw_flash_work_list_lock);
 	list_for_each_entry(work, &module_fw_flash_work_list, list) {
-		if (work->fw_update.dev == sk_priv->dev &&
-		    work->fw_update.ntf_params.portid == sk_priv->portid) {
+		if (work->fw_update.ntf_params.portid == sk_priv->portid &&
+		    dev_net(work->fw_update.dev) == sk_priv->net)
 			work->fw_update.ntf_params.closed_sock = true;
-			break;
-		}
 	}
 	spin_unlock(&module_fw_flash_work_list_lock);
 }
@@ -332,7 +330,8 @@ module_flash_fw_schedule(struct net_device *dev, const char *file_name,
 	fw_update->ntf_params.seq = info->snd_seq;
 	fw_update->ntf_params.closed_sock = false;
 
-	err = ethnl_sock_priv_set(skb, dev, fw_update->ntf_params.portid,
+	err = ethnl_sock_priv_set(skb, dev_net(dev),
+				  fw_update->ntf_params.portid,
 				  ETHTOOL_SOCK_TYPE_MODULE_FW_FLASH);
 	if (err < 0)
 		goto err_release_firmware;
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 5046023a30b1..7d45f9a884e5 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -53,7 +53,7 @@ const struct nla_policy ethnl_header_policy_phy_stats[] = {
 	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
 };
 
-int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
+int ethnl_sock_priv_set(struct sk_buff *skb, struct net *net, u32 portid,
 			enum ethnl_sock_type type)
 {
 	struct ethnl_sock_priv *sk_priv;
@@ -62,7 +62,7 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
 	if (IS_ERR(sk_priv))
 		return PTR_ERR(sk_priv);
 
-	sk_priv->dev = dev;
+	sk_priv->net = net;
 	sk_priv->portid = portid;
 	sk_priv->type = type;
 
-- 
2.54.0

