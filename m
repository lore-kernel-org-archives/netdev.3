Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5F36D9F7;
	Tue,  3 Mar 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553195; cv=none; b=mQ745lHvyruq9hPEATi/W+ZzRUiRC7vhP0g7tI3zHEU1hda4B4lGlu3kn611nD/TnTm0DbDNJDvTlycj/0hYP9Umd7laTh94D59xNwdtGM46r5DS1XSgqg5n1X/0WTz/OQpRs1vY9z2YehiDnfg4D5YUabiv9dBUfTZTh9SwH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553195; c=relaxed/simple;
	bh=i0vxSKNrglF+HfDErWtKifPkEfp9pl8XYQ/LTHgJW6U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kxxyQV1efvflYtNLNT5+jhnyEPWeydsjEIGF6G91wOAJnlOLAJbGGVaRbgAgGOA0QOmkIJdtLsRtzbkaTChSfafwwfDq2QGjZ5v6IyayHU6F3xSEcZ6HDSnnYDUXL/pH0NOeIx7tUUDfPSPfN38N94nVXG3xvfi0rXSqJO/WhbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bUR1CERm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bUR1CERm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m7ytA09r9MSTJPCkDhQCSLuflvhto0YiYFFHJD9HlzE=; b=bUR1CERmx8ojd37QL+5QoXEcmP
	+YJf6jtXgh/Su3FEbG0rUTDrNGFZ49y4o5nbiEVdteFKfYTbZsfE5jm9gxYoNwiXgl82S974v5nHz
	F/JqEJY9Iqs65RIaKUMUTXs1T4gT1Wrks66SKEPNOwmY3N6n32WMLS7d+tLhR+xmJjJkWxv6glNLZ
	TzEGE94sufcM6MnyGi5P5CMU6pqxofJxJ0/mOhTKgJ4umkHiZ815PY9RWFFvz6cm+2TEH3Rg6WjXi
	14Kbyw5k8Bh+AQU6nrWcsZ4avY2oiAVp0B7lcqMjb0DX/nMo7Za1U/Pm4uBQoN24c8vCliBqS9Spn
	29ty9Y0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48450)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxS3W-000000005JB-1QEp;
	Tue, 03 Mar 2026 15:53:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxS3S-0000000073S-31Ko;
	Tue, 03 Mar 2026 15:53:02 +0000
Date: Tue, 3 Mar 2026 15:53:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH net-next v2 0/7] net: stmmac: qcom-ethqos: further serdes
 reorganisation
Message-ID: <aacD3osfaZkLsGxm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This is part 2 of the qcom-ethqos series, part 1 and patch 2 of part 2
has now been merged.

This part of the series focuses on the generic PHY driver, but these
changes have dependencies on the ethernet driver, hence why
it will need to go via net-next. Furthermore, subsequent changes
depend on these patches.

The underlying ideas here are:

- get rid of the driver using phy_set_speed() with SPEED_1000 and
  SPEED_2500 which makes no sense for an ethernet SerDes due to the
  PCS 8B10B data encoding, which inflates the data rate at the SerDes
  compared to the MAC. This is replaced with phy_set_mode_ext().
- allow phy_power_on() / phy_set_mode*() to be called in any order.

Mohd has tested this series, although not in the resulting merge order.

Changes since resend2:
- Drop patch 2 as that is now applied
- Add Vinod's Acks, which were eventually sent in response to the first
  posting of this series.

 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 31 +++------
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c          | 73 ++++++++++------------
 2 files changed, 41 insertions(+), 63 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
