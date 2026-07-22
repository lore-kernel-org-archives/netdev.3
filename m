Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CD33F8A3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726712; cv=none; b=BX4b+S0Ar2c5ocw8nSiOkPloIiwhlriowfHjaX+jo+thzpJ4KJmNwlwcsGGhqi4QC8qB+k2DY+gZBh4Kb68TIxcfNiVOZONghqrPG96XPj1JbTrZ+3shT5YPhedCHitdqPriHxrHyjAf+ouAUrFk/Cbiw7wkG+9ALOGzH1M7ikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726712; c=relaxed/simple;
	bh=Pg2VRxd7gCM6h+IJ8Y41+glwBqp8kgUUHbMEbqXsK7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLd7hEK9v5y86sSxDctqK14RlLEvJbeqNhpBJfZn9hjSLwH1Elugmno0ZTwrb1Nd3O6BMBhTP6iZKzzYFGUYg1L2Vrsp5bDkMWlrTaL2X7SK4n1klF2J87SNsZhwk3s3nPsphe+kiw9qHhnPOI2pyJ17seHQ5yFrl/zYqvvPy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=I7PQ7eX6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="I7PQ7eX6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84874b52eabso12092141b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784726709; x=1785331509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1m9B3TqTXQp52+cm2Y/AlOog6dUAN0pTGZwsxsnFWrM=;
        b=I7PQ7eX6/Rb/83fhiCREmP0Nq9eXv/8ZYLxK6ztSl6OrAv+aqnt6f9STu3Vq1k2KL+
         bU1TKP+7O+loIusmFCQZXOM0p3NC/iZ9zOW0HKBJHalGGDC1YGMbBwQRPvqRP6CPXmu/
         2HnwYRYOHUCS1/e4NG798Y4uR3KXwN8QJMO79AT0YzGCPQxv2oCCVMSuM7+hKAQY5bpI
         PpaWIx9Dv4d34ftuVsUjC0IrpiwbzOJ5mrIqJWn4tSWWFJqcd/t5GUZFRFfT0jPvV2X1
         lgWsmcfGHW4F13bun7avMbYMkVOgP+/QMXRxXgYKbfCWNyftbySmKuXIuOvbV3rtq4Zw
         JpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726709; x=1785331509;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1m9B3TqTXQp52+cm2Y/AlOog6dUAN0pTGZwsxsnFWrM=;
        b=cKlu3M2wHzflCtTuuL7toc8+B/MYmXK9UaIoPY+S0t1yTXonnyUYDvaAvTqUYCum9L
         0PdquigLe0RcckkarcPoKVpSdeUMnrP9o3FXB8cKihezpTw01s2E4iKZEI89IHBrG8H/
         3qV4Yjtq3MRAKZ0JdP2qAyJ0k+yx6VKuWzLuBfbuErEl6HfVCbiJ84S5XWprTcLvfbD/
         n+NxgShnOd2C2B6GT2Lcz6qIDXJ5iGmj5bO79/65abg0P1Osfk6fRN/k8LKhR9bLuOZD
         hqooTLtJKRp5NzEQLsNQeEV5sS67YI710+u6fCJSHx+S8vx/LeyCQKIbYc6u47cQCyMN
         IL0w==
X-Forwarded-Encrypted: i=1; AHgh+Roh0guqPunKYu+KBR+3lMHyF8l/Cml20OSvaTCCb3Y0XirGRXRBqbHvmh1j4aTB2nePagM3p+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtXQIg8oyMSZY8V4ATttbpHK6pvhp2g/JUMhl5xc3BspNK5N5
	96A4u+XTFRaWETSRUbMRulYZ5WW8ysVGJuz8vROV8kHpkl3wNIwa5B4I9GAZeXxuZlc=
X-Gm-Gg: AR+sD11GQ+Umc0b2sNCrhWiiee3lbrDmNuC/83cKG6WK/fB44xB7CxJ165rrerbjR1G
	1x1fT7WPSftWgpcMGmx+svD1SyeakkPHO3JyBc04NIjyhfHZnU4IRgk+nbjeiqzgua4EmvyQpXp
	qkDpmgzhB2ULIsFo4jX1XiEh+jkJAiZVn0Xq181sbhFVhRQt9ebmhyNM5+dCPA4N1VwWLO4w/CJ
	SiMzE2S8j7xX/uYpRZInmbY1jrf38X31GTuoRlliGUZA18vQxbGxCCX6+GNjmTBVrI0AD2GIJXj
	y0Lg6FTKSyTgf2ZtPqAMYhgne+8QVTopbzwzV5Drld7aglt6R+lSTRHUmBrd90K1cVZeSM/mgXd
	qQfvmSVFQUrXOy22sTRUnpUI6zCdOiCkMQ7INNaPGaMLSFRp5KAVMs8uGjhk=
X-Received: by 2002:a05:6a00:13aa:b0:84a:2ec8:fac1 with SMTP id d2e1a72fcca58-84c29545550mr24635234b3a.72.1784726709431;
        Wed, 22 Jul 2026 06:25:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17602046sm1332323b3a.59.2026.07.22.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:25:08 -0700 (PDT)
Date: Wed, 22 Jul 2026 06:25:08 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 10/14] net: enetc: refactor SI VLAN
 promiscuous mode configuration
Message-ID: <amDEtJmcET788Lls@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-11-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720014317.1059359-11-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:12AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Remove the enetc_set_vlan_promisc(), enetc_enable_si_vlan_promisc() and
> enetc_disable_si_vlan_promisc() functions, and introduce a new unified
> function enetc_set_si_vlan_promisc() to enable or disable VLAN
> promiscuous mode for a specific SI. This simplifies the logic and makes
> the interface more straightforward. The vlan_promisc_simap field in
> struct enetc_pf is no longer needed to track the current state.
> 
> As ENETC V4 only changes the address offset of PSIPVMR register compared
> to V1 without any functional difference, enetc_set_si_vlan_promisc() can
> be moved to enetc_pf_common.c in the future with minor adjustments to be
> reused by the ENETC V4 driver
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  5 ++-
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 36 ++++++++-----------
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
>  3 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 66bfda60da9c..16da732dc5de 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -185,9 +185,8 @@ enum enetc_bdr_type {TX, RX};
>  #define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
>  
>  #define ENETC_PSIPVMR		0x001c
> -#define ENETC_VLAN_PROMISC_MAP_ALL	0x7
> -#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
> -#define ENETC_PSIPVMR_SET_VUTA(simap)	(((simap) & 0x7) << 16)
> +#define  PSIPVMR_SI_VLAN_P(n)	BIT(n) /* n = SI index */

I suppose it would have been nice to only have a single space after #define
above.

The rest of the code looks right and I think the promisc logic is clearer, so:

Reviewed-by: Joe Damato <joe@dama.to>
