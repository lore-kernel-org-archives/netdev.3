Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713737B3FE
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139103; cv=none; b=OEyhjXAsWE17Iqcv0hsvlP2q+NgPtxNKRk2n4BqGM6mhXCwktrm/ts2DS/puBqZRa42+nbdXacZp86XoVNDWSB7w6eE5MZ4lRjmg9h9NOlWNUl7q75L4Wgi/Nbew+SMhuaXDiQuPNfF2acfNdM34oaJ10I2tDsHnZYDWsf87zDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139103; c=relaxed/simple;
	bh=xEf3t/R7Jbvgx6YTeNrky889ZHjfTclMhSwF0D/NvIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L3n182yCoJucpGgaG270cgNj1UUWCkxJrkVJVrwIIcEGak0qJ5VEDwTAl0buIO5iDjvry3Nc6WWjOr/W8GDCD65hh9Uuc0PcBSfNEYhu4PAwG21RPhreXsno/NmkbFmw0OZtxBXoWLdblFj2YlXBy63871Iu3SKdI6sLoz2Cl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dch50fso; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dch50fso"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so334871a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790139101; x=1790743901; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vau8smD7DdgUp75NMX0g1XIGti7nSC/bWHbTDZeWg+k=;
        b=dch50fso9M7VJGXrAYDFHyVlbRo7yjBqqzorKb4JWf0oGWFgeWigQLr7DGg12i5Iyt
         gUswyR0Avy5E5Nz5ODVLiBvqSftjwzGbnuhgPazbHfeAYEoP0KaNwnV0Zz6RF4aQF/yB
         wpkvnsHLn7txMFfYLV5ixY4SvPYuAQnBbypB8l84dNA/RzyuUPSvU15DMaH1tgmvrGJg
         d85uqAEYnucMGLd2leeFm5zdsw2VLGHvq9hDNm++o/SqP/Q7K9ONx4s0fgEogaWfz1Vn
         XYhUNEULharJLbhA0dZTMLXuC31bRHVEJ0wDI39gzJwCPAzEfI4YovEJYChOpNVzpMgs
         +BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139101; x=1790743901;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vau8smD7DdgUp75NMX0g1XIGti7nSC/bWHbTDZeWg+k=;
        b=xUrDFCMuPoOpabJNC6KXY5UDqOh7Chk6HI/o1XmVs0EfHAsL43mXqcyyw1moKaZc53
         fqu5nNEQsjFajnklt0Ig2PhCTouuZomL3e6tWhyfW4UC/klVldF8/P+WQoNDaOmordpl
         YwYXgEBAwax7iBok+7YTZzpKJcAg/3sF7m3kS+DtPfLfi+XXKavvQjqg28AK8J+uvR9d
         ODCo/+n+TYJmvauO4l+ImAVs938UxN4ATJUzsQiOEBs+vqLnjyOdB21gtPLlfja5hrPh
         iCfgD9N9ZJpyyJXR6Ugwq2h4gWjensHzimH51Q6RyKmy3x+Mjvw6Dw9Fp8rfLbZ9xyae
         apHA==
X-Gm-Message-State: AFuF++kwhg5XKqFKJq1PndPmRD9n48WGSYn/hLD1yTg5vs697yalxTJS
	KSvVfUymW1KZwmMnVTHk3TCQwR90HL8yliJDhnNWz47H4buE7ZtpD1lI
