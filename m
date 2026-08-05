Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8393F6C25;
	Wed,  5 Aug 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921143; cv=none; b=Leas0+f9gnXXmpLN6qNk6rmHbtQDYj0BaRLhQpy40TTnkLW61FDkjPIrvlv/Ru7RqiTWN5Q5E6gqhQQ9zDqfhTqU7NCRdU11Rrrd95AGIqUO1haCKHfpzpxf0S+CifVxlr0C41nKVKOWKE6de0lzsEmsDg7DsZ6faqHwBGSxNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921143; c=relaxed/simple;
	bh=u37wlO03RM1fb9m5qn6oHyq/lyBft4YJSHG1hALPj60=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UoNy4p4mOg/xnKVx7uMpU7qbpEGkfhhe0QJ4ZSRar1S6qqvkYJ2oIa5jf8IYAQ/rXOHf52/1MIQE9tBY3H7POexCDZGrEDsBtYj6Lgu4xiw6G6judtEPhObr3JM6GBLHbaZibiHePKM8awIvIDx9gKkCUFQd5NvxxY37o/VEq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GhyrrZTe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jx8us0cj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GhyrrZTe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jx8us0cj"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CAF51400096;
	Wed,  5 Aug 2026 05:12:20 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 05 Aug 2026 05:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785921139;
	 x=1786007539; bh=MHTLEg29LKoWbwxmX+ebrTjEqEV+f6dnJqTwwTHldlM=; b=
	GhyrrZTeNPAmI1EprCyugjhFhDh6YJ6tRgIKOk5nkd3Kvc+5LHuWFqGrfz6LRt2Z
	pRCaq/zEGOF/TW7GQT3vNW5eaemBNRpGaSzM1nSRKZCo/sAlIopE3rCdNLUYYmaM
	6I2+jwL+cMDUdUC1/LkEF+a+ZCxF2ez4UegKYYfk0fl/KW2a6Ibj3cgW78nPmsql
	lP1vydCd35AqBRweWjMQMtaBHZFpf/CJAfmKQ9oC8+0iuhpTVe11tVBcP/gSaSZL
	q5OJpH3c+6agUNiy6r3tWmn3ULsT+dob8i05E4PobfI56zPY2/GJLfrRcgCYGUup
	nQGAZ5yLHAjRZ8Ut8bys4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785921139; x=
	1786007539; bh=MHTLEg29LKoWbwxmX+ebrTjEqEV+f6dnJqTwwTHldlM=; b=j
	x8us0cj+qrTYGcws1oZTm6yvMVac66mWz9myRZ9ABgvadQ3GTJ3bt1ahXK5hd9Lw
	VxWzfPisY6H4Dwl1hDv3/YMMp+HSZXDQbQtjk52JZgSgHToLuOrdmCB+p8TFFEeH
	0f6xeCH9jWy3CJgvk3FpTJud28k8QLGqyfcvmfgqOtSMD9etXMYrvNplDIDaQ2/e
	DnUFk0Fh2A4r+Oig2EzfG5gEVVpeT5LzKlIfDTqekpdxixdsd5feLJA2qq/ZYDrW
	jJLM17GD/VS2Z9lz48o/NKf/xtf3CerwYkpmRsrJUIBcJJh9Njr/6sXlFRZFb/B0
	Gm6mRqL3DVwUcNpkVm3rA==
X-ME-Sender: <xms:bf5yai9n8EcA9u7tb72RZRq1vE2a2uqemPzmD8pPhqBpIg7NvWdNag>
    <xme:bf5yatj88lp34dcjTelyKhxjDr2xBZtVbbFK1lLY8AGn1-sJGuA71zs98MuVzfGh_
    5chzv7U0aocYo529HbGRWyMGTt1Wr14d2yGVxD94nNS1qesF3Euho0>
