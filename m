Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07602434995
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790421577; cv=none; b=oKMWl3lRZYDuNd3BCJ4oFoPX7ZaOgbqJNs8SIG/GJV64f8pnkFAGF6g0WEPVwgC9R1I70Q+XJBCrxWq8V0PiWIa0P3FcdFGyEeke2+7G2RSxw2TxjM6VCeG6AuwcZEsm/9x6bxPWfyKG4ULoPjj6rKo6vPpEiiOO+UpzPQTSnfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790421577; c=relaxed/simple;
	bh=Lww05ZAzWz07fyBBS1Asgti4qwtQR2M2hFx3NPJelho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V3JzsEOw2E7K7+9gzU8Izua1JKBXLSf/pC6BnytN/B9Tbu2Ch//QfCPuM+M8ship9DRiuujC5+FEx2AKlXxTEvDW1+ANjkRsQNIES88DfsGD0a04a7ttA879bjNDOJl/9hOQ5Sig8WW8BBYmLdeUXcECKzfeBlKOEZ+WysiXARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGVrMslz; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGVrMslz"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1247111a91.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790421575; x=1791026375; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qrMJ0YsFDHzrc+kmXrsiVTStKnHMXKnt5ySd1IaBrc4=;
        b=SGVrMslzP0szY6E8dvH6iGk0pEFYJje/gVGwMmdrgaQwHa2Z4IaScPeTxX9Txj+Voo
         oHnpB+8IsNc8kWo5JCKsdnQ6Au6NeF5754WpnEt4fNQvi4yD8HTrX2EvmUT/t48IyvY4
         qn20Eo8eRdPjysEIZE+Hgid8guScn0F1IHavaCSdGKqXa/Gp2RfzrF1qMXaTwNqc6NSG
         rSvYZOWcl/1D2Wg38/kSfvQqrg8l/Cjfb7HNoaFs96f3tnrNvJcihwOFfRxvpu06O0N8
         RTRbiN6PZq+98Qx45iEWUvw+o5y89wK+WoNm5i1Yz0L1h2LUZrDA1hxxUYhyOaRe82Dp
         RMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790421575; x=1791026375;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qrMJ0YsFDHzrc+kmXrsiVTStKnHMXKnt5ySd1IaBrc4=;
        b=ts7Tdd1h6Ez9rlbxctW+9fzt9gtkxdfWYsjgkb0kkArXdVWxpS6NOuDtoUZipsB63n
         y36xvv+Qs/s9XA4n0H98tmlpcwA49iN5pRwvJP0IO/weL4UJ74jwdJcJxPaKxm5+zh+D
         puO9l8JxuGzQYx3jR2onFlBdP6ayH4biXexTqKvIRNb2koG2QMlg+LORuRGPv1G/ZwXr
         ERhFYq/GGSTCFc1nyosQ6rM12YO+CGSzsUX7NBwwNezHUJOg80aTvtfKqchlxK7jY5Da
         6uVJ7Dx6adslDiHSsvHFVSMs2xA9vBBwnchyz/OYiYoZ8XcNRvPdl0YlFeHGG6C0oMqE
         cJkA==
X-Gm-Message-State: AFq9FYL1asogKt6CvP6hvK+gDQR55m0GsYU9gUgdfjEGXXsJnxvj9cnq
	L6D1qm5tLyBC01dwEwOTZechhWpZSayA8zy0wEHHj9utoYWg6wxF3G/h
X-Gm-Gg: AYBFou1rsCPnPK74cizvrBzxr3lYBCAzfHLKwBgRj7meY71KqGgP02zzOGRIgI7fhmC
	0IMt/apmM/45LSh18ajFukCjXiQM5qf0fnfV1bVG+QoR3qh+y+xnM7tual7nnoKcRH3gJwbD7/Z
	y0LNyyh35+XzbhFDku7DRt2a0ZfWjMh7g4p3iuca1nPrPJ5S7QJ9rr69R0ZqsDcv2SILhHHEyA5
	JnhZRE1lbZPf+L6jqQLFZA4Gqjr05j/MXW+yuoIYT1xjUPqnAGbTf9X0V9loPOf6Q9f/qL7NZgQ
	pZSCmThpgV71CXtnrN5YnU+75wi27AHAo/Poz3V5aSjFX1yf6VORUv4iEb4BD8NpdbMNu1FXaq2
	d6MI642RtRRb0LYPPlpCyd5gSfB+bbsm0230+8qRP471SQokMXwm+u2Onk201wPkOPNv+xrgvoO
	4WwxC4BJX3pJSKRbqJGoH0cTV9fGv58XRnlkoP/yLpaS6obu9jYxBRTiR7jobukIWesBW3XZFoX
	kbBQ0D0
