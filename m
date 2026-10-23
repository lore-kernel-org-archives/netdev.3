Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760741;
	b=xjFZJoIw4BTcxgtR6GeJR8tmCuFGE5CUy/7pZp+Fx1ADtVQDuCf6ijPE4PwOrz1nMn40
	 Z03mkwFoUHIOWG0a9bpJZK1nq9F1eOrJRwlaQoMI6tJIp7cgfK6Jq6dL1goR59s45F/Jo
	 FbHCfXx8seovMosD1MDWuVPGPC/2RNjkYQRXUnByyLzrr+sVOuquPB0dykSTPDMwknsFG
	 2qs1Y+JWhKRJMasl3IdzbOR1eU/KPn3xjTLOuX4jBj2IUu92YyPZpcqr3g/aiPVCxjZoG
	 WXR//U50lsOk+TpKjD163kgPaPAiL8zVbvLmzpGzK645pRhRB0Bz94IjTBcOPU1a2EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760741;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nxrlDr5Pv1kPW7dd5eO3qfJ6XICV5uYprA+uta9M6UQ=;
	b=Yjyb54XfbU8m9g/urWrShx4otVGb9eKVJsc34hIxLutN0m6sQ2ynBDAhWEzBuW4GOY7o
	 nX++mZQnMVlCzddIzmdWFsxXf16dKnCS+8AGr3Acps76R0zHqXgHc2u94SdEGeEb2n98o
	 3TNzakSXJH5K8gwaSc6adp8woHnxe9oJuXQr/KrYc/FxPKW60ogmBJAWHKMGCADRyTU2T
	 arcXr4UDaC9mvNsW7Qull5IZYF234pHgvcLpgarjVHXgWdOKAgZimSkcO53O5N10dibO/
	 RUyAnGpaQcc2yp14gSLwNSKtSgSCHwFPfp93dhyWpQ4wB+leQeqtNCVOVAVfKphuFHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mioTpND/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B6606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mioTpND/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279221F031E2
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760741;
	bh=nxrlDr5Pv1kPW7dd5eO3qfJ6XICV5uYprA+uta9M6UQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mioTpND//qWuVuc3ljq4iPyNLlJKcEF6BwqcTdsM3eLtWtwrXxMQIJO/sx2FS920+
	 OqHnBTFCFl4WSBEn+TiyiOKjaqUatBBwmUgw0Z4P8ojhUU9v5w84rMkzDZGqCGU7Qo
	 BqpRzt36i+az+d0FO8PwJ75O8U23jIu5l/27auuiX50iHFvM3G4dFTFqstGz1TDnCd
	 ya/r+etVeHYBX+F762XSA/1BdF4SHF61KisAt52cABXX7xWAhUzJb+egQXTizFJE0i
	 rX1ISsCNP32oAhG/kpIOSaWjqisDrx+RKKPKr1Al1D4gRhrD+Z1sT+J8c3R9VcvUTu
	 QLQcnTgX/w2eA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-70094949641so753976eaf.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:05:41 -0700 (PDT)
X-Gm-Message-State: AFq9FYIlsc/X3nVgpCSHmsPUyic4Oeevy3W84H1gLvxBGL0IJK3MUA/u
	/k1x58qZznlxpz0PwwYp1MvTDSg55bPVCnDmULS2FvEzeHRnhkJOxbiyfy6XN4gr+W8svSmNRSe
	LqwD5qKdyw2D4LzwtJXXs8aNzXfjGZT8=
X-Received: by 2002:a05:6820:1a09:b0:6f7:384:a094 with SMTP id
 006d021491bc7-70a8040d285mr2645443eaf.26.1792760740508; Fri, 23 Oct 2026
 06:05:40 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 15:05:29 +0200
X-Gmail-Original-Message-ID: <CAL4WiirQwq=MyAn-D4voz+cctj7sj5pbpz4f1K12yhRjp-_qew@mail.gmail.com>
X-Gm-Features: AclHuK9dKwFPAUosG0D9nbQQXD1VWaoosAHEMdMOIldlGKdqHWO2J3RhpAy5O6E
Message-ID: <CAL4WiirQwq=MyAn-D4voz+cctj7sj5pbpz4f1K12yhRjp-_qew@mail.gmail.com>
Subject: Re: [PATCH net v2 4/6] net/sched: act_ife: do not consume the inner
 header on egress
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 13:59, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> The issue:
> tcf_ife_decode() unconditionally calls eth_type_trans(), which pulls
> ETH_HLEN.  On egress this consumes the inner Ethernet header; a following
> eth_type_trans() from loopback_xmit() then parses L3 data as Ethernet and
> can BUG in __skb_pull() when the remaining linear area is short.
>
> The Fix:
> Parse the inner Ethernet header with eth_type_trans() in both directions,
> then restore the egress data position and MAC length.  On ingress the
> existing behavior is unchanged.  On egress, push the inner Ethernet heade=
r
> back after parsing so the xmit path sees the original frame and later
> actions see a consistent network header.
>
> Decode is a receive-side operation; the egress branch keeps the frame
> intact for transmit paths such as loopback.  tcf_ife_is_eth_skb() accepts
> Ethernet and loopback devices generally.
>
> Conditions to recreate the bug:
> - egress tc filter on lo: action ife decode pipe;
> - AF_PACKET SOCK_RAW frame: outer Ethernet with ETH_P_IFE, IFE metadata,
>   inner Ethernet and an 8192-byte payload;
> - the egress pipe re-enters eth_type_trans() via loopback_xmit() after th=
e
>   action consumed the inner header.
>
> Fixes: ef6980b6becb ("introduce IFE action")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
