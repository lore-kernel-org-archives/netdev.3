Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA663EBF1C;
	Sat, 24 Jan 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769293399; cv=none; b=W7lzc+l0NE/1mMtBxdI/vJgT4h02MY+xDoXjuD0wxl4ZrfJgJyUpekgPPzGT8AvNWA+Cmn/0r1IqErEQcIOhvqc4lIC6d4TxOwBXFjwBUCHUxZ5KBKH9OCx/avizgEZWp6Y55+ZrDCy5UgS7xH8KE94ICKOu5JemZUHpJ05jRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769293399; c=relaxed/simple;
	bh=YVzXQhas0toIeCXzOBaoEcdV9B/FlRV+ZO3zxqsnlcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL69OhViFHYA4v/fetZDPCfXCHlk5PGiauVmTKIXTvpXAggl9yWVyrg3vo8NzD6trfz2ajKKjrkk6NVsDFskJjlS+h877Q81ImGmDyXXzkqsjlYMSd8zsHDpYqNPoRTVDnzNjNTx/2l6g4CWLGKCffXmhtuaWHg8EA2+Q5IhEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SrSktCw6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SrSktCw6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=91EObFawnv2FpeSj30TciysurbabPQzio72p5mpC3Ow=; b=SrSktCw6bRBmWls9rAfqbEBuYl
	ryYqxLiHNniADUD555hBFyINbWh6BilP7VrshhWJ85RM2dU/NbCtup0gYDjpEbPL6ScR00DRBzXS7
	ONmkSkEaxnLBOMKfrzzgho9eMR6bzQmMNOcT2O+3mBo6upcrhLIJNXRCS+1SK5kVAxJ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjm2B-004WFU-0L; Sat, 24 Jan 2026 23:23:11 +0100
Date: Sat, 24 Jan 2026 23:23:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Oliver Neukum <oneukum@suse.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 net-next] net: usb: remove unnecessary get_drvinfo
 code and driver versions
Message-ID: <e91dfc01-373d-4d3e-9dd4-9fb3be92f756@lunn.ch>
References: <20260124102042.112101-1-enelsonmoore@gmail.com>
 <aXTHhI710LK1EsTG@smile.fi.intel.com>
 <CADkSEUjwCmowmo_AwZ7TNS2gDt0CLz6buvfjjXz7BrLfuokM4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADkSEUjwCmowmo_AwZ7TNS2gDt0CLz6buvfjjXz7BrLfuokM4Q@mail.gmail.com>

> Sorry about that. The only change is that I had overlooked smsc[79]5xx
> in the original patch because they had a version definition but didn't
> use it in get_drvinfo.

It would of caused less confusion if you had just sent a follow up
patch for smsc[79]5xx on its own.

We prefer lots of small patches, they are easier to find time to
review. Combing patches is generally the wrong things to do.

	Andrew
