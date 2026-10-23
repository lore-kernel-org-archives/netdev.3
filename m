Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771793;
	b=OT2Cwx+wETRO4XUqyZ0xrM6D37urrmMWXTAm7tjNINCtQoPHrbmcS3aA/ybxLtwPU5Di
	 OD9GhcdOnlMI+zP5B+7BopXfq+zbxvrPrZIT/c/lPOAA7XXOhg9dHsqPjpeZ4dT5DGeOt
	 qjFWKFaNG9wxISKEbCd7Jd267Lmxbor52JWj4Cz93xoQnCejBJRSVXa7aLVnGAn1xsVWS
	 Cl5lcQcexVzgzAGvpLrYTe7L88eGDwP7DedINhwHWXNUulUy0EbYoLCqmrYhRJoXLKkfB
	 b7H3WubV66+s7XSTF6to/G1TzNfoh6zNoJv27nrJWKyJ08XVboWG2DttWF0BBAlya5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CmfPnWP5B6RgKJCu/MFJ8MblMva2bc9HFmeEh//UCZk=;
	b=ydE7ffxW++CsQjtNc/LHtT2cEoKXDAU4q9hOHeU1XO1snJ8TVZI6k+ZKeSIW7dhgPRWf
	 2+OMd9bYvdJiHdQzcWb8ZMVY/TeyEGqRMjNUyVUXxbNzEjss/6GGAQMJkZn5Htza3Zzl6
	 fzM1TnxSzpaHbzgdSjIUdk2XHjTgdENBnh+M4FAogVVbQT8JEIbOGetAMK0diSQlWlZsP
	 q02eflp4nnSxnIT79qYNP1CJApVD/tW2wTypu4FeZIcHeq/h3XF8mQ9YDP4/cN9bm+Vrn
	 aQ/8PL8YJXLVIG4sOhbE+l0NOBDbj2O5lNBavZDL3aD2K2ULQdb3hFs/oh1Yy71n4Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTZWksC+;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA88606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA88606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTZWksC+
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eafb65e163so733225e0c.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771791; x=1793376591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CmfPnWP5B6RgKJCu/MFJ8MblMva2bc9HFmeEh//UCZk=;
        b=FTZWksC+iYfKyk8B+byZ+4M/snU7whcjv0+k7YaPonWXnGtvz0xhEqd67KSKxZQH2X
         WjYUtM0q9qXXRJOMEXJUvsJsIadlcZOhS9/0SVfBTwvXV1VSCZsUsltAm5fpEh7cvXVd
         AsZHm400dzeSglc7YLHMCHlfi/fWHfr9eP7JLdvzftlPCTkUo3QD/oZ6ih37v61qj2cC
         3oQCC3VxgbZ00ZIjGW2IQnUhPlv19uGoDMUihOlx/oZX1/yKSMwrFSCBUceksJgVQesV
         OiPXPiAqOFBkAX832we8w4zjJik6UvpFEsox79gLY1UHcVrVqr6kSnQl7n/wLqxeEH9s
         T9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771791; x=1793376591;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmfPnWP5B6RgKJCu/MFJ8MblMva2bc9HFmeEh//UCZk=;
        b=JPN5phoWW9MPco56YPcX6bTL3can/iOfTS8MRIL8azX/EiSDB7SULlbTudDK0obSDx
         KD8nySTOdiVuSkyJr4FGbmsWCcSqUewyddwj5f1ROOe4QDu+G3WUro83w572mMFElfUT
         MqFy81dfkMej+adme7X6tP2UsQ1btUr2iLRb/yrsqOm4pzzfFnNzpAxVTdgoaodqTM0h
         ThlKwrjvQdOEhIYebbQTpYJrEbOyfSc9EBXIpCQYYgFXok9CzdpqCLVX5GSbVF3vCL+G
         aZXbgr2T3tPkK7HpH+XwNF0qF/5Ek40eRMfIHKkcP72JbdGUmI3LNiqKxEUj+4lt6aBg
         Be4A==
