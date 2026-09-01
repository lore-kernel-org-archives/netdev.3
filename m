Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A69418A39;
	Tue,  1 Sep 2026 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231140; cv=none; b=cUoaB0mELa7loIuv9SnD1W/p8acw/B51906JUHC3HGBPGNI6KDJSQN7Xlputyxp6L/xB+y2YGA1d6UXuQcNjnwkMvz5P4FRSFj0eS64Nuf+f/icJZ2ubTQxSvVx0JGPdpxSg92hTI4U5dic2kVBNAY8d9kWJkzxhTG4sU7R5DrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231140; c=relaxed/simple;
	bh=Iszvc2B+1AM0jkEN/fkmnTpNYkHxt01ctdvS0kpBenA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtmaLpByCLNIDwioFDaOaM3HUXSAT+M0ql+yJx5mOhWiZN02iD2TTZuRZbrLRkb8Wiz3tLHcnPrRWGgDU3KMGGy6UoucMP1G+IjoPgipAcy+Kll21ERfu2wEHpiMNEeZvMn9b2y3c+ftCmnNfTG9tb0LbQpZRLnaUWgbhLHW3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N56MgGkH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N56MgGkH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RBIciBePJHu4TIWKwdlTXJQRXcfr437nv2k1+x9xHR4=; b=N56MgGkHsZSpLfM4B1uuwf/LjI
	FzLViVUW/IzxNJuNpKNa96HeXLGVjxqUaUb6/vAolsBCtofUzpxGVx3dEmjoJyjYygalDN0PwL9L7
	doiYZZa4HXe5iLC39O+C2E7raTdbxc5qQW4jhMIRSHdVwQDZQzYMR6MKBY+IjUD0qvO0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1EbT-002I9V-HN; Tue, 01 Sep 2026 04:52:03 +0200
Date: Tue, 1 Sep 2026 04:52:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: xilinx: axienet: Add 10G/25G (XXV)
 ethernet support
Message-ID: <fe83c236-ce55-4c33-aa1f-23028e978696@lunn.ch>
References: <20260831150816.1020883-1-suraj.gupta2@amd.com>
 <20260831150816.1020883-4-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831150816.1020883-4-suraj.gupta2@amd.com>

> +	/* This error handler runs only for the legacy embedded-DMA (1G) path,
> +	 * whose mac_init() cannot fail, so its return value is not checked.
> +	 */

Is legacy the correct word here. Have you stopped licensing the 1G
MAC?

	Andrew
