Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF441BA9F
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175402; cv=none; b=DklRR/SbaXqlXmfsk54eWKeANSPfz/TjRedQ72MBArXx3Hg1u+3jAEFnHRjxUWtUQlU8WP2Yg21As9vRkgQbLnfoUOx4uwPZq7ACGhpL8HmtRn1MHTpuOnAKo3psadJtwB+1GpWeTbuB8Yxbpsgnk09xZ37VShvBJ66HwGaXbgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175402; c=relaxed/simple;
	bh=FHwgTAFzrXTx4iWKUJ9YccvNRh/Fg6wOoxQny8Xfg2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G68qRjhw4LosenRfra008id0vX6c9Nf7cHTsL1qHWLjhcNztQ//34nZeu2S+EFXU4KrCBd9GKooYYGqsQCBT0NJz/e8m3a6KmnpJC/lXTZjvfeJHS9CUonmYN7PEGTBTZX+0KZ0RM7Y77q5i1QONdDLDnfnB94gcjNG46Kmh5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVZ8kRGw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVZ8kRGw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf27856f9cso39355635ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785175400; x=1785780200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wj5zhB0vKynw1HsA+hmusZTlDhlC3W08hs39OKdbvAg=;
        b=XVZ8kRGwIUoIw9oAEz9W5mYVUaEKf/bwZN/2l4ef2QyNco1Iht1refrv9pHsXJKjsB
         Jy1PSnfczKYP2hY90yFYanQwWPzw3M6e+IQPsAvYaLqBfcw5Q5e/XqZo1obCObQt3Zm/
         F0R33PWdEIowrA4pC9NSwNaLjIfSEkcbiCALjFTKSSLkctajdPmLXc7vzzkYFbZXjeb4
         JgOeGhQCZLHWmhZT33pUfgIYlzSyfjNCpjet/ZY5H77x0s5o0ch6AFel+GEsRLBjEIBT
         ZeLJA5QEyp/Xm/m/tRsmXDDgVXKYtcltxyltJMi65ZWcGyqTbZxCnAqEopEAbZw7rvJQ
         2Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785175400; x=1785780200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wj5zhB0vKynw1HsA+hmusZTlDhlC3W08hs39OKdbvAg=;
        b=LFthR94n1DNyphdZzMlpyiDnRUXfCi6UA6mHFffjS0mwBhTDg4F99WJKnPS03CQUYI
         ApyfnypugV4w6QUi+rFFYKMd67P+S+YidehZVIcsD87QZyuu4y8fTKYDzzRHMI4zz8yf
         6SZM6ObNdwTLHMiJE7Bs9HbiljJEH+a4rRx28BqrinJG5l0Kcc1FkUWtUgZsPB1rZudn
         BRPuPV5BnRaBiLQPNQNStZVEAPv1p3h13btWV4XMu3Ka7jF20ElUMYAvS36imMD4Ii9B
         I79G/4aEhDNAiG9Rl3sx2jVLDkB5M1BjNAtgO6C9HXHF36Oj3HRDw4NKwk6Lx4cKi0ZN
         OUGA==
X-Gm-Message-State: AOJu0YwO0/bLyXu5gLCUhAQvg8nhBWfxmcfDSFX0TQFeR18R4xjY6KrF
	ykjhCXlMKuVhk1iw1xC9WYpxQ47nXlIBj4fEMVOuidqidNzX31WdrmKTE3iLSnkOFyTG0g==
X-Gm-Gg: AR+sD10N+J7ifJsC8YEA8H5iN1um+2pVnShQwGEEWQ+KKzrdQZtl8JLciBAZfctQdV8
	v4RFHs2BV1dDfwgAWeYxM8OI4RsjJaqtWof+hkZtTB6J5v1p+PnTu0Zv+mvxGkmFgCWu0F4Sp96
	B05zpxSdiPKklSjChHgpWB8gXSUxgvQZvA2uaecYhmqRdmzmsDq5TCAtpUe9tuwCfsqHyWtDMVU
	/wN3/bwhD3I0OXGFBuqNT8IdncWSF+GXppbIk+7enjcUaXKB63+URRNYu3fC5DNPCgRD2QhNhRI
	CgIl726zIUmgUGquA7Z42SqqoSa3IwR1ciPVqkaVF5KWV3J0r49MlYPfCtK+GhNOMlBUvafLYrn
	UfYmJqpFJY+w2w3OeVeCpibaBFyoyYEtPi64VNBILiB+KVift5XP+f4Y+sHikEncHHcHX+mhghh
	9b3QiQD3aUv1EweQw3y8k7
