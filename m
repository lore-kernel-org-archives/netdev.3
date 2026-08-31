Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F493AC0D5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213127; cv=none; b=j8pUPKIvu8C6LkKguECZJ/eXFdEjUV5gfsZQ227GGMuviEhaBKoBaTW6Hkwl2X1DdEBbbiIOMruE1aFHff+7waP85DbWD0XPT6evyiFHQC7DKa6smeWMK7b9WEOrN/QkWvxSZglMyfO0K96AdtVUU6zIBYB18XolooZTJvlOIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213127; c=relaxed/simple;
	bh=GImSaBburXI+fSPmhv1GLTsPcvIOT1rc2hIuZWzMLxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O83es20Fen59ES9GwQ3apyOPAhGOVuebzsXxcvD2xptYauruYzH6ILOPdtRDGA/uK/Q54YWXpZLjFeV0neRPwJMusPr8Ipm6KR1ekapFkd2x2NE3OgviNlsVbAMBm8sNvCPIyqVvFKcuAPTd/+WwV32enceGEdGfpy4wvdMWOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrX7zYjd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrX7zYjd"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec201b582so5031977e87.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788213119; x=1788817919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JLqppsKFYm25VyfvfGmhK0W3JzFpvK1MwZIK8QKSzOQ=;
        b=KrX7zYjd+cs0rzJwjfdWX2eaZTMX65rltXU4f7PSDBTrEMYONt6QZK/rXvvHBtWiM3
         cezxu6pEBm7dja/cbQoaJ+uBARVDh32bXnyg7mFU/79pD6I+XDIJTN0mTLirkznr0e5D
         WPFSBfTlyVS3mDUbV3AUDwdDilE3ZCt6mPqe2Jfthj7ygndFmxR/qLJIJK4hRcd+Gpw/
         VfUBREJC2CFs1SA2EozpQorxNtSkqOMNn/Jx0VZHZi1ttB3PFt7YcQWEgEAbzdC5U3w9
         XE/yB4+Gv1XNFYED7v8wwb6XdoiDXi5D45PKm49JRjx0LYU/EFLD01+hCyj/h1yYo7f7
         HPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788213119; x=1788817919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JLqppsKFYm25VyfvfGmhK0W3JzFpvK1MwZIK8QKSzOQ=;
        b=oUHimsqC2bn2d2vEr37eVzKv1a0BXbkjHSa8N3MxuzhFlW05sMA1HqLUBJyAtE7MK+
         zLBr/hAMmsfdCpNX5wPoKBmCW8sdTMF2oZ4tu9eTZbbSQjHKK6i7gtYF9f1qxie6NxEp
         EU23wDJ8lbJUXXts7FeUjMqQi7qVW5kNTBaglSHTw+mzIgYhbpDLfU0tkyxo/ECkwhJ3
         jwU6FqGVsRJxyOSuKDBYrs4r+r1hfgQxQYqgtMBoGIEPBd8UTPSjDTaXBzXEKTg0psO5
         Y/8UsSN+a2kUEXMDB9YOEaDr54FiY9WyVYVSYQ+bbtea8IiJC0q+9JH5lpSnWZze0kh3
         8ilA==
X-Gm-Message-State: AFuF++nDiluS1xnWAPOAm7i+WWjSXGQwb4jCG/V6zwOmR1Agsx3hsqRR
	rZAUdJa+diK5EoevdTCkbvRi+RfGwvKlxeDWFupiiNYPxMxdlgLECSPRUk37hAaKSfo=
X-Gm-Gg: AYBFou3P6I0ziCHkfc2l4cDb+A/pPxT4R5zvgoSK5Wbrng7XixBWSwD44fouh3VhC3x
	gO9gQ4zU/P1stverMokk8VRp6sjb4kSiYDm19C86BGcBD23G0g79oRJcAHG+43gE5l9dyDm8t0a
	mNHbIQ0E6mO5IYVInRi9nTmQvGByRbu+N8SLiyyDL5KygOUy47Sw6V1W2CVObFUKIU5KIR6hKt8
	+L/i0HqowGSVVulMVvXMKyb5Ty+GkxPVJuG9L6CBoTQk0CZ1xlJD6RKle/KPlmp/HBZ0avuhwfm
	Not+8t31E07b/bR3KUVWyHgHsvpWwvdVSS/Ce0EeQTyNf5D4ZimDYAKx9+QRBjQtoQomITtUt16
	G3N/7vdOMJcIJuD2C/NY5DWafGoMOFI14OzlGwvPuDYW2WNLduEr/utDEcHwxy2P64jrPgioXWM
	/3F3UXVwO+d2WujlhJBssWom0aPirdJN71+NjLH3ahHuVWwwWWSlGWgwAtJEg+iHfDp5YvgBa9C
	je5I3I6rk3WLYVs5bHpTb2zq/KfEUPxaA==
