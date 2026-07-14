Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762492931FE;
	Tue, 14 Jul 2026 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067647; cv=none; b=djlNLz/vDpLgcTFbTcAnVtikyeSnxJ+9IaFKIOl6rHbVlwaLf6aj3gjcVZwDJrv7rq6GYYtuBbZu3QLZinCpL2w35wV5dtiJKivZjS9FGOpZSlH4tWd8eFg7F9hfgW0khnfWl+n7PWFPYvyBxt6hdWjAfr90lkxDf6bqXQ39kls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067647; c=relaxed/simple;
	bh=0QYRChUHk2McANE8rfcAYC59eQhkwhxcDIib4MzazXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0AY/NwyY23BvepXAGkNUpSjxboTYJesh1OO4DMfYd6Kpxz1rOj9J1W0gxSEmoO9+x3gkLuQxljHEBjSrdd+4GBHCb0ZXtSV6sAjCENgdGflC09dMYP5Zy7p2/cpTS41Bd6kGT3tSx2RfwbD0OI+VpTKAOf95NtJM+KcANXZ2W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c9g3O8TR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c9g3O8TR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+y8MbrUOrzwB05+hHMbLFGSdunFxbfYSCzTa31t31qc=; b=c9
	g3O8TRCslL3lW1qZP1ksCUCKFY5X82A4RYEmMwTOUJhPKWkUpfjOx6kepQ2xUqlVQCZ2ztsJB8ME3
	J5RGFOtOZNWfib/JmLP4W3ktVlf8D02ttxx3bCALLP81bta5YGGaoWwHTcQXp0xv7whEsC0BhTMRM
	+JqLgA1U13qyFGM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjlUG-00CGAy-Q1; Wed, 15 Jul 2026 00:20:24 +0200
Date: Wed, 15 Jul 2026 00:20:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: rnpgbe: Pass an expression directly in
 rnpgbe_rm_adapter()
Message-ID: <dd0bb5df-22eb-481a-9274-7feb725172d0@lunn.ch>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>

On Sun, Jul 12, 2026 at 08:35:21PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 12 Jul 2026 20:25:10 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “rnpgbe_rm_adapter”.

Please can you show the path taken that mucse is actually NULL.

I tend to agree, that the correct change is to remove the NULL pointer
test.

    Andrew

---
pw-bot: cr
