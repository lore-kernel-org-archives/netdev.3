Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302FF3905E3
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183751; cv=none; b=Cvgp+fI/KkTB1VQTbwpjoo6ofSDRzaIY15vhdxV0T2U9ZkSOIYT9ypEuNOcC5nWTnOkkRoRcQghZ4RCiduDfdifDHMroI0IR1IlunJXrd/4ze5+UcbXvRDhdOfkGg7alfwyoRoAOZs9zFibSXgVj8xzFwVt+1Pe86M3l6ru7BVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183751; c=relaxed/simple;
	bh=jxGuprUYi106B5t11FFkgi+yqb+rQeyTVQAW+p12YwA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EsqIoNvdeyIfd4mKOxIP1BLxAASTcXC7sQgbKf6PIYe8wdfWChQuKmewpPa7qYJ9IUgh8kCYtvhxNvgeYVb0wRPZeYMmlAw7+dmzDqDMgnYtatuF+qNen9Fr15ytDcl2KlcqidqmU42zxuQelX81fGcQ9vSbIHGk3ZyOSAeNAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=ZVe0P3h1; arc=none smtp.client-ip=91.218.175.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="ZVe0P3h1"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jxGuprUYi106B5t11FFkgi+yqb+rQeyTVQAW+p12YwA=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790183736; v=1; x=1790788536;
 b=ZVe0P3h1vL/8qbgOqkx72olxY4ujSROqjM5GA/cl7qJF6JFSNt2gDq2Pzo1UvKljCgDNsOkA
 u0rlqhNm2fR3+NuPptvnQV1bAWCpK6jEUOqfEW/oqZ95g9e/cmfCSQs1u7f8QfvAfT1b8Xsbjde
 B0BNy5tQfRQSRdFPaJ6bmH7++YW9IyvUL+eMHXgaBBbBUiqSey1YABoPxKuX03yKhxhypFrd1Xg
 Yn/ldhH/mCSv4TOFo+JpYYMZ1w7fFKLyEE25rzRj5s5RT6+eOt2QL2u8EUkEK6Gaae0GHzoJzbr
 2ThwUJ0DqxwMQkKG6K5FDaxBmAskcbxYzBMGFbqUlrvTg==
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6f9c8085352aaf04;
	Wed, 23 Sep 2026 17:15:17 +0000
X-Mizu-Trace-ID: 6f9c8085352aaf04
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 19:15:13 +0200
Message-Id: <DLMV5WTF5TR1.BXDY94L4J4H7@cknow-tech.com>
Cc: "Sebastian Reichel" <sebastian.reichel@collabora.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH v5 5/7] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on NanoPi R5S
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: <ricardo@pardini.net>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 <nic_swsd@realtek.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
X-Mailer: aerc 0.22.0-24-g39041fd9f179
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net> <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-5-c1b9e5f10cd6@pardini.net>
In-Reply-To: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-5-c1b9e5f10cd6@pardini.net>

Hi,

On Thu Sep 10, 2026 at 10:07 PM CEST, Ricardo Pardini via B4 Relay wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
>
> The FriendlyElec NanoPi R5S (rk3568) carries two on-board Realtek
> RTL8125 NICs behind pcie2x1 and pcie3x1, alongside the existing gmac0
> RGMII PHY.
>
> Describe the fixed function nodes and attach ethernet1/ethernet2
> aliases (ethernet0 stays mapped to gmac0), so that U-Boot's
> fdt_fixup_ethernet() can inject mac-address properties from its
> eth1addr/eth2addr env, for stable MACs across boots that both U-Boot
> and the kernel agree on.
>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 30 ++++++++++++++++=
++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/ar=
m64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> index 90ce6f0e1dcff..9ed11663c31c9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> @@ -15,6 +15,8 @@ / {
> =20
>  	aliases {
>  		ethernet0 =3D &gmac0;
> +		ethernet1 =3D &rtl_eth1;
> +		ethernet2 =3D &rtl_eth2;
>  	};

With my NanoPi-R5S I'm still getting the following warning:

  r8169 0001:11:00.0: can't read MAC address, setting random one

```
root@nanopi-r5s:~# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DE=
FAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: end1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state =
DOWN mode DEFAULT group default qlen 1000
    link/ether 4e:52:85:9e:22:f9 brd ff:ff:ff:ff:ff:ff
    altname enp1s0
    altname enx4e52859e22f9
3: end2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state =
DOWN mode DEFAULT group default qlen 1000
    link/ether 12:e5:47:9e:e2:f1 brd ff:ff:ff:ff:ff:ff
    altname enP1p17s0
4: end0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode =
DEFAULT group default qlen 1000
    link/ether 4e:52:85:9e:22:f8 brd ff:ff:ff:ff:ff:ff
    altname enx4e52859e22f8
```

I did not do anything (explicitly) in U-Boot, but it seems it created a
non-random MAC address for end0 and end1 ... and then stopped.
AFAIK gmac0=3Dend0 already had a non-random MAC address and I hoped/expecte=
d
it would create non-random addresses for end1 and end2, which would've made
the above warning go away too.

Is this an issue with this patch, with U-Boot or me?

Full details:
https://paste.sr.ht/~diederik/8ae7d354985afcd1c3464e3a4ad81da1b4442364

Side note:
I wonder how 'random' those addresses are as during testing ``ssh rock5b``
landed me on another device (NanoPC-T6 Plus), f.e. My router has DHCP
reservations based on MAC addresses and it looks like it got confused ;-)

Cheers,
  Diederik

>  	gpio-keys {
> @@ -107,6 +109,20 @@ &pcie2x1 {
>  	num-lanes =3D <1>;
>  	reset-gpios =3D <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
>  	status =3D "okay";
> +
> +	pcie@0,0 {
> +		reg =3D <0x000000 0 0 0 0>;
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		device_type =3D "pci";
> +		bus-range =3D <0x00 0x0f>;
> +
> +		rtl_eth1: ethernet@0,0 {
> +			compatible =3D "pci10ec,8125";
> +			reg =3D <0x010000 0 0 0 0>;
> +		};
> +	};
>  };
> =20
>  &pcie30phy {
> @@ -119,6 +135,20 @@ &pcie3x1 {
>  	reset-gpios =3D <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply =3D <&vcc3v3_pcie>;
>  	status =3D "okay";
> +
> +	pcie@0,0 {
> +		reg =3D <0x100000 0 0 0 0>;
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		device_type =3D "pci";
> +		bus-range =3D <0x10 0x1f>;
> +
> +		rtl_eth2: ethernet@0,0 {
> +			compatible =3D "pci10ec,8125";
> +			reg =3D <0x110000 0 0 0 0>;
> +		};
> +	};
>  };
> =20
>  &pcie3x2 {


