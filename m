Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5D3A0E8A;
	Thu, 14 May 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767511; cv=none; b=hdsu3b1NgKLx3w80lSgfX2nRy7lAhCMRh8Frf9fObsjZYEl+Cmp52MQ1NKdyPMtlVtQJPWmkNv5iZSSloHuw7H+sfMaDOCzyap4mLRnAQGQqN4xcGylsqhjv86z1DD3t6B9n8ufwDzx1rxMq09n9JPegF4tcVBUwVOoZm2tx9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767511; c=relaxed/simple;
	bh=vPAduBjl8oMw4oLLFxL/pDJ+ZwHl4IsmAu7duRxZSkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un3gjhSyUeASaiGKFKaj6H6/XgkNI8/rfeJ1K4VPqf7xrsXceEnrvzwpOS7GuEc/Be9xBnZdO/h7kfXHcM7AbnVwLoCZKCf/GVv7IrOB2Uu2njIfvgokIWgEdWm3O0eHW3YjuVzS/HmxmBWcD7e4tCbaRjMVVpge5iCStBEMDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OrZ8kIOd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OrZ8kIOd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L370SzS7X6C3tntTSWVgtOtzf65DKhEXzhFrCyxMqfU=; b=OrZ8kIOdbuRX01crjAMGXdiAx8
	o+9HSHMPQ0tFea6afEWr7SweckY4JoT4r22MWU3qnNO0ilZ7nYoWhrxMaFMFCIKo6V8ehIgrDlzQ2
	l//258vWhuKTTLMpeC5GMhwO/ltDBL9psW6gsj5abD27a8pKs74cVh/To1yT2u2gScAI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNWgR-002ujv-03; Thu, 14 May 2026 16:05:03 +0200
Date: Thu, 14 May 2026 16:05:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: Re: [PATCH net-next v10 8/9] netlink: specs: Add ethernet port
 listing with ethtool
Message-ID: <29e43b47-ab06-43d0-a48d-137c6fe15e1e@lunn.ch>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
 <20260513130521.1064094-9-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513130521.1064094-9-maxime.chevallier@bootlin.com>

> +  ``ETHTOOL_A_PORT_VACANT``               u32     for non-mdi ports, indicates
> +                                                  if the port is connected to
> +                                                  another device that could
> +                                                  expose a MDI

The name ETHTOOL_A_PORT_VACANT and the description seem to be Boolean
opposites. There needs to be a 'not', or 'false' or something in there
to invert the meaning.

    Andrew

---
pw-bot: cr
