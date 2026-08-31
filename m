Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC339DBE5;
	Mon, 31 Aug 2026 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195679; cv=none; b=fTeE1fOQjnW//TS0d/aVtmhuKLQAwEJvWZ3C9U0Ql0nQEA3iLceWslbabS9brlI8coDsmIzTS3YbXkGpyAkNFMEq0rFmW/btxsRuAmnydLW9OWf/4mP/JiBgRHLeymJv80IUG6XOr+rbituKHeNUH+tuculb37Oh5iIWuwSsQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195679; c=relaxed/simple;
	bh=bRQmaVK5YtPc9OyhbJlSSLkDRzpF1K/eb8Kd9SdfqB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GShTXfVbiGedbDWqF+Rn7ytNtx1ECEKQkR2tXN/jD1hxWAFLg2XIn64Oj1ewAjluE9vKRDasUrliGutZiDQ6mdnMEPmR7vuUvLJ8T11Cx5KzUlU1rjWephXA9HJhB/mwepMvx/FgHA3Njd1sf49h707puAuLERgxQOrUBFTARuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CQrF/Ej3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CQrF/Ej3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 195B54E4146D;
	Mon, 31 Aug 2026 17:01:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D938860231;
	Mon, 31 Aug 2026 17:01:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D87111C791C9;
	Mon, 31 Aug 2026 19:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788195672; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NeMX3TyIVgiWv0EHpllg7BARTZozM1wKfOdY7ITpCSQ=;
	b=CQrF/Ej30jVPaNnk9wov2SvTuyLFk4VzE9ygj76VdqnEPfF1aND5Yvpc0cLjIUPM/cQQnR
	RsPZ1ctIAyUR4PD/0V+TWEtajDw3WzOECJHmqXVtAa2q9UYL1gYiluTgdODsKbcqxZdy/A
	uhHxEfUYh624qacTBT1kjC8BBhquwpgSkTdxGO0VqjrEbs2W67rPw1ruG/UwyUwwVfxx6Q
	iXz5WGtqpbSIBIBg1FE8IogG9bavMTphVYll5Quke4vvzd6MpSMN7ATOG4DOp/X/nv+OMx
	U801DB1uCIWxhMoSVDFR1lEY1UNWwOlQeh3cmV8HDupzJW2rpZoCzjqr6QLRUw==
Message-ID: <b36109c3-00e5-434e-a9b7-46049b0bff40@bootlin.com>
Date: Mon, 31 Aug 2026 19:01:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/9] net: stmmac: qcom-ethqos: fix RGMII_ID mode to
 use DLL bypass
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-3-f0f4a1d19929@oss.qualcomm.com>
 <42355330-c22a-4fce-98ab-dc22b321ff16@lunn.ch>
 <ai93X/cNWHtEQsDt@oss.qualcomm.com>
 <82705420-771d-41bf-a4d9-ed94dff86ff0@lunn.ch>
 <ajF6q5eKz92ddqVl@oss.qualcomm.com> <apU8Yx08/PJiS9Xw@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <apU8Yx08/PJiS9Xw@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Mohd,

