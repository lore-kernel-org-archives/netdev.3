Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972328;
	b=bMpTaQRR4B0jBZCbEtiU2nW5kTjbXKbc210+GcMzy9JH/UU4my7obF3AisPTcvhAGAgw
	 4gH3l0trddEA17WCu6n+Z6KjGA34eTd0IPH/O5zsglUJPO8hOecp7T3VkWtjyxHoD2nE8
	 M2+gH2+K5BRFvx2UgaG6uYmFMsVJsTLXv2HmPmn0Ekd7hgP9FbwKHC4G8Z9NuZtaRT105
	 yDo3ZR0dzuz6x9n7N3Kkq42R3yISajegIMKt5AWOoxXKEZ7+GJzBCkE6bZDiQHpgqn1RY
	 3Ku/iBX020CEHUyyrE/Jo8SZ0CBEWCCYLkytVXADdOtq5j0hCDY6C+6PNaysJlNDTtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972328;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=yYW2PSaeeOYaOaP10pZyE3iM+rRN0qk/qtsLIw/0pRQ=;
	b=FnV+g0gQOnTDeoFGaHWRhx6M6OKfFPosWWT5+ZLu4FsjC9RE8LaiKl4kxMTs8aTugn8W
	 7AQwPNTgSi2pE8kDnal2iWDaqGhPpe+KXhm60IcHTvQY8GTU/Oofj6R1mq3gkLp2yul7f
	 DzV5pYYCD9j68t/Sq78elG3bSrSdlapoPjxECEjw6SfusXnP0rmz/wWvrjNMLZm+FptxH
	 u8D3yGq/8bdA9NlcQDHXGgErPVFjZJ0LByMkTpqxOM4xGvjQup6El/FivUfnLzvmSvwTF
	 GtpehJqCL/TbFEf1ztmSnIW1R1ioqgM4LvdbdNhpyspXIb8+oBUlknLSv32auVIueHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=IiQZmQbS;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28E606A326;
	Fri,  6 Nov 2026 13:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F28E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=IiQZmQbS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yYW2PSaeeOYaOaP10pZyE3iM+rRN0qk/qtsLIw/0pRQ=; b=IiQZmQbSiNataEC2O53kuECmZ1
	mW592GsHSYZXP0eU2CmMaABFhhe1oibOG2t7IzwhD2jNONWQLRf9jT2vTv/b+TqcouvggWZON0EiS
	Rvgam6teVku6UVrvA4Jkt9DJqeOFLQjJilt2AmjMHbXr71kHMPqr15k1cuqmxlF2fXKc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPK9N-00EmAO-G0; Fri, 06 Nov 2026 14:38:37 +0100
Date: Fri, 6 Nov 2026 14:38:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: Re: [PATCH net-next v8 1/2] net: dsa: qca8k: let regmap serialize
 register access
Message-ID: <6aca850a-ef67-4451-aaf2-977be884d1b0@lunn.ch>
References: <20261104120130.48455-1-yongzhao.derek@gmail.com>
 <20261104120130.48455-2-yongzhao.derek@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104120130.48455-2-yongzhao.derek@gmail.com>

On Wed, Nov 04, 2026 at 01:01:28PM +0100, Yongzhao Chen wrote:
> From: Stanislaw Pal <kuncy7@gmail.com>
> 
> The regmap is created with .disable_locking, on the ground that the
> qca8k read and write callbacks do their own locking. They only lock the
> bus transaction, though. Since the driver moved to the regmap
> read/write API, regmap formats the register and parses the value in the
> map's shared work_buf, outside of the callbacks, so two concurrent
> users can swap or corrupt each other's register and value.
> 
> Most register access runs under rtnl, but not all of it: phylink's
> resolve work (mac_link_up/down) and the LED class callbacks do not, so
> a link change can race with an ethtool or LED access and write the
> wrong switch register or read back the wrong value.

Do any of these operations which don't take RTNL do an open coded
read/modify/write? Does the regmap read/modify/write operations hold
the regmap mutex over the entire operation?

	Andrew
