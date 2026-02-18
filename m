Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B762D9ECA
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402168; cv=none; b=KzpNCbNoc0QGnyaKHkqrs53ssA2cFijWU/2ZLg2oAMGJR0KCSd/0KdQ0Rkk672PDycusxr85t/tgl+GN+KKIy0XX+BCoR/TxjoIG6a2YV8kp2iMlJkF+Doj+Xyx0gSo3PfFGYaCPT6wTU8vmMxPlc45U5ki2YsmXy6xLH6xtbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402168; c=relaxed/simple;
	bh=J2FD7AOpQGTqNlvmjVg1GLe71TpEryB8hAFBtlmZ0aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBg/c9MOWiwKZHFPM8jkN4D214czaEwoPwsou3xe+xlCmvgv1l/uPMwG4UoSsv82amsoJBZUftftyL31qL6kemhDb0d11ejXXfppV2pIytuQbuXxD72e2z636KkLkjIkdPhU2SlvNHRlazh9rJ16OG5MfP1CZh60LM4/DDy/iOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.221] (p5b13aefb.dip0.t-ipconnect.de [91.19.174.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0E36E4C2C37D4C;
	Wed, 18 Feb 2026 09:08:44 +0100 (CET)
Message-ID: <d5debf35-e07b-45ff-a1cb-076b77a91694@molgen.mpg.de>
Date: Wed, 18 Feb 2026 09:08:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igc: fix missing update of
 skb->tail in igc_xmit_frame()
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Neftin <sasha.neftin@intel.com>, kohei.enju@gmail.com
References: <20260214194636.295647-1-kohei@enjuk.jp>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260214194636.295647-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kohei,


Thank you for your patch.

Am 14.02.26 um 20:46 schrieb Kohei Enju:
> igc_xmit_frame() misses updating skb->tail when the packet size is
> shorter than the minimum one.
> Use skb_put_padto() in alignment with other Intel Ethernet drivers.
> 
> Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1abbdbebf8a4..7ebeca5333b6 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1727,11 +1727,8 @@ static netdev_tx_t igc_xmit_frame(struct sk_buff *skb,
>   	/* The minimum packet size with TCTL.PSP set is 17 so pad the skb
>   	 * in order to meet this minimum size requirement.
>   	 */
> -	if (skb->len < 17) {
> -		if (skb_padto(skb, 17))
> -			return NETDEV_TX_OK;
> -		skb->len = 17;
> -	}
> +	if (skb_put_padto(skb, 17))
> +		return NETDEV_TX_OK;
>   
>   	return igc_xmit_frame_ring(skb, igc_tx_queue_mapping(adapter, skb));
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