X-ME-Proxy-Cause: dmFkZTGYQzPiS+6CAGJ80ElOgofc6XxvNhr7dDCV7m30Gh0DCcBzJTf4Xg1dXtUvR8MB7m
    UA9b+gvFVgKZGldYEKMqEjtETe22S8gmYBXUK2IfUukNLyfo2FEkXhivUSiKke4jNHpA3N
    Vo9zpmQf4Re/dS1lCdUB5mlaLEb0sG1GT9zMfIbyZ3AbscTKzUOG/BOFaqSjzPyD4y4d8I
    Rh6rP7UnTtAd8cVOO+3WqjqA/JQCtEMKRCwNQf//KKwDU9X6u7JM9v/7wrI5fwCI30BcTt
    7spZ9DV/2G7TZruWxDNvv9j+R8kRpfgXbIqOHMsLCS1ZuYj9y2j4Xzdse5LTNAFkWY7RFX
    LE7nk1YmlO2bdUgc/L6Vkk8PyaYInihj3VblXxtKHhi1MOXxjhX9jo7LbvVmTOXS6m94Pj
    dgkigpS7bC44LujTUB4va6ABVdWjG7ZDEE+7TZQLBbpS9gOdgRGrfZGYiWfQWdy8frOjCy
    6gww/MvAbLoVTybV0Znq/ru5D/V9fm2RTxxAOysAb3YUQh7wgmb1FCpDyvXgpRho4Da7zl
    Imc29lUb8DYYca1f0rTaGTE5zo81r+lIVP5IsF5ZMis4JCiuF1sdE9f/+01e1Yd6JhoSOp
    zflJKxtrUhMNz3NWnpSI7IWBnRo/GDHeIYMOEAk0t8JMnEJIXrjhw60j3Gxw
X-ME-Proxy: <xmx:cP5yakNNl2UbZWHp4iBgii9WT4E4l88692G9iwLHzQHwNNx2m8mxFA>
    <xmx:cP5yauoKYCKhqWnolj0rU-IpoxkqjIvFLxPkNXAI4BLdta4VzSMa6Q>
    <xmx:cP5yaj4v4q9LoNoEdoCqbqFONe7M5IumR-KrFPId3j9Go4y47pSK6A>
    <xmx:cP5yauEYaJuBVmjVk3Hb2IFKyRjzEBMSZicIo1n-fUseInGwnf8Biw>
    <xmx:c_5yajnSQaNFB0L8iWruYr99rn6USmqjK7YnQmx9OtKmkONWRXJ_tzCm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 59DDD32A0062; Wed,  5 Aug 2026 05:12:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGiDCXf8z4CV
Date: Wed, 05 Aug 2026 11:11:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>,
 "Andrew Lunn" <andrew@lunn.ch>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5d9c865e-a9a2-4756-a27b-a5af60ef3bad@app.fastmail.com>
In-Reply-To: <anLzkNOBMvn7_0d3@pc-du-fromage>
References: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
 <d762ff5f-30ba-42fc-bf58-500f807483ad@lunn.ch>
 <anLzkNOBMvn7_0d3@pc-du-fromage>
Subject: Re: [PATCH] w5100: restore GPIO-based link detection
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026, at 10:25, Arthur Cr=C3=A9pin Leblond wrote:
> On Tue, Aug 04, 2026 at 07:54:29PM +0200, Andrew Lunn wrote:
>>
>>https://wiznet.io/products/ethernet-chips/w5100
>>
>>suggests it has an integrated PHY. So why is a GPIO needed to report
>>link?
>
> the W5100/W5500 exposes directly a LINKLED pin for the carrier status.
> On my board (RPi), that pin is wired to a GPIO to detect changes on th=
e host
> directly via an interrupt.

The datasheet says

   LINKLED O 66 Link LED
      Active low in link state indicates a good status for
      10/100M.
      It is always ON when the link is OK and it flashes
      while in a TX or RX state.

which sounds like this is not a great way to do it, since any
data transfer would drop the link status. Are you sure the
gpio line as you connect it actually only reports link status
and not RX/TX? Which chip/revision specifically are you using?

With the W5300 driver (now removed) that was trying to use the
link gpio, the LINKLED description in the datasheet is different
and does not mention flashing, so on that one, the gpio link
interrupt was more likely to actually work.

      Arnd
