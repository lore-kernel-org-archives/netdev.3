Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973086;
	b=EpLg5nB207g2OiG6n8WQB539UDHHMye9HFFGE+1fCZu9DQFUCOX5+kjuJ7ClkQ27fKQn
	 C17S/wjiHxEKJ/NCH2LnByqRWJ75HirFmiCtFfIvEx6jKQhrpUqTOvHz+HXp2YkhWDV8y
	 CF+pr21GhPULGna1njO/dmPELB8tSJNe3gc+Sebtdzz1WlBurLnc3TvN20KQSKzKI63KB
	 vr+DnGjxHjC0A+IXLGPJetkU+wNU6NZWKyjwYlIrMKqG40WQwe3GBsy/GS8IpcsgGzwHF
	 8ebn0AdGI2NCj22tOrvyLT+cAAPPQnheOuhCjp4PbUVKyRH8tWZEvLpPoIUAY1G8lNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973086;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qeICje2YNdfsBQRYsbfVR7niizvYHczhtYbtuMr6CdQ=;
	b=v+m4E/71P+AsC95DGpyw0yBEzwucX90njHuTapWrRCERQegdkjaXLpJ4RduurbE9yPZ4
	 pRCV7vG2NdaQRE5uIamwmtZ9Ope1sQkXX35LI1gQ7p0t1UgA9f7GG7PD89EvcPamqUJWJ
	 RpaXhfrRHosJhwfBNNcRhdMk8eRgvZ6JzK8B+88wvogKYR2cm/56OmGE1MgBvnOxGvcuk
	 aL3rDp5b6sjeyM75tFCPbeXe4OJ1EA0+VjGC0SsGBfRX1ngKfKT0WRQmg+GWD1QF3xZEX
	 6Vq5qLZ5iC1ZPoBiASxfL+LeW0tXgnuu6pAm6W/Vct3T5vJhcaFhRyQMYlfLLx6mvSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aV4csmfn;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79365606A326;
	Fri,  6 Nov 2026 13:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79365606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aV4csmfn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qeICje2YNdfsBQRYsbfVR7niizvYHczhtYbtuMr6CdQ=; b=aV4csmfnKuakOW6TFXoLC9Ktu0
	bIBLZe+STOBIT5HyekpVuWK+ge/O30bQ4Mn/eTJN2e7E8YtVPyRBBSaNF56VvujedbFIYnf+GnNmu
	Com3q+B15IT5KrR6rFA1UrK3HW+eGmCzA4zI0CgJbZTyfafsmyvnK4IniSYjjeG8JLBU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPKLe-00EmL2-Og; Fri, 06 Nov 2026 14:51:18 +0100
Date: Fri, 6 Nov 2026 14:51:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Thilo Zirnstein <thi.zirnstein@gmail.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: phylink: keep initial advertising
 settings
Message-ID: <fb28453b-9df6-49a1-8c01-543e7bfceeab@lunn.ch>
References: <20261104125509.3221743-1-thi.zirnstein@gmail.com>
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
In-Reply-To: <20261104125509.3221743-1-thi.zirnstein@gmail.com>

On Wed, Nov 04, 2026 at 01:55:09PM +0100, Thilo Zirnstein wrote:
> If the net device is phylink based,
> consists of a mac with a phy connected and the
> mac driver does add the phy while the ndo_open callback,
> initial advertising settings of the link may be overwritten
> during phylink_bringup_phy.
> 
> The mode of action is as follows:
> 
> * The link was not up yet - no phy connected
> * the user configures the advertisement of the interface
> * the mac driver delegates the call to phylink_ethtool_ksettings_set
>     * here we are not configuring the phy - it does not exist yet

If it does not exist, it is not possible to validate the user request
is actually supported by the PHY.

> * the user set up the interface
> * the mac drivers calls phylink_connect_phy

At this point, is the previously configured value sanitised by what
the PHY can actually do?

Take the example of a MAC which can do up to 2500BaseX, but it is
connected to a PHY which only supports SGMII. Before up, the user
could request 2.5GBaseT, but at admin up that needs to be reduced down
to 1G.

	Andrew
