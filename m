Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438630569C;
	Fri, 15 May 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862941; cv=none; b=tWxkwMIb0Et9IzbFzLIs609rGNVPVWw09j2SE+MkvDRWSrdrUDAegum1lKyujjcfOoR/zM0MexuZz3gNJy4seEGIJPbSwSJHT1cmZ66IeP8d2Opg8bC+GC0qKHpwnOtU27UQl3ZIIhY3oAhRInOAmMxAL2snLMLYN0xAgd0HoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862941; c=relaxed/simple;
	bh=z0TToX7NuQQDS0WTa8JQyVq2hvOXUS0Rv14QeiIfwpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfjbXayLYZFt5zNadrcT0onZS+rxoQXKYJy9lBnpv5ITzNf1hTAUCViB05H1AKkWU47tr4i3QEP4wULOpKDIy2GQFGKRx7dZo4SiiQ0xd8103fWxs2QhB8ak1T1L/qRc25WqWoRlVUJmDE/yMNFMxu9YdkXq4RUn2QbGJbyz1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p1KbMoJq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p1KbMoJq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vQ2HtcE0Pc693HHxm8VI2FjMQ3HxiNYJHgGdi2s7BNk=; b=p1KbMoJqhbrMZ0jTRbmLHH8Kkq
	n8zp9GwQTEEpw0BaGTpAbq/wbKX+fBqZoMXgu04TO8fTxM873FsXzgnYBYsoUmg5HlhrxOAEstTML
	o94rIXlBx+O1ryM5sVGEiV8Z/qbQPINka8H2iD4shfDPB0EnnZ29Zn+dABiLXa6IPoK8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNvVR-0035Zy-FE; Fri, 15 May 2026 18:35:21 +0200
Date: Fri, 15 May 2026 18:35:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net: ethernet: oa_tc6: Interrupt is active low,
 level triggered.
Message-ID: <3dd191d1-118a-4280-8da5-fe836ab1ed62@lunn.ch>
References: <CY8PR02MB9249D2392242AF27988B9C0583042@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249D2392242AF27988B9C0583042@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 15, 2026 at 04:13:48PM +0000, Selvamani Rajagopal wrote:
> According to OPEN Alliance 10BASET1x MAC-PHY Serial Interface
> specification, interrupt is active low, level triggered.
> 
> Fixes: 2c6ce5354453 ("net: ethernet: oa_tc6: implement mac-phy interrupt")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
