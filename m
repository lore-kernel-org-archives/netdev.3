Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF381724;
	Sun, 27 Sep 2026 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790479733; cv=none; b=IP07sI+VX2/AIYpBsfNdDMoOkCKNg1hoyqPZ73vMUp8tYysJyHDAh/ATtNPwjnGLTxVziuh2/iZvX/JB5tegCo/dYRbGRigSTkgX7USdEQG26om4OEmjVDnB5iagKC/Mo6lpyMz0bgMx2NSXgPPLPS7mEWQZB+2zwLLi/bKOF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790479733; c=relaxed/simple;
	bh=k2u1ChEr6LZw5PLvA+8vLtxFSyAHOUNUCwIyreGdjTA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HkmvdXt40ywLbB4GTwAUDxtpUXSjCbKPjarLq16ZrstRrccQBWhiiFQDoc7pzpjqTuqS2w07LoKKv0n1kw564Sh83QZB09+wsRugm8x7Pp4oTepVhsc6Eq090gUKPH8rz4cTnEkqjhSJROLo6GkyDfNGku0JX0T7WIqtjNUN3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6HXz66q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6HXz66q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E44D1F000FF;
	Sun, 27 Sep 2026 03:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790479732;
	bh=6a0VT1f5TCixo51k9+lY1+LlgZn70eiYSlEvJbKsfbU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V6HXz66qKIOMxyMLQqbHBfABI8ZMt3ztYEXexLFaEcHpKsfAO011oTmtM2YiDL6aK
	 95W1VtJ+zSd0ooFRvlwTsi0CC2TbDkmimEbQHQ0n5RAyymDHztuTE4oQOlSPZ7mrwz
	 28Ss9VqUwjIrsOR1rz+ne6ZUcxyYeEgRxuN5Box2kaL0ESMV4lgj2kCkoedrAK7jtc
	 hVlr4jLAI6heNJOYLeA2FccBChv1H7AVtKF0OrIAJFTDotFqEBvdev59C4GjT2g3xI
	 4fVwZzpIrcFDYQkatavpHrNX0Vew1pTblL2QgeB/Zii+5pcOHYvE2jUEl2au1PsaqC
	 aBDSPGTwFkA+w==
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: altr,socfpga-stmmac: Add
 altr,socfpga-stmmac-agilex5-tsn compatible
From: netdev-bot+sashiko@kernel.org
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dinguyen@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 03:28:50 +0000
Message-ID: <179047973070.2160803.3411978604945361082@kernel.org>
In-Reply-To:
 <20260923021823.46649-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
References:
 <20260923021823.46649-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The binding patch makes the new compatible "altr,socfpga-
  stmmac-agilex5-tsn" a peer of "altr,socfpga-stmmac-agilex5" in the…
- [Low] At this commit, socfpga_dwmac_match in
  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c has no entry for…

--

dt-bindings: net: altr,socfpga-stmmac: Add altr,socfpga-stmmac-agilex5-tsn compatible

This adds the altr,socfpga-stmmac-agilex5-tsn compatible for the Agilex5
gmac1 port, which has an FPGA GMII-to-RGMII converter in front of the PHY.
The new string goes in the same enum as altr,socfpga-stmmac-agilex5, with
snps,dwxgmac-2.10 as the fallback. Plain agilex5 is intentionally not used
as a fallback.

> diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> index d8f90d36d2469..ca768937d8905 100644
> --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml

[ ... ]

> @@ -42,7 +43,9 @@ properties:
>            - const: snps,dwmac-3.74a
>            - const: snps,dwmac
>        - items:
> -          - const: altr,socfpga-stmmac-agilex5
> +          - enum:
> +              - altr,socfpga-stmmac-agilex5
> +              - altr,socfpga-stmmac-agilex5-tsn
>            - const: snps,dwxgmac-2.10

[Severity: Medium]
Should the allOf conditional further down in this file also cover the new
compatible? It still matches only the plain agilex5 string:

  - if:
      properties:
        compatible:
          contains:
            const: altr,socfpga-stmmac-agilex5
    then:
      properties:
        interrupts:
          minItems: 17

        interrupt-names:
          minItems: 17

        dma-coherent: true
    else:
      properties:
        interrupts:
          maxItems: 1

        interrupt-names:
          maxItems: 1

        dma-coherent: false

The TSN port deliberately does not list agilex5 as a fallback. A node with
compatible = "altr,socfpga-stmmac-agilex5-tsn", "snps,dwxgmac-2.10] will
therefore never match the if. It falls into the else branch, which holds
the Cyclone5/Arria10/Stratix10 limits.

The TSN board would override the gmac1: ethernet@10820000 node in
arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi. That node has 17
interrupts (macirq, tx-queue-0..7, rx-queue-0..7) and dma-coherent.

If a board DTS switches gmac1 to the TSN compatible, wouldn't it fail
dtbs_check even though it describes the hardware correctly?

In the companion driver patch, socfpga_agilex5_tsn_gmac_setup_plat_dat()
calls socfpga_agilex5_setup_plat_dat() and changes only mac_interface.
That suggests the MAC-side constraints match plain agilex5. Would
something like this work instead:

          contains:
            enum:
              - altr,socfpga-stmmac-agilex5
              - altr,socfpga-stmmac-agilex5-tsn

[Severity: Low]
At this commit, socfpga_dwmac_match in
drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c has no entry for
altr,socfpga-stmmac-agilex5-tsn.

Would a node using the new compatible bind through the
snps,dwxgmac-2.10 entry in dwmac_generic_match instead? That path would
skip the SoCFPGA sysmgr, reset and platform data setup.

The next patch in the series, "net: stmmac: dwmac-socfpga: Add support
for Agilex5 TSN GMAC with FPGA converter", adds the match entry. No
in-tree DTS uses the new compatible before that patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923021823.46649-1-muhammad.nazim.amirul.nazle.asmade%40altera.com
