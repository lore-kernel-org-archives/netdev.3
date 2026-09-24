Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF342EEB7
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240536; cv=none; b=ZAVG5rQOxR9c34Z6kI/VYUl0uUtcV08+kQZqZ9ebWbN/gSBGaCiMKqPJoHai9XUviXWJT2eyQr1lG47qEvnWoRGw5TBF/boJ1yTjP1t7vToCJb6brLRuXh4rtKCDvdde5j0C0pyRdw0GbYAGqoCjvAtv7OoVtEJ0cH02CqWiTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240536; c=relaxed/simple;
	bh=Ce2ymKVfonavaoEYAGBUsfI9fZcWikNo8pBvq8Buq4Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Imc12BOqs3keRIR9GVD3etvKmcywbAGKPgnqLp9c6Ii5V/yeCzquVWxf3LF7wp+Y4Fj8gRWWgyAirSzZvAL0jnZsLLdivYeQJiZUjQa7+t6bnMW8YxzrHV4u/iRVoWxymcCQsCS/9iVS3u0Z7Qx9DxjnbV+qPxe+vX4zqyXBeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a1HHHn6/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a1HHHn6/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E5E76C211DC;
	Thu, 24 Sep 2026 09:02:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9035A5FB45;
	Thu, 24 Sep 2026 09:02:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2457A1032944A;
	Thu, 24 Sep 2026 11:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790240528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vR7HTskuo3QA3UfAnJnKV8R+LADlbZiIPXzgpnhb+y0=;
	b=a1HHHn6/Lau7NKqrsoJ6ZKglKHjAE5aINeiOnPet24A2RUQq1BFBnlNjQ4HlASH24L8kwM
	8sZVzzg1I/AXv/TcPBLTSJ1Q93r/4wtf2Poxb8ujP3ERwNwfk+O/TUTFibZsvOoDeoQIEN
	CnrMOZjtOxmNG6HBZRIrMDfH+Q6/tgYqeyA+1wNzLLpqwMopPD5DPdrHgfiVd2hs9ZYgJ3
	2PRuzZL5uXmcUhFk31aug8s3nprebTsm3RR3LpVSiKVhxM5rg0git3O5IBRyt2j1WK6WNJ
	rIwIFPM6h5muT/vt2tw7Kl5Yt7sWKlfTNCgM+dIP7K3K6N36KZ7JkQihaLoDZg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:02:03 +0200
Message-Id: <DLNFAUX8MFA1.3UMOGNLDKDRJM@bootlin.com>
To: "Zijin Tao" <taozj888@163.com>, <maintainer@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: rate limit netdev error info print in the
 data path
Cc: <linux-kernel@vger.kernel.org>, <conor.dooley@microchip.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260920100920.65773-1-taozj888@163.com>
In-Reply-To: <20260920100920.65773-1-taozj888@163.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Zijin,

You missed part of my recent feedback [0][1]. Copy paste:

 - Also you are missing the prefix [PATCH net] or [PATCH net-next].
   Read up about this here (and read the full page):
   https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

 - Also your To/Cc list is weird, make sure to use
   scripts/get_maintainer.pl (or use b4 for patch
   management which uses it automatically).

In addition, make sure to read the "submitting patches" guide [2].
You missed:
 - replying to all review points one by one using interleaved [4]
 - V2 in subject [3]
 - write up a changelog [4]

Also this one is less well known, but the net subsystem (and many others
nowadays) expect people to reply to Sashiko review emails to say
whether they agree or disagree. Especially if they disagree. You can
mostly skip over the pre-existing issues which don't relate to your
series.

For example Sashiko says you don't cover some log netdev_err() calls.
You can reply explaining why only the ones you touched are important to
deal with.

--

And I see just now I have in my inbox an email from you asking how to do
it properly. Good! But it doesn't show up on lore, I'm not sure why.

Replying to it here:

 - Don't send the same patch but slightly modified. Maintainers need to
   know the latest version. New version means V2/V3/etc, even if
   changes are tiny (like a typo fix in commit message).

 - Don't put V1 for the first revision. I think that's git-format-patch
   default behavior.

 - Using git-format-patch looks something like:

   =E2=9F=A9 git format-patch -1 998b159fdd78 --subject-prefix=3D"PATCH net=
" -v2
   v2-0001-net-macb-take-bp-lock-around-NCR-read-modify-writ.patch

   =E2=9F=A9 grep ^Subject v2-0001-net-macb-take-bp-lock-around-NCR-read-mo=
dify-writ.patch
   Subject: [PATCH net v2] net: macb: take bp->lock around NCR read-modify-=
writes

   =E2=9F=A9 scripts/get_maintainer.pl v2-0001-*.patch
   "Th=C3=A9o Lebrun" <theo.lebrun@bootlin.com> (maintainer:ATMEL MACB ETHE=
RNET DRIVER)
   Conor Dooley <conor.dooley@microchip.com> (reviewer:ATMEL MACB ETHERNET =
DRIVER)
   Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
   ...

   I think most people call scripts/get_maintainer.pl and write the
   git send-email --to/--cc flags by hand. I've been using b4 for a few
   years now so I don't really know the usual git format-patch workflow.

   Or you can use `git send-email --cc-cmd=3Dscripts/get_maintainer.pl`.

[0]: https://lore.kernel.org/all/DLKVCOXTNGVZ.3CC6KFXDIFJ3X@bootlin.com/
[1]: https://lore.kernel.org/all/DLKVEXS7X14N.XLLMBDDX6ZJW@bootlin.com/
[2]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html
[3]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html=
#subject-line
[4]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html=
#respond-to-review-comments

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

