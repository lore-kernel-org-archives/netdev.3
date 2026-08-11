Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6771A6800;
	Tue, 11 Aug 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453317; cv=none; b=ujk8tFx74awEnBhnGBiPKcT1aljKGCEHXQNRdfq2l15Z3vEmqEcCiFKZ9YT9MK68ZPSvW0ANwYMI7wi5qbhZFiBz4hbcNPO4ko7PqeARXo7SrVZTwVf2bsTK6dhYHmmsmYXxXgmLDC2sF68S7aXKa8QlZSraFWts2Rqi9o4BMT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453317; c=relaxed/simple;
	bh=kpsi8X1cNLWM7qX4mAchoKmutuiJ4Re7uQmaGjl/7hE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lqtF5TNZaK5xOM2spJQRcIzJZvkdxxnfY1muu8yA0PwL6U/DNOF8ZArsDE/dRLYkcXr+hNdUr52j21vO8Slf2Yon37YmWfI5KA/gJaVas8vhiVkpy1dj86Y7KAIq6XRGw/XOU+6f09XUaRDj9oThcvwb1at+ipWJCtWQzyJUCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Fa0rr8dj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQqSd3Q5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Fa0rr8dj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQqSd3Q5"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AFF214000A2;
	Tue, 11 Aug 2026 09:01:54 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 11 Aug 2026 09:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786453313;
	 x=1786539713; bh=wzRRmYsLSDB0GpJkilO/Cjnjr5xUTbHjpSjaKE5qs5g=; b=
	Fa0rr8dj1qqReSId+0TiRuECa8O39k0TIVhJgArQnd6S+TVjftoFS+ei0w3zVBy/
	Q1dvlx9P22MfYrKM2SzGhlquS6rdBUvtE6pHCckCddU3BjEYSj+zfHS232UedAGC
	L2cK8ceSTrmeCP19Wz5KSGGCy/f4fAWfAvRqbvv88l3+cFd7b1rBtNNt/Lgs9lNK
	uO0ckMDb8AlbZ4XrYYlQ0eWldfLJ6V2Sk/0vykQFFWfNj+QV4/5NC45I55WlytLB
	lHiD9P6/hdm+Dgc46wJuI1D7SGLHTHPwCJxTKT9zT53ql/sRjutmKqAwa/5afNl4
	y3wKZGS5zkOtd7OZ4DiwMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786453313; x=
	1786539713; bh=wzRRmYsLSDB0GpJkilO/Cjnjr5xUTbHjpSjaKE5qs5g=; b=h
	QqSd3Q5anvuI1KCByQ9ntNCW58D2+aAep5RYuUeJVRUHGsPMFLNFURvBrZ86RGT8
	NcmuroeToQSve1Bl3ZRV3RKxnnvXAF2S6BpagTfqfMxAMiSh5bITLRvwB80TqyV4
	odIC2qayFDWpAphiaGiq5H1P6nS+BYnLoxQQjSxY12tKKR75n5eD7o+iNxgiF35q
	TVsC3VvUywGrYJdeFyXbzuf9eyjUz9rtXfWf5cGAPkiD22EGhUnCwZMKidjTMVOY
	km16imYInjqqc5OPWWUMW89jLwQxwlGLiYQu8i+Ar7z+MFlDD8K/NpkIGOtESCGt
	bgjGerOrMi8AG7pLna1MA==
X-ME-Sender: <xms:Ox17aqrAg2Dp0ioiqiS4nmuAN6Y2ajWVibHg6SKzbk79DUKeztWwjw>
    <xme:Ox17ajeYeFtTD0ADe6Brx1itNckBMOnVZ36tCPvFONBXIFvjdmrdZVsa3KC0Djq22
    8pkjR5epQOeMWK0AswBtoDcEOwpYXqLimObEeC_88M17gmciZsD_JZU>
