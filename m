Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC75328C7
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172126; cv=none; b=lXIETzS9Og/UPtvG5PWsMw3x3OVZrbd3P//kmozDNopgLSaLc2wtkK9zOkioo34tvTWvzLOJB1AHQDpZqDU7QoEv2nymKjFXC2e6hCFVKMBA+r8gMxWaPYS/eK64LfFO7dGQuvIZmpI4j5gk7N8s9DrW/r0hc7u2raLYfhSnVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172126; c=relaxed/simple;
	bh=7o0r4xT7dU4ZLo/lsVvqnCyZzuGUywIQIsoKQlG7wFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0n4lJGQWswb6UxtFYg3tz36CA/S8jfanriiO4qAziqZ0NT25ZM7PZH/eXYyr6dv7xIcvt95aRRJwlgAdb19js9kxdVU2P4V6lnJObbEaY7n7zf1SL3Pi7CgtbT4VQ+OPoRQWA5Hocybw4gjRxhwQ6HmjkqfLa48ihUNNxnszso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=bBE/TyJc; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="bBE/TyJc"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8631d0023daso542445b3a.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790172124; x=1790776924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nOvcdYU0dRk1zgquznwCGjvnJFZcKqDjbV30BWWVegg=;
        b=bBE/TyJcPh0eQBwaNyepPeQNCjMkmTcRE7j8pVTE6o5A4iKieCo2PXGlGOu+2Fs8Ms
         LN5UxNNPuivcDIJZCRByqS3u6LhOZpFPrbIEl7XrRirEJ1rJKVr0IdYgStU2o6BIC9cA
         M9YtvMXeuEBvMCQnIyXkj7ssGdesZJmQeF1qcdwJgh+bDWNsYBDW8wWwp//ckGRuHpGW
         m70UsNB62Bc6IftFUTShXPYdAD9CT9hqYEbLf6o4Sqp+IKt9EGbt8GqPdlvK8T6Vg3eQ
         mlrntYm8JpTEvJFfTaW6dXjxYS6pUs8MyCNNMC7ZDwE9tPzqkiVM6BHVkMtXCHx5wm2h
         ax1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172124; x=1790776924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nOvcdYU0dRk1zgquznwCGjvnJFZcKqDjbV30BWWVegg=;
        b=JGvPaY45T6uD/zMjVjfS+7k76PT+5JM/Qj0Q+R/JW4Om85UEDRPOQzWWFSvfszpkR8
         BKXH7dvOrTZeR+xokf/zHxQdcf5Q2rlgYe35zz2nQEOBiv8LQgr4NLHk0CuAwZyyqLm/
         NW5kme0EZTft+uaGsRUj+baev5NKgFV3aTpOzaIoROaARnOOCScBX8S/Es1Ybm25z+Yx
         +uB/ooDPQiBSyPzi95I7sYoJbogmvvVFa/FvVSKF3sFjKvg6J28iCwdUtxpbwk99KPrX
         XuvILB14DsJttSrXIa+rg4XDzT/U90w+gXbNgdcXQOi45oGxqHjShIjuRm5J8aJOWLtW
         7unQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgqsp0SaQD/L+5sf5Ld6zqM1dYMI3LhOJg6ouNfoBBtFqjfDVVP+z30pXxd+xOX4SelvuVVOE=@vger.kernel.org
X-Gm-Message-State: AFuF++n+poQnUZywDFkA+xeH8ApL0ZB1Xvi4Uxl56O61a6Rfhu5g3vIo
	dn4WTsyJZBCGiCZHzOPldxHu2E5RZZ/6pYwJ5WZDDUfSk5nlJ932cwaIE9R3Qv2B7Dri
