Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602171;
	b=PxKBgFY7fmTrH/url7ZQjReYOPZHJkn8eHT0sl8v5fktCS/Tfxw7dNENa6dTSFgwakKX
	 WYZX/a9nhpjYHxNs5KsudoijZjXf/Z1ACamAmkKuk9l/W4VcR6a/VnyrqBAmpuPT6YKOH
	 zmGM77LPnj1dhsV8BadeFGsHmLTtGP3ZhNvnXmE736RWnsqQBbPC6piBk0PskgaZQDTGD
	 haYOlS6xBK1R3dU8ArsdxjMnpafu9vajs1aR6lZGpfEl0U1DgYH4N9AE/jqNB/OEuygyM
	 M8aanTdQe3zRq/tHk+8K8j/D8/08gwjZI1+xf/XhXkTwNSVz4FxqwDlu8yOxMtnCGsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6VjuU2aTLmacVA9KDoSsRlNxzT6VBc/2/KWdoZzBwEw=;
	b=FQZdxMKTFaC5k+k4K0JK0NO+6nEgYtwieNsUM0DFxBw2kx34zn75az5Jd9JAZoecjiN4
	 IiNBkGxYOPlt0LDh1k72t3MvmCjrWobrndiOEMQRd3JPeitz8U+VIoMnoFuzSqMzsAvPz
	 Z2ogn6ErpcE9NcomCai/R3oH5XEkHtydNj9pTcti3pN0NtVNb8SBx+DSQsvbwR+TBEoFX
	 JF4XrzZ4j1Ee+OtgooY0G7iQaSkZzPZit8miEvmktBVzJQx7va1QIqDW+pcQkgTr2asTu
	 0uR/P5D3Sv/W0l+IJnyIswTMXs/z+2ty+sd01fnto12PXvEAfLV/1a94ClbcIvW0sdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rfka8TN9;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC00606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 06:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CC00606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rfka8TN9
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2eb0f1b592bso8547545ad.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 22:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793602170; x=1794206970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VjuU2aTLmacVA9KDoSsRlNxzT6VBc/2/KWdoZzBwEw=;
        b=Rfka8TN97vWvPfkaIIflW761ov3ZlJdPvWet7UmMNTF4AoSczsdojaq8RakwlCbphK
         OGgDQN7jTBLf8q66kN6g9Nss6Vp250lTk7KP4s7LMhNybbEz5bONT15VMHmd3y/gkPaP
         JLmJ433k2CXcmo0liiOF55wXza2eAQqizr2tT0Sg3hXKq3zRklBKbOKcZDq7z7fwZj4w
         xNh8xdBtAlmPMUejQeQlpe3nDQA+aMbdO1MbU0DcFAt4mKB9kYxVd1TaP82pW2RW0wwb
         69clgU2OkKzwFMWxbkBAxjMo/QqiYPZmkBDr+8rSwd1rNXYqVnbOLpgFheNb+q0qfoYm
         Xciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793602170; x=1794206970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VjuU2aTLmacVA9KDoSsRlNxzT6VBc/2/KWdoZzBwEw=;
        b=YNPqnoPWWNQ+2c3MBh3bIu/hr3UzLW/QVaJzyZhBOnMCjV90qyFpZUBEYqFO1Ip3XU
         cOv1alTHpB0rwD1qKCZbSSWCVjV3AwH7TvV5vud/n0WbWzPCyy9eigPTvIJcKXGLeTCp
         XV6vjmE3b/dlIo3t+kz0p7qajaUZvNROsAe4tFjFG3ELHQx5gi01ivkHeok+Wu47fRdC
         U+0MKrLL5YoPcWUP3crWN/UHgPVlg4mHPSE8JCg8nwgD5smALPXrzM2ra1RxcwNfh5m+
         9+Gup4PvZNG+q6gUfVbJhIBMWCn2NhU+cqcjKyruFMvZzmOTTkk7LVPa9jcRilUs1t2h
         er3A==
X-Gm-Message-State: APuU4Z9MS+iBOTyBSfHVUbBjdHfQJObPb5+WwQolZoZrrPFW/x+VkdTV
	XHWEUpsDnu5nC7r9rprDDXRZAPx2cJ3edyWLkUU3sPT2cfegJtSooVc1CVeVhw==
X-Gm-Gg: AYBFou1skc1iaIc+VS9MlpGt0dZcPx+2wdICh3IM6KQPrXOIAaxLw20iKEf11g59MuO
	aDDpZFYxn/Ko7l49xPEKaAydgIIy8SnmgawIAhaeLTi/+hkk+bJqc6V9WS8aP0fPMmAHvPC1xip
	dgqtwhuM1a7sngXF3oC9Ol4S35Wll9IOa6V6u2iapYxAfc5hm381JLz5eID9ejaKE72P5N/roSP
	elmlQZb5JVQnZNEd99ZcekFItHRnA089hCtpFRcmlQVqy6ctMAZ3Xu7NPLAVgOB1u3f/PTmGqBt
	N4t9M64cNrbgDwzqrnv1Tny2I3qKI5ARzwmbrHv1zh2qLOZJGJOZt2Hi31L1ygvXOwPH3alt6tH
	PjHMQjEfWHi2A/UWK/XVnEFEHyn+UBEQM5K0BTb9jNeIfObR0xx8GVK2YS3pGb7n7yPGRaZBHX7
	ySradClEo8fdK77ygo0JwSTur2A4DFdinyz57xzy4PwKhmedZeifOclCzf6zlJT95ziLremeVmO
	qJf3jcAHtcP19V9aF4QiUdpi3KkaC1aPL033DsYkUPVU9GtjYnV7XqioDqPGLVmTNOUCH6Hxtfp
	VOg0LEWWMZsVZNMLpGTpNMcEdnPfRLvfOE2qb8rBTum/lgJnikwwy41ARiMRLxoYjRrtcWwNkNV
	tBorE4b18dJgCr0Mx52CsCE+Z5Ijywz4yNhGPK1S3WDS77OH73xTMnDIbxgv3ClLxPi6cMtkyRQ
	==