X-Gm-Gg: AYBFou3L1pSP7h6cSTlNVexau/+toVT5sYdRyMkMr1QJDqY/iBCQ6DvUx7jxFuo7uWy
	u+ypg7WsIJhq508bhxaobeIaLPhriGaj0MjFPFyDb+VwM+y04c8ABLlO5vDvpWQTLTEt5AslmEv
	477wi1kyXx4D8Ex2oSz00iBOmh+Jve8J2u7t586eWHem7STS/bc7os7XjVWwnYm35boZTWeIv5D
	zMQKgO/GyfAy18ZqLc6BaOdmPJDNdCriUEAbHVA82vq+p1e1fiEa6TFuUSovrrMAHf86h7B8V4j
	cuaxwbs5MK3X7rWYakyXiK6+HXtm8lllxcYgUxZkSKT2roH2RdXzVsDtPhzsMddCMsEG+nR28lD
	HElTzezPP7Bak9Ocz0WfgeKpxuvfpD8Nh4FU2AlyLiD/CcgilGjYipyEk0hAB7M57D6uvqwQubJ
	aLsmi5E3uKEf8Bsp7we8wTQeeVAtlb6RWCNc9pz4PecHOGUB84E3QQyR6aHJUYCjBI26UaGJd5E
	ceTWG2Ntb0C+7D4vtKz
X-Received: by 2002:a17:90b:560c:b0:39e:423:bb8f with SMTP id 98e67ed59e1d1-3a07e51ca8emr1317609a91.1.1790139101363;
        Tue, 22 Sep 2026 21:51:41 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a089197169sm234555a91.8.2026.09.22.21.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 21:51:40 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Wed, 23 Sep 2026 13:51:37 +0900
Subject: [PATCH net] seg6: fix HMAC validation when an extension header
 precedes the SRH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-b4-seg6-hmac-transport-header-v1-1-3ae85dc0fdb9@gmail.com>
X-B4-Tracking: v=1; b=H4sIANhas2oC/yXMQQrCMBBA0auUWTuQhjRUryIuknRsRjAtM1GE0
 rub6vL/xdtASZgULt0GQm9WXkqL/tRByqHMhDy1BmusN2drMTpUmj3mZ0hYJRRdF6mYKUwkaPt
 hNG6MLiYPzViF7vz5+VcoVOH2n/qKD0r1kGHfv/V7aCmGAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5048;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=xEf3t/R7Jbvgx6YTeNrky889ZHjfTclMhSwF0D/NvIA=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqs1raOyWwew0Hli56N7ZHs07TCEoACZ5nU4jBZ
 tBe5dJMzVyJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCarNa2gAKCRAq19F1Kl0b
 TfSuD/43UvtuGT71ZkdlZL0stBTiD5Sa3zMnzh1FociHb7jmsBZZfeupSv0jsleR8CtkgyewkUA
 JA7VgW2rq4h1Bs7IdZRidsdonkYBMR2Poi6QmK9H5uJRs6MxsA4bb6AYA92O7eaei9HkZ/yPhIS
 KiHj5/qlWsTWfs+Ov3yZt5/0VHvxKN90u8pZNyKa+CzeHeRhUfs8VuXZtbitA1gRQzm1n/rEjl4
 P/iQOyqaLxC+9QGiMXxQOSvrBd059ByHaLs6UTGoQ3gInwga28alKoDT41H65CYxvqWfJFML0Rh
 rv4MnbnoyF89kNfEXf1YY8QG64X4cj/bXL5YIS6/qtrrzYuivp8nFCkebX7NN7jHN2u84xqTBOY
 V8JlUxnS9xhr+EiVZrK4L0P/KwBvKusIlPFur92eS0mbZ5sm5QN1innzY+TnkQ/HNfyxPBe2z3F
 mvC381aFVfh/fKqD3T0SV0vlhyCNN4euKaatwNv7335vxM4/SlPtTs/AaRWnXroVeW93+kAujiL
 LFALuB09EqPKE8BPVsIUki0p5wiBX32BJe8k6N+s4oT2v59/5y4PMYC7bjR2JT9OLCbhnydpvYT
 Cjs3+1EFsVYQ/+sgKu0gl96008ldm8Fx4PnR1HH5xhAh10zJRcc3tE9s88PGG1qCx/3xqCFrPSk
 ClMNUoZciNakXjA==
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
comply with IPv6 standard "RFC 8200""). The misread header is covered
by the pskb_may_pull() in seg6_get_srh(), so the result is a wrong
verdict, not an out-of-bounds access.

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