X-Forwarded-Encrypted: i=1; AKwUvBxFxCJyueqrJYgeBz/1GqKImGuOy3YJArlmxX+dRQYXNQT4KwotV7ZnI8w9uAVT0MZXxfC+Jo4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKrNsVrzRv2XgcHMlS+DkMKfc+ugBpn83oX737VJ25DAWjO+Td
	AKFRQNyzmju1HrrTreA3OT1n6UvANzi2lp1cz1zVwIoQw6ZpgI4a2L/E
X-Gm-Gg: AYBFou0u0Dmu10r4GWltJzVrekFClLzqAO04EjYra5mtGAuT3mILsDwTs9wkcV+0h+d
	6LWCkVy0R/t0wptUUam6mNcEF+5dFEnkxa1MvZlDYv3nyq0UqxCQcvmx5VRgkYi8yEF3CxAPUaC
	fSRp+WyLLDZXmgjt/PxQzvQ2MQGl0ibX9fWAnYEzYV5Z0Kozo1S98Qp3WxwBz0goDCqCaMNoCdt
	x6jPhKOKEV4hQQna7FId/mmsur3C6Xz009L6Sfz9+fCLza0h6vJTsP1KwZeRh9U5GyeNgqQrW84
	PeyIyYqleTqaU03OhjPxzIQgRHbaAhjX+hPD2GcMaAQ6rAv4JHGSXpFBTA6o7ZXifsy/W1n6NRX
	NXiMI+v/YJRePY5V2ga3+JicrtsvLdEO5dXisP2vtEBNGZOhpN16S03yCJYGdWg7ER4Zkkvcw/P
	uAmRrfT/y9Bk489oeS4ALeMtb1X3iO8Uhe53/vmqiHyta50UnFY/arigU562pYiFgM+L+uEedu/
	9MlWfcm829hkCpw1L0oXkLvN/XnNMR5XyOvWJHtOTCPXQbWMq5ahFdN0LAnaMk1cIlmhOBd8G+m
	CZyxxCwfGfMk+D0SZyUMI2gZyoF/PWrozMDvdwtML+kAAX9Ey2wA8rcLEZtFrXlkxy7Ejnc6I2g
	ZDl7LHs7viowJ25QX9D8=
X-Received: by 2002:a05:6122:4909:b0:5ea:cd69:7cda with SMTP id 71dfb90a1353d-5ec14a6ff12mr1128537e0c.7.1792771791099;
        Fri, 23 Oct 2026 09:09:51 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec1ff28c92sm592483e0c.11.2026.10.23.09.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:09:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:09:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Victor Nogueira <victor@mojatatu.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Martin Varghese <martin.varghese@nokia.com>, 
 Pravin B Shelar <pshelar@ovn.org>, 
 Vega <vega@nebusec.ai>, 
 John Hurley <john.hurley@netronome.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
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
> act_mpls POP can leave the inner Ethernet header in a page fragment after
> skb_mpls_pop(), either on an L3 device (mac_len == 0) or chained after
> act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> __skb_pull().
> 
> The Fix:
> After the pop, if the original MAC header is shorter than ETH_HLEN, pull
> the inner Ethernet header into the linear area and drop only when
> pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when the
> skb was not MPLS, so no separate state is needed.
> 
> Conditions to recreate the bug:
> - egress tc filter on lo: action vlan pop_eth action mpls pop
>   (chained), or on an L3 device where mac_len == 0.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
>   eth / mpls / inner-eth frame.
> - The inner header is in page frags; a following eth_type_trans() can BUG
>   in __skb_pull().
> 
> Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_mpls.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> index 4ea8b2e08c3a..5363bca892fb 100644
> --- a/net/sched/act_mpls.c
> +++ b/net/sched/act_mpls.c
> @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
>  		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
>  				 skb->dev && skb->dev->type == ARPHRD_ETHER))
>  			goto drop;
> +		if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN))
> +			goto drop;

Is this first condition needed?

More importantly, can it hide a bug?

Simply running pskb_may_pull is cheap if no pull is needed.

>  		break;
>  	case TCA_MPLS_ACT_PUSH:
>  		new_lse = tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_protocol(skb, true)));
> -- 
> 2.43.0
> 
> 


