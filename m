Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A83DB647
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556148; cv=none; b=dWe4COpwto88+b/s3P18Vg0+YKgS1UiM3UGEN7b6LZ2aeEFNnwGrZSaAv65t8IJZhPo8bxHIwADtdMyGHW8XHWGYmdhEJ25SAVJGeaKbvKAp+09z8uqGrocplCb/pNXjmIQgo4dGs3Z/h2WqbnsERXDcNLBY0Ev/VU4+NjTa3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556148; c=relaxed/simple;
	bh=rzSDRNXg2hNBJYYiqAkMSddwIljDCmzWH3Th/zYE0UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyga0hRA+G3nMq4/sQi5W6DgORgQqEz6EQ7GhOSyUJevKzSpcN86SHXF2AuD/32KZMcZvSGNPSEeUmWD28+5/vCosWSMgbs5CUBPEOVyPgoarEs2m5FQ/ZZK8oMuniiIHfLQux/eakjpb51mhQLiTFF7UdGzYLIIiUbWVi7+u18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=rAzFDGjY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="rAzFDGjY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceaf8a1265so98769515ad.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784556145; x=1785160945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jjgcDbEk+UwGPrm8p3ddZGJiNEptTi23fs+y3mGJy60=;
        b=rAzFDGjYYX0iF7Hvx5u39nAwjX9ZfS+gM5m3EHb8gMYxg6bPCGzLUar6n0lt6uBAXy
         C7jaPk8svw9LpnbftP7sY+tsbrd6cAu4BNndVNrvTKus62KK7EY9/G9dTSAgy7J3CVke
         BtYv5UPyktl34d+sPR7RZFn0ee745XxB2KuFudI6oakA258vZq0xInNBiXYJaGL0KDH8
         CGVNQ30Pk38ndeITE0/ee37hVln0+SXqXOoNIHwrYYNl1jPmiXxDlmw8VZ4t1C2gabYH
         cV4Sp/UF7E5xsS1LJdCm/bkBCBQJzZ60ezOlH9RYDmnkKg6mxMez5YWIC6OmqXeYMCi0
         mw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556146; x=1785160946;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jjgcDbEk+UwGPrm8p3ddZGJiNEptTi23fs+y3mGJy60=;
        b=qrEX7Klom3z3FwXZXZNm47slGjug4Eea8lozvw77sqW4Y/UsqeZ4OoMgQrwgoj71z3
         HnTPuFUzxqFQhRA4OBmhdKZnguKLhE7iTbbG0nu/PiS6a3B+vlWK5mEGhyzZT/yg5NUG
         YwhdjNTzrCaZWeVfhdwLE+7YQ+//yHHAUUVZWIzK5XWe484HexwvuIhaY6oUzXDch7dx
         flaWn8qsitPINQEr2pDCuLsfW97+x6+zn1qpWd0RkQJKsEMMBwJVfmwndqjMnIRGURes
         36aGRqgDIPOQKJiAfFPMjCS0cOP9c8P6evd8+17+1af5f0Da90LLmXNASTYyPgYJANIw
         cuOw==
X-Forwarded-Encrypted: i=1; AHgh+Rpv8C7tLbf802zWmQqMTFaAoEM6w1V3mhsYvU+jQU/6N+PVYnWyYd23xEKStJFSEukj1UPl/aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9RDtrhOED7VMl2LGbRDUnORtA3aSFouEnHzijDLuz2Zy/rZX
	D1rl/JHEJ2zTyzklQTl8wfUeQaxMusim3ulB3404zwjXTH/msdH6di5JhjEM0WO0aW4=