X-ME-Proxy-Cause: dmFkZTFGAoW15MFXWCvi0/XQR8FtAOBms1kLy4R7VMRBN6rKkcGmJEKGxAcCl1mfyxiKaT
    pqtmX8RyWGwk5rzwJlTD0cgUpy9fI2auq14+IXvFaMoK6aNlVlck5daFAIopjAEil8E7oL
    rH4pxsQcVDgFbRt5r+ZZv2d+oylKssaJBNbHak6Lb/4GA5MguX7HLaWS2ZzmWVDNxwZW7L
    JxGlcEZSmpliPJ4tjj/JgQo7MQ/m+LsvZiOMfOfRW6Kdz09oHBhoG78j9x/8+pOri1I2Js
    Prc+imKhk6eXN/DbnAIndY0o83L7Ie54HXRsMyRaEkEdGsJIzw+JIyOFEBtzabX71t34eb
    RBWSAkdX7dtO6FmZNBIYTHWaxT/weag4tYlw2exdJR6utsbvetj92x1r1+Fo3v2gw4wMJE
    h/cGg53GsJdqTAv7UCoHGY27SMoKuXiOAllBlIMGuYpfKrdu6CwyinXwL1JW7WaikeiQ44
    1M6Oy0i0rV9nDpgHOwZg4l+QJ2ZJ900e80Bbrdu+slM8etOs12PNzGByIh2yDxo1TXoCh3
    3WGa5nnBdpxcAXw4BOFy6rD3GQRESNBhhbUrfZU7oQX0HDlodc08Lq4sTBOU/RyRzmOjz5
    msmbNmbHBDJrjgRfz022Fr6CsEPCMZa+rrZvzy2FI1e3tlFaUfLA0MxJ+qbQ
X-ME-Proxy: <xmx:Ph17atncwZV6tYgDys2Q21mWpLJkt1ivQih7iHWzIq_Hiz47NAb5kA>
    <xmx:Ph17auBFguZlEtiVr4hYVjzJN6kNsgXfRoDHH6yRlaNtN65w_QpgOA>
    <xmx:Ph17anCIKfrni3M9AOrG5JYjn3J1Aa35Ym9fy29XJmReI9zC-6Yd1w>
    <xmx:Ph17atH2oVmea99o-caJ3CeKUklMLHWe73uiy5e3oKrAp5JRF1STRQ>
    <xmx:QR17auszH6OZdoyGwYMewRxRgyOlS68bp95bmKYC1coztPDIfHnfZYkH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 51C3A32A006C; Tue, 11 Aug 2026 09:01:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZ1hQAj1mJfJ
Date: Tue, 11 Aug 2026 15:01:26 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Message-Id: <9bf826bf-cef8-434c-8fe4-e8724c90a37b@app.fastmail.com>
In-Reply-To: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
Subject: Re: [PATCH net-next v4 0/3] w5100: restore GPIO-based link detection
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, at 14:34, Arthur Cr=C3=A9pin Leblond wrote:
>
> In the previous version of the w5100 driver, the LINKLED pin could be
> wired to a GPIO to detect the link status changes via an interrupt.
> This only works on w5500 as it is the only one documenting its LINKLED
> pin to hold the link status (on w5100 the LINKLED pin is changing with
> RX/TX activity).
>
> This series of patches is bringing back the link status detection on
> w5500 using the Link Status bit of the PHY Configuration Register.
> Additionally, the LINKLED pin can also be wired to detect link status
> changes and read the register in the interrupt handler.
>
> Arthur Cr=C3=A9pin Leblond
>
> Signed-off-by: Arthur Cr=C3=A9pin Leblond <arthur@marmottus.net>
> ---
> Changes in v4:
> - Use directly an interrupt line instead of gpio -> irq
> - Update interrupts in DT bindings
> - Address sashiko reviews
>  - drop devm_ on request_threaded_irq to avoid use after free
>  - disable/enable the link_irq in the suspend/resume
>  - only call netif_carrier_on|off if the link interrupt is present
> - Link to v3:=20
> https://patch.msgid.link/20260806-wiznet-link-gpio-v3-0-532d4a143805@m=
armottus.net

Hi Arthur,

This version looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Krzystof said that he preferred these to be described as GPIOs
instead, but I think there were some other open questions with
your previous version. If you can come up with a version that
Krzystof likes better, I'm fine with that as well.

To me, the main benefit here is that describing it as a
interrupt instead of gpio means it can be connected to an
interrupt pin of a chip that is not also a gpio pin, but
this is another rare corner case, and the code will already
work just fine without the optional interrupt if someone
has a system with interrupt pins that are not also gpios.

      Arnd
