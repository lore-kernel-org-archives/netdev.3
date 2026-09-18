Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68851331EB0
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712319; cv=none; b=Iz4Z1y8FcdcD1iZALvA//GJzVFQtTIhZNJ60dr7A34Am57u3o3NLSj344XFBv7OWy8DEKu4RgNAMQyu4bauYt/n+4Q7i+h7ryO9Ja/EZ1rmb8tVuzd8amSMxnHUOVA5p/e6hXMezootOexHk8YUNEq5zTS9oiKHa0ZHM9vA2/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712319; c=relaxed/simple;
	bh=2iO+cYhu4TaBBMi5CLbsSD/Hs/ex+Tkf/xXQVg0s+g8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UDufV3vn0JVqehS2NRmnqPbr5TrZZW6QNy43L5B25FFbj4HUPdUMpTPewk1O37WsON6zlFbvGz5MefHq7ZGs64GgReu3O7LT3V9t28YfvDVTvCJHISwevKrm5JyulD3eYvfTaMlwLBr4InNcgCnn25LQ8L7dKCsU8sJ0uRqBQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=momBS6tC; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="momBS6tC"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db22383fe8so2150415ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 23:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789712318; x=1790317118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlH2FkH1P5oTFRvmo0HQX9xZlRE985ig8ruveN6rylQ=;
        b=momBS6tC7doXBg3hzQ1Lcx0qLkyO6xM/kuANuZxGg3acF0yBDSQiPEMh1etq7/fyXp
         iwZZBbkDPmSiEqrG8MzaHdidbDYz2Yoq81Ei3KU6C7Gboc4t4FmBBAyXJ1qp/wzb1tSJ
         wfubIjXke8vEZ3+pz3XxBlaWExlyGE5pwWs2gwvFsAMKgXgjONqVgCa5Hum90x6LjIrv
         52Aevee5YgDXzn1U/idLqEbcxsyeaB7YtT9KxrMBlFXTQS17uktR8xCyeyvd2enHM3Qu
         UbYBwbWfLE7FFaO44Xk1reKPE4TwyKSJl98sxTEOn04vyvjIkqAUa48T6EsP+JzbmDfU
         NxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789712318; x=1790317118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlH2FkH1P5oTFRvmo0HQX9xZlRE985ig8ruveN6rylQ=;
        b=v6dBZ1l1Ig24qOLTvYFJnogcCCCDqvOxetCxTqK5EUz8enmdbIolXaN2+GE0alhz7z
         QRMreh6LGtM6Pl4AMHM9+bRyvl8p4jHVJFNiY4FlkbYwMvX0haIm6sNCr1qLhJARMaS6
         /KE4BWtbyGWJlRu7YYAvO5WQhFcLpb34iPGbff3LP41v14Hdrpcl+Fg7Gq2WyFWQ0P0s
         GEHXJSedgB1o1ycfQV42qzvoyvE3jPT77vjuDjgoEhZJFETkvnglufAWlWNR06u1uRZP
         RQ9EnyO6fcvKeIoLia9u08QQ6d8RxM8hyEfATly/ilIA+BSGYAhgPRb9+ayZk6TXU4L6
         u2Rw==
X-Forwarded-Encrypted: i=1; AKwUvBz3ukGveSAyxf7kVAw6oWWIibin4qMO4g4rsoKR+x4zo/05vT6p37K6lZGmMW5pdXsBPtyD6+I=@vger.kernel.org
X-Gm-Message-State: AFuF++l2S47ceLClLtmLHYVdaJeJzy/Bnd9DIScOdnWLXKiEdpJVHp9m
	GY8VvOyoCg1gRK69SkzjdVICR9m0IEzrm2hcVX+apBjcHaXD8AClFIn3
X-Gm-Gg: AYBFou2FCom4TDQIFvxRugFxAPuP7rhkSqT+T5ke/oCcoa5U9sqRCbVLl260cnJgMMC
	zfmWKEc+If1Evi/SNPaBF8VUOH5ICOekSCqFI5Gf6MHumpTGwi6DyiohHoTL+djxUQTsxL2NPrO
	1IMhXClqunmxJMhezA9KOtqpoCNbRH9ZcOBEDpj2LlTPYBfK/KQkGz+9UuFhZnbUNuTrIMQky1X
	4NPrBfIyfkU94aowkTWp4qqO6FboaWqHcrbjwtyWrMlLzUhepFDXiKPvU8BHVniROvfLvuTR+/B
	qgh0lAC7bqgudWWF2ZcKGFTaCxiuvb7K2b06aUHMBO14dOyH6OKQcOHDNKpy5PlvZaPkN/FFywA
	h6XBDaDgkrr1ULNjALHCx+JttI08mta2WoX0N+uwkKUEC0YIfCwq3BIHvTgDbaukYHb4VrDLi9M
	Kd5+dl6+zftixv3YNYx0JKUZuxoObFwIwZfWXWFdU6RnR35xXEwWYoSxfV+imZRQpZRJYKkjZ5U
	LmBLWJo9g==
