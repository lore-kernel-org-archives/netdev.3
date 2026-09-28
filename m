Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B567547046
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570487; cv=none; b=mRZTzXSQ+GLY3U9dyhr/tj9xQehifV07So4WVB5UvFdvvAhHZK7qpF13XMNKBmG+JENZ/+tE0MmQ6RduI49Em8kci6dhdWRrnciu69H9/ZPtbGfIepbuKQUGPBrUanOm1SyWyJOJ4UNR33UNYn39W1hqh0gFczW8yAfljK2WE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570487; c=relaxed/simple;
	bh=tBP0mKKiyRtu+f6csMdfdzJtR9AlT8K7h7koP3za+m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qp+LvGqH9bt+P3Vv5zLYWY/Htm8sGCSpubZ/hkeBM4nuNAH81IOw5LFgJAR3M7D6cdStnzT4VWd71QLmB4lxNQVwbkOkB+LdtQGHx1ZaSK2QKJGh/jihPSdFntAWiFNsnr/koyhZRP+g7pwu1KS2TVr2bbMB4RzHyBamZoqTUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=0xZXrKbN; arc=none smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="0xZXrKbN"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-343f0de0450so385144eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790570484; x=1791175284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IluUd3MK7emFHAWijVzGQhPdB3+0qlh6UZvBGYkNpY=;
        b=0xZXrKbNRo3vXGGBs3YvteCBoyhlqYBtR3T2fU1fPNYP6snzjfRNPj7JtPNCHnhq5z
         hZ8BO/aClebM0qRC3SpqziwVCPeu2QDEsffubcQkdKdf3maqNSJSPtP3U65bimawIKsE
         3J/CfQkotlScJa05pSZ2kXiyRyqSDqWCDf51xhaOwjHvxcFvptQvZpGAOcwqeOnq+sfp
         5crKWDkb4m4VFc7dFxpDDjhkfD+Pu68D22l9WIeGSmc1ML53/ZmrqB0G0s1H6+OtIKLP
         ftNG5k1ndKwI73hyoZhhcIvTRR6yOC6DMF5V8TKDt/9vKtcBfMUQeCsPL/H0f2gdrsMU
         H6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570484; x=1791175284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2IluUd3MK7emFHAWijVzGQhPdB3+0qlh6UZvBGYkNpY=;
        b=rXFgtSV4DKdLy4FnRgSHMAgH97SVf/M3WDf2Pq40wKH1lyvKVyKxzN1zCiCJ/rzY7x
         K+xQyg2btax+0iJeDgSVoZrNeL+yp+DsJcQFM9b6csUy1GABFZqMGy0v86vuWVF+LBd1
         b9Alm0dTOERX/4IYKEA1u4vcGgaeyJJnB1UY6NyY8JUATVrlwoc5ElJYOfEq9w93lFIx
         D8jjcHGygE+6n7CuGFedRzbQLYCTZVSGLWejGqQU13PxHsuwg2GbOG9AyxclKr3cEKTo
         yK7G0v7la0uAZCRlJQJIKRiyoRlsyiCiItXxbi449hRtEppBR22UIu+WRvm+/9jbfez1
         5tKw==
X-Gm-Message-State: AFq9FYJ7zrshUcJ3plV+lbEA7Yz6dCl/WCgnBdsRKcYGCQ3p/7u4aPXU
	8xyXymG/m0uc6L4y4nXnjK/O/OrKujo4c+U695wIlR8ck6/o8d2zLDWY3BJo+kk9BEdYi2TodYi
	CfczHJ/n1qgA2qgMdNGJRbd5yisrIj1oFxo9ucV7mWADuN1lDGcrpgN2CRS+jJNGXd0u/DIq6OV
	55Yg==
X-Gm-Gg: AYBFou1lu491asUVuc+ZOo1dE5+FUT66alOewjursgl1f+sdlgy/3afXcs9FNYEVQ3h
	tOR6ZJLs1ZL93XgA5EnKsrbefvIuN6/pCF+zz6FQmd3xczaN+BTfD8wslUmjw+wCCGMJ5wRuX5Y
	Eaa1mQZRKVo0YAy9dgN2FYMTQlydsieS10DZznwhQiWLMZgutGCWlVomaWQfIMbsT94DKvGDtLn
	Wv/OBsdKg89JwkeckDrRb11zG/VpZFSPwK5TnOLNv8zyYPUiXjI7KMXPzSKY8dgQOTx6DbQzILr
	tkEsbzVykSnrGWASpKTvYPpwTGrQK88agEDjHf5+GmkAWNsR6Qrnvw8OSYEQScjKIgFO/Y59UHC
	yej4wJ34iaIN+syou9W4D0KMVAWuC+NIoRHJxfmna++59HdEcvkeag950NGia8dmPjNzMAAoOzd
	Q24x//RFK9Ijs0g1ct8Ce7PXfETrTG6cW2KiFHbr1aHODVIoFbYpNHav3+vV5tnIO2MH9q4FCgj
	BnhdRpdh7ThBpF5zLa7qg==
X-Received: by 2002:a05:7300:1c1e:b0:33e:5e42:942a with SMTP id 5a478bee46e88-3427324b07cmr7851695eec.22.1790570483702;
        Sun, 27 Sep 2026 21:41:23 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm22772905eec.28.2026.09.27.21.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:41:23 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v3 1/5] net: core: use the packet's L3 protocol for the GSO size limit
Date: Mon, 28 Sep 2026 12:40:58 +0800
Message-ID: <20260928044102.1004310-2-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928044102.1004310-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gso_features_check() compares the frame length against
netif_get_gso_max_size(), which picks the IPv4 or the IPv6 limit from
skb->protocol.  A tag which is already inside the frame replaces that field
with the VLAN ethertype, as skb_vlan_push() does, and an IPv6 packet is
then measured against the IPv4 limit and segmented although the device
could send it as one TSO frame.

Let the limit lookup take the protocol as an argument, and pass the L3
protocol, so where the tag sits does not decide which limit applies.  The
helper cannot look behind the tag itself: it lives in netdevice.h, which
cannot include if_vlan.h because that header includes netdevice.h.

Fixes: e609c959a9396 ("net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_size")
Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v3:
- new patch: the L3 protocol fix split out of the resegmentation patch
v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/
---
 include/linux/netdevice.h | 4 ++--
 net/core/dev.c            | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d037faff7c44b..1c28861fcbe2c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5562,10 +5562,10 @@ netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
 }
 
 static inline unsigned int
-netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
+netif_get_gso_max_size(const struct net_device *dev, __be16 protocol)
 {
 	/* pairs with WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
-	return skb->protocol == htons(ETH_P_IPV6) ?
+	return protocol == htons(ETH_P_IPV6) ?
 	       READ_ONCE(dev->gso_max_size) :
 	       READ_ONCE(dev->gso_ipv4_max_size);
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0dbc..ffa9b0c27788c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3843,7 +3843,8 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (gso_segs > READ_ONCE(dev->gso_max_segs))
 		return features & ~NETIF_F_GSO_MASK;
 
-	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
+	if (unlikely(skb->len >=
+		     netif_get_gso_max_size(dev, vlan_get_protocol(skb))))
 		return features & ~NETIF_F_GSO_MASK;
 
 	if (!skb_shinfo(skb)->gso_type) {
-- 
2.47.3

