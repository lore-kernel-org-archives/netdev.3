Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B630D407;
	Mon, 12 Oct 2026 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815876; cv=none; b=i8DN2Iwpm+rpHag/a7dXFCjYQBqHAJEiabdL70pSpDQ4Du4A97Tg9/oLjIT88f1Spp+cZBXfmE9L8Lg07V/7F5WnOFeCCDIbEZWQOT9KQCD7UUP0gRQiaFZV8h9LK0sukT/C1qRWgSGQhC4TVtwRaRjhWilSEuL+5nv4UeID3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815876; c=relaxed/simple;
	bh=TZn+0ewPw/4Ybt0CwaZG4DDCE0OIrFQnshpHwPu8h64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvhAQTE1kpc7KpitL467f6DsMwoPdgfwC7lmzcgAlx1yp8w29RGDfN6xy8FJ+ezwO16dzSlWMbzkYXYEzRVhOjLSkxa+WZkPH/JXyCl1Q+Rf3Rhi0uKY6kpedz2qsNddDjn8nC9lLrwYM2fcn83kbzOthpJLS1GYDnuVjd6SX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sdiSyCfK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sdiSyCfK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VNTotHqtHWLq3V885Blb+kNFEDKyBBDlCTc+Gl1cypQ=; b=sdiSyCfKtcXtfcsiA/23x279W3
	30VZaYjIKEFdP2lrYJWqvyrXPe9VxOz5MZjP/2dFY/j9gEqO9dx0ViUkMhI9RvjsUXGnf87l7x3rQ
	nLdO/3urv+9bdMhodqT7J6SyqzQCgftOuRpiP0lhWVGcOymhrUlgtzr35sO+j2F0ta4M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGH9u-00ALD3-WA; Mon, 12 Oct 2026 16:37:47 +0200
Date: Mon, 12 Oct 2026 16:37:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v13 4/5] net: dsa: tag_yt922x: add support for
 Motorcomm YT922x tags
Message-ID: <db69e82f-2c9f-4ff3-aef6-8d4ca4ca7a86@lunn.ch>
References: <20261011025043.1859940-1-kyle.switch@motor-comm.com>
 <20261011025043.1859940-5-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011025043.1859940-5-kyle.switch@motor-comm.com>

On Sun, Oct 11, 2026 at 10:50:42AM +0800, Kyle Switch wrote:
> Add DSA tag support for Motorcomm YT922x switches.  YT922x uses the
> same ETH_P_YT921X EtherType and the same 8-byte tag length as YT921x,
> but the tag layout differs, so a separate tag driver is needed instead
> of extending tag_yt921x.c.
> 
> The new driver documents both the to-CPU and from-CPU tag layouts.
> 
> Update the co-maintainer for the Motorcomm DSA driver.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
