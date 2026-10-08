Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C891495AE1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455762; cv=none; b=XHFLik3BNN+FZU8SQky6o4m611TUtS5eziykLlDJtrCenwldrWzWpUgMox2uKTVXZzEmi9YvZgrkOE7w1/x+Two6Qpk8MY/qzuYERspth+2VO7FOMKdb1wajcCLwPadZkARyWjEWOn8F8HuiohfFrP2CeLaUdo+TopjihMR3ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455762; c=relaxed/simple;
	bh=ipbO2EO7WMe+xgF3zJ/lomU9N7tX740/0Tw89M4ayys=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMsDAEGwVNAJTVeLpw7XswMYhG3c6buags+VVwj47A2u6UawMDkC28Fv5izAmUhLARQQhRhBOeTviDR+BfLTspOyQwpYfeTpufXmUO80vNWamjONZUUTebnbRE63TUnGQ6+/UdoGdAVtudKe9LxmFGubAMFjJTUUU+nDgYHy9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qsT43MDY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qsT43MDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791455761; x=1822991761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ipbO2EO7WMe+xgF3zJ/lomU9N7tX740/0Tw89M4ayys=;
  b=qsT43MDYDc2r5TVXgpEu0slP3SxDXvG1CSuTm7jzIsDdyeAmGDdnRkw4
   zKMg0CqlxOzz19pwUKo0NPw1B4S7hUBj0/V8Q6Ug7MCbYHtXzhNnurNtD
   424XxgwFflSTSdMyMvyFdFneiojGaRgd4ZB7IyJfEcZiY0rd7H4/dPRf8
   h1WfJcEh5Uu1CgplIOd3558noY3gTcjDO4FBbwj2VsLstfrEgJjff3fh4
   wEBC5M5LvKA7+CvaUZXN6IV5Zn/N7fp//p/BzY7WhnLvLCDpzJuheQTw/
   u7I0wfnDAcm+fj1RCjADlFt3Tmv3I6NrmCzQm9HYIfKSWUgJkdQQMmwCd
   A==;
X-CSE-ConnectionGUID: w9CmF09XSmCgePfJ5EwSkA==
X-CSE-MsgGUID: qLf1DkxMQ/qIVOlT+dQz/Q==
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="296163816"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 03:36:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 8 Oct 2026 03:35:59 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 8 Oct 2026 03:35:58 -0700
Date: Thu, 8 Oct 2026 12:35:57 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] ptp: ocp: fix PCIe delay estimation calculation
Message-ID: <20261008103557.mkws3svbpiijwnko@DEN-DL-M70577.microsemi.net>
References: <20261007203359.417270-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007203359.417270-1-vadim.fedorenko@linux.dev>

> The commit in fixes introduced a high cap for delayas U64_MAX value

nit: I think delayas should be "delay as", probably not worth respining for.

> while ktime_t is actually s64. This is wrong cap as it becomes negative
> value and any comparison to a real delay will fail to update delay
> value. Use KTIME_MAX constant as correct max cap for PCIe delay.
> 
> Fixes: aa05fe67bcd64 ("ptp: ocp: Improve PCIe delay estimation")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/ptp/ptp_ocp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 3d26ec1f7b9e..a8cba2f64b98 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1825,7 +1825,7 @@ ptp_ocp_watchdog(struct timer_list *t)
>  static void
>  ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>  {
> -       ktime_t start, end, delay = U64_MAX;
> +       ktime_t start, end, delay = KTIME_MAX;
>         u32 ctrl;
>         int i;
> 
> --
> 2.47.3
> 
> 

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
