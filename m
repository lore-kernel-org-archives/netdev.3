Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE1483819;
	Thu, 15 Oct 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096458; cv=none; b=gn/tVH2LAbGl0nyOY2Ag9iqU/VWvmNGrL/C3g71/qayJAgmIijjaMmfQIdhOrGIKtEjBGKryYp6j4+1apfpc7WCZIXgG/RTRJl9xfC+Q8SZGlTcmFWaoRfT4MwW3FUJiuOzO4jp7JhAYz9ko3nJG6ea5/+BIBDes2amzpe9ZcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096458; c=relaxed/simple;
	bh=gDpQFN++xPwT0x6m8l+Fta4hIRm9lrj7r30nvMaPyW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vpf9SilxY3kjzcP+uJt71iocFvWGyqmlYs81+F+hDqqkfHH8oieD2wFYUpczmi44lsKWBE3C20K9dHD/VRWbwPP4ovTlJrsgV0z4gyPceg9tavesN3Bynk+b5tGihXL+XjxiOjNMCp62bJVie/LmLi3HI5b2Wc6QW4PllKftaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XS7h2Ylr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XS7h2Ylr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sT57Px4Vg7Js1kzkyVxmNzndr3U3+dmuMx+Xr+DujHo=; b=XS7h2Ylrdx/fLqFAMc3VTKBd0s
	VzmZ4Vci+QLQFGsd4MDtb+8axLdtxA1loz5sD3UfsGTmMh/0nJQfVNNCFEZY1klml8gN0BrE714PT
	cvORvzPM3T1r/1OhC0jzZ+qFc0CN84RXXd/FWd+Z/R9AqT2u7fcZVUIWraC5+B5MhTr4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHS9O-00B1JS-3W; Thu, 15 Oct 2026 22:34:06 +0200
Date: Thu, 15 Oct 2026 22:34:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@riscstar.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: pcs: xpcs: fix operating mode selection
Message-ID: <597dbcf1-8362-408e-a1ba-256b07b99713@lunn.ch>
References: <20261014223100.304486-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014223100.304486-1-elder@riscstar.com>

On Wed, Oct 14, 2026 at 05:30:57PM -0500, Alex Elder wrote:
> The XPCS found on Toshiba TC9564 is unable to operate at 2500base-X
> and slower with a PHY connected using SGMII/2500base-X.  This XPCS
> supports 10Gbase-R, which is the default operating mode, and this
> causes mode selection to fail for slower interfaces (SGMII, 1000baseX,
> and 2500baseX).  Writing a reserved value to the MDIO_CTRL2 register
> avoids this failure.
> 
> Wangxun already addresses a similar scenario, but includes custom
> quirk handling.
> 
> This series implements handling for slower rates for an XPCS that
> supports 10Gbase-R.  The first patch rearranges code that performs
> soft reset so that it is done *before* the interface mode is
> switched.  The second adds code to xpcs_switch_interface_mode()
> to update the MDIO_CTRL2 register for interfaces that support
> 10Gbase-R so that the desired rate change works as intended.

You Cc: those reported by get_maintainers, but i think a few other
people should be involved, who have made changes in this area:

Coia Prant <coiaprant@gmail.com>
Choong Yong Liang <yong.liang.choong@linux.intel.com>
Vladimir Oltean <vladimir.oltean@nxp.com>
Jiawen Wu <jiawenwu@trustnetic.com>

       Andrew
