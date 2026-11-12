Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485326;
	b=iBPWYBCXkZCR3B4f0M5zsTPKD9l5lHAm6tPOzix4PupraK0VFjR27HK/tYhV2W9iBJZ/
	 y1JZI8LKbh7REOFIgyMGh+dJxw1w6D4tZgP3ZSOmu5NuyBAor4vwM4ib8bifN4ReNy0sp
	 UgrFekPDiJcWVYtd977N29rlu5d5TJM/woszt2MLnXqXunQdy+uPnkX4zgqU4q1luaYLp
	 n1n12c5CoD+LUxvbNrDCkDJx6/f4mCBpQbnfh1ZVGLJc3EoPaOCVVMbfy17LS0OOfptjJ
	 lEOU6GHa1c9a/4eUY4sR8l8Pk1PpWMVfK+UpTq2FT+wwr+qumHpbWhugepgt50K3YIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485326;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=f1MEjtMguNEF/cHLIF6AWlz6RiobbkPLi0M5dgocHyc=;
	b=UQtdkQNOFMVicGkaj2vobgDvL/MHtkWzX+x/BRB1EBEHhP/pwEwiLdMFHdpsItadxkvS
	 PUXqkE26VLrCwA3yxUFsWOIX4e4t/3XwM0oHbl9CyhMtHoPn4cGKd2M8doPOKK6neVVfi
	 7eQcHFpc5oDJAPvQF2mG/Q9WaqTbisa00q87uJ4qOB7vjGI0H86Z3YMPWLPagWWvOm2bt
	 g8Nisi2bs1Dnn8rqNdSvOkc4Y1LEr6xkx6c1w1rdWH2qKgrVcaR8WT9YlcWj+ZZUhFn8n
	 ssyVJxUUNqvugsBCDVcv9kkavIaTcTHaFwnukdAJZAcgrMXi+9BWkiRslOgosLX0iiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=x0IvzHy+;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1C606A31C;
	Thu, 12 Nov 2026 12:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25F1C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=x0IvzHy+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794485326; x=1826021326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ceqU1RzZ/17D27kp1OnRrKSKE9YXqGXBWtsvFx5l8To=;
  b=x0IvzHy+Dq29A6TotWtTMZZy+y3fGOw7Q9+q3vhBVRnEMf5zJQcG97yQ
   EsHlvjJYN4V5NwjRh+qyxxO7NmgW3/oWuqf1izNZIGI7WC/uw3nvaGLqm
   y7DkpYo/5g3XuxbNKqYqebsiIFEb9w5ZRpF9+WDRDouEtYvm/fcFKWHMV
   fI5lPZM3zH53w6bCv/HXSmB7i5i/NiCzIJ9PZVq0nK6354BCAISDFe4p8
   c7Y1rUe5ui7B/0BjXPgDohbYvKK6EAq0OohVj4ts7KoKFDk6Mj3h9at+u
   8fI05yP9c6FcvQec5ePaEebDR31GxZ8ZO9pkovJIyI/FacaWepH8eecI6
   g==;
X-CSE-ConnectionGUID: wT1Wv8j0QhCcxW2K1VU6qw==
X-CSE-MsgGUID: pDKX+QX8TPGyf29Khy75cw==
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="65443584"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2026 05:08:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 12 Nov 2026 05:08:38 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 12 Nov 2026 05:08:36 -0700
Date: Thu, 12 Nov 2026 13:08:35 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik
	<jeff@garzik.org>, David Gibson <david@gibson.dropbear.id.au>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: ibm: emac: fix MR0 write in emac_rx_enable()
Message-ID: <20261112120835.jhn7kbktc6fpcbof@DEN-DL-M70577>
References: <20261110014313.1586633-1-rosenp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261110014313.1586633-1-rosenp@gmail.com>

Hi Rosen,

> When an asynchronous RX disable is still in progress, emac_rx_enable()
> waits for MR0[RXI] with
> 
> 	while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n)
> 
> which assigns only the RXI bit to r, as & binds tighter than =. The
> following write of r | EMAC_MR0_RXE then clears every other MR0 bit,
> including TXE, and TX stays stopped until the watchdog resets the EMAC.
> 
> This path is taken when RX is restarted after an RX descriptor error.
> 
> Replace the open-coded loop with read_poll_timeout_atomic(), which
> stores the full register value in r.
> 
> Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: use read_poll_timeout_atomic
>  drivers/net/ethernet/ibm/emac/core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 1b95b4d5deff..0311131055f7 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -24,6 +24,7 @@
>  #include <linux/string.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>  #include <linux/types.h>
>  #include <linux/pci.h>
>  #include <linux/etherdevice.h>
> @@ -248,12 +249,10 @@ static void emac_rx_enable(struct emac_instance *dev)
>  	if (!(r & EMAC_MR0_RXE)) {
>  		if (unlikely(!(r & EMAC_MR0_RXI))) {
>  			/* Wait if previous async disable is still in progress */
> -			int n = dev->stop_timeout;
> -			while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n) {
> -				udelay(1);
> -				--n;
> -			}
> -			if (unlikely(!n))
> +			if (read_poll_timeout_atomic(in_be32, r,
> +						     r & EMAC_MR0_RXI, 1,
> +						     dev->stop_timeout, false,
> +						     &p->mr0))
>  				emac_report_timeout_error(dev,
>  							  "RX disable timeout");
>  		}
> -- 
> 2.56.0
>

I think the v2 conversion to read_poll_timeout_atomic() looks good. But I wonder
why you dropped the tested line in v2? Was this version not tested? Either way,
the commit message should say so.

/Daniel

