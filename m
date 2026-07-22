Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904A470106
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705876; cv=none; b=idb2j7AclAsnamclvyqzkVz+mDWRAjsPqtIa5h1yP4duVvZ2p3Rg/6PW6wAtK+DB56uDUYlklCLB61dt3+zZrbQM/aJh4KaX833lsJIKhqB87ufVqJVPE+U2NF+3NJGd6nOdgmYbFrFlE4WRKuJuB8muBWzdD6KAKNr9TM8pWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705876; c=relaxed/simple;
	bh=dlrz+Z9u90xfxHvOqJSUYMwYB8pU1c6ILctpKrvGjUs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=buAJGDb1HQUHqusija+1qd8ytOf/v6FMIowpe4JHckLYn+KE1fnyk2sQNa8zBy1R92I7TQIj/+LdxCZh7eeirLYKu4MB7qAdstHMs7/wc3SnxSwOHs0maTv3I01d/VklrP5nIkvzTUtQL/7MUrsN3VjNwDK6ONuYy1mK1s+KA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QgJ/zlKH; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QgJ/zlKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=/MCglywllKbwduRxD/1kZ34U7Dm60ws86ArABKfGdAE=;
	b=QgJ/zlKHaD1u9Im2CezyaBtqWQ1ISdKUops15S3h1SYzv+TvnS44Sw/qPdzuEp
	DQQIN7Pfs7SxKiEyIQcGsncti+rb2KhitGqAjse8D31XxEpbkMBT8f1a/oYA4HD9
	PxUFqxhlilhJ0VLm20I+xs7ic5YXNEsNN0AFh6H6ZjyKA=
Received: from [172.21.20.151] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3ovAec2BqYlO8Jg--.118S2;
	Wed, 22 Jul 2026 15:37:06 +0800 (CST)
Message-ID: <43379065-5916-42a7-8ecc-4b875ea53d22@163.com>
Date: Wed, 22 Jul 2026 15:37:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] 8139cp: fix DMA mapping unwind on TX frag map
 failure
From: luyun <luyun_611@163.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20260717103724.13971-1-luyun_611@163.com>
 <20260717103724.13971-2-luyun_611@163.com>
Content-Language: en-US
In-Reply-To: <20260717103724.13971-2-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3ovAec2BqYlO8Jg--.118S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1xZrW5Zr4fuw48CF17Wrg_yoW5AryDpa
	1Yya4YkFs5Xr1qv3WxJay2qr45Z3Wrt34Y9FyrC3s5ursxZF1SqFWxWFy5ArWDGFW8WFWx
	trs0yFyfCF15trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRhIDxUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wKXZmpgcyITWgAA3K

Hi,

A gentle ping for this series, the number of patches is 2, not 13. I made a mistake
when generating the patches. Please ignore it.

Any comments or reviews would be greatly appreciated.

Thanks,
Yun

在 2026/7/17 18:37, Yun Lu 写道:
> From: Yun Lu <luyun@kylinos.cn>
>
> When dma_map_single() fails for one of the TX fragments in
> cp_start_xmit(), unwind_tx_frag_mapping() is supposed to drop the
> DMA mappings that have been established so far. The current code
> gets this wrong in three ways:
>
> - it unmaps the DMA address read from the descriptor of the head
>    slot, but the head descriptor is only written after the fragment
>    loop, so a stale address of a previously completed (and already
>    unmapped) packet gets unmapped again;
> - the unmap sizes are off by one slot: slot first_entry + 1 + k
>    holds frags[k], but is unmapped with the size of frags[k + 1];
> - the head buffer mapping (first_mapping) is never unmapped at all,
>    leaking one DMA mapping on every failure.
>
> Pass the head mapping and its length to the unwind helper, unmap it
> explicitly, and unmap the successfully mapped fragments with their
> matching sizes.
>
> Fixes: cf3c4c03060b ("8139cp: Add dma_mapping_error checking")
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>   drivers/net/ethernet/realtek/8139cp.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
> index 5652da8a178c..03929bb0bd79 100644
> --- a/drivers/net/ethernet/realtek/8139cp.c
> +++ b/drivers/net/ethernet/realtek/8139cp.c
> @@ -713,13 +713,24 @@ static inline u32 cp_tx_vlan_tag(struct sk_buff *skb)
>   }
>   
>   static void unwind_tx_frag_mapping(struct cp_private *cp, struct sk_buff *skb,
> +				   dma_addr_t first_mapping, u32 first_len,
>   				   int first, int entry_last)
>   {
>   	int frag, index;
> -	struct cp_desc *txd;
> -	skb_frag_t *this_frag;
> -	for (frag = 0; frag+first < entry_last; frag++) {
> -		index = first+frag;
> +
> +	/* The head mapping was never written to the ring, unmap it
> +	 * using the saved address.
> +	 */
> +	dma_unmap_single(&cp->pdev->dev, first_mapping, first_len,
> +			 DMA_TO_DEVICE);
> +	cp->tx_skb[first] = NULL;
> +
> +	/* Unmap the frags that were successfully mapped. */
> +	for (frag = 0; first + 1 + frag < entry_last; frag++) {
> +		struct cp_desc *txd;
> +		skb_frag_t *this_frag;
> +
> +		index = first + 1 + frag;
>   		cp->tx_skb[index] = NULL;
>   		txd = &cp->tx_ring[index];
>   		this_frag = &skb_shinfo(skb)->frags[frag];
> @@ -828,7 +839,9 @@ static netdev_tx_t cp_start_xmit (struct sk_buff *skb,
>   						 skb_frag_address(this_frag),
>   						 len, DMA_TO_DEVICE);
>   			if (dma_mapping_error(&cp->pdev->dev, mapping)) {
> -				unwind_tx_frag_mapping(cp, skb, first_entry, entry);
> +				unwind_tx_frag_mapping(cp, skb, first_mapping,
> +						       first_len, first_entry,
> +						       entry);
>   				goto out_dma_error;
>   			}
>   

