Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94793BFACC
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492722; cv=none; b=TEcwALwWEqGUytMiPu6kHL3U+eracS9klP1dyRdtf8d2LMmvvwr/llPOBSbyrNeasNZtcrv+Jndu+tEekxnpfCGnHjwhSOLte/uTEdR+H5DaHNPf4AV46zfjN6rJkr+LMMa1hXfnmFO87kq8mUL6HW54DRVTCc3r/CuKGpHZQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492722; c=relaxed/simple;
	bh=GuRG14+GUqNxXSOU0NL2TWNoa3WuTJ+S20HtqcOTRIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZbTHuMHRkSwU212hq8Ey4e0pk8STRGMXLQp7tTPWRMVUHAiwu7FRpEITqvnPdcretMGPlxHeuTSEw4vQBXPSN/MdDEwokEbkNsTipcGvKg6pse35Li+yB3apkEMyTgJItmPne7hKqklPBLFH9arXHwL6kKOMNUJ5T9bjWgm/UaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTzEs4/O; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTzEs4/O"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8568e3ed034so408950b3a.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788492720; x=1789097520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hXpXx91/E6BCZemGz0ldXBc04ihy3mbQ+Y8EH+5h9YQ=;
        b=gTzEs4/Ob070L5siqz8VRtDLbNNOWPwE4gvEeKmgmbWzc171cJiqYGDh7jNG/1NWed
         2hxjzCtw3NU5c3pOlp4hmk3G21s/iLB/L/5V1Smj9siEPxhBJZUHWIZRtTCSwe14aSUv
         JJrFBhSmU/h+A//r6qTFekiP8vtZ0SbAyYbQEaFg8St5kSDG5RkrpAjIURtaARzHwEks
         LUQ6hobxwZuxuG9/pRRrPsIOj8TCTrX3sgGpr35tN1jQ5M33s+iIKKGT2lFEdSnEHHtf
         OIWvtvSLMHqMf5bc9oKaHAjjiwvOw1Jp/pVxclncObmHZu1013snWk6nyCBHlp3WeHEb
         2IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788492720; x=1789097520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXpXx91/E6BCZemGz0ldXBc04ihy3mbQ+Y8EH+5h9YQ=;
        b=VmWqzGikR4n8bEHgBsbEdeTomT3vUj4QRlmYM/dBtrNP4miwSmlSgZNZkGCAvzf/Yl
         f7s82nsyDsD0xUzT9cCLvJ86CVswnGHpHmWfBOQJHSd7VJWaVnkae8i1Ry3i+/pgq+/U
         QOyp5mVsRKtkv8HfU6G8U/yL9gNwnhFGu6L+fdMa6MczJt412KAfHXEbtYom1NtFuSzD
         loGgHcZSXFKj5mrNdk1lVrXf5q5KIQBjEFBrEZq/RdIv2Gb/1UmoSesngEMFScYNDlMA
         zrhUEATRMT74PK3DtycgImZ7HHeaAEHplJfRa/6brN7sbjVe0X9CH7tnoZzorqTjHPxG
         cXnw==
X-Forwarded-Encrypted: i=1; AKwUvBz/w77/IXXaiqkmOsZh5m6BPHwntN+Lt7RnfjdRgMwxBonPjSD8ruiMcx4lx5ZxgCtXDKgXNjw=@vger.kernel.org
X-Gm-Message-State: AFuF++lEyHyNSjQhEI/ZxLD4Pp+R7VF/pQC6rMiUHK5zc6zFfJiCIYam
	XnjE65vXf3eFtjAw0TGs8Tun0Ak52CGIHIVAB6RxmKw2Ixikaq2bPdMVTgfnriOa
