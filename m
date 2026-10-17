Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D93939A2
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255143; cv=none; b=Z9g4Q/UVUNC1FZvHD+lhjoz8szT+KD3SNlpmM2N1VNUz95A6AwR6ycy4P/2wjwPcRrkEc7fJrmcOleK5WQCaYn+zD4FUQNHtvp2nlhXFJEBHe0N/UUofGysDuyZf8mMf0MfQT01hIwfd4ksmtX8PxTVdOstMK0p3tN7zBbgdeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255143; c=relaxed/simple;
	bh=7AEfMtx9Kcanp4UjTKPB/YCQKJtXbAs74T3H5GqGVMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3LKB6K3qhvjzNVq0fm2y4Tg2nKIZGFe+Ul6LjvK4qmRSnYFHMNP3YDibIvNW6+9R/zYLMrk9c2QOHnHGe6h9/owoRbyz5KO1SXwXW4S3b9ePpoMAMyO1+j64SvFUCTZT3bTEes90cVg+PeftdAjZuvq3rWvAxIstC2EcsZ3ES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIhLPMV9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIhLPMV9"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso534296a91.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255142; x=1792859942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ez6MSD+AceaDu7vNZmXph72FgmoMN2SxdaCBTXkP/s8=;
        b=XIhLPMV9nTah1Avqt9+FxtWJpByFhsKvh8JwSlObvY9dz6EfccjvSNjrI5t2O9xkzc
         EU+Ei3G70iG0GY9AWpZlzTY4zpJNK+dsTg9dWHMfB36LzR0aDNIUA3SkFp014LZsCy0b
         Gjiz+op010r0jD9RqAJbvAiehrlTG+zVoGG3oUR5UfbnC/S989APpF5TJ/CwufeJd4AE
         bFNgy42wDaz6YoevXsuc077rB2Wyrf1xfYp2H6RoUS+/rhbSQPvj6JKirZcPzOnDruHU
         ddh+t0I9v70JzRjBr9WkW9D5uDHo8k36kJOKcNfVf87uJAZWOPXcw3jxGWcHsWgwygT4
         FCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255142; x=1792859942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ez6MSD+AceaDu7vNZmXph72FgmoMN2SxdaCBTXkP/s8=;
        b=rD4+q9pu/Yj74Y8Wh2/xm/I/+egEmOb1UQF8/E0z5uAwYSK5rQxu1qQDVp3eSfN1+D
         56/xbVUs2/ObmIcACjUjwJVBVrFT3CVA77c1RBRhDJOGh9jVHgAlA+ELua/2sKvsntOo
         XvZZqaEhtwFCJG2bxq0Uy2Og3MuCzQAgjFSUJTPnrMf5prWNEioXKknstIPOBi+MNOA1
         l5n6/tXXSG2guaOSqctoIG4TOSAuSNGzZ1IG/XaYW0ydJEJtas7dKXG5GemLf6/dKoN1
         XXNzxsC4ekqbexGizW1JQuANLVhkS6kJYK/pYQ6AuvZx1xG72r5qSIjwN9xdLdovtEc+
         NNxA==
X-Forwarded-Encrypted: i=1; AKwUvByNqLSUtogEZ7HZchDc3/TomkH1/N2C1N6xKLZoRWp18pprlAoExuCSWsBgIcS1V3OY07s28wc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeDoPtshcT81BF7dHw2+HfHT38UNiIgwYOlgpFvlehphb7kG8V
	zGPu2VRsWQ9YLJGr+2YlviE+zEfPI35Xy9hgf6EwcvW08pcJyN6zW6fz
X-Gm-Gg: AYBFou0iPBr3U9nPAPdSGU0Q0xpAlkVK0I7ncbbZAnqpzeoTw7OxiADhV8T7SQwGIsP
	+oozgARMRMtzZF/ghZ/m8AhPsYPWPo7yh+atoV3TFZVqa1eUhYq3DPLE9fvUsT/aQdwLmYl0cNb
	b+zERsCCx5aLE93mjgQLbc9VrK2t3+ZsKPzW4W9+Fp+keIYx53kDHf0aXDH3xSkdMqwpqWWWzUI
	wplAUVj1UiPup/k7XU0nsDM52NrIkhBIr/9Z5hNV6u03KRoCs88eJqmYeijW63Fy/fSxVtcOn8Z
	l4hltf37dELtVN/RbaNGWJ5+XKrFiI8ByPrf1Fz1xakoru38VQDP3e9t2bbaK5AIIfFHPdDtdLx
	P/ew3gQF1lJLsVIA/XxKvdDtXg//iaX8gfyR2tp2uvbgmXVbhsTWPYAyJsmYACADrpx1Ke0xFvf
	XIxcpoQ+bKLBeCrHAdAZb9UH/ha4fW9xqQOqCUzXmPl/bbkjRrTeDr/q+45oyPtYIuTPdbaMBoz
	DoZ7RKryfIpbjG5EIbzmhKJpIc051oRKgUmW+L/Jep8Mkv6h0P9bCFkhW2hngAPgydkZa2hsthH
	AthzhG8iVvfWbSY9d4Tpdn/rLsY0OwJNPIukatHioAYSARXG9Nkdou4=
X-Received: by 2002:a17:90b:582d:b0:3ac:8af9:4a73 with SMTP id 98e67ed59e1d1-3acef10ee88mr2787745a91.28.1792255142075;
        Sat, 17 Oct 2026 09:39:02 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05fb680sm5145552a91.2.2026.10.17.09.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 12/43] bpf: Pull the inner header for End.DT6 in End.BPF
Date: Sat, 17 Oct 2026 16:37:14 +0000
Message-ID: <20261017163745.3341787-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
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
index a62f3decf1e2..6fbe0cea2140 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7066,9 +7066,14 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 
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

