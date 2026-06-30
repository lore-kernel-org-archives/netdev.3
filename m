Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C326F1A9FAB;
	Tue, 30 Jun 2026 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857039; cv=none; b=pahB1gbUcLYrjxMDCL+3dZH0b1p0Q54jFH2u+p0j8GuYCmym7M2GdjIiRlKHqPtPXcPV30dPCvwAabZnP+LKHUd4x/fRUjywh5FdUN8Ys4RIV3kkdvD3fz8SPE5bGMmSMUp0O69q2Hr0KBK2CrrYfqz1ukzcUEwT3SdDor3iuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857039; c=relaxed/simple;
	bh=cK+O7/XCu4aPt7NnRvAI0tpavuykzrZEPg7v5BzyKa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccaoxu1qtRpcqryvlx1n+c8PHR5ESbWkyPZDkVmHJY/hOsoV3FC9TuhvH3mSqv307q+FmWG7CbsWNDBF9ZlUSU2x2iA/KBJXZ0WA/kt96A22To9VWjrjuJ9z31QgQdIYbjAEaOLrRt62kx047vlSbyIbe95r9ZaVW5f/Jg6QVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EL3h6M7P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EL3h6M7P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XWJglUQdsIP/I8zVCTTz9htWO6qEW3IEvfuRVWBI86s=; b=EL3h6M7PCGqRjiVcCSabElaLWb
	Kxu/odip3olo8i0/Ffv/4/HPHqal4v/JsKyo+XV0IgDeV3E1wh1r7nIIgWEgLBr1ScK5izmolCWRK
	NzAiAxlUSm/6xph5wBocvK41r/W7v3MqsJy+G9I0ctaOKRGwhUwFBCUsl9t+dGOO3q4k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wegYM-00A3A9-8x; Wed, 01 Jul 2026 00:03:38 +0200
Date: Wed, 1 Jul 2026 00:03:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com, nic_swsd@realtek.com
Subject: Re: [PATCH net-next v7 2/4] net: phy: c45: add setup and read
 master/slave helpers
Message-ID: <c09ebfd7-a5d4-4ed1-88be-6d47befe14a9@lunn.ch>
References: <20260629064718.1349-1-javen_xu@realsil.com.cn>
 <20260629064718.1349-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629064718.1349-3-javen_xu@realsil.com.cn>

On Mon, Jun 29, 2026 at 02:47:16PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds two static helpers in drivers/net/phy/phy-c45.c to
> configure and read back master-slave roles for non BASE-T1 Clause 45
> PHYs via the 10GBASE-T AN control/status registers.
> These helpers are wired into genphy_c45_config_aneg() and
> genphy_c45_read_status(). This changes the observable ethtool output
> for drivers using the generic c45 read path.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
