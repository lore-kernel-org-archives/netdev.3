Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1822E3BCD02;
	Sun,  2 Aug 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684607; cv=none; b=Z4dpT6gXN9eMr70NpHzRgcoHgxW9pTLY9ndjRuE9zwUK4IaWuZnwaVgKV+mOX2tEeQmkF76cK6WeLPFLRbKzV/3PYK4B2ibl8kgmmh8Grx08SKFe0DVqztLjmDmifuIz8K6SAMfPPXuzOtROS19xTU4tknezKSjqnzG3wMGaSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684607; c=relaxed/simple;
	bh=dvHFRatbUIeVKsDtQyLEkqmOLEpi7Nd7Vo2JjxL2caA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeAFN9HYlnBkVpMdoG9qhVXH+qtJitdm85Jjk3ao8Dl+DkK5H9kemflHvZDBPFQXugrHSx1gYBqXOuNn6fc6TnsmNI+QXdqkumcQq672yb1/pjVlx9o5dS38kZfD/o1vWy+9fNXJ1AVyEkonv+Ka7jWb1d3EoUuW3tuyZ5CEFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XtcA6DEj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XtcA6DEj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WzrYo1lyFpWZKJi393dXtaNDvuSvD/nQjp1n6YJ/oyM=; b=XtcA6DEjSejnja+DVAb1LEHAvm
	vvCcqpNYinXPURR6vpe4jy0FKSE9elku840eB79+0JtWO3QzyiHCpDN8vTRnLGbn7zvGFJSAgdsc8
	OvVzoB3gxvvmydXBnSH026ZtSTivIQMYObSwug/btWHOD3iEr7v4MGvT/OFO87zzM6AI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqY8U-00FaZU-EU; Sun, 02 Aug 2026 17:29:58 +0200
Date: Sun, 2 Aug 2026 17:29:58 +0200
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
Subject: Re: [PATCH net-next v4 11/12] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Message-ID: <b1d5da3b-31c4-462e-8885-979e503794aa@lunn.ch>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-11-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ax88179a-v4-11-2cf1f71b1dd2@birger-koblitz.de>

On Fri, Jul 31, 2026 at 06:19:11PM +0200, Birger Koblitz wrote:
> The AX88179A/772D devices have 32 efuses with 20 bytes each,
> which can be randomly programmed. The AX88279 has 16K FLASH.
> 
> Provide ethtool read capability for these devices. However,
> no write access is provided.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
