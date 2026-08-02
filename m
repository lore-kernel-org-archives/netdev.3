Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E32F8BEE;
	Sun,  2 Aug 2026 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706098; cv=none; b=fNPQONPK1ESz3wrx1/GWRM3sfV/DxiovjQhE96ADsfT4EN3XEvjSzcHodnuonIcKIjWiSsP/6GujCFDmnhyBpiaxWtdPilI1AVl+xxD3fPZHg8NA1VKJpssYTWpPZyyb6YS73DUOj0NAvgUBDmIvEMz4vsvW8OiUFzCMRuyxV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706098; c=relaxed/simple;
	bh=z2VDpQcwFi9hPK+FFZZ1eM3+7JyORAcnUDFDA/wZJZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekI8B/Blqv05YYHBlCpeWK0xUJSL2bA34R9gqtI3NoSE4Mp1/nGjjR02rtTRBVEcCgUtKM9omy1hgzhFw1Msc5hHriNTcbPlpzvTmuoPRy1CbLGypRdYTmzfFVfjDzrCJjz/kj6Q9SInnpfiwEz68SlBfL85rBMjr3/Atmt4Qvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DsA6YvzT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DsA6YvzT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V42kT6EXoSa+IeJC0yIO8EqvkOfMbnUtK2ASHDEmaO8=; b=DsA6YvzT5998KFBP9ietcUQR63
	CUsFvpjsrtbT1l1kD9QNUPD2KDP08z6/lMXq16wYwInsz2Mk5UPsnvnLU4nCcZJMBaObHzj/PlVei
	FIKsZ0BA14y54ba3LKrE5kor7azv8juk7bohXeHVKsBl7/TfNBc0CvK51lJw9AL6V/BI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqdj6-00FcG5-1B; Sun, 02 Aug 2026 23:28:08 +0200
Date: Sun, 2 Aug 2026 23:28:08 +0200
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
Subject: Re: [PATCH net-next v5 04/13] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <b6c5b109-a999-43ac-b4f1-14007e7b3387@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-4-dcb9fea4acd4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-ax88179a-v5-4-dcb9fea4acd4@birger-koblitz.de>

This is more of a nitpick, given how much work you have already done
on this driver. I think designated initializer syntax could make this
more readable:

num ax_bulk_in_speeds {
	BULK_IN_SPEED_1G_SS = 0,
	BULK_IN_SPEED_1G_HS   = 1,
	BULK_IN_SPEED_100_FULL_SS = 2,
	BULK_IN_SPEED_100_HALF_SS = 3,
 ...
};


> +static const struct ax_bulkin_settings AX88179A_BULKIN_SIZE[] = {
 [BULK_IN_SPEED_1G_SS] = {5, 0x7B, 0x00, 0x17, 0x0F},
 [BULK_IN_SPEED_1G_HS] = {5, 0xC0, 0x02, 0x06, 0x0F},

> +static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	const struct ax_bulkin_settings *bulkin_data;
> +	int index = 0;
> +
> +	switch (ax179_data->speed) {
> +	case ETHER_LINK_2500:	/* AX88279 only */
> +		index = BULK_IN_SPEED_2500;
> +		break;
> +
> +	case ETHER_LINK_1000:	/* AX88279 & AX88178A */
> +		if (ax179_data->chip_version == AX_VERSION_AX88279) {
> +			if (link_sts & AX_USB_SS)
> +				index = BULK_IN_SPEED_1G_SS;
> +			else if (link_sts & AX_USB_HS)
> +				index = BULK_IN_SPEED_HS;

This removes the 1, 2, 3, etc making the relationship more obvious.

     Andrew
