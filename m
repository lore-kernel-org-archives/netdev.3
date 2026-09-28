Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43C4E4C54;
	Mon, 28 Sep 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608499; cv=none; b=Jq7PGTo11blGMJzupmn07z0RIhAdxiqdyMq/HwrSAetrdT8YC3rB6TF4Z6+lB7aZu/VarbknM3SDS7VgYA3ZS0pgss+pgEeJUQudIUArVpLXgoQ4HDrFPgqp3LUo4cuFvNolzZ07hlwxJ+zu2f4mn7scg9xsFjmPIPYhPPcbO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608499; c=relaxed/simple;
	bh=//iA92Cb/95cVPrsed63yZV1ntnzxyLz5sN+/uqxqIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrpKWf/vc/jSx3iv8xduz6pcfmTG5P2d0k9pfWdoBzrx9Dyda9h3hXEK7DgLzcEpHj6wOX8wSZUVMW9H29nDfRYnZNWhfPWczEteIslTOq123cZqia2t8/QYBl8nOGO2RE77jdvGfjF/VCwaZpqElIHWfJp1EQco7Z9aRpBatVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AruLnew8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AruLnew8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790608502; x=1822144502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=//iA92Cb/95cVPrsed63yZV1ntnzxyLz5sN+/uqxqIc=;
  b=AruLnew86CVVitK4bzmWjnfc0xsyWrXWF4ISjpLe3avWou90GK1k3khV
   0Ohfn+UhpAaCo/X5LTTY7jgPwHjL3zPStdSBLTmpDiZiDMED8IreChVf8
   hwo/TKvyA4nh3vgGrKlIlPHXKY2j6kr6dii7PVUUKWbJF4RX8xQV0+/dd
   t2QaWtdPBy60LuAJDWTgfLjcJLJPYhTziNIYVbV63JWYTMBOcevE5w02o
   ShFWjI5wloE/qrRwPOLPgmEK2Uy/RQhs4xiU/CTcpJ7CSyXC7VI07eyrt
   hotc/xwo8VQUsELttip/mi6ReFd+k099Ws1m0dfh4k/U90xcLBMYV0OkK
   A==;
X-CSE-ConnectionGUID: ruO/2bxPRV6E3dOTkw2JSg==
X-CSE-MsgGUID: Y9gywBzxR4q9pSNX9VzmmQ==
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="231374969"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 08:15:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 08:14:56 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 28 Sep 2026 08:14:54 -0700
Date: Mon, 28 Sep 2026 17:14:53 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Quentin Freimanis <quentin@q-lab.dev>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: start the domain 0 TOD counter on
 non-PTP lan969x variants
Message-ID: <20260928151453.fzch356vrp3ergy7@DEN-DL-M70577>
References: <20260928044955.29647-1-quentin@q-lab.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928044955.29647-1-quentin@q-lab.dev>

Hi Quentin,

> Currently the base non-PTP capable lan969x variants don't forward any
> ethernet frames. Testing showed that starting the domain 0 TOD counter
> gets them working again.

Ack. Not initializing the TOD domains on certain variants is a problem.

However, TOD domains shouldn't affect basic forwarding. I tried it on my board
with PTP forced off - no forwarding issues.

Certain TSN features do require TOD domains to be configured, though. How did
you test this, and what exactly did you see fail?

> 
> Fix by moving the TOD counter start code into a helper and calling it in
> sparx5_ptp_init(). Non-PTP capable lan969x parts now start the domain 0
> counter, and PTP-capable parts start all three, as they used to. A similar
> workaround that starts all three and registers the PHC clocks is
> implemented in the vendor BSP 6.18 kernel [1].

What we do downstream, is to ensure that all domains and PHC's are configured
and registered on all variants, with a very simple is_sparx5() check. 

> 
> [1] https://github.com/microchip-ung/linux/tree/bsp-6.18-2026
> 
> Fixes: 207966787b71 ("net: sparx5: add feature support")
> Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>
> ---
> If anyone with access to documentation more detailed than the
> register map knows WHY this clock needs to be running, I'd like to add
> that to the commit message.


