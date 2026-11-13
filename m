Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606914;
	b=VyfI362ilxIIbCK4L9pQTJcvs3nzbCUYcgSRULVlk3pEOqdDLE0ee7/R0sKxUjYsCp6z
	 sQjoE87bYs0vw09CD69mD6pomjtSyRTwgfjt3x0nfM/GUTaqBeS5NBFFAz/YVzAmpBt2w
	 TI11E4TTsTBr9KigvZ6dlgs7fCLdfHkW/dj2EpaWt2pv0HhyE01BhnMbjWUvgsC4hQw9e
	 Ne+zFZhz9LOYeY68v3eVy8TSwwZLKs/47fAiZvTLKV+lZCOOtTg0qx/Tj9elRF+qRCjBB
	 Ps+YgOVCY0zSj4hZZcvkGMKPzE0DpAgziqJMK5e8tjvXZRVM/w9y4J7kjEJyJ2Unm/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606914;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=yvbW2zcWdHKiTQdDa2WVBHbUrgqT6+HK4UGo7OmSEdM=;
	b=Wx+kOIuiX6fsLlsNkpFj2umJiK5PznLEDYOrOGD8if8uBjHYvndAGLk0k8udBcgQVDWB
	 6/oGWUQn8qMFRm3woKgkHzgLQt2H1HqMVIIAVGQ+ZlbqV47HnMf+8h09AvInCBUVkYehq
	 Fl+OdPz6Dd3ZPlKg96RGSEXdIAzPqo04qlC88ZUXLJi4r6CCMyQ0b1voPJbOy08Vl0OqH
	 Rw9RCwq6LthK2wURTu7Vy/EKxcCgHUwe79TlITbodjpSItUL+qTxqpkd2/Q7AzIb+AdYH
	 IQVAGNYtwdgXdLd+Pl7dNH80gmJe9vAy+YZEBFmyT1cXUgigfMClToJcaIbmww5GMiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=K9efZJWe;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C498606A335;
	Fri, 13 Nov 2026 21:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C498606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=K9efZJWe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yvbW2zcWdHKiTQdDa2WVBHbUrgqT6+HK4UGo7OmSEdM=; b=K9efZJWen246tWt7pNoIQc+xDn
	j5wZQi2KcP1+JeaE5Olq+LZbfEYODo+HZbE1uqHp8HSyFK71a4u9YCiyZudVj8Xjegj/T9WzpZdWT
	YFbSBp+7IzM38uW3wDFmR/LsT8Xe/ZsSOUWJ1/KKcFVPEAHSBVkNvVh30q5pYm74DsqQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRzEa-00GN7v-7B; Fri, 13 Nov 2026 22:55:00 +0100
Date: Fri, 13 Nov 2026 22:55:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	Mlody12 mlody12 <kudzo51@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: mdio: mdio-bcm-unimac: Define
 MDIO_OP_SHIFT
Message-ID: <1b1a10ad-108e-4b54-b466-94ab962bbb85@lunn.ch>
References: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
 <20261113211554.2058181-2-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261113211554.2058181-2-florian.fainelli@broadcom.com>

On Fri, Nov 13, 2026 at 01:15:52PM -0800, Florian Fainelli wrote:
> The MDIO_CMD operation code field starts at bit 26. Define
> MDIO_OP_SHIFT for it and use it to build the opcodes instead of open
> coding the shift.
> 
> While at it, rename MDIO_RD and MDIO_WR to MDIO_RD_C22 and MDIO_WR_C22 to
> make it clear that these are the Clause 22 opcodes, in preparation for
> adding the Clause 45 ones.
> 
> No functional change.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