X-Received: by 2002:a05:6512:6288:b0:5b0:15b1:3d5d with SMTP id 2adb3069b0e04-5b5e6902f5fmr9592721e87.22.1788213119500;
        Mon, 31 Aug 2026 14:51:59 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.184.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e8a06a77sm2388782e87.48.2026.08.31.14.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:51:58 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 06/11] ip6_gre: add drop reasons to the RX path
Date: Tue,  1 Sep 2026 00:51:32 +0300
Message-ID: <20260831215137.549324-7-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831215137.549324-1-littlesmilingcloud@gmail.com>
References: <20260831215137.549324-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mirror the previous patch on the IPv6 side: report
SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND when no tunnel matches the packet,
and tell that apart from a header that cannot be pulled
(SKB_DROP_REASON_HDR_TRUNC) or a metadata allocation failure
(SKB_DROP_REASON_NOMEM), which so far all ended up in the same plain
kfree_skb() in gre_rcv().

ip6gre_rcv() and ip6erspan_rcv() get the same output parameter as their
IPv4 counterparts.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_gre.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 736eefdb528f..27fbe175beec 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -454,7 +454,8 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	return 0;
 }
 
-static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
+static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
+		      enum skb_drop_reason *reason)
 {
 	const struct ipv6hdr *ipv6h;
 	struct ip6_tnl *tunnel;
@@ -473,8 +474,10 @@ static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
 			tun_id = key32_to_tunnel_id(tpi->key);
 
 			tun_dst = ipv6_tun_rx_dst(skb, flags, tun_id, 0);
-			if (!tun_dst)
+			if (!tun_dst) {
+				*reason = SKB_DROP_REASON_NOMEM;
 				return PACKET_REJECT;
+			}
 
 			ip6_tnl_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 		} else {
@@ -484,12 +487,14 @@ static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
 		return PACKET_RCVD;
 	}
 
+	*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 	return PACKET_REJECT;
 }
 
 static int ip6erspan_rcv(struct sk_buff *skb,
 			 struct tnl_ptk_info *tpi,
-			 int gre_hdr_len)
+			 int gre_hdr_len,
+			 enum skb_drop_reason *reason)
 {
 	struct erspan_base_hdr *ershdr;
 	const struct ipv6hdr *ipv6h;
@@ -497,8 +502,10 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
-	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr)))) {
+		*reason = SKB_DROP_REASON_HDR_TRUNC;
 		return PACKET_REJECT;
+	}
 
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
@@ -510,13 +517,17 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	if (tunnel) {
 		int len = erspan_hdr_len(ver);
 
-		if (unlikely(!pskb_may_pull(skb, len)))
+		if (unlikely(!pskb_may_pull(skb, len))) {
+			*reason = SKB_DROP_REASON_HDR_TRUNC;
 			return PACKET_REJECT;
+		}
 
 		if (__iptunnel_pull_header(skb, len,
 					   htons(ETH_P_TEB),
-					   false, false) < 0)
+					   false, false) < 0) {
+			*reason = SKB_DROP_REASON_HDR_TRUNC;
 			return PACKET_REJECT;
+		}
 
 		if (tunnel->parms.collect_md) {
 			struct erspan_metadata *pkt_md, *md;
@@ -532,8 +543,10 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 
 			tun_dst = ipv6_tun_rx_dst(skb, flags, tun_id,
 						  sizeof(*md));
-			if (!tun_dst)
+			if (!tun_dst) {
+				*reason = SKB_DROP_REASON_NOMEM;
 				return PACKET_REJECT;
+			}
 
 			/* MUST set options_len before referencing options */
 			info = &tun_dst->u.tun_info;
@@ -564,6 +577,7 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 		return PACKET_RCVD;
 	}
 
+	*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 	return PACKET_REJECT;
 }
 
@@ -577,17 +591,19 @@ static int gre_rcv(struct sk_buff *skb)
 	if (hdr_len < 0)
 		goto drop;
 
-	if (iptunnel_pull_header(skb, hdr_len, tpi.proto, false))
+	if (iptunnel_pull_header(skb, hdr_len, tpi.proto, false)) {
+		reason = SKB_DROP_REASON_HDR_TRUNC;
 		goto drop;
+	}
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (ip6erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
+		if (ip6erspan_rcv(skb, &tpi, hdr_len, &reason) == PACKET_RCVD)
 			return 0;
 		goto out;
 	}
 
-	if (ip6gre_rcv(skb, &tpi) == PACKET_RCVD)
+	if (ip6gre_rcv(skb, &tpi, &reason) == PACKET_RCVD)
 		return 0;
 
 out:
-- 
2.47.3

