Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97D1D432D;
	Fri, 16 Oct 2026 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185574; cv=none; b=eORi9nMk1GJdcMvPRd7q0mOtW3cAlEyWxbD2WeUdQ28nIE5TSMBNI7ohDfwXDdfNI0lLIdv8eL9dnunReWeR6AM2Mv3AgoLw4fb7xoTpIRpxly1Dys2wfzHflJt5qBcDqUKFsC+pTFq4vonfKwZaDYM7U219B764W7cgpm0gzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185574; c=relaxed/simple;
	bh=Qjm/l1eDIccEqPHw6+qQpJoZIuDerYvbP52G9q0XSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcHxstEeUnfRYxXASeVyZjK+eLkGopztM/WJc2js/SiqLzWQWAzedhLnPcgsub2/PJzOhR/TPoUMRC2TTlQd29WW/fbIMqKsque50KJCHrXzkFFS/9ZXutU271QXONIzvQXz9K2q+1A9dnDINKypFjqGhJGfb3GGWQ799pXYbqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gOeKLYCa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gOeKLYCa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V5w94m9OhMlEyNjDJCLgviFC5Ul1A9TAb36cOzK+GMY=; b=gOeKLYCaFx5Twd1YeYd3hq2mt8
	LUQAW4xJ8qdXcLBt7vXujIu7seUK0ZHIWzqPjjWktE3bS2hLfV4p0iLOZk2QQfEuLH7sVxNl2zpf3
	M7PdEtnHJ1hAimqES9E3WBTrWENpikuSxJZ/yZ/np+9nlS6K3yymbWQoRuTBnvh0YJb8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHpKk-00BEH7-VF; Fri, 16 Oct 2026 23:19:22 +0200
Date: Fri, 16 Oct 2026 23:19:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: phy: aquantia: restore EEE
 discovery in get_features callbacks
Message-ID: <5a7e4b34-1198-4065-9dc6-7db9f8eb964d@lunn.ch>
References: <20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com>
 <20261016-net-phy-aqr113c-fix-pma-capability-v3-1-0bbb1b84035d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-net-phy-aqr113c-fix-pma-capability-v3-1-0bbb1b84035d@oss.qualcomm.com>

On Fri, Oct 16, 2026 at 11:23:18AM +0800, Hongmei Xu wrote:
> aqr115c_get_features() populates phydev->supported by ORing in
> phy_gbit_features and setting the 2.5G bit directly. This skips
> genphy_c45_pma_read_abilities(), which is responsible for reading
> EEE capabilities and filling phydev->supported_eee.
> 
> As a result, phy_probe() never populates supported_eee for AQR111,
> AQR114C and AQR115C. The kernel then clears advertising_eee:
> 
>   linkmode_and(phydev->advertising_eee, phydev->supported_eee,
>                phydev->advertising_eee);
> 
> This means EEE advertisement registers cannot be changed via ethtool
> and ethtool --show-eee reports no supported modes.
> 
> Fix this by following the pattern used in aqr105_get_features(): call
> genphy_c45_pma_read_abilities() as the base, then set the 2.5G bit
> explicitly since the PHY does not report it correctly in PMA registers.
> 
> Also fix aqr111_get_features() to check and propagate the return value
> of aqr115c_get_features(), which can now fail since it calls
> genphy_c45_pma_read_abilities().
> 
> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
