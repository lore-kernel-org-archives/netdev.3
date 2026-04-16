Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA23B7B61;
	Thu, 16 Apr 2026 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342348; cv=none; b=MCbHc4gkhgIydlXztVGP3VE0gMEgp9bTgJ7T0ljW1v6NtUgmw+ce1YvXwTXnI0q5PJuoUqX10kKoABHlF+6go+VfTAGC1eCzJNrvxxngwQet3A1+7AUqdtiSHIVT+ivak43hAL5pEivh9JjkKWqLoEFStYelI6rA6CfWH61Tiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342348; c=relaxed/simple;
	bh=o6GLJgpl3wqGe0icq+9A06A6j6sCyGCrvbXWN1isA8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0LTBdzXLoClh3efVUqd6+Zjac5oN592kwYT6scuGny8Qan5gYml2uuudxy/07+1aTBXwd52TCXAttKfr/EKvVUpnVYADHa9W0bLLoqHx5VFJT+czJH8RMH/qymFLTk/HuanFyXUsXMHvCwQnB8yIGbr76YPHKam7OP3oUzeJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TFn8laKe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TFn8laKe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a+ibqk4w3Rjdz3Ip4cq3cGoMzx070Y2r4edXmCZUgls=; b=TFn8laKeThTAjsxhp2wbxOCjGq
	WdvQRtXiBHPT6ODzvsfvmctpBVv3w6o9FlCwKZQItDfyXUFjwtc6oPJm5wywPw4+tEUXRa7Ex69KF
	8g0olUJOO1WO5OQTlLrN9GXR6Y1Pm9lOJizcKgnY8pzYJfnCyug0C94Voc+Of69U/UtQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDLml-00GHrL-3s; Thu, 16 Apr 2026 14:25:31 +0200
Date: Thu, 16 Apr 2026 14:25:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio LAWSON <lawson.fidelio@gmail.com>
Cc: Marek Vasut <marex@nabladev.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Message-ID: <03040421-89e7-4422-9fb5-0367a34323e4@lunn.ch>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
 <712cc46a-5ceb-4f0f-88bb-fa0a47002258@nabladev.com>
 <84e24758-2f59-44ca-a9b8-a46094578f83@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e24758-2f59-44ca-a9b8-a46094578f83@gmail.com>

> Yes, I think a reasonable compromise could be to expose three tunables:
> 
> - a boolean "short-cable" tunable, which applies the known good settings
>   (LPF 62 MHz BW, DSP EQ initial value 0).
> 
> - an integer LPF bandwidth tunable, for advanced use cases where further
>   tuning is needed;
> 
> - an integer DSP EQ initial value tunable, for the same advanced cases.
> 
> The boolean tunable would follow the KISS principle and cover the common
> scenario, while the more granular controls would remain optional.

How do the three interact? Do you need to first enable short-cable
before you set LPG bandwidth or DSP EQ? If it is not enabled, do you
get -EINVAL?

It seems like having extack would be useful to return informative
error messages to user space, however, that requires netlink
ethtool. And ETHTOOL_PHY_STUNABLE has not been added to netlink
ethtool yet :-(

	Andrew
