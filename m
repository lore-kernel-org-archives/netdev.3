Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1423C4569;
	Fri, 20 Mar 2026 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017948; cv=none; b=VnmWYNyTqotaB0rmSH1RqU6DCx0myF6j+qifxPly38KxqcyOsHsaiwKlHuPS7b9uUMZecbvxVYgJoRYj8c7uQalLHHekO0NwgTW1eSIHGKb2hyhvPDeWVfBgkDqcmmMnn7xKoynSkcCxauoDnLZ8njZnHML2BjqZIxB7As0XYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017948; c=relaxed/simple;
	bh=qBa55GlxA29pRQ/jYvrAaZksNOPxLN72XF9M10MlWlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEW7z1uStFE0TFQusQW6O6bKYs95IIn5M96iuroww9dKhbdTOGljneEUQ+opo0fEriq01XQvrt472F+ZArkF1qxC8e0EG+4Rg3fxkUIdMngssUzyTCeaYrPflEwjWsdT8TbI6q2EPnsQqTDW+RWBmteUMXZfc2oYUvkLMoj2WJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YMu2+JTF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YMu2+JTF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zkkFxBKoL0Oafe+OXBoXrA0rys94DPf2mbkJ030SJKA=; b=YMu2+JTFYiwkNNmfXzc5QT0AFa
	XgHEjMBV4PyHyZYCYYimrHXoPH5HutN5pvlG5GFh9WtULnU5K6Sjh4ZLOvPV33aU5/5eqUtR3KxA4
	LP3G++TTfL6i+CTJ6e6F9GvR6nIkhuUM/qltvLCM/3VAvka8h2G2zmYcXYUXxN15GjCPMKoxreOjf
	JIVtG6a1w3ugStzWc/uP0j7euB0NYniAbwD84RZmTuan6wwv6oTEN8CitXSVigmsQJHSRFF81v5ke
	4SRrimN/19kavH+E84ye0sg/hH9ratpJ0n+K085WeOPqW5FHdN57ZyexR16pysJ2v+KCBoCozwQ6s
	7VSKMScQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46618)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3b6U-000000006AJ-15Xu;
	Fri, 20 Mar 2026 14:45:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3b6R-000000000u4-2REG;
	Fri, 20 Mar 2026 14:45:31 +0000
Date: Fri, 20 Mar 2026 14:45:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <ab1diwlayiWMsBIx@shell.armlinux.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <aacpVFhH8eV7dxHV@shell.armlinux.org.uk>
 <aaspCUWel9k_ls4i@sirena.co.uk>
 <6022954.DvuYhMxLoT@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6022954.DvuYhMxLoT@fw-rgant>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 20, 2026 at 10:39:10AM +0100, Romain Gantois wrote:
> Originally, I implemented a runtime PM support in the SFP core. This allowed 
> to cut power to the cages when the attached network interface was down, 
> thereby saving power.

Have you measured how much power is saved by this?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
