Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520D425880
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186530; cv=none; b=k7mnPUawQN4FlDTcYml4ZFFJza+YQJbWYI+HtbDjMLBM2gN5RhjpOYFkTSURQt7wU6A6PzQdMD3oBUHfztdJnRGUAW7QuCrVo+mfahtT1y7BssnCbiUJ9aPqBWxFoMQWyk/Mszw9++h2/VeFqYTgwuEpdowBrqy6FW5tBw6/IH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186530; c=relaxed/simple;
	bh=UKDBISzxFIl+nurq9kahLIQ0MAiK0ssSOXUcrGU43r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leR+mZcbnhvjNOSUxqlB+b3Y2mLPBoHyGYc5BgrNGy7qciwTdxfZplPTon6K2RVkcJ5dtmqMBepHvX1TiXmh/i/3tXQeBlUUpOFCBolS9FLY0Sxwb1DLQerT8AWEhDM2GRYcmgGdPVjl5uj0/om/tl2FB8568xIX2RYHBDurZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net; spf=pass smtp.mailfrom=pardini.net; dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.b=RgetEjO1; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pardini.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.b="RgetEjO1"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so185458266b.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pardini.net; s=google; t=1790186524; x=1790791324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DBO6ysXqxsewkyeoBpzt8RskMK/dx24xXh3/dEMcXyQ=;
        b=RgetEjO1W6XFfPhBre2KaXMu3r9p1IDeSumdheqMRlg4ca6JBRrOqy0se8sCq7bWrp
         EKQDHmeZyg7Ru0dLSX9fpygPgS04taJwX94uLWKxd1foddAW0lO2hdBVhVeP6sBpk0q7
         Dl5p08I4C3rwxy59k+drCRbKCSkgwFIvXFsDeJxk17eMBCkrtvrtSNb/Nk1A5y2ZR8xl
         3umsd40wL1n72qPml5mJOO1SSnqGdW1vi4TrkZg5SGwzniK/ilt87Ee4QJUfjYbYToRP
         ycMm3f1Gzq1Yprbb2ncsibYXbMfZT38Py9TwED73tKJVvckxhNeVZslpIDEMeu+Q5MxJ
         kMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790186524; x=1790791324;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DBO6ysXqxsewkyeoBpzt8RskMK/dx24xXh3/dEMcXyQ=;
        b=gzhUPV68gAB4B1rz3nbbSEyiGWIBKc8NTYAmBeTqKOkGjM/JWlBsdS/05VezREimfS
         Tb/h+eBh7sWJLZFi3+CQLBZoSxxUvGitF7VgcWIULm8hyNUsQwS+6KAI5mWwPh+hfR8Q
         PK+/L9eCn3SgvzHNOaYv3R3PrBKRYyui5silqLgagKArT4KoTZfdwTr19dPO8bRQ8yTJ
         Rpf2pPI9HUTB8nvCmeBH6TjMdbeb9SfRbCCtv6L9Z5Gj5Lje/siROr1CnWg/gcKnimyK
         0QOgmkbemXDvE06ZVgolmkxv8oWNZP8yGy25APYxo5uGmPSooHZM4tOZYU2bt9EMK4B2
         egjg==
X-Forwarded-Encrypted: i=1; AKwUvBxy7TWrg0JTwsnUvZv48sEU3/p0XugQNeQpjUWhxnIyJWuYe+BBZdVblZVq9KJxkTQfhD3JZs8=@vger.kernel.org
X-Gm-Message-State: AFuF++n+9mIPefSB131aKTVgA11UHBNazVOo/2/zgb/99VIt+j5Y9pIP
	29Lci9pnE+b1M4acy+/rxKI4hQOT/ko0e9lhaydYdlVXJsJ6LfJ6kyxLkyA47ovzeg==
