Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E87363C6F
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200362; cv=none; b=XMF7UB5/rhOnEVLJM+BPT+v+0NXgUIbJBo82adp3qfFmaO5WmrkIhZvejlsWgaqFlke/d8uX3xHKNtH78xmGk/y+c8OaW4AXIDSgwWVaIm8wSN9Ade+kzPuMdTFvhIvgKUtNJ41Uk2O5VynmhaZuxsv854b+wJTLR9t2yC5W2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200362; c=relaxed/simple;
	bh=zk6wACFbhggEWceOYKisJFBuimFSjZGpAGx3520e3h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj4QZPcZcUQh1dPNLjq1EvzxI97+15ydmkmiICV2SKCUG4uXJY1mg5AkHFu2x4osy/vn/zGr6/wcr7/odSUv8/19/kcVf2xIt3DvWxV6Oi3gnLzbt1994gLwyOHgLzf5HuPNsxzTytHt43PX7eqbG2lUnS+cyzAinmDF3FDtnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1/s49YH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1/s49YH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso351009a91.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200361; x=1792805161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q5v0KPjUnY8OHlqXROvc59T8STwvIgaO5MHNNL/si3g=;
        b=e1/s49YHlHoIGUGFYpFPBJQllsvMub09qMBPbpbDTC30Dv8rmO3PhYoLmFiWC6xMd0
         5eUiGH+mWwHw+RDpyV8nSWd14eCkosEUyoNkoPWwye6bnGgVUIZ245+avbwPJ0Y9qD/g
         EPikrOaXVjASqde3jqc7mrhH5Nu62GQqGlSHA/UPhmV2z/k0hGGLEfJ5E/61mdZGgU+M
         29YTsxeDDid2vLDAQOitU/MTmWk1tQf6+oYiWdH3dv4YgRWMzKxVKo4K/1r7crUcaXWv
         9n1tHtyOY7jLS9WPvU6GoD8npazzszzbZy2VMyx7/94dF+TeCrWxnxpawO7w5BhTnPql
         NLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200361; x=1792805161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q5v0KPjUnY8OHlqXROvc59T8STwvIgaO5MHNNL/si3g=;
        b=vY4yDSzByMUah1wBMh7J2WhJfSaDcqJxX0HaHaAedlycaCvt4O8EaIt2dLJRGe+Rjb
         l15C4PNDFNFDuI/wy7+N/1rOsL8S28shmF3RGcAl8oJ1xyHP+U6+svkYhxDcjpsZO9ai
         U3YYqjLbXihldIxiCZ5CpIUt0pr1p2YWlBEaMbmqEFKRMDS2rGM+/yqXMYf8ZlPMCbg/
         8sVu1lQJVHvqFgfqYTgjp9MeCK67AYybypfR47a/FLHe23Nwizv05y+KPHxGxmtmQxgo
         mdzhN/0Ce+dpTbPkE1ykRQViKaAP00W7izWewKGOWFpfnQX+1Ql7B/ExmU8r5tciZ1hK
         /6LA==
X-Forwarded-Encrypted: i=1; AKwUvBwJVhqMIQcSk5HVWPmqZJpmeg+sPYvf419wwzW4J58+sDybSgpL1fBvE8nn87Z7JaSNU0JBA6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIawFO6qy2NMAUy4BLhRTPY046r7Bru6ZbZfjb0Tvql318w3GDd
	oXiH2qHWaP5uEBdqDoPJEiAAFzws7MIIJPo9OVK0Q+bV9yhkmmxMajIw
X-Gm-Gg: AYBFou0ARfhgfml6dYNCaWmjm4XhmFeG/DSi3/vkfmDNAC4ghy8EMgb/+0CFPZGMEty
	1jW5ENR3UlYzA+H2FH9j2YCsWGYuodkH9AbanG9lgwsTn2days3DoTONAym6PaVDbkPw2f/Xm72
	EZ7pPE5uYxpReRpHJ17HRr63y8SCzw9Z/QAGSvkHRfdAVxfaM2yLoUz09aIcyXJ93MOjUNYXKN7
	JCLWfEBQEoRx9k7LwdvdLdCoEQV0dJA++mAznUZ9JTkp39NqrJ/+3sDqY8hO2JAl6AMiiMrlnto
	qIu+lavVP8ZdfI1/AWluQ8CoCTTvgoCn3kv5bK8Zhk1C6hDCL1T964tOTXPviXjhI0piPwJUUWQ
	paxx2ViMkk+hnWXcswxghFFwIxahseP4Nfgmg3RR4gJi3GDGvNEeowXeKdhC9WXOYc5RaT2LuqR
	K2xX3hN5Ud08njXJ4OrkBPMNRDQl1KOl5V7n0W36il7jZ35cA8jifZVem0IS0wVi5RZIZ1wsjHD
	bwKTKS5xAHpMs+wb1vAOa6k2kSOCGdmnxhXKFDGsOHXLWuGC2ypmxKHBal0NKCECmYFeRS0RjSw
	zFgT8FgiMRJ90S+vT1HQgSAD+96BMWxs2XP1fzPXP5/x8uu4I729KQ==
X-Received: by 2002:a17:90b:5112:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3acef58e42cmr1338007a91.64.1792200360790;
        Fri, 16 Oct 2026 18:26:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947d2706sm11311997a91.16.2026.10.16.18.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:25:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 12/38] bpf: Pull the inner header for End.DT6 in End.BPF
Date: Sat, 17 Oct 2026 01:24:25 +0000
Message-ID: <20261017012451.364800-4-alexei.starovoitov@gmail.com>
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

bpf_lwt_seg6_action(SEG6_LOCAL_ACTION_END_DT6) pulls the outer headers off
the packet and hands it to seg6_lookup_nexthop(), which reads the inner
IPv6 header at skb->data. Nothing says that this header is in the head of
the skb, or that there is one. If the head ends with the outer headers,
the route is looked up for whatever lies behind the head, and the packet
is dropped or leaves by the wrong route. If the program then pushes an SRH
with SEG6_LOCAL_ACTION_END_B6, seg6_do_srh_inline() pulls an IPv6 header
off a head which has none, and __skb_pull() hits its BUG(): the kernel
panics on a packet from the network.

GRO pulls the inner header of a plain IPv6 in IPv6 packet into the head. It
takes a packet which GRO does not look into that far, one with a fragment
header in front of the inner header for example, or a device without GRO,
and a driver which leaves the inner header in a fragment.

Make sure of the inner header together with the outer ones. The program
goes on behind an error of the helper, so do it before the packet is
changed. A pull which fails can still have moved the head, so look for the
SRH again.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6ac386dea4e8..be792b160e18 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7063,9 +7063,14 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 
 		if (ipv6_find_hdr(skb, &hdroff, IPPROTO_IPV6, NULL, NULL) < 0)
 			return -EBADMSG;
-		if (!pskb_pull(skb, hdroff))
+		/* As long as nothing has been changed, the program goes on */
+		if (!pskb_may_pull(skb, hdroff + sizeof(struct ipv6hdr))) {
+			/* but the head may have moved */
+			bpf_update_srh_state(skb);
 			return -EBADMSG;
+		}
 
+		__skb_pull(skb, hdroff);
 		skb_postpull_rcsum(skb, skb_network_header(skb), hdroff);
 		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
-- 
2.55.0

