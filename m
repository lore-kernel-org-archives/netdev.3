Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB606466B55;
	Mon, 29 Jun 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751238; cv=none; b=PKiXeNbgYHluQ2xhOLFLqMaw9hs36iraraRjrMCNdsAsrpzi0b3wYzkYJBswY/WKswfbVriGbJIRRtM8p6ON/T3N3iIx5tJXa/Q9wbDQfhtxeaWeAoOnZjVOTe7qJ7CwbA3tNvalowscP1dzdhn40iRjszilXysi1s7BWVEYMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751238; c=relaxed/simple;
	bh=WDMPEqZYeN0qJw6TBb89cJUqVRRZql64sfwgLlNdEZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU3LNUk0XOZSyk9cVuiRFXpNvwilAF/qbl+RcK6bqUyn/Q9SJuXnhahxZCCsMt72rwZZnCkpqupWlJpyUMxtrJ/0QWXftxv5lXZkZnRk4pBeWEDRKzcbIzBcLK/vk1uefjjD9UVb/rySae51iIco8RG4HlVgq7rRtzhlazWimAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NxMbMft/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NxMbMft/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+djGRMETRVsAzJKe8US6MqpQv3dZ5Ip9nKfifjhY+zE=; b=NxMbMft/+paMcXrjL2dVxzWVUl
	lgjsVGOZ7+TM/sHfn3exOg19/O6PllrUtvnG+qR8cPSbTXDZJecMRIfjDLPclnM5bmjDkblK+kOCC
	Og2uNPc9ZyAWr69Tjs7NaN9CvIm+Av19Kg5rHMB8uuuiSVMHDFphZ23m5eNhl35NUZ3A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weF1v-009mtU-OR; Mon, 29 Jun 2026 18:40:19 +0200
Date: Mon, 29 Jun 2026 18:40:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/8] net: mdio: realtek-rtl9300: Add c45 over
 c22 mitigation
Message-ID: <af7ba89b-bac6-4e04-b606-8e51a61d4be0@lunn.ch>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
 <20260629152336.2239826-6-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629152336.2239826-6-markus.stockhausen@gmx.de>

> Enhance the driver to detect this register 13/14/13/14 access sequence.

I still think this is the wrong way to do this, and you should look at
MDIO bus lock/unlock.

     Andrew
