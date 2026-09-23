Received: from mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1D53D0D4
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188861; cv=none; b=MXJLnLETEHiqV66VeMjLzswrCIhdm2L8OahiRdDL69HhePOF2o2SoJP9wLDPdoT8leyOZlVwY47YwzOLYD3JeG+H6cRcg74DV4jWe4vWTiA93NxpNv3Ev3+R7s4s81YvMqDjn9M7pQAw9xSogKvmilZMnHoT1WewQixG+nLB4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188861; c=relaxed/simple;
	bh=KHltIsP16/D58QoS2DV7BJ0dfwy+AgfodY00vY+4j2w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cZW2ECpF9ieSRLvpOD0z9yjVC/bVPMxNcKGtYA7nNO1t8HbHjdMmJwnEC9Q+lMTsvIsvq6v9qEmADqcnonBl22vUQg0YXjsA2ykJLJt06KqeFfZI0+AsbxyBwtGxzdH0ihIWdCX99varTO6XPfXmPEL14b0pIaEQqsh1+/8lRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=LqmUBHEl; arc=none smtp.client-ip=95.215.58.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="LqmUBHEl"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KHltIsP16/D58QoS2DV7BJ0dfwy+AgfodY00vY+4j2w=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790188851; v=1; x=1790793651;
 b=LqmUBHElxdjwZqJAjAC+wzS2hQA3pIfJXEugnSX3sVWkDfhxAoCftVJSyq0Po+J2uSGWppaT
 pCY+hcYJ+cZsptCvzKiqGV6jstKsAH1IYgqroU6nrdifbGASNpfyNA7vpDoTl4x8RRomr3QeLdU
 pM/lk0fjBn5IZB/Dx3zSNaP5vJpDu1D4WGJ8fq/dJWbbwqCKPyVp+msanb1sJJeavNweTxGqMCe
 uWklVQxYFXozpE95kjYMJqNEHitptBnzMfVvc+rdoEIuJIimUXGQzuZ8Uiv/suSaGB46Ii19nMW
 5N5ZTZ7KBYAkPOy+9jhkkJ1Tu8oQu+KdVrdl0ya2e2vcg==
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b3c24cb28d2361dc;
	Wed, 23 Sep 2026 18:40:51 +0000
X-Mizu-Trace-ID: b3c24cb28d2361dc
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 20:40:50 +0200
Message-Id: <DLMWZGK72FK2.22X7CQ2WIY9A@cknow-tech.com>
Cc: "Sebastian Reichel" <sebastian.reichel@collabora.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH v5 5/7] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on NanoPi R5S
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Ricardo Pardini" <ricardo@pardini.net>, "Diederik de Haas"
 <diederik@cknow-tech.com>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 <nic_swsd@realtek.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
X-Mailer: aerc 0.22.0-24-g39041fd9f179
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net> <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-5-c1b9e5f10cd6@pardini.net> <DLMV5WTF5TR1.BXDY94L4J4H7@cknow-tech.com> <12e5e5ad-7d55-469d-a63e-d19e3279c6c1@pardini.net>
In-Reply-To: <12e5e5ad-7d55-469d-a63e-d19e3279c6c1@pardini.net>

Hi Ricardo,

