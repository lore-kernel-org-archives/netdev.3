Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12A40DFC3;
	Thu, 19 Mar 2026 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773880572; cv=none; b=SMNCozFjxGvPRM2c5xs12Rvpb+mVtOmv0XNKQpSOmJtGv5XQKPysxAsE2lUN2RvLpFmDkLOdEhahwZE6ztKI8XsNwur4vikCdzGx/04eVo6XLDuCIq+C6o5aEBn5a7gAW6N3PXapKzQxNLxEatYntYJ7WSt3h4Aqyu/kKen+/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773880572; c=relaxed/simple;
	bh=GLRxmZqFR01k+/vw+eN6+g3NUOdrIhuDKe7/EHNHSTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4cWdaUl8vdPW1Kv471LZcpQ6XRjiUMWdL23f0/lOZteVYlDkFxvu24hEa1Se6A7JyW6r5gj1oCP+fJOZfU4Utzz8ykLQ+BQCsrVw3u3Jp1N744Np+JcPLYYLYF39cfM3wBhE29DuUP4dPl2g5inw/ESUYQ+hul+HA22xo6eif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qJhLg7a4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qJhLg7a4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7xpA/C5tz/CpKZahcDKyOu6poBgzBCZEd5UawYwBT+k=; b=qJhLg7a4oqGLAhUvbffrGJ40bC
	4pzhWzD7uzYU4P5cSUlwduYA3UgjGCYzxLDzO1YVMx8fumRI6UdYXUp9/n/x5UWp+xssnYmRF4bzc
	g5rEOw5W6ETvWGIjWSQZqVSw99aODB+6Y5Mzrst5b6Q50d7hKZ3H5QD2IlDodfaX1N5DgTT0Ndtjq
	9iZy7tImoGtCV1npgu/Pj1LN41ql1XMT7Q2++FU83m9N/zoS0OlxQ6ffYhYI/It0EziYspthrZ2Gx
	mvfNGK1/hPPwNW6Pdh8uYL9VpL4vna+nuXApqXLxHGdTGVI/QdtufRYevWAo2ovAK4wjF0kXOD9HR
	/+WSwH9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54544)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w31Mo-0000000045O-2FVc;
	Thu, 19 Mar 2026 00:36:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w31Mk-000000007Z7-2Ca1;
	Thu, 19 Mar 2026 00:35:58 +0000
Date: Thu, 19 Mar 2026 00:35:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 0/8] net: stmmac: improve PCS support
Message-ID: <abtE7sDT75I7uPnk@shell.armlinux.org.uk>
References: <abQC7r38QLhSeadl@shell.armlinux.org.uk>
 <abdEscs44fU4kRag@oss.qualcomm.com>
 <abdYu864OmNWiWIW@shell.armlinux.org.uk>
 <ablpxwGks9m38fhM@shell.armlinux.org.uk>
 <absjNQ2s3Z5N2Zwo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <absjNQ2s3Z5N2Zwo@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 19, 2026 at 03:42:05AM +0530, Mohd Ayaan Anwar wrote:
> [    8.650486] qcom-ethqos 23040000.ethernet: clk_csr value out of range (0xffffff00 exceeds mask 0x00000f00), truncating

Please look into this first - with the MDIO bus operating at
who-knows-what frequency, this could make reading from the PHY
unreliable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
