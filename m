Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F63D954D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273390; cv=pass; b=acUB2MynjF465ixWCIDa1652UgCkj0HK8UWoW7a0cChAaNEphDwaeCG5I3yUg90UpQa0AUR94bGlEnPujvqHT6NKPEPWwcg+0X6/vH/kYzJRh4BlN3XlIirut6WoE4z8x3d1cf8yav1noPLl8SvmbS1YzOZ/RFgaMRWAukPiiOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273390; c=relaxed/simple;
	bh=+Gn4vNqqi7vmqCWlHtFRorYIfOlcGjXYRNZASjgdUC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbLaGm8untZ8APWftgpX+7EkuvOks4H8neD/SI1TM1pEQuNNuM5+Cjot8jHFH48pE0hZ/vc/RX14lUrt6ahzzplAcX8zjLZHqG+R7lYhYoOiQdgBv5Mk2Aup+Pt0uqHBIMff4UtR0o/CnaaHFrRRJNflIFf2JaG3nGQtXO0lvyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=lf0VCBA4; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="lf0VCBA4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc73e322dbso4053755ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785273388; cv=none;
        d=google.com; s=arc-20260327;
        b=cZSXbAe4ciGp4l+lCtw/PbD6MA8LjaPznbQvGMoY8akeS14NpuaNCHvqlN5W88CSMc
         d7d9mdgenb/kr3TvP5WK2GE+SC8Zh7YM+AACRSNYKXBL4MIgiBvgNZSLHtwr2bKeYjtP
         qeZx+4VA8/fq98ZCEZt9Xdhj4NENc8fvtuB6a4dapaAu3u5yEVwGvEg64DtP1RMw1Evt
         bGlwCBiOdV8YAkNkBrT1HA5vBeM1bRJ5UBoyVQkorLl2GEjDUms+q+lLdGagfQyn6OHu
         eUduk6CE4qawFyvdIdDN2KGiEViZoQdhyl2mfNJLkZ1p+ErZegZWFLUaGoicd39FFkgR
         MbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iBdyp5Zkl30Ji4jvBMshO7o8pfuaLY6rUP18nddYao4=;
        fh=Wi9unw4raMFzs0gl9L2RwKeOjrp8w7xHFFMcpE3WTxA=;
        b=HfGHTGc5voxTBFlxLjFeU2N0TMMHZYvsp6Br8pkhY6WrFa4hJaDOO9e70VW3hK1iXO
         o15sSbU4zE41/jE2STagXswChACwDAixThaf7pb6jwfSg5T3fyg5GyxMVABx/m6JJRzW
         guQRwkcbJxo33HAdCKtTw8e0NyzA6l/LYgNMyY/sRBg1Z8Q2nYWK5FwClOVlnBoFCRft
         VNwjn8zNrwjDbzZ8tUhRue4qxav73Ji30OCE52U/drciIH0HAQoOdk/leEOo1vmrxYjW
         csAF6OnA63E+n/4NIppzbMSN5aBRFga5MGfx4lXsZNq7v0wcdKZCwhaC5LfUu4znMLCF
         fl4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785273388; x=1785878188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iBdyp5Zkl30Ji4jvBMshO7o8pfuaLY6rUP18nddYao4=;
        b=lf0VCBA4UvdolSYQ/iGB58ZPGfe4jKScO4kJexFoQJgyNpkPiAB7LU7qq9XgjvwhxF
         UhypzIKgU8Eajm7aUnx5l8mg5O9GkAsXwk88B1XP8ZnSXuzsC/BFsLMUs2rUnvvZHbeM
         wrJc+civ7aYmmUg17jdBdFZoWt7KH3CqsCaAmvmjEwcIPkfJ0u6xwwzFZyp3tJW4xwU2
         DxGBLnq2qlarKIw/S7rQpjeejVq5ZSYATggR7LgffcaTtlnO2n89on+QTIcBcQ7BKEqD
         LFFHH4QrhseH3mXEgIemSI5Z3pY/EydkkG9vRxewIhErpzXHyCIsdDdRj5yDv/QUwDrR
         NfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273388; x=1785878188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iBdyp5Zkl30Ji4jvBMshO7o8pfuaLY6rUP18nddYao4=;
        b=gPTB3cRza5faPSv5zc9xF6cPhIHlrnUlGaU7WZzanMyaWD+mMBTjMJA+daNtF0H2Gd
         cWuZUQo0QHI4YEkSpI/tfcSzW+5eZeynmzzp52C0uNFGUd7HneqKCMDes+8gN+uvhJA/
         tUoWb7aX18LRtnkFmvTlyb9HXEUS4rgocDgg8t5cfTBYcgcblacxSNyTw2PiQ1V210qv
         V9Sk+ivz7typQwPyW4HhuEzmb3d0D0O+6vIjHw9/gmBfGfB4lQMFmYFk7iuHvZ9tLEFU
         Zel6Xw/Lxfa0Yj77nhjWz78rXcBwz0gNG3WzPL9VUrlqUYddpkA8hbaCDcG1PBAqgiQN
         wQ0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpbqTuBxWon7vxu6GCpNyh6Px3TKMZmq9c5CbdQUTfjIO6dNezUkJ6umneyoO1+noRLtkZAhJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYeBTm3u6hinDw9O0QIilLr8FSIS3fqQBXYqYyAl2Acy/p4jtR
	uZBr1Ex0m5m24RHiYHFXk7fe7f2TWH92n7Iv+AvgtnUi98r+AS41xQiMoogQMdXgas2DIODN+6D
	fmRlH8Zc315e5odDTH4i95jVqFduqmRstnnGThCG3
