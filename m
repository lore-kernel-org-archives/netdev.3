Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AC374745
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854447; cv=none; b=l48IHlJhsNn4vFwOmyo0dvl/7mkFnH/xiUFB93BC24Gu5g/h+HSvGGbJxTkUKQfTgAutCwLXwijqtqgct7ifPX1bCBiDBND5X/x/Rpy7HzlSUGQhOxBP0alCKzCRncnuMYCndSYybDwgSzohtnOWUjfYbnKXCHbRNBzFd45KEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854447; c=relaxed/simple;
	bh=Q52dnLm00AjfWJF2P2fnmTewO8zuC0FXJWli64aEUCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4WvzRMFeZTY4zFgsmRtE/OamzkQnUUeDGHWJgZEP32VakhwsY+1fa63z2UA34/fEy1w7jhnszSNoOC4YQjr/YgFIuGIBePlGKRINpyF4MfFDrDx4kbRg1rXd/LPBQEx/XJ10a7wRo5vN/kdLSeqemdnoSTg8X3AnQg8775adLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCTu5kB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCTu5kB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0F11F0089E
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790854445;
	bh=Q52dnLm00AjfWJF2P2fnmTewO8zuC0FXJWli64aEUCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nCTu5kB3kN4pnl1t0K1cAqKxOxSlohW7iyMzjhQ5B6PKDL5AKqyxCVidXXnfj28NI
	 934wmVLYlUkfvh5Z0184ACtQEeNwtHQes9RKRO644zhmOUdeoDJp2jT+MY3Myv6Gq+
	 LU1jVz7TKO1EX4ygwGPUHcR1v9Ljs9JSXIbz8x7Z2oeiQyneKBZ7gxqlOLUCB6ocWn
	 kTEtavX3fVlZ2+C7sZuQYlW0jBWvP/LaTy3YicWrLJOBaehYe1TpWlN2D530GuboBg
	 S7hPbsH32nFqIZIE6vyc13b4I/CEqBzLVPaxkKS/ODVbl1EubTWZhL+D+ykBEAx1S/
	 gTWqtGD9SByyg==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a77141826cso17582051fa.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 04:34:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzpF81Dtrb9//9MNMzAQWc8goF6mtnFdZoH3FsyJcnPsDmdxCiMWs5UQFVcDmYUD7dSDmGw00o=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2/cZGDUO6DTqrQ2XVsdDEnvzGKmJhhHR5Of7utyVS/QTaKIMB
	d9zzrOWecLmZOkZUfonMRjRFLX/0BEDJtQT32JrwGYweuOiDBrFrfx4Q30GZPhFNAOZvutbjVUR
	7d4fwMB5WkqmptIONb0LqdIe8rlNK7R0=
X-Received: by 2002:a05:651c:1509:b0:3a5:93dd:e18c with SMTP id
 38308e7fff4ca-3a7791db5a5mr13150771fa.5.1790854444125; Thu, 01 Oct 2026
 04:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org> <e11c709a-5d4f-442a-a30b-f244b75715cc@redhat.com>
In-Reply-To: <e11c709a-5d4f-442a-a30b-f244b75715cc@redhat.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 13:33:50 +0200
X-Gmail-Original-Message-ID: <CAD++jLndAoKUsBPywu=qvDWneLV=nOx2OPbtKkKzRnQwYLP6cw@mail.gmail.com>
X-Gm-Features: AclHuK8SD3vowjzdzk5GQcfkttAZLJyWvbDhiVQKJOFzgGwEbj-l8w0jEqChsLg
Message-ID: <CAD++jLndAoKUsBPywu=qvDWneLV=nOx2OPbtKkKzRnQwYLP6cw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/11] net: ethernet: cortina: Fix Gemini RX
 buffer management
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Myeonghun Pak <mhun512@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:51=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:

> > Before these patches the network driver would crash under strong load
> > but it does not happen any more after. Tested on the D-Link DIR-685
> > playing back media and transfering new media using ksmbd while
> > issuing ping storms.
> >
> > Assisted-by: LLM
> > Signed-off-by: Linus Walleij <linusw@kernel.org>

> The vast majority of clashiko findings are actually fixes in this
> very patch series or pre-existing issues, but I think it has a valid
> point on patch 5 (WRT rebuilding ring with odd number of entries
> consumed).
>
> Also it looks like patch 11 is mostly against the current netdev
> guidance for guard() usage:

OK I'll look closely at patch 5 and drop patch 11 and respin.

What I did was to kind-of-sort-of run the patches through
sashiko before submitting them, which makes it find
less.

Thanks Paolo,
Linus Walleij