X-Gm-Gg: AYBFou2i45tKrY3Iw8DCFxdvcvqLlhmhurj04lZom4v8W64jDoShbEhmbyLUcASkUKN
	EGZDJ5oWg3vQz9/2f5HgFL0mTG8BfQJ9SCtgXjKMWaUKGLiTykoDYlQiDAx2jqV2vRsrOjEWNeg
	9iWtK5a7pZUDbRBz1dLoVyz2YMuVhPBQevKNa+5QSM0UYzYNpn+NPQYzxhfkI/YGoOMsuLEY/a4
	wxnxR45bA5cvYqHBf6JKleYY3UT+gf3pcydIIUYfCRf1YF9MmEbLUh9FWKQqSFIo1s4vQzn77rI
	XgtuQIcbYGPoV+6AJi24sBIoHmO6ncy1Ia1Axk+cQKJHOJAh3pUg8LcTgMzPb30JykfgIiKm8Ff
	G0w+prKxBpy7FqsR6BbKPoLMUEoZ/Qdu6PzeDq265JsUoI5ifrnKb1Rt6U+iV8694zztPGSuA0p
	H06rg+Bxj3f+yWajxdm/bZ/GmeMcEEyvSNq28lX9GrBE6oLyw2YvKu6lR5dohHKqtpvnDAW5A=
X-Received: by 2002:a05:6a00:8009:b0:852:3726:dfde with SMTP id d2e1a72fcca58-8616809429bmr4802620b3a.9.1788492719962;
        Thu, 03 Sep 2026 20:31:59 -0700 (PDT)
Received: from c79ofce.localdomain ([103.165.85.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-861537284ebsm598927b3a.48.2026.09.03.20.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 20:31:59 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH iproute2-next] iprule: warn about host bits in IPv4 rule prefixes
Date: Fri,  4 Sep 2026 11:31:38 +0800
Message-Id: <20260904033138.10620-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv4 policy rules match the from and to selectors according to the
supplied prefix length. Host bits outside the prefix do not make the rule
more specific, but ip rule currently accepts such prefixes silently.

Warn when an IPv4 from or to selector contains host bits. Keep sending the
request unchanged so existing scripts and kernel-visible behavior are not
affected.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

I noticed this after seeing rules such as:

  ip rule add from 192.168.0.147/24 lookup 2

The rule is valid, but it applies to the whole 192.168.0.0/24 prefix. My
understanding is that this form can be easy to misread as if the host
address mattered.

Changing the kernel dump would alter user-visible behavior, so this patch
only adds an iproute2-side warning and leaves the netlink request unchanged.
Existing scripts keep the same behavior.

---
 ip/iprule.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/ip/iprule.c b/ip/iprule.c
index b56b1b18..d358cfdf 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -276,6 +276,18 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 	return true;
 }
 
+static bool inet_prefix_host_bits_set(const inet_prefix *p)
+{
+	__u32 mask;
+
+	if (p->family != AF_INET || p->bitlen < 0 || p->bitlen >= 32)
+		return false;
+
+	mask = p->bitlen ? htonl(0xffffffff << (32 - p->bitlen)) : 0;
+
+	return p->data[0] & ~mask;
+}
+
 int print_rule(struct nlmsghdr *n, void *arg)
 {
 	FILE *fp = arg;
@@ -1000,6 +1012,10 @@ static int iprule_modify(int cmd, int argc, char **argv)
 
 			NEXT_ARG();
 			get_prefix(&dst, *argv, req.frh.family);
+			if (inet_prefix_host_bits_set(&dst))
+				fprintf(stderr,
+					"Warning: from prefix %s has host bits set\n",
+					*argv);
 			req.frh.src_len = dst.bitlen;
 			addattr_l(&req.n, sizeof(req), FRA_SRC,
 				  &dst.data, dst.bytelen);
@@ -1008,6 +1024,10 @@ static int iprule_modify(int cmd, int argc, char **argv)
 
 			NEXT_ARG();
 			get_prefix(&dst, *argv, req.frh.family);
+			if (inet_prefix_host_bits_set(&dst))
+				fprintf(stderr,
+					"Warning: to prefix %s has host bits set\n",
+					*argv);
 			req.frh.dst_len = dst.bitlen;
 			addattr_l(&req.n, sizeof(req), FRA_DST,
 				  &dst.data, dst.bytelen);

base-commit: fce739fa4f2ec83206d8d9435aa94ce22f09cdb1
-- 
2.34.1

