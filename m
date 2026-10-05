Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F59419FBB
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194674; cv=none; b=lBcMHHSdBe6zm8UDC0dkNmpWIoJ9HylINiUMkDq4MUnWpOcZGSOAHEAS/iPySHi1AvUo29GvISi/QJKWgpph5OWbNOot+F7gEYm1vrczB36Azkq/leKhewrd3A48QNZE3hhXSf0Fgb4ibkGfE53ZmwWdWjO5nkaRIdjOKkFre3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194674; c=relaxed/simple;
	bh=oHX5S5UfFPvt8CW5tDL/Lr+kdvnzvnuIjZbXiUvlxCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnjhAgfqlvPv5hFuGq99IDrhw5AX5EPGk6ATXRqLVExHVd9LleodzAxID9rO4qnVsU62dGPPqzPo9klih/1RshBVUmlzFKQHVglnSjFY9pNOF3hsWtNT97f1EAH+vPLv27vKBcfv0XKL9Z4qxVOvgVZLWdZwL2xqNssCMbdmDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so1520272a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 03:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194667; x=1791799467;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFDKBytFqpiCAKHq7794WGTm1eiUeSTtEFvwUnjGNk4=;
        b=B6l411OhNYbzQbiNovniIf/hdvL3p6vxm6vv7iS7L4wP60RyveeJfXXM3ODMF9ZfJ0
         bQXWsTQtLTJt17vEfFe3WsFhgieSEovcnV3CBfI7gpnj1y00n8CtxHfQErTFiw5L1yo6
         0WUhwt47FuJgqJPbu/F0EZw2uywwhDwbh4bAympRs3ILmUpHZL4dVVLlajkSS2XKlCJc
         2A4ubuaUe7dgCqeGxOhjGIz5qdsaLB4frqlKkIpoNxPFDELIayyvnXt2otZMaGQrNiEx
         5fiqEqreCqLzPAyZUq1rZpmXvJAxXIcrsZ8GfNYfW0STCDc9v8b0xnssdpjx02fhiQbz
         LL5w==
X-Gm-Message-State: AFq9FYKRhMxZ1ojWnXlERIjTuhLYncSvh5QiTlB6nwwSKEbEktrM/GFb
	sYOn+L2+9xiiaSLjm47rXMML6z1zQ0CzJnt3fDLs9f11n2mkqzJG9TBP
X-Gm-Gg: AYBFou18/HjZnQJuz5OR4DsqR1ehg3amIGlpjOv2ug8fOiGhRD7J7OrwXJHnJI7Cp3/
	lsBStaPiNeyACDC7bg9HDP6vMoJbya1ksSWugiPNrWTw7AIj2r+OKWTur09WFBbE6VT22swwQa0
	mHJM7HTYIVe2KychNeO9uZeIt5gmPwX1i83GCq26/7K85A2ZXe7OMfYlnH6LHF7VxkXVNDu9dvo
	4zwCMi3hs+3mOzxYuFMC6dYKia5fc7HNIFnZ44sp0dil1WYGMTBa2dB+iuEKj8R5NSenWOG0DkR
	XzsKio8+3UEiFVYJIi0xkjVVKi5mYZjk8AfSQhwx5BevbrP41fe2wbJ96FAaCWHpnnsSjp5t7U/
	vZE3Ta2kb07dWvc8sgwoWI29KnIA3Vj56wL3Td7baFhKmsnYPWwIFLfVq7o4fh2wA2YwrzOC30h
	d7Hr7fAY+GZtAlTwDzON+0wSrIKfWcRg0rCjgrxNU0U4uEBAg3tzLLNDd4SisxuUj7d5vZ+8uiP
	qXi642RljjYBCsQqx7vd4y6Tv3H
X-Received: by 2002:a05:6402:2421:b0:6ac:6968:9424 with SMTP id 4fb4d7f45d1cf-6afada1af02mr6404847a12.33.1791194667149;
        Mon, 05 Oct 2026 03:04:27 -0700 (PDT)
