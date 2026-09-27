Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88041836E
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526696; cv=none; b=OQ8T3BpPK0duVH/DsbYUhJ+ng0v0I6AGirit5Uxuy9JIoryN/k6TEQf1WElbpR8JfK8d8TGRYh+CIteHo/L+xWxfL3flUjtP3y9xe3/BFhbJt4okhbCwkcQr6latFKizHnQioeaJupgi4hjIwpj+Tsq94PbU4mRZehl8VqCNiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526696; c=relaxed/simple;
	bh=xtHgkLDLXdIRafLNhcILYt+MkfxN1Q9AfpswHsev6oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrpuq57PYhk7JZzSYMxunSOX5ayzVj7dJrOenMV2QD3888RijnM+RPuS7QbFHp6BWrLriCWKF0jSkYriLehAc6jTC84WRK4jAxmLYStJcZOmcJFV+GYpF0IB982BfvpWgp1dd+fZGgYUTKbbXFtPQjxfjn591PS3OHzzs/mRs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgpWlP3i; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgpWlP3i"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so2512332eec.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790526693; x=1791131493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tZRjOTFhnU5GAKoWVMmwGlqCnUjTFRNgvFnEoiZqddk=;
        b=OgpWlP3iO62GKnimLzp4+kaZUGM6O21ZA6ZhcVYVamD5wmxgoZG/H8JxP3zqE3gHrB
         WQh2E8N9WxKrmctOdO4DbnhqyHUcXJ/vd/Do2gHdjV9Hp2nZTpxYREdlU/J5DrhNri0g
         ZM1b+c8T5UIqVn9bclNhLJjhXr8x0sp5RbO1doIDrFz+lFWygONV035iR3eEO6bdqpvI
         qSVeOpDkm4tBLgE+ex1XV2xrHOtNRyuAcJ5SvJLZ9uf7ZXiwe4MXtPXdRLNsoIxEg3ap
         wzLnhcJqy+Pvl5O0VP29W7oNWBQ71WrliAS+J7eakIqCPZf1RlZWJndOBnSxc3U3JjSh
         mVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790526693; x=1791131493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZRjOTFhnU5GAKoWVMmwGlqCnUjTFRNgvFnEoiZqddk=;
        b=l42Jn2UVxPcKErx+BOo3G/LLuUwp9fgRhKkDUYsGzip59XJuCFFrqhC4p5VNDfu9j5
         CS7JwV/kpBYeoc6XETVZ7J0Epgp22l12p6g1lDs8mX8vvV4OL7ezgFXSqJmd9G9eOm4/
         bEao7VrCh1WAubzSYR6vKZVppkOScYC2iDS2cU9Ov+Z9CGvDIzPZiYU3oTb3ENF5H0S+
         SWknz4m3A9z0qgSZbinbCDkFBN7cVV+vA/f1nG4MOThWIaUdVuBAiVooeAV98GSjWg91
         /GIaIsWgd0h6rAkU1Cw9Yta76QTwqdVdFmprtRnaS65yH3GKS17W3J3fXbPuTvUZAVzN
         Kh1Q==
X-Gm-Message-State: AFq9FYJgJavH8V6TsYcQSfE2+fpjHtvr5O99t5LPMIf825glw7IQtq7V
	DG2ghEIdzJvaNUbjWo86njc7YkxaHaZj9u+pmaiCtDgKNWyJBQc/S14j
X-Gm-Gg: AYBFou2bK/YfKPV8wb/Iuu4RHPuGuYrgUB6fG2mZytaOa9j70bojckhv0CgGuc4f80Y
	3JHmsNQoPYjt9kHCWCS1K7s97QwtkEaP1fgp7QG8VkEB0sxP+FT4FjbMkTLGb/xpdeZ5JbS4mX9
	1qr6ELKyiHUQq24lGmnmbpRw/ZHQS6YfhVN1Qd2sVZ0Z6YNTow+w/vpvmXZ0kHUSOhrp2Nei4/W
	ZULj+mQ+eJoWHeO7g2J3z5BdEErckg6TjTUJqsmfzdsQhSqyKNNyFxih5MxymwPsEPr35UXNH5e
	yF8QlVS9+jAAYBZ4sw0HIOwZZuED+ZyzO1CyJLVCUjuzKS3FBybCYMnTRS1faFYtGURqY7TmYZi
	f0hYlzhsuuDBpbGePsE9XezStOOtK5EdhJN4o94NiwbabJtbvHkgZyqbrnO81WBtT3GApPQkcvy
	zA1S5Bh3+kE1qVXi/ExW0bsnP4Ap5fqDH3x8IcZemUAzUNa/DsbPVigCyFBV5sZyd/TykESJobS
	NB3zPfXhOuCVsviXtkQyzz2u91BybVi
