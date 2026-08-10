Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E082FFFA4;
	Mon, 10 Aug 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384648; cv=none; b=AKlJ9YGtpzlSQnXDZy2tsB71+hiYNGbQxahZVggEBaxCXqwz8AOaux9J6EMp/E1YSyif8+g2TxC/aP4iw5vlI5cSBKPg80awbccNS82LUmGPz8WoeT3QV+m2jx26BVz0H367TK4ullzMVUix+ARNw5VrxgaeTFmReYv7hhVGDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384648; c=relaxed/simple;
	bh=MW4+WxcWsrUf86xPnHKpvBCUjLqwAdhixQa/DSm8Efg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ3X7GfkOLXSLvPKux7TYpCBYxIA5ZGueukA3WG0B2L605pOTW/oReefh23r6mTZrdSAFBOlEp3d5JX8/fmlB1Sow2kMM1Qrnlc2CjIuIyBJB50bs9ie0Rra0WM8itVRA3AeaOnNR+7P9XEetCuY98vtGdMjJOhIQqXZ1AYysT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NmFzVmim; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NmFzVmim"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sJGjyJAfrE29E39fw5p9eEIjpaHCubsz58nYmECUolI=; b=NmFzVmimdna6vCG42MyuFQ82H4
	SkxIOP9K6N5Le3hQ3I2oJHA6gPM2538b87rRWSkmMtOQkwkRo1T9UsCBw9PzLBGsmIK7/4c1HXRzl
	st5YBeQQcVb9lViTD2C5mPh6NgxjsWqkjkcZKwU6R/GoI7HM0VC2Rk13U43/7wAkKBXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtUFN-00Gxot-Ae; Mon, 10 Aug 2026 19:57:13 +0200
Date: Mon, 10 Aug 2026 19:57:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Malathi <malathi.a2000@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Subject: Re: [PATCH net] e100: fix shift-out-of-bounds in e100_eeprom_load()
Message-ID: <0b5374f0-54ef-4730-8282-54cd9509dfee@lunn.ch>
References: <20260810063815.151326-1-malathi.a2000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810063815.151326-1-malathi.a2000@gmail.com>

On Mon, Aug 10, 2026 at 06:38:15AM +0000, Malathi wrote:
> e100_eeprom_load() and e100_eeprom_save() start with an address length
> of 8 and call e100_eeprom_read() to auto-detect the real EEPROM address
> length. e100_eeprom_read() adjusts the length with
> 
> 	*addr_len -= (i - 16);
> 
> based on when the EEPROM drives a dummy zero onto EEDO. A malfunctioning
> or emulated device that drives EEDO low too early makes (i - 16) exceed
> the current length, underflowing the u16 addr_len to a large value such
> as 65529.

So this is a theoretical issue which never happens, and bothers
nobody. This does not meet the requirements for stable. Please target
net-next and drop the Fixes tag.

	Andrew
