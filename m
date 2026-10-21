Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603866;
	b=f37Sex1HmjJA9bcnjMqJlmaTG/Fei2bBaiWXbADka7WJeG/fVjv1g8WCLDqBHSk1aYkF
	 Mhod2S0ac8hSYQ1NKmi6VCmDa1KRJj+0sh5nwTi1lTGmhP4DzJJk/mxOdSBPEXoFVYa08
	 R6smoE5JSLt0kUlQY7AhG2epR3VPJa3s93oOCdk7B+JcUeqYJziVGAkRUNnuVMnUbsn3c
	 hB5AgAWWs6p1wR5yboe48BtH5RUyfEMsD9YhOruA1wUCYHZyzI6y3v/qj19cihthkZ3RK
	 HOHUiE9GkM65Yk6NyUCX7rfmmD5LdwtPk+jjGH5mRd2ZLNS58IlZ4VuF8dVDcZSy1eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603866;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=gagZ5ASkE8eLLuFwQfkpde+V6H0h46m+Thc6cakVrDA=;
	b=U8b2vWkGK7hUECfMy2P/cbMUYLcNiiiP2AHwghYl4Nym/eFtf2YEGmbXrbA2aHwTlG5X
	 UghP1BMkkBkOHSNWl6o4SNHgJe1PQKjwXKF3U+8hjDYKV0OF3KON9RNjkBE5l0gQ43km8
	 XLvc2/mBeHWGcR2NP3qlzVJ+duvnHgImbQnM8fUGNEIgRGQcf1+c0KoqGTboKSq8NvYmR
	 sug6WgTZdIVdI6zvCvev1ROp6sUzdEUKkQSfudB3xcX15IM1HVGy/Z7paCeR8ATsUcjJ7
	 j6m2c/JlR69WtO5PNLlyGTPCvkWgzBd/FQpDOJxZVO2ADVAajX2adBGbfJAMEuDxc2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=rsh59+Ht;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0B606A31B;
	Wed, 21 Oct 2026 17:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA0B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=rsh59+Ht
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gagZ5ASkE8eLLuFwQfkpde+V6H0h46m+Thc6cakVrDA=; b=rsh59+HtsZ/u2x/kS+d0ZpeTrD
	P+xxmXp1FxonFSyEhGcpb48qqJRzXGTS1xoy6wfNIYOJqyHcTIyUnvMZyXsXU2Rk0ooOJOUtxku0L
	INV5I7QWPEtnc3NIP9FNlkTHFzGRxrJuylFYOj4wr59yMAkbUoCspy1q7jOOEUPSB+FY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJa9S-00C8Ya-41; Wed, 21 Oct 2026 19:30:58 +0200
Date: Wed, 21 Oct 2026 19:30:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pufan Jin <cyan2254650260@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: phy: realtek: Add support for JLSemi
 JL2101 and JL2121 PHYs
Message-ID: <44fbfba4-edc1-453c-8e9c-8a6ddddb43ec@lunn.ch>
References: <20261021170248.49264-1-cyan2254650260@gmail.com>
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
In-Reply-To: <20261021170248.49264-1-cyan2254650260@gmail.com>

> +		PHY_ID_MATCH_MODEL(JLSEMI_JL21XX_PHYID),

Thanks for this change.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Since the merge window is open at the moment, patches will not be
accepted until it closes.

> +		.set_wol	= rtl8211f_set_wol,
> +		.get_wol	= rtl8211f_get_wol,

> +		.suspend	= rtl8211f_suspend,
> +		.resume		= rtl8211f_resume,

> +		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
> +		.led_hw_control_get = rtl8211f_led_hw_control_get,
> +		.led_hw_control_set = rtl8211f_led_hw_control_set,

Have you tested these features? You have seen one register is
different. There might be others.

   Andrew