X-Received: by 2002:a05:7301:2324:b0:341:49cd:6815 with SMTP id 5a478bee46e88-342709b5850mr6503247eec.18.1790526692387;
        Sun, 27 Sep 2026 09:31:32 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3416e4c2f50sm22383449eec.27.2026.09.27.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:31:31 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	co+1fe9b56e2c61be5e@bugs.sh,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] net: gso: validate TCP headers before segment length checks
Date: Mon, 28 Sep 2026 00:31:16 +0800
Message-ID: <20260927163117.746432-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_gso_transport_seglen() derives the TCP header length with
tcp_hdrlen() or inner_tcp_hdrlen(). Both helpers dereference transport
header metadata without validating it first.

A TUN user can supply a TCP GSO packet without NEEDS_CSUM and with an
invalid IP header. The skb remains GSO while transport_header keeps the
unset sentinel. TBF and police can then reach the length validator and
read tcp->doff outside the skb head.

On the RX path, CONFIG_DEBUG_NET currently lets the unset marker survive
to ingress while non-debug builds still apply a temporary compatibility
reset. Validate the consumer instead of relying on that reset.

Validate TCP header ordering, linear bounds and fixed header presence
before either public GSO length check. For encapsulated TCP, validate the
inner offsets while allowing the outer and inner transport offsets to be
equal, as required by IPIP. Also validate the MAC header for the MAC
length variant.

Leave non-TCP GSO behavior unchanged. Those paths do not dereference a
TCP header, and valid FCoE skbs can have no transport header.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen
  Read of size 2 by task poc/133
  skb_gso_transport_seglen (net/core/gso.c:155)
  skb_gso_validate_mac_len (net/core/gso.c:270)
  tbf_enqueue (net/sched/sch_tbf.c:260)
  dev_qdisc_enqueue (net/core/dev.c:4227)
  __dev_queue_xmit (net/core/dev.c:4884)

Cc: stable@vger.kernel.org
Fixes: 4d0820cf6a55 ("sch_tbf: handle too small burst")
Reported-by: <co+1fe9b56e2c61be5e@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/gso.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4df..7c76f721fe24e 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -240,6 +240,29 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
 	return true;
 }
 
+/* TCP segment length reads doff, so validate its header offsets first. */
+static bool skb_gso_tcp_header_valid(const struct sk_buff *skb)
+{
+	unsigned int transport = skb->transport_header;
+	unsigned int tail = skb_tail_pointer(skb) - skb->head;
+
+	if (!skb_is_gso_tcp(skb))
+		return true;
+
+	if (!skb_transport_header_was_set(skb) ||
+	    transport <= skb->network_header || transport > tail)
+		return false;
+
+	if (skb->encapsulation) {
+		transport = skb->inner_transport_header;
+		if (transport <= skb->inner_network_header ||
+		    transport < skb->transport_header || transport > tail)
+			return false;
+	}
+
+	return sizeof(struct tcphdr) <= tail - transport;
+}
+
 /**
  * skb_gso_validate_network_len - Will a split GSO skb fit into a given MTU?
  *
@@ -252,6 +275,9 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
  */
 bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
 {
+	if (unlikely(!skb_gso_tcp_header_valid(skb)))
+		return false;
+
 	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
@@ -267,7 +293,12 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
  */
 bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
 {
+	if (unlikely(!skb_gso_tcp_header_valid(skb) ||
+		     (skb_is_gso_tcp(skb) &&
+		      (!skb_mac_header_was_set(skb) ||
+		       skb->transport_header <= skb->mac_header))))
+		return false;
+
 	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
-
-- 
2.55.0

