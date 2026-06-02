Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736582899;
	Tue,  2 Jun 2026 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436859; cv=none; b=qfkJ/694otR8ZcAVqnQoomUjKRkRl9jP7rhXEufZZwj0qkraMkemDrigt6lIRJERFCgrlfGE8315FRDltNQJXuBdc9DUAaOjaWPyuxrWhAdTM1ehrVY3+zE4uwHC90KuZdyFWvd7re/idQIGWBwLEgnl72yW2xS0sv1GSY/4M9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436859; c=relaxed/simple;
	bh=gHc7r4WxfvEJUGHG2lg08uF5bacabWFzr+bp+QTeucg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fec+X69Mf9EEdKl5ZBWuVD4flSlukUZvNOvEE9IaQl0Mm2nTtyHOBfoXx4cPek8MRp//u+WxPlyEmPq9bSH7xXjgp1Z4KrntC1zkXOX6J6tBKCN5b2mlAOJvgxXjDa4A6bDQqfkWSslqRtb02AAOK2uSttbyVwPWP69BO2oy68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t5IGYAS8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t5IGYAS8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=//nNaE6gxeoMML2yK2kEJkCHcj+FCtUumR027IgiKUM=; b=t5IGYAS814Y/2MRHAuAWULTrxz
	6agzJoQjAaOQlKpKc9xXCSx37I6sJGc2UX+n3C3jNxkBxxpXqNh4dH7vg04wO2zKBOh6wZAF/teQT
	wH9WUiqNrU2BCsTcPxrOeZKfjwI80ORQcl4dQ3rcRK7T3D5W0AK7KbB1gxjEawUI/fcE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUWxH-005lRM-1y; Tue, 02 Jun 2026 23:47:23 +0200
Date: Tue, 2 Jun 2026 23:47:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Laight <david.laight.linux@gmail.com>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Message-ID: <f295db46-3d10-47e9-bc22-582fe3fe7851@lunn.ch>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
 <20260602150712.5b28d58b@pumpkin>
 <CY8PR02MB9249B26D4B4344064A582A3C83122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260602223807.1ac76456@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602223807.1ac76456@pumpkin>

> The frames are padded to a minimum size so that collision detect works
> on maximal length 10M coax segments.
> (Or rather coax+link+coax+link+coax acting as a single collision domain.)
> The same minimum frame length is used on modern networks which are all
> physically point-to-point and all 'hubs' are store+forward where a minimum
> packet length isn't strictly needed.

You need to be careful here. This is automotive T1 system. They do
actually have old school CSMA/CD. Did i remember the acronym correct,
Carrier Sensing, Multiple Access, Collision Detection?

	Andrew
