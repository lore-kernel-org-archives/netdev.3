Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682469;
	b=hmW8nIB5vDrnEW0NbQk1TbJYIZypv18lNg/LqYTcAEKZys1YIXNZAo9UgHTU9sq1D/g2
	 9IQItQTrlo6JgSfCHTP9Lpy4DzHNClLgH37VK/56JCwSah62s98RbhbePO3qaxW5nenV6
	 d2g+c7oQYEcCnkr+H45glxb9Jvtj8fxuJwKQuYgcA4S1E4mhYHSv+xwmby9VNTi1NwX/m
	 NrScohr6mwHusS656HPro+cCQJk+6T+KGX2gQ+c36K7wDCzEFkl65gHySTZOGx+I//bnz
	 63Mo0tjPNGsOcdZONprUyqH5nbtCNp7863NsWYw2wAKlaY7m2HiAJiNpRn5CvEJ2lNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ut1MbZFisvfUQUtEfL6SNU0FdsUnm/HnnqHBMvtQOC4=;
	b=OQdVWbvrSHpuA8/Bgbb7I7e06X3+pfjjnxA15JSZ3PlIja5KPkNE+q5lV0WDJPy2e3mI
	 ZNkpTSMo5Ffyaf416nBQeFAfqTkz1C+CbMbcOKg9Rk9wkiRJoBDpKYDtutsY24ywggeXO
	 vy37OEsOYzM45TKBsevNZxjMmBh69VthO7CMm0ucWx5q0s74rYxPR4/ridtYrD2To5ES7
	 NKabU3D/bIid9JonY1KdckcTA2HcCB/i8ylrp3Qzmkd9GZD0B91ZebRb37ZYXXCZrqoqS
	 ZFdzuP7H54gQ5gzNLCTvp9zFLF92kjn7ijt0qt53XnAAVvIcWfVL4Y4qvXImcphm/DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipQMKzYb;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCA606ACC3
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CDCA606ACC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipQMKzYb
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eac01ff101so802109e0c.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682468; x=1793287268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ut1MbZFisvfUQUtEfL6SNU0FdsUnm/HnnqHBMvtQOC4=;
        b=ipQMKzYbHgjHM/EwCO58dSFAnNpq1+KU7vhUwsLIJlpYtpCPo1xOBHe9msP1BIGMI9
         Ha4kYX2m6/onHNR9ui5yDM2wtW0Oci0uZ1QD26oVaPKKuhJQ4iCHw7smcz4oR66iMLA8
         TGM1nTjx8obQhsiY1ytvupAHCUe+UFpDGtohgnAqQmAduzceFGTQvZnjX1TaMzYrmros
         MbtjQwlkzk3js33URLlp66roXPSaIwP5upIVOcawIt2olSgIn9lEa9Tla+oDs8NL99VG
         ChwZ4iDaaW8gT/fUMkxu+tCSsgLKsn+dhFPvnPRXJuqlQGizGYgtlUk1rzOP5DUDbzn+
         MAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682468; x=1793287268;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ut1MbZFisvfUQUtEfL6SNU0FdsUnm/HnnqHBMvtQOC4=;
        b=haU7YMYBcdC3O8ulWU4i6vaHWv2n09LYLp9wBoWUkDSsdW5FHia0a/LHOOeAxkkDPC
         re5vHtUXt4mMUt6p0P5RAV54w9DYcNquSh+iuicqPUCz018LiTusTvTv9nJRf2oP7PFW
         oA6rI7BKvGJR+5qSzdsVlnwsB3VWZ99BMCJyFTFnPZdbbIh7BBKuoP8MX6xHXjYCZReK
         zXjoMSPmOiHLuSHhTFHbyPcoKR5dBPCrp7WomehL+4wyKnQ8usLz2aIEMelA295tSG+F
         Q/lfdz0Y6I9nS37gN5tpm/aaGRDc2SufwFeiDihMJx++7oakaTW8aDtC4VGvl+ApMqEu
         +JsA==
