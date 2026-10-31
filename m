Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423277;
	b=SFPvr4UdJlnLZxeEoT6FLSOgmnQIm8ZAlr1xn/Lnj63gr84ueisbdnPUrJAxPXjzOzVr
	 lF3lwtvZVlnh3Pjglo/JUYoNJ+l0qr+hZd4LzsWWgAHjqRW8BmipVsVyZF1TDzbK7yNK3
	 3naMqexy8AqYoGYNw5EoowqsowRwXm9Ym3MRxoe+0NIvzLweQ2TyrElcW9JMe62fQYR1E
	 M4HL93JVCDmxPEtzHGJWxdgbxbr5CELEeEKz9ATvsSPT5yIhtujxYPrVypFhkhK1kpOJX
	 NMpINk1ZoSwzPGP+hUHPgK7ioJKNDbIiM3ly8ly+pquA8fqtlkQnedsmSNtPvqiV1Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LHwpZd2hxgw9EW+51k+f4+mN+FOI4H2HOB0NQ4Pk+Sg=;
	b=4LtrZ/Ll1hPZPp9zoB2LhUoNETpkBI7I0/ivEThVD24algdjNJ60XieBXpPsl+ZdeaRX
	 l4zi+z04Bri+JbvzcFGyA/Wsz4AvSQvipmQxGXQ+9WLtm0/IEhD9+jgV+1+rfL7P8VlRY
	 RE2v4F5k6MYj7KEE5qSQiY9ETyfMomgGho9aAdYPe3UgiK3j1BB2Iq4TP4nNKPWC5FXBg
	 a0l+btsZ8zizELl9QMe6KCu6trK8tG45joMSHoN1tNlcOslKPXvd0n6hGtu846Bc52cZk
	 n5gPLKI4aFx79JNGd0pLLVB5PXbjcnDhvDZFXLDN0YDduLDUoClBigvi6m3N/X49q4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=JIuk46PK;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C07606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 05:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=JIuk46PK
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4932b13c4ccso874909fac.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793423275; x=1794028075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHwpZd2hxgw9EW+51k+f4+mN+FOI4H2HOB0NQ4Pk+Sg=;
        b=JIuk46PKuL3WEnPTO4ohToX07UJwVSchjMXxsocHyjk2/oJSQ0bF1XU3rrDNDiTZzo
         oRbFyEhM09Np6ZESZH0yLqCNF8a4jSRE/C3quGuoYlYl+UV8Rz00i2c8d1Hx3iZi6p+I
         z5RFvVBoPb/Ygg8gGBDs0OAbDjYujx5udli1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793423275; x=1794028075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHwpZd2hxgw9EW+51k+f4+mN+FOI4H2HOB0NQ4Pk+Sg=;
        b=Me4999SKABxpkPH/XCKm1vGAMkciR4XDmuzQm5oEatBwZPRp874EFLtnmWbivFsi0p
         zw6ZeQlz176SXvhLa6pKIDF8hKtdQ60sMZmo4PNGKyT8D5DaL0NR87ocL9BBBYARPsNS
         W8Pi2H9HDVWQgz6NqG+q/D0y2EL6KaPhd48vo/iecp4sHwxsoqUYLOkAkXzGoV/hP/tG
         LvGFpghqCZfcCdV45BTFl1kHrjkmEuodUAlbL+pEQ9aZOI6T2VyEDCW+TPOSPfLFVbUY
         rw9eJnXYA8BnsPMifQip/UbgkUoNNjk1FAdQbGVTW0u8x0dFsgRGoKyNUA1ZCvHH/pOh
         NKBQ==
X-Gm-Message-State: AFq9FYIrRKotT0YKmVNnMTN3q+ZENM9vfqf0yIjIOmjNoWG/1L9BQX39
	Hq6/oasQ4PSbXPckPuBLRpwhUg8gIj4IaGS/mdnPevXEgsAevA1puj42gPh2bLKtny4pYD5w1/H
	S8QLv/FY=
