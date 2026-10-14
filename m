Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5354E323D
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971130; cv=pass; b=cGrzdQUkYZOeRwk8yFY3cAqb92ukDXUh6oF0yWXVFlUyKOjYvq55KaowkFWAenBQqbRXwcgm7qIDu/IUHVxuLLW47qi9pWSWtYYy5UNzqIlXpvVZJLwJesFQnQTYPmFiL0AnsILpiOtXROUtv0uC3Lo58Wq58nX88UPqJSfDY98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971130; c=relaxed/simple;
	bh=gusoHEwTYtpIMo9jbvB0sb5YbKOtm4Z6P3NaNg27eS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jprVZk41wUdHdtCQ0I4h0Kf+pTnMujc5WYqT4AAC524Ot7TNlrC6gsLBynFqsCV8N9BMOh/Q6SGxMg6bogZu68EuIrO4V3yeqE63Fkf1jtYTJg547m5CTunBw5aATNg/NWJpDpfIEOlMLmXj5b7vRQGBMdumvPyTATXQ8cdWeS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=PK1r923x; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="PK1r923x"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6767d92cde6so3744227d50.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791971126; cv=none;
        d=google.com; s=arc-20260327;
        b=jyJSIOPubo3mfirkXoq41exi4yRw1BxE4iiqJ3S0u8a0dx4X4jFqofpZHBFEyMo2Qq
         lsNwHD/Gg0OONDLX8wkod1vLvdwvKWOM16SgczpGOhXpG1ikElIqS2knr2uxPaDq1pE0
         8ogTBLSlKLCcD7AMexRb8XsVqdu1YIsksY2RK3BWVUE8NJY0KIeunlUwhegKGKHNqIjQ
         8q8Rk1SM7EUfRO1eocwc7kZzdbDqwpo3UBLNib4gKFmLedXKVkygPGdX7tIQkjGc8nqR
         E0cV8IIHBNfoWQGt1oZq/Fh+pF53xwAbiej7i2IaNn8xJ9GiZK/waDyfpCJugW0JsKOt
         pjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gusoHEwTYtpIMo9jbvB0sb5YbKOtm4Z6P3NaNg27eS0=;
        fh=b6j5q+BkFhQYBsiI0dyzmcmwztaD/L5nn68h8HDwXWE=;
        b=VwLii+6Ix/Y4tGjL7hrj/rQ1Ik+Zo9v4PR/AfX427Av1KN/Pm0SR9Hs7GqFxN+8Q+y
         NsuygTX7vbQMc+PxR6RCcWRRU46rkNaGTGV8SsPd2Hhojvda5+wQPudHlu28YrVNVyK+
         xs09Qp0a9ZpMARxhT0sKtCg4O3GHpbq94anYcLw4c0c3zuZx/hI5LLG1H2LExhKBDt1s
         jfIoJteMmXqOfjcJOFAzfLytOCyh+DRQymBRLwvM9yXkB9H8PJFvUJfevwqgVunqdhOo
         YyYHLrYaR2GnWbga0pydyXmTB6OP0RwNzXMYTbnsb8f0uE42QP46ksCxBdmLUNItZxyq
         nxjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791971126; x=1792575926; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gusoHEwTYtpIMo9jbvB0sb5YbKOtm4Z6P3NaNg27eS0=;
        b=PK1r923xhU7qDZUbZmXe0yFUiSBca3J8XHIHs9qS+//TYB4Fft+Qo2Ljqk3oG6sPvs
         ExQCXNC1AHfaOK+vCwWLnwkjAKTf2UBbROgtrQXr86a/xPPl6cnW8uxv3/TF1HaeunIL
         WDiDbbme6gyhDZGG95JeVXsSEylcaz4DknthCfgSWs5Ausu5ByUHgSsm7wIUQRywIF7U
         6L6dKDQwf2C+Dc83KQaib+KmDPGD3y03epzqW/Cg6zX34bmKNG+1EutwDxzYAA5TyPdM
         vvgnoK8SarlTBCqLg0ZTdzmtuFchV5igeEa4cykI2Ygktz2Ux2qUDOT2+uGnWf2ewKNE
         z44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971126; x=1792575926;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gusoHEwTYtpIMo9jbvB0sb5YbKOtm4Z6P3NaNg27eS0=;
        b=Ts9VCt0ESn525117Ex6elZ2lbSyqTnKubSCM3i1suGv6r5yfcNcbbeeLePksEa447H
         f/cFRbQj60eUKi9wFEm+3znNKkIlUHdg3WrJJ9qfCsF7Ia9C9PTrtXWgPpw3ulTOT5nn
         HqPthFpIfUN5lSV3CibsDL4lwGGP8uvjM75pnDNC9nmZWbs1SATC4VVvztqvfBECHVhs
         yBovjBCrIM/ZMQTpph/q4egOedsBtsUvNZ0Hw6Eh/aT++qrOfAH/DZkIu/6mpZRlegqF
         UGaoUIH6twVsITQq46b1PWM13aqvPBzeKGNXrHU1FnUyJ4EN6Kh/nYxxcsM3RRUoKSzZ
         SSTw==
