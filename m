Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104631DA60F;
	Sat, 24 Jan 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280561; cv=none; b=YizMqM+ndXPEJq9BKLInIncfg1/ev75tRu0ilyK+gNEnnZNZLPROjsb1QonoJKckfIPBvaJbTD4Io7datMUs2MMU7Ro9zle3kowmc0VuZFg2DstbbXeSqM+QpicOMZdyV5R1LEzni0EJOaU8z1gLW2mKbtLkK5DXkOvUEthDCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280561; c=relaxed/simple;
	bh=I2AEfzXWA9r03df6Hax5x77d85rPnGoeKzfpLsxDDf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq0t4qW6+qIPBRGq96TQPMZzRbfjxNKFnZHLDQsyazNqEWpEa9p9pNfXL++zQfww6JiC8/wtw5SdOm80t41Q6hCrHUksrJzz8xuI28XUc6JBW+o6667B5GOGUq4R94ycU3pggccWp3Ugc3wpw7g7Ek03lVXMWozUJfcb03mnrSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=opK94cmV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="opK94cmV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GAlPgHJ5rg7VK3bfUh85vdVf1pECnbqXOd8IMWOIUAw=; b=opK94cmVtKyG1xc/KWwsj6FFil
	9zoOQzde8mduAlLGNj4BtBXMmAuiALIPtVjSYJma2OyfSPwjaWQ+pHpl7NBDFGlcAV4G84T+ScE5v
	U/DB0/l3BoUuTzwkr7NTpaz7PkxN2Ek9tX9hN0KEp0sm6/2LSCCyhYpzt7DwEDXFS5y8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjihB-004VCl-B8; Sat, 24 Jan 2026 19:49:17 +0100
Date: Sat, 24 Jan 2026 19:49:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: usb: smsc95xx: use phy_do_ioctl_running
 function
Message-ID: <ee359515-32b1-4382-9315-bb76f1775fb1@lunn.ch>
References: <20260124080751.78488-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124080751.78488-1-enelsonmoore@gmail.com>

On Sat, Jan 24, 2026 at 12:07:51AM -0800, Ethan Nelson-Moore wrote:
> The smsc95xx_ioctl function behaves identically to the
> phy_do_ioctl_running function. Remove it and use the
> phy_do_ioctl_running function directly instead.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
