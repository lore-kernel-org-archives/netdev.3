Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476543815E3
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851985; cv=none; b=uxsVZpAbCJRqEXlzs8hkEDKCn1c/61adZgJ5s9s1ep+2KhjVC8yv0AczFidhpnP/fSYUjhXhXZbZAbN493q2I6zuc96w51JG9YVSHItkeEpIRdno5xkaw2/eiU35EOrpNsfGpkNj2KIttjoZIh2z7egWrh4MRhxQvCE8JreT1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851985; c=relaxed/simple;
	bh=1mZsbngPmUGZlsAHxnckBzeOtO8Zwy79cpor2SauIBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShRj9afrG97lnruYECGQPhutd5UPzBRDHA9b/KVX8NoZiZDnlcHtR//8odNFKGdhBmSdaRCW0T/JTL2mhlLxW7yboldqRIWKjEnlTPRxL09apLjnm8Bfbdxy+zDLvLt983VF2qNTLB4KsNKW70IE4ji38a9/w/3kllb0RseyvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZLE9j54; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZLE9j54"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso1311891b3a.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851983; x=1790456783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENqTX+NY7Ywqvs/LvA4+I8HL6U8Mdro5TSSkptMowFA=;
        b=MZLE9j54VoXoFO4uhGwdBXV+pdnQh5z/oFxoM1kcJ+NFz6FemvtH7Yx6RWJqZR8muM
         iEcB3zNwGUUkiiGgry1TJP1cCoyN4FU+JoQNIGwLvzbj2xsrKSwVzQYKoYES+O6RgTAj
         sqPofmGHeEF3QkPMrbq1KqnLslENNE0782Zzpze8OD3cqu3S6mIzAzjDLpEqB51gf4k8
         5ASHl6Gscm0uHbmUQt2jHodYfmral7PsuAx6CPY4FYcaY+L/DepDH0eN2x3BO8gGGIhf
         e8o0YA2WgIYLVno2E0a/bSV5rVjPvqwEce1YhjzlNrV/W5z1OSs0wyMh6zEiLbAH2VNc
         NSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851983; x=1790456783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENqTX+NY7Ywqvs/LvA4+I8HL6U8Mdro5TSSkptMowFA=;
        b=jArQSCTwrBvovDTfIkgf1yGnSxl/ejr78Jr08+VjlyY7ijGmBIdIDqqtJ9gkw72L7h
         1E93sXN+LK7QGoUmM5DExpnq/nf23JykYA/i2yhKpdmQyiPvDGy9r4kp0LnqU+6WrSTR
         N+9MHOgtBu1Mhy07LpBgLbfQ07AhWLIaA5Qg6PESR9RdHcVWbwjN4rbzWRpeO2t+ThOY
         mi+XFDToo8dS63mCmmkrfKPS1yhkp9Oxw3khR0gUDYwULZTyizlH6dHowuRGsjSGQtWq
         KzVYeMOw8MsE299RdI95Ztw9DW1ozCQWTbXsftelsL49T0JNBkIxg8Tf4LI3KBTvG4xL
         UWCg==
X-Forwarded-Encrypted: i=1; AKwUvBxl8OYBIVdYkeOj8snemuUYBidLkai1HxO4B4e5zwvRmyw4PF1qVfceGGHD1g1sBUZ8s8C27s0=@vger.kernel.org
X-Gm-Message-State: AFuF++n1GjoN5GUJYozk81f6BOH5gWSrjBtN17XwrQVTBq5r1TB+rxW1
	HMi8pCHnRTZvC1HuvcuU2ZODLF7Qzxl1Jl8SZK/KcTGrAskb0RShTmnm
X-Gm-Gg: AYBFou347aXiDq0nXlW1GvZ11h438RV2+a8nc6KojTmjwtmG6j9AQ3ZMGYygP4jQPim
	sEUfzTQQURDYb3/26MFFY4e1GA9Gyml4Xoj2LsRGpGL1o7qmfYOeaEJ100Hmo927oZHDd/QmHF5
	8PGBUtuJme9GjCWtVh5FxkmxnT2iZKU7nntozrAonSd+gIC5yMpiQE3O1YqcRUa44pteoRMR2Jq
	9JKIKTqZHWyS3baOecjQmh/mzl9Ovu5reqZma+MINIsdMaRquW0y0NeGxw3/ibMXUL/SNJBZbbV
	l7HTPNb1IRxTZRKgxcQMT/WSco+evxjSoLzlPEM/ceCOLaxvDC+ZlPF48bURADg2xNSw3AKxEdJ
	we2oolGMj9kH68cqv5tTiAaEkY+IN9VYeKgoaBraqBUdwP8J+DcFqFr681r5jaPA3efXhf+vCii
	LXvSdjSZ+pjwwSQnTqT2z/Tvevwk1J+XTyHjZgq3tlosWp4Anp+BNDq3VbHYt9DU5d1cCNrYIbT
	4D4zDF4wjhl4v6DXzHIrFefcjCtU1mH/Vq4mip0QF3wxzK2+362DllXpK2Rd1XcNXevVo7mCA6z
	SWMpzKq2yw==