X-Received: by 2002:a17:902:ef08:b0:2e5:ee16:2f8c with SMTP id d9443c01a7336-2eb36426e30mr90562695ad.16.1793602170134;
        Sun, 01 Nov 2026 22:49:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392965fesm23212825ad.59.2026.11.01.22.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:49:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	bpf@vger.kernel.org
Subject: [PATCH net] ipv6: Check the Home Address option again before its address is used
Date: Mon,  2 Nov 2026 06:49:22 +0000
Message-ID: <20261102064922.2636027-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

ipv6_dest_hao() checks the Home Address option and sets IP6CB(skb)->dsthao
to the offset of the destination options header. Later mip6_addr_swap() and
mip6_destopt_reject() call ipv6_find_tlv() with that offset and use the 16
address bytes. They assume that the same header is still there.

But the seg6 and ioam6 lwtunnels, the End.B6 actions, ipv6_rpl_srh_rcv()
and BPF lwt progs move or rewrite the IPv6 headers and keep IP6CB(skb).
Then ipv6_find_tlv() parses other bytes. It returns when the type matches,
before it checks that the option is inside the header. Nobody checks the
length of the option again. Thus mip6_addr_swap() can write after the data
of the skb. mip6_destopt_reject() can copy that memory to an xfrm report.

In ipv6_find_tlv(), check the length of an option before its type. The
returned option is then inside the header, and the header is inside the
linear data. In both callers, ignore an option with a length other than 16,
as if ipv6_find_tlv() found none. Then the ICMPv6 error goes to the source
address of the IPv6 header, and the xfrm report has no XFRMA_COADDR
attribute. Nothing changes for a header that ip6_parse_tlv() accepted and
that is still in its place. For the other callers an incomplete option is
now absent:

 - ip6_find_1stfragopt() and mip6_rthdr_offset() can return another offset
   for the fragment header or the xfrm header, also in a forwarded packet.
 - calipso_skbuff_optptr() returns NULL. netlbl_skbuff_getattr() and
   netlbl_cache_add() then see no option. calipso_skbuff_delattr() returns
   0 and the packet continues unchanged. Today it returns -EINVAL and
   SELinux drops the packet. It already returns 0 when an earlier option is
   incomplete. The receiver drops such a header in ip6_parse_tlv().

The code that moves the headers still does not reset the offset or the
other fields of IP6CB(skb). If the bytes there look like a header with a
Home Address option of length 16, both callers still use its address.

The first tag also covers ipv6_find_tlv(), because its early return did no
harm before mip6_addr_swap(). The second tag is for mip6_destopt_reject().

Fixes: 793832361fe7 ("[IPV6] MIP6: Revert address to send ICMPv6 error.")
Fixes: 70182ed23d25 ("[IPV6] MIP6: Report to user-space when home address option is rejected.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv6/exthdrs_core.c | 7 ++++---
 net/ipv6/icmp.c         | 7 ++++++-
 net/ipv6/mip6.c         | 9 ++++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 4a9748338cf4..764c694fb417 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -138,9 +138,6 @@ int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 		int opttype = nh[offset];
 		int optlen;
 
-		if (opttype == type)
-			return offset;
-
 		switch (opttype) {
 		case IPV6_TLV_PAD1:
 			optlen = 1;
@@ -153,6 +150,10 @@ int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 				goto bad;
 			break;
 		}
+		/* Some callers read the option, so it must be in the header. */
+		if (opttype == type)
+			return offset;
+
 		offset += optlen;
 		len -= optlen;
 	}
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a95b0351824f..d8203ebad882 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -343,7 +343,12 @@ static void mip6_addr_swap(struct sk_buff *skb, const struct inet6_skb_parm *opt
 		if (likely(off >= 0)) {
 			hao = (struct ipv6_destopt_hao *)
 					(skb_network_header(skb) + off);
-			swap(iph->saddr, hao->addr);
+			/*
+			 * The header can have moved or changed after
+			 * ipv6_dest_hao() checked the length.
+			 */
+			if (hao->length == 16)
+				swap(iph->saddr, hao->addr);
 		}
 	}
 }
diff --git a/net/ipv6/mip6.c b/net/ipv6/mip6.c
index 6a16a5bd0d91..961567972411 100644
--- a/net/ipv6/mip6.c
+++ b/net/ipv6/mip6.c
@@ -211,9 +211,16 @@ static int mip6_destopt_reject(struct xfrm_state *x, struct sk_buff *skb,
 
 	if (likely(opt->dsthao)) {
 		offset = ipv6_find_tlv(skb, opt->dsthao, IPV6_TLV_HAO);
-		if (likely(offset >= 0))
+		if (likely(offset >= 0)) {
 			hao = (struct ipv6_destopt_hao *)
 					(skb_network_header(skb) + offset);
+			/*
+			 * The header can have moved or changed after
+			 * ipv6_dest_hao() checked the length.
+			 */
+			if (hao->length != 16)
+				hao = NULL;
+		}
 	}
 
 	stamp = skb_get_ktime(skb);

base-commit: 714b7112017fc7f8b2afabccf562acdb12d2ea7d
-- 
2.55.0

