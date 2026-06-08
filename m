Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108173939A9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904497; cv=none; b=m7o5apLLcW+YlzhHWdxiXGwZl3YS6lv0Brd/Lk5+aeoQVs1VPSivMVeE47gQCqI4UOQCFmmGxaTUhCEzem/VNfPqkuePNE5hrK31mKgd/qKOqHfi0iekhjllOgG6io6cTdMcSFjQCsjEZTNjyPbKCAvszaIlqLkMZAI6VNknz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904497; c=relaxed/simple;
	bh=XYk8oVHsv5ylI+PTyOcCzcI1zcM607243dzPsQLMM/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWcIdsOpE78sjnrtAbW5NuGmIzuEVxqR+XmKLOurODsocJcDPWLbZMM/hMWdjkWzSSizFG/rwI1ooG+Roizs1ZJ24BRbzHWczQsXpUt/r0RKTMktIymij2MrH3yoSV9K6Bz3FhihA8vcGTchw115pJfBonrKniVdBbdtpGAf6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeEvxOi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeEvxOi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5701F008A0
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780904495;
	bh=XYk8oVHsv5ylI+PTyOcCzcI1zcM607243dzPsQLMM/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PeEvxOi1x0N9XlKZEx9opLwyxAYWbnD2yrIo4DhcDVfv77BAUON8RdtHfjsrh242q
	 CyX+Wa2idB8xwIMb7hOeiPZ1XGcLD0rbfqkD9Bn5qMwPkXGJjhIqHWDbM3nOHoCBnj
	 np7lbT/Q7mLJOvLAbW31EhCWYo9tiqu/ciQuytjUvP4Vq5/a/aZtDUsAi8GfahWJ2K
	 CVa0yq/3wfxoE4HDWG3ON82fYmsH51tK7X70cW6ZO9/VCu8wVWalLq0yKrJgVRqt5t
	 9usygYHovCD/rwyWkWg0q+oTZ8mCsVBShm14HPN4D86KPhE/txdVfC+T2HQRvgv3Fk
	 bkdQLUZ6VyMgg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso3981097e87.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 00:41:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/CqMUdWsQxUk124x/A5YxBFGCyd8VMXU2WIxWfihApGhcYWcos8G/lAb1vhY5Vfqp4kNhNmBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLDVlOeAOwC4cWONFxB7lrAR3bfgd2Prsit5BUUxZrKioXSJn
	GnObvP+3vMyli+nstfKaASAWrJJMNFMM3JYvPiD2yPPehOeN8dBiI0VoCnMxQ73VLMjBEEahU/6
	/7boDoMPyc4HlrgTK9kNHa8mTlxODBPE=
X-Received: by 2002:a05:6512:12c4:b0:5aa:105e:b95e with SMTP id
 2adb3069b0e04-5aa87bbe102mr3546702e87.16.1780904494202; Mon, 08 Jun 2026
 00:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com> <CAJq09z4cTkFd=bvdjhBnqkwmO20xiGvqkzFJm0FpM6+9oOJx9w@mail.gmail.com>
In-Reply-To: <CAJq09z4cTkFd=bvdjhBnqkwmO20xiGvqkzFJm0FpM6+9oOJx9w@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 8 Jun 2026 09:41:21 +0200
X-Gmail-Original-Message-ID: <CAD++jL=2cLYyw8fWA04BcjvA4a0s6CYSb8Me-sGRxcptdAQYCg@mail.gmail.com>
X-Gm-Features: AVVi8CdPU_PRN3Aw565jDqs-Irn5_xttWBUoHIHJwaGvQtspM3xPREyFQ9Aodhc
Message-ID: <CAD++jL=2cLYyw8fWA04BcjvA4a0s6CYSb8Me-sGRxcptdAQYCg@mail.gmail.com>
Subject: Re: [net-next PATCH v13 0/9] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:43=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From both reviews (and the history of them for older versions), I see
> no blocker for merging.

Me neither, the AI reviews improves the quality of patch series
but it also tests the contributors patience by raising the bar quite
high I think, and there is something like "perfect is the enemy of
good" when it comes to patches.

Yours,
Linus Walleij
