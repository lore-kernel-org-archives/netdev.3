Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCC2475E3;
	Thu,  7 May 2026 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189792; cv=none; b=PqzCsdPPL160VaE3K63rp6Ivfv2hb2fa8RRmIt/EjrMhdNKp66S8zueh+06p5X/+r4pevmJHL9Zfkydqm+4HnZGYsmBspg8TgiW1kbwgz+NIvBW9mNEtlBm/Fgg7MpDv2cQeVwx9kSGLZh6quWQAuEm7uVoYnMoMYq7WdPJJDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189792; c=relaxed/simple;
	bh=p3wVzz5VNqgwveHdVU9d5bK9qwu/4koa6H+tJj2UyaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijC1OWfqc68UbWTwH/vVnP3zs3fTeCQEH4dvvq17fTcdzgZmV19ZL78WaNc5CpDwfrrXJpgGf6nmKVuKvdnOo0vO/u0A1+IOacD0srljfuO5DW8h/0ri5hgObRgA+bF3grvdrRE9sDL3RU5kiDBRxpk/178tdF+AdklL2s6z4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ax2WpD9O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ax2WpD9O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=EGD8JspjmSP80eMiWCiz+GZtznF5vZ7uaGhPmePdXwA=; b=ax
	2WpD9Ob8DtriFO3GDwHPYC3Ncwa+gpynnAQ+4hmtkSIpOyUzG5g0UVfxxXCg9p6MguhSVilkZCaTj
	aW/gry1sjeMoGSCmIinzbRZPPgvV6wv9Iw7VyXF1xpz8v3y72HK7LaKta313siWMhGgP9d3EKuySO
	IwLHdeLowl0KnWo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wL6O5-001s1n-AV; Thu, 07 May 2026 23:36:05 +0200
Date: Thu, 7 May 2026 23:36:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: phy: air_phy_lib: Factorize
 BuckPBus register accessors
Message-ID: <d7580b92-f165-4135-85b9-ec89a2568949@lunn.ch>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
 <20260326-add-airoha-an8801-support-v2-3-1a42d6b6050f@collabora.com>
 <3bd7803d-4c4a-4f61-9434-a6bf25627b58@lunn.ch>
 <9f569ba00b959b701a7a51bcd7347c1a108a15ee.camel@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f569ba00b959b701a7a51bcd7347c1a108a15ee.camel@collabora.com>

On Thu, May 07, 2026 at 02:11:54PM +0200, Louis-Alexis Eyraud wrote:
> Hi Andrew,
> 
> On Thu, 2026-03-26 at 13:30 +0100, Andrew Lunn wrote:
> > > @@ -480,8 +287,8 @@ static int en8811h_wait_mcu_ready(struct
> > > phy_device *phydev)
> > >  {
> > >  	int ret, reg_value;
> > >  
> > > -	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> > > -				     EN8811H_FW_CTRL_1_FINISH);
> > > +	ret = air_phy_buckpbus_reg_write(phydev,
> > > EN8811H_FW_CTRL_1,
> > > +					
> > > EN8811H_FW_CTRL_1_FINISH);
> > 
> > Is a rename required? Is the namespace air_buckpbus_ used somewhere
> > else?
> > 
> > 	Andrew
> Sorry for the delay.
> 
> The air_buckpbus_ namespace is only used in the air_en8811h driver.
> It seemed better to me that in the new air_phy_lib, all functions (the
> buckpbus accessors and air_phy_read/write_page functions) started with
> the same prefix. That is the reason I renamed them, even if not
> required.
> 
> As an alternative, to avoid renaming those buckpbus function calls on
> air_en8811h driver and reduce this patch changes, I can add macros at
> the beginning of the file such as:
> ```
> #define air_buckpbus_reg_write(_phydev, _pbus_address, _pbus_data) \
> 	air_phy_buckpbus_reg_write(_phydev, _pbus_address, _pbus_data)

No don't do this.

If you want to rename them, rename them. But do it in a patch which
only contains a rename. That is easier to review, and more obviously
correct.

	Andrew
