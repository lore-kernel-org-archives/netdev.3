Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799751;
	b=TBGYrTSmXAkgWmuHVGwmaZ6caus+NyIB0H4bv0wuSZTNH3M3SP+b8jnJa3tMTo/fnhFu
	 SvtYcaTOsCgicEVlIdFWwpv+RCAwtVdA876kBrBu/Gt+B8DRvYYVWjGJNHHkB/2w0ivqx
	 2Px6/Z8BaICxEi6OL+K3kVFDcgmt03aMS0HNlSe4M+s9SmXeBbN1E1ECBD1mR1EFtwtWN
	 Wtxr0KkmjKlnGhz86/7v6X9Bd+USyXeiP1uiRUGvwuSBpuNEUw24g1KwQl+gecbDdZy5l
	 1sN9/w1/AXcRalJmSs5HHMO5jZkCxE9DO7hmwTJfd/2wWFjPQu+u+37EhI5s7Zx4cdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799751;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5ob+IWHtp5VQ73kBziQrxePkao0SVI0prmTDzChtEtY=;
	b=1IQexqudNvtKYsLEx6wc1pM2PSK1Ot7VZkdA4hFH9wsLjFchCkPJyvo+MU4LYGnfq2W7
	 6LAMaGZ2UMLwh7pibOmaVgRNdku27YLqpyl5cH4tqVRPrptnfV851+RQWvMEglm6w9xOg
	 HYEVSbfhC8t6AXXCrBpR/vHdiHNYngGL6q0P8UdYlecr1iR8PZ7wMAT+ayhJSLs6QF25R
	 Uo/56qoBufylAY/UuAYg/V/UfKGIHrJKuW2S+GWHnDcCDyFkdZzlS03LQJp/0gtTR+rtI
	 nEJj1u/6PLLgF1hS0xAgoWNMyaHzuFHAG2F4yC66uMvj0nW49nu22OnIT36vvZbyCxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzqFIyE7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4D8D8606A32C;
	Wed,  4 Nov 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzqFIyE7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 97DA71F000C1;
	Wed,  4 Nov 2026 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793799751;
	bh=5ob+IWHtp5VQ73kBziQrxePkao0SVI0prmTDzChtEtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MzqFIyE7I1IUaZVuwSDCt6moXxlHzOar1+gYPE3+HqiS8zaL5gYo6bqMe2u/GUfFa
	 8eLrEM//6tOAewQwiZ+6iVVALGjy8NV7L5+vNvG73SSSQKDYZwpiYasSyBS5sI79K6
	 Wh7Iw2p46GrJKXtNAjs5fbvDmr9Gha/5A0ETswvyP0bIlVyDgm11upROZhT+mkkMf1
	 5fYoa0psH6TTOC+QmkRyuwDIb04YFydZyqBcyz85CZfvWD3Q51++CGtYMWTrf/TmnS
	 4fBsB0NxT+3imoeGM4cXzyFN3w2Vk+3cFkmA6VwWL9iAOFilRpoTS2gKstYJ5cWEgU
	 ZZUcuCtRI+F+Q==
Date: Wed, 4 Nov 2026 14:42:27 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: lemans-sa8255p: add ethernet
 nodes
Message-ID: <ernvflqhg4dn7qot4enn2jltrstutagsnc2rcm2d2ngdujum2d@s4tik7l6funp>
References: <20261103-sa8255p-emac-dts-v2-0-05f9355df966@oss.qualcomm.com>
 <20261103-sa8255p-emac-dts-v2-2-05f9355df966@oss.qualcomm.com>
 <ausos--t6wJVzI9g@QCOM-aGQu4IUr3Y>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausos--t6wJVzI9g@QCOM-aGQu4IUr3Y>

On Wed, Nov 04, 2026 at 08:44:35PM +0800, Shawn Guo wrote:
> On Tue, Nov 03, 2026 at 11:42:00AM +0100, Bartosz Golaszewski wrote:
> > Add the ethernet nodes along with their serdes PHY nodes for the gearvm
> > variant of the lemans ride board. Enable scmi7 and scmi8 to serve the
> > EMACs.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi      |  30 ++++
> >  arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts | 207 +++++++++++++++++++++++
> >  2 files changed, 237 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi b/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
> > index 91c97a55f2787406b104650956b9a511a6a34c23..96a54f32f0eeb16dbce9802e74eec82622ecd35f 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
> > @@ -58,6 +58,18 @@ &cpufreq_hw {
> >  	clock-names = "xo", "alternate";
> >  };
> >  
> > +&ethernet0 {
> > +	compatible = "qcom,sa8255p-ethqos";
> > +	phys = <&serdes0>;
> > +	phy-names = "serdes";
> > +};
> > +
> > +&ethernet1 {
> > +	compatible = "qcom,sa8255p-ethqos";
> > +	phys = <&serdes1>;
> > +	phy-names = "serdes";
> > +};
> > +
> >  &firmware {
> >  	scmi0: scmi-0 {
> >  		compatible = "qcom,scmi-smc";
> > @@ -3218,6 +3230,24 @@ &uart21 {
> >  			     "perf";
> >  };
> >  
> > +&soc {
> > +	serdes0: phy@8901000 {
> > +		compatible = "qcom,sa8255p-dwmac-sgmii-phy";
> > +		reg = <0x0 0x08901000 0x0 0xe10>;
> > +		#phy-cells = <0>;
> > +		power-domains = <&scmi7_dvfs 0>;
> > +		status = "disabled";
> > +	};
> 
> We have the serdes node for Embedded variant as well.
> 
>         serdes0: phy@8901000 {
>                 compatible = "qcom,sa8775p-dwmac-sgmii-phy";
>                 reg = <0x0 0x08901000 0x0 0xe10>;
>                 clocks = <&gcc GCC_SGMI_CLKREF_EN>;
>                 clock-names = "sgmi_ref";
>                 #phy-cells = <0>;
>                 status = "disabled";
>         };
> 
> Per Nord discussion with Konrad [1], I plan to move serdes nodes back to
> common DTSI and let variant DTSI to supplement or overwrite properties
> as needed. Does that make sense?
>

Yes, it'll be in line with emac nodes. I'll wait for your next series
before resending this series.

Thanks,
Bartosz

PS Please try to trim your responses, don't include the entire long
patch if you're only commenting on a fragment of it.
