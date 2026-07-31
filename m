Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE84398F2
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511360; cv=none; b=cEue0B1NLGNiOXcKSUaD1PesMUQQ8uMF1pgaGtcWSR9lg+Orocc1PlqkgrQln557ZHGBi9qlPHPL/pn/iXzyNbEA3mIB1O0jM0DkcfR0VS787akTAmtnP1TcfyFU8wArXxqb53ZOW8K6T4oGpQZ4mUl/ZdReHq02J1kHLBGVmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511360; c=relaxed/simple;
	bh=DnP+lq4p4HmVtUtvlCxM9l2AHfwTrOC0MBXJAnbcP0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWUf8HGY83kP7lmNm8C8XrcIwjNXC+rzW6utsrUHF4XyIFTI3gietpjCvEcG5zl8zIXCGLdYy9Fq0F/9S9hKxsHTADX64aX5o12wbLdi/wwL0xZbb5X3bzJVDgTKFZ5lPPeQEoD++ftHBphuV0VC5Koc3r5vfR0FmdGsfbG1mtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxBGOJEm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxBGOJEm"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso827401a91.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511356; x=1786116156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfQPKQUvEhVM07DV/Ae6sTs9WmmayzZHa3H3lJ+JhOc=;
        b=nxBGOJEmlmqHI6XXggS6b+esuRjhC0Afihcv+mQL7/AjlDO39ayNXnhU8AyAgv4OmI
         HvznDDIyH4veaHP09KWJX8RDTGjxwsSPiqjRKgY9DnIHxsjWv/MsjkrNmLt/QpgKVCzF
         IzX7Q+XqtzPakGje2nX86UW3LcosmUGLtgguqWWjGNVENHXPQvtoMb8GQkqhBaCnWnxr
         rmefNzACp9c4rQUVWviA6dU/L7LmqnX5QGaAMhEK4AQWcY8GtevbOBniK6azGZiiKrOu
         kCS3pP60e7srh/4V0uyxE4Q0YdB6t5T0r2eF2b3Y+G5UwctQD2LKTXbO2PkZ2g/mlCGX
         F6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511356; x=1786116156;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfQPKQUvEhVM07DV/Ae6sTs9WmmayzZHa3H3lJ+JhOc=;
        b=gyLxUCJ9dzTqMVyvB/+7tH8Spozyt+ybHp/mIg05JRmPianURM/89NhFOh9mvua7Wv
         eHAsRjiPo39bN75uQ3H7U9/TXAAGxHWdwgJgMy+RW0QH8qS/UX4AvaiHfEE2GI2/9Xzv
         /fskPAuSVhHgy9/LsnGbWLbYwxtbdpwlFpXWKP54MNFxUyBdUsI69mo8ESMuZiJVJYLk
         QapqkLE56i6d/1dzQkFcs9BpOiy37HfcPvismBLeYEKqu8/heNvcZNN+wQAl9oEysqdf
         2kNJ+utXe6v/Dzw9q6MqFsAQ2xUIFSv0fZpbqIQqF+n2jfaa6Agfdnf9z2K3WLMGS7E+
         HQkw==
X-Forwarded-Encrypted: i=1; AHgh+Rok0GchrC3LFIPoV7EAtQqdxGx61F5+KmooZAU6zMVy/SMIgjldnCQXykE7hzF/fUT+mZ8U6x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWElPRaQQ2TijW89LxvsdMs/HrU4JtQIbnqDYBYf9s6t9eDBC
	pen3jqwZdL21noMcQ/cGPib3gE8saLlc1tMxKg6VdFgTUgLw8H5al8id
X-Gm-Gg: AR+sD10waJGO3NfBWWKAgoPMmNoWFkKx6n9q+sMTGtpZ+IYly1R6UORbQ3PF79Ifrhh
	P2yEioRzLTB6vOffBrWAH5pE24QuM+AyOydhrdNvwMEFEEAui6jHNnJ0Iaa9O439eKnoMUOQfMF
	IyEe3V54AXCVaPWyQCcGx4lEL9Q7ZfsHef9azPq5fU2AbIgALCvJe1WToIASzSxK6lsIX+k+dKG
	PM2nC1N4SBX9CYby34I/ZSAkMZmHzsjv4tZ18SWXEeh9USlCNN9jKIiRZPtuHiTqzZSaOc/xE07
	nLVIGdCn3jrRtE6kr3wwLizRPvLGw5Z7Ce6ogUhesuVRFAn5lzkHZtZgeuG+XZQpjo4B9pl+u+p
	qlxynLkVJ3mbgX2wxWRmEtAuALzrLsgMixIfeijINjXdzrdqCcvcizYoqdH943pcPvIFF8MiLfF
	JCycOzsaxe/fVw/Z1kNiiSKqsGEOBP+CBuvT6jdrNO4JPanyvNgnyg5WN2CtDS6CqEm5MsfpCDM
	ho+q4z8+uiA4pc0nYSw/fOH6Tog9NF2WyuDt5uXgs4kUkCobZSEL7QSy0c=
