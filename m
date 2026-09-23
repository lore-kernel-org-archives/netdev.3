Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38F569F38;
	Wed, 23 Sep 2026 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177191; cv=none; b=IrhhGrd8rW1V09c2YKAAlx+To2bndYJL1ptXHk7KE1A8YieIWit/C0k+iUgNdHUEnGicNeCJRl81HI2JfoH6/D5wI86UXBmUe9zF/HoRYg4JjZCnnBn1dmFL48bignroNcyJnNNRsJTZrVBgDoXld7AQicheZkPviEhttiNtvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177191; c=relaxed/simple;
	bh=vrbPIssYcE+G1boY3nf4mE6n9dZNKraBrKXeokVxoe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJfvfUEM2HFsI+JsHpnfLCfg93Ym6HQ8eZtk0LrAKAOti4vvLu25e+jOF2YA14M+MCS08Xa/alrSe5HrmhuK1clk0tpX2C5Kk6fqU5op3ErESYQF8Xsw6AG0pq1QMwpfAkEmzkz7YjOy5S676mXn7BmPNTbqP0baQE2Q5vi0SgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oCY9s7RF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oCY9s7RF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uAiaR86OSQO2rmOlIf8ugE/uflMk1PnNZbdTcjJO8zk=; b=oCY9s7RFCpSQdCR8gdzuK8KJos
	M+cORGvri83+0gtpAKD60jpPbY3Izo5d2RWyjAqQOIK0SQSH2GG5GCmB44bKQRsmVMyRw/lvBojRV
	jRcyKd0k4IjES1FMy7mbMqmbFZSM/DdMvvu6T2tk0j8G5w8627ZG0aIkKcEyH+iu4Yls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9OrP-006plg-Fk; Wed, 23 Sep 2026 17:26:15 +0200
Date: Wed, 23 Sep 2026 17:26:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: aquantia: AQR113c fix up PMA capabilities
Message-ID: <5b7031ce-4f5a-49af-9d2f-202050f53aed@lunn.ch>
References: <20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06@oss.qualcomm.com>

On Wed, Sep 23, 2026 at 10:02:29AM +0800, Hongmei Xu wrote:
> AQR113c does not report few of the supported PMA
> capabilities which includes speeds like 10G/5G/2.5G,
> add get features support within aquantia driver to fix
> the same.
> 
> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>

Please set the Subject line correctly.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Does the AQR113 also get its features wrong?

	Andrew
