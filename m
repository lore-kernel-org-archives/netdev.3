Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDD2D7D3A
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824978; cv=none; b=tTGZ4YjsAVzzX85vaVEbe8RTZbf36w92H1Vmn8YmC/8NZsv+Ut3imhosc01cYdxXCJR07uyO4Dv4QkzjSR9/BmE7fDZDN0aAkFUpCxvrQJmdlLZTmS3vNpmd4rzHGUH4HHWuVD3HsFgVZp5SLbHfec22jSGmWsBO5jY9yka0UNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824978; c=relaxed/simple;
	bh=8W51nJyglvhOpn2VYDlSgSOas945wwOcnvCIqq4Jevw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoIXedd1zPdnh96npCe67U9u7gpwQu+tc+DhyZTjHgvi//6CFLUZLFNfWD6CHJsj/ssY9Zq0W6Xd3HZUHZkuaet/MTZnQZgS6S2r2tac7AQ44EMM+mKwk852urgdr14W8k8tGNfw8b6yP6a0M6UmWmCjTCVUto6DPHb7z6XCoh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKmJBgTH; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKmJBgTH"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so513009a91.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789824976; x=1790429776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X2UdrhoImrGC3N9b0j2Zq3y6Lv1BfZsed0QQhRYRPbQ=;
        b=LKmJBgTH8fmFcwzdHWh9EqVmNc8XSzTXPvWSEVd4+7MXFWJxNdD/pVq8e/EciEJrj/
         CmLRVNMAaJZvSwzPC9kQXz8CioP9pYpGSVHKPU4Ncd1oyv34XGL/Fp0x6+gNneP+0/G3
         76UgZRLL0EGQPfyqPoZIuSfIRKoResDiL7Tby3q8ebxgmBC/YhxaQiU0Myv3ElEucE9U
         1I2etNriWGgNpAwpODfEGnKeqnQKFmOaDcXNhHyAVrMjG0Z96e4RqMIzHWJaiAtuMQPF
         0U+UOfh/3HiLsGt3GxQg2VYlxIfaviu1qTyxJLQVcbQVEiQEhneeUU58amf7CeOdIrgM
         7ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789824976; x=1790429776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2UdrhoImrGC3N9b0j2Zq3y6Lv1BfZsed0QQhRYRPbQ=;
        b=K2EPxMbOFs8oUW9rA0XNzAg7bLPa2jTmzvP/WbQgrk68QIoQXuKCU4Aew+Y15dO9Mr
         hDQjldQSgs0o7bdirZ3MWqiTrHJI+Lz+S3tWVtm8zZhV6PDSLiGf8CGqJCjETvP7y06k
         cdOQpU+38dpszRL8FLupP31F6Pds2wFEV4roCTxgPMM4SxsC0erjcjJAN0q9oB8PgVnJ
         AAGVHu/rt7hJsMoSs0zvcRcSa+xwHwWgjGXNtLn3zG3/LUhJklnk7UGDkBBHS9u6ZIGc
         uN8/GqnbikWSNudAEm5VtdpID8q27fxsf2idn7roJ/Vs0b1IRWXUcsjJinsVJIbs0jo1
         TlBw==
X-Gm-Message-State: AFuF++k4W7NkAdDt1cWEpgz2dFPdK0Ru/uoSp+7VRjvhyj7uyF7GzB5T
	gon6eO8By3/CQ7p56VSTCztyP3uY0z6JYne3ZuVVmDQOvKGP+FsEpcHHwQkT83x0JfA0zw==
X-Gm-Gg: AYBFou3ayd8WcfjOKhcROz55KfX0nPJeO3ae/Z9A6RL+MRdsiEin0mn2ngY2tWXZ0KY
	M4Vm0hARVmfTembQXKjYD7HQTzVyu+01mNZtK0aCHyZIbTPvcg2sUQQVfVDAocnl609uhA+LvIJ
	ij2mwvOESBRLmHNjRxHuMd/DUdqhtlfYi3pOe7oyympchMJGpTmGqtOZw7A8+eKypik50fcm3/l
	d+2uKwnIuJmri0VHSOgrbHH8Kjg39bXjn+ZL0NdS9LCk5GhbCo3YNZM66ehybeTWXJiVRMj3jo9
	q7STlhpkwIVQFtO8Hcv/oAsGZQ+i9P1VrUCZxIwKD4p4ywZVUbrI0OpSI4wL5uw4klXxLeZmIyn
	qadAqzxgS4/wij1BFwRh4FsIYo5ZeyWy2U3j5YKzJ5etRreax5ItsxHkGBi0Q8EZ82CGROCeeY7
	MBBbRdhJWU4ZYstRGiv5lnyBv7xa0GSzaGPva29b3KrsEvW5n9jOS7ST/IFNkKi/rAnLsZTlv3r
	VNGF+tQYyOSLVLK
X-Received: by 2002:a17:90a:fc4b:b0:3a0:2900:f577 with SMTP id 98e67ed59e1d1-3a02900f8f6mr1240758a91.51.1789824976318;
        Sat, 19 Sep 2026 06:36:16 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c379c4bsm5039110a91.7.2026.09.19.06.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:36:15 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH net v2] net: skbuff: fix pull-bound underflow in skb_checksum_setup_ipv6()
Date: Sat, 19 Sep 2026 21:36:04 +0800
Message-ID: <20260919133604.50948-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_maybe_pull_tail() subtracts skb_headlen(skb) from the unsigned max
argument and passes the result to __pskb_pull_tail() as a signed int.  The
function does not ensure that max is at least skb_headlen(skb).

This can happen while parsing IPv6 extension headers when an skb already
has a linear area larger than MAX_IPV6_HDR_LEN.  Once the parser needs data
beyond the linear area, max - skb_headlen(skb) wraps and is converted to a
negative delta.  __pskb_pull_tail() then passes that negative length to
skb_copy_bits(), where it can become a very large copy length.

Pass the requested length itself as the pull bound at the three
extension-header call sites, so the delta can no longer go negative.

Fixes: 1431fb31ecba ("xen-netback: fix fragment detection in checksum setup")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
Changes in v2:
- fix the three extension-header call sites in
  skb_checksum_setup_ipv6() to pass the requested length as the pull
  bound, keeping the helper's fast path untouched.

v1:
https://lore.kernel.org/r/20260823142620.126424-1-shlomojune6@gmail.com/

 net/core/skbuff.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cc3b4b70288b4..a2d7b2fbc006d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5977,7 +5977,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
 			err = skb_maybe_pull_tail(skb,
 						  off +
 						  sizeof(struct ipv6_opt_hdr),
-						  MAX_IPV6_HDR_LEN);
+						  off +
+						  sizeof(struct ipv6_opt_hdr));
 			if (err < 0)
 				goto out;
 
@@ -5992,7 +5993,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
 			err = skb_maybe_pull_tail(skb,
 						  off +
 						  sizeof(struct ip_auth_hdr),
-						  MAX_IPV6_HDR_LEN);
+						  off +
+						  sizeof(struct ip_auth_hdr));
 			if (err < 0)
 				goto out;
 
@@ -6007,7 +6009,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
 			err = skb_maybe_pull_tail(skb,
 						  off +
 						  sizeof(struct frag_hdr),
-						  MAX_IPV6_HDR_LEN);
+						  off +
+						  sizeof(struct frag_hdr));
 			if (err < 0)
 				goto out;
 
-- 
2.43.0
