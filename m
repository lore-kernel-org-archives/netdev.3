Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793344093;
	b=kLCxGv2pdoSh/u/dYSgRV3sjqG1+I0e90V06keAu3Iv5EbsOH32UGUoFGPJ8AlAPM/mH
	 zCoQXl80Mvn/BTcH+mn8h/WOBruOuRNvriiIf9J3nnvDpzaHybpZdoBLAkdkRyaCj95+b
	 q9apCASk4kw2k2Sn01BQQK0qBOmcVzZFe2aEhHX+D8/ZljnBYG35LTRuXstwXh0JkMfas
	 umN3eR4WC1B0UrHw4bi+X25tpsS7dHaopXs0lbGnf23dG1X+fhQVEuEnqX1qfYMOGgJLd
	 tbQ6/kvlHd2IbnLzOOVnkwmKb7zL10uQAh1VYYYd8PF19feTk7MDi/7p+MXw50dqIkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793344093;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=mHQ5PY0q7ltLpy3AnqLRTF//Lss1FbxyLGYi3osAc88=;
	b=CAWMN/jU0nSI2Io/LYw++tVsubnN3e4OdPZoicJd6tssR6q0zvKFPZdma0hfj4cBcmtJ
	 BSEfDmN4MU5vSYtWfH1cKvHeCY+sM9y0rHmGWYTCEVg+NGdCasO+o0RZdPSDYRKhXB2no
	 kNuhCHOdVxX7IYgHkefMhN95asBgpOQ4Dfyp481nkiCnTm6HV0oja/XDwTT+IWTsXKCQM
	 qjiBIYqW+SqtxcGki3Jusl3M1qJdAtx/XI5CcWlB3tA4RBUaB1G5oQndud5YjxAcPOfkL
	 E7yIGWAPaXV8MhfDDgld/AxO+d2N/8kP9l69GsXCpj4eyie/lfKhmKYvm8X7yLVUx9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ork93d1K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0A606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ork93d1K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8791F00A18
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793344092;
	bh=mHQ5PY0q7ltLpy3AnqLRTF//Lss1FbxyLGYi3osAc88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ork93d1KCVTQe3TOUzBiEm2V1iEDkehNbT+JM8MCvkXcxQVRYegO+hEZFs2tWlpIq
	 yLDUS57PMybnUVs+Qf1DjmSmv0XJ/UJ0ZJXcT+PnLZKSA8pKi3mVvC+mOdHe8NCqSv
	 pGhASICcOraOSBySOMBwzIrvwKm4IgONSgmLKGpzeADmLbqiPfUGKzUWcLl3H18xYz
	 MWtccIF1k47q6QWf0vnK990jXIa/dbcmXFA+GEY6A3C5i90nMIgfZg6Fl7mIR7HCyl
	 ctdr0RpjSYUce0e8V0CsQpNllVdBi1Va1S0pFsVhJqz6BNpnH7FqYI61BOe4hL9chA
	 1M93IE/3/Lz+g==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-53dda625f63so227202b6e.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:08:12 -0700 (PDT)
X-Gm-Message-State: AFq9FYKvEkurrb+zO0oS7feJuXEfv39fTxXz4+DPAa8wNzIkJSOlba7w
	cwPI06lkynO05bxIxm9f2y/gkIUIaWm7T6kD0uqeQh1HdlT9xqkljY+wk8cVMNWFR6KbcbxL6eR
	pe4suY7RRIfI/sgpGvS1JMUPKj7B2FFc=
X-Received: by 2002:a05:6808:1512:b0:53a:ff9f:4d84 with SMTP id
 5614622812f47-5640d91b306mr1132841b6e.2.1793344091902; Fri, 30 Oct 2026
 00:08:11 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030042212.73949-1-kylebot@openai.com>
In-Reply-To: <20261030042212.73949-1-kylebot@openai.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 08:08:00 +0100
X-Gmail-Original-Message-ID: <CAL4WiipXOH=B2jbdDAprKTonTwgRe7qr1h8axzFZYThQc74D3w@mail.gmail.com>
X-Gm-Features: AclHuK9xLrLy2m0XOZ8wr86o8hZVzkdM5MtFQpYNijpLuHL3xzSe7P-0pKW8xk4
Message-ID: <CAL4WiipXOH=B2jbdDAprKTonTwgRe7qr1h8axzFZYThQc74D3w@mail.gmail.com>
Subject: Re: [PATCH] net: gro: avoid parsing headers from shared fragments
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	outbounddisclosures@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 30 oct. 2026 =C3=A0 05:22, Kyle Zeng <kylebot@openai.com> a =C3=A9c=
rit :
>
> When an skb has an empty linear head, skb_gro_reset_offset() can expose
> the first page fragment directly to GRO header parsers. For a
> SKBFL_SHARED_FRAG skb, those bytes may still be writable through a file
> mapping. Headers validated during receive can therefore differ from the
> headers later copied into the linear head and used during completion.
>
> For example, changing an IPv6 destination-options length between the
> short and full header fetches in ipv6_gro_pull_exthdrs() can make
> ipv6_gro_complete() pass an out-of-bounds offset to udp6_gro_complete().
> This is reachable with an ordinary TCP GSO skb containing spliced file
> data, without an skb zerocopy destructor or a second GRO packet.

"ordinary TCP GSO skb" ???

I do not see how a TCP GSO skb reaches skb_gro_reset_offset() with
skb_headlen() =3D=3D 0 : TCP always builds its headers in skb->head.

My guess is that you need a decap step first (gro_cells after a tunnel
pulled the outer headers), so that the inner headers come from spliced
pages and start at frags[0].

Please describe the exact path in the changelog, and send me the
reproducer privately.


>
> Keep the direct-fragment fast path disabled for skbs with externally
> writable fragments. With an empty linear head, frag0_len remains zero,
> so skb_gro_header_slow() pulls each required header into the linear head
> before it is inspected. Subsequent pulls preserve the already validated
> prefix. This covers both gro_receive_skb() and napi_gro_frags() while
> leaving the existing linear-head and private-fragment fast paths alone.
>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> I have a reproducer for this issue and can share via DM

The fix itself looks fine to me, but for v2 please:

- Target the net tree ([PATCH net]).

- Add a Fixes: tag. This is requested for net patches.

- Tell us how the bug was found (tool, LLM, manual audit...), as the
  netdev bot asked.

Thanks.
