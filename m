Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495017BA2;
	Fri, 13 Feb 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771008462; cv=none; b=jrzHRjaB+adjNEJngpzciPXbk5HTTfYmunA7I4LUInyoQJIRSuy1n99ixqqXckv8QOIvix7wAs2o8CoMTVuUOUAkpbJPohYq7uPJevBzwHpkXSR9lBZac10MjGHqKNS2Q//9BvVL7A1MR2cyZUAR2Fa/ScJw+yr0gTJ2NG7RmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771008462; c=relaxed/simple;
	bh=TJY/s3H43xuizNMto+kfjJvv/5kkOlYO7V/EZHsTUiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cvuw7+4gPwgd2moAnnyqEovm6vII/1iwCWo+bilooFcdAQbhFBEJ9LVe03fpQgcn47N23zuc+KVtfAvepWXXBXNOSi/RVeUNBqXXyQw45io27Quv2GbT6YwnvvOpDaEip/op/nSPD0uIWqJj+UI7949eIZnIZ2i9ZD59OKbh80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uw3nfuQk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uw3nfuQk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=75dVsMxQSCtUUOY53Ie7fIWd+5uJDH3ZUDCTQzFC4E0=; b=Uw3nfuQk2vnBKDqEE0hg49gaGP
	jOFooSYkHGRmG1wuaPpOukxKzyUbS4AH/11S8n/03zr+ibncYMYo+YxyX4MR8dq4FnBaKVMyMeBPd
	tv2nXH1JbMp9Vy4z2PMyr02z3CLML3I5NapbP3aDJKubc4BF5nfnJ8xBEQY7PI/4p7OcItYaBlmZk
	IwcX/rf7J+ftwQFedzA7b13Dqy794HJxpbySNBpBKyb/fIP3G6NB/7rBHLytqjkNZit8MHeXyhdp4
	Qga9tk9lYwTWVb7s12Y+QUUM3j896xk+e5wEUTzlF9b8Ztkv2ACGfGTiwUzkDegKWIQhLWb44azds
	deqmxpQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51324)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vqyCF-000000005SA-1E56;
	Fri, 13 Feb 2026 18:47:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vqyCA-0000000060W-1oGw;
	Fri, 13 Feb 2026 18:47:14 +0000
Date: Fri, 13 Feb 2026 18:47:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <me@ziyao.cc>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: Problematic understanding of phy-mode in Rockchip DWMAC driver
Message-ID: <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
References: <aY9s5PXP4zZ7R6fa@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY9s5PXP4zZ7R6fa@pie>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 13, 2026 at 06:26:44PM +0000, Yao Zi wrote:
> Hi folks,
> 
> I was looking through the RGMII delay setup logic found in
> rk_gmac_powerup() of dwmac-rk.c, and found its behavior is strange,

dwmac-rk is very broken and is unfixable thanks to Rockchip not
understanding the RGMII interface modes used by the kernel.

It is what it is, we can't change it without causing regressions.
Please do not try to fix it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
