Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCA455176;
	Thu,  3 Sep 2026 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425951; cv=none; b=XnyeTmVjXO7qSO/2+DBBGF3N+xjHySMzowKpTGkA9oX1J5efPzkRhkk68YaWwS3o421K32pvg4dfExXV/5f3AqmyhJO8lR4dQmAWJvBKZ1WqIMUK//M+FnW3qILQxk/wdox+/YRJzD2s9/xkr+mpED61BuGo/msnDjdJXGq7GOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425951; c=relaxed/simple;
	bh=BPOsSzQ1YA9suEvAssb439th3KDx+MsFa+BEF+SOKv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOoFJTxslw1kuWDuqRQrXyVtBxtajVJWUUbguRGs2gwnLujBLl+YPs3hkwhQXSvqwlKEvuZQJETGNkt3W4Gp0SB3f2rDvwZ9Vncd5crvhjbNLP7C1r8hamovmPFdtwH4qUOtZEb2220GzAo3+T3i81PcEv3YLdsdJi6FSMrPH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q1GHvmMj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q1GHvmMj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 227C41A18F9;
	Thu,  3 Sep 2026 08:59:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E519A602B8;
	Thu,  3 Sep 2026 08:59:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDB7D11C79B6F;
	Thu,  3 Sep 2026 10:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788425945; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=V1QGsX6n7s/Q58nwjzCnUIFO1aaMfaPkZ14gV28tNtM=;
	b=q1GHvmMjv4Wa6DSVg0LmjGGBrxi4LPtvTp4UyOe4G6EegU/mLn1n5mIKxBVj6oLhjuXXWU
	v/dAmFaKftte7CBAZkrOfBE70aMZNpgU8kEJEfTHIRqLcbSttVx0gPuxMJk/dpGgpHV7oZ
	e7bLnyBn9DkvQ0okpSO14YyQOyBWGlK4A6zKDhbd2cLlmqPPD93NU8qmKGBWYiUwwSURKK
	uLYpBw+hl1d4Ly8fJ9LCB8ItREG2ebAvNOdHJF3niAAbjbf/3SQEUPejTorP3sL6soehQi
	I2vTd3bUZKcctPRCFR8/zJIX8Oo67eTENP3LmZVNWu5C4z0UHQhF2ZKBSNwepQ==
Message-ID: <7d0e6b70-b474-44d9-bf57-6079b8d9651e@bootlin.com>
Date: Thu, 3 Sep 2026 10:58:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/10] net: stmmac: move XPCS lifetime
 management to platform drivers
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
References: <20260901150111.141037-1-coiaprant@gmail.com>
 <20260901150111.141037-2-coiaprant@gmail.com>
 <0dec5462-f6d5-4ef9-9d02-5fdf7f3090a0@bootlin.com>
 <CALj3r0i2msRXH-uqA2QX=cRkQwM_H2bFH9GiroEys2NfEbTtCQ@mail.gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <CALj3r0i2msRXH-uqA2QX=cRkQwM_H2bFH9GiroEys2NfEbTtCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/3/26 10:51, Coia Prant wrote:
> Maxime Chevallier <maxime.chevallier@bootlin.com> 于2026年9月3日周四 16:32写道：
>>
>> Hi again,
>>
>> Sorry I had a second look at that after a good night's sleep, and actually here
>> we may regress. The original logic checked for "pcs-handle" presence, then
>> for the pcs mask, but if no PCS is found we didn't error out, we returned 0.
>>
>> This is making it mandatory to have a PCS. Please handle gracefully the "there's no
>> PCS" case :(
>>
>>
>> Maxime
> 
> Hi,
> 
> This change covers all callbacks that use `select_pcs`. Drivers
> without `select_pcs` callbacks will not have their pcs used by
> Phylink.
> 
> Currently, only the Intel mgbe driver uses xpcs, and Intel has also
> set a mask for pcs-handle not set.
> 
> This means that on Intel platforms, the parts that implement
> `select_pcs` always require xpcs to exist.
> 
> I think there shouldn't be any problems here, but I agree with you,
> regression issues can indeed easily occur here.

Alight, let's keep it this way. The assumption becomes "if you have
a pcs_init() callback, it means you expect a PCS to be there, ENODEV
is an actual error".

My reviewed-by still stands then.

Maxime
