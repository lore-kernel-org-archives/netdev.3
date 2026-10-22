Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693957;
	b=mhDKiBht6xAmSc4uYLvFXyQ16FHj0zzBlVBGsDsJW7qRh8/DOga616wm5knB6QqxVBB+
	 aGz8EwovW+8C8T94NngEgWWzx9Nrlph9UWTItqZFMpBie5VojjXVX5AOlJHiozVd0gy3t
	 ZWyx05olwixqQ658gshdEyGuDQ/TF4xNgmR0rRVSmWg1/894pSnWBS6XDaL5dg2Nj1/5b
	 +DxBFV1WdXdqgkP8vB3eGSSpoFOpmH/S1LQBFbGc0NFV8uiQ72Hh9mo+oE+HyZQDa5+KH
	 a1wyesBT9grGc7mEckROW7lgOekAHpqbQEosqsrkDdiolTdiZtVOH4e+uuY32ctGXIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D4ebXgpyO3igDhP3z8XtyBcXciVo7ucHsU9A+ZflO/0=;
	b=2fmU9UYCD9WMZSy+j61Ctr1ZsVYgAdAwA/VjbyY43xrs9jdc7Q3iYuIp0DAoKRSxlQiP
	 v814ImuF7e70m/fpGR12gFBILkRx6UcLF9gPdHNvj4CJMFwzb32Fh1O5w11lskZuqSL/1
	 ays6EKlz9wDiMyNW/ypVKa+VC57d8SeldMIJiXNXe6dj/ngwjsmHd8+JyscLXZvBKt1Mt
	 48g7Jwnp58KzRoqsn7Xn1hGn1nbMvfQvQAqMCXYf/oec1KAil8bnWK/JWICQwMaKtzE+3
	 do9RmvVNPtprFdyAhBQ4v+P7R8onNEDoFl4nRlDoJecAhp6W4vLaH9hjWR/vBPUXniA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=iuAqHaYc;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9F60A261D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E9F60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=iuAqHaYc
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so72295a91.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792693956; x=1793298756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4ebXgpyO3igDhP3z8XtyBcXciVo7ucHsU9A+ZflO/0=;
        b=iuAqHaYcXqlIDQnMM6Gcn89/QovibgQR1vxpljFc8yXWe7kHwQ/VQc2MiZdHC2vJ8U
         Ue/UeQv4216ihq5wWhmCwuWfWCw8g0BUiqD6A02Mwr+oE33z7bknpA9LKzH2zfBZuHp8
         iv7Hb0q0sehuJu11RIVWmFuKAZgWnfDTkB323hfR9xnYkxZMbaWARMmJtORgK7391QCv
         LWCT1FPAJfgdTl96adXOlD8ng4y5dpux2KCGlMc8bDlGjyc6hDAfvGw534GeDJ38oq4y
         IA1BrBONmN/1Az1ADgD1O8vx8HbN6Y8cE4hdASXW/4/yU/BJInShZrFDNxruHThW3r3s
         kWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693956; x=1793298756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4ebXgpyO3igDhP3z8XtyBcXciVo7ucHsU9A+ZflO/0=;
        b=NA8BE1I1w9avk1id2GmRUstNKImfKTGuLHo9bKyEJQLTQASiz3jXhAZbpYB2D6QU5/
         BY9n9rFuwpXZAtZjws3uw4uv7FC42ZIjgJBiDeEnIc8tnU3y76AKmamp/4KKKrdvFFIS
         6iTdGbIzGmj9BuWyhNiI4q6Vsl3eCR/P7dlgxo2NwSuVGkNVr0L5V922IiAeE8LhT20o
         Ykhm1MTPbypAW3CAjzOAjMaNcUgKHmqVm+vaWPZuJzc0mEx5BvPfqsY3UM1RUdy0hrOl
         /3JA4Xra27QAXdN3glx8Fq2WpQbejk4vaUTdleF1AMs1FdXV4Y8ynCFJwkx7pioOfp0v
         urUw==
X-Gm-Message-State: AFq9FYJPhp4yASMbEgWtE6wgvWL4h27NL59FVYngtN+HICmPq+shIAiL
	b5HJn1bEKAP7AvvW4egmBYG7DLOFQE+OP9/udqWAHOXNWF7bj3TCXdEaCbgAs2lTYBJTEAxXTkh
	6FtuiJKj2GIU=
X-Gm-Gg: AYBFou3GOy437S4qKEeXOE+QFTJ3QFQ9J2SZpjD+aVq7asCAmoU+Tmk9rbVrDsR8QAH
	e2DtOlrkVYDGp6KgKOYRjyYMrPzSDOUxTMXWnStFNeieHRwadSiJIjdqRBYeEb7m+CHBrHJiLKj
	mSBl3cbflAheoSOId2+8WIbC70zpZ0/MkbfIY5agaxM3KGLxB4PFnCvc8FTK5uhizlNDX1fnJGE
	3j/uZlHFtS/SzVtJ5pn6xH5U4TG9H+IC+seruBiaxgGmgSjqL4dPQcehVBlr7KMPZ287v93HfuL
	W7EQHOk7YSA/SZ8EUkp+ChKinZg71clmkYIBdsNfN5sNj5M+5sMJbw67yxmE+VWpM8EpPwMe9h/
	gI9OZfq3TZLDErMjDkZjxO3lBcc+EuLr7BFMXKa2Ad8/CyKh3Hla17zlxK1SNSd0oqdJslTNHMD
	nD0ooJuRIOcloeFgUw8kt5UA3JpIEeA8cnAAz6DBGgvZpkmaqG9Ca6MrGwg8V1epmJrW743f9z+
	1AuKeHNtDNgtczE6gGPkrpa77mV63yghFox6ecnMAETPzchdB1kB92dwgGfI6IVKSaI
X-Received: by 2002:a17:90b:4b0d:b0:39d:f08e:e6e7 with SMTP id 98e67ed59e1d1-3ad86dbca24mr4710256a91.9.1792693955844;
        Thu, 22 Oct 2026 11:32:35 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:ffab:2834:5ac2:f726:a005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49314besm5275608a91.11.2026.10.22.11.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:32:35 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] xfrm: ipcomp: account full fragment pages in truesize
Date: Fri, 23 Oct 2026 02:32:17 +0800
Message-ID: <7f2686a7d3d393a0ef9eb7a2a2abe82caa7874b2.1792692779.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792692779.git.zhilinz@nebusec.ai>
References: <cover.1792692779.git.zhilinz@nebusec.ai>
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

ipcomp_post_acomp() allocates order-0 pages for decompressed skb
fragments, but on input charges truesize by the decompressed byte count.
When the output ends partway through a page, the unused tail of its final
page is not accounted to the receiving socket. Repeated IPComp packets
can therefore retain more memory than the socket receive-memory limits
charge.

Round the decompressed length up to page size when charging input skb
truesize, matching the pages attached to the skb. Leave output accounting
unchanged.

Fixes: 7d7e5a60c62e ("ipsec: ipcomp - Decompress into frags if necessary")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/13830
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/xfrm/xfrm_ipcomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 671d48f8c9374..c2cc88c8c360f 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -67,7 +67,7 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 
 	/* Only update truesize on input. */
 	if (!hlen)
-		skb->truesize += dlen;
+		skb->truesize += PAGE_ALIGN(dlen);
 	skb->data_len = dlen;
 	skb->len += dlen;
 
