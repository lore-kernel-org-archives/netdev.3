Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA13815F7;
	Fri, 27 Mar 2026 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612108; cv=none; b=YgMYtyLvGbaONWzezeQDWPv2P0N+h8kWwdMHZ3JtrYlIHVVlJWpB9tAbtbtX3kP6KfyjRCX5oZRcVCDyN+Gx3Wvmyf0Y/PcIoRkmJ2ofkWRa+PM4KVYtttYvqniJnu6w+QSlqW5GRbMm6bgWCRDM3SbPS5kv1l9NwJ0/RuGajPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612108; c=relaxed/simple;
	bh=Kwtx7sJmgY9H63obq3O12tOE4ThiZXqrxNJqOnkc86c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc4bAQ1MMuEwtJ5bzgEzQYMNa5qWSy96RKDus2D+Kmb8EvdzT4GTJ/X9iUd6wP6U+RwWpLS9586Er4RMYTj1jZ3p4tgEM4+vdvv1sMKxd1gO4Unq/bXQXPlcAfAuzd1ET5J+dNt0oDJJrTY76ikaYdG+Y3oCSLK8zN2ISP5R3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tm/l+TU5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tm/l+TU5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DAhJnv5c2JC/LGwNBMq3wIdQ+V/gMdi8PLZ3o0VQ/OA=; b=tm/l+TU5AGFWW1JeSpiASjvKDl
	QnDu7nLiy8lHwChc+hkUWr97Fp0DuFTzkClvkKwutwvko/Wf9WlLHxEMmRB3sqLqc+9+fjc3BKcm7
	WrBnSEbnpw2pbOVMqo3GphX3Kzij4riEHmsmo6HC+dTE6ATWNLaGMhvQVTvoU1gnR+f8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w65fl-00DeIa-E1; Fri, 27 Mar 2026 12:48:17 +0100
Date: Fri, 27 Mar 2026 12:48:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: phy: mediatek: add phy driver for
 MT7628 built-in Fast Ethernet PHYs
Message-ID: <95814693-ed58-46ca-a680-8b93e4adee72@lunn.ch>
References: <20260326204413.3317584-1-joey@tinyisr.com>
 <20260326204413.3317584-3-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326204413.3317584-3-joey@tinyisr.com>

On Thu, Mar 26, 2026 at 10:44:11PM +0200, Joris Vaisvila wrote:
> The Fast Ethernet PHYs present in the MT7628 SoCs require an
> undocumented bit to be set before they can establish 100mbps links.
> 
> This commit adds the Kconfig option MEDIATEK_FE_SOC_PHY and the
> corresponding driver mtk-fe-soc.c.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
