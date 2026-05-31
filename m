Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD018E02A;
	Sun, 31 May 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241139; cv=none; b=rj4RvQ0kIqd0/A2Tdnyrk1EOB4QPRrWdeoNPJhD1J/kXsqXJ8+E8aHsP4R2icmioHmJWVbZcgL2VOrikHnq+BpaAplsr/qCJN08gqK8emxWYyfbO+hWAVOQTvghC3r0699/gGJ2t/v9Tq9C62Lf3rmjImChZJN2hdthzpXWCw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241139; c=relaxed/simple;
	bh=QJdRrhZvfINQYg94kjlJQiKsAS/EoDlREda7BlZqvsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHmMn/Glzh36LuWGWeXMhhMCuXTAiXNXKzaDOPEbV7Jb7x7xJjCw3kMim7LxHrJ3FVgcUMCZNQeVjkZ1LtZ+7qht45SO8M4ufNRplazWjMzvX1qoXmW3/6wau6KlGuyrKtyRAwuDDLMpAJ5KGdjY2KXRntjhYK2dluKaTRav3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KKNK6V6r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KKNK6V6r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tggoz0W6PHZB8ZgX6WAr7umIoLdUih9Ni/G99H8whns=; b=KKNK6V6rOi6rhPcZWfhaldaaow
	djS8oJfaAUDEPAQulDUJnvbYngG0/m4L1zoaRe+6kABCzkvnTMlj67VgqtQz5K68O2DB4VK94fNfW
	NH9aNhBnZWnM8+5ou6vMKcIOtrgP+UUyB1/A3Rx4hUUJnmUD7kUeqhSyiwqgZZUzG80A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTi2Z-005N6r-IL; Sun, 31 May 2026 17:25:27 +0200
Date: Sun, 31 May 2026 17:25:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 09/14] net: phy: ncn26000: Support for
 onsemi's S2500 internal phy
Message-ID: <5c8e4a0b-339f-46dd-a22b-310797f022d6@lunn.ch>
References: <CY8PR02MB92496757556AC350E712191883162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92496757556AC350E712191883162@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 29, 2026 at 06:41:06PM +0000, Selvamani Rajagopal wrote:
> Adding support for internal PHY of the integrated
> media access controller S2500. PLCA tx opportunity timer's
> default value is correct in this device, compared to
> NCN26000.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
