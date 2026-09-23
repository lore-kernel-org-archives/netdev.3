Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA633019BA;
	Wed, 23 Sep 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171257; cv=none; b=a6QI8Ry4GpeCUecQQTTuCtXzNBrgwGC6RVIJ8iSUKIx/UhewO3TOlRbKPr869ael1ydMWlLyvzZdZcMu6Bmlxl+4il1NORJBF1tLTgSXzKtCEdCH7iLr/USi8sv3hVIZsEkWNGjkrKRDNnDveG0yKEsp8+0upe6q1leSAQI2UNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171257; c=relaxed/simple;
	bh=6wr59utk2f9FPWnpLCJUvqUpS4s4Dy7MJ0vY1g+Q74o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0ugZlO0phO+QPhGO4AfrOUKADGqaUaZvmibEpOEcSWUCcoUlyzPS7g5O9hWcgM2rXahD3yxmgEWoPTdxQToHc3l/MmFpvS87axO1XZEP8+QjmCpCM0+q9m4uQElA4J4yt1ecXpnqhf0lQcq/rOYw3A3hO/re6+DpIuwu3Yl/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnKGwI7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnKGwI7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB351F00893;
	Wed, 23 Sep 2026 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790171255;
	bh=enZrA9KL5KcJYg7045i7Oen8N//oPvSiJBMB0j2xFu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GnKGwI7drZrdPYc/xI20nDslDydd6Nd1J5vDs0WlY5Yq5qw1JxHcDqN7GSF0hsRJL
	 ERUrX4urED0VtRkNpHJ52589Cpmg251TUTehCE1dxbEXupIkMI1qA1vaqZ8tn/8sNr
	 z5L9ARvolKAu8wK7FlUliWXSNjR26szXoziYl7OhATkFNycrJHFBUgA43LPpyVBpgy
	 SKYpA0BC2v8VEDu4Ra2Kb5pMo7acYfNdaoRMMwnbyBG+S5eQuwpA+ha0aae3mx2mu3
	 pId1kNywFyDJMA34KdWskk1o+/47qxAC3g35dkJRsgYodfVemXNbtx2xSArrDd2vgE
	 2o2aBiTlUpEiQ==
Message-ID: <1554dd31-79ce-4803-a12c-2f806275fe25@kernel.org>
Date: Wed, 23 Sep 2026 08:47:33 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Add Agilex5 SoCDK TSN Config2 board support
Content-Language: en-US
To: muhammad.nazim.amirul.nazle.asmade@altera.com,
 maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/26 02:05, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> This series adds support for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
> board variant, which enables gmac1 as a TSN Ethernet port alongside the
> standard gmac2 port.
> 
> The TSN port (gmac1) connects to its PHY through a GMII-to-RGMII converter
> implemented as FPGA soft IP. This converter provides the RGMII TX/RX clock
> delays, requiring the MAC interface selector to be configured for GMII while
> the PHY-facing interface is configured as RGMII without delay duplication.
> 
> Add altr,socfpga-stmmac-agilex5-tsn for that integration. It is not listed
> as a DT fallback of altr,socfpga-stmmac-agilex5 because that port has no such
> converter. Patch 4 adds dedicated match .data ops for the required
> interface setup.
> 
> v6:
>    - Put altr,socfpga-stmmac-agilex5-tsn in the same compatible enum as
>      altr,socfpga-stmmac-agilex5 in the net binding, per Krzysztof Kozlowski.
> 
> v5:
>    - Replace of_device_is_compatible() probe check with dedicated
>      socfpga_agilex5_tsn_gmac_ops via match .data, per Krzysztof Kozlowski
>      and Dinh Nguyen.
>    - Drop altr,socfpga-stmmac-agilex5 fallback from the TSN compatible list
>      and rewrite the net binding commit message to explain the hardware
>      difference, per Krzysztof Kozlowski.
> 
> v4:
>    - Fix wrong email address in Acked-by tag from Krzysztof Kozlowski on patch 1.
>    - Add Reviewed-by from Andrew Lunn on patch 4.
> 
> v3:
>    - Add missing Acked-by from Krzysztof Kozlowski on patch 1, inadvertently
>      dropped in v2.
> 
> v2:
>    - Replace mac-mode DT property with compatible string-based detection per
>      Andrew Lunn's feedback.
>    - Use phy-mode = "rgmii-id" to correctly reflect MAC-side delay handling.
>    - Rename compatible string to altr,socfpga-stmmac-agilex5-tsn for
>      consistency with existing altr,socfpga-stmmac-* compatibles.
>    - Fix Makefile indentation reported by Krzysztof Kozlowski.
>    - Add DT binding documentation for new net compatible string (new patch).
> 
> Nazim Amirul (4):
>    dt-bindings: arm: altera: Add Agilex5 SoCDK TSN Config2 board
>    arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2 board
>    dt-bindings: net: altr,socfpga-stmmac: Add
>      altr,socfpga-stmmac-agilex5-tsn compatible
>    net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA
>      converter
> 


Applied patches 1,2.

Thanks,
Dinh

