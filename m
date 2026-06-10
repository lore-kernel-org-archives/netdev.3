Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646083B71C3;
	Wed, 10 Jun 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080897; cv=none; b=pOhcSPipcLOWNTM/QGEa6sVrXfOwXwiBfl1/qkMzK/sWe2a0kHLdYlcBWUwky/+b5sp8eeDqOFtIjcaGeBw4hPwu+28ijIuMutc32GQq6AmQS/g/ENYiEv6zgwv7Uyy5eE4qYdWWnscNI55lQmSraJ1WIq07rxAU4XX+K24e2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080897; c=relaxed/simple;
	bh=gaE1KoNcLuei1hGJFWfcN2lWfL3rvLe1FA/rKdKGfHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl0Cs6YXyS1LV+3xxMeuvxwn73AvKG/HD5/TEVh3rBhPfBVdgzxFRuJFyo3U0KWCbwWLZpY567UtLK8BBftdMC4f9IkCQg+Bs23VM6F8HpyRGZZJQTNM8h32H8D38OI85uvV3A/5bCmKiZC7SnOLnjPqXhpoTOLvZ8C8zTSh5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YMkoICmC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YMkoICmC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zwRZpdWrrC7Hcs17gSNX1j+WRenkYiA30xF+AFaP70w=; b=YMkoICmC4GGu4BkyiuDTA80GqH
	0dcLyzDl/dwDTjhsSsXmHsWoAr/85SruGTlbePP71JKmbNvrnCcN3JSwlHmnzseqhLX0a3gMCFpwQ
	Y1CTDI4YvmUAXlInpE2ljbsQRofI07AR1/Nnm/oDtEYLmcsADn50PYOcmbgoXtOs+J38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXEV0-006wtV-TL; Wed, 10 Jun 2026 10:41:22 +0200
Date: Wed, 10 Jun 2026 10:41:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johan Alvarado <contact@c127.dev>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
Message-ID: <6772330f-46e0-4ff3-9071-570f76fde596@lunn.ch>
References: <20260610075241.1069370-1-contact@c127.dev>
 <06baad5f-fd65-4572-a23f-73b3cc470599@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06baad5f-fd65-4572-a23f-73b3cc470599@smtp-relay.sendinblue.com>

> +static int rtl8365mb_sds_write(struct realtek_priv *priv, int sds, u16 addr,
> + u16 data)
> +{
> + u32 val;
> + int ret;
> +
> + ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_DATA_REG, data);
> + if (ret)
> + return ret;
> +
> + ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_ADR_REG, addr);
> + if (ret)
> + return ret;

It looks like your mailer has destroyed the white space in this patch.

    Andrew

---
pw-bot: cr
