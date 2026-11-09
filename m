Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257501;
	b=WMmu5HTRGnuq0o5crnLzeLZlTq5HlRmxtxkD3Unpks5H21eUai0ijvAVSwn9p8z/3dCV
	 1KaEwJP2MonGE7ehv78v3dpkdCbq4Hv1sNCRM0pF+bZglTBy7R1kWgh43TkL8tTFsqx4F
	 CGL8wtkI/jeYCOUXahSmuU8qaeabyNef9IxZXWPJdD/8H/2sJ/xIrR7L9DHjchqeR/MQO
	 oDH50IEu8JyBUV4QbXuDZVlMS5jhqgPXCgkGrl0honX3vKZBZGKDtFR8h8mZz//sjkkiR
	 HLebCZXshHpxhNE3vmDtAax9v7m1BemXFI9QPfDvw40jYQ/Xb7okUGGgD8CXYOs0oFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257501;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=L4zXAJ3yW63ryN+gw48d3K33QL1qFIrjuPfLxKdzEno=;
	b=AwTnbNLj5BufHrXKI+Hpm/E4+73nnJQsL1EziAbtagMPF6WErqEiYfm8uKJKWibae1nD
	 Lgr51p5v1ZnV/feHNeHN85TqhoYQ1aFkANrHNw2nN60El/mDwWbQA1LBdVlPJfakf6snU
	 wjsh8LeRNVXw6GshlE3n+tlhNWXcarEnrZfgrMNWees/gzCZ5jT99TNfvzU/WumbljJ+a
	 jewVL+qTJoAsty7QbAyxF8teCAOo70C2jIWjlWEFsJlQcamrX4WXjUuiAFs6ijL1XsVLQ
	 f53GyMX2PGe0yg2ziCCkeoV6C835R2WccuUAYQcIADMQSV6yf19PQV86GVYuH9roAAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="cCMY3r/L";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA1606A330;
	Mon,  9 Nov 2026 20:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9BA1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cCMY3r/L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L4zXAJ3yW63ryN+gw48d3K33QL1qFIrjuPfLxKdzEno=; b=cCMY3r/Le/jeF9GaTJ6+A6bLat
	RUMBthYmwyWH0IZYfmRIS9BnzmriPlNHa1FWkbKhTMXgRWv4CP/HuzDZsf/ikGmNO4F+kp6OIv/K8
	6/sTVUB7uSCMMvCZhuGzb7sSDbCxLZ0iMwHg3kCXy32QSaEr6V5i6aBstuQTcBuTUROM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQWKh-00FL2i-Uo; Mon, 09 Nov 2026 21:51:15 +0100
Date: Mon, 9 Nov 2026 21:51:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/3] r8169: add PTP hardware clock support
 for RTL8127a
Message-ID: <e4b6394d-11b2-4244-85f2-5c4aa89ed463@lunn.ch>
References: <20261109023022.770-1-javen_xu@realsil.com.cn>
 <20261109023022.770-3-javen_xu@realsil.com.cn>
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
In-Reply-To: <20261109023022.770-3-javen_xu@realsil.com.cn>

On Mon, Nov 09, 2026 at 10:30:21AM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8127a has a PTP clock in its PHY, accessed through the PHY OCP
> interface. Register it as a PTP hardware clock supporting adjfine,
> adjtime, gettimex64 and settime64.

What PHY is this? Why is the PHY driver not exporting the clock, like
other PHY drivers do.

	Andrew