X-Gm-Gg: AR+sD1310snvieBNWCluWHI6ifzh6Ns83tt4d0gtrKYhqvHY/qx7YviXRrMl6QfXwQv
	TvMmMzvfevyHfBsPe8zBt/YkImarPcNlCU5TXBnDXvYyV5hfYoW4qQoo059k/5CrBl0Zi8OV2te
	FwV8nLiMpGuCY27ddz3ggC1GwBxWjf/SWmNvSrxCzU2xzVfJR05KaTG1sAoMb239KToLCSR74aK
	OffZmHn+P15Kfy8Y2JTc3SQ1ej2erw3lhefgQ3l+JUtMHQqEfqFPO9Gtx3T0Ld4EhefRJYAjQHB
	t9Y0UNjPNulVKDq78wKrYZ++YFTceTVukqT99xeX/sEmNpilA217l+WG692djhqgeX+pfSdovee
	k4IfbHvGM/puL
X-Received: by 2002:a17:903:230f:b0:2cc:89ce:2ef8 with SMTP id
 d9443c01a7336-2d015d983b3mr49997815ad.40.1785273388556; Tue, 28 Jul 2026
 14:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720204430.1886091-1-xmei5@asu.edu> <20260723100949.4443811e@kernel.org>
In-Reply-To: <20260723100949.4443811e@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 28 Jul 2026 14:16:17 -0700
X-Gm-Features: AUfX_mwVYR2JRpCveHpjLfDPvMGoOYq5K7umIlMi5g3WiRdAZGIKWZtsp9P8Z1I
Message-ID: <CAPpSM+QSpU40rcEO8Wx7JHeD=ErD3FUWmX2WejDvho6U5cFmdA@mail.gmail.com>
Subject: Re: [PATCH net] seg6: fix NULL deref in input_action_end_dx{4,6}_finish()
 after nf hook
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Ryoga Saito <contact@proelbtn.com>, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 20 Jul 2026 20:44:29 +0000 Xiang Mei (Microsoft) wrote:
> > When nf_hooks_lwtunnel is enabled, the End.DX4/End.DX6 actions dispatch
> > the decapsulated inner packet through the NF_INET_PRE_ROUTING hook chai=
n
> > with input_action_end_dx{4,6}_finish() as the okfn. Both functions read
> > the lwtunnel state via orig_dst =3D skb_dst(skb) and dereference
> > orig_dst->lwtstate.
>
> Per Sashiko's feedback - we need to validate not only that the dst
> is there but also that it is of the expected type, no?
> --
> pw-bot: cr

Thanks for the review. You are right, I'll do the following check in v2:

  if (!skb_valid_dst(skb) || !dst->lwtstate ||
      dst->lwtstate->type !=3D LWTUNNEL_ENCAP_SEG6_LOCAL)
          return NULL;

v2 also covers three more functions with the same problem, so it is now a
series of two patches. Details in the reply to Andrea.

Xiang
