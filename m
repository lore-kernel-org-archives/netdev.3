Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACB26B2CE;
	Wed,  3 Jun 2026 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492520; cv=none; b=c+SkGOOhpbpg573ah1nOwzWQ7CDaFGcC+F8peF83RwOLu8Wo7y+s6RWFkYw0GnLeziatSZ3mR1YIak4qiRUcoOf2ILmsjq8ZuooLXSebqiX7tyUITRGg7Q2kVFvbuJFux8sodWTv3X5JUfFNWIoJSjqxDs3ehzL8LgLZJS8iCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492520; c=relaxed/simple;
	bh=lCQJ9mw1FPDJXKsBwdxiyAriVn0m/V3Ql3yqrophdMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3BpwE6aJdEaKZ62LaRQX//SwyugcWT3UpdiuJNzQxxFMXsR56606AdyR2mQ1xYUNxZ7rj9YE/TytDeqBIWYFMkZyeIo/p5en50mlJCOx4hydsH8M65e9OYkTlZOS7kwvhCR5ZZOjlIEbyAX+uwUTiupqaRxoag+n59X8Zy2hcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cnSUHns3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cnSUHns3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IxX4ef1/ZRvhfLr6R6N2rF9/YUBOj2G4OZm6eMT1GK8=; b=cnSUHns3/yGsojxQQwefiHpNW/
	kmOw5JuY7xUVfc9lyng5RnSQPvOlCJ9nSc+g7rPMTW9RKetFKxJyjOnDGShx16MCs5oQ8/w3PqLC3
	nIgRkH/oJYBn0JefTgmd/4a7AGGhiSywZu49xRxZJ+8I8jvofoYT35Ggns8hi2so3pgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUlR1-005slJ-4Q; Wed, 03 Jun 2026 15:15:03 +0200
Date: Wed, 3 Jun 2026 15:15:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
Message-ID: <bf3c29cb-334c-4d2c-b9d7-61bf04779fe2@lunn.ch>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
 <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
 <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
 <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
 <7c35fa5bb5f24afdb42e2d45a4e559c3@realsil.com.cn>
 <bac05b34-9c16-4c18-9e6e-a8ccee86f0d3@bootlin.com>
 <c088522c19624f11beb179a71a11d9c1@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c088522c19624f11beb179a71a11d9c1@realsil.com.cn>

> You are exactly right. The PHY doesn't actually exist; what we have
> is an internal PCS.

...

> I actually tried to migrate it to
> phylink before. However, the current driver codebase is deeply
> coupled with tp->phydev in many places. Decoupling it may introduce
> bugs for numerous existing devices. Therefore, I want to try to
> expose the internal PCS as a dummy PHY device.

Architecturally, you are going down a dead end. You really should be
using phylink.

I don't see anything too scary with tp->phydev in the driver. Are
there parts you think are going to be a problem with phylink?

      Andrew