X-Received: by 2002:a17:903:22cb:b0:2da:c09d:b5d2 with SMTP id d9443c01a7336-2ddb1ac96f8mr28382165ad.3.1789712317647;
        Thu, 17 Sep 2026 23:18:37 -0700 (PDT)
Received: from c79ofce.localdomain ([103.165.85.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb75bf3acsm2820125ad.62.2026.09.17.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 23:18:36 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH nf-next v5] netfilter: ip6tables: hotdrop malformed hbh/dst and srh headers
Date: Fri, 18 Sep 2026 14:18:03 +0800
Message-Id: <20260918061803.36372-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hbh/dst and srh matches have paths that return false for malformed
IPv6 extension headers without setting hotdrop.

For hbh/dst, strict option parsing can stop when option data cannot be
read or when the current option length exceeds the available header data.
Treat these packets as malformed and set hotdrop. Apply the boundary check
to the current option regardless of whether the rule asks for more
options, so a malformed last requested option cannot be treated as a
normal match result.

For srh, keep a missing SRH as a normal mismatch, but set hotdrop when
header lookup fails for other reasons, when the SRH fixed header is not
present, when the advertised SRH length exceeds the available skb data,
when the SID list implied by first_segment exceeds the advertised SRH
length, or when SID selector reads fail. Apply the SID-list length
validation consistently to both revisions of the srh match.

Returning false treats these malformed packets as rule mismatches. Set
hotdrop so rule evaluation terminates and the packets are dropped instead.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

Changes in v5:
- Rebase onto the latest nf-next tree.
- Drop the ipv6header change because ipv6header_mt6() does not stop at
  non-first fragments, so changing its short-header handling may affect
  valid fragmented traffic and requires separate consideration.
- Keep segments_left greater than first_segment as a normal mismatch,
  since reduced SRHs may legitimately have segments_left equal to
  first_segment plus one.
- Apply the first_segment/SID-list length validation to both srh match
  revisions to keep malformed-header handling consistent.

Changes in v4:
- Retarget to nf-next.
- Do not turn ipv6header ptr overruns into hotdrop because ipv6header_mt6()
  does not stop at non-first fragments.
- Fix hbh/dst strict option parsing so a malformed last requested option
  also sets hotdrop.

Changes in v3:
- Remove the unused len variable from ipv6header_mt6().
- Validate that the SID list implied by first_segment fits within the
  advertised SRH length in srh1_mt6().

Changes in v2:
- Use hotdrop labels for hbh and srh paths.
- Mark SRH packets with segments_left greater than first_segment for
  hotdrop.
- Drop the redundant ipv6header length check before skb_header_pointer().


v4: https://lore.kernel.org/netdev/20260807084559.63276-1-running910@gmail.com/T/ 
v3: https://lore.kernel.org/netdev/20260724110111.18783-1-running910@gmail.com/T/ 
v2: https://lore.kernel.org/netdev/20260714032124.7042-1-running910@gmail.com/T/ 
v1: https://lore.kernel.org/netdev/20260709063012.33160-1-running910@gmail.com/T/ 

---
 net/ipv6/netfilter/ip6t_hbh.c | 33 +++++++++++++-------------
 net/ipv6/netfilter/ip6t_srh.c | 44 ++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/net/ipv6/netfilter/ip6t_hbh.c b/net/ipv6/netfilter/ip6t_hbh.c
index 6008dcff8488..53fe8520a1f9 100644
--- a/net/ipv6/netfilter/ip6t_hbh.c
+++ b/net/ipv6/netfilter/ip6t_hbh.c
@@ -62,21 +62,18 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			    NEXTHDR_HOP : NEXTHDR_DEST, NULL, NULL);
 	if (err < 0) {
 		if (err != -ENOENT)
-			par->hotdrop = true;
+			goto hotdrop;
 		return false;
 	}
 
 	oh = skb_header_pointer(skb, ptr, sizeof(_optsh), &_optsh);
-	if (oh == NULL) {
-		par->hotdrop = true;
-		return false;
-	}
+	if (!oh)
+		goto hotdrop;
 
 	hdrlen = ipv6_optlen(oh);
 	if (skb->len - ptr < hdrlen) {
-		/* Packet smaller than it's length field */
-		par->hotdrop = true;
-		return false;
+		/* Packet smaller than its length field */
+		goto hotdrop;
 	}
 
 	ret = (!(optinfo->flags & IP6T_OPTS_LEN) ||
@@ -94,8 +91,8 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 				break;
 			tp = skb_header_pointer(skb, ptr, sizeof(_opttype),
 						&_opttype);
-			if (tp == NULL)
-				break;
+			if (!tp)
+				goto hotdrop;
 
 			/* Type check */
 			if (*tp != (optinfo->opts[temp] & 0xFF00) >> 8)
@@ -107,12 +104,12 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 
 				/* length field exists ? */
 				if (hdrlen < 2)
-					break;
+					goto hotdrop;
 				lp = skb_header_pointer(skb, ptr + 1,
 							sizeof(_optlen),
 							&_optlen);
-				if (lp == NULL)
-					break;
+				if (!lp)
+					goto hotdrop;
 				spec_len = optinfo->opts[temp] & 0x00FF;
 
 				if (spec_len != 0x00FF && spec_len != *lp)
@@ -123,9 +120,9 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 				optlen = 1;
 			}
 
