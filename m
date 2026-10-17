Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03722D73A0
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200089; cv=none; b=jj3K8tnTVjskrzQlAF7JcRdU/aMLyXxM4Oj/2j4w6ja9ff27cTa5HdCe4+A5BJ5YElW5uMyBlm1NpMWeVa3n5w5gVFLERklPzvRxf2bX9zKfjZYxbiOZzL4VP21hqqyLLlh3AWyaDGI4yyZFT/BcYlyGvhkQU/ONlyIVwURfIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200089; c=relaxed/simple;
	bh=eUvssHMgi9uWImtjEOl39Yas/phByQHZ1Ucu+8DH/Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONJU84C94EJmd0RQEK6YpNBzzuQvBKZoNzkw7O0IZL7Bg9g+aQW2UamCRnxsXTtqecc+HtQJGGABshRO4yMLqFffjhsUlPCmk9Qf2tLHW2MioP32+Hwx1cC/sydq/TRlRMNx8WD2zdYWHOmpp9hmfqbqxI6GD6Y7D9UsIYULgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8/eBX37; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8/eBX37"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987a2ba0cso3230375ad.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200088; x=1792804888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qND9eoVfb23NMeltyU+Z7QueTQJ5SyLaDy+fo2vIfdI=;
        b=i8/eBX376sQI2qnNsMQud1Yl0KWqUKrRADPpYborfswq7SCK0JTyE3fjZZeHMQdpao
         cvGNOopvoOqapXTHLU6dVUKt1rG2rsxVgo6plkXIzxmX8SkufPZis10+gnySEXtA6ULB
         B7m4tGDFq7gYy2A1M4cGB+KtLIBVUf76AdyZ0AFr9vCG9VMccxUc8sLfApquQEx7EZQJ
         juo77h30bkn+IP/aBwPE2Ie4WeqclcIanAcKVTHlvdKvc4nvXd/FMfvhEtx92nCk496K
         pMPGQ6J9vFyX6DadmvBM8nJdq0n25hZDVxW2lTXZe4pXBsZdC6Pw2i0w7OvPzutRMJJu
         4bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200088; x=1792804888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qND9eoVfb23NMeltyU+Z7QueTQJ5SyLaDy+fo2vIfdI=;
        b=Bozap3Ahlld67LRORE8ZHLbalDYvffI9oP98R7NY0QOngJyXrOPwvBRnyXdxw5pMq8
         Xl5vmvEJ/viGjx9zHrUMR5drNZvOzxALEzRMijE63/CX6ksdFZsSwqRQth/Zklnt1suB
         zMYXArO6PZw5UMdr5sM1TEmu+17ocMTjolFeDVTC7x2g03GZiPm2gyLwNf4K98ZYKK6z
         f7PjZDA5CA4YIxbAQsfqqOtTxGHUDEyvx0lPONro3Yb/gD7avffG27JupK7kLDvGzMxr
         eXd9rfSCYN4GwW6KNjhp10+SO2gDoSjYB0sRorA+m3Jy5jV/aGfICZ1Y6H1TSh9ohL17
         IGZg==
X-Forwarded-Encrypted: i=1; AKwUvBw/etHeimqJtfogYBdFKyUIVYwAaieIuSaaEBSirdh8eOsU/Cv5mZjAq/g4u7ps//YHEuhMORw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjrBeo3E+tXZDpZ3U2QONb/IeScgu7JberGILVD1aZncx0q40i
	+l9bPcZXhgTmkHIpn+R3HFKmNDQFr1EViaiJGjd8yaDkSn2ejlJJUUL6
X-Gm-Gg: AYBFou1mobZmlE1r9s1tFmwBBHFAgDv+yoXf2G1/MeF0bKqk0ujjwi6YOpuXzhOCWbs
	T8zj3AngZaKQp1U2TQ0Hje1rycps54Q1B6PG1yb8hBXF+oVEFhXUZXl3gY++SS1BTfoqkHpiXbY
	MV+Vz06z4jdzD7V8oVGD97v43bhKMFEK6Eo5cBEEGLHZvviefqhmX3uEfrpgbqMCYGMSKdio055
	hJLJOept22iuhJDbOUTphudN63tQIP6fVrQc799/1nJhIJyGpe7d+vdRNq7TTq88N3396ZhNNIs
	pfQt+N5bCfIA11NY6f6I+LT4yMzQQyR9UFT1F9EcKhmsHTO4ehUZWVoe4rf67LWz3GwdQ+1jxOn
	SuW/FeqUqyX8ITXbGR6ls5lcMJ8VO+2gPG3H/J5P5hp6HOcn7ngAy0nRtlHjJZkU6hUqZRKVe72
	L3vYxZzfD203UEU9d08kpkKfUAXOQfHOR9h5hVAI+hca4XVQPnItjN6U8hT2Ruyi0cggGBVt946
	JXqeFp0UgBHinCNDL3GevjuRhRckK7EZmgGvTfpR65bAYnwWjwUgZHxtRHCY/7kdEKHHMoJYzW8
	mLpchZujIDvQA12WpEm0gGL4MxEp/fWVQA45DDYPRMM=
X-Received: by 2002:a17:90b:4d88:b0:3a8:cb54:e135 with SMTP id 98e67ed59e1d1-3acef134c30mr1497740a91.19.1792200087871;
        Fri, 16 Oct 2026 18:21:27 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9e47588sm3341060a91.1.2026.10.16.18.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 08/38] bpf: don't let bpf_skb_adjust_room() use up the MSS
Date: Sat, 17 Oct 2026 01:20:28 +0000
Message-ID: <20261017012058.355787-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

When bpf_skb_adjust_room() grows a TCP GSO packet without
BPF_F_ADJ_ROOM_FIXED_GSO, gso_size is lowered by the number of bytes
added. Nothing looks at how large it is.

gso_size is the size of the segments the peer has sent if the packet
comes out of GRO, and what the sender has written into the virtio header
if it comes from a tun device or a packet socket. If it equals len_diff
the result is 0, and a packet of up to 64 KB is no GSO packet any more. If
it is smaller, the 16 bit value wraps around.

One less than len_diff gives GSO_BY_FRAGS. skb_segment() then takes the
length of each segment from the frag_list. A packet with more than 64 KB
of payload gets that far, and one from a tun device has no frag_list:

  BUG: KASAN: null-ptr-deref in skb_segment+0xcf1/0x1a90
  BUG: kernel NULL pointer dereference, address: 0000000000000070
   tcp_gso_segment+0x1be/0x9f0
   inet_gso_segment+0x288/0x740
   inet_gso_segment+0x288/0x740
   skb_mac_gso_segment+0x179/0x2e0

Refuse to grow such a packet, with the error that other packets which
cannot be adjusted get.

Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba536be2915f..a18702f89feb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3612,6 +3612,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
+	/* The MSS is lowered by len_diff: something has to be left of it. */
+	if (skb_is_gso(skb) && !(flags & BPF_F_ADJ_ROOM_FIXED_GSO) &&
+	    skb_shinfo(skb)->gso_size <= len_diff)
+		return -ENOTSUPP;
+
 	ret = skb_cow_head(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
-- 
2.55.0

