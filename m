Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A43CB555
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120351; cv=none; b=kwwHdNC+wKABTaKFB/jEJ+ZeJ5nTNWcOjTgfZZhEz9UFyKelfuI/KxIkkz93FzboxFgNTWW7RD1xQOjYEFOKEuFL9E5G8NqLHPwFO1pPOzuF0bc9rmCHKwBADuzujQ9ARAXp5Tg/oCCmlyPd5jKT+mcKsGIHwk9gCXnQLx4xbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120351; c=relaxed/simple;
	bh=23/ENQ5gA857upXkBJbmjsuGG+iGltANLDGDlezshT4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HFswPbG7WHlWEvooobUFM0lHK7IdN4I5j+iqPnwT7k6iQA/xTYCI87m6+EMOsKoTseo1lFgrkrAl5o0haO9e2EQfcYcCAXVyZtr/G1tlT3LCAojDxkKPqPdRZyY6a4GOR86K6ba4xcCLWsctAVygEvrt49FYqLYKR0Ay71TIG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=Y47QMUxn; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="Y47QMUxn"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=23/ENQ5gA857upXkBJbmjsuGG+iGltANLDGDlezshT4=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789120346; v=1; x=1789725146;
 b=Y47QMUxn0TKeXOuEheK0ycl9t9263+tQ83GEl/ItuBW7+Hyc+Qpz6IVPyLsGQYkCU6KCAiid
 gVj7eAaobAmg1BIf/3Cqy6LDdUh4cYf5lYUkdpgh/cNGRZNNhHWHr8PbWmlbGedcFVtgDcG/Qz4
 /Vjj75ZDfz5dORvuzFbMqknb4iAurd1fFuI0iXpc1JZNfVlv7WYUGFqO05h1mxSvxN4XlbvTUlF
 oD36TemK2ca0ixXx6RNDDaFU24W1G+JYQ/0yLso8vvx9DrvpLLkfpChyFjZHcetef0KdawHKcd8
 dYKERR6JsSnROndHTel9FtB0duUJNGL44M+JFIQpFKQoA==
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 336b87e032570366;
	Fri, 11 Sep 2026 09:52:26 +0000
X-Mizu-Trace-ID: 336b87e032570366
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 11:52:24 +0200
Message-Id: <DLCE8BRWYCBL.2UH33L4RQMAGN@cknow-tech.com>
Cc: "Sebastian Reichel" <sebastian.reichel@collabora.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v5 2/7] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on NanoPC-T6
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: <ricardo@pardini.net>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 <nic_swsd@realtek.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
X-Mailer: aerc 0.22.0-9-ge948bb7230f4
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net> <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-2-c1b9e5f10cd6@pardini.net>
In-Reply-To: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-2-c1b9e5f10cd6@pardini.net>

On Thu Sep 10, 2026 at 10:07 PM CEST, Ricardo Pardini via B4 Relay wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
>
> The FriendlyElec NanoPC-T6 carries two on-board Realtek RTL8125 NICs
> behind pcie2x1l0 and pcie2x1l2.
>
> Describe the fixed function nodes and attach ethernet0/ethernet1
> aliases, so that U-Boot's fdt_fixup_ethernet() can fill in the MAC
> from its ethaddr/eth1addr env. The on-NIC EEPROMs on this board are
> not pre-programmed with a unique MAC, so this gives a stable MAC
> across boots that both U-Boot and the kernel agree on.
>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 30 ++++++++++++++++=
++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> index cfdb5c13f8606..550358a756618 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> @@ -20,6 +20,8 @@ / {
>  	compatible =3D "friendlyarm,nanopc-t6", "rockchip,rk3588";
> =20
>  	aliases {
> +		ethernet0 =3D &rtl_eth0;
> +		ethernet1 =3D &rtl_eth1;
>  		mmc0 =3D &sdhci;
>  		mmc1 =3D &sdmmc;
>  	};
> @@ -644,6 +646,20 @@ &pcie2x1l0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pcie2_0_rst>;

The new pinctrl reference is ``pcie_25glan_perstb_b_pin``, so this patch ne=
eds
to be rebased.

>  	status =3D "okay";
> +
> +	pcie@0,0 {
> +		reg =3D <0x200000 0 0 0 0>;
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		device_type =3D "pci";
> +		bus-range =3D <0x21 0x2f>;
> +
> +		rtl_eth0: ethernet@0,0 {
> +			compatible =3D "pci10ec,8125";
> +			reg =3D <0x210000 0 0 0 0>;
> +		};

Described on page 23 of the schematic titled '2.5G Ethernet B' and ``U12``
(ie RTL8125BG) is connected to LAN2 which has ``ETH2`` as label on the case=
.

> +	};
>  };
> =20
>  &pcie2x1l1 {
> @@ -660,6 +676,20 @@ &pcie2x1l2 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pcie2_2_rst>;

The new pinctrl reference is ``pcie_25glan_perstb_pin``.

>  	status =3D "okay";
> +
> +	pcie@0,0 {
> +		reg =3D <0x400000 0 0 0 0>;
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		device_type =3D "pci";
> +		bus-range =3D <0x41 0x4f>;
> +
> +		rtl_eth1: ethernet@0,0 {
> +			compatible =3D "pci10ec,8125";
> +			reg =3D <0x410000 0 0 0 0>;
> +		};

Described on page 22 of the schematic titled '2.5G Ethernet A' and ``U10``
(ie RTL8125BG) is connected to LAN1 which has ``ETH1`` as label on the case=
.

So this results in:
ETH1 -> rtl_eth1
ETH2 -> rtl_eth0

This sounds like a recipe for confusion and/or potential future mistakes.
I think using ``rtl_eth1`` and ``rtl_eth2`` would be less confusing, but
I'm fine with another construct which achieves a similar thing.

Cheers,
  Diederik

> +	};
>  };
> =20
>  &pcie30phy {


