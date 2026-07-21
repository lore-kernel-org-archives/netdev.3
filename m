Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621A13B840F
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675770; cv=pass; b=TjHI/6YYPRhE77KBAUoOgTXgZw0AcVgYJIOSH9awCcNT1FhJMBl/0iVXKnj0RdefHFpp7+20CUZ1afDuADG34PQW5919xobauHaeFCkL2JsFBJbN4fyGd0xAydLus3UXWe+bQmEbFx8RK+CF9dXkXKlTM4U9Q48bkBgEWXkTPBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675770; c=relaxed/simple;
	bh=K3vwbJgta4mPjl2UvmCjVZq394q/XKHZcGeWcgfB/1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts98Q+ikDr9QVmIYKiTOGOx15cQSU1k2czPI+aCwm+5zvvxL+VECb6a05Si9SKA3ui9ElPtS5SjdVl/eNTZ5tXjTbtDBA9NLF8Qj+Bi0f9tLeVl9VZON4dS/3cyqXleFzCDtFscC+rBr403ckJHd34T+xR/ZYaHO4GNV7aGM9c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwL2DmjO; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwL2DmjO"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39eb257e9fbso34201951fa.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784675766; cv=none;
        d=google.com; s=arc-20260327;
        b=RSd11KfJNxoQSQhdv0T/iLpDuuSpQPDVTU9bNoTqkX5WDWpB19G8sPTBieP+Bf1US8
         oqq7MwNtJoIxe2Zwx3koScQJ9z9ERiXwSVXMheLTEQNwA+jZjcEyCjHX7i/E7ACYZQ3N
         TtZ2O0VS/E+jg6/XfTFeUDE+T7+pwdMN3uj0EvNtvhi7oYHTkZ/4v92F41lNBQTUUsJk
         6YhYQYrTaR4StlTyRCdAESI/CwxOBMtZKCFYKAIctkWpAjhSdOi6oWY7H6LBTd6sUcBH
         pqtqo8E5CtclAb+Q3HNDZX2Ke6eC1Nhz8ipAPGynxboBZ/pBKfLUUyTgYdIdp5irJenA
         TPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LTrgY5zF2M3nMKJvPh+FFXaA1E6Ck1f9mjx2//PbJRo=;
        fh=zleQflP6ssACWzERyHAeqFQSm13g0xWS6t5PiYOVbVk=;
        b=R1XaJVuN5NsP/OkqCMQBHaRN9m86qq0KhhPVd0/mT1j10V93b0OOGrh+wOwyLhARMz
         i4FaapEVlVIe8Bul5JlLEfU/EKVNFfQwKzyqhdWU9fpaXkjF1+OhyI+Xiu7FPioqQLnG
         PzpE+ixNjWNfkKSNuzD3thKgJXMyEFbEQbWfziP2MNhVni+KIuE/bbpwjfGMrF+O+ftp
         mypnHhrNq0pxF85yrwi5vHx/nXVdIX6FH8a2NyTrLW+RBzN9zrZ44/YFj5T3IHo54tg0
         FXzYJr2+VFpncJFDs840d4CCQ4/80EQIoXkkHfwDk2O4qyLzWpXLov0qs0jsjXmPCLTc
         w+hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784675766; x=1785280566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LTrgY5zF2M3nMKJvPh+FFXaA1E6Ck1f9mjx2//PbJRo=;
        b=AwL2DmjObOSEBTc7mMPUbmDP9h1t9QgtsiCzRCdWmIcs4xi933nyQQmC6oZs9OAGy7
         6FidBBnVMfiVKNsSRBzRg6vu13OqlYgwvcv/lyP9iKg50cdB5KIWXtYQFTzHv79TJhDB
         GOkx0hurmIEuEE57wDaknKSdFXhbMr5D2FoTp0RFMUv7e3rLH/rdUtB4Kk6I44GtdFD9
         or8JEMDBPxut9w/oCxnk2bE3BQZyOdNUQjZcBVmEy/2N2iGKV16uxyZWWaQEyrRUGL5r
         YkLrbqzTLpweN5BieZkJCCSNCkGbIyrhVEQ7ZcwzknX5PorgAFsghvP/MBPq2CWYsQ0O
         AfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675766; x=1785280566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTrgY5zF2M3nMKJvPh+FFXaA1E6Ck1f9mjx2//PbJRo=;
        b=U/wSND+TAqzkYW6xg6NZyoaKjHmXk0fsbGvUKTltDf+UtNQLRJeIqsHYa5PZ53sZEh
         jrAHcJJx5FLvefSEy0SkCVSoA7cKx0HzpO6a6eK0BJWO1UJhWHhtPKnAdiajvSb4NILs
         picAf+xUKumjWwgl3jWvi1YFK7d/V03oH9qwItAYaCEnjwjDHFg62cs3pjBdecqoRcki
         IHgfON/jbbiD6fl4hLaMv5eXrOq8JN/36IT6IL8Uu6bdcBvGqpblBUJdiTfXoKRu9OIn
         i5o5yeZ2BAVfwKh3wHt+WmqfzfhuaLXqHKKCzv6qY0AyU7u+ntXfySmeMpAEWGJIe8gG
         RxzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvXDM3HS8+pjVpuVaFVeFtGX1RMthyod0sERCBE+Axh3+6GC0CvgNhxbmPYgOv8/hVW/MkHQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3S241uDAUt4Q1odvKHPvGuJRAX1Tg+dxOZaYIUbHq1u+jBhe
	6kG93ZfAnaXWktzmyW97QRhodqBKLQbuG8z3YBq1YqODh6RAFj/VpvTOuefWrNG2NjLfyXcTpGV
	5zpmdlxjGR1TG3P9T0+2fR/Ila8bf0JI=