X-Gm-Gg: AYBFou0zuANqCcI8gCL79iQlQQekd6ySPn1+pqsyb0vXxyxJJOpieAi12v+0+GW6mxz
	8j1NQQOVgf/KdOKAUwdeE5WDAkkAhhu59jcCQCqP2Zq0RKUj20PDbUqaqNpKUczzwIknTkkXuXB
	u76YgaVwifXLNczQYTx21HohcpH0sfApleC4pYLNxfVu+1hVUU6jD2nwZbRm1yOwkGPn623A8KE
	GMjSjc+jn08+WsptlEHiTzLS1l8hUe1AsId1tvIPRgl7uNHNyBhYhKi5VAZOf0Hd9kuEFW5YwUd
	keI/vS1ZhrjcdgwTtARBmBKUTi3q3aYBMXKe7dj+1aXpBVDor0jrej7ddHsVYu2EmxTHoYiHD32
	vzsyaUpSc1QGQfSB4ga7eAcO/O5ja68w4iJ11izkV1IJTcHuW4+V0TJGHsCaBfiesdQUFq3L7Z6
	/UoyB0ytJK++lKW2YdruKA5lyhvnr1XDETeD4f9TQRgbDjv6JdDHztNCacwfNO/n7NBuqDi2B3e
	CXs8pyeG2lYg9yC0SNdCwygEQs9bLqM1fG44fmtX8qtizmMzyGwQ5ao9P4ygSD7ELAk6d92ra89
	IdCWbgLjDQFiaflmb4hBpZJP5HfLxH9rcrP2Ul0yZad0rQ==
X-Received: by 2002:a17:907:9288:b0:c29:f5d8:9c6c with SMTP id a640c23a62f3a-c2aadc48f8dmr294406666b.27.1790186523723;
        Wed, 23 Sep 2026 11:02:03 -0700 (PDT)
