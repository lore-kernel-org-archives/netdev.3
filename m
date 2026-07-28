Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF8399361;
	Tue, 28 Jul 2026 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272098; cv=none; b=D40im+XB9ZQ9oUKngHSMk2MiSDVlUkFdXcE0WQHL72RSn2UwJ641XH2vUr9Jp1eCKCHqKIkzS/4HXni9TTxM2YITo2tNRAONZiFzeOTYaoF+6Wi5yYxzTsUe8jhNQxHw/Re+lV8ozgLuTfNQthbAKn/GUJZnp7GWgLuk/geMLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272098; c=relaxed/simple;
	bh=LOTDrjPpB6aqVVgFmIJTMdefz0tvg5uQWXVARCWef8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwKmS9zJq/74lhYcWHeEDYonZMLXlLD+ZlCn4nTu4CQZpce2dWcMKIRzBfvd5JIGZZlatRgLXako7Vf1JCq4VOjGYGxV27I7RzknGL2LdAPrjhMN4MJPxpDhDPhzt3iZZHX4zvLp1N7c81cZBdBCayxlqahf8MGq+H2/VOjnvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LvCycbRo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LvCycbRo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZTHaShcUtSb3SrSfg3jYBwVK3GqrBvt47fUDb+LWjF4=; b=LvCycbRoenNLtwxTEhKZFbwDIQ
	uUhmt4dD1TL2t1/HRjiXOPmjpHUCcxyNYwR9TYnHSnTcAczOmwYuqsy8YsVUTnYY+bs7d99fc6ZN/
	nyWk8GbTJFtt5qz2WvsnvX8c4zbfETM7xqvrLo1hbwmT6AYD8W2WUsJSj1qqd+gxHyik=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woooz-00EhJ7-DK; Tue, 28 Jul 2026 22:54:41 +0200
Date: Tue, 28 Jul 2026 22:54:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gavin Gao <attinagaoxu@gmail.com>
Cc: Alexey Charkov <alchark@gmail.com>, Jiaxing Hu <gahing@gahingwoo.com>,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
	heiko@sntech.de, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: phy: motorcomm: enable the reference
 clock for YT8521 and YT8531
Message-ID: <37c2162d-134d-48c5-92d8-3355306f15ec@lunn.ch>
References: <20260727205602.1188008-1-gahing@gahingwoo.com>
 <CABjd4YwmznLERMx_DgfTeqXmOEZh=pcOjf+NYfkV069mETe-uQ@mail.gmail.com>
 <CAK2JjQVsJbC5wuLs1wFvose0S9ho6FDNPbhteveWOttE0prjeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK2JjQVsJbC5wuLs1wFvose0S9ho6FDNPbhteveWOttE0prjeA@mail.gmail.com>

On Tue, Jul 28, 2026 at 09:57:32PM +0800, Gavin Gao wrote:
> Hi Alexey,
> 
> I slightly prefer keeping the helper.
> 
> This looks like a common pattern for the Motorcomm family rather than a
> YT8521/YT8531-specific detail. Other PHYs in the same series may need the
> same optional reference clock handling later, and a small helper keeps
> that path easy to reuse without duplicating the same code.

Please don't top post.

Look around at other drivers. Is it generally put into a tiny helper,
or used inline?

My gut feeling from reviewing lots of drivers is that it is inline.

    Andrew

---
pw-bot: cr
