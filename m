Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC0033B6D9;
	Sun,  2 Aug 2026 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706647; cv=none; b=JtERiesHPa9abWkHlhWCVK0VzDLa9hSUWIX1wA5GBnp/de6nhba/asOCOLoReRzM1cVN7jyphQ6B6yDKt7ZOkg8aRzqEx/3wv1Q4HO0j3742NgAv4efKvaORt5i9G4Uwm8Oxqn9y4+nvmc9xhE+KEkjMLuLh8mMVCaFR5dYB5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706647; c=relaxed/simple;
	bh=BqDlJuTMZdnv7fREt9gpoUuvvlTU+RyW7aP7bJ9ylxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUQsj0bTiXj5BWQJS/+7hXZCOIzu4OFAk3ZlBpjRMGsyg7YH1lhtUyRUvfc0x0dvHKTkZDdu4VACdd2PDlspcgfgg7bc6uOuh2+2F0Bfl+I6AwhAmcgK19lilQOvxKIvlv2xaz2VwWF91k4qKW1C8eif1LZpFYr8H5h951Z9tR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jSoLatMJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jSoLatMJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NJU+wufW2f63TDAc3kHCH7O7gXjUyaKzuTi8qNGAUvQ=; b=jSoLatMJlwGWuHv3Ybn845f4XO
	9DOnBtsmf0mdpQbOC7MtaIdnaBilE0/R4qL6CDuoGX/a1jE5Yma1Jeua8ZMQaF5vE/B4g0TBP1X0C
	Mr18KmBWT5XedEQ8vtIcV8rohOdFkZ+TsBqqfSa9iJmS/Ncx9p00Q88W4yihCF1+vElI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqdrz-00FcJP-AT; Sun, 02 Aug 2026 23:37:19 +0200
Date: Sun, 2 Aug 2026 23:37:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v5 07/13] ax88179_178a: Add VLAN offload support
 for AX88179A
Message-ID: <6cefc364-5ca7-4a47-92b7-3afec59912dc@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-7-dcb9fea4acd4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-ax88179a-v5-7-dcb9fea4acd4@birger-koblitz.de>

On Sun, Aug 02, 2026 at 06:32:05PM +0200, Birger Koblitz wrote:
> The AX88179A-based chips support VLAN offload. Add configuration
> support in netdev_ops. Features supported are:
> NETIF_F_HW_VLAN_CTAG_TX, NETIF_F_HW_VLAN_CTAG_RX
> and NETIF_F_HW_VLAN_CTAG_FILTER.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
