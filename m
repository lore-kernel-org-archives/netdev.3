Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AA3E8328;
	Thu, 15 Oct 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081648; cv=none; b=uDNSAoKYdqewOza0O2Jz41O3eF5P+KSs9LU7vlFtCTNCUdSCEAOetFF6irpPC3gdBvpp+OTIDy/EySwXKLXxi3jHDBGh04cgSMLTwK+Ehvmgfyhqy6OrOcpL1LAdZ9T+51ynnDCraY47ACLMKKiOOnbPh9y031FBTowCZCQEvGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081648; c=relaxed/simple;
	bh=uonIIClogFYOKtOy4OyoegoQrD0WZnHNSpQFPfvJHfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABSXVj6Tl60FOusOJNitLQuX1fI4Zahw04svUI1KAvw3anBdHlnlFVJGPjrniNWSqrzBdbtiMUftzQywccXSdk3kQt6mMcwQwiYypQFYVmmehkJkLbwFzKPRYlBY2haUT9sDA5e0ZbCs4NfeiEibZfFchXo2nWKXO0ViYjabIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vT/z3Saj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vT/z3Saj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TolzObcggGsHIr69ul4n19FES48teXB7Q5Nog2kgj94=; b=vT/z3SajRPaeAoVuj/d5+cW9F4
	jyRpHpnENkuc+iYr5+YdriLcXFRSIvwRiVWxJ4sQ4XiBmwLyr+K65dKJX+yIPryGuqPwfGWXhwRB8
	mwK6OFOrXnKw0rMCzvoFrmzjHx2kwXNjwBQmxOeAuBZxjJpGQuvwGYB58X8evgkH8sXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHOIH-00Az5e-5e; Thu, 15 Oct 2026 18:27:01 +0200
Date: Thu, 15 Oct 2026 18:27:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@riscstar.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Daniel Thompson <daniel@riscstar.com>,
	ansuelsmth@gmail.com, donggeunyoo.kernel@gmail.com,
	mohd.anwar@oss.qualcomm.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: Add regulator
 management
Message-ID: <1af4e7a8-adb9-41bd-8841-61180b284470@lunn.ch>
References: <20261015143849.483339-1-elder@riscstar.com>
 <20261015143849.483339-3-elder@riscstar.com>
 <atDz2hJ6xpA3p5y7@lore-desk>
 <4fc165eb-b57d-41f8-b7b9-c9fe433d866c@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc165eb-b57d-41f8-b7b9-c9fe433d866c@riscstar.com>

On Thu, Oct 15, 2026 at 11:01:43AM -0500, Alex Elder wrote:
> On 10/15/26 10:40 AM, Lorenzo Bianconi wrote:
> > > +	if (count)
> > > +		fsleep(phydev->mdio.reset_assert_delay);
> > nit: should we check reset_assert_delay field is actually set?
> 
> Are you saying there should be an alternative delay used
> if it is not set?  Do you have a suggestion for what to
> use in that case?

Does the binding require the value is set?

What happens it if is 0? I think fsleep() is happy to delay for 0 uS,
but does the hardware still work? Does the datasheet say anything
about power on delays?

      Andrew
