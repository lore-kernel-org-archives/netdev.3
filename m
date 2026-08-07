Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF636E489
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110133; cv=none; b=gDl0mbtP1WYq5zs4yxYJt5KABaGSBrj6DoSJzTpPB95tUPCEoWC/FNlm1Lb4ZL1QfgH7zEtZx3KK+IPVXlNrGeBHerYutp0o8+58R0YP2X119vpq2dkcXwEYoWqV7t7A7X4IYyPGLjZ8dZnYZuZJj3fYqGxYXmq2PBSzf5vYQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110133; c=relaxed/simple;
	bh=3C0BLDCMq/D9BBVEP30AtDd9hbkCaDZVLQ9Sr7F0eX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX3MNh/0LqiA2Fi5XhrUiFVfrnxWzaq/CBW+R7mbbqXV/Iwpy1BQwd00RwDKl1MZPkoj+sNdcNbjPWYnaJ9++lCCoK+9MIEHM2MPfDzoBR6iYmHySjW1JR2SAY+5mW0+3sG2PT7APwuoWr6aZMbyrNd2Lfbkw2cxYGk9P+pwohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NoyCN0N+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NoyCN0N+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cqEGxe3A4TsyHhBhGyDAK0XOce4vcKHjalvNKtq5WmI=; b=NoyCN0N+4aKNGSBwHj1WkzxdfX
	e8IwxM7z/R0PS4tdmPGt0AAGZM25W2UZC3URznTkbT85LjxKEHEFY1pNh5npGZh5aRlWEFR2EKfKu
	NrSniIGwky4h7/Ehc3V+65JcPrClmuCmVvfqZV6/RRmPNAJ/qRZ7eSQ6pjmdSPnBIPz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsKpn-00Gad7-6I; Fri, 07 Aug 2026 15:42:03 +0200
Date: Fri, 7 Aug 2026 15:42:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: xuanqiang.luo@linux.dev
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v4 3/4] net: phy: dp83640: clear state after PTP
 registration failure
Message-ID: <625c75de-aa7d-492c-a4fe-6ea8a2d93a0e@lunn.ch>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <20260807070729.12545-4-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807070729.12545-4-xuanqiang.luo@linux.dev>

On Fri, Aug 07, 2026 at 03:07:28PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> dp83640_probe() publishes its per-PHY state through phydev before
> registering the PTP clock. If registration fails, the private data is
> freed while phydev->mii_ts and phydev->priv still point to it, and
> default_timestamp remains set.
> 
> Clear the published PHY state and reset the PTP clock pointer before
> freeing the private data.
> 
> Fixes: 4715f65ffa05 ("net: Introduce a new MII time stamping interface.")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