X-Received: by 2002:a17:90b:5648:b0:38e:76f8:fcbf with SMTP id 98e67ed59e1d1-38fbc55256bmr286165a91.31.1785511356037;
        Fri, 31 Jul 2026 08:22:36 -0700 (PDT)
Received: from ?IPV6:2601:646:8f02:5350:ce4:701d:f6e3:3a6b? ([2601:646:8f02:5350:ce4:701d:f6e3:3a6b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e044912sm8250572eec.15.2026.07.31.08.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:22:35 -0700 (PDT)
Message-ID: <34c8d95f-3897-498a-921c-df7c6868af61@gmail.com>
Date: Fri, 31 Jul 2026 08:22:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] i40e: xsk: use xdp_build_skb_from_zc() for
 XDP_PASS
To: Chenguang Zhao <chenguang.zhao@linux.dev>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 kerneljasonxing@gmail.com, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260731020736.170485-1-chenguang.zhao@linux.dev>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260731020736.170485-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/26 7:07 PM, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Replace the driver-local i40e_construct_skb_zc() with the common
> helper xdp_build_skb_from_zc(). On failure, free the xdp buff in
> the caller.
> 
> xdp_build_skb_from_zc() already calls skb_record_rx_queue() and
> eth_type_trans(), so pull the remaining descriptor field setup into
> __i40e_process_skb_fields() and use that on the XDP_PASS path.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v3:
>   As suggested by Larysa:
>   - Drop eth_skb_pad() on the XDP_PASS path, along with the
>     temporary __skb_push()/__skb_pull() around it. The stack
>     handles short skbs and other vendors do not pad on Rx.
> 
> v2:
>   - https://lore.kernel.org/all/20260729054916.720750-1-chenguang.zhao@linux.dev/
> 
> v1:
>   - https://lore.kernel.org/all/20260724020125.246333-1-chenguang.zhao@linux.dev/
> ---
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++--
>   .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 79 ++-----------------
>   3 files changed, 33 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index ef5e657816f0..87553b14d34a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1833,17 +1833,17 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
>   }
>   
>   /**
> - * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
> + * __i40e_process_skb_fields - Populate skb fields from Rx descriptor
>    * @rx_ring: rx descriptor ring packet is being transacted on
>    * @rx_desc: pointer to the EOP Rx descriptor
>    * @skb: pointer to current skb being populated
>    *
> - * This function checks the ring, descriptor, and packet information in
> - * order to populate the hash, checksum, VLAN, protocol, and
> - * other fields within the skb.
> + * Populate hash, checksum, PTP timestamp and VLAN from @rx_desc. Does not
> + * call skb_record_rx_queue() or eth_type_trans(); callers that already got
> + * those from xdp_build_skb_from_zc() should use this helper.
>    **/
> -void i40e_process_skb_fields(struct i40e_ring *rx_ring,
> -			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
> +void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			       union i40e_rx_desc *rx_desc, struct sk_buff *skb)
>   {
>   	u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
>   	u32 rx_status = FIELD_GET(I40E_RXD_QW1_STATUS_MASK, qword);
> @@ -1858,14 +1858,30 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>   
>   	i40e_rx_checksum(rx_ring->vsi, skb, rx_desc);
>   
> -	skb_record_rx_queue(skb, rx_ring->queue_index);
> -
>   	if (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) {
>   		__le16 vlan_tag = rx_desc->wb.qword0.lo_dword.l2tag1;
>   
>   		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
>   				       le16_to_cpu(vlan_tag));
>   	}
> +}
> +
> +/**
> + * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
> + * @rx_ring: rx descriptor ring packet is being transacted on
> + * @rx_desc: pointer to the EOP Rx descriptor
> + * @skb: pointer to current skb being populated
> + *
> + * This function checks the ring, descriptor, and packet information in
> + * order to populate the hash, checksum, VLAN, protocol, and
> + * other fields within the skb.
> + **/
> +void i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
> +{
> +	__i40e_process_skb_fields(rx_ring, rx_desc, skb);
> +
> +	skb_record_rx_queue(skb, rx_ring->queue_index);
>   
>   	/* modifies the skb - consumes the enet header */
>   	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> index e26807fd2123..3c52e0e60487 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> @@ -9,6 +9,8 @@
>   int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring);
>   void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
>   				   u64 qword1);
> +void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			       union i40e_rx_desc *rx_desc, struct sk_buff *skb);
>   void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>   			     union i40e_rx_desc *rx_desc, struct sk_buff *skb);
>   void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..dfa519c30a0d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -3,6 +3,7 @@
>   
>   #include <linux/bpf_trace.h>
>   #include <linux/unroll.h>
> +#include <net/xdp.h>
>   #include <net/xdp_sock_drv.h>
>   #include "i40e_txrx_common.h"
>   #include "i40e_xsk.h"
> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
>   	return count == nb_buffs;
>   }
>   
> -/**
> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
> - * @rx_ring: Rx ring
> - * @xdp: xdp_buff
> - *
> - * This functions allocates a new skb from a zero-copy Rx buffer.
> - *
> - * Returns the skb, or NULL on failure.
> - **/
> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
> -					     struct xdp_buff *xdp)
> -{
> -	unsigned int totalsize = xdp->data_end - xdp->data_meta;
> -	unsigned int metasize = xdp->data - xdp->data_meta;
> -	struct skb_shared_info *sinfo = NULL;
> -	struct sk_buff *skb;
> -	u32 nr_frags = 0;
> -
> -	if (unlikely(xdp_buff_has_frags(xdp))) {
> -		sinfo = xdp_get_shared_info_from_buff(xdp);
> -		nr_frags = sinfo->nr_frags;
> -	}
> -	net_prefetch(xdp->data_meta);
> -
> -	/* allocate a skb to store the frags */
> -	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> -	if (unlikely(!skb))
> -		goto out;
> -
> -	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> -	       ALIGN(totalsize, sizeof(long)));
> -
> -	if (metasize) {
> -		skb_metadata_set(skb, metasize);
> -		__skb_pull(skb, metasize);
> -	}
> -
> -	if (likely(!xdp_buff_has_frags(xdp)))
> -		goto out;
> -
> -	for (int i = 0; i < nr_frags; i++) {
> -		struct skb_shared_info *skinfo = skb_shinfo(skb);
> -		skb_frag_t *frag = &sinfo->frags[i];
> -		struct page *page;
> -		void *addr;
> -
> -		page = dev_alloc_page();
> -		if (!page) {
> -			dev_kfree_skb(skb);
> -			return NULL;
> -		}
> -		addr = page_to_virt(page);
> -
> -		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
> -
> -		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> -					   addr, 0, skb_frag_size(frag));
> -	}
> -
> -out:
> -	xsk_buff_free(xdp);
> -	return skb;
> -}
> -
>   static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>   				      struct xdp_buff *xdp_buff,
>   				      union i40e_rx_desc *rx_desc,
> @@ -372,21 +309,19 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>   		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>   		 * SBP is *not* set in PRT_SBPVSI (default not set).
>   		 */
> -		skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
> +		skb = xdp_build_skb_from_zc(xdp_buff);
>   		if (!skb) {
> +			xsk_buff_free(xdp_buff);
>   			rx_ring->rx_stats.alloc_buff_failed++;
>   			*rx_packets = 0;
>   			*rx_bytes = 0;
>   			return;
>   		}
>   
> -		if (eth_skb_pad(skb)) {
> -			*rx_packets = 0;
> -			*rx_bytes = 0;
> -			return;
> -		}
> -
> -		i40e_process_skb_fields(rx_ring, rx_desc, skb);
> +		/* xdp_build_skb_from_zc() already ran eth_type_trans() and
> +		 * skb_record_rx_queue().
> +		 */
> +		__i40e_process_skb_fields(rx_ring, rx_desc, skb);
>   		napi_gro_receive(&rx_ring->q_vector->napi, skb);
>   		return;
>   	}

The cleanup makes sense. I think you would also need to update kconfig. 
xdp_build_skb_from_zc() verifies page pool support and if 
CONFIG_PAGE_POOL=n, it would return NULL. In that case, we would end-up 
dropping packets in XDP_PASS.

With that addressed:
Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