X-Gm-Gg: AYBFou358UKcZXqmuG6y+rg02F33MLIERmRYfWQ8xhi0+bweoT8QOVkrxm1x0+4lCDj
	+0BzbJoRG142NORctslGm+nBj5RvYUJ19LZY0WzlLfRq8ryAkcCez91CSRDGTA2JoBLZlc+JWkp
	r1pJqwSO/w44nZJqa0lSp7uNMYD0vkbu53HZUDMhjBDVkHcBpVs//dwzFTsqtW/1OcTRnjzYJg7
	Zd5PUROvuwPQrBXsAUM/BVgXXYOF3RY3U7X/PpDDNFVALbgF7XZ8/e6h0XKAx7R7IWmk8zxv8EC
	472YtAa3GfxVNXgpLuddVrhzPwCCf6N5KZACVnOEKNnxHKUgGwvJ/BO9PoDHjBfwxXx+IdrpDvU
	1FDfdgB3SH0q3Qyba94CGPP8l+1yQ6bC6p46V2Pp79VMjjlVudReCRNNoD6XajtAmrcypeXkB0z
	r2ou7SYoKDoY0hIUVBMBXVi8smCnML106VUT9iaL89vrLC+IQLa82NlSDnobBMcfcw69wgBnnmQ
	qDSsrRS6eWBS1zBuFcRRNdCl9Ms1w==
X-Received: by 2002:a05:6a00:3316:b0:86e:8deb:fbd4 with SMTP id d2e1a72fcca58-87d1a7af6fdmr2599123b3a.11.1790172123010;
        Wed, 23 Sep 2026 07:02:03 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad42fcsm1328940b3a.35.2026.09.23.07.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:02:02 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com
Cc: zihanx@nebusec.ai,
	horms@kernel.org,
	kees@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	richardbgobert@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/1] net: gso: limit recursive IP-in-IP segmentation
Date: Wed, 23 Sep 2026 14:01:46 +0000
Message-ID: <8b7e7dad82a40e7bdb4721516823c8a7ae6106a0.1790161599.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790157745.git.zihanx@nebusec.ai>
References: <cover.1790157745.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP-in-IP GSO can re-enter inet_gso_segment() or ipv6_gso_segment()
for each nested IP header. encap_level tracks header bytes, not callback
depth, so a deep chain can exhaust the kernel stack. Making
inet_gso_segment() stackable introduced unbounded IPv4 nesting; IPIP
GSO/TSO later made the path reachable. The IPv6 stackable path was
introduced separately and shares the guard; Fixes identifies the IPv4
root cause.

Count IPv4 and IPv6 GSO handler entries in skb_gso_cb, initialized once
per top-level GSO operation and preserved across GRE/UDP context changes.
Set the cap to five, matching IP_TUNNEL_RECURSION_LIMIT. Allow five
entries and reject the sixth with -EINVAL before it can dispatch another
GSO callback.

On the patched x86_64 kernel, tracefs observed six
inet_gso_segment() entries for the 199-header reproducer; the sixth
returned -EINVAL without a stack-guard fault. This validates the tested
configuration, not an architecture-independent stack-safety margin.

Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v5:
  - Replace the header-offset budget with a shared IP GSO handler-entry
    counter. Entries one through five pass; entry six is rejected.
  - Initialize the count for each top-level GSO operation and preserve it
    across IPv4/IPv6 dispatch and GRE/UDP context changes.
  - Use the existing IP_TUNNEL_RECURSION_LIMIT value of five as a
    practical bound. Tracefs observed the sixth entry return -EINVAL on
    the final x86_64 revision; rerun both IPv4 PoCs on that revision.
  - Avoid rejecting a single-level tunnel based only on header length.
  - v4 Link: https://lore.kernel.org/all/cover.1790041241.git.zihanx@nebusec.ai/
 include/net/gso.h      | 9 +++++++++
 net/core/gso.c         | 1 +
 net/ipv4/af_inet.c     | 2 ++
 net/ipv6/ip6_offload.c | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440c..18944ff06 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,10 +19,19 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
+	u8	recursion_counter;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+#define GSO_RECURSION_LIMIT	5
+
+static inline bool gso_recursion_inc_test(struct sk_buff *skb)
+{
+	return ++SKB_GSO_CB(skb)->recursion_counter > GSO_RECURSION_LIMIT;
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372..e96ef6350 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -117,6 +117,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a..18037d8d4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1375,6 +1375,8 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 78f50c93c..099f14e09 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -104,6 +104,8 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.55.0.windows.3

