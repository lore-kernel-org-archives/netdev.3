Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B480332637
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567088; cv=none; b=F2e5ZQiFLO07VwpaMAHRvBODCkcADJFs74LsfJMqZlwL0b4hnbkT2tFfV08TDYRNFJyiMvAaM5VW2ur7eYi38QHeVlGoTS8b42n2WAo1n3c+XJbd8FT+SYOwo7/LRT/QivdMOwDY5hAObY55amBRl261T+8MgXTbxQVKOPPT3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567088; c=relaxed/simple;
	bh=kqQJ8xc3vkuS40H+cWObDa0dDEUwROCwDDmchGwzADo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXekFxkC1geK3n7Q9uluhzmd/Q92bIaYL4jTdM2fNoKWsH3j+YjGlQTS24bZW5ShY2bicTv4J+68UGk2ZjUN/DVrbYEL2kZ1L1QRSnVwigyrKz8vy7JlmL3ZVX+T/Qey3XEvgaTOuXcd28gZOAnxqwOCO8AhpmqqvmdNk1uQypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHGwJOjm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHGwJOjm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so4363215e9.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567083; x=1786171883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ibyAvlXW4OBxswkrpuHvoKSISh5II++nXruZ8WtjRy0=;
        b=BHGwJOjmbNUchRQnHoIM4mVOfrT15+RGJRXRuCPQKlZCx/Yi3iS2sPb1Eenm1bLyxM
         D3zgsHKskE2xLg+W94ezxD6w99YkwWMjzCP7K5rFphGK5epMvH3koDUgBZZxCVVGg/jP
         NXfWqocqobyzBOGsRJyiHa40MmJaHMR/GmJ78IXNjf4oNf1of7VCQ9vD/4SfuEhLvFGY
         9VS6gwCg7eiQSvGmqrm7sytAv5AvTxSttZpDb3+O4qTrrUBP95b3S/+G1SxDGAnZRvxd
         URDjnEbOjUukNbIt7YuF8g/XrS9u9WbeF9SHtSdkdJkn9KQreGz3P/rYJRi2ChoVq1AV
         IqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567083; x=1786171883;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibyAvlXW4OBxswkrpuHvoKSISh5II++nXruZ8WtjRy0=;
        b=RAYYp7Xsr6YvpH5Bih+8MCNrvrZMwrqjeGrHDPzF9pigDl+kCoWdaG+acT4BuuJTQl
         mXl30sne8N4E3Lgp1iF8XqfK36qWqusrH7kIKnN8zGVEcPyUZWVEdWWH/qcJn3FakqqW
         ApnYRpqlJ74zf+9sUCFxoO9J8hBPiOJcRCr5I5QvMl4Nvw5zn8kuFivJjqPe69tiWd+K
         2RSfOA5bkwGBxNH0r4xNfh8Jr2ND++6y2D9xuyraIGWl7OWMnKuniKskTsq1gJpKy+Zf
         +MXgpXcKO9VYXesg82sO56N0cRgLNEAhOFvFrPWRwMhY/Bdznysl5K3EW8CozN5WSvWN
         p3eQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/AHInjhPahYEpAn3EbDEqTGm/OevrR1AQVcpVMEVjRbHBEgN9woeO7guy1nFOj3kPBexuP+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jHlZmX9kMPBP9F0el7WuNGiJBpvKEHg/ouYyUOS+Z/BHCghv
	CuLD6LgZbUPpUi7cTNs4XETznVJ6qWTO5PYEgWsPKo1ByJ5oIGYXh+jK
X-Gm-Gg: AR+sD10teeOypvLriCSQYzhqNterKTU67R1qBI140NZ3Jm8TnhMu0EJzGmfmfbusPpq
	RxYpb4y1BFJcPib9Cnu/sCUjC3I2oUOQB5FNe+y/nGD9TCKKy0tDO47Y0ZS4A3ovAa9rOa51rDm
	IB64eHBT8oqoB87w0SNetBC6myq1Gwr5ezPnoj7ABr118eY1JyQDEv0oaEKYHk0+/VGLt3dzPjK
	yteicT2oh41exQOQDJx3bOJr+MOeNfdOs8qlkqXd9zY2YlsnKhMrgfCtz+blt1Q8xiYb2uOnA4C
	zjxUhZstYnIFscmoAlhzBwbd2ByBpdukPgO8W20KOHbggiR+0n9FfhGEfnIVUP6vAYRbpNjHisL
	Sx3pbX3IBvH2pt9pEq+FWX7w7cAzkQyyzgM4xhYqM+woh9BW1medPR0CAykOuOZSa82KuaCy4t0
	RXGsQuyZyiJ3n85/q4FSESM9yN+p34cmrIfZ7/LKdCCSqF+O9jWANDCbtBDyuf5H1dCX2vTRIM2
	xV2UuUXTmeN4SlCWHuxTw/gRPrmpGgKi2PzaKfbQB5ENMpMEBvM4SOx9HevGo0=
X-Received: by 2002:a05:600c:608e:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-4980c64a978mr24899205e9.7.1785567082676;
        Fri, 31 Jul 2026 23:51:22 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f112:3801:7859:cd6f:5f73:7262? ([2001:9e8:f112:3801:7859:cd6f:5f73:7262])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b6745csm30760375e9.7.2026.07.31.23.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 23:51:22 -0700 (PDT)
Message-ID: <c55d6167-b8e4-42fb-a5b7-6b7eb5ae3a3c@gmail.com>
Date: Sat, 1 Aug 2026 08:51:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20260728084307.2129515-1-jelonek.jonas@gmail.com>
 <20260728084307.2129515-2-jelonek.jonas@gmail.com>
 <20260731171639.1baec9e5@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260731171639.1baec9e5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 01.08.26 02:16, Jakub Kicinski wrote:
> The second patch conflicts on MAINTAINERS so unfortunately a rebase
> will be needed.

I'll do a rebase.

> On Tue, 28 Jul 2026 08:43:03 +0000 Jonas Jelonek wrote:
>> diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml 
> While you rebase -- the AI points out that the binding is called
> ...-gen1 but it documents gen2 as well. Should the -gen1 be dropped?

Not sure, Conor before requested that the filename should carry
of the compatibles [1].

[1] https://lore.kernel.org/all/20260710-divinely-sharpie-1d415917c850@spud/

Best regards,
Jonas
