Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570F3803F4
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739200; cv=none; b=BEcegEK51QoftDEuf5+/Sox138ynWRraXa1BtRCKnafdJCcEpL4kwC83OtmdHalJJbWSsjQ/jXxSdkx3mOPFoRKGvkBN0LTnUW7k15EWASWeh5DnfdHDyuX7uZok4PF5VxdYoUNsCW/o6cpmp8myko3Zcdke8vf1YGKxB39Kh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739200; c=relaxed/simple;
	bh=TJLOSsXrUic9FAQ3aWSz7VKwUFuzOGeQo+r0jZdR/wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lvidiGxgHm1jRcgLEr2PgmzlfKimGBI65VYW9mB/2Fl5o4465u7Wd0V+0R6Xq9OFOF/oL42cdJbg634LVNuED6nmS5L5ANsgBSIfQeh3Sn3yxqjvJQcieH7bd2XNQNzxZDdjRY9YtStSJO4302NNwRVc9+SuUobd7E8Ggbrzo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nus/85k7; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nus/85k7"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so4448196c88.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 20:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790739190; x=1791343990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z5k7G2kLkYevUaZy+2ENCxK2AUYKBP2e2jNeXEWSJH8=;
        b=Nus/85k7++99Hd8LqeYeVFZXzfazaASjrKjIxKCjcyHjniKVf3nwiI2Cv2wEX+OYwj
         3WRzNoudiPwNtZCKOGSKwB/7Ly2BDgnWq3Du+BAgXDjha7HJYY2C2gh3nRMFDbHKtfOe
         VRgXSyrchESXPcH14cJD4JliOQ7C4zqWGXzPWCfCJPhe4Zl4RkF+qDPWZ3BYkJT+ulsn
         JBd4P24NuJKBudFXnm0af9vNNUlaSlhMpj5oTKc9hyXVjD+eGwM4z0qFlUaeEvJf+OR0
         YY/PHvK4vzKnuLk8oK6OKaT49N72ryi3cCuRKpA0o++4mGdPxDOthanSa/WgQRvVF4zg
         XSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790739190; x=1791343990;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z5k7G2kLkYevUaZy+2ENCxK2AUYKBP2e2jNeXEWSJH8=;
        b=aiTIn1eVpl8xWHHHmwesf4ZcBYgM6K98e83/8PZ5ecJUVjlEXyZkHDPdCF7NAuKHTh
         NnHAhsAd2LwAQoggk/R7RvY2HDnffeGcYIdjoBZ7ok58msuOSdbuH+BD0WYnqDMISSVp
         bBRWI27mw1aGzyr5TzthkG5441ceQyjh/y+9Wotd5m0sUW65qu0+c7Ta8dMnewi4h7qF
         oGAv0yiSE9GdKpJq/8c+X/Z7BOC/me5ruSPQ7uKCtkdZHJ5PsjD6pDZlLtW4MF+ABSID
         bxSNK/5PqtxJHmqR33vSx76ICpSaUpsL1HryJjhqhMPU4YBQMPQHo3WKXSmqPOkMT0TQ
         3Jiw==
X-Gm-Message-State: AFuF++ns67/vuWejp70n4bAcQjVLcIWZeEoR7s1h8dxIwOjekAh+RgCO
	5dPNuHWh146ZnCWgMXVqBYCxtxUQhdNazi07P4VHw+UH4Prxe+7DyKp9tQTF6A==
X-Gm-Gg: AYBFou19jPln1RgKrG6+Ls8f/ivZypkugzM0LFCxpV0fX6q69RDpUESjGeU6mEBnwA0
	zzoSj3arh2OWlJyEAYVPvqiLAlOnKwRva5FmNNRaNyGUDnQpd3IzqVCOsbqAa735XaMyu5oGX2b
	L0B8x3eAbAizVsq8ozGnWo3fB1nNfJjFtO+K1qP3P2BROeMU/3U73sKIYu7RMj5w5ELBx3hulPl
	fKXHrQeuN8hXqwvSx5u4NtRF6OR44WAJMGCCB4dq8MFNHT8XCaHhlOvhnt7HY+ENR74bkPpo8WL
	k7fARWUytPGmrjMaXnzcelUfI3YqczHWmZ1nOhfdTRgQcMtb4EouCILRD9yYo7WsYu+Mw5XTc5d
	Vo2CYQtCDZECCkivROhMinipZEm6toBl1X339Pg3jsM5aNr8er85uqp6W4xVREPxjX0D8F1/q5b
	tjQGAUCtxxFUYA7MwF5M1SSctzGYd8b88e5RqQ57TMsfTU+7eV6V94N88D1NpLLP78cqU7ZbZIh
	FEy1mDl4vjOrDI0r2DdPpZ2NDJ1A0wiw39MnOUr9EJbu+0I8vT6L1zFbjC6f8AX0u5BX1isY63d
	YJVSHAipWOBhQnmV/CQzxLvnBzNnl9lWUVFqCq4=