X-Gm-Gg: AYBFou12btCKzW9CpvsjmzEnig1yfqMCeFd0yxrIPOjZ6+tib7GNQzLcU3fm0Ge38qX
	YqqEvAVuURfkAm4tWlQq1KLZVFnfHJMST/+2Iz2emlf0X2dyrKKfsoQ75JuhbvycbwDKzpfTFjf
	VkQk7uedM1erk+Kyoo7GzqpXhKjexKuk398T7Bg5kOOPPUHCY7Hwp239BkGy9HmU8q99cf62JE7
	H8lZSnjsIBCUAuV4qY3pq9z0Q7aKd4z7lS1ho21leDmkqjTqrtr7eRijVSv740VXyC0pWvu5Q4S
	V0pGh0wl5gkvbXxfbr1A/mC5lQlf/EoiBLdX14lexLjcQpugZ/WveEDfSC7lMFoMdXBtQhuxbUF
	+CyV1/S3heiO0SL6vOqOgCGzfAHtoQaPolAzVjLvWCz87Bn8Rlpnb/XmOuis7L1KOEuv7SYgc9l
	5+VXiKoJ9GA/XYKOgmRrO5dJOshXSNfqmm3rO7jj8XEyU/K+7rSRNs0zRUMBfSSJCdKIGZ4r77+
	AUnXE/Nr8FwZ5iIIKSw3bB7HUHr45HmKkJrnSwqoB9eWfhrGMo9vqSnC7h12Gdej4fkAzQqTnxg
	dZI3CKS0VjKn4vkfPJCSSR8pUTHZL9EkWn5veKnjXd+WiODm5m7fh1JlOxnUZSOUj0YvEb5GXnv
	XjATjgNIx+eHZ7efy+R7BiMfddk/Ifg==
X-Received: by 2002:a05:6870:8092:b0:4a6:f676:ecef with SMTP id 586e51a60fabf-4a9077af209mr3002687fac.55.1793423275411;
        Fri, 30 Oct 2026 22:07:55 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921a60ea8sm1626065fac.15.2026.10.30.22.07.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 22:07:54 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH net v2] net: gro: avoid parsing headers from shared fragments
Date: Fri, 30 Oct 2026 22:07:52 -0700
Message-ID: <20261031050752.31869-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an skb has an empty linear head, skb_gro_reset_offset() can expose
the first page fragment directly to GRO header parsers. For an
SKBFL_SHARED_FRAG skb, those bytes may still be writable through a file
mapping. Headers validated during receive can therefore differ from the
headers later copied into the linear head and used during completion.

For example, changing an IPv6 destination-options length between the
short and full header fetches in ipv6_gro_pull_exthdrs() can make
ipv6_gro_complete() pass an out-of-bounds offset to udp6_gro_complete().
A userspace reproducer triggered a KASAN slab-out-of-bounds read there
on an unmodified kernel as UID 1000. The same completion path can write
the UDP checksum and length through the invalid offset. The packet has
trusted TCP GSO metadata and spliced file data, so it reaches completion
without an skb zerocopy destructor or a second GRO packet.

Disable the direct-fragment fast path for skbs with externally writable
fragments. With an empty linear head, frag0_len remains zero, so
skb_gro_header_slow() pulls each required header into the linear head
before it is inspected. Subsequent pulls preserve the validated prefix.
This covers both gro_receive_skb() and napi_gro_frags(), including other
protocols using the same helpers. Linear headers and private fragments
retain their existing fast paths.

Codex assisted with review of the supplied report, reproducer and draft
fix, related-path analysis, and this changelog. The patched
net/core/gro.o builds with W=1 using the supplied x86-64 configuration,
allyesconfig and allmodconfig. The fix was checked by code-path analysis;
the reproducer and kernel selftests have not been run on a booted
patched kernel.

The issue was found by an LLM.

Fixes: dff0b0161ad5 ("net: gro: parse ipv6 ext headers without frag0 invalidation")
Cc: stable@kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue.

v2:
- add Fixes tag
- explain that the issue was found by LLM

v1: https://lore.kernel.org/netdev/20261030042212.73949-1-kylebot@openai.com/

 net/core/gro.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20d..d6cf2d497934 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -413,7 +413,8 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	headlen = skb_headlen(skb);
 	NAPI_GRO_CB(skb)->frag0 = skb->data;
 	NAPI_GRO_CB(skb)->frag0_len = headlen;
-	if (headlen)
+	/* Shared fragments must be pulled into the linear head before parsing. */
+	if (headlen || skb_has_shared_frag(skb))
 		return;
 
 	pinfo = skb_shinfo(skb);

base-commit: 2a500a04d6f969318c05f46aedb6e73fc1963a00
-- 
2.55.0.openai.911.g06873a30d2f3

