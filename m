Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE283FC5BE;
	Mon, 10 Aug 2026 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373224; cv=none; b=QV+u/HQLgz60hJfj5nVIDFmjuvwF0GxxvSlGnmp/PPRNdeDgS+xqkSsaBJUcdGw0MtuAZGjqW74BWZ2XAihwFUQggg3hh8qE3oVSnp9fzJAagIJO5jZgsNBt6kriH44tCuV9pMN7aA6unjsgfszuHK/7tfk9gL7LAAEsnLbU6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373224; c=relaxed/simple;
	bh=L46JLBWhB+Q9Mx2Jm4/8OB7JsvsaRNMPrbczPD1tCPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvTm5Sk0ys4u1KsYeAlUSpkOmFzZK8c7MaH62i+/xaUuhQ6lnZcj/tXPr3oJWbrBZNQuInPEDkQbnlfpXmVKaBgWhIOGx8Uagi04c5ATy+S5q/x23L4omTRPlBo7nvBX/0b5gkWhr/PFpzzfuYrSqLuHDr9MbCEg9d/4NIoGlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=fYU52lyy; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="fYU52lyy"
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2B1D3F559;
	Mon, 10 Aug 2026 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786373219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L46JLBWhB+Q9Mx2Jm4/8OB7JsvsaRNMPrbczPD1tCPA=;
	b=fYU52lyyZyV3HpNjVwrClA8QJl0C+tUAR8EMZVa51bWOVF1y7HMDsI0dyFbuFdVkmvwv7t
	05B4FW9V6DN6SXYwiSq5DBhydKfwmvhwQ3mC1iw5ymd+xka2GIaQiQ4VTR63hCZzm1VFcQ
	dTmNFQX0T8hgkIQaHPTntqef1XL30eutUYixlfBwB+5XKQ791hTGdNLsTPj2areekSbHbb
	9nZt3z9+eKmtxwJcAIgCgwoEpPNiuOYtPpZrno3e3W+evWXO+7e2jh0z6rOCix1ZvTcMMs
	mGJRCDc/eMDJWeS0gcnJMW7JlliToSjSIYdYMpqtjnHXZ2VUhW5vAZ8OCnGfMQ==
Date: Mon, 10 Aug 2026 16:46:52 +0200
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
Message-ID: <annkXFHpFjyEAf4g@pc-du-fromage>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
 <20260810-arrogant-anteater-of-economy-ef2078@quoll>
 <9e8fb566-e372-4519-ac0b-b8ca6de275e3@app.fastmail.com>
 <105fcc5b-e1d9-4bd8-a697-2d68e185aa38@kernel.org>
 <anmH0NR42wC4EwG-@pc-du-fromage>
 <44b4c6f3-3414-47ac-baaf-bca2f68df4c4@kernel.org>
 <ed92fe3b-2fef-4343-8ef9-314e8753ce69@app.fastmail.com>
 <f2e4fcfc-0713-491c-9749-bc75b1169776@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2e4fcfc-0713-491c-9749-bc75b1169776@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEM+KEY6LijsWlnpwtcJ8wLcxDXF+Yflu/H1+SGnrX2oYU58V/XXUxv5wae57mkHwzz42I1Lyyg+GVzKqdEjer63mhxjF9vy0/Poq6khabO8Grs0wGbjeCGOhZx/PZkIjPGzF0GtVuMCl/BKpHoO9qKTAPkgTM6ZPBVPYpRUUs3NKqbSCfYmoZFW+1rljMnGiHXr527um9AvPkxmomjCuS72twOzjKPmrvtkiTnE0O1OfYpox5LvdnRdck6eDXx51yUSFK+cfZxjVx5v/3Gn8TIycRvVOeAQKnl3R4Ng+xtmo5pFY+FWrijYfTxEh2eFKWsRD2SMrMYT/wjT7xCNU1eUpngYM1PitwoL6KFXy9zxscQCXwIIzN46TlniQPMNuxWn7VU+MeakfnTDhlBVMCpX7VuUzTWzRhZyUMpYEo8mOSialh6n1KGYxFvEnUsrLKMC/CJ6zRnuBArlLkINvTsyOS8kHf0yodo5JKKFtOL04DAC3363GGnGZFDmfG3PVcgCbQa1flWmt3dTdklqTIwTK/d87kcZQdf4ZRRSZx3CEXFZgUArrSiiKj+x1nrjuY2AywdZlJgAUsVxanrbn+LWJZtnbuAO+CubRpyLqgvXnAjqxIK0OK+Nxi61XQ05aYUiBFVsZBRDrQnmFKV16cOxE+0+xLPJJgOncD48/2KdA

On Mon, Aug 10, 2026 at 10:31:50AM +0200, Krzysztof Kozlowski wrote:
>On 10/08/2026 10:25, Arnd Bergmann wrote:
>> On Mon, Aug 10, 2026, at 10:21, Krzysztof Kozlowski wrote:
>>> On 10/08/2026 10:12, Arthur Crépin Leblond wrote:
>>>>
>>>> We use this line to detect a link change but don't read its value in
>>>> the interrupt handler, we read the i2c PHYCFGR register to get the
>>>> link status.
>>>
>>> I know, but won't you have soon the same problem with active? Otherwise
>>> are you going to keep polling for the active link, since it is not
>>> reported through the main interrupt?
>>
>> I don't see how we'd ever want to report 'active' state back to
>> the kernel, this just means it's either receiving or transmitting,
>> and the kernel already knows when a data transfer happened
>> because it either started sending or it receives an interrupt for
>> a received frame.
>
>True, that was just an example so the author thinks about it instead of
>just solving one problem now. For example neither speed nor duplex are
>reported in the main interrupt and you might need to configure something
>if they change.
>
>Best regards,
>Krzysztof

I did not want to modify the driver too much and the link status is
enough for me.

Arthur
