Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F8331EC0;
	Mon, 10 Aug 2026 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349537; cv=none; b=pv71N6VsTqstNEjzkLiK3DWfe1FWRTlL+3PHk9MD8FiP9ZbBKg8uRqJgucWjrKq/Jm+b2QbTxVqN/Uj4fGUoPgGIQJC5GpNTUxiZxWVhiZwDjc9pg68BTOAp3/1kzl9DtezEYTMNe8fc4cVRDUDLDdKDVHaF50W+pkLs5W5g2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349537; c=relaxed/simple;
	bh=7JIMFAz5G4K06JMHrQKTddhQ9cceZsFjkNIp3OFFeiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkK86rpFKosK11izm3EiwoNyJmTTp3ZX1PSd/vcT5d2E+ErNrc6+PS0wadk8kmOsDHZga4XsFerkRkai4TQRscxEvDgpM3oLMP1OLksoOG+8XS/dGVoslDqrMB7cyFy++JVMkqxCC3Yv7epLJ4GNera2IWSolH+EaobyiokbOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=M1wXZJ6D; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="M1wXZJ6D"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C67F01F6B5;
	Mon, 10 Aug 2026 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786349526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vFz3+D4XJViTRjZy52bDeSuEFMncn+BYlQG2XjGXrE=;
	b=M1wXZJ6DasWcUAhQMMKoFlAP3c7Mly7o23mHl4w0rlL/H4AolroCsPTYsgS7rk4CI9+Jhm
	R4/CZTUHU/6W9R43pg4AAh5K2TGvX8wvVV7zRpSWDkpQvzhME29MDs5CscTtOW/1awxb5z
	xdUO0HJFSGOjhMJx30MNsmnm0aVe8/ImlrAtvAiAQMGNQBWvMfDzl8cNrUzq4xQt5OAj8q
	hrt00ekv3lFJaQ1f0EGzArYGFCfI8dTGi5bpfHRG1HHea25UfzMLZ3RmNv+og3jz9Isixz
	6iEqNrhQVbqom30bDEM7ORZ8s//OCabd1m7zlmHlPilQizXWiR2EMQ7xXoKIyQ==
Date: Mon, 10 Aug 2026 10:12:00 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: wiznet,w5100: add
 link-gpios
Message-ID: <anmH0NR42wC4EwG-@pc-du-fromage>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
 <20260810-arrogant-anteater-of-economy-ef2078@quoll>
 <9e8fb566-e372-4519-ac0b-b8ca6de275e3@app.fastmail.com>
 <105fcc5b-e1d9-4bd8-a697-2d68e185aa38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <105fcc5b-e1d9-4bd8-a697-2d68e185aa38@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTF1eFA26jUND3JewQV6q3aeJ5oZlj9FE6mpvZSNm2BdaZaBZbFDXWWDP5Ud80ur+CvicwMByhgQ5Y1AC8LK0xhgj3LdcvtTm90AM038SECyaNBCwg7BBc67MP6dNbu6JW62MAcQYo0VPb8qRI3+9ThtWbLY3EtBq5JyEmB8euwbOv6fyhaOqW+OWobOmzzq5nE0gcOt/FKDxwSJfN6c5wR5mOmYeKPeI/hMqZ8oZCPApME2tzqDqn2ImrgCXN8uq57mq9ofAmzTyd3MuSCpWIFv0Efhc7AZ3kEVDYVlde47B+sIN1QRN2d0isdYsSkGBYLNMHU/Hql+RogkHgAPiypzdKL2GSjQxbWggSN0pEqatRqE5iKsuyBORZ0nC1iyaKz2agpRWIlWDfKtZe5D9UHtN0NQYiu7ols1jaWnujAa9N2sq04HtLTTbe+0JqycEQZnpnaR6PnvPyGAAEOA3y5O/a4PgvfInzBPUmCHZuFi18gWJqIooPMi7Dv7EGgRoHW37ljh53C7sABYP2le/NV6ibTC0bDceQDqrYSr9pHhoWIIaijInFGTMgAulutZ69D5sZUBetf4qoJcIDqYCDCqZdtqyGpLM6Js802Tz/4uTLPpEHyBpauUU1Qb9bwcEatC9OZhz2bxUn5p70gb4pEygNvgLwc0chrmJI7BGJuMkQ
X-GND-State: clean

On Mon, Aug 10, 2026 at 09:59:18AM +0200, Krzysztof Kozlowski wrote:
>On 10/08/2026 09:53, Arnd Bergmann wrote:
>> On Mon, Aug 10, 2026, at 09:43, Krzysztof Kozlowski wrote:
>>> On Thu, Aug 06, 2026 at 05:00:01PM +0200, Arthur Crépin Leblond wrote:
>>>>
>>>> +  link-gpios:
>>>> +    description:
>>>> +      An optional GPIO line that can be wired to the LINKLED pin of the w5500
>>>> +      as an interrupt to detect link status changes.
>>>
>>> The message is confusing. If you describe it from the host (system point
>>> of view), then interrupts are not GPIOs but "interrupts".
>>>
>>> But maybe this is OUT GPIO from the system to the device?
>>
>> From the device point of view, it's an LED output, but from the
>> system side we should describe it as an IRQ_TYPE_EDGE_BOTH
>> "interrupts" property rather than a gpio line.
>
>Then probably we should list all four other pins as well (speed, duplex
>and active).
>
>Best regards,
>Krzysztof

We use this line to detect a link change but don't read its value in
the interrupt handler, we read the i2c PHYCFGR register to get the
link status.

Arthur
