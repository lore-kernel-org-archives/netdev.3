Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B96391E7C;
	Mon,  7 Sep 2026 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813590; cv=none; b=aR6sAwwo4+SbRJ1DKeALu7qtAheC/qnQ0PHdu60VuMSIiVKj6fw+YhVfECt9cploO/+SGVwZULzWniHkBrDeTk9k7BoaeTRERVgJXTMWKRc427I8O4r9iGA7pvx3De+x3tVbHUw5R2AKuk+mL0Kk7nMA9o+o4msoMn1eF25mgDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813590; c=relaxed/simple;
	bh=+bwWJJU8/H444tALJUqIiR0q2uK9FM3aw1trgRGDSRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWUQFyGUqyVFjl7EGzpqJOg1sr97U8BPrtiZhN8WtBlqiKfrmbmkmYnVvpmXHcDzqn8x1fYSgehnZ7MkzPeGtiHh/SXykAqPyI/XIDmJTylncg145XrBfMHT9ZiWoLI01OJ3LuYVDUFUpKIz8gYTXB1f1MoVW/U/hWPwu4+fDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b2bpORnt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b2bpORnt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BSA/MPL4yYO516IkuyJ0Nz5JZO0zPLDAgbuQ4jtHckg=; b=b2bpORntuEjm/nLzNVO920pArz
	lVwDbuJG6CHyx0a+3tERc7eraggMPpGtGH4hJ0ZZTO/3Ro77Kgxsa6k7lx6S/f52ycqT0w5LNMUJV
	S3TBDbW94z0A3fwoWT+HnGd+C8BFr8zzV8BPkvia7bSpHpGL1MkWNy3CTr1104/8uvwQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3g7w-003dbA-4w; Mon, 07 Sep 2026 22:39:40 +0200
Date: Mon, 7 Sep 2026 22:39:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: realtek: rtl8365mb: wait out the full chip
 reset time
Message-ID: <af80c818-d3e3-429a-aad4-38d129e4e23d@lunn.ch>
References: <20260907191940.806734-1-kuncy7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907191940.806734-1-kuncy7@gmail.com>

>  static int rtl8365mb_reset_chip(struct realtek_priv *priv)
>  {
> +	unsigned long remaining;

> +	remaining = deadline - jiffies;
> +	if ((long)remaining > 0)
> +		msleep(jiffies_to_msecs(remaining));

Since remaining could be negative, it seems like long would be better
than unsigned long.

     Andrew
