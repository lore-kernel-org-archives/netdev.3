Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D952B1E8
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913781; cv=none; b=jTu3CUahPKzLGcLc6RWP7oFnh55t+rHYmH4RZE7GQQdGf4hpJLI7pDTGU8xEM7Ub2Vtev53GeYaqDOj01lB/FsioEov016MU339Temezzdy/FpNpDjT2WOTw3+yZM5OTXDiiv6rewGn0spz7PjWuhjOZLtYXMv32o0uDqGBad3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913781; c=relaxed/simple;
	bh=veC7dK0xPRrLFkaM681KuGvGBVLL+Vg781W7iTbhR2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cj14/qI1lu07OPbYtZFl+EoMxGo4Vs8sygKDWCSskgMTpOn1WLeBwTe3Li1ZDYek5rtP3lzn+GO2b6hV2iYxiwLHroZsLTLIuiqQ0oztjR+LhAEOQ0yspa8TGHMYNHA/dE1Gz3ZQ6Xi3g8G64IyTdu2JEJTwQy9D/t5wnVIeSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uml1W3fs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uml1W3fs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 40A921A121B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:49:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 160DB60362
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:49:36 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 94C1B11D717E5; Tue, 13 Oct 2026 19:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913775; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7JHn1c0jhTtw4x+nWKYYAbqqMhPie3zHHQoxJxD2lv0=;
	b=Uml1W3fsqlFcqHhgzrxMUJ0zeCy6I3KtmBog5eQwULtkiAjeDYpWog4S5lwkkMhH86SNUI
	w1dad9YGBah5TqrVRfZ8zXLuZd3MbriBIHEX8c6fhMwD4BkFQB7qpCOxqHAKhiPJn3DYtj
	mCIPWXIHlP47xdoZOpMH6MfeUf+hx0wb7nBwnzuS9IE/ARb2LXrt8NfybEjuALwj2Wygj3
	+EUB6he3fI6fWqckgKhGDb2jalUm8YeOp5/03Shxq9djTXMoeCABkq60qTxHUSsJLBEwqZ
	cX3qw34hXtZLmYKMiWQfPG1/5oK64kea9Rb1u7rrmm3B5tXbDtesqy5ey7RHfQ==
Authentication-Results: mail.galae.net;
	none
Message-ID: <4a283b8a-8019-4987-8c6c-23f9bebce858@bootlin.com>
Date: Wed, 7 Oct 2026 15:34:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 6/7] arm64: dts: amlogic: t7: add the ethernet
 controller
To: Andrew Lunn <andrew@lunn.ch>, Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-7-tanure@linux.com>
 <c1764303-9f18-4487-ba93-06173cd8a53f@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <c1764303-9f18-4487-ba93-06173cd8a53f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 94C1B11D717E5
X-Spamd-Result: default: False [2.40 / 30.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[148];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[41.19%];
	RCVD_COUNT_ZERO(0.00)[0];
	BCC(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,bootlin.com:mid,bootlin.com:url];
	FREEMAIL_CC(0.00)[amlogic.com,lunn.ch,davemloft.net,kernel.org,redhat.com,linaro.org,baylibre.com,googlemail.com,gmail.com,foss.st.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[]

On 10/7/26 15:12, Andrew Lunn wrote:

> 
> You should only need max-speed when the PHY is broken, says it can do
> more than it actually can do, or when a 1G PHY only has two of the
> four pairs connected to the outside world etc.

We even have a DT binding for that case :)

There's an example here :

https://elixir.bootlin.com/linux/v7.3-rc5/source/Documentation/devicetree/bindings/net/ethernet-phy.yaml#L348

and the binding is there :

https://elixir.bootlin.com/linux/v7.3-rc5/source/Documentation/devicetree/bindings/net/ethernet-connector.yaml

Maxime
