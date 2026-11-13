Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607095;
	b=YFX7HefcdRZmhfd6vGQtdQV9GKDbGCLPL4uVUgc7hKh+onxjNrtTECW3puEwPnhqu7na
	 MRqfrdhDCZcAtRh8yC3525mjTkSoVT00cHgLB8+lmoqpNRHR2QOLtUeTbQdM27t5ZBiHl
	 znHi0iQjdZF+O/m2lB63CgIEb1G4yPKBrHUxjqPn0bJQmlxi857uufGINF3mwJonNkhjx
	 2lHoR8XnC4sQxlYnAJnwR5lxGd6E7Z1JMDn+eUmarW56MV3jkDzDSrkA1+YvNk6jxmauO
	 7ooXZpZacLomkqUT422CrWtIA3UULIMSzxl29Yq/B/r0rplM5q+0gMQgHhG+q432Y9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607095;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=f4jGGstSFCJDPSl6ErU9IyY0WjIsDfkogqS5VlL6TUg=;
	b=2cZnahzdO+q/QMDm5mV6rd4r8d9DQ2vbypLAxiKubAHsqhhKqTdh2Xe5Hd8nDX08hfmv
	 9K+EcGrlEyZBf/TfTHZtYUXVUPEGCZDaJwxxGGqyP4dtCcrtLkt19b5aWcoI7fgc/pP54
	 2GxAMK1xWsYhcGqz2Q3lJxS5obfMMbbD0/yifkNsp5ygBPRePO3xWiPHQf3S8/7g/0vQc
	 rc/eu20B/I9uB9LA7SD3F28npgGwI/edBJjFkb4Ckw23BfywbDivA5sY2cRFv682fpqUt
	 OS57eeiZ+i8u3/1fJMkhCESDwQGLrxogFYUchwvuENmiYrk+tVkrM4+UzZJXU2o16Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hcDiX7xE;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD7606A881;
	Fri, 13 Nov 2026 21:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18BD7606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hcDiX7xE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f4jGGstSFCJDPSl6ErU9IyY0WjIsDfkogqS5VlL6TUg=; b=hcDiX7xEX+u4VqyphszQCsQfv/
	w+KRQtf/pIxBrs585QxYZO+YFBvjrXfjy9LEHQjXQ7riu7nkzRgpDyGUb5oKDOT7OrTFmYHZdNmIy
	UbN5vP0tLbTaGgqetrdNnLyynkBC/xvt95ikHmax5M13SrAccjQyPygspa7XMfOd/LsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRzHb-00GN9v-FZ; Fri, 13 Nov 2026 22:58:07 +0100
Date: Fri, 13 Nov 2026 22:58:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Carlos Soto <carlos.soto@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	Mlody12 mlody12 <kudzo51@gmail.com>
Subject: Re: [PATCH net-next 2/3] net: mdio: mdio-bcm-unimac: Poll for
 completion at 1us granularity
Message-ID: <db69534f-a523-4d9e-ba80-af8518e85fbb@lunn.ch>
References: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
 <20261113211554.2058181-3-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113211554.2058181-3-florian.fainelli@broadcom.com>

On Fri, Nov 13, 2026 at 01:15:53PM -0800, Florian Fainelli wrote:
> The current polling code unconditionally waits 30us, which was sized for
> a ~25us Clause 22 transaction, and then polls MDIO_CMD with a sleep of up
> to 2ms between samples.
> 
> Adding Clause 45 support means that every access becomes two back to back
> transactions (an ADDR cycle followed by a READ/WRITE cycle), so a fixed
> delay sized for a single C22 transaction is no longer meaningful, and a
> sleep of up to 2ms between samples can add significant latency to each
> access when the transaction has not completed at the first sample.
> 
> Instead, poll the MDIO_START_BUSY bit every microsecond so that the
> completion is noticed as soon as it happens, regardless of the type of
> transaction. This turns the wait into a busy wait, which is bounded by a
> timeout reduced from 100ms to 1ms: a 64 bit MDIO frame takes about 33us at
> the lowest MDIO clock the driver can program from a 250MHz reference clock,
> so even a two frame C45 access completes well within that.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Co-developed-by: Carlos Soto <carlos.soto@broadcom.com>
> Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>

Nitpick: Since you are submitting it, your Signed-off-by: should come
last.

Apart from that, please add my Reviewed-by: Andrew Lunn
<andrew@lunn.ch>

    Andrew
