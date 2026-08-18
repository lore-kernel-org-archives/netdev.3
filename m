Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82911B4F09;
	Tue, 18 Aug 2026 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787015608; cv=none; b=YcOxslrIokstS89g6wDi4lHu8DswlASKAAIh+dlsXVlHYIS7ZECGFIkvdRkCPsEPRfom8VOw8GyJ74nANHjW9KfqodvaPQonL4Xbw9FRdNEAQN3iFK5FwnxN7CuuN2rysMh37REcoxzyAnyswIy1ZkgqnsPIY/r6oa8d2+RVDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787015608; c=relaxed/simple;
	bh=S7r126tTMSortfVsY9wLzhsbIhoFIxgUkPypK1W4vG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRVN956tCQmIQfLJr3T70crcaq1XtlpKHpnPWo2TztOD3R5nL5ZCqagggz0A4SHFyBnYpXtLzMHL1hGUoocBGur0ciq8XCljxqElkZycBN16BaR4Qqs7ANqdo3I/b8k70cnMO8m1ItgrEqlcz66Cr/zB99LvLC8E0WNvnyLqk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kaNsBypb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kaNsBypb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ld02Gx57rk3XqS2zPdWyorYFfty9u9jCLLVQauVBjlM=; b=kaNsBypbwqKbOMLJLB8QsB8zTw
	4USwFTjTn8CvQDW/Y0DMkAh44TEmPIZC8uywBo1LhElnClUBBZrWL5FtWIQSETQi9J5D1Mn9cZ3jy
	U5frvzaa6YhMpW29A01Q3z0jR4XhwEkGKIcxJworIdxM/lNJrDmvfIEnSou03hxeDrk8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww8OA-000P5n-1s; Tue, 18 Aug 2026 03:13:14 +0200
Date: Tue, 18 Aug 2026 03:13:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v11] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <ddcf52a2-fba3-442e-bd82-106cf7f48ea2@lunn.ch>
References: <20260817110626.510277-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817110626.510277-1-kyle.switch@motor-comm.com>

> +	if (link) {
> +		phydev->link = 1;
> +		phydev->pause = !!(lpa & BIT(10));
> +		phydev->asym_pause = !!(lpa & BIT(11));

This is wrong.

Where do you see any other driver doing this?

phy_resolve_aneg_pause() will set phydev->pause and
phydev->asym_pause.

You should be trying to use genphy_read_status() to do most of the
work, and then mix in the 2.5G status information afterwards.

    Andrew