X-Received: by 2002:a05:6a00:4389:b0:878:37b2:df9a with SMTP id d2e1a72fcca58-87847134851mr2309234b3a.58.1789851983519;
        Sat, 19 Sep 2026 14:06:23 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a95f2abesm1297272b3a.26.2026.09.19.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: paul@paul-moore.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: calipso: fix 8-bit hdrlen overflow and missing pskb_may_pull() in hop-by-hop options
Date: Sat, 19 Sep 2026 21:06:21 +0000
Message-ID: <20260919210621.3029744-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs exist in the CALIPSO hop-by-hop option handling in
net/ipv6/calipso.c:

1. When inserting a CALIPSO option into an existing Hop-by-Hop extension
   header in calipso_opt_insert() or calipso_skbuff_setattr(), the
   resulting header length `buf_len` (or `ipv6_optlen(hop) + len_delta`)
   can exceed the maximum size representable by the 8-bit `hdrlen` field
   (256 * 8 = 2048 bytes). When `buf_len > 2048`, `new->hdrlen = buf_len
   / 8 - 1` (or `hop->hdrlen = ...`) truncates modulo 256, causing
   `ipv6_optlen()` to under-report the allocated header size and
   mismatch `opt->opt_nflen` or `skb->len`.
2. In calipso_skbuff_setattr(), when `ip6_hdr->nexthdr == NEXTHDR_HOP`,
   `hop` is dereferenced at `(struct ipv6_opt_hdr *)(ip6_hdr + 1)` and
   scanned by `calipso_opt_find(hop, &start, &end)` without ensuring
   that the Hop-by-Hop header resides in the linear data area of `skb`
   via `pskb_may_pull()`, risking an out-of-bounds read past `skb->tail`
   on non-linear skbs.

Reject Hop-by-Hop headers that would exceed `8 * 256` bytes with
`-ENOSPC`, and ensure `pskb_may_pull()` linearizes `hop` before
inspecting it in calipso_skbuff_setattr().

Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the secattr.")
Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/ipv6/calipso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index c6a34334e657..b8b7451a16ed 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -944,6 +944,10 @@ calipso_opt_insert(struct ipv6_opt_hdr *hop,
 		memcpy((char *)new + buf_len, (char *)hop + end, hop_len - end);
 		buf_len += hop_len - end;
 	}
+	if (buf_len > 8 * 256) {
+		kfree(new);
+		return ERR_PTR(-ENOSPC);
+	}
 	new->nexthdr = 0;
 	new->hdrlen = buf_len / 8 - 1;
 
@@ -1323,6 +1327,13 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 
 	ip6_hdr = ipv6_hdr(skb);
 	if (ip6_hdr->nexthdr == NEXTHDR_HOP) {
+		if (!pskb_may_pull(skb, sizeof(*ip6_hdr) + sizeof(*hop)))
+			return -EINVAL;
+		ip6_hdr = ipv6_hdr(skb);
+		hop = (struct ipv6_opt_hdr *)(ip6_hdr + 1);
+		if (!pskb_may_pull(skb, sizeof(*ip6_hdr) + ipv6_optlen(hop)))
+			return -EINVAL;
+		ip6_hdr = ipv6_hdr(skb);
 		hop = (struct ipv6_opt_hdr *)(ip6_hdr + 1);
 		ret_val = calipso_opt_find(hop, &start, &end);
 		if (ret_val && ret_val != -ENOENT)
@@ -1341,6 +1352,8 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 	/* At this point new_end aligns to 4n, so (new_end & 4) pads to 8n */
 	pad = ((new_end & 4) + (end & 7)) & 7;
 	len_delta = new_end - (int)end + pad;
+	if (start && (int)ipv6_optlen(hop) + len_delta > 8 * 256)
+		return -ENOSPC;
 	ret_val = skb_cow(skb,
 			  skb_headroom(skb) + (len_delta > 0 ? len_delta : 0));
 	if (ret_val < 0)
-- 
2.55.0.1082.g2b9226bbc0-goog

