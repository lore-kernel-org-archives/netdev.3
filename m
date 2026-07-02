Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C247F2FB;
	Thu,  2 Jul 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996143; cv=none; b=Tj5Mp8GlhHIqrPk149qYrZF5ejyvi7FatfRIvMItnjI3iAe23bwS53ZaFCebemZ/JtAJB45gNp7rPUp9FJdNKdkUVpiCr8RJ1wPh1xYw+frZupGu5GRV6OGzKe4JkbYIEQhUEA5mHDVZHPOG5w1+eeaiXEe3Gswp5weuoSHH9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996143; c=relaxed/simple;
	bh=NBx2DennnSX1r9HIDzwT5gU80RQbv6zzbDgws8jF9QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWAEaKD9ekTlysbMA2CwcVDErCrDq+fGehof7pBqk5qjNgZZ0Ks4X00DGIT+OZSYtCxAcZOKrSw0hlGYfV4MYV+F7/5l/ai7uJeAzMzDSOOkewHMPRgfXLMD5xw7hPlJRZP65cSwQ0lqat2Llszd1Q8OyXqSVQUBjKnmigxxaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C5B572004C9;
	Thu,  2 Jul 2026 14:42:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AC91D200445;
	Thu,  2 Jul 2026 14:42:14 +0200 (CEST)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 196A9202A8;
	Thu,  2 Jul 2026 14:42:14 +0200 (CEST)
Date: Thu, 2 Jul 2026 14:42:14 +0200
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com, Ionut.Vicovan@nxp.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, horms@kernel.org, Frank.li@nxp.com
Subject: Re: [PATCH 0/4 v2] Serdes: s32g: Add support for serdes subsystem
Message-ID: <akZcpgDSjAg6gcok@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260203161917.1666696-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203161917.1666696-1-vincent.guittot@linaro.org>
X-Virus-Scanned: ClamAV using ClamSMTP

On Tue, Feb 03, 2026 at 05:19:13PM +0100, Vincent Guittot wrote:
> s32g SoC family includes 2 serdes subsystems which are made of one PCIe
> controller, 2 XPCS and a shared Phy. The Phy got 2 lanes that can be
> configured to output PCIe lanes and/or SGMII.
>     
> Implement PCIe phy and XPCS support.
>     
> Change since v1:
> - Fix compile_test
> - Use devm_reset_control_get_exclusive()
> - Fix s32g_serdes_phy_set_mode_ext()
> - Manage devm_clk_bulk_get_all() returns 0
> - Fix s32g_serdes_parse_lanes() error management
> - Move xpcs filein drivers/net/pcs/
> - Add pcs_inband_caps()
> - Fix functions in phylink_pcs_ops
> - Fix MAINTAINERS
> 
> 
> Vincent Guittot (4):
>   dt-bindings: serdes: s32g: Add NXP serdes subsystem
>   phy: s32g: Add serdes subsystem phy
>   phy: s32g: Add serdes xpcs subsystem
>   MAINTAINERS: Add MAINTAINER for NXP S32G Serdes driver
> 
>  .../bindings/phy/nxp,s32g-serdes.yaml         |  154 +++
>  MAINTAINERS                                   |   10 +
>  drivers/net/pcs/Makefile                      |    1 +
>  drivers/net/pcs/pcs-nxp-s32g-xpcs.c           | 1006 +++++++++++++++++
>  drivers/phy/freescale/Kconfig                 |   10 +
>  drivers/phy/freescale/Makefile                |    1 +
>  drivers/phy/freescale/phy-nxp-s32g-serdes.c   |  953 ++++++++++++++++
>  include/linux/pcs/pcs-nxp-s32g-xpcs.h         |   50 +
>  8 files changed, 2185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
>  create mode 100644 drivers/net/pcs/pcs-nxp-s32g-xpcs.c
>  create mode 100644 drivers/phy/freescale/phy-nxp-s32g-serdes.c
>  create mode 100644 include/linux/pcs/pcs-nxp-s32g-xpcs.h
> 
> -- 
> 2.43.0
> 

Hi Vincent, all,
I'm taking over the S32G SerDes/XPCS upstreaming. The effort has moved in-house
at NXP and I'll be carrying it forward, continuing from this v2 rather than
restarting from zero.

Vincent, thanks for the v1->v2 groundwork. I'll keep your authorship on the
patches that originate from your series (Co-developed-by plus your
Signed-off-by) and build on top; I'll send you v3 off-list first, as you
offered.

A v3 is in preparation and will come as an RFC, with the v2 review comments
addressed.

Vincent, if you're OK with the handoff, a short ack here would help make the
transition visible to the reviewers.

Thanks.
/Jan

