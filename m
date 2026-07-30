Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAB417369;
	Thu, 30 Jul 2026 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411699; cv=none; b=A6RP6/PWHKGPJ2BL7kU6mP1kMVVTEH8rCrFSdDHGacOqqtRrIbg5R/GDuzmy5x8MQiu0W60ZC8qzIu7cn/VJpGopa6tvyqogNXXb0f7HNMovyU0NjrTLzushftlViscj8PdWiLbir5hieMGcGDzE+/M8j7ODjKBv4Cu9xrUoEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411699; c=relaxed/simple;
	bh=XJC8VPRE2FBJbIJ8kWSMeCvOs6Pnqmn6A4ET3qRLeCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P17Vig5wNMDzqe2VGb5IQJtAJmY5rWI1CV7kFqIwABWpUeW+2q0IxEkKzax05KKnJU6kj+aae7gYic4BaZuno5Kk3bwTw9MTrQluuF11Bj+9oWFtLi/A4EnSAEqwLneP4VSm6nR6/ZXq4bc1/869tWRozEDYywrA/QbRPoEmFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqHrVb4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqHrVb4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8F31F000E9;
	Thu, 30 Jul 2026 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785411697;
	bh=1Y8PGz3vJMmVf3g3KPKLx97MsTPFyh1Ze5zLLFy1D3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eqHrVb4chm2WrXk/JzLSXzeLtQVgdu9ebdSEi+JIp5/CUt6ouGFo9TKj4ghriWlaG
	 Uf1WHTR+UqoQ8tWyHhdsLITg419hjDWrtP1ZmwtI3LgjX1jga6Fr8aOdYRYkwfmxhk
	 Alr7c8hbnQGfKJ5Po7UwtVQu8rtEIemR6hdVRh67H/s0tF1ictYUvZX5KxqeZASww+
	 y5bp0XZE4gbMZiRs4Z8CEnjB0eTDIfhdQ+C/dSAVlS2MFg71PTTjR4c8fut1Uy5uaK
	 GHWLXK8BZWweiQxBjTepfIzHcU0MqpbgX5GYMEg5vYQdncF673DCNQQm8hfwDoyL6y
	 eC1HvdVvJ3WvA==
Message-ID: <50a524c2-a470-4b24-9b63-41b37346fa74@kernel.org>
Date: Thu, 30 Jul 2026 13:41:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: rockchip-dwmac: Add 25M
 refout clock
To: Gavin Gao <attinagaoxu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 nicolas.frattaroli@collabora.com, sebastian.reichel@collabora.com,
 sashal@kernel.org, alchark@gmail.com, chaoyi.chen@rock-chips.com,
 amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk, horms@kernel.org,
 alok.a.tiwari@oracle.com, david.wu@rock-chips.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
 <20260727021048.3375444-2-attinagaoxu@gmail.com>
 <20260730-lucky-strict-oryx-9ce8de@quoll>
 <CAK2JjQVoaHjzf4Z=_LDVzTj0R-ey1Z4T+1OF_xYACdz1C4yReQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAK2JjQVoaHjzf4Z=_LDVzTj0R-ey1Z4T+1OF_xYACdz1C4yReQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/07/2026 13:38, Gavin Gao wrote:
> On Thu, Jul 30, 2026 at 4:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Mon, Jul 27, 2026 at 10:10:45AM +0800, Gavin Gao wrote:
>>> Some Rockchip GMAC instances can provide a 25 MHz reference clock output
>>> for an external RGMII PHY.
>>>
>>> Add a clock name for this 25 MHz reference output so SoC dtsi files can
>>> describe it separately from the existing MAC reference clocks.
>>>
>>> Signed-off-by: Gavin Gao <attinagaoxu@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>>> index 0ac7c4b47d6b..074ac274f2e0 100644
>>> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>>> @@ -81,6 +81,7 @@ properties:
>>>          - pclk_mac
>>>          - clk_mac_ref
>>>          - clk_mac_refout
>>> +        - clk_mac_25m_refout
>>
>> That's the same as clk_mac_ref and clk_mac_refout. clocks are not
>> outputs but inputs, so explain how does the device take three SAME
>> clocks: clk_mac_ref, clk_mac_refout and clk_mac_25m_refout?
>>
>> Best regards,
>> Krzysztof
>>
> 
> This is not the existing clk_mac_refout clock. On RK3576 the
> REFCLKO25M_GMAC[01]_OUT clocks are separate 25 MHz reference clock outputs

That's why I emphasized here and in other patch we do not talk about
outputs. Read the comments.

> intended for RGMII PHYs, while clk_mac_refout is the existing refout clock
> used by the Rockchip DWMAC binding for the RMII reference output path.





Best regards,
Krzysztof