X-Received: by 2002:a17:90a:10cf:b0:3a0:b7b4:b649 with SMTP id 98e67ed59e1d1-3a0b7b4ba36mr3032731a91.52.1790421570582;
        Sat, 26 Sep 2026 04:19:30 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589bbfsm9595972a91.9.2026.09.26.04.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:19:29 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Sat, 26 Sep 2026 20:19:27 +0900
Subject: [PATCH net v2] seg6: fix HMAC validation when an extension header
 precedes the SRH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-b4-seg6-hmac-transport-header-v2-1-8087b76f6375@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD6qt2oC/4WOyw6CMBREf4Xctde05RFw5X8YFn1caI1Q0laiI
 fy7gO5dzuTkzCwQKTiKcMkWCDS76Py4BXHKQFs59oTObBkEExVrhEBVYKS+QjtIjSnIMU4+JLQ
 kDQUUvKxZUatC6Qo2xxSoc6/Df4ORErTfMj7VnXTazTtmXUw+vI8XMz/g32D+Z3DmyDGXVJdGs
 86o5toP0j3O2g/Qruv6AdhfmVrhAAAA
X-Change-ID: 20260922-b4-seg6-hmac-transport-header-2158048b4bc6
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, David Lebrun <david.lebrun@uclouvain.be>, 
 Ahmed Abdelsalam <amsalam20@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5383;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=Lww05ZAzWz07fyBBS1Asgti4qwtQR2M2hFx3NPJelho=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqt6o/vhL0NINjeQJyM6BskYTOs7UokyoXsEDBb
 8MTdPXGhMyJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCareqPwAKCRAq19F1Kl0b
 Tb29EACUo8C+jJdTlLC33sXyIHv3vjFPcedpZ81zMwBNGAkh+iV6Zg3AO+tT6XVlFAor7Ph3Wgn
 jOr6KFvu1thbV+las6W9Me2qEDMYD1gQ1M3wbBd3tk6W2+SgPj2SP0ilcil3qyPOSWSRmKWOWaA
 QbWM0SZuJ9zWQJxhIL8OQogg0Uuz4Zus2eg+Z+Ik5WLBWh94ig1WlfCScxkjoMwBWCWsatK/c+/
 87M//ka1b/wCBMNVLp0TVDSL9+XXgKP4qvEgFZseZxYnljncRBSssVUr2kwIVGfJ9JTz/KbZycv
 kQFts63T1t11cyCf+2r8Acd8IXtujSHvZPWpYAdFpglhFrd1qOBxUvd5k1vCbkK5m/ZntKMME/h
 /v83ME9tRPyekf+49sjDY8WzoZDm3sCnNz6NxRacUXd8X/heNl9goGAt0IkMIrldfZlCMZy2gcD
 dBcRw8xMXqB7x0QU6etrKFMcP0z1x0ydRhYCQReu7tDsHO8D5V4tG/OmtdjcSjoTxJYF0JDC5lV
 y0JCLObqQDaK2XvOpiFgFKQpJm0650f63WZrQeTugLs1YSVi7aHWapzmNawnMHBmLMMIfEApWQ3
 1Gg0WJ0w5//0LQ5zPEYSDvRgf7qlaOpDNu6Ho1CWTYQeIU6Y39r/us9ePloDiZXXBCRNNvWloMu
 3epWtfs2fXDSM/g==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

seg6_hmac_validate_skb() derived the SRH from skb_transport_header().
That only holds while the two coincide, which is not true on the
seg6_local input path.

ip6_rcv_core() leaves the transport header just past the IPv6 header.
A Hop-by-Hop options header is consumed before the route lookup and
advances it, but a Destination Options header is not: the seg6_local
lwtunnel is entered through an input redirect from the route lookup,
which bypasses the extension header handlers. The transport header
then still points at the Destination Options header while
seg6_get_srh() has located the real SRH further down the chain.

