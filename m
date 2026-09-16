Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263DA49DBBF;
	Wed, 16 Sep 2026 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562198; cv=none; b=BM1HC8pyk7OHTlHH5vs49RQ3GbN+dqK4ZAfzj4QUBCF1Nx6UixFnFqiLNxG01cnN/AmVCUYIU63eN8ADK2Vk1JGntq3BAVvQBbJdIjPVkqpdWH6BWMcs9SEmYCaK3WrZr8I15SBpPONkotHxiZjQtSEL476yDdyEibARPma81rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562198; c=relaxed/simple;
	bh=kNPPbPR/mrHlcfwUn7SC1I0/pDn9Yz/1l9GTGHdWz38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beHhmVP+GGhJaVFD9R8GtqeA5Zs59Nibc1xdwQuDaHrVbFD2/8pGmC6mq4MBHSBeKGXPDaICcioyqgH5ekwXLkCEKkrgL6kjMgd/2wt8LEy2zkvuZ9HSFCBbzDym1cO/ovSUV+paZFvqlDQyzYI6bZ5ImvVGaOMwWc2osepwa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=emYA7/Lz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="emYA7/Lz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RFQCYq+nQwh7la753siJRbrhr6ylRbKn2cdDnKmooSU=; b=emYA7/LzM6PguZHoZPKDgP2lHy
	Z6f4c9/E3MauZz8rWuOtGi/5nRAhtscX13ONH350Z8WxMQ/St1t4bqR0T1P+uCME8QnbeTjmsexVh
	KvRuJI2IZtEQVpI/wtsI33vPl9S6WLKQCiTEoUeQdOqIYQQKwszOdb4FBQF8szZYjWow=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6osG-005TeW-VU; Wed, 16 Sep 2026 14:36:28 +0200
Date: Wed, 16 Sep 2026 14:36:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: dsa: realtek: rtl8365mb: extract
 PHY OCP address halves with FIELD_GET
Message-ID: <55eb74e5-b91b-4662-bc9d-60e92255b4e7@lunn.ch>
References: <20260916090102.349157-1-o.rempel@pengutronix.de>
 <20260916090102.349157-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916090102.349157-3-o.rempel@pengutronix.de>

On Wed, Sep 16, 2026 at 11:01:01AM +0200, Oleksij Rempel wrote:
> Extract the two OCP address halves with FIELD_GET() before handing them
> to FIELD_PREP() to build the ADDRESS register value.
> 
> rtl8365mb_phy_ocp_prepare() previously fed FIELD_PREP() the raw
> ocp_addr >> 1 and >> 6. FIELD_PREP() masks the value to the field at run
> time, so that was correct for the current callers, which all pass a
> run-time register address.
> 
> FIELD_PREP()'s compile-time width check only fires for a compile-time
> constant value. None reached it here: the address is computed as
> PHYREG_BASE + regnum * 2 from a run-time regnum. The EEE support that
> follows adds callers with constant OCP addresses (0xa5c4 etc.); clang
> folds those into the inlined ocp_prepare(), so the shifted constant now
> reaches the check, overflows the 5-/4-bit field and breaks the build
> (gcc does not fold it here). FIELD_GET() narrows each half to the field
> width first, so the value already fits.
> 
> No functional change.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