-			if ((ptr > skb->len - optlen || hdrlen < optlen) &&
-			    temp < optinfo->optsnr - 1)
-				break;
+			if (ptr > skb->len || optlen > skb->len - ptr ||
+			    hdrlen < optlen)
+				goto hotdrop;
 
 			ptr += optlen;
 			hdrlen -= optlen;
@@ -137,6 +134,10 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	}
 
 	return false;
+
+hotdrop:
+	par->hotdrop = true;
+	return false;
 }
 
 static int hbh_mt6_check(const struct xt_mtchk_param *par)
diff --git a/net/ipv6/netfilter/ip6t_srh.c b/net/ipv6/netfilter/ip6t_srh.c
index db0fd64d8986..c89f5eb68926 100644
--- a/net/ipv6/netfilter/ip6t_srh.c
+++ b/net/ipv6/netfilter/ip6t_srh.c
@@ -27,20 +27,29 @@ static bool srh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	struct ipv6_sr_hdr *srh;
 	struct ipv6_sr_hdr _srh;
 	int hdrlen, srhoff = 0;
+	int err;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
+	err = ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL);
+	if (err < 0) {
+		if (err != -ENOENT)
+			goto hotdrop;
 		return false;
+	}
 	srh = skb_header_pointer(skb, srhoff, sizeof(_srh), &_srh);
 	if (!srh)
-		return false;
+		goto hotdrop;
 
 	hdrlen = ipv6_optlen(srh);
 	if (skb->len - srhoff < hdrlen)
-		return false;
+		goto hotdrop;
 
 	if (srh->type != IPV6_SRCRT_TYPE_4)
 		return false;
 
+	if (sizeof(*srh) +
+	    ((srh->first_segment + 1) * sizeof(struct in6_addr)) > hdrlen)
+		goto hotdrop;
+
 	if (srh->segments_left > srh->first_segment)
 		return false;
 
@@ -111,6 +120,10 @@ static bool srh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 				!(srh->tag == srhinfo->tag)))
 			return false;
 	return true;
+
+hotdrop:
+	par->hotdrop = true;
+	return false;
 }
 
 static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
@@ -121,20 +134,29 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	struct in6_addr _psid, _nsid, _lsid;
 	struct ipv6_sr_hdr *srh;
 	struct ipv6_sr_hdr _srh;
+	int err;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
+	err = ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL);
+	if (err < 0) {
+		if (err != -ENOENT)
+			goto hotdrop;
 		return false;
+	}
 	srh = skb_header_pointer(skb, srhoff, sizeof(_srh), &_srh);
 	if (!srh)
-		return false;
+		goto hotdrop;
 
 	hdrlen = ipv6_optlen(srh);
 	if (skb->len - srhoff < hdrlen)
-		return false;
+		goto hotdrop;
 
 	if (srh->type != IPV6_SRCRT_TYPE_4)
 		return false;
 
+	if (sizeof(*srh) +
+	    ((srh->first_segment + 1) * sizeof(struct in6_addr)) > hdrlen)
+		goto hotdrop;
+
 	if (srh->segments_left > srh->first_segment)
 		return false;
 
@@ -207,7 +229,7 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			  ((srh->segments_left + 1) * sizeof(struct in6_addr));
 		psid = skb_header_pointer(skb, psidoff, sizeof(_psid), &_psid);
 		if (!psid)
-			return false;
+			goto hotdrop;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_PSID,
 				ipv6_masked_addr_cmp(psid, &srhinfo->psid_msk,
 						     &srhinfo->psid_addr)))
@@ -222,7 +244,7 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			  ((srh->segments_left - 1) * sizeof(struct in6_addr));
 		nsid = skb_header_pointer(skb, nsidoff, sizeof(_nsid), &_nsid);
 		if (!nsid)
-			return false;
+			goto hotdrop;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_NSID,
 				ipv6_masked_addr_cmp(nsid, &srhinfo->nsid_msk,
 						     &srhinfo->nsid_addr)))
@@ -234,13 +256,17 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		lsidoff = srhoff + sizeof(struct ipv6_sr_hdr);
 		lsid = skb_header_pointer(skb, lsidoff, sizeof(_lsid), &_lsid);
 		if (!lsid)
-			return false;
+			goto hotdrop;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_LSID,
 				ipv6_masked_addr_cmp(lsid, &srhinfo->lsid_msk,
 						     &srhinfo->lsid_addr)))
 			return false;
 	}
 	return true;
+
+hotdrop:
+	par->hotdrop = true;
+	return false;
 }
 
 static int srh_mt6_check(const struct xt_mtchk_param *par)

base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.34.1