On 8/31/26 10:33, Mohd Ayaan Anwar wrote:
> Hi Andrew,
> 
> On Tue, Jun 16, 2026 at 10:02:51PM +0530, Mohd Ayaan Anwar wrote:
>> On Mon, Jun 15, 2026 at 06:48:55PM +0200, Andrew Lunn wrote:
>>>>> I'm curious how this works at the moment? Do no boards make use of
>>>>> RGMII ID? Are all current boards broken?
>>>>
>>>> Searching through the DTS, I found that we have two boards using "rgmii"
>>>> (qcs404-evb-4000.dts and sa8155-adp.dts) and another board using
>>>> "rgmii-txid" (sa8540p-ride.dts). No board which uses RGMII ID.
>>>
>>> So this causes problems. We cannot break existing boards, yet it would
>>> be good to fix the current broken behaviour.
>>
>> I am trying to track down the sa8155-adp and sa8540p-ride boards. The
>> EMAC on QCS404 is extremely similar to QCS615 Ride [0], and I got that
>> board to work with this series (with RGMII ID mode). So I am fairly
>> confident that QCS404 would not break (if its even booting up with the
>> upstream kernel currently). Also, I think we could change the phy-mode
>> for QCS404 to "rgmii-id" from "rgmii" if these fixes go in.
>>
>>> It could be the best way forward is that you issue a warning when
>>> "rgmii" is found and pass rgmii-id to the PHY. And you also change the
>>> two boards to use rgmii-id. Lets think about the rgmii-txid case once
>>> we better understand it.
>>>
>>
>> As Konrad mentioned, it would be great to know if we can test out these
>> boards. Looking at the different versions of the ETHQOS programming
>> guide, stopping MAC side delay should be as simple as what we are doing
>> in this commit. But whether the two boards work directly with the
>> default PHY delays is unknown.
>>
> 
> So I did find the sa8540p-ride board but have so far been unsuccessful
> in getting it to boot. While that goes on, I would like to proceed with
> a series to fix RGMII on qcom-ethqos due to the following reasons:
> 
>  1. All versions of programming guides give a programming sequence for
>  MAC-side delay or PHY-side delay. There is no concept of "rgmii-txid".
> 
>  2. I also found some downstream code that was using "rgmii" phy-mode to
>  program MAC-side delays on the sa8540p-ride board. So it looks like
>  "rgmii-txid" was a workaround to enable ethernet while support for
>  this board was being upstreamed.
> 
>  3. I have been able to test this patch on a variety of boards now,
>  including:
>      - Shikra CQ/IQ variants (with the TI DP83867 PHY)
>      - QCS615 Ride (with the Micrel KSZ9031 PHY)
>      - Talos EVK (again with the Micrel KSZ9031 PHY)
>      - Talos Lyra (with the TI DP83867 PHY)
>  These platforms cover the two RGMII configurations that Qualcomm has
>  typically deployed.

I've been able to get my hands on a qualcomm devkit for ipq8064 :

Compex WPQ864 6A02, has the IPQ8064 connected to a QCA8337 switch
through both the ports, one using RGMII (no ID), and one with SGMII.

The DT is downstream, in OpenWRT :

https://git.openwrt.org/openwrt/openwrt/tree/target/linux/ipq806x/dts/qcom-ipq8064-ap148.dts#n198

happy to help in some testing as well if needed, this board is going
in my CI for stmmac stuff.

> 
> With this in mind, I was thinking of breaking up this patch series into
> separate ones to solve one problem at a time:
> 
>  1. Introduce support for "rgmii-id" using PHY-side delays rather than
>  MAC-provided delays. Also, issue a warning if any other phy-mode is
>  being used.
> 
>  2. Fix the DTS of the existing boards to use "rgmii-id".
> 
>  3. Once the DTS is fixed, remove the now-unused code handling non
>  RGMII-ID cases. This should also allow us to remove the whole
>  ethqos_emac_por code since it wouldn't be needed for RGMII-ID.

I'm wondering if we should add some temporary very loud warning for
boards that use "rgmii" before changing this, or even just keep the
actual "rgmii" behaviour which inserts the delays, as there seems to
be lots of such users...

This is going to be quite the breaking change.

> 
>  4. Add support for regulator voting in the DP83867 driver, mirroring
>  what Daniel Thompson/ Alex Elder did for QCA8081 [1]. This will help
>  in adding support for the Shikra/Talos Lyra boards which need the
>  supply for the PHY to be explicitly enabled.
> 
>  5. Support for Shikra can be added once these changes are in.
> 
> Does this plan sound reasonable? Thanks.
> 
> 	Ayaan
> ---
> [1] https://lore.kernel.org/netdev/20260605010022.968612-3-elder@riscstar.com/
> 

Maxime
