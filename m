Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4283ADB92;
	Wed,  2 Sep 2026 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382604; cv=none; b=APQvQ8wzajrarPO0VCzkY/1fBQD3NmOiFFcBCJDWsQdNEMv05LcsCgKfQoM4ZcnDIixZdhGbfKqnS2EYPGqrr4DobP6JxrXdw4Z7Dqf/K1uvxKlA7LBRsj6iWIk4aW6L2jtQhCgut6H8LZ+zFP90quHCClOSiPLA5Fvk6/J8sTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382604; c=relaxed/simple;
	bh=w8mpcDlZzQjHGedL6f2f57KjFLNxO2kOoYGGIu8QfLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7lwVBQOK1V5j5BJdiy4bVLt3Hedbi2m+mcxm3dtjvH6B6PGG2aVSO+sAMQEZBULmuaD0UhpQo9+A2TQ+TanZDtWnxY2UyldKPr1YRFTlYVEOK/n1OK/lHBHz3dMUBSpFDPSi/iWCR5i+50LEiZzZw8S+ZCtwuPLvedT6paeZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PJUHbkXY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PJUHbkXY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7WRT1BsF7VK3pnqo2rj1unSTDxkw4+xSOIWyaeAyzbs=; b=PJUHbkXYNp7u0sQ/rsmGGapuL7
	mAyUQhI95aYpRSm0CvMF/ZNvP32XxC6vJGTfB4AnnLSCtQgnb1WRw102RCkKUaMdokNFYgOP+A6bI
	nK8M3vFnP/t9GWfK/kgtu2o2ngBstcLIuFeWZ5HDkj17LiqeHlCLxCS4RmIisr0lWlz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1s0W-002aYf-7j; Wed, 02 Sep 2026 22:56:32 +0200
Date: Wed, 2 Sep 2026 22:56:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v9 15/15] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <d53e40fa-f189-4467-aa3c-096743781ce5@lunn.ch>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
 <20260902-ax88179a-v9-15-8e6d7710a2ae@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-ax88179a-v9-15-8e6d7710a2ae@birger-koblitz.de>

On Wed, Sep 02, 2026 at 06:57:29PM +0200, Birger Koblitz wrote:
> The AX88772D, AX88179A and AX88279 are 100MBit, 1GBit and respectively
> 2.5 GBit PHYs that are found in ASIX USB-Ethernet controllers of the
> same name.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
