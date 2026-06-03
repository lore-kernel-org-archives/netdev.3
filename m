Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A651DDC3F;
	Wed,  3 Jun 2026 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445800; cv=none; b=slhGO/lntWEha7Qa+aB5pkc1Pwh/tu4vYNwLTzDfqxjcZMjD7zdnidhi25jBmPimvv+5Y9G5H5I77X+zJi8r9bJgb0ku01MAlY7NCZpPZnWpLwwNrpcxb11qJr0XIl0aJVUzQJ+6pp1GHQRXe7dgN6XzSKCahL5ktJHNK09+xro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445800; c=relaxed/simple;
	bh=VnWcVr1Lne7dR7bsrfFF+fMQKU1U1TSkca865MsfDfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P97VCm6LBUnkXo6JnrUMvYZT60M0iAxsgmc7zzNuNMB3wnaIU6QTCCGwS9Tq9JEXsxxNOAbyCzocaurVZBtwiG0FxE24jcQwI8G/vX7S1D0V0/QJu5Y3ERuzH9nwQ6D9Y2fB0gevVKjw3hxIj5dm6W/dcnKUR5jYMrZ7WZ3RzAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aJpcr8La; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aJpcr8La"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZmV4UCd8znAK5gyIFcgOlICFE9S4/sbctQqsx7mz+8w=; b=aJpcr8La3BX13x5sb39NR3WPfM
	Wgf+u0NzavrCFXn6qAEZBm/pBckeGvyaKIBkIDkE18u0XlE0WmwaWyx6dsXW9CYTN6yDDWzhRkXfA
	y0iS0+BMTacbyf4obPSeJSEIg/TJXoZxEs2a7UnZM6PlOEM0q7bG7dK7JvvORYivyA28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUZHf-005mLO-NQ; Wed, 03 Jun 2026 02:16:35 +0200
Date: Wed, 3 Jun 2026 02:16:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Patrick <gregspatrick@hotmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] net: phy: sfp: detect presence via I2C when
 no MOD_DEF0 GPIO
Message-ID: <930e4026-fc9f-4f49-b6e8-4ab9d597a361@lunn.ch>
References: <20260602235528.2795028-1-gregspatrick@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602235528.2795028-1-gregspatrick@hotmail.com>

> -static unsigned int sff_gpio_get_state(struct sfp *sfp)
> -{
> -	return sfp_gpio_get_state(sfp) | SFP_F_PRESENT;
> -}

Humm. Why?

      Andrew
