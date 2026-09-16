Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D93DAAC2;
	Wed, 16 Sep 2026 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562008; cv=none; b=pEnuq72yjjQCv8cgCjODU7u93dgew9S9kDAt8Ss8oyb6lvsPraCHLLArnVpr3kRdQ2T8xDyvDAMl5IvUdWpQu6ARXshXYa5v5oiFKByot8QmodXsOTcM7F+mTAVCigEdW+kZb6PYbTpWgDv2kxO6NIQOXnX4e33sYQVas2OqX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562008; c=relaxed/simple;
	bh=sP5rqHNvJgvFdZoxhnqZDbO9crun1Qy+FcnrYXyNKLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgdEPunix+nOdvx4iB5qtO9OF1e6CJbAV39ZH/CxHzHtMm8QVPTqvP75yjG1vNWRWk3dZSzXmUN7pavuu5Q6xPi0vVtbLSNqYKQLJXTT3sGKeTQ5CEEbKQ8LGIr6hEserjGwxTK5xnMa9FnrD1gffteJZ/ROFkVWI2hWvwroZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OsdACiBa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OsdACiBa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KC7cqL1N9efHNeYoXYd5krKXRGhul30TvrWbn8hygIo=; b=OsdACiBaI6MVSfYUvr0Ce8J2Gd
	TjGj81Em3XhRffHy2Coyuyg0ZTTOkaHJbMJ5i+Qu78hDsChCTcoODBKssFZnJKm/2K2xV+wvlUnsc
	y4gHoXbJXOtjfpc5Xv9o62CIyx0eEPdxxPEvaax32AQm64ICZTr/AjF/ZQjzY6vdTMQA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6opB-005Tbh-C0; Wed, 16 Sep 2026 14:33:17 +0200
Date: Wed, 16 Sep 2026 14:33:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 3/3] net: phy: realtek: add support for
 RTL8261D_VM
Message-ID: <d640b8b3-40de-464c-baf1-05b8dc1239a6@lunn.ch>
References: <20260916081444.497-1-javen_xu@realsil.com.cn>
 <20260916081444.497-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916081444.497-4-javen_xu@realsil.com.cn>

On Wed, Sep 16, 2026 at 04:14:44PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add support for RTL8261D_VM, its phy id is 0x001cc89a.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
