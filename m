Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9AC429803;
	Sat, 17 Oct 2026 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245194; cv=none; b=Jrqzxc8mWFMvrSTmmzebNnG8crabG6bEx5jnzyLYYjqfuaJRfqw3qT/v96BOA9w3vUGd9jJNVSx8nEFhaLZgqVGVcgYPu5w/r5RO0loq+zUH/HND09F/bwamOVIt47aBtBLhpvgyDwxwrqCzZke7Au1amiWmR4O+ayIUwifEtOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245194; c=relaxed/simple;
	bh=Z2KK2RSNi+ai5oTf6xKE77Qx1Sac42HVmsdQQOs6s50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baiZ7Psrs1gWUV0NElI/fmNUfGkLI89DDxYAY5nsoliaRVj7644i9+jxUFdw8gZNum8HNhxAKNkuuo2BvWA0U+O7eJUZ8WjTQU7yPMbZ+KdOfV91Mk0Z0k4auJwXo/AnJWjlpbijpT8jje9f9EPUGueAkhQCF/431Mq+1b4VW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IXvf3/2a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IXvf3/2a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qqki18dh2sw7qjBR1ax+MbRp8zg5PnsDMbmc+/oYY+Q=; b=IXvf3/2aiKKcGiRfgJNajtyG6X
	nCHfg9ARZOdM+I38LEsFL46clgsoBcFs6GZUBdPPmRNI8C0M5+PDbaaSyjaICSMjhI9mZj9J6VreC
	OCz0w1u18rl3cnIJvIwG1lDs8oAFfNIRt8+99Nt4pS0wIBBd+3K7DNhtzoY/I6JFW6SY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xI4q9-00BKHj-6D; Sat, 17 Oct 2026 15:52:49 +0200
Date: Sat, 17 Oct 2026 15:52:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/9] net: phy: dp83867: add regulator supply
 management
Message-ID: <5402d24c-3d3c-4ae3-b63e-605bbdf64ec5@lunn.ch>
References: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
 <20261017-shikra_ethernet-v3-1-26a8beb44b8f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017-shikra_ethernet-v3-1-26a8beb44b8f@oss.qualcomm.com>

On Sat, Oct 17, 2026 at 03:15:12PM +0530, Mohd Ayaan Anwar wrote:
> Some embedded board designs use GPIO-controlled regulators for the
> DP83867 power rails. Add dp83867_power_on() to enable all four supply
> domains at probe time. Absent supplies are silently skipped, so boards
> that do not describe them are unaffected.
> 
> When any supply is newly enabled the driver sleeps for 200 ms before
> returning.  This satisfies the post power-up stabilisation requirement
> mentioned in section 6.6 of the DP83867E/IS/CS datasheet.
> 
> Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
