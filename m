Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E891A6835;
	Mon, 28 Sep 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599262; cv=none; b=O7ITAh+3sGqYpgcpKY/p2//nPqvsszlxmoiHD/Ds8dNga4xzKpx1qFFzD+8OpAclQJ8xEBZWbB464+04bptzmT9MzYlVfX8T7x48rZaXzkrAENE27nvSfUwJVn0x7PBZLf48YM/3r+wItJlPP5A0/WBxFHXmkWndCJsmdApJVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599262; c=relaxed/simple;
	bh=SP+yN0c8hoQ3LTJlfJEiOyn+JLXnmSLJbw/vTA1xMuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aATjdczqrhih6voiWGSOeofcQXTUmKLIGWDFmA0hHJGBSKm/4elBkNUJPs8SZHxaoQFnxRx1BmJ5MsM5jPSQc7FGMm36yibNcEf6BzdEYNbv4Uwjc7EOfGZXrmV0uk4yYJnf1jxCV2CQpKCx+LLG/gJfvAqo9+y7UO/NxI6qZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DHXxSOpM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DHXxSOpM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0mqZx8zLsL7pTXePuoXro0FVbrVzpZkNRCXvhtwEpE8=; b=DHXxSOpMA32CVnuAeEnpjtrXlQ
	q5iFbyZyDiTD6cZUFrBl7lT3ur+oApYIAcvql1c6YXKzOGXNTrOvOyYwXBps3dJ07qFj+fFSFpMSs
	1Ny7o5pvlO0DweqUXjgTrheLfLivRwA//jUc3XWwcBenQ8NXbgsggCWwY+6YdiOGJW3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBAf5-007hx6-5X; Mon, 28 Sep 2026 14:40:51 +0200
Date: Mon, 28 Sep 2026 14:40:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>,
	George Moussalem <george.moussalem@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337
 internal CPU PHYs for SmartSpeed
Message-ID: <c3c050f0-9a9a-4c98-8b0f-94320739dd29@lunn.ch>
References: <20260924234814.1734-1-yongzhao.derek@gmail.com>
 <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch>
 <20260925210153.8717-1-yongzhao.derek@gmail.com>
 <69b36e16-eece-4739-9208-96bd8e60943f@lunn.ch>
 <20260926082129.1632-1-yongzhao.derek@gmail.com>
 <426f9dcb-7473-48d5-a473-4435cc81312c@lunn.ch>
 <20260926215152.376-1-yongzhao.derek@gmail.com>
 <e18c66e9-7ba2-46c0-baf5-b4281a45755d@lunn.ch>
 <20260927153616.2317-1-yongzhao.derek@gmail.com>
 <20260928065758.5507-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928065758.5507-1-yongzhao.derek@gmail.com>

> So I will not add the workaround property. I will send the at803x
> change to net together with the DAC fix

Thanks for keeping at this. It is always better to understand why
something does not work, than try to work around it.

	  Andrew
