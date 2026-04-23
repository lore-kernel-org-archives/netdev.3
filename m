Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96B3537D0;
	Thu, 23 Apr 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945866; cv=none; b=OXBfyTVWCXK5QE6ltwjAPCHwU/uOHfmgK58HvaH6xsKWDvSndux3uGa7PZfdHv/NDHz8j4bF0OyxMMOibJYABK8p5flXaVPjOAFjZfG6GS5TbheFdAyecXXyXAiQ95wiw4ArQCdFs6d5+Jkn+r8So0OKLCACeZmQv3ZZ80s6JP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945866; c=relaxed/simple;
	bh=I3tKf4yCmZd/s+7DqMHfh1vBYnGdF6LurI3O+UpcPXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgBpT4/looflGOoNzIgyRlWnYoiViWD+RbnbxhRMN05CleL7nlf8YW5Prumf1Oob1mZwekeJVD2NEiqscft4ThOX9OX6HHcs6iqtRoo55XLOtXsYBEdpzPfA2B1C0oYY9+V4vw7xdbm5iseWe53PMFh6N/cLVqStp+HipWHg4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BqBqnbyH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BqBqnbyH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=USXOe+2GVLHL+20wlkJr5Rs1Oe/LDBqgq93gZrDLmLU=; b=BqBqnbyH8KKOKkHAk6Xr3oecgB
	+NRks7XQ1VbWvKNgYQeWyO00R1UsyEddMmafWk9USYC2rsYoZbaarzFUjoQ+u9cDRKDmYI78wJ1Z/
	pbFOPf0tMPYKf9P7T4dq3QBSuYGd1ShhX6y9b4g9Kbt7l6msk2qkTyQbnZB1Ax4VY7Rw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFsmw-00HEpo-2k; Thu, 23 Apr 2026 14:04:10 +0200
Date: Thu, 23 Apr 2026 14:04:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Fritscher <michael@fritscher.net>,
	Byron Stanoszek <gandalf@winds.org>,
	Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 13/15] drivers: net: 8390: pcnet: Remove this
 driver
Message-ID: <97a5bd32-5080-4dd7-91c6-dcb65e154481@lunn.ch>
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
 <20260422-v7-0-0-net-next-driver-removal-v1-v2-13-08a5b59784d5@lunn.ch>
 <aemy5Lm9B2dLItdd@isilmar-4.linta.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aemy5Lm9B2dLItdd@isilmar-4.linta.de>

On Thu, Apr 23, 2026 at 07:49:24AM +0200, Dominik Brodowski wrote:
> On Wed, Apr 22, 2026 at 01:01:56PM -0500, Andrew Lunn wrote:
> > The pcnet was written by David A. Hindsh in 1999. It is an PCMCIA
> > device, so unlikely to be used with modern kernels.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/ethernet/8390/Kconfig    |   11 -
> >  drivers/net/ethernet/8390/Makefile   |    1 -
> >  drivers/net/ethernet/8390/pcnet_cs.c | 1717 ----------------------------------
> 
> NACK for this one. This is the most common PCMCIA networking device, so
> should be removed only once the rest of the PCMCIA subsystem is removed.

Please submit a patch to MAINTAINERS making yourself the Maintainer of
this driver, if you want to keep it around.

	Andrew
