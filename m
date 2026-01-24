Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8253EBF12;
	Sat, 24 Jan 2026 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280954; cv=none; b=EY7uo3GPhN7TTymJcRcWHlIiI7XS6Hi6xKzsdo8KuqjMJhhKD8e9GnmEE9o3IWDBpT6rcV70aw5UfcEed6mqvd/+53umme8Q5a393rP4qQsRmduhcQ7saQKnv05MJ9w3JbV6ZUx2WEb1VvdsF6QbV74/4ElzlTAO5g2lO0Yifz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280954; c=relaxed/simple;
	bh=7nyuEnO33AAV0ZcIFPeQ0kU7R8Ur/8uzFz3kJxZfMOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn4RKr0KJDhnf90SJ9gMcnfeaSH58hoOr9nXHU8ff8yMZbsoUttAkPSrBqcIV5+AjfjWSPio/AgvTPpK+WcZEpjbje6P2Gue0Q+gPEQeCTb8YQZYBnH+Se27zpfr5qTwnkOHIhdtAbiTUCdqk2mNCs2N8aYwMV4ujzk/vtZkcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A2dDj2s7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A2dDj2s7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q62Gvy1EjFTJ20YElIN/oACYKuQgSPj+WiUURBLfctk=; b=A2dDj2s7KdFsI3t86Fq5dDk89e
	0fjdAI6JfKCbEpWbjfZF4yFdcoMiGvuucyW2Rvopkh1Oywd5Cz6KQk2DLmGhVuKfFFtgZkzbN1Svp
	8iOOtW2sFC/zZlRWmsXg+rMzxTybpMoyn3FQzX0/IlsPESnT6ggX/Aje58IwN8RjGzqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjinU-004VGs-Ft; Sat, 24 Jan 2026 19:55:48 +0100
Date: Sat, 24 Jan 2026 19:55:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Oliver Neukum <oneukum@suse.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH net-next] net: usb: remove unnecessary get_drvinfo code
 and driver versions
Message-ID: <131bde32-47ae-4f7f-b92f-71702c89ff56@lunn.ch>
References: <20260124092423.97481-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124092423.97481-1-enelsonmoore@gmail.com>

On Sat, Jan 24, 2026 at 01:23:26AM -0800, Ethan Nelson-Moore wrote:
> Many USB network drivers define get_drvinfo functions which add no
> value over usbnet_get_drvinfo, only setting the driver name and
> version. usbnet_get_drvinfo automatically sets the driver name, and
> separate driver versions are now frowned upon in the kernel. Remove all
> driver versions and replace these get_drvinfo functions with references
> to usbnet_get_drvinfo where possible. Where that is not possible,
> remove unnecessary code to set the driver name. Also remove two
> unnecessary initializations from aqc111_get_drvinfo, an inaccurate
> comment in pegasus.c, and an unused macro in catc.c.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
