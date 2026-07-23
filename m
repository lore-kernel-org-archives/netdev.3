Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8283DAAAB
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790171; cv=none; b=dsr815tMEGFd/vT5kdhY2rtmB61WGJkg7SG3gaurFmti/CqcimO22B8Y74PH15wjxvSaSKvIM2TFPNU6ajFzpUksnyU1DyAcctdviGCrds0rDlQtzDd81SjmKaITxgFKOEtQZ8I6nh1x0eL+200Om0qU6H5zcLKk0HEpzyAehAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790171; c=relaxed/simple;
	bh=0nHQoqO0ZldmrmERHt4qRwD3p9/bmgGdtWDifPLBLug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVBD4t2JxSnOuGBjra9kojZRUgNcK+tav0J6yDadu+2wi4V2lnzb9KelBVhJlyDXhx8IJ8WtM5fOVRtHoy1RkwjjnwCB8a8ZTElJloUXd8LAWVagzZ5zjikMf9TCG+HOPC1bVbiIFn04KlMwZ92aClWh/lu0wvoiRrPuw1bIBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E4nj7eoa; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E4nj7eoa"
Message-ID: <20f83ab8-d99f-4b10-bab1-cd5c6202937c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784790165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOURQ+zBINwB3RQ/XOplI8aNDuWjLCRWLUDyous7DQo=;
	b=E4nj7eoaFNC5GMlR04WIlRj7hqZwFacoRfor5D5HPLiDPqP8OQHNT9iyTacOpdZBOzXRRq
	QJM50VEjxqlx/xboFNZPMRKZmk7lFUT2po4NbOJYE5hMWOC+PDHk3I4L7HIwNH7xFJMAF9
	5Q7KtANekeIK0uYXg1vCquiYroZX+tY=
Date: Thu, 23 Jul 2026 15:02:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] i40e: xsk: fix multi-buffer XDP_PASS skb
 construction
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260717012416.168107-1-chenguang.zhao@linux.dev>
 <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for the clarification.

I agree: the minimal bugfix belongs in -net for stable backportability, and the conversion to xdp_build_skb_from_zc() belongs in -next.

Please apply the existing v1 bugfix to -net:

     https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/

It already has :

    Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I will drop v2 as a Fixes candidate.

In parallel, I will send a separate net-next series (as v1) that replaces

i40e_construct_skb_zc() with xdp_build_skb_from_zc(), based on 

net-next. That patch will not carry a Fixes tag.


Thanks,

Chenguang


在 2026/7/22 07:15, Jason Xing 写道:
> On Fri, Jul 17, 2026 at 9:24 AM Chenguang Zhao <chenguang.zhao@linux.dev> wrote:
>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>
>> When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
>> i40e_construct_skb_zc() copied frags incorrectly: memcpy used
>> skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
>> given a virtual address instead of a struct page *.
>>
>> Drop the custom helper and use xdp_build_skb_from_zc() instead. On
>> failure, free the xdp buff in the caller. Push the Ethernet header
>> back before eth_skb_pad()/i40e_process_skb_fields() because
>> xdp_build_skb_from_zc() already called eth_type_trans().
>>
>> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>> ---
>> Revised as suggested by Maciej:
>>  - Replace i40e_construct_skb_zc() with xdp_build_skb_from_zc()
> I might have a different opinion on this patch: yes, it actually
> belongs to -next material. The process should be like: 1) fix the
> issues by v1, 2) refactor it by v2. The reason behind that is the
> helper was introduced in 2024 while the home-grown part was in 2023,
> which means it doesn't help for stable steam to cherry-pick the patch
> in older kernels like 6.6[1].
>
> [1]: https://www.kernel.org/
>
> Thanks,
> Jason
>
>> v1:
>>  https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/
>>
>>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 73 +++-------------------
>>  1 file changed, 8 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> index 9f47388eaba5..1319a5c22625 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> @@ -3,6 +3,7 @@
>>
>>  #include <linux/bpf_trace.h>
>>  #include <linux/unroll.h>
>> +#include <net/xdp.h>
>>  #include <net/xdp_sock_drv.h>
>>  #include "i40e_txrx_common.h"
>>  #include "i40e_xsk.h"
>> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
>>         return count == nb_buffs;
>>  }
>>
>> -/**
>> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
>> - * @rx_ring: Rx ring
>> - * @xdp: xdp_buff
>> - *
>> - * This functions allocates a new skb from a zero-copy Rx buffer.
>> - *
>> - * Returns the skb, or NULL on failure.
>> - **/
>> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
>> -                                            struct xdp_buff *xdp)
>> -{
>> -       unsigned int totalsize = xdp->data_end - xdp->data_meta;
>> -       unsigned int metasize = xdp->data - xdp->data_meta;
>> -       struct skb_shared_info *sinfo = NULL;
>> -       struct sk_buff *skb;
>> -       u32 nr_frags = 0;
>> -
>> -       if (unlikely(xdp_buff_has_frags(xdp))) {
>> -               sinfo = xdp_get_shared_info_from_buff(xdp);
>> -               nr_frags = sinfo->nr_frags;
>> -       }
>> -       net_prefetch(xdp->data_meta);
>> -
>> -       /* allocate a skb to store the frags */
>> -       skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
>> -       if (unlikely(!skb))
>> -               goto out;
>> -
>> -       memcpy(__skb_put(skb, totalsize), xdp->data_meta,
>> -              ALIGN(totalsize, sizeof(long)));
>> -
>> -       if (metasize) {
>> -               skb_metadata_set(skb, metasize);
>> -               __skb_pull(skb, metasize);
>> -       }
>> -
>> -       if (likely(!xdp_buff_has_frags(xdp)))
>> -               goto out;
>> -
>> -       for (int i = 0; i < nr_frags; i++) {
>> -               struct skb_shared_info *skinfo = skb_shinfo(skb);
>> -               skb_frag_t *frag = &sinfo->frags[i];
>> -               struct page *page;
>> -               void *addr;
>> -
>> -               page = dev_alloc_page();
>> -               if (!page) {
>> -                       dev_kfree_skb(skb);
>> -                       return NULL;
>> -               }
>> -               addr = page_to_virt(page);
>> -
>> -               memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
>> -
>> -               __skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
>> -                                          addr, 0, skb_frag_size(frag));
>> -       }
>> -
>> -out:
>> -       xsk_buff_free(xdp);
>> -       return skb;
>> -}
>> -
>>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>>                                       struct xdp_buff *xdp_buff,
>>                                       union i40e_rx_desc *rx_desc,
>> @@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>>                  * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>>                  * SBP is *not* set in PRT_SBPVSI (default not set).
>>                  */
>> -               skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
>> +               skb = xdp_build_skb_from_zc(xdp_buff);
>>                 if (!skb) {
>> +                       xsk_buff_free(xdp_buff);
>>                         rx_ring->rx_stats.alloc_buff_failed++;
>>                         *rx_packets = 0;
>>                         *rx_bytes = 0;
>>                         return;
>>                 }
>>
>> +               /* xdp_build_skb_from_zc() already ran eth_type_trans();
>> +                * restore the header for eth_skb_pad()/process_skb_fields().
>> +                */
>> +               __skb_push(skb, skb->data - skb_mac_header(skb));
>> +
>>                 if (eth_skb_pad(skb)) {
>>                         *rx_packets = 0;
>>                         *rx_bytes = 0;
>> --
>> 2.25.1
>>
>>