X-Gm-Gg: AR+sD118SWKr44ITOZ32I7j7mTRoTa1wQJWxtXrNpqd9BB5BHResjmCzvLv1bw9Mfkk
	yoLT86B80ApDnfwAV7R837SdpRATCfDhRANRuLfl1dccMcPVJEA49yI4/dlv3yRaE4y1Mv6PRNg
	R5huInVk2KAf86zLYX1gUmYBiBIoA0pL3l45IeWxJSqulKTpzP9aoOJkiW0lGQMhWSWKk3we5Cp
	pzULigtI0xWCRruiz9vVqv+XpWGWnU96HBZAAejV/mU0QzLWTGknTVKSrjOlEISk5i+qADUGwEK
	GiSbcAnz+dw4InnuIJY6AXH2ZJE4zApN/jueBlwsxiuBuS5skjoqdeqAb5cm9qMd9RHNFHeiW+Q
	kAOgkgG54MjhzEbzgRku/AIBxeAkMcFHqlY2upqsk0tPMUC2UFknh3itlF7KZnggT39tBJw==
X-Received: by 2002:a17:902:f78c:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2cf348bee75mr154491725ad.11.1784556145405;
        Mon, 20 Jul 2026 07:02:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db113sm56870065ad.39.2026.07.20.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:02:22 -0700 (PDT)
Date: Mon, 20 Jul 2026 07:02:21 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 01/14] net: enetc: extract common
 helpers for MAC promiscuous mode setting
Message-ID: <al4qbRV8h1a5nZCd@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-2-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720014317.1059359-2-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:03AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The PSIPMMR (Port Station Interface Promiscuous MAC Mode Register) in
> ENETC v4 has the same bit layout as the PSIPMR register in ENETC v1: bit
> n controls unicast promiscuous mode for SI n, and bit (n + 16) controls
> multicast promiscuous mode for SI n. The only difference between the two
> hardware generations is the register address offset.
> 
> Since the register functionality is identical, the MAC promiscuous mode
> setting code can be shared between ENETC v1 and v4 drivers.
> 
> Rename ENETC_PSIPMR to ENETC_PSIPMMR in enetc_hw.h to match the actual
> register name used in the reference manual, and extract two new common
> helper functions, enetc_set_si_uc_promisc() and
> enetc_set_si_mc_promisc(), into enetc_pf_common.c. These helpers select
> the correct register offset based on the hardware revision via
> is_enetc_rev1().
> 
> Remove the v4-specific enetc4_pf_set_si_mac_promisc() function from
> enetc4_pf.c and the duplicate PSIPMMR_SI_MAC_UP/MP macro definitions
> from enetc4_hw.h, as they are now superseded by the shared code.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +--------
>  .../ethernet/freescale/enetc/enetc_ethtool.c  |  2 +-
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  7 +--
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 11 ++---
>  .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++++++++
>  .../freescale/enetc/enetc_pf_common.h         |  2 +
>  7 files changed, 56 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index f18437556a0e..6a8f2ed56017 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -69,8 +69,6 @@
>  
>  /* Port Station interface promiscuous MAC mode register */
>  #define ENETC4_PSIPMMR			0x200
> -#define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
> -#define  PSIPMMR_SI_MAC_MP(a)		BIT((a) + 16)

[...]
  
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index bf99b65d7598..66bfda60da9c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -180,9 +180,10 @@ enum enetc_bdr_type {TX, RX};
>  #define ENETC_PMR_PSPEED_1000M	BIT(9)
>  #define ENETC_PMR_PSPEED_2500M	BIT(10)
>  #define ENETC_PSR		0x0004 /* RO */
> -#define ENETC_PSIPMR		0x0018
> -#define ENETC_PSIPMR_SET_UP(n)	BIT(n) /* n = SI index */
> -#define ENETC_PSIPMR_SET_MP(n)	BIT((n) + 16)
> +#define ENETC_PSIPMMR		0x0018
> +#define  PSIPMMR_SI_MAC_UP(n)	BIT(n) /* n = SI index */
> +#define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)

I probably would have fixed the leading spaces when copying/pasting the macro,
but that seems like a nit.

I read the rest of the code a few times and it looks right to me.

Reviewed-by: Joe Damato <joe@dama.to>