Received: from ?IPV6:2a02:a466:4d7a:0:1072:bb1c:c0f3:280f? (2a02-a466-4d7a-0-1072-bb1c-c0f3-280f.fixed6.kpn.net. [2a02:a466:4d7a:0:1072:bb1c:c0f3:280f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f35sm166925266b.12.2026.09.23.11.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 11:02:02 -0700 (PDT)
Message-ID: <12e5e5ad-7d55-469d-a63e-d19e3279c6c1@pardini.net>
Date: Wed, 23 Sep 2026 20:02:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on NanoPi R5S
To: Diederik de Haas <diederik@cknow-tech.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
 <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-5-c1b9e5f10cd6@pardini.net>
 <DLMV5WTF5TR1.BXDY94L4J4H7@cknow-tech.com>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <DLMV5WTF5TR1.BXDY94L4J4H7@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2026 19:15, Diederik de Haas wrote:
> Hi,
> 
> On Thu Sep 10, 2026 at 10:07 PM CEST, Ricardo Pardini via B4 Relay wrote:
>> From: Ricardo Pardini <ricardo@pardini.net>
>>
>> The FriendlyElec NanoPi R5S (rk3568) carries two on-board Realtek
>> RTL8125 NICs behind pcie2x1 and pcie3x1, alongside the existing gmac0
>> RGMII PHY.
>>
>> Describe the fixed function nodes and attach ethernet1/ethernet2
>> aliases (ethernet0 stays mapped to gmac0), so that U-Boot's
>> fdt_fixup_ethernet() can inject mac-address properties from its
>> eth1addr/eth2addr env, for stable MACs across boots that both U-Boot
>> and the kernel agree on.
>>
>> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 30 ++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>> index 90ce6f0e1dcff..9ed11663c31c9 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>> @@ -15,6 +15,8 @@ / {
>>   
>>   	aliases {
>>   		ethernet0 = &gmac0;
>> +		ethernet1 = &rtl_eth1;
>> +		ethernet2 = &rtl_eth2;
>>   	};
> 
> With my NanoPi-R5S I'm still getting the following warning:
> 
>    r8169 0001:11:00.0: can't read MAC address, setting random one
> 
> ```
> root@nanopi-r5s:~# ip link
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: end1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
>      link/ether 4e:52:85:9e:22:f9 brd ff:ff:ff:ff:ff:ff
>      altname enp1s0
>      altname enx4e52859e22f9
> 3: end2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
>      link/ether 12:e5:47:9e:e2:f1 brd ff:ff:ff:ff:ff:ff
>      altname enP1p17s0
> 4: end0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>      link/ether 4e:52:85:9e:22:f8 brd ff:ff:ff:ff:ff:ff
>      altname enx4e52859e22f8
> ```
> 
> I did not do anything (explicitly) in U-Boot, but it seems it created a
> non-random MAC address for end0 and end1 ... and then stopped.
> AFAIK gmac0=end0 already had a non-random MAC address and I hoped/expected
> it would create non-random addresses for end1 and end2, which would've made
> the above warning go away too.
> 
> Is this an issue with this patch, with U-Boot or me?

Hi Diederik, in this case (3 ethernet's) I think it's down to U-boot.
Check the output of `printenv` in u-boot, you'll probably find it only 
pre-computes 2 MAC addresses, and doesn't feed the ethernet2 alias 
during its fdt_fixup_ethernet().

Try doing `setenv eth2addr xx:xx...` in u-boot before booting -- it 
should work. I think that's what I did when testing the R5S with this 
series, but it has been a very long time ago.

One way around this (without u-boot) would be to use Alexey's series [1] 
which could compute as many MACs as needed out of the CPU serialnum - 
but that also won't work as-sent vs rk356x, I believe he's checking an 
alternative proposed.

[1] 
https://lore.kernel.org/linux-rockchip/20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net/

> 
> Full details:
> https://paste.sr.ht/~diederik/8ae7d354985afcd1c3464e3a4ad81da1b4442364
> 
> Side note:
> I wonder how 'random' those addresses are as during testing ``ssh rock5b``
> landed me on another device (NanoPC-T6 Plus), f.e. My router has DHCP
> reservations based on MAC addresses and it looks like it got confused ;-)

Interesting. I dunno what seed is used, as I've been fully set on making 
it non-random, but I wouldn't discard the possibility of conflicts 
across different machines. One more reason to have this series ;-)

I'll soon send a v6 to linux-rockchip/dt (with small fixes Sashiko found 
to DTs, and without the binding) and split a single-patch v1 to net-next 
with only the binding, collecting Rob's review. If and when those land, 
we'd have open road both for u-boot local-mac-address and Alexey's 
nvmem-cells for the RTLs.

Regards,
Ricardo


> 
> Cheers,
>    Diederik
> 
>>   	gpio-keys {
>> @@ -107,6 +109,20 @@ &pcie2x1 {
>>   	num-lanes = <1>;
>>   	reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
>>   	status = "okay";
>> +
>> +	pcie@0,0 {
>> +		reg = <0x000000 0 0 0 0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +		device_type = "pci";
>> +		bus-range = <0x00 0x0f>;
>> +
>> +		rtl_eth1: ethernet@0,0 {
>> +			compatible = "pci10ec,8125";
>> +			reg = <0x010000 0 0 0 0>;
>> +		};
>> +	};
>>   };
>>   
>>   &pcie30phy {
>> @@ -119,6 +135,20 @@ &pcie3x1 {
>>   	reset-gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
>>   	vpcie3v3-supply = <&vcc3v3_pcie>;
>>   	status = "okay";
>> +
>> +	pcie@0,0 {
>> +		reg = <0x100000 0 0 0 0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +		device_type = "pci";
>> +		bus-range = <0x10 0x1f>;
>> +
>> +		rtl_eth2: ethernet@0,0 {
>> +			compatible = "pci10ec,8125";
>> +			reg = <0x110000 0 0 0 0>;
>> +		};
>> +	};
>>   };
>>   
>>   &pcie3x2 {
> 