X-Gm-Gg: AR+sD11KCeGawHo78VqwMVNICjoIimLtgPzC3HJLqBLV3ZJlq7Qw+F/7LuugZO/O217
	iGj94WTjZtfSdt8IlqwO5UZxwEAFpD+cg9lBRz9gFRwdMcxAjAjCjZvXbH9yeao6Z9fSl2RM0i4
	yxnKie3YWa0O6fIcJb1VASGWkOkFrZai4se/VFqUqn60R9kTkxxFwp9mfrItgr3doXdcZQF/v6g
	QFfYH+UkJeX0wHWZrSmkTKskTpVTVGou1jzWcLRCp5k4RTMgGY1XZ7ULo/yhG8/BmlzglehrQUx
	/feMwrIAsKM7cDNqFf2ZgZj4tDd10Kmd2kRZv5kJ4sFKOunBUCmlSiVSAXRo794wctuo3vamqt4
	=
X-Received: by 2002:a05:6512:3d0d:b0:5ae:b86b:71ee with SMTP id
 2adb3069b0e04-5b28f998d25mr4200656e87.38.1784675766155; Tue, 21 Jul 2026
 16:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717012416.168107-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260717012416.168107-1-chenguang.zhao@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Jul 2026 07:15:28 +0800
X-Gm-Features: AUfX_mxQea9F49gwqUrjVFazKRlYsxiuTSbn67aBB0jdhefEUWVCROGSEtHMdSE
Message-ID: <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com>
Subject: Re: [PATCH net v2] i40e: xsk: fix multi-buffer XDP_PASS skb construction
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 9:24=E2=80=AFAM Chenguang Zhao <chenguang.zhao@linu=
x.dev> wrote:
>
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>
> When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
> i40e_construct_skb_zc() copied frags incorrectly: memcpy used
> skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
> given a virtual address instead of a struct page *.
>
> Drop the custom helper and use xdp_build_skb_from_zc() instead. On
> failure, free the xdp buff in the caller. Push the Ethernet header
> back before eth_skb_pad()/i40e_process_skb_fields() because
> xdp_build_skb_from_zc() already called eth_type_trans().
>
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> Revised as suggested by Maciej:
>  - Replace i40e_construct_skb_zc() with xdp_build_skb_from_zc()