Received: from [192.168.1.135] ([84.68.183.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb020bdb9sm3060982a12.23.2026.10.05.03.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 03:04:26 -0700 (PDT)
Message-ID: <f246ff74-a30e-4381-a6a0-ab51261f9e90@linux.com>
Date: Mon, 5 Oct 2026 11:04:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] arm64: dts: amlogic: t7: khadas-vim4: enable the
 ethernet port
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261004144046.391444-1-tanure@linux.com>
 <20261004144046.391444-7-tanure@linux.com>
 <d1ae6c21-72a9-4bc7-aaaf-9051d0f6b1b0@bootlin.com>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <d1ae6c21-72a9-4bc7-aaaf-9051d0f6b1b0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2026 21:58, Maxime Chevallier wrote:
> Hi Lucas,
> 
> On 10/4/26 16:40, Lucas Tanure wrote:
>> The board carries a Realtek RTL8211F gigabit PHY on the external
>> management bus, connected to the MAC over RGMII.
>>
>> Enable the controller, hand it the ethernet pins and point it at the
>> PHY. The clock delays RGMII needs are supplied by the MAC rather than
>> the PHY: 2ns on transmit and 2000ps on receive, the values the vendor
>> kernel programs.
>>
>> The PHY interrupt output is wired to GPIOH_6, so describe it and let
>> link changes be reported instead of polled. The PHY reset pin is driven
>> by an RC network on the board, not by the SoC, so there is no reset line
>> to describe.
>>
>> Tested at 930Mbit/s sustained receive over a minute, with no MAC error
>> counters moving in either direction.
>>
>> Assisted-by: LLM
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> ---
>>   .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>> index 0fa83362b417..5d0365ddde72 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>> @@ -14,6 +14,7 @@ / {
>>   	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
>>   
>>   	aliases {
>> +		ethernet0 = &ethmac;
>>   		serial0 = &uart_a;
>>   		mmc0 = &sd_emmc_c;
>>   		mmc1 = &sd_emmc_b;
>> @@ -256,6 +257,33 @@ xtal: xtal-clk {
>>   	};
>>   };
>>   
>> +&ethmac {
>> +	status = "okay";
>> +	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
>> +	pinctrl-names = "default";
>> +
>> +	/*
>> +	 * The RGMII clock delays are added by the MAC, so the PHY is
>> +	 * asked for the mode that adds none.
>> +	 */
>> +	phy-mode = "rgmii";
> 
> In devicetree, "rgmii" means that the delays are inserted at the hardware
> level, i.e. with longer PCB traces for the clock. With the above comment,
> this is therefore wrong.
> 
> As a rule of thumb, "phy-mode = rgmii" is almost always wrong.
> 
> The right behaviour here is to represent the HW as it is, that is to say
> pass phy-mode = "rgmii-id"; delays are internal. In DT we don't say who
> inserts the delays (MAC or PHY), that's for the drive to figure out.
> 
> If the MAC inserts the delays, then it needs to fixup the mode passed to the PHY so that
> they follow this doc :
> 
> https://www.kernel.org/doc/html/v7.2/networking/phy.html#rg-mii-electrical-interface-considerations
> 
> Maxime
Hi Maxime,

Thanks for the review. You are right about what the mode names mean,
but after a few tests I do not think this board can follow it. I tried
all three:

   rgmii-id    23 of 23 received frames had a bad CRC, DHCP never
               completes.
   rgmii-txid  receive becomes perfect, but then the peer sees nothing
               we send, not even an error counter.
   rgmii       1Gbit/s, 930Mbit/s sustained, no error counter moving.

There was nothing to tune on the PHY side either: the RTL8211F delays
are single enable bits, TXCR bit 8 and RXCR bit 3, on or off.

The modes whose names promise internal delays are the same ones where
the glue switches its own off, so there is no value that is both right
by phy.rst and working here. Keeping "rgmii" and the comment, so the
next person sees why before trying it. Glad to help test and convert
this board if the driver's phy-mode handling is ever reworked along
with the other Amlogic boards.

Thanks,
Lucas