On Wed Sep 23, 2026 at 8:02 PM CEST, Ricardo Pardini wrote:
> On 23/09/2026 19:15, Diederik de Haas wrote:
>> On Thu Sep 10, 2026 at 10:07 PM CEST, Ricardo Pardini via B4 Relay wrote=
:
>>> From: Ricardo Pardini <ricardo@pardini.net>
>>>
>>> The FriendlyElec NanoPi R5S (rk3568) carries two on-board Realtek
>>> RTL8125 NICs behind pcie2x1 and pcie3x1, alongside the existing gmac0
>>> RGMII PHY.
>>>
>>> Describe the fixed function nodes and attach ethernet1/ethernet2
>>> aliases (ethernet0 stays mapped to gmac0), so that U-Boot's
>>> fdt_fixup_ethernet() can inject mac-address properties from its
>>> eth1addr/eth2addr env, for stable MACs across boots that both U-Boot
>>> and the kernel agree on.
>>>
>>> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
>>> ---
>>>   arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 30 +++++++++++++=
+++++++++
>>>   1 file changed, 30 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/=
arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>>> index 90ce6f0e1dcff..9ed11663c31c9 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>>> @@ -15,6 +15,8 @@ / {
>>>  =20
>>>   	aliases {
>>>   		ethernet0 =3D &gmac0;
>>> +		ethernet1 =3D &rtl_eth1;
>>> +		ethernet2 =3D &rtl_eth2;
>>>   	};
>>=20
>> With my NanoPi-R5S I'm still getting the following warning:
>>=20
>>    r8169 0001:11:00.0: can't read MAC address, setting random one
>>=20
>> ```
>> root@nanopi-r5s:~# ip link
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode=
 DEFAULT group default qlen 1000
>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 2: end1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel sta=
te DOWN mode DEFAULT group default qlen 1000
>>      link/ether 4e:52:85:9e:22:f9 brd ff:ff:ff:ff:ff:ff
>>      altname enp1s0
>>      altname enx4e52859e22f9
>> 3: end2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel sta=
te DOWN mode DEFAULT group default qlen 1000
>>      link/ether 12:e5:47:9e:e2:f1 brd ff:ff:ff:ff:ff:ff
>>      altname enP1p17s0
>> 4: end0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mo=
de DEFAULT group default qlen 1000
>>      link/ether 4e:52:85:9e:22:f8 brd ff:ff:ff:ff:ff:ff
>>      altname enx4e52859e22f8
>> ```
>>=20
>> I did not do anything (explicitly) in U-Boot, but it seems it created a
>> non-random MAC address for end0 and end1 ... and then stopped.
>> AFAIK gmac0=3Dend0 already had a non-random MAC address and I hoped/expe=
cted
>> it would create non-random addresses for end1 and end2, which would've m=
ade
>> the above warning go away too.
>>=20
>> Is this an issue with this patch, with U-Boot or me?
>
> Hi Diederik, in this case (3 ethernet's) I think it's down to U-boot.
> Check the output of `printenv` in u-boot, you'll probably find it only=20
> pre-computes 2 MAC addresses, and doesn't feed the ethernet2 alias=20
> during its fdt_fixup_ethernet().

It's indeed what I suspected. I don't dabble in U-Boot very often, but I se=
em
to recall it has fixed room for 2 MAC addresses and that would explain the
symptom/problem I described.

> Try doing `setenv eth2addr xx:xx...` in u-boot before booting -- it=20
> should work. I think that's what I did when testing the R5S with this=20
> series, but it has been a very long time ago.

I'm going to give it a try and see what happens.

> One way around this (without u-boot) would be to use Alexey's series [1]=
=20
> which could compute as many MACs as needed out of the CPU serialnum -=20
> but that also won't work as-sent vs rk356x, I believe he's checking an=20
> alternative proposed.
>
> [1]=20
> https://lore.kernel.org/linux-rockchip/20260902-rk3576-otp-cpuid-mac-v2-0=
-e4b7fe2ab13f@flipper.net/

Haha! You linked in that thread to Heiko's RK356X OTP patch set and I teste=
d
that hoping/assuming that could help with generating unique MAC addresses.
I see (or think I do) pieces of the puzzle, but I don't know how they all
fit together.

>> Full details:
>> https://paste.sr.ht/~diederik/8ae7d354985afcd1c3464e3a4ad81da1b4442364
>>=20
>> Side note:
>> I wonder how 'random' those addresses are as during testing ``ssh rock5b=
``
>> landed me on another device (NanoPC-T6 Plus), f.e. My router has DHCP
>> reservations based on MAC addresses and it looks like it got confused ;-=
)
>
> Interesting. I dunno what seed is used, as I've been fully set on making=
=20
> it non-random, but I wouldn't discard the possibility of conflicts=20
> across different machines. One more reason to have this series ;-)

They all use the RTL8125BG and I suspect that plays a role in it.

> I'll soon send a v6 to linux-rockchip/dt (with small fixes Sashiko found=
=20
> to DTs, and without the binding) and split a single-patch v1 to net-next=
=20
> with only the binding, collecting Rob's review. If and when those land,=
=20
> we'd have open road both for u-boot local-mac-address and Alexey's=20
> nvmem-cells for the RTLs.

Awesome, thanks :-)

Cheers,
  Diederik

> Regards,
> Ricardo
>
>
>>=20
>> Cheers,
>>    Diederik
>>=20
>>>   	gpio-keys {
>>> @@ -107,6 +109,20 @@ &pcie2x1 {
>>>   	num-lanes =3D <1>;
>>>   	reset-gpios =3D <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
>>>   	status =3D "okay";
>>> +
>>> +	pcie@0,0 {
>>> +		reg =3D <0x000000 0 0 0 0>;
>>> +		#address-cells =3D <3>;
>>> +		#size-cells =3D <2>;
>>> +		ranges;
>>> +		device_type =3D "pci";
>>> +		bus-range =3D <0x00 0x0f>;
>>> +
>>> +		rtl_eth1: ethernet@0,0 {
>>> +			compatible =3D "pci10ec,8125";
>>> +			reg =3D <0x010000 0 0 0 0>;
>>> +		};
>>> +	};
>>>   };
>>>  =20
>>>   &pcie30phy {
>>> @@ -119,6 +135,20 @@ &pcie3x1 {
>>>   	reset-gpios =3D <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
>>>   	vpcie3v3-supply =3D <&vcc3v3_pcie>;
>>>   	status =3D "okay";
>>> +
>>> +	pcie@0,0 {
>>> +		reg =3D <0x100000 0 0 0 0>;
>>> +		#address-cells =3D <3>;
>>> +		#size-cells =3D <2>;
>>> +		ranges;
>>> +		device_type =3D "pci";
>>> +		bus-range =3D <0x10 0x1f>;
>>> +
>>> +		rtl_eth2: ethernet@0,0 {
>>> +			compatible =3D "pci10ec,8125";
>>> +			reg =3D <0x110000 0 0 0 0>;
>>> +		};
>>> +	};
>>>   };
>>>  =20
>>>   &pcie3x2 {
>>=20


