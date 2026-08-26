Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A643AAF5B;
	Wed, 26 Aug 2026 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768779; cv=none; b=Rq3UJKfWdj9mUruCTWUNULIzNUNk0+FZB+Mr3S6Var7cuMZpsZyL8cGFCShY57zUe3n4MeX/iUucw16XOpseQGpy499AbHK3+/aNV/ka7hhtNUd/ypvn1PVx/ZkFoNiez01ZM+FBK7BAQ55ORrvGdecdnLj9XBHBygnkLA6ax3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768779; c=relaxed/simple;
	bh=vspygNUdGM0R7C1TtDtEIqMVQHUttHRnP/KTcMmrFHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j396xeD+bV2bkh5e/nw2bwLjvB61VAnrL8l/zJ2W4FBHXsjpPdevRuecPT349jRk0SfTt4ohfwEJXE/tsre1k2sgVOH16elAait+53v58WiiAI0GvRQdZ54UhvrYTW+uEEBGndZxwAPEwrb3/ztgQ2A2EbzGHhldYlv3sMiemlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aVJHaJSh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aVJHaJSh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KbpLNegUdhJUqXlal6WiMR1yan/qUeADHo28QDiqzQ8=; b=aVJHaJShUddYszfYj5KS0Fn7g/
	38JO1B6Cd94eVzSYVksG2RtIRamnEvT7zjxtiQi8x6b0h6lg+TYohomsu3VAbMnZjzOfkaMi05tiR
	mxVF1JC00VwkTIEBOBD2TeiiQlyiI8bYbHptp9s1PvUbVOuc1ogzgwpiGaqA5blop2gc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzIJq-001YlU-Am; Wed, 26 Aug 2026 20:25:50 +0200
Date: Wed, 26 Aug 2026 20:25:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net 5/6] net: stmmac: selftests: Account for the UC
 filter list for filtering tests
Message-ID: <0a27797f-f7de-4e56-81d5-72571846c3ec@lunn.ch>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
 <20260826140500.616466-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826140500.616466-6-maxime.chevallier@bootlin.com>

On Wed, Aug 26, 2026 at 04:04:57PM +0200, Maxime Chevallier wrote:
> On dwmac, one of the Unicast filter entries is used to store the local
> HW addr. This means that we have to use promisc mode for any kind of
> unicast filtering if we only have one slot in our unicast filter.
> 
> The number of slots available depends on how the IP is integrated, and
> we can't autodiscover how many of these slots we have available, so
> the DT property snps,perfect-filter-entries can be used to specify how
> many are available.
> 
> Most IP variants default to 1 if this isn't specified, which is the case
> for the amlogic variants (in this case, S905X3).

Do you have this hardware? Did you try increasing the DT property to
find out how many slots it actually has?

Maybe a nice little project for a newbie which has some stmmac
hardware. Write some code which adds MAC addresses and reads them back
again. Determine at runtime how many slots there actually are.

> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
