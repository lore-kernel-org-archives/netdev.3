Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6749DBA5
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981927; cv=none; b=YBagSl8xNwZVH4XJoBkgrRXmyztCv9bOj4Ex+QxMcyhXxN1byTN522z2b/oQr5i2ViJG15nzP2oBl/r4NolBWNm0wBYQIeePuWtWbYg2hYx53ka1BV7eciLF6wZHkQ03Zfi50VfAhcMidX7S7bg5Sa1OSjRl6CHT+v1HoKCIlL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981927; c=relaxed/simple;
	bh=JqMSR+Da4NVux+GSct3KYN21nN/qQvTE8oL3k5rSxqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KScyRWBiZVMBRRTcvcZ1Knd7Mpo5mbS7W5PebnqIZU9cpXoZxQnOftRtqDrgYh1A3oLnNRzM0KLVJVnLhUzOpWSsRTCpA8Tja2ZGa02pl3dO9IoiANQ15xLeT64ZUgamWMfRpMusmMqvo1XvQQGGbyiYnQj18SzJRC3Ssq+Vjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjoNXuu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjoNXuu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756C01F0089E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981926;
	bh=JqMSR+Da4NVux+GSct3KYN21nN/qQvTE8oL3k5rSxqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AjoNXuu1022s8I//3Wk6u5KiqSjcOWmDS+IfOzhUNLiN+YMM1IUUVupItmqa+rA2T
	 yqeu4GasDhOj7CEvBVlhcKlAf7gIv1Q6RP1nBgqI97gpE7wA2fsVO00+XuIi19IPsW
	 AcMt4bhM/YKKKkE3yYUS2reSJieULseDDecNoeSvLD1JYyVPEUTfayxTaLkxffdSDA
	 lhOQEY7Kye1zSGN8pAIneanOmm7gZxZTK4srwoElon/wJe+98j5nYVoQH1J4SUz0hG
	 Z+PkmS2o8Hdbrv4g6cZ3OS/RmtUuRbcjkn7TI0XNLB+4ocD2Fa4y8ORmm7cd9quEtJ
	 VstjT1Ymehp3Q==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c95395230so55285511fa.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:25:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw6wXAKYoSn51rZrwHU7aaJhcf5feGr0Cf6Rg881+nw5YXHVIpLlAG9iANoVq6Jo+KOq0FrSv8=@vger.kernel.org
X-Gm-Message-State: AFuF++mkShbvjrEwMxIbckV8MQ3pXUbO7WEh1VUzZj9N4T2im2nc8bfl
	SZbzkSssA558eYPH1xH3WGeIog06ZWyJssJSs4yQb7y/Dl+fXUN8HhaB/jHioI1HmU9cw5y9eKR
	52N/zV+w+UHXU2KYg5+z/ctE3tTabGjE=
X-Received: by 2002:a05:6512:110f:b0:5b7:a987:d048 with SMTP id
 2adb3069b0e04-5b7a987d14cmr1006497e87.24.1788981925087; Wed, 09 Sep 2026
 12:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org> <20260909181949.GM40544@horms.kernel.org>
In-Reply-To: <20260909181949.GM40544@horms.kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 9 Sep 2026 21:25:13 +0200
X-Gmail-Original-Message-ID: <CAD++jL=eB_kAeX_GoY_bUFVs1Zkur0gigHRMTzr0gbFgf=gTMw@mail.gmail.com>
X-Gm-Features: AcwNN1X7-qf8Kv5dOXYeY06U66wRUGvioVAZ4EI-GlAoENCuz0rObKUn2yOOeGU
Message-ID: <CAD++jL=eB_kAeX_GoY_bUFVs1Zkur0gigHRMTzr0gbFgf=gTMw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: ethernet: cortina: Gemini Ethernet
 fixes, part 2
To: Simon Horman <horms@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:19=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
> On Wed, Sep 09, 2026 at 12:18:18PM +0200, Linus Walleij wrote:
> > Fix two RX-path issues: acknowledge FIFO overruns with the correct stat=
us
> > bit and bound descriptor processing when malformed chains lack EOF.
> >
> > Assisted-by: LLM
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
>
> Hi Linus,
>
> Perhaps it is a timing error relating to earlier work hitting net-next.
> But unfortunately this series didn't apply with the CI ran.
>
> Please (rebase and?) repost after the usual 24h delay.
> Thanks!

OK no problem!

Yours,
Linus Walleij
