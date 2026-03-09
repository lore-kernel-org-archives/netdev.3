Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790BC1A682D;
	Mon,  9 Mar 2026 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054168; cv=none; b=MsmoEjt6UZzjL+oeYM2IFUodOHc28ctC3zleQ2e+Ms9iQM0uVEki+7QS/RfF1vR67IpiFUJyw0LLiEZsS0tlYmSGHcXPUDz2Wor+5Ze6xImd6gWwrcJKVcQqg/Muovtgz7VeQjjaGj/kWlSfDqz3jz2ka3BkqL4OJxIS/r95cus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054168; c=relaxed/simple;
	bh=0hux6s+q2IE32ojAatIIWOV4BuOR0FWWO5Z/4OpA4Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/+Ym8i4wBAqcpQQ+tzu5mll+Tr0+Vg+PeIZaO5jWLvXNseUfmW0nsbGX7IQ0uZezBmf5fZ7VyFdSr3xqfISA7R/tZIZdsmDqKzTQC/2nqcpanWMRm4m9j9NqcQMIXsZ6x/MKNZn4fuxmTC06FyTcOi2RLKqGX/I2xPk+xr5ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kQnBDvz0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kQnBDvz0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sAkRjP9jYISvdMSyBJJw0ajApQvAkfVgmNZbtMfYkuE=; b=kQnBDvz0laLdm0pWRVN8e4/E3s
	IgESKlZ6AMDuT1IePF3BZzZWkfTma4/fS3zWrngtkKycV66UO8DR32Z8ppv8fNyqJB2NcNvhn0/oA
	b37FxopH4vF7Q8NVEulkxinLjgcyzw6sEVaMb1BnM3FvouqcBdLAoibT5BK39sQNi8URpXjSpHNmJ
	PFh5V5zYBHZKMSKE2tfdnaiq4OQw1KvkuoQNg+Scb/k1AF//X2KqmHkEDJeNaz1l4fBH1e/fAV9Qs
	hER0s+tKnKBpcebWKfkEibAqcTdfrKVvcFI0lO1YB1A22xf72DsEBrDHexqtpnCLr5Oj9q66wM82z
	XPom7/Xg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vzYNj-000000003dG-0zT3;
	Mon, 09 Mar 2026 11:02:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vzYNg-000000004FS-1Hwk;
	Mon, 09 Mar 2026 11:02:36 +0000
Date: Mon, 9 Mar 2026 11:02:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next v2 0/7] net: stmmac: improve PCS support
Message-ID: <aa6ozPBP_OlayFs9@shell.armlinux.org.uk>
References: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 04, 2026 at 08:47:36AM +0000, Russell King (Oracle) wrote:
> Resending this as the original RFC now conflicts with net-next.
> 
> This series is the next of the three part series sorting out the PCS
> support in stmmac, building on part 2, which was posted yesterday:
> 
> 	net: stmmac: qcom-ethqos: further serdes reorganisation
> 
> Similar patches have been posted previously. This series does away with
> the common SerDes PHY support, instead using a flag to indicate whether
> 2500Mbps mode is supported (STMMAC_FLAG_SERDES_SUPPORTS_2500M.) At this
> time, I have no plans to resurect the common SerDes PHY support - the
> generic PHY layer implementations are just too random to consider that,
> and I certainly do not want the extra work of fixing that.

I'm intending to tweak this patch series slightly. First, reordering
the patches, moving patches 4 and 5 to the beginning of the series,
followed by patch 1, 3 and 2.

The first two add support for reading the SGMII status from hardware
which we don't currently use, then we add support for BASE-X and
start using it for 2500BASE-X for qcom-ethqos. This should result in
no change at this point.

Next, I'm intending to add a new patch which sets
plat_dat->mdio_bus_data->default_an_inband = true; which will enable
in-band mode, and thus start using the SGMII link state. This will
be used where the inband caps indicates both the PHY and PCS suport
inband. For 2500BASE-X, because the PCS reports a value of 0x01,
that will switch phylink automatically out of inband mode.

This should mean that phylink will switch to inband mode for SGMII,
and outband for 2500BASE-X, which will eliminate the PCS configuration
change done by qcom-ethqos.

I've also changed the "report PCS configuration changes" as I
suggested, although this should no longer trigger.

I'll post this shortly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
