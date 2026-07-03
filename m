Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DC2D5937;
	Fri,  3 Jul 2026 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096265; cv=none; b=rdW+M9RxCKPZEXSMbswtVELTPaa4SZtG2A8rAlECxrTeuLhBEritlnJgqBtP9xN7FeXoHMGuHypp560Dy6legrdKQFgJI+hVvxC2OythsllVsdsa1djnwprrEnICON94Iea8ftdXk1/J5jZCkGyyQoDkixf61Ds8ZN87g9mXeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096265; c=relaxed/simple;
	bh=15WN/V86a7VYxUbV+qagA+LK0E9ugBgtu+O30/NFkKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz24zKacroinWbrGiwyoxw8dkhPNqLh599qOIOpaASLFX9O82R+iBFbx+6frFF7F5IrwK601JqX79O/PtqLnIM6UA7uEeNqY2IrqfVygtzwxcQvIDKFnNj3Oz5HzWSjc8r7CM7cpV0rwhykaHiDd2tksSMjQ9JDYzCOKexVI734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JBS1jnIS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JBS1jnIS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=etnKuiaGnlG3JOwXFfNRNf+6mlZGHxP3FTCIlaWThvA=; b=JBS1jnISTaaR5l/KtgR6bAxO2o
	H1OcbjFCXm09oKSeKUzlYKj5WlR6rkapsEadgCuFuKbPcYMn83FohkUT4de5A1NS3DomNjJ0ZBZEE
	pasaFJvhydT75vnIBpjLqB9zH/iIS5G4yWALABHn55nhXjwtRs9HzkK/I6vKmFln6eTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfgms-00AZjH-MB; Fri, 03 Jul 2026 18:30:46 +0200
Date: Fri, 3 Jul 2026 18:30:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v9 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Message-ID: <2aa4ad89-c906-4b06-b449-15d08196de26@lunn.ch>
References: <20260703071330.1707-1-javen_xu@realsil.com.cn>
 <20260703071330.1707-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703071330.1707-5-javen_xu@realsil.com.cn>

On Fri, Jul 03, 2026 at 03:13:30PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for loading firmware. Download some parameters
> for RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
