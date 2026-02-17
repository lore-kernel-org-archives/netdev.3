Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63730B52B;
	Tue, 17 Feb 2026 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365602; cv=none; b=RVUfc/HD/LjHP/TJbkvtLYKodk7bk8jE3sowQ54btsTR1BgIsfYsK3sZJ9lHjo5qooeOIbzatkM9RpEETElJLpjR3c1NImsV38qg+fq6HnfEYEaNc4MSAUUuwc0gD2s+zsJ+UjhfJW3Kp5Q2K6lD8LVhgJkNZmdp1mLCCWev4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365602; c=relaxed/simple;
	bh=1KFybEk9QuwRToTqNIi6MYrhV9F6EZyrTfHdFSJR2ls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBjnacY42oCrjsNJLIgc/P7AIgmP/KC0JWCFy8nWfcRVMlFeeEzbFsGHXZIytVC52a+viAdXpllEc43G0sotwq3eHYYm0MJLnqmlJSwFQNRsjdGEBYEduuy91eqtQ3+035YKVRYvL2sYYt+7XLrzawfu00vw6R5n8xBjVhNEhm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9QfSzp3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9QfSzp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80A1C4CEF7;
	Tue, 17 Feb 2026 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771365602;
	bh=1KFybEk9QuwRToTqNIi6MYrhV9F6EZyrTfHdFSJR2ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W9QfSzp3ldumQT1aE8LOijpEvQAALFIwANolJ7sdxMavTJcN0uMXFxnmM9MAd05Xw
	 cXa29f74Lk/r8uGv1DK1LoIrAU+1Eb8KfxLJNdbNCgrNRKVVM0qzsazXwAgWObf+jZ
	 63JLwtHnXGsfrsrnDWiYLMVaWNibFqNX/5Zr0vuXVshzJ2w0e/CqwDKvNfGEFpWAje
	 t3+QMd7Om4CKratdUrgiNGq6edfthSqzYQILdms7MdEPnSY5OmG3/+vWalIfBOF65v
	 LL78kMrrNSDeWIvW1BKf3q5ONhw/Q/knExm5tBA+/3qpteCOrTe72w8BOa4lstY+nJ
	 L193hg62sI0bQ==
Date: Tue, 17 Feb 2026 13:59:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v23 2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20260217135958.216c30b6@kernel.org>
In-Reply-To: <20260216102359.37586219@wsk>
References: <20260204232135.1024665-1-lukasz.majewski@mailbox.org>
	<20260204232135.1024665-3-lukasz.majewski@mailbox.org>
	<20260205182805.196fd832@kernel.org>
	<20260206112454.2e9a686f@wsk>
	<20260216102359.37586219@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Feb 2026 10:23:59 +0100 =C5=81ukasz Majewski wrote:
> > > Transient build failure here:
> > >=20
> > > drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1072:32: warning:
> > > variable =E2=80=98priv=E2=80=99 set but not used [-Wunused-but-set-va=
riable] 1072 |
> > >       struct mtip_ndev_priv *priv; |
> > > ^~~~
> > >=20
> > > I sent out the AI code reviews while at it, without looking at them.
> > > So please approach them with caution..   =20
> >=20
> > IMHO, issues pointed with AI review have been at discussed and
> > (to my best knowledge) addressed.
> >=20
> > Shall I prepare next version of this patch set?
>=20
> I'm a bit confused regarding the next steps for this driver.

1. This version didn't build, so it's out.
2. Take the AI review under consideration.
3. Address issues from 1+2.
4. Post v24

Well before posting:=20

4a) wait for net-next to open up, it's close right now

> There was no reply regarding my last question - and I don't know how I
> shall proceed...

Hope above clarifies.

I strongly advise you to follow the ML so you have a better
understanding of the process.
