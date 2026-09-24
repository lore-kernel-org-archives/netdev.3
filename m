Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A03D47C8;
	Thu, 24 Sep 2026 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216508; cv=none; b=J4Xw68MqA80l/zpXucD+3i51TdCQ4c2kh7BTYbDgxkPnMTcRHczef+OPu6BVCyShNlRjwEA4dV6EzfHiv16hp9Z60SZrvYy4HBZIx6Uq00LpTJbvIE8Dvr8BjyxT+NlpE0lLSvUV/Vrbb5qegf7wdTLMQzqSA3SIpwr5vdXfJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216508; c=relaxed/simple;
	bh=2Q1eceJSc++9XlGm/BOIjSudrlIu+JF/7X8LZoD3s6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwQ56RiT6B7pA5sTefW1gdZnLkwXoMqMQQpQ+j2YV4wtpyzGDxVu8HhqV8MtMNYL6bVekVNgwW86K0ubwRpfF9Ysa3BIXxxAzHxRKkRC1M86XLxCEICtcxdcJzW3zLeEsg9nQwWLm3Y59sPUvwy9TtI0hTNBRahHV4drP4QJvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jwAAFeZg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jwAAFeZg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bc8dweOqGbv3HoYVjDw6CX5nD3uqw3AqaZmEoaappMA=; b=jwAAFeZg8QLc30JqgusUjaCr/V
	2Hx1jrDbeaM8xFPi1YzF8oKTJbOM/M+wuluq9FxzStAp9GJ2MioJfxqUcJKivdrh47Hufso0X5Cic
	ktqgMfwZM+VMXiCG2x323KoNE2+DI8Ltxjzccz7DmeF7YEgciEKxxzu+TaLD309n/Gi8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9Z5a-006udP-Kp; Thu, 24 Sep 2026 04:21:34 +0200
Date: Thu, 24 Sep 2026 04:21:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Marek Vasut <marex@nabladev.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [net-next,PATCH v1] enetc: Increase eMDIO MDC rate to 1.2 MHz
Message-ID: <e1f3dcac-af64-4eab-89c3-3b79c3940984@lunn.ch>
References: <20260924003132.580306-1-marex@nabladev.com>
 <b49d86a5-299b-41a8-b65f-51f1aac2a1e4@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49d86a5-299b-41a8-b65f-51f1aac2a1e4@linux.dev>

> If the property is absent, you should configure the standard 2.5MHz rate by
> default, instead of 1.2MHz.

Agreed. 802.3 says all devices on the bus should support 2.5Mhz. So i
see no real risk increasing it to whatever the hardware can do close,
but less than that.

    Andrew

---
pw-bot: cr

   
