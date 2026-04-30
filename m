Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE518C2C;
	Thu, 30 Apr 2026 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507990; cv=none; b=o4iRA7f8Pu1A/7NnindjEfUag99rQ065w/9qCkNorrlRTogtZaOgwVnxFhWWTIi19zaGYz3cQPFk8f7tpJOyFTD4ffwrnY11UPPrSW07Eon8bE5m0v1SDeaCnBmSeGuvSkLdikL2/riAgGdyHSTcJwmMukN5gNNMvRTUYJW4fbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507990; c=relaxed/simple;
	bh=BItvzQkmDs3qE/bIqrWLinaBdsIIA6iXl/Sl1zB6KG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+phCArRpvzx3mi1/YSSslVZ+bD2iPPZ/olRmWvVz40Ec5hIxv0jAGovWJuZ++RqXLtqnaTy7YSPosQ+pvzfQLNlL4eP+KDPgOjVquudSvKClW1xpHZFXXD4+mx0RXSDEIpLtwLAZ/xo7XHuqvDO336rCQUwD9w11obW4UbFKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KJWUAyPA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KJWUAyPA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J2ry0U935a8I3q3XfQjQUSSNMEI0AxgGrv07wg6nKVY=; b=KJWUAyPAQWZB0kky33B6zNGF0S
	k37urVAle+ZHmV+kFU9r768+7cpcdanW2GHOptBCiw5++7XNvs5iwYeRjB0CiUk47ZZDYlVSkhAK1
	ED4HFLTpgI1/4ymFQmnirTXu5YTTxq7AgDmoHuA2Y5wPrXOj1XwcLFuAI9blhprja54k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIF1L-000bDY-T5; Thu, 30 Apr 2026 02:12:47 +0200
Date: Thu, 30 Apr 2026 02:12:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jakub Kicinski <kuba@kernel.org>, chester.a.unal@arinc9.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
	ansuelsmth@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <52d69a5d-a951-4a65-a947-7aaf41bc3daf@lunn.ch>
References: <16efd278e4f17776ccfbf8491e5be71a4689c137.1777385305.git.daniel@makrotopia.org>
 <20260429234612.2240476-2-kuba@kernel.org>
 <afKaVQ27GUQiWZTb@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afKaVQ27GUQiWZTb@makrotopia.org>

> > The priv->bus pointer is initialized during probe. However,
> > INIT_DELAYED_WORK() is only called in mt753x_setup(), which might never
> > execute if the DSA tree remains incomplete.

The opposite of .setup() is .teardown(). So if the delayed work is
setup is setup() it should be cancelled in .teardown, to keeps things
symmetric.

	Andrew
