Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB749690C;
	Wed, 22 Jul 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714990; cv=none; b=O0ofLAbGxMqvcYDIGp9/pUwjoFpnDZBEAGISFjDYSb0w4wBJc9AHi7T0Lakp1o9oF7G++DJCtjZFrEDWBr9DrlJnv2fyuVxdKy5cmThUffh3uSvwp6qNLecxAP6tTgDzaWQ/S4d7MvAVpm4446ouuCYlhJ3UmL4x7wWq53zLRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714990; c=relaxed/simple;
	bh=C/g0FCT8/6BVpjY5mBrYqjavJ0k0jfr3iQ2wKIc5Auk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vC7uHicazNhFiX2Ny1UIKPNhxyizkuVvvgoBvLIHMZtvkHO0vW3iEtxFTwbbwTRxw62TYwpReyyTtEpiqC6C6L8/ZxWdPmihj3PRfKkasnUJY+jGIzBLJCFb1WLzO5U/G9mAteEsk7IamSLSMao0O7R+soJHc4qOzglw0o1wTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pGM7EhnV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pGM7EhnV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784714987; x=1816250987;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C/g0FCT8/6BVpjY5mBrYqjavJ0k0jfr3iQ2wKIc5Auk=;
  b=pGM7EhnVjzscQWAO6ASiygosVwCItktlQkaNKsCqT/WesW8323djDUCn
   dvKQ72ObcrSKMvd9sz5xsyX/aQLIGWwpdvK2ujtKmEnJPbPQ+Uve9NfpP
   +7F7LRBJHivPFl7TRkfClRSIs71zXdoV5eASs4yl0Z2hOQ+0Bl3vD86og
   tHAsNMSGHiNdNyoN9+hjey+ctWCE3z4YH/5mmsZa3tuHZgYFekLsKk5PQ
   j28wxILLBpCc6mqpA2zD3VJ3P956UfmPI6jffXUS20AcvNlGWhoKh4Arf
   5nHYjw8QKt+nW6o22XVm9FUHavp1Qz2xW+vwQfw1gor52CL34Y2x28tC3
   g==;
X-CSE-ConnectionGUID: 4UUhkR1eSmCzM/jVqS1HTA==
X-CSE-MsgGUID: eYcBRZ76RQunyFwCGWLRRA==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="60995226"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2026 03:09:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Jul 2026 03:09:39 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 22 Jul 2026 03:09:35 -0700
Message-ID: <b6524b93-593f-49c5-88f2-393297ed86fd@microchip.com>
Date: Wed, 22 Jul 2026 15:39:34 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] net: ethernet: oa_tc6: Disabled tx queues when
 disable_traffic is set
To: <Selvamani.Rajagopal@onsemi.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, Piergiorgio Beruto
	<pier.beruto@onsemi.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
 <20260720-fix-race-condition-and-crash-v4-3-8273e2f38a1f@onsemi.com>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <20260720-fix-race-condition-and-crash-v4-3-8273e2f38a1f@onsemi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Imperative mood for the subject: "Disable tx queues when disable_traffic 
is set" (netdev convention).

On 21/07/26 7:50 am, Selvamani Rajagopal via B4 Relay wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> Previously, TX queue interface was stopped when
> disable_traffic flag was set. It is more appropriate to
> disable the queue as there is no recovery, once
> disable_traffic is set. Carrier is also marked off
"Carrier is also marked off" contradicts both the code and your own v4 
changelog: the patch only adds netif_tx_disable(), there is no 
netif_carrier_off(), and v4 says you reverted the carrier change. Please 
drop this sentence — the message currently describes behavior the patch 
doesn't implement.
> 
> Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, level triggered.")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
--- is missing
> changes in v4
>    - Reverted the the statement that turned carrier off on
typo.
>      disble_traffic, as it may have side effects
typo.
> changes in v3
>    - New patch. Carrier marked off once disable_traffic is set
> ---
>   drivers/net/ethernet/oa_tc6.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 9e6850ccfe6c..4b8f6280be51 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -730,6 +730,11 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
>          skb = oa_tc6_detach_waiting_tx_skb(tc6);
>          spin_unlock_bh(&tc6->tx_skb_lock);
> 
> +       /* disable_traffic, when set, is a point of no
> +        * return to working state. TX queues are
> +        * disabled.
> +        */
Comment wraps at ~40 columns; fill to ~80 like the rest of the file.

Best regards,
Parthiban V
> +       netif_tx_disable(tc6->netdev);
>          oa_tc6_drop_tx_skb(tc6, skb);
>          oa_tc6_free_ongoing_skbs(tc6);
>          oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
> 
> --
> 2.43.0
> 
> 