X-Received: by 2002:a17:903:41cf:b0:2cc:eec6:558 with SMTP id d9443c01a7336-2d00f3e94b4mr2791655ad.39.1785175399822;
        Mon, 27 Jul 2026 11:03:19 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc338sm39171155ad.43.2026.07.27.11.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:03:18 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	jlayton@kernel.org,
	runyu.xiao@seu.edu.cn,
	kees@kernel.org,
	michael.bommarito@gmail.com,
	gustavoars@kernel.org,
	willemb@google.com,
	lirongqing@baidu.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net: reject IP sends with excessive headroom
Date: Tue, 28 Jul 2026 02:03:06 +0800
Message-ID: <0c6c64e9bbd71a0decc8504a384061e0e631be13.1785054561.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785054561.git.zhilinz@nebusec.ai>
References: <cover.1785054561.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

IP output paths reserve the output device's LL_RESERVED_SPACE() before
recording skb network and transport header offsets. These skb header offset
fields are 16-bit values, so every offset written by the IP output and raw
HDRINCL paths must be representable in that type.

Namespace-created stacked devices can make hard_header_len plus
needed_headroom exceed U16_MAX. Without a range check, skb header offsets
wrap while the actual skb data pointer remains after the large reserved
headroom. The packet is then built at the wrong address and later header
consumers operate on stale or invalid data.

Reject IPv4 and IPv6 sends when the largest header offset that the path is
about to store cannot be encoded in the skb header fields.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/ipv4/ip_output.c  | 2 ++
 net/ipv4/raw.c        | 5 ++++-
 net/ipv6/ip6_output.c | 4 ++++
 net/ipv6/raw.c        | 2 ++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e6dd1e5b8c327..c29af28ae1844 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -983,6 +983,8 @@ static int __ip_append_data(struct sock *sk,
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
 
 	fragheaderlen = sizeof(struct iphdr) + (opt ? opt->optlen : 0);
+	if (hh_len + exthdrlen + fragheaderlen > U16_MAX)
+		return -EINVAL;
 	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen;
 	maxnonfragsize = ip_sk_ignore_df(sk) ? IP_MAX_MTU : mtu;
 
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 7f74d8b95a373..4460a8db32bae 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -356,6 +356,8 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 		goto out;
 
 	hlen = LL_RESERVED_SPACE(rt->dst.dev);
+	if (hlen > U16_MAX)
+		return -EINVAL;
 	tlen = rt->dst.dev->needed_tailroom;
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
@@ -397,7 +399,8 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	 * in, reject the frame as invalid
 	 */
 	err = -EINVAL;
-	if (iphlen > length || iphlen < sizeof(*iph))
+	if (iphlen > length || iphlen < sizeof(*iph) ||
+	    iphlen > U16_MAX - hlen)
 		goto error_free;
 
 	if (iphlen >= sizeof(*iph)) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 368e4fa3b43ca..7b41f95a40ad1 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1495,6 +1495,10 @@ static int __ip6_append_data(struct sock *sk,
 		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
 		     rt->rt6i_nfheader_len;
 
+	if (hh_len + sizeof(struct frag_hdr) + dst_exthdrlen + exthdrlen +
+	    fragheaderlen > U16_MAX)
+		return -EINVAL;
+
 	if (mtu <= fragheaderlen ||
 	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
 		goto emsgsize;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b88d364e78aae..bb3803338eb91 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -613,6 +613,8 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	if (flags&MSG_PROBE)
 		goto out;
 
+	if (hlen > U16_MAX)
+		return -EINVAL;
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
 				  flags & MSG_DONTWAIT, &err);
-- 
2.43.0
