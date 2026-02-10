Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057D2749C7;
	Tue, 10 Feb 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731267; cv=none; b=LUDfspWdbBcfC7q/ZAXu2PyWG30e8TJKNrNAuTJ70ao6g9mK6tVqCtK2CG3ISHFZB16y3qXEM8UK41i7PMpxkYRYsQQVogr2X5S/1YxoYqlRTeDPI/WUjg/EU8yx/uB6NyL0ECH7CQ0KhH0YOf0vKL9EXp3i4/YM4tb32mTzrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731267; c=relaxed/simple;
	bh=ZbxnQix/W5OgpnZ6DijlN3ozaBZtLkcEINRjuhnnhaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZtBJJswYE18+dPRJGflk3kGAKkVbimd0WK7aCkMh9cDDm46p/RzMUspfqLnGAu8z+71oWC3EgyBhDWQ/la9SyrdUDaTZgLkheDCDjsrlRsFCTIeDfYwjEY6qjuAOvfeYT2Wdz2wYWI6d/M4PsdbKSGC6VyUnLdZatFpGBBrZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pBBXQjiD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pBBXQjiD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3aMXt61cCmGa2ehLRDVodFqvqerK2mFVEC+9Y0ENreU=; b=pBBXQjiDSp8XUkmUWsXrzVNhO4
	YyGjl0VeHqFsu5YSUS7RaPglzRfhYYv8J9IYlCHrtRKDp4NSQjZT8GyBzw0H17e3sfkOvAeA5JhRQ
	b86UZvBBGKR4twpIGKNzl2D+X/ka/oC2UzafhENG2Pt5uVt8KJfIxYgYUm444nT4cO+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vpo5T-006q0x-On; Tue, 10 Feb 2026 14:47:31 +0100
Date: Tue, 10 Feb 2026 14:47:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] r8169: add support for RTL8125cp
Message-ID: <1a36b013-ae9b-4d51-8259-92728644ceab@lunn.ch>
References: <20260210071134.1530-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210071134.1530-1-javen_xu@realsil.com.cn>

On Tue, Feb 10, 2026 at 03:11:34PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply
> different and firmware for RTL8125cp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> ---
> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, 0x10,
> 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0x1001) on patch v1.
> 
> v3: Set phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003), bit 0
> means 'link speed 10m PLL OFF', bit 1 means 'ALDPS PLL OFF', bit 2 means
> 'ENABLE ALDPS', bit 12 means 'ALDPS XTAL OFF'.

If you know what these bits mean, why not add

#define RTL8125CP_LINK_SPEED_10M_PLL_OFF 	BIT(0)
#define RTL8125CP_ALDPS_PLL_OFF 		BIT(1)
etc.

    Andrew

---
pw-bot: cr
