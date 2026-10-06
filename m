Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D583BCD17
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294952; cv=none; b=LAM6DYqvkk5isCRFEpfreId3WnP/YyEStp+FpgtMseKOK6FctX38D0mSIZU1oDNK619T4Ih0R2EgWZ68Vb9HeHoDs3rDbj3ZxUfixPMAwWMdFAiQSw/FR9c32cL7JEgG6Os+qo82ADwKPhtKJ0lOdARfjYt9jkhS68NCKxVr/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294952; c=relaxed/simple;
	bh=EfsknO+e8STbS4VH4mYbE6xCJxLHJAuPON4fbSQTRAc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WRaHEBBwOj2YIAXisrxFEuz8gKUOBiuoSHJZhRLNQOxQBv+bIlAwQv0dMMw6N1V/PH4HIGx0fJnjKwPQ0hXnGwkg+A+ECq4QStVzj1nyOrNEDff+lIuVjtvizbVweCp0xFqwS/05zILsBOnqUEq548bHYJSWhy77sV+dNbxFPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SihA87bu; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SihA87bu"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a854dffb5dso377651a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791294950; x=1791899750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Id6lH5GTy+yyaEPTm6FcZZ7BLsleqqnI80GvEmpDvAs=;
        b=SihA87buQeKBBcothTaDqfgAwjht2ZE9cMOLP8+CISRwbagc9qvCiiTdfhLLYl+CSQ
         Dsqd9er9K3+MhCqMEaLfTsXUgCPLMa9953obiHiabEOKFF7aw+Bmk36CyBTYsJMhv0Py
         i/PnM3QI2dxZhRPOuKKaMlvykoDhzmgQ1aK67H+xdj8NstPzzZisWbgq5wVr/PJuPi3t
         Ht5dIsfLcJB2BPQzIwS8mqDKSCsVrhPHNit7IR9qIGqUmdFEaEL/frgYdLi49G81Wgci
         FxPc3g9iQz91+dDTJjsCKGA94NfHocsqqA/ruQkiK0LI/2v/rKH+MR2g2sjWgVc2PjZA
         wBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294950; x=1791899750;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Id6lH5GTy+yyaEPTm6FcZZ7BLsleqqnI80GvEmpDvAs=;
        b=0rJ11zzvaDUEWzUIpZmWFeHh+REW9DCo5z01c2tSczjaO+Q6VAMZMAD5RuA885qBRp
         o9g5qewLEF5EDbHGEUo2GzBOwY1kQp9pZstKAtJuciiy1Tc0pCXSdkhzHqq7OobBptgg
         A+ZEgBAFGFJVYM4exs3rfHfkULTnp32ysrsvBbhPTpNEWrA/KQIBQRE7ZAUeqBx2HKiM
         HLrEdJe0DllLDKUt78RYL3i+RPi+ltb9TmYs4rQnmMlcvai/jPHBmpdCMPwLq1qQcsWi
         P3pY6gDFauyvcZlKI5jmkG70zUgqIdQScouoif9lh360MJAQl2xXuYA7lotRnTpIKlNm
         pF4g==
X-Forwarded-Encrypted: i=1; AKwUvBySih7Ago2fdt+oEtKLRAEaK8rw49KS/WlQVavQypd/xc50G7CBHFrkBdzjX4PRd3ly0ngmv2c=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2sba8jOW8O9cokovj8mVyqjz+SlzGDS27zdq8Wo0I1eLNfAVV
	RP2FHiU/kKl8xIvdb3o31h+9WtIfTXj/BsT1DPrThrNfXB84VTRD6ThT