X-Received: by 2002:a05:701b:280a:b0:143:271a:308 with SMTP id a92af1059eb24-14c9fdbf774mr1394103c88.46.1790739190026;
        Tue, 29 Sep 2026 20:33:10 -0700 (PDT)
Received: from cp-amitesh-Precision-5690.. ([2402:e280:411f:685:bb4e:8bc5:3754:5034])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5b3ea3csm162933eec.23.2026.09.29.20.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:33:09 -0700 (PDT)
From: Amitesh Singh <singh.amitesh@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Amitesh Singh <singh.amitesh@gmail.com>
Subject: [PATCH v2] net: dsa: push hwaccel VLAN tag into payload in dsa_user_xmit()
Date: Wed, 30 Sep 2026 09:02:39 +0530
Message-ID: <20260930033239.57093-1-singh.amitesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a socket buffer has a hardware-accelerated VLAN tag (skb->vlan_tci
set), the conduit NIC inserts the 802.1Q header after whatever the DSA
tagger prepends, producing the wrong on-wire ordering:

  [tagger header][802.1Q VID]

instead of the correct:

  [802.1Q VID][tagger header]    (for taggers that follow the VLAN)
  [tagger header][802.1Q VID]    (for taggers that precede the VLAN — broken)

This affects any platform where tx-vlan-offload is enabled or fixed:on
and cannot be disabled (e.g. imx-dwmac). tag_rtl8_4 and tag_sja1105
both carried open-coded workarounds for this; rather than let each new
tagger rediscover the problem, handle it once in dsa_user_xmit() before
the skb is handed to any tagger.

__vlan_hwaccel_push_inside() frees the skb internally on allocation
failure, so returning NETDEV_TX_OK on NULL is correct. Remove the
now-redundant per-tagger copies from tag_rtl8_4.c and tag_sja1105.c.

Note: tag_lan9303.c is unaffected. Its xmit path never inspects
skb->vlan_tci — it always writes its own fixed [8100 | port_index]
header regardless. The skb_vlan_tag_present() call in lan9303_rcv is
on the RX path, which this change does not touch.

Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
---
 net/dsa/tag_sja1105.c | 10 ----------
 net/dsa/user.c        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index bfe1f746f55b..57bb9360f9d2 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -244,16 +244,6 @@ static struct sk_buff *sja1105_pvid_tag_control_pkt(struct dsa_port *dp,
 	__be16 xmit_tpid = htons(sja1105_xmit_tpid(dp));
 	struct vlan_ethhdr *hdr;
 
-	/* If VLAN tag is in hwaccel area, move it to the payload
-	 * to deal with both cases uniformly and to ensure that
-	 * the VLANs are added in the right order.
-	 */
-	if (unlikely(skb_vlan_tag_present(skb))) {
-		skb = __vlan_hwaccel_push_inside(skb);
-		if (!skb)
-			return NULL;
-	}
-
 	hdr = skb_vlan_eth_hdr(skb);
 
 	/* If skb is already VLAN-tagged, leave that VLAN ID in place */
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef..7c178634228c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -20,6 +20,7 @@
 #include <net/tc_act/tc_mirred.h>
 #include <linux/if_bridge.h>
 #include <linux/if_hsr.h>
+#include <linux/if_vlan.h>
 #include <net/dcbnl.h>
 #include <linux/netpoll.h>
 #include <linux/string.h>
@@ -935,6 +936,18 @@ static netdev_tx_t dsa_user_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (dev->needed_tailroom)
 		eth_skb_pad(skb);
 
+	/* If the conduit NIC has tx-vlan-offload enabled (or it is fixed:on and
+	 * cannot be turned off, e.g. imx-dwmac), it will insert the 802.1Q
+	 * header *after* whatever the tagger prepends, producing the wrong
+	 * on-wire ordering. Materialise any hwaccel VLAN tag into the payload
+	 * here, once, before handing the skb to the tagger.
+	 */
+	if (skb_vlan_tag_present(skb)) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			return NETDEV_TX_OK;
+	}
+
 	/* Transmit function may have to reallocate the original SKB,
 	 * in which case it must have freed it. Taggers will drop the
 	 * passed skb on error.
-- 
2.43.0

