Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7736B912;
	Thu,  1 Oct 2026 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862817; cv=none; b=gZhLtfyNhUUMDadbpSlYuDYPfzyJfp98FGpOgoO8J3nOwgHG23cXtWpYPIxVGux8SNq4K9neCSh7bZrbs01S56Yjci7c4eES2BLDyskCKmyPthFdqgG/L3pM/4LnuPuKrhBrjU0EMxZxv4dXyN0/4+ZNkrpsyZ4IgsLQ11klbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862817; c=relaxed/simple;
	bh=uCdfcz3v6mxxw3wC/s78cYO+k50sdqDfx1y0FX3fHU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDP7hwxpw+mBFxR2GpB4aCTW6E/PSrTCWpid9i0CUl/skz22gDpw9HeAcqckuHe5w3cwMGWqKteu7V06Rw7q3366QNmJ9Q0C3z6Ffr79IREo7K3l+hNWvx08EBzGGRKj4nsKNhQuCjLCzIDMdYuHbUS3+CBO7n9cLFHpUF+fvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=38MSYv9c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="38MSYv9c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o1erPuTBrPzxFY3cpm9t8CWiJEf5qm/y/ZbecFvb/I4=; b=38MSYv9cMjolrsZPutOvwHpQ/C
	nHkJrQHZElwLnAkPVTe7mftiqo2a3ucTBylGoHT2034eodK2UDOK4gQ8cJ+9MdKMIEkcaqm2S+lw4
	cAVlq3en0+owiy7CPjzysxOpv9ZfK9g2hUwPt4K4uO0+udJ4B3WeczZJlebtCHVfDZxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xCHDu-008Oh1-Fw; Thu, 01 Oct 2026 15:53:22 +0200
Date: Thu, 1 Oct 2026 15:53:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Marek Vasut <marex@nabladev.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Message-ID: <0b1e6d29-5054-423c-bf7d-2206f2473579@lunn.ch>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
 <AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
 <AS4PR04MB9338B4278A2A5B94FA854056888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR04MB9338B4278A2A5B94FA854056888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>

> Okay, but please consider Andrew's suggestion. Add clock-frequency
> support for greater flexibility in adapting to different situations,
> instead of fixing the MDC clock to 2.5MHz.

I consider this nice to have. And to actually implement it, you need
to know the base frequency in order to calculate the divider. So i
suggest the first patches in the patchset set the clock to 2.5Mhz,
then consider other DT requested frequencies.

	 Andrew