I might have a different opinion on this patch: yes, it actually
belongs to -next material. The process should be like: 1) fix the
issues by v1, 2) refactor it by v2. The reason behind that is the
helper was introduced in 2024 while the home-grown part was in 2023,
which means it doesn't help for stable steam to cherry-pick the patch
in older kernels like 6.6[1].

[1]: https://www.kernel.org/

Thanks,
Jason

>
> v1:
>  https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux=
.dev/
>
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 73 +++-------------------
>  1 file changed, 8 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/eth=
ernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..1319a5c22625 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -3,6 +3,7 @@
>
>  #include <linux/bpf_trace.h>
>  #include <linux/unroll.h>
> +#include <net/xdp.h>
>  #include <net/xdp_sock_drv.h>
>  #include "i40e_txrx_common.h"
>  #include "i40e_xsk.h"
> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_r=
ing, u16 count)
>         return count =3D=3D nb_buffs;
>  }
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
> -                                            struct xdp_buff *xdp)
> -{
> -       unsigned int totalsize =3D xdp->data_end - xdp->data_meta;
> -       unsigned int metasize =3D xdp->data - xdp->data_meta;
> -       struct skb_shared_info *sinfo =3D NULL;
> -       struct sk_buff *skb;
> -       u32 nr_frags =3D 0;
> -
> -       if (unlikely(xdp_buff_has_frags(xdp))) {
> -               sinfo =3D xdp_get_shared_info_from_buff(xdp);
> -               nr_frags =3D sinfo->nr_frags;
> -       }
> -       net_prefetch(xdp->data_meta);
> -
> -       /* allocate a skb to store the frags */
> -       skb =3D napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> -       if (unlikely(!skb))
> -               goto out;
> -
> -       memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> -              ALIGN(totalsize, sizeof(long)));
> -
> -       if (metasize) {
> -               skb_metadata_set(skb, metasize);
> -               __skb_pull(skb, metasize);
> -       }
> -
> -       if (likely(!xdp_buff_has_frags(xdp)))
> -               goto out;
> -
> -       for (int i =3D 0; i < nr_frags; i++) {
> -               struct skb_shared_info *skinfo =3D skb_shinfo(skb);
> -               skb_frag_t *frag =3D &sinfo->frags[i];
> -               struct page *page;
> -               void *addr;
> -
> -               page =3D dev_alloc_page();
> -               if (!page) {
> -                       dev_kfree_skb(skb);
> -                       return NULL;
> -               }
> -               addr =3D page_to_virt(page);
> -
> -               memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
> -
> -               __skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> -                                          addr, 0, skb_frag_size(frag));
> -       }
> -
> -out:
> -       xsk_buff_free(xdp);
> -       return skb;
> -}
> -
>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>                                       struct xdp_buff *xdp_buff,
>                                       union i40e_rx_desc *rx_desc,
> @@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40e_r=
ing *rx_ring,
>                  * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>                  * SBP is *not* set in PRT_SBPVSI (default not set).
>                  */
> -               skb =3D i40e_construct_skb_zc(rx_ring, xdp_buff);
> +               skb =3D xdp_build_skb_from_zc(xdp_buff);
>                 if (!skb) {
> +                       xsk_buff_free(xdp_buff);
>                         rx_ring->rx_stats.alloc_buff_failed++;
>                         *rx_packets =3D 0;
>                         *rx_bytes =3D 0;
>                         return;
>                 }
>
> +               /* xdp_build_skb_from_zc() already ran eth_type_trans();
> +                * restore the header for eth_skb_pad()/process_skb_field=
s().
> +                */
> +               __skb_push(skb, skb->data - skb_mac_header(skb));
> +
>                 if (eth_skb_pad(skb)) {
>                         *rx_packets =3D 0;
>                         *rx_bytes =3D 0;
> --
> 2.25.1
>
>
