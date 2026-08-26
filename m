Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CB3EC2F8;
	Wed, 26 Aug 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747021; cv=none; b=iwisO/iC2RoRBpbikJmC8sgWXj6Yjdkfwcd+6JB8dCIx3MQA89s/kL0Y2MvipSOXhyHFbH3BfdzQ/eImrGduOhymwh15CSKrrVk9eiSkFDhMZ9HfVfb9LvjUM3IKJa1aGCVMYnZQ7TEeuwocyXEjGVJejEdL6v2+lvVg/gvzdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747021; c=relaxed/simple;
	bh=BI2F+ypyKBbDK+wdPWjweJ4g71WNXZd3h9Yemxl5JCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5cwXiqatxFMhiPa3fnQzFxQMSAlP97K5gkc7V0ksW3fzj+Sg3Q6YKDZe9zCPuRHB0g7OwnaBzecd53WGx8YscYAWyidFhcYitka8pRNJrqUAs8Z9huDQfE3aCy/wHJzupmpaGIgbqNdLSgg2JkWdFAlslAxmKy72TZLkTo3+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wy2OI3f9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wy2OI3f9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3mBB7aH1lVR/G+Fuyhaip6TpSpRtuDD8azXWh1ZBcjQ=; b=Wy2OI3f9X2Dp162KGlQw2njmql
	fDI/iKmIDEDY5kw+MfFu2hbk+WhGReuIufB4uFrIFgQibiFxa9BCyA18PK9b3SXhw22POGJgk2HcL
	nNquSSJg1dezu8mQg/pLw2+kq1Ez06Th8P5HGMWlXVeG3NGa2YAGmui9OykxEaDg0xk0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzCf7-001WB4-3T; Wed, 26 Aug 2026 14:23:25 +0200
Date: Wed, 26 Aug 2026 14:23:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Richard Patel <ripatel@wii.dev>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steve Douthit <stephend@silicom-usa.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ixgbe: fix MDIO bus leak when rejecting SFP module
Message-ID: <87e4aa92-4687-4fbf-b632-9493932c349f@lunn.ch>
References: <20260826042945.2344686-1-ripatel@wii.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826042945.2344686-1-ripatel@wii.dev>

On Wed, Aug 26, 2026 at 04:29:45AM +0000, Richard Patel wrote:
> Plugging in an unsupported SFP module caused ixgbe NICs to get
> wedged permanently.
> 
> ixgbe unregisters the netdev when rejecting an SFP transceiver as
> unsupported.
> 
>   ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+ module type was detected.
>   ixgbe 0000:3b:00.0: Reload the driver after installing a supported module.
>   ixgbe 0000:3b:00.0: removed PHC on enp59s0
> 
> This code path failed to unregister an MDIO bus owned by that
> netdev, so when unregister_netdev() tries to tear it down
> (via device_del() -> devres_release_all() -> mdiobus_free()),
> it trips over the leaked registration.

Maybe look at using devm_mdiobus_register()?

      Andrew
