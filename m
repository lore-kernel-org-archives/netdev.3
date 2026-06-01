Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22335372B50;
	Mon,  1 Jun 2026 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319370; cv=none; b=acOsSC3PtfqhF/XUPeGyMt7cq5rd/t+/rOh55vGnRrXshk2T0JXgZnStb656sYDiTcqEGTPm9VSLtBZkfr0EnosGbAr5VT2nP99n3D0Q92k/6jeVGkpFo0u5Tju5dCvwERgwQIY3c+RKxpReI9n4w15FFwlX+sU32AWb/xjOsUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319370; c=relaxed/simple;
	bh=XxvgQGerUpwt8iRlXZM8UdWNvaIMJk4uw3KBifQ3mxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdzlgbfmJPu8BXlelEsx7nxIj0nJBkz5NVNUN8R1sdCdPkeZp6fleeI7V9qbugelH5sF7iYIZ3xo/YXL0DnLEYvTZ4x16Ejt8YI9GdHJHTDfn15JStcpvBr+MoTMr0Kotiid4y5sX0dM/pxGRndd60tCblc8/VAb5hrc82J++Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cy87BTmU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cy87BTmU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yXFpaWuT9wt15zY7aD7ngz9aDxvO1R/1bZEsyHrwDxs=; b=Cy87BTmUkaXPYhuaKe8BnPndE7
	bYyIkMjpbhICFdfwYDNxXAoFYDn6svAibQEDj/jnKgCHRGjU2yjMyoy9QDavKWwNpR65BuCdZ3xi8
	PxGbVoIv/8Ql7pzQaPY1q53/JQZ/bPbenycLm5f3eQAJ0SZP622m0YLBfe36k+/ksQRA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wU2ON-005VfC-8M; Mon, 01 Jun 2026 15:09:19 +0200
Date: Mon, 1 Jun 2026 15:09:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shaoxu Liu <shaoxul@foxmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add power management op for RNDIS host
Message-ID: <248e3597-c3ca-4e7a-a508-bc9a5b4e41d3@lunn.ch>
References: <tencent_96AA6EAB892D4596D70BA972ECC3667AC505@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_96AA6EAB892D4596D70BA972ECC3667AC505@qq.com>

On Mon, Jun 01, 2026 at 11:29:19AM +0800, Shaoxu Liu wrote:
> RNDIS host does not manage the USB power, and it will
> cause more power consumption even when no data transferring.
> 
> Adding the power management operator will make the USB
> enter suspend mode when no data transferring.

You are doing two things here.

1) Adding a new vendor:Product ID
2) Making that new device manage power.

The commit message does not make this clear. Please split this into
two patches, and make the commit messages better.

Also, please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr
