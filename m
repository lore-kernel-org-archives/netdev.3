Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894344E05B;
	Mon,  5 Oct 2026 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242387; cv=none; b=d9jZm9bXj2RL0acYVNm+s8hHYYXDjsQUpt5m/ObbHelnI3IGB5iwrdzX8J0bswqGSmFOHzMJq8JokD+HzHFaBhXlrfbdvV1r9fmzIr2NtSV17Rv3jpuBwXBMjECUb7yN3AdGEFeGtgANW5kIIhjySapZchp12ic+wrlhgJplv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242387; c=relaxed/simple;
	bh=NrAF9FpsHKHN3C96ZCaREgoG5qpzTMGeeHU6+lp2tAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syM5FgJEVMsljfu0njyqkG7YphROwhTg54XWxINf2gzAsNRE1Nr8/H2sUy5/SYfuPZWrZY4bnBsaxxt3+i1uX8TLKgqjUtZ0l00G+9dLO1c51t2u5DxMPd+f4mReomt8kM1bZerQIEL1z1jnqh8+pvyCIAzURLleQI8pqR0Npx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hykXjjsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hykXjjsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007BB1F000FF;
	Mon,  5 Oct 2026 23:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791242383;
	bh=F+y3aBH9puqqy2Q8Hip3gbqWCjZUwgwB1v1NmKcICyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hykXjjsGhzo39JZgFwpt98KLn8bx9AJ5p6VSPzwn5xMe4L+1tdIvc+q1wCmkccyjK
	 3Rqp9xVptwbY1DR7ege0zdBy9IDDrh+1iY825tJQxKnNWisv3Wat3OdWENtXjmeLFq
	 iWeto1/yMPsh2ARBSXeP1lotmo56tIoaWtJK+rNuyOsprvUz3SG+j4uCChUucjtbQA
	 Ow+kzI6BpRZgeIaxRg7yDIH4wsE+GG/8xNWtPoggvDYVGK5UjQSXnvZ4aXgxwnBR4v
	 jo/w7lCySZlNwRFuSDMDCDUmaaUvg3lzVCtP/FQXWujosoA/IgBVyCS1J1S07p62s8
	 bjDciTVxN7pdg==
Date: Mon, 5 Oct 2026 16:19:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: <netdev-bot+sinfo@kernel.org>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: move printk() calls out of bp->lock
 critical section
Message-ID: <20261005161942.2a23f861@kernel.org>
In-Reply-To: <DLSVOPXORTQN.3VAUYHPWRAYVO@bootlin.com>
References: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
	<179079351154.31693.11286897642165841220@kernel.org>
	<DLSVOPXORTQN.3VAUYHPWRAYVO@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sep 2026 20:55:47 +0200 Th=C3=A9o Lebrun wrote:
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan. =20
>=20
> This is mentioned two fold; in the commit message:
>=20
>    The netconsole deadlock is theoretical & never reproduced.
>=20
> And in the cover letter (folded below the '--' line):
>=20
>    Technically it is a fix, in practice I'm happy for it to go through
>    net-next/main for more testing and it is a theoretical bugfix (as usual
>    nowadays). Decided after seeing Jakub taking a similar patch into
>    net-next this morning:

It's borderline, indeed. But "theoretical" does not tell us how you
stumbled upon this.

> - Maybe it could trust the driver maintainers, especially regarding the
>   second question about having access to real hardware?

I'd like it to keep asking. It's also useful to know which SoC you used
for testing. Of course this patch is quite trivial so the biggest
miss for the bot IMO is that it bothered looking at this patch in
the first place. Hard to tune these things :/
