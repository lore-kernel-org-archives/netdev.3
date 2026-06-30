Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F231E858;
	Tue, 30 Jun 2026 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858356; cv=none; b=Xv4Wz06OAJ6zqMB3ErJTXBrickUHu0raUyB431nYJ5Ht9i+VA2scPQs6l76s5GaR13m363fkLvRdzFPs90VvElI3BC/7HW1x6GGkIjNd4ZBg+Eh++zgt9/GOx89UC/27OiToHQ/JO0mRJsgXY0TqIcRaMSE+HEdmmM9wkl85hIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858356; c=relaxed/simple;
	bh=UJt3xwA9OUv4ytsi5gs6gUeLW/uZReGQZ4GZ32yz594=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oromQtQROpNw3EPzArdcOZCx5BMfnOK+YIme6xlxc8aeb4TrltrwnqbRr9/PEqsR/f+MYVP0tEZgnoB6hmjwhPHhkfHVrdbGOhwEeFt8W1orwl2hfHQy/RA8V8e402pagC3FUWt9YpIeMIiQdrJJaJA9qaVBOQA4ZM1PUxoDeaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aEquCaiF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aEquCaiF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z3bXcgl09qRXn2GfBaT6Bogy4+hSBh+lv7mb+1qzP9o=; b=aEquCaiFDaxhq+XbRwXbXA5oSr
	fbTpT+hhwB8PHbmjF975lvoA2oBmrCXO72hP5KyQbtR6JqHWinzqWC4xuNWuhlz1n5M0X0dZC/HO2
	h0LJd7EN7SRSbcOo+7RajVeyFzD3ry5MX0tOtbEvFV0WdqEnTpmhDr/FqeaB12x8kpr8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wegto-00A3LE-Q3; Wed, 01 Jul 2026 00:25:48 +0200
Date: Wed, 1 Jul 2026 00:25:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: dsa: motorcomm: Add LED support
Message-ID: <a1a943de-b184-408b-86a9-196490a7ff8c@lunn.ch>
References: <20260629183137.541341-1-mmyangfl@gmail.com>
 <20260629183137.541341-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629183137.541341-5-mmyangfl@gmail.com>

> +	duty_req = YT921X_LED_DUTY(on > off ? off : on, cycle_req);
> +	for (unsigned int i = ARRAY_SIZE(dutys) - 1;; i--)
> +		if (i <= 0 || duty_req >= (dutys[i - 1] + dutys[i]) / 2) {
> +			duty = dutys[i];
> +			break;
> +		}

The ;; got the looking at this, since it is unusual.

i is an unsigned int, so it can never be < 0. The test should be just
i == 0.

> +static int
> +yt921x_led_blink_set(struct yt921x_priv *priv, int port, int group,
> +		     unsigned long *onp, unsigned long *offp)
> +{
> +	struct yt921x_port *pp = priv->ports[port];
> +	struct yt921x_led *led;
> +	unsigned short cycle;
> +	unsigned short duty;
> +	bool change_cycle;
> +	bool change_duty;
> +	bool use_cycle;
> +	u32 ctrl;
> +	u32 mask;
> +	u32 val;
> +	int res;
> +
> +	if (!pp)
> +		return -ENODEV;

I really do dislike all the tests.

Are LEDs created if pp is NULL?

Please don't use defensive programming, understand the logic of the
code and decide if this can happen. If it can, then yes, have the
test. If however yt921x_leds_setup() has this test, and will never
create and register LEDs with the LED code if pp is NULL, you don't
need any of these tests. Please look at every instance of such tests
and really consider, can it happen?

	Andrew
