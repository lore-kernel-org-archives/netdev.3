Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3A3B894B;
	Thu, 30 Jul 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400102; cv=none; b=pM1pcDMbL9byQOB9Jj4LUQs3AmT95ZbHD9NlBH6zlZMMBbBqYk3ZmjaozAp5y0gw6HXl1XEaoAwGlZrrDuL/7kIAHtA3nmPOfR8efR7IxKmGEG9sK8rUyk+uP+mjyN3+S2lDG4WYB67T4BbLVrjf2YJ//iUMgFqubHUs5fiIwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400102; c=relaxed/simple;
	bh=bxBJBjrKqgZwEbpNaf5/UI47pXkxo93TJAhmSmSxQ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVeKUWufyzS0IeSgYx4ROM4/cj+6dmXgO31GQYELlkpsV8x1qDhc258/NH/wM7dIY4vTSH/5qnL/KSTrfIcTj1tWg4y3zocnlfeQL2yI032Ipi7D9qUcdQMgzjrtgQN7Z3rh7QQApKCH9ctWPte+UxtG6G3QKL4aegv68srjmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxi1cOys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxi1cOys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F251F000E9;
	Thu, 30 Jul 2026 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785400096;
	bh=IqWfPHowzypNS3fC5xvMrVulrkg/53CBTJvxev8Nx5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dxi1cOyszRtlP/OETbzH9DzS1JrcmsxerAuE1GIeA4eMSLgfQxwXEVtPcz45v6Jk+
	 rA2Bks3auZ1nx2bGDNs1LFcWAjBoxlIVoYdQQAbVUCPNEMbFFwA/99atlIdEc/e0FK
	 Q4q0EhvQbJsdKHIH+4Wh/EEPMOKTtz5h12QXlKgLsdMVsDhzfiGJI1a7uPWNkTkhlL
	 6oBTm9s571O/TBpR2hhYdjXIeRJ20qGx+dTOlKb4oElWzDStMNGNlCLHpNAHVCS9BO
	 naVZLLc713RhicSXOhVRgNOpzqzdebsGnG8DLHLn90BHePFJ4XNGVKTTBQCYKHaSd/
	 9WrV7yUewA71w==
Date: Thu, 30 Jul 2026 10:28:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gavin Gao <attinagaoxu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, richardcochran@gmail.com, nicolas.frattaroli@collabora.com, 
	sebastian.reichel@collabora.com, sashal@kernel.org, alchark@gmail.com, chaoyi.chen@rock-chips.com, 
	amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk, horms@kernel.org, 
	alok.a.tiwari@oracle.com, david.wu@rock-chips.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/3] arm64: dts: rockchip: Add RK3576 GMAC 25M
 refout clocks
Message-ID: <20260730-complex-funky-angelfish-dc9aad@quoll>
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
 <20260727021048.3375444-3-attinagaoxu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727021048.3375444-3-attinagaoxu@gmail.com>

On Mon, Jul 27, 2026 at 10:10:46AM +0800, Gavin Gao wrote:
> RK3576 provides REFCLKO25M_GMAC0_OUT and REFCLKO25M_GMAC1_OUT clocks
> for the two GMAC instances.
> 
> Describe these clocks with the clk_mac_25m_refout clock name so boards
> using RGMII output clock mode can let the MAC driver manage the 25 MHz
> reference output.
> 
> Signed-off-by: Gavin Gao <attinagaoxu@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> index 70e67d4dccb8..f1125c2f88ab 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1692,10 +1692,10 @@ gmac0: ethernet@2a220000 {
>  			reg = <0x0 0x2a220000 0x0 0x10000>;
>  			clocks = <&cru CLK_GMAC0_125M_SRC>, <&cru CLK_GMAC0_RMII_CRU>,
>  				 <&cru PCLK_GMAC0>, <&cru ACLK_GMAC0>,
> -				 <&cru CLK_GMAC0_PTP_REF>;
> +				 <&cru CLK_GMAC0_PTP_REF>, <&cru REFCLKO25M_GMAC0_OUT>;
>  			clock-names = "stmmaceth", "clk_mac_ref",
>  				      "pclk_mac", "aclk_mac",
> -				      "ptp_ref";
> +				      "ptp_ref", "clk_mac_25m_refout";

Where is clk_mac_refout? Why do you claim this is a different input
(important: INPUT)?

Best regards,
Krzysztof

