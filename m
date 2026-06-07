Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB33195FC
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855189; cv=none; b=RX4IZe+u+Nso+yTQ59/AncnL7teeAsWqfUprNd6LYrKyGyXvckO/r2vY0ddRt+ToxDARQCYOwN7fiQxIth1cGEVjixIHE28ikIIDMDWL6y+G6mwbugXIQODIras0RfFWEFjzlxJHYUs23MqWbl298PCZ1erID8qkbZZ11IzdDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855189; c=relaxed/simple;
	bh=dBSneK3g/mKHTKlzxrafMjuhEdTM5hLnwGt+sxPwlL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWQgSlxoebdU+UfoRCOyd5Van9YHoZK3no3Dny8MQ3p0Ak+h86drzoiA3bMTns4SQkWzHJsfvdS0GCYdUXXEXikyhjfFjBOzd7CG1Kcy3JEcniwpfjVfSFjSXkcIfEWKwqkSQABnCF5X6myfnhiqW5RpBFI9CdwDrDNrCtKmTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uOSn24Ne; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uOSn24Ne"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Zf0m97OgoTucNTnDyhotBDI2qtIuVu0YxmjCd+niLc=; b=uOSn24Ne3rG8pgy8ZmDnF7JrgC
	JIQgnG892K+WKMichL5TzfvCURJ6PWDszUyPbZl5imeD5mE8ZLvfMDB/KgsuEVMJ19VnTboJ/khRj
	417BdqDtr3lvgz8RD2ksIIb0aUuvvrKP47szBy7FHlgngGu43eNHFslfAezouo0ctvLQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWHmb-006UZP-QO; Sun, 07 Jun 2026 19:59:37 +0200
Date: Sun, 7 Jun 2026 19:59:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v2] net: airoha: add ethtool priv_flags support
 for LAN/WAN and GDM2 loopback
Message-ID: <33c3a87d-ad97-4f6a-8f76-ebab80c496ac@lunn.ch>
References: <20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org>

> When a GDM3/GDM4 port is set to WAN mode, enable GDM2 loopback to
> support hardware QoS. Conversely, when switching back to LAN mode,
> disable the GDM2 loopback and restore the default forwarding
> configuration.

Why not just use the presence of an off loadable qdisc as the
indicator to change mode?

	  Andrew
