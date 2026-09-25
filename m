Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F240F73A;
	Fri, 25 Sep 2026 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338233; cv=none; b=Clm+capBeqS59ldV+9GtF6n8S3MMHkMZctgxPAP5eoMhOw8ig87+8kGo8wLegC466ovhpl+LcLvcdt5DuCYYhHcWPJv7sI53iG8A/gyW0bIXKmQJr90P2YlPPHlUBYIjHFTeAKSKyxfdt98kczChhD5KosjElDz2x3Scgf4SAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338233; c=relaxed/simple;
	bh=VJYGCznRNQpQyYEM8PBmLnsTts8Lw1qFtOlIW6V5dss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3kw+2znGJC5UaNQFFVWgJNrvgHJUcCULGyRYdsax77J4HjkK7CmR7cfSWRl8jmboVqiJ9B/75re1hp8fawWPwg2oRVbiw7KRA4kYHmzRq84UL+fO3EGSXfE1zu/rChaunU2xQTHkG5BgplQVV/e0dQJVfwpRvAncP2niEmHNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NrbbzHQp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NrbbzHQp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EMQEp9v0Qeqzk3nZ5KO8ufsPeb+LN16l8gwkJKnLh/4=; b=NrbbzHQpt/YaV492PDMoZZcbbY
	rrrULVjLqx5uqF9qSbiuFym6IsHlIH04W9Z4+aPHmQ7cnBBD/gilGuV4oR8kP4PS0vsQr8VmisyCx
	zZwZPdpthXWS458N9J/FQBuPwFr9rmiUdkwpZhciOkR0y8MeusGSFyyV1WGTLU9ok2rk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xA4ky-007BxK-25; Fri, 25 Sep 2026 14:10:24 +0200
Date: Fri, 25 Sep 2026 14:10:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] net: pcs: airoha: add support for Airoha
 AN7583 SoC
Message-ID: <d1f5d3ce-65bf-4f87-908b-39d1022e934e@lunn.ch>
References: <20260925072712.23419-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925072712.23419-1-ansuelsmth@gmail.com>

On Fri, Sep 25, 2026 at 09:27:10AM +0200, Christian Marangi wrote:
> Add support for Airoha AN7583 PCS. This use a new analog PHY
> implementation that doesn't require manual calibration but makes use of
> internal algo to lock to the center of the band EYE.

Is this PHY capable of other things? PCIE? USB?

I ask because a generic PHY driver is often used to represent the PHY,
and that can support PCIE, USB as well as networking.

    Andrew
