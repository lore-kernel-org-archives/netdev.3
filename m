Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC231D9A5F;
	Sun,  2 Aug 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785681082; cv=none; b=spCrDU+ddJdVNr6DquFl0Icg/twa8rB2vAd6G5L5/igy6djbVefPNoQXcaPcwgwOYgfVkcbnvmIus3MzI8Z4wKfgUpHvUSZ7+Qfz/53sIRirCZyjhAoPM1TlHLpo1NktARie52Ou4oCd2RC6aiky3RtQs4tZB/UDkmhZanK5g28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785681082; c=relaxed/simple;
	bh=WWN8zpt5OeLHup416kq8YDDgHwN8H1PrGQ+Ht7eWHyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0mewiM3p5zbb9Od7Yv/YfQIDY1QCId2pTVoGmCSrEQib5j0Yi+BioGwRCMuObLwMAQuwrIasPMHRj3ZrbdK8rHWoOkht5V6c8voq8evZcQcDyBerGUMakr95HEf7TmWXgAMVivMTeXHtDD5559ioTzFTV6uq/xF4JkfXcNjbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mwJ8aLS5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mwJ8aLS5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4ggfcMH1kahDYCbGmOP7Ajq6AppNr+Gjq/mgURpxy5I=; b=mwJ8aLS5VQNSjkOn0xGqK75CSS
	ID9sYCVvsHAz13X3MKwofvRBt/1ztsO5fCZWY3TiJPfbpJvg4z0CbN/yXWkCVv0CsdWMKdYOX9w3V
	Q/kqDeBdHJ644FGsUU7rpNRuhgbEdHjiGAzK3XRkn7gfITAj1dVfYo18jnu8wQokMBjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqXDI-00FZzM-7S; Sun, 02 Aug 2026 16:30:52 +0200
Date: Sun, 2 Aug 2026 16:30:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 06/10] net: pcs: xpcs: add ANRESTART support for SGMII
 link recovery
Message-ID: <2886b24e-1c3d-48f7-8b22-9620fa0404f7@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-8-coiaprant@gmail.com>
 <cfddb747-11d0-476d-8402-e0886cca582e@lunn.ch>
 <CALj3r0i1TCTgvm8FrJAJqmZgoJp61NCxc_xmVYaDFd-gh4H=7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALj3r0i1TCTgvm8FrJAJqmZgoJp61NCxc_xmVYaDFd-gh4H=7w@mail.gmail.com>

On Sun, Aug 02, 2026 at 11:11:40AM +0800, Coia Prant wrote:
> Hi Andrew,
> 
> Thanks for the careful review.
> 
> > This probably needs more wide spread testing. I would be afraid that
> > if you kick off an AN cycle, you loose the link until it completes?
> > You would of noticed that on your hardware, but other hardware
> > obviously behaves differently...
> 
> The trigger condition is: link is down AND an_complete is set.

Ah, i missed the "link is down" check. That makes it safer.

I still find it interesting that this devices is different. Has the
silicon vendor done the integration of the licensed IP wrong?

> Regarding testing:
> - Jiawen Wu has tested this on Wangxun NICs and reported no regression
>   (Tested-by tag included in the patch).

Probably Maxime will test on the platform he has, but i don't know if
any use the XPCS.

	Andrew
