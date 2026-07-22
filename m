Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241B233954;
	Wed, 22 Jul 2026 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714937; cv=none; b=e942cO3hhppFn8d1LQs+ue1sAAdBjsVk9lpij3VAmgDi5BEADRN8R4P9nX6Wz3W+JKmcb9bC1DNsYANLKfTTZDcYJDKD61woUYU3+Qd0XtLytYIK94s95SZKBF0KBVtb0te9X2oXfftgPQxjs2gxLkdfjxOfBwc9jjELLkdF8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714937; c=relaxed/simple;
	bh=lDVDA87PEKayOQuhgsG6iZJIsWyJqp5rLBGEuWmvNpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tZNFcdiUzPsX6tuAHhih9XD/b0Ab9slJV+++e7N7ZGSVyzF+QFDSZplrDsZaM5vEf2v14IJufI2QVVkDPyrMOdVSX6FW/yB3od54BLp4rAgw7zGjwT10g0uvAlMHldGNeGDkOOnr3VNkzXvOCjQ8eed/t6xNZtgKWRmyi46dM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=raxbXFK8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="raxbXFK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784714933; x=1816250933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lDVDA87PEKayOQuhgsG6iZJIsWyJqp5rLBGEuWmvNpQ=;
  b=raxbXFK86mqKvwkd8rwTQXmwYthAj/izClh4WZMSeDT9pc0d8WLsfnaK
   peFhiPMq6b9s7ZNVHG9VDTmS+9avy7GqwYGou5Gx0nRwwiI+jpSjp014O
   PcGx3syfdQNagNF/N1MH86ImW6QppmMwCUlXtmYbI0BKYqsOKumxqqu2t
   lVTKceAv0Art9ISD78hYd9razGbaeEP5SLiWSQInp9ONvA44xFV+3EDCi
   ce4ukdQeE3yQCZbajO+GT+Y+DRemJt/KGvHX6guTPlMPu8jNyyEyi0ZtY
   VkIv4fjG7GTeIXS7RRCN0YEoL7751aJIE0PS5AKCRxHPc3+FUZB7on1ot
   g==;
X-CSE-ConnectionGUID: sZMU8XJEQ8aO7FCzQe8U+g==
X-CSE-MsgGUID: QzgrMZxPSVW6gusnbjpm+w==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="60134205"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2026 03:08:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Jul 2026 03:08:43 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 22 Jul 2026 03:08:40 -0700
Message-ID: <43382111-f55c-4ed2-bcad-586a51b3e413@microchip.com>
Date: Wed, 22 Jul 2026 15:38:39 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/3] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
To: <Selvamani.Rajagopal@onsemi.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, Piergiorgio Beruto
	<pier.beruto@onsemi.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
 <20260720-fix-race-condition-and-crash-v4-1-8273e2f38a1f@onsemi.com>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <20260720-fix-race-condition-and-crash-v4-1-8273e2f38a1f@onsemi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Selvamani,

On 21/07/26 7:50 am, Selvamani Rajagopal via B4 Relay wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> Threaded IRQ uses waiting_tx_skb. Transmit path also uses
> this pointer without any mutual exclusion protection. As a
> result, it might leak skb buffer, particularly threaded IRQ
> runs in the middle of tranmsmit path, near skb_linearize.
Typo: "tranmsmit" -> "transmit"
> 
> Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, level triggered.")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> ---
> changes in v4
>    - No change
> changes in v3
> @@ -1393,7 +1431,9 @@ EXPORT_SYMBOL_GPL(oa_tc6_init);
>    */
>   void oa_tc6_exit(struct oa_tc6 *tc6)
>   {
> +       spin_lock_bh(&tc6->tx_skb_lock);
>          tc6->disable_traffic = true;
I don't know whether this is the right place to provide this comment, 
but FYI: the disable_traffic read/check in the hard-IRQ handler 
(oa_tc6_macphy_isr()) is not protected, while it may be written in 
oa_tc6_exit() under tx_skb_lock.

Of course, spin_lock_bh() cannot be used in hard-IRQ context, so perhaps 
a different synchronization approach is needed?

Best regards,
Parthiban V
> +       spin_unlock_bh(&tc6->tx_skb_lock);
>          disable_irq(tc6->spi->irq);
>          oa_tc6_phy_exit(tc6);
>          oa_tc6_free_pending_skbs(tc6);
> 
> --
> 2.43.0
> 
> 

