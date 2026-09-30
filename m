Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92337AA95
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794561; cv=none; b=i9sTTEQAohDD5xPnHIFXD34wW8srDDhS8YJJ+qXrS6JBSu2OEUJGzqB761aSAdt+puoFAW2EsmlL5TkXcN0crYfJQ0etUkb6Mw22Jp622Oqxugqc4q7kfcmQGAxOa3v4Ionw+x71F1l8l+f1t2tKUS7O+jLJ6WOlI1Xd4xEiuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794561; c=relaxed/simple;
	bh=Cdi6iEhAkYqeW0kVp4+sYOmNGIGkZo1BMdz1wK3sr3M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DuKn2CPYmpWyXb6mqd15AMAuPvOEZX3te2VQ27LS5xAj3zaZQS9lXP1vCB6NjjVJMbMOiNri58qSR5Vncr6fKEHdB4/Yola9oLuJDf4/1mEEvwDB9bFPrklJy2+zQAxlg4jtIeqffuVGgw5EfNIy6CP0kWETQqxh3zfbihdLF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eC1lgRtw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eC1lgRtw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 738BD4E410D4;
	Wed, 30 Sep 2026 18:55:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F3FB60749;
	Wed, 30 Sep 2026 18:55:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D77310329045;
	Wed, 30 Sep 2026 20:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790794551; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3okyBMtOMrmtHhftnNhQyM7WK76HdKVGQKG0QkKbBRI=;
	b=eC1lgRtwtPk9bHaaajBwxI6jHrsZ/yOx9zKaRZa3eCNtQ+atj10Lpry9KrXgmZvlU6Ojjr
	i4on9Iwj5coqd4tI5S5HFa8mbid4zvTYt4/q1ZzwUUQIa5i6H2gahWJr4VUEzFZQzcOICk
	sdaOQaUo8fjTBhtuMcYWka3TUY+U6ARNg2Ll+ZzC6QpNgxrAF6LvpAzyF287dNp145B8/L
	D7MaZpCjjNyK1Hr6BHRZts0iqb3sm2wJGOINZfYX3Ke0OMJVKMAgx8zBj8AS28T3UGvBta
	G2z9KTtBh4bWvFKYoEH4i2nBn4BMXZTClQFMbv7ig69sau9jQCW27xiEx/X9zg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 20:55:47 +0200
Message-Id: <DLSVOPXORTQN.3VAUYHPWRAYVO@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: move printk() calls out of bp->lock
 critical section
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
To: <netdev-bot+sinfo@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
 <179079351154.31693.11286897642165841220@kernel.org>
In-Reply-To: <179079351154.31693.11286897642165841220@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello netdev bot,

On Wed Sep 30, 2026 at 8:38 PM CEST,  wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

This is mentioned two fold; in the commit message:

   The netconsole deadlock is theoretical & never reproduced.

And in the cover letter (folded below the '--' line):

   Technically it is a fix, in practice I'm happy for it to go through
   net-next/main for more testing and it is a theoretical bugfix (as usual
   nowadays). Decided after seeing Jakub taking a similar patch into
   net-next this morning:
   [...]

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I do most of my MACB tests on EyeQ5.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I love this newly introduced message!
But here it might have been a false positive (?).

 - Can it read what's below the '--' line?

 - Maybe it could trust the driver maintainers, especially regarding the
   second question about having access to real hardware?

I looked around to see if this infra was open-source but I couldn't find
it. Only found the https://github.com/linux-netdev/nipa repo but that's
not it.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