X-Forwarded-Encrypted: i=1; AKwUvBxPjLVJPEou1W9tJvWrsNRtvso0vdF49elnr826/NbXNYuhMgYarMjYRb8CIf2L/rTuEw6yWlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMmd46z6wgrcJvXmD09+VF6WXSlGb2amjTLr26wUEVfA9nqhbY
	XHo5NTXVArNYZv99bCkQwvBhszMGiXEvww3q59pN0plGanV2Cy0cLGrXestV5GUyxmXeyeR8lvu
	rLSJowA4QAbd8VusPcQ5vbQ4M89eltH5YS7/IKmIe
X-Gm-Gg: AYBFou3G8Qw/m+ioZxKni3wnBml45HRwHcypaaXcvSfDpUe5XY1bwBIYbiSIQpxt9g0
	CQO0zztBMsCOBjtC8SotL1TLU9d5CDMk4G0nLNBQU4SxQiXy2rMoD3dKeB09XWLgjWDMt+JsZJ8
	Eyo8w1WLOpYpIp79qyg0oXKPjuaN0XxHe9wDfccoYhjWp2IRbln9ipvngQsTCgaPITKs+GP8X6D
	Z/cfSr3WUyC9OOcXerxrGFm57UWV14at9yKzvwTh3cbvBJZnD4wG2WApT/RSjclMgocXsD12Jwl
	cS2a9HeVHyYIR6PrfEMhRaU/0OhqRcI7c2gYZCJyAkm7e8FEEZFxCEU4Jiran4Y2oZIigP5rjVP
	avMJyRZi85JpUg2YkBCjqRNWCRrxZMNhPkFtoPlLUoetyOHEMWCYTgHPUmmoHZVNMOBWmGjUX1m
	IoHwWKC/5iHn1EH3RSIWfMflpEWuD9CqkZczejiDqoMHp45GyQDVT6+QkbggkT+LHQaeV3sH2xY
	nZ4Qpib10hvn0mgKHQxGX1w3cxJzCgwukdGUg17x/AGSQGiZSSBNT/myMDnCcgLciYhgugGQnp4
	KAgzbT67d4KJZg==
X-Received: by 2002:a05:690c:c4e5:b0:8b0:9e22:2651 with SMTP id
 00721157ae682-8b09e22273cmr36219317b3.7.1791971126209; Wed, 14 Oct 2026
 02:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004171636.3545085-1-julius@bairaktaris.de>
 <20261004171636.3545085-2-julius@bairaktaris.de> <b4aa46a5-dd8a-4520-8574-d008a3877f28@nvidia.com>
In-Reply-To: <b4aa46a5-dd8a-4520-8574-d008a3877f28@nvidia.com>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Wed, 14 Oct 2026 09:44:49 +0000
X-Gm-Features: AclHuK_at13xJpgBNhwlZvLzlUVxJXDvkN0LGkLWSuS73Rn7U8oFN9DIXlg-t_w
Message-ID: <CAC1t37K0tEMzxmRhLeHnH-TPx61pZmCHt0xxTJ5Wq2Wxvzv8Jw@mail.gmail.com>
Subject: Re: [PATCH nf-next v3 1/3] net/mlx5e: Ignore FLOW_ACTION_PRIORITY on
 flowtable offload
To: Jianbo Liu <jianbol@nvidia.com>
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, lorenzo@kernel.org, nbd@nbd.name, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	rdunlap@infradead.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 14, 2026 at 03:17:00AM +0200, Jianbo Liu wrote:
> The handler is only in tc_acts_fdb[] and only accepts flowtable flows,
> so NIC mode and tc flower rules are rejected as before. Looks good.
>
> The comment says what the code does, but the consequence is worth a line
> in the commit message. Because the action is ignored, the priority only
> reaches packets still on the software fast path, where
> nf_flow_offload_forward() sets skb->priority. Once the flow is offloaded
> to the FDB, mlx5 forwards it without touching skb->priority, so the
> offloaded packets do not carry it. Refusing the flow to honor the
> priority would keep it in software, so ignoring the action and keeping
> the offload is the better tradeoff, it is just not obvious from the code.
>
> I checked this on ConnectX-7: with the series the priority-carrying
> flows stay offloaded to the FDB like plain flows, and without patch 1/3
> they fallback to software.
>
> Nit: "prio" already means flow table priority in mlx5; skbedit_prio
> would be clearer. Not a blocker.
>
> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>

Hi Jianbo,

Thanks a lot for the review and for testing this on ConnectX-7!

I will send v4 with your suggestions this weekend.

Best,
Julius