The HMAC is therefore computed over the Destination Options header,
and a packet carrying a valid HMAC TLV is dropped when
seg6_require_hmac is set. Such a packet is legitimate: RFC 8200 allows
Destination Options before a routing header, and get_srh() has walked
the header chain since commit 5829d70b0b6c ("ipv6: sr: fix get_srh() to
comply with IPv6 standard "RFC 8200"").

With a Fragment or an Authentication header in front of the SRH, the
same mistake also reads past the data pulled by seg6_get_srh(). This
happens before seg6_require_hmac is read, so the default configuration
is affected.

Reproduce by giving a node a seg6local End SID with
net.ipv6.conf.<dev>.seg6_require_hmac=1 and a key installed with
"ip sr hmac set <keyid> sha1", then sending

  IPv6 -> Destination Options -> SRH (carrying a valid HMAC TLV) -> payload

to that SID: it is dropped, while the same packet without the
Destination Options header passes.

Fixes: 5829d70b0b6c ("ipv6: sr: fix get_srh() to comply with IPv6 standard "RFC 8200"")
Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v2:
- Describe the out-of-bounds read reachable with a Fragment or an
  Authentication header before the SRH (Andrea)
- Link to v1: https://patch.msgid.link/20260923-b4-seg6-hmac-transport-header-v1-1-3ae85dc0fdb9@gmail.com
---
 include/net/seg6_hmac.h | 3 ++-
 net/ipv6/exthdrs.c      | 2 +-
 net/ipv6/seg6_hmac.c    | 5 +----
 net/ipv6/seg6_local.c   | 6 +++---
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/net/seg6_hmac.h b/include/net/seg6_hmac.h
index e9f41725933e..3161a8104b89 100644
--- a/include/net/seg6_hmac.h
+++ b/include/net/seg6_hmac.h
@@ -48,7 +48,8 @@ extern int seg6_hmac_info_add(struct net *net, u32 key,
 extern int seg6_hmac_info_del(struct net *net, u32 key);
 extern int seg6_push_hmac(struct net *net, struct in6_addr *saddr,
 			  struct ipv6_sr_hdr *srh);
-extern bool seg6_hmac_validate_skb(struct sk_buff *skb);
+extern bool seg6_hmac_validate_skb(struct sk_buff *skb,
+				   struct ipv6_sr_hdr *srh);
 #ifdef CONFIG_IPV6_SEG6_HMAC
 extern int seg6_hmac_net_init(struct net *net);
 extern void seg6_hmac_net_exit(struct net *net);
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 09a4552f7f08..3ef3c2635581 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -387,7 +387,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 	}
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
-	if (!seg6_hmac_validate_skb(skb)) {
+	if (!seg6_hmac_validate_skb(skb, hdr)) {
 		kfree_skb(skb);
 		return -1;
 	}
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index e6964c6b0d38..bd2704d4c7a0 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -173,13 +173,12 @@ EXPORT_SYMBOL(seg6_hmac_compute);
  *
  * called with rcu_read_lock()
  */
-bool seg6_hmac_validate_skb(struct sk_buff *skb)
+bool seg6_hmac_validate_skb(struct sk_buff *skb, struct ipv6_sr_hdr *srh)
 {
 	u8 hmac_output[SEG6_HMAC_FIELD_LEN];
 	struct net *net = dev_net(skb->dev);
 	struct seg6_hmac_info *hinfo;
 	struct sr6_tlv_hmac *tlv;
-	struct ipv6_sr_hdr *srh;
 	struct inet6_dev *idev;
 	int require_hmac;
 
@@ -187,8 +186,6 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	if (!idev)
 		return false;
 
-	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
-
 	tlv = seg6_get_tlv_hmac(srh);
 
 	require_hmac = READ_ONCE(idev->cnf.seg6_require_hmac);
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index d1070aec7b72..67eeb27ee43a 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -222,7 +222,7 @@ static struct ipv6_sr_hdr *get_and_validate_srh(struct sk_buff *skb)
 		return NULL;
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
-	if (!seg6_hmac_validate_skb(skb))
+	if (!seg6_hmac_validate_skb(skb, srh))
 		return NULL;
 #endif
 
@@ -239,7 +239,7 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 		return false;
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
-	if (srh && !seg6_hmac_validate_skb(skb))
+	if (srh && !seg6_hmac_validate_skb(skb, srh))
 		return false;
 #endif
 
@@ -771,7 +771,7 @@ static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 	srhoff = srh ? ((unsigned char *)srh - skb->data) : 0;
 	pinfo = seg6_get_srh_pktinfo(srh);
 #ifdef CONFIG_IPV6_SEG6_HMAC
-	if (srh && !seg6_hmac_validate_skb(skb))
+	if (srh && !seg6_hmac_validate_skb(skb, srh))
 		goto drop;
 #endif
 	flvmask = finfo->flv_ops;

---
base-commit: 17741334d00bf5ebd37f8c1c36bc9c146a351deb
change-id: 20260922-b4-seg6-hmac-transport-header-2158048b4bc6

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

