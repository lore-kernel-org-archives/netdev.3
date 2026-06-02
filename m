Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA203D3D03;
	Tue,  2 Jun 2026 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404824; cv=none; b=koJ9QFjHpR3E4uvKCLiGqPby6851cJnKSzVaP7P/oj+1dsiLLVTfaoS7VkBVJCqmcwl9Ta3jaQj/EwV2l9plGpKGHboJge5zs+5QG/HLjXslvkOUQmXXVsaw6dXws6q4RarKu5HMwIXxI/erjsB+g9Xi+P7SFF6mymIvKPqEO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404824; c=relaxed/simple;
	bh=0m6SrxuraIDKvaHvXGQNbIP8IROejOqjDQ/lYGmPRZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkFPPAbuOJVT0KhdrwDxa8qiHhC4YbD1YCVKCqzQmvDPke3G6IkrJtg7uzP9h4DLBBcOm6y5VWuJZ8rcp8103fVLvNvwVHK8xUeMpam4mq5NaOx+jXLbbBDpB4PwIqCpEFBVMDslxoKlfmSqPekn3UXpszSan4+uNSB69Vk6xkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0FTy80FR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0FTy80FR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kThE3ouLXybphO7ccO14wwrdXnBFXg8i8MI11Mw60e0=; b=0FTy80FR9k6ZVp5xDrbzm3oCD9
	BA859GfzaIFu8dJXqMk0D1sFOwQ6sUDEFVs7SFv78MCaDgWScH2mmkfI9Z69ssDIhfg04FASapNFB
	2wKGUHhlKD5dUGagBYP/a/9MfLM9fHn/fqmfTU66mTFdKHD1bn+Q61ppsFRQ//Z5zlco=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOcY-005gnf-FT; Tue, 02 Jun 2026 14:53:26 +0200
Date: Tue, 2 Jun 2026 14:53:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 2/3] net: motorcomm: phy: set drive strength in
 YT8531s RGMII
Message-ID: <1b7954b7-024c-4f83-8518-1c4bdf2a2d66@lunn.ch>
References: <20260529020530.16856-1-minda.chen@starfivetech.com>
 <20260529020530.16856-3-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529020530.16856-3-minda.chen@starfivetech.com>

On Fri, May 29, 2026 at 10:05:29AM +0800, Minda Chen wrote:
> Set RXD and RX CLK pin drive strength while in YT8531s connect
> with RGMII. Need to check 8531s PHY ID because 8521 and 8531s
> pin drive strength is different, 8521 can not call
> yt8531_set_ds().
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
