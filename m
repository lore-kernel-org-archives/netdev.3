Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578E3BB12E;
	Wed,  8 Jul 2026 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531383; cv=none; b=dew17oX2ZAO+MBdaJNYOU8u+LmXnIFxTp5ZEGL7EbM8lNrXiXm5qhOrVIiMFNgZf7XjYSYAH/ZPHG4IU6FxM73gA+pZ5cohr5QP5niCvn0tHrL1pO3IWn4nQkkSshgFZdZh1bMiwYYyuurArB9bAZYTUP8LokwPcaXh9dvZrxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531383; c=relaxed/simple;
	bh=u5Q2OLreMrmLTRxKEegWbhu3qR1KMBnmaRKMwGRsRIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cur2Hf6CTsKjhgjZXYzj2FK7hMEWBGwqLx2UN0ENGDAUljLFuP+NmH9nUNLzHlzXdtsz7PY+U7wRRCEDmcsV6uQP/Mf0+xAgZ3BBIDuGOYIbL4rSD2tsSz/2T5H1ENL8RjWYeH/HRJ9iHzOh5OQgWOEvQm5EqGjQdUSeyUpByuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hpZuRScU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hpZuRScU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3++YkgLcmkON0Sm1NTVdLgPcQ8WGoMskQsN/BYk13WA=; b=hpZuRScUtqE/Az7T3x5RFAd2lN
	lGTp19COqsSe+Dx3eZraSt7lCctITwnsRNpwrr/XOpvI9hmIFdBU6DqdbqTMh0ACNwrGmQi1BWnIx
	6a1+0XGbvsV3eCPPirFIEAJ4gjqUKPPSDms3kQ6FSCZHgaEnrGcoKQSudz73cDGVhIDY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whVyz-00BMSn-LA; Wed, 08 Jul 2026 19:22:49 +0200
Date: Wed, 8 Jul 2026 19:22:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <96c362d3-59d2-43c4-b2aa-c12dfeb6fcca@lunn.ch>
References: <ak0KJ6gUk2l_IwoI@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak0KJ6gUk2l_IwoI@makrotopia.org>

On Tue, Jul 07, 2026 at 04:16:07PM +0200, Daniel Golle wrote:
> Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
> SMDIO register access. MCUboot rescue mode only exposes clause-22
> registers; the existing clause-45 MMD interface is unavailable during
> firmware transfer. The MDIO bus lock is held per-transaction (not
> across polls) so that SB PDI polling during flash erase does not
> starve other MDIO users.

What other MDIO users are there? It sounds like once the switch is in
rescue mode, switch management is dead. So how can there be users?

       Andrew
