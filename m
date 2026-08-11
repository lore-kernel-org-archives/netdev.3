Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CEA34040D;
	Tue, 11 Aug 2026 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457715; cv=none; b=BDkTBbWJdZSlTZyzLgaslz4chOeopEjvkpExatpIe9/1WHxAxM+PaxC5LRcXTS8acpUU2EBcb0unVBesBjPGh8vfXIueyHrpgBUe1UtVAYMCF8NmlnaieuLunRy1XcZDrzO2aoMoMmQ/JUqxsayuvnsrsx6CQ2s4JIceiHyXI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457715; c=relaxed/simple;
	bh=hff+GetzW23/4CRB88uLQZxKIlNWZLJA01JhWrZ1o6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTxwHb4CrSZ/KfMbZrTPsXqFdqNCGDQeBlEaXEvTFS4xs4k6cs0HusAYZf3jR5ZWiYlTYNiqnRoIdqoKI/OQL7dimgmov9Oz8qeP6Nw/tjCfArPgyTmoJbGyBDZtp6afPWtrDkOqcfsdkji41DkZruOptw9ODRmdW5YjeqeYjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=K+0ZQKNh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="K+0ZQKNh"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA3DC3ECF1;
	Tue, 11 Aug 2026 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786457705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWw44zpzNqo6YaMY19rOprxLGahTztOgmFF9cvilol0=;
	b=K+0ZQKNhyE33FOMpfJ+8mxce0aNTgHNIav6JfGCeSoEvqDPTTbSoQoid9zv6S94hEQuHiU
	RpPB9093TvauAs5aa2kZRC3woibVr0PO7aKtqXczBxY5oNfH7EjZRe26VwIq6fbjRD77k7
	1t1zzltJtBciIpt5wgO0fuK3awFpr4laNCE/DM0JJ/VrKSebQGh3KNTbnGgPQ+olpxEXhf
	768k2HgzTTtpNiXESdstuWpE2LhqEoCe0qNLmzMYk/+GwIrkIZDJsOUDt5Xl6bPPA+yO6O
	teeoDYZFoDjvp5SFDYlhNMroT5K5D9AHstBKOUw/CI+r64CG6Oi+/CLjma4Lrg==
Date: Tue, 11 Aug 2026 16:14:57 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Message-ID: <ansuYaT2GAMAA0hF@pc-du-fromage>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
 <20260811-wiznet-link-gpio-v4-1-4d5f7da885a8@marmottus.net>
 <5812d452-5dbe-436b-ae6e-af062a873f7a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5812d452-5dbe-436b-ae6e-af062a873f7a@app.fastmail.com>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFNhpqs686JAHk0xx0MEzMcDAhHwLrEfZwlQs4xTFISFeJops4AyxV3U5s2XwVaBbziRL651+1mRnb4ezcc+0A8oYPRkuLe+FIxNokTQWzOBjM0STvumiUqCsDcQqi8JFer8Y6rwsDQ8DLY0MOGG3CQbEJltgHmeJpbUVAXDg7oA43sgJaBqWHNbkLdyqHDiJ2fiJ0QmXLM0X59yvj6CNxJ92GDSnSf3p/ne/MBBc2O1vUVWyVRkEh7LoZEVtxlEViHHDBaS2qXaEmbe/Asj2uSpjqbxAH1TydhsM9YeAuby/9Wko/UtGA++qNdF6YrlcyPA3s//S0HdDlktIdG/2kqeCqB8TrSpyJ6n2bjaQ5lP/5ASQL6HcZ48XdQMXP7FLNKWmGLde0unqcukKrxk/vSkvEFWqYw6D1eol6CjKnxIcLrGPTmzP7boHvjILY1ORHqfpcGY/KpL+By/tgLebFYjmHThS1Wvh24gafZ2HSKDRu32jyP7mIsZysaTraSsHeOCNu+q6FoEJBDJQZ1Ln71MEtGLBCLqNTrHG1QfYsLeedzFi2wzGNrh5GgMFIwN8k4C3i5hs6Q/imk1PEPyFDymRM02eu7Zoxnjrt7qvsylHWSAlq3N/bY2LDgU8a/fHjLOXFjyUTbHEXzVV192aEeOYomE2//KaN7vOX5XqDUbQ

On Tue, Aug 11, 2026 at 02:57:40PM +0200, Arnd Bergmann wrote:
>On Tue, Aug 11, 2026, at 14:34, Arthur Crépin Leblond wrote:
>> +        ethernet@0 {
>> +            compatible = "wiznet,w5500";
>> +            reg = <0>;
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&eth1_pins>;
>> +            interrupt-parent = <&gpio>;
>> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>
>I think this needs to be IRQ_TYPE_EDGE_BOTH instead of IRQ_TYPE_EDGE_FALLING
>to make sense.
>
>      Arnd

This interrupt is for the main one which is active low, we don't need
to catch the rising one.
Only The link interrupt needs to be both edges.

Arthur
