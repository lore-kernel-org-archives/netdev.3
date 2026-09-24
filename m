Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81E425880;
	Thu, 24 Sep 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233941; cv=none; b=ebZCQxeqkTdMt9vf4dWz+7N5/Sb43YRCEJ1l0xDyi6yxg2fP189dg/pmR595EZY97x/tv47V6M1OdI3pPdLiNpYtVl9dUSDjeI4FMCEa2n8xJB0jFr7MfJo3td/NrFKEMwJtZC03SVXYbuO1myitptmgLvxe+EOVlc4/MWrFItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233941; c=relaxed/simple;
	bh=btEEWI4b+b6mq5vKXQqK0Za+5BzrDpw5YM4Ltjo6KqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJLVwOrq9o6Q3WZbHOPYVmdrtN2S14fkqGu6VZY+KvhNPp4L/E0XgpLgF03CV00aaKltr+uTwPYvVynXwDtlu4WjNPa9AmW7w0xoINcjBMcaU9dPMCy9FR8oN0iq7h6yT2C5+7QfEoDN85y4fUfjviKhf3roH7md8EHCtv6Fpy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=bd1OODpO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="bd1OODpO"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C7D73ED48;
	Thu, 24 Sep 2026 07:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790233923; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=LKJhibbg9LOPrfq2uY8UxfmNCi6pixt8LIckTcy2Rw4=;
	b=bd1OODpOJj98tZG/TXvK8CthzlPjVMJ9XiN2bLjX1hhAUURe8hvmhvogeXpm+waY5whYjh
	+HMlzRyhs7dZdUiEKETkClInuuD2D1EXb/CgEXC/t2JK73R/YzRJOksEuHuSg/zAZS5qAe
	xYNmYCZBIi7P/VH63E6MEyqf5G4pY6Sx+vGVC42B3fLVGlRe7lT7ASDwQv+6bS1W9uUO7s
	jQ/gXfukaz+MygokFlzk5nqMVz3jOQvCh7PAVe/YhQ6aGA/In/186rfSUSrhx2aPB86wfg
	IeclIJ0vl0lcI6dketJimAvEJHken5QNP/tjMDZwpJ7S3UeD8HIWAQeYQZFWjA==
Date: Thu, 24 Sep 2026 09:12:00 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Message-ID: <20260924071200.GA19102@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260921-wiznet-link-gpio-v10-1-5874a7a147a2@marmottus.net>
 <179021495314.2160803.14503162237139110651@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179021495314.2160803.14503162237139110651@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTFb7R3TFqzm2kPkpKROydm2KBoTrWspHdFjVKLgpcUJ38+gMKvW5W20ZNKrLzBmgEjvoAxlNxYAEVgMxPULeQi9WKWdz2xn5WsQ2Cic2CG9LuPXKgvQ1F6AL0g1n23Q9Kr1fxYCzqGoJ+prZSgVSuNTzYhJu0wehoqgLHoqHaoitm0kd06wanQSm9F5uxLTfv7B73G0D+nlwS48ttdLh8XNRnbtlLbMHk0AipZrXYxwc9cK8bGGOofWUWL/7efeMKxEljO3XFYC6v0RAOXyI0yIArYC5HlmtoRzfE6SpI141lLU7cAowXMJwE14QvnAy5/C/JDzM17P/X0LTBxRVoDwJMugfxG7mqOPmZtxDeoiJBzfClp2e+nVJs3OlBV+jG81lNGAbo70Bj3kmKdlGgWs143bIQbtbHyDPYQgzCWd9WaE8npBmLAknzgKcxaEcNZKJ8VSJ2mnRfrH9sG1MYfnkxhhBMKi/bp19FQDYWrKqDljqSWWUy/UD3zHA+Gadx/S8kXHcJCo1HZkaBoz9WYU/CAzkIxzBvuQ1AvGrxH5Ksye59c8tVWzXH0r9Gk5P9pWV5zxglaPqPDf5Emc+ZItSMBObpKUxvewL9huw2Jt9WRIZp11yVH9JVeYhC9bz2enhKfydbK3X4324Nqccbg/CHIJX5JJYIEQl/CjtwQExQ
X-GND-State: clean
X-GND-Score: 0

On Thu, Sep 24, 2026 at 01:55:53AM +0000, netdev-bot+sashiko@kernel.org wrote:
>[Severity: Low]
>The description here says the w5100 tops out around 14 MHz, but the only
>machine-checkable constraint is the loosest value, 80000000, and it applies
>to all three compatibles.
>
>Should the w5100 limit be expressed as a conditional instead, so that it is
>actually validated?
>
>  allOf:
>    - if:
>        properties:
>          compatible:
>            contains:
>              const: wiznet,w5100
>      then:
>        properties:
>          spi-max-frequency:
>            maximum: 14000000
>
>As written, a node with:
>
>    compatible = "wiznet,w5100";
>    spi-max-frequency = <80000000>;
>
>passes dt_binding_check and dtbs_check with no diagnostic. Nothing in
>drivers/net/ethernet/wiznet/ looks at spi->max_speed_hz either, so the
>14 MHz figure is not enforced anywhere.
>
>This is still the case at the end of the series: the allOf if/then block
>added later by "dt-bindings: net: wiznet,w5100: add link status interrupt"
>only constrains interrupts, and spi-max-frequency keeps the unconditional
>80 MHz ceiling.
>
>Separately, the old wiznet,w5x00.txt documented the 80 MHz figure for the
>w5500 only:
>
>    - spi-max-frequency: Maximum frequency of the SPI bus when accessing
>      the w5500.
>
>The new schema extends that ceiling to w5100 and w5200 as well. Could the
>commit message mention that change?
I don't think it is really an issue here, the user must put a relevant
max spi frequency when creating their DT.

>
>[ ... ]
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index df8ab9b824024..9f84e4c8163e4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -29450,6 +29450,12 @@ M:	Miloslav Trmac <mitr@volny.cz>
>>  S:	Maintained
>>  F:	drivers/input/misc/wistron_btns.c
>>
>> +WIZNET W5100 ETHERNET DRIVER
>> +M:	Arthur Crepin Leblond <arthur@marmottus.net>
>> +L:	netdev@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> +
>
>[Severity: Low]
>The commit message describes only the .txt to .yaml conversion and the
>trigger type change, but this hunk also creates a new maintainership entry.
>The "v8: Add a myself in MAINTAINERS" note is below the --- line and will
>not land in git history.
>
>Could the commit message describe the MAINTAINERS addition too?
>
>Also, at this commit the section is titled "WIZNET W5100 ETHERNET DRIVER"
>while the only F: pattern matches the YAML binding, so get_maintainer.pl
>still reports no maintainer for drivers/net/ethernet/wiznet/. That gap is
>closed later in the series: "w5100: detect carrier state using link status
>bit and optional interrupt" adds F: drivers/net/ethernet/wiznet/ to the
>same block. Would it make sense to add that F: line here, where the section
>is introduced?
>
>--
Will be fixed in v11

Arthur