X-Gm-Gg: AYBFou3uuJAdEBHu7q9JT/XUgOl1/TpMWWKpGPxtZlwWoBxyVLTORMTzYnEKXoTd73Y
	cGSoD38gQuSZhpK5t5XL8Ds1CLof19NYiyv5u4t+B7qTwRNa172/GJO/mSPWFNhGvNhipNl/xTj
	sHmnGRk4HhsNV1gGIFaKiu3D3bHaKEEpZz9/ilP4qTDXPwErFcuGJS8Q25aCL94g2QwPp22S/gm
	lK1q5e9w4FURqWwa4S1h68EXuC4HNB+llT7WIkvPPIVwk7f/TJHJjTsuqfmQcCv5dlzn7pJo/2q
	cAKAFCoWDbXAK9wenYR2tHncgj3PVHs3zIfD1mKsSYwA0mpJj1x2JODnKuK71XnBEmr5pplI+MV
	t2+0co1YYiOZOi2JBVeK/RlsJeLMVf7Y6dP2F4rtPQMmjvwCMXW6amIU5h+8kHVUPk5Eh9jEhGN
	mbUTPex11UYIeIXTERfDdr5qiqAPXYEDXp+eAffy9/LVhe5B3y7NV+XYgjhpVRJNUXYnw=
X-Received: by 2002:a17:90b:4c4e:b0:3a7:eb0:119e with SMTP id 98e67ed59e1d1-3a873554164mr844006a91.21.1791294949932;
        Tue, 06 Oct 2026 06:55:49 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2603:c021:8000:9500:233::14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ccf99acacb2sm1189776a12.22.2026.10.06.06.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 06:55:49 -0700 (PDT)
Date: Tue, 06 Oct 2026 21:55:41 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Rob Herring <robh@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v10_4/6=5D_dt-bindings=3A?=
 =?US-ASCII?Q?_net=3A_rockchip-dwmac=3A_document_pcs-handle?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20261006134802.GA1916640-robh@kernel.org>
References: <20261005223011.1124347-1-coiaprant@gmail.com> <20261005223011.1124347-5-coiaprant@gmail.com> <20261006134802.GA1916640-robh@kernel.org>
Message-ID: <F86D938C-01FF-4398-B4A3-69EF2404FB72@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 6, 2026 9:48:02 PM GMT+08:00, Rob Herring <robh@kernel=2Eorg> wr=
ote:
>On Tue, Oct 06, 2026 at 06:30:06AM +0800, Coia Prant wrote:
>> The Rockchip GMAC binding needs to describe the PCS reference used by
>> the SGMII support added later in this series=2E The property will be
>> parsed by rk_pcs_init(), and a missing phandle fails the probe=2E Add i=
t
>> and require it when phy-mode is "sgmii" on rockchip,rk3568-gmac, the
>> only SoC in this binding that has SGMII support=2E
>>=20
>> Signed-off-by: Coia Prant <coiaprant@gmail=2Ecom>
>> ---
>>  =2E=2E=2E/bindings/net/rockchip-dwmac=2Eyaml           | 18 ++++++++++=
++++++++
>>  1 file changed, 18 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac=2Eyam=
l b/Documentation/devicetree/bindings/net/rockchip-dwmac=2Eyaml
>> index 80c252845349c=2E=2Ebb7540e838033 100644
>> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac=2Eyaml
>> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac=2Eyaml
>> @@ -120,6 +120,12 @@ properties:
>>      maximum: 0x7F
>>      default: 0x10
>> =20
>> +  pcs-handle:
>> +    description:
>> +      Specifies a reference to a node representing the PCS device
>> +      connected to this GMAC=2E Required when phy-mode is "sgmii"=2E
>> +    maxItems: 1
>> +
>>    phy-supply:
>>      description: PHY regulator
>> =20
>> @@ -159,6 +165,18 @@ allOf:
>>          clocks:
>>            minItems: 5
>> =20
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: rockchip,rk3568-gmac
>> +        phy-mode:
>> +          contains:
>> +            const: sgmii
>
>The 'if' will also be true if 'phy-mode' is not present=2E Probably not=
=20
>what you want? You need 'required: [ phy-mode ]'=2E
>
>Rob

Hi Rob,

Right, thanks=2E Without 'required: [ phy-mode ]' the 'if' matches wheneve=
r
the compatible matches, even if phy-mode is absent=2E I'll add it and send
a respin=2E

Thanks,
Coia
