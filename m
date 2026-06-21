Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF223E342;
	Sun, 21 Jun 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077566; cv=none; b=MEacOW0RstHnyCv3JxfGedTalQOmuex7WE24pAoYAk1QdQIEbOVvf5KinDX8OS3ZjRz7tHFW/PGfOMGju5c1wFn+ilLBIV9s7lSP5sjoku6PS+ahHSkks0zlcSx6rDGf0Xd0MpCilQPC7crHdhZe5Usydr2aoI1BxL8J2nEmSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077566; c=relaxed/simple;
	bh=B3OzuQue4xcBDCDEsE6Fy43nNHe3Pi7L4kWzy2hc8Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THjb74DIN6FrErXAMKkGLbFmhLg1CRj8yuo2bn2Enemz/NQ2l7QpI7UjoiQCIeuKjzYsdD9DvYtkFq39sIvCCpiRn7IqyLhxpvHQ3pDkkXSTgBiXgytTg16+srBee3IrogTTl5CTMpKers8rAsXYTml4Hs8cGm8+FbufMf5OLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU/KXID3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU/KXID3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D5F1F000E9;
	Sun, 21 Jun 2026 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782077565;
	bh=EHJDaH5l99xOOoLRUD/4SgFWm6IU9UxSGvGJPVO/DLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aU/KXID3RDWfqmi4sAa96brSYGWpmV0dLbRgbRHa+TGyExTMVwNDxmBs5pR0/O5rm
	 8NsXLJ5EkFlNDpMEhKbwpvGPbjRaYWCroM/mHUorkPhOyG5q1PWcrQDYFXmOJYVI81
	 sDTnUyI1xZpwjUZ7Dv8IuErMiuHeR1pOT2bSjgpSrrZRCRz/8Pk9NrbyrW3K/C6RCI
	 d7uVq/arZistvdSULvet7k+L4v/5CTg1hBi7SOago7z4BokzTTPGT8kTMAM+0iJkUp
	 uZAppk3KGUYPQKZF/qDZkmNLSJyZrI2HTdv2OmkLO2e/tO9uzwrt60mHGP6xyvP6Sz
	 eLQEBxvdKleew==
Date: Sun, 21 Jun 2026 14:32:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Corey Leavitt
 <corey@leavitt.info>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: pse-pd: decouple controller lookup
 from MDIO probe
Message-ID: <20260621143243.1bb43f20@kernel.org>
In-Reply-To: <20260620112440.1734404-1-github@szelinsky.de>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
	<20260620112440.1734404-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 13:24:36 +0200 Carlo Szelinsky wrote:
> This is v2 of Corey's RFC [1]. Corey is busy at the moment, so I'm picking
> it up to unblock everyone. The design is unchanged. The main thing v2
> fixes is the SFP deadlock Jonas reported, plus a couple of smaller points
> from the review.

net-next is closed during the merge window. We can merge the first
patch, tho, if you repost is separately for net, since it's a fix.
-- 
pw-bot: defer