X-Forwarded-Encrypted: i=1; AKwUvBxEc4jQsUKv7xFTGx0M4PWHaPMPW+VM73jugS1kVgkodMoF8lzFC2fLDS8d+qrwtb8WenrTOjA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7n2EUWdvfvvtxsDzKlTlrXa4A1pRhU6v2kHxs+bOgtIPp2vIw
	jRGnSUgqQc02gVNVwUjNBuOeR1kVieltGgJzSqJW3qbEZZVWxThHijTN
X-Gm-Gg: AYBFou3+D/yDslOb+6Ei2+9FP+58WBBsR6n46WvAhdC4sMWcIDMQcqNXOe4AUkzu0JQ
	siCsSvOsaaCR0UBw/V0XfZ4FkZv54xcpo4UKbCMM7GrI78VE/zWmSzgzTPGvuZwwpyzClHNBeMn
	WJAsQeaeKQwpJUDWHE8gr1dFE4zxNdP+74eGPQcjng1fEyIL0DJOJm/3A5aAMllA2KOX0DX/j9Q
	RBgpsQKbEbClY+veMCIFRPT3Z39y9cqg0swfpvyX9JtFb8Up9bHJ359P1K4kpH7TOBP++o9Pzmq
	M97fS2CbM951rcAsR/Uhex5vHxqwww7ikojygn13dEPWffBnh1EA71C9+uxO1K5VFcXGdN+ej/m
	C/Lfqkva3P7uIfuT75eIsNTLibmbfm6AlpXxc4WbNtPUMhV2w/qB95d/6hgy+QlnumYAkvYKHyI
	heYOH99p+c7HRvWCn3kQ8+JBllqUkZyvJe3kvgpQ5bWpf3pev3FiE+GnA/0PN/n4JEmZOhW4lMs
	U9SLEirV4o7RJYK4FY6kqttf0mWpZIr2vEcHR8uZtEdx2dnk3VOMv9LBUm4yhkU8aILsRWixTu4
	eURq6orTXkFveRyM8cuR+M6bHhK4dluymU6nRc20Nsx+BmzYLoDk2SqQ5WFSVj/Bzsta+9dDJ+0
	0Fm8EZWPynOhcsnDxYyU=
X-Received: by 2002:a05:6122:d0a:b0:5ea:a0d9:e5d6 with SMTP id 71dfb90a1353d-5eaebea1ffamr2067386e0c.17.1792682467917;
        Thu, 22 Oct 2026 08:21:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae9788c68sm7312496e0c.5.2026.10.22.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:21:06 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:21:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Guillaume Nault <gnault@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Victor Nogueira <victor@mojatatu.com>, 
 Vega <vega@nebusec.ai>, 
 Ren Wei <n05ec@lzu.edu.cn>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Jason Wang <jasowangio@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.38722ee638a21@gmail.com>
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
Subject: Re: [PATCH net 1/5] net/sched: act_vlan: reject short linear Ethernet
 headers after POP_ETH
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:
> The issue:
> act_vlan POP_ETH can leave a linear area shorter than ETH_HLEN; a
> subsequent eth_type_trans() may then BUG in __skb_pull() when the frame
> is redirected to an Ethernet device.
> 
> The Fix:
> Drop the packet at the producer boundary when skb_headlen() is shorter
> than ETH_HLEN after skb_eth_pop().
> 
> Conditions to recreate the bug:
> - egress tc filter on lo: action vlan pop_eth.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
>   eth / inner-eth frame.
> - The pop leaves skb_headlen(skb) < ETH_HLEN; a following
>   eth_type_trans() can BUG in __skb_pull().
> 
> Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_vlan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> index 6a375fdc63dd..ddf03b08bfe8 100644
> --- a/net/sched/act_vlan.c
> +++ b/net/sched/act_vlan.c
> @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
>  		err = skb_eth_pop(skb);
>  		if (err)
>  			goto drop;
> +		if (unlikely(skb_headlen(skb) < ETH_HLEN))
> +			goto drop;

Could it try to pull the header and only drop if the packet is too short?

>  		break;
>  	case TCA_VLAN_ACT_PUSH_ETH:
>  		err = skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_src);
> -- 
> 2.43.0
> 