> 
>  .../ethernet/microchip/sparx5/sparx5_ptp.c    | 72 +++++++++++++------
>  1 file changed, 49 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> index 5953e04ef14e..b436684ddae6 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> @@ -573,6 +573,42 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>         return 0;
>  }
> 
> +static int sparx5_ptp_tod_start(struct sparx5 *sparx5, u8 phc_mask)
> +{
> +       u64 tod_adj = sparx5_ptp_get_nominal_value(sparx5);
> +       int i;
> +
> +       if (phc_mask > GENMASK(SPARX5_PHC_COUNT - 1, 0))
> +               return -EINVAL;
> +
> +       /* Disable master counters */
> +       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
> +
> +       /* Configure the nominal TOD increment per clock cycle */
> +       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(phc_mask),
> +                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> +                sparx5, PTP_PTP_DOM_CFG);
> +
> +       for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
> +               if (!(phc_mask & BIT(i)))
> +                       continue;
> +
> +               spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
> +                       PTP_CLK_PER_CFG(i, 0));
> +               spx5_wr((u32)(tod_adj >> 32), sparx5,
> +                       PTP_CLK_PER_CFG(i, 1));
> +       }
> +
> +       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
> +                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> +                sparx5, PTP_PTP_DOM_CFG);
> +
> +       /* Enable master counters */
> +       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(phc_mask), sparx5, PTP_PTP_DOM_CFG);
> +
> +       return 0;
> +}
> +
>  static struct ptp_clock_info sparx5_ptp_clock_info = {
>         .owner          = THIS_MODULE,
>         .name           = "sparx5 ptp",
> @@ -605,7 +641,6 @@ static int sparx5_ptp_phc_init(struct sparx5 *sparx5,
> 
>  int sparx5_ptp_init(struct sparx5 *sparx5)
>  {
> -       u64 tod_adj = sparx5_ptp_get_nominal_value(sparx5);
>         const struct sparx5_ops *ops = sparx5->data->ops;
>         struct sparx5_port *port;
>         int err, i;
> @@ -622,8 +657,17 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
>                 sparx5->ptp = 1;
>         }
> 
> -       if (!sparx5->ptp)
> +       if (!sparx5->ptp) {
> +               if (!is_sparx5(sparx5)) {
> +                       /* the base, non-ptp-capable lan969x variants need the first tod counter

Nit: s/the/The

> +                        * running to forward frames.
> +                        */
> +                       err = sparx5_ptp_tod_start(sparx5, BIT(0));
> +                       if (err)
> +                               return err;
> +               }
>                 return 0;
> +       }
> 
>         for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
>                 err = sparx5_ptp_phc_init(sparx5, i, &sparx5_ptp_clock_info);
> @@ -635,27 +679,9 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
>         spin_lock_init(&sparx5->ptp_ts_id_lock);
>         mutex_init(&sparx5->ptp_lock);
> 
> -       /* Disable master counters */
> -       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
> -
> -       /* Configure the nominal TOD increment per clock cycle */
> -       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0x7),
> -                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> -                sparx5, PTP_PTP_DOM_CFG);
> -
> -       for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
> -               spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
> -                       PTP_CLK_PER_CFG(i, 0));
> -               spx5_wr((u32)(tod_adj >> 32), sparx5,
> -                       PTP_CLK_PER_CFG(i, 1));
> -       }
> -
> -       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
> -                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> -                sparx5, PTP_PTP_DOM_CFG);
> -
> -       /* Enable master counters */
> -       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0x7), sparx5, PTP_PTP_DOM_CFG);
> +       err = sparx5_ptp_tod_start(sparx5, GENMASK(SPARX5_PHC_COUNT - 1, 0));
> +       if (err)
> +               return err;
> 
>         for (i = 0; i < sparx5->data->consts->n_ports; i++) {
>                 port = sparx5->ports[i];
> --
> 2.55.0
> 
>

/Daniel
