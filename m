Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA45363C6F
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200384; cv=none; b=rc6rt4qOtdi44ni8uDXcE3KEUi27kjC2Tz9U2tiq5hs4F/kDaFcbKLzAP/NTQ6lYnktYUlfPXQ+7HEPIC0T9qlEDcmiZ4PRFqaLeY3L+CgKD8lG11PF2Boejg/sbcbiD1ygtQGbqbJU2IgAMWlr2OXrlPfR/fQbzCsbEL18xDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200384; c=relaxed/simple;
	bh=08SBMlIPFZ4QqNwPVXontnnNyNqGBdZW7HWIVBvUBAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BavVKRNqk5RJN1uq+Y8el1jrqGx3TjcLujD93hmEixUt2wcyzuxPd/+jyGkhsgkUEpvAQZKPj31d0rwxoAFQL972BZuH0mmBNGvlfd2Ej1Kf31qTfWimoAXARVBvabXzMPvPjsYtUsxbEzYMV7dZxciwqJp/lvt51q64QXaw5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci+/j4z9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci+/j4z9"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38759bcd877so359853a91.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200383; x=1792805183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w65oifnN5/ENwAdNOCu2SExnEHx1+W+Nj3UBG9hGAvI=;
        b=ci+/j4z9Z0YmZFkWkpj/+6AiYsu/052r3me+s39Ma0eIRW7xLcrfQAbel1kL48t0lM
         BqfnpZBi9daVHiGCnG+OWWH91YWfPh4xq+QOG+ani3jjVW+AP1g9pGA1KTCxegLPFSXv
         wCkjzdFCFXFjsbOzCi2ebHj7IiVmT51MgdiWwE4rMZQ8PPV6Id1EZHYwZWfGU2NnUXi7
         KrYy390BVYmRwpAjnMaJE+/u3KJjdPIuLkycCxx9OQhrtD1Q705I1HfFErJBWof14N2U
         qM+LlUIL4KkIsHXGAv4HSXtEbHiiRteaBPBvhcRM+m2OI0e4W4XMv26uxIMEumrJaTGv
         DEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200383; x=1792805183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w65oifnN5/ENwAdNOCu2SExnEHx1+W+Nj3UBG9hGAvI=;
        b=lPGgFiwKw3s8TmKZYYw7vHZfW/dqwkI4e5anV/8FwTRIokeYjIKrgKpVXccrPWeWY7
         yix2UnFSTC3Ar+8RmUC+XNGwqyVBnd6fkvm1aQBK7Bt7jhkmCBgyRJiYcDPFox7gym9f
         3+3B1LbkDTUZOaMtV9xJO97S7uKo9TCNjpKCuS6DSU3Dp0Y5OXdgsrblmuBkb4ZZHRFI
         sF63t/NFGG+/90HqWAcMcr9taoXy3Gl/ftJG0Yj8Q7/A0e0fCFoibBjrTjzzY4tVQZvf
         iTJwE53yHAsiezWb4QUmo0kfFmR+UCG3vIWwjI/3Fh+dTKeSDgUchFnJFOK0AK5vr/Qu
         lwGQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8oZUX/zFTNiyJH5jv/2z87zrWXpRnVIKl0Wu/KRjAms0mCxTAMk9UQHbRI2LMJtGFY3EV/M4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTUhVFnu/30Q90833TO8oWljzyKGAXa4F2m05drX8JqQCgEa3d
	TsUuQBM87st4ygRFXjP47eAhYnFMrEY4EOhBDp2tX4SGjLnRNCogUZE4
X-Gm-Gg: AYBFou2tk6hoeYDB1SEg1EzCO3hRMKFTe5LTGyvnzhjr1J46zx5LhQj9vIvPBZgQrk4
	FRHVLTD71FQuzVN7DbUhCVk5Ix+JtG0LzZhx/LyCYzzKFP+ysAjBOtHJT+WDtpAeNb0Rwfaw6br
	m59rP2DmLwJr1Rof2gEgol10SNwKsEmWHxw/g3wBaTbuyl6TKP6hdSnEp9y0dUmSU8qGhouXw24
	OKSgyTvEFy1QWdKHiOTntqpTJZEnMhXUISs6SUn1cpxlm4eCyjI79pbsEatn3qeVjf/NCLS/GLj
	5+KaKFBNhZuFnMpDo79ZgooLszb6b1+thLEiFHm5WlG0/hgIq6dXhNep86UilWIgctBWd/mG+Dp
	UfQsstGoxe7YMNBVkLpgIKbMjCtn2K/PbzW0I0BspLqEBhPaIj9qYP4dCGpviL5AqAU9vMi7alN
	+Gxz81z1TwDIodVPqv14yxUh/ML2Kdc8QQ9ibsOKXtqWJOE/zpOmryAHV9udhggTo1n3MWg9LAF
	HqULwASVHY20ojCTBEAdkfy4te36SsSAcJphb34zP0RL0C9BDzxUPThTJpYeTtjEJWliBfAB0ZM
	KQOQjiCWVkjHxdc7rUZhxsPmwWhhHneB3kgSSACMNFA=
X-Received: by 2002:a17:90b:4cc6:b0:3a0:c85a:ee02 with SMTP id 98e67ed59e1d1-3aceefc4ee9mr1354763a91.17.1792200382627;
        Fri, 16 Oct 2026 18:26:22 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm1886129a12.1.2026.10.16.18.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:26:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 13/38] bpf: Update the SRH state if End.B6 fails late
Date: Sat, 17 Oct 2026 01:24:26 +0000
Message-ID: <20261017012451.364800-5-alexei.starovoitov@gmail.com>
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

For SEG6_LOCAL_ACTION_END_B6 and END_B6_ENCAP bpf_lwt_seg6_action() looks
for the SRH again only if bpf_push_seg6_encap() has succeeded. That
function pushes the new header, for which the head of the skb is
reallocated if it has not got the room, and then looks up the route to the
first segment. If there is none, it returns an error, and the pointer to
the SRH in seg6_bpf_srh_states still points into the old head, which has
been freed.

The program goes on behind the error. bpf_lwt_seg6_store_bytes() and
bpf_lwt_seg6_adjust_srh() read the SRH through that pointer.

Look for the SRH whatever bpf_push_seg6_encap() says.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index be792b160e18..bf01152d0cf9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7084,8 +7084,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLINE,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		/* The header can be in place although err says otherwise */
+		bpf_update_srh_state(skb);
 
 		return err;
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
@@ -7093,8 +7093,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		/* The header can be in place although err says otherwise */
+		bpf_update_srh_state(skb);
 
 		return err;
 	default:
-- 
2.55.0

