Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578414A2E3F;
	Wed,  2 Sep 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359961; cv=none; b=qtH3LXxr0rROLsmO7Ia7oNmabHobcwIj807HGwu92nIW7mC5+GI9nx/8YkouMSgQ/J8MROPXYKpl9T2jQCRF5DFnvAVwbGJowp+ezuJzPDuMlhNMm2hQ++22vJnXHbO2QxIWFh8PlwKofcp2O31E0MAWNLu73rJMFaSHq3/qNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359961; c=relaxed/simple;
	bh=+x2YgdlKss25LU4ZayxSBtc1tUQj5vYBgzAiEMRk6nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW3wgtaMzqBPRxVJ6mkgaFy2K+EIuS6jsuGmPHbkXbWLoQF59FFwFxiw0C1SpMqjwJrKFp4XVygEdfTx1p0h8E2iMZnUPIKFIyTIVb4QlS3KBFuwsn6UdHuTMyMjODakJhAg2OHGOz/rGLfjFv6N0H5PG4MRcHj5ZZNG5c79veU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ap/PrcgP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ap/PrcgP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1CrawKwaMvFkbEVCpph0GK0gbB8SZ73x0coQbMzkNok=; b=Ap/PrcgPf/+8wFVMWF6cWd3UPJ
	/8Y+9ZpKEOmNOm++PN1X1UTxdAGLVsMwggIWP74L7KXEmhqE+WQ7MTvFFYLUJNB3XXGX4kQvbZo8e
	zdmnpOhGdqIoOZUkkAlIKSNHLKQ8Q8M/MOvxzI3ATv5nTyQENXu8HBGqrioH26/UbNFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1m72-002XDd-J8; Wed, 02 Sep 2026 16:38:52 +0200
Date: Wed, 2 Sep 2026 16:38:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v9 4/7] r8169: add support for RTL8116af
Message-ID: <c67acbc0-6686-4cb7-a7d2-cec49938c70a@lunn.ch>
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
 <20260831053745.1197-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831053745.1197-5-javen_xu@realsil.com.cn>

On Mon, Aug 31, 2026 at 01:37:42PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8116af is sfp mode. Phylink uses pcs to get the link status from its
> serdes reg, instead of standard phy reg. Speed and duplex are hardcoded
> to 1000Mbps Full-Duplex. Also, RTL8116af doesn't have internal phy, so
> we add some checks to ensure that tp->phydev is not empty when we need it.
> In rtl_hw_start_8117(), the MAC calibration for register 0xd412 relies
> on reading the internal PHY register 0x0c42. Since RTL8116af does not
> have an internal PHY, this calibration step is intentionally bypassed.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
