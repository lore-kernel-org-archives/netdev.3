Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DE407587;
	Mon, 15 Jun 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538581; cv=none; b=hwRdseCbgb4m77iTPeWuKJoDI9g8kKWCsMRjQuQ4nRpnJMnJbd0kMrS3WJTBuzNoMu4I6iK5zlDXhgYmste/I8xOfCCQs6phI0/ewhXLEFTjWe2PPGgPbJcMO9/iIW2JfUSDvzQgQ5qGvYrZgg2tYVZJbHDwr3ZrhIbwpLssaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538581; c=relaxed/simple;
	bh=/E7GvrkXECTo/HpuypASA+JFRh92jRpsrpUdcVghiqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3qm6htXbzLRmZfHpBNCm2AyD3dPkvoO1p5NL2M4zEpOY75OUGHt9VmjdTnFEpqyyYmTEbUnxY0gOXbZAK+zzYW6M7Hz7GNFVygKYMR8d2MMePdUp0hZP0a9FpOPtbQRANOuETwe/y//SLkr98L/W835oHNiC+JeLwSiWj9ahmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oT0cfsbh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oT0cfsbh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5wTvMrRX0IBTYTKwfO8HzxnMI/qKcPwKrCjdFYcZ0lw=; b=oT0cfsbh8s+0sjvUI35QrjujVL
	J4b6EEeN26IXyTRt8jU8E4TKs3m1AsxaaDKhlmKP0ZWjOAdEjatW1q4C5F/K7+4L4WoJzYun8RA2G
	u/pXQ2Fdmy3QD/inzV/7YRsjzxP57HcmIeGNihMno9kvIjJY5qVZptHphWaq2YFaqVcc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ9Z4-007pN5-6A; Mon, 15 Jun 2026 17:49:30 +0200
Date: Mon, 15 Jun 2026 17:49:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v5 3/4] net: phy: realtek: add support for
 RTL8261C_CG
Message-ID: <53fa9ac9-7ef3-45e8-a068-83db7448082a@lunn.ch>
References: <20260615090817.429-1-javen_xu@realsil.com.cn>
 <20260615090817.429-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615090817.429-4-javen_xu@realsil.com.cn>

On Mon, Jun 15, 2026 at 05:08:15PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
> 0x001cc898.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
