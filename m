Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54063470EB5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793626; cv=pass; b=ESUyceYF5nJhwjsGfHYIYWVWndETMT4e6/BnGswMp1BYBkPvQhSzpKy+sTAHxPdOAekqZVS9XF4/h26YzvBWUSWlVIWVvxNjB12PxgxkpRfGOGQL0TDsJxh9AxzQdsJw0CzJmzRnDoqwkEgVWFAPumdR7qxPWmFmsy+nj3jq2sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793626; c=relaxed/simple;
	bh=A6VdHgg5aksQ8wKFRCWIhPIeduG6QGvXk3di0T48H9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKDNrBwPGNsMKz8vE7w0pt2nJTEBCjdwQGjpTFqGCiANE657KUEaeRvNlCiEwMVrh7PmzmhOUM6cFf4W+iYEi/1JQ4V27q2LkVbnllJ5p4z4yQfy//6qp9nNbuopn2WEE/BIlJiZs94pUuAJgnr1tKXlv1TjT4+NhaQtZp2d1xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEx5wA/S; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEx5wA/S"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so219222e87.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784793622; cv=none;
        d=google.com; s=arc-20260327;
        b=Xwkl04va3YJZZhFvByIKuMjWz3iCSWA9ScsklMXkKcNYwVm0YrGkwWHF+B5JCj9lrN
         z2nYxwgBcRyjIgkkzHMW6Gn6kqZhtV2FowyRwYMgqT6FIxK666pgvuBIJsxMGVG2gw8u
         clbzPvP0bA1NpOjrvjqFLOt8QeAl/XVbIPArywvgM94YI/amGzDWTdIW0TOJQHUAADAH
         kPeXwrj6D3JTAdy5b+6E8I+VTxrZo8L2056kQ2bQTtkhOCUpNbXHxmMYDh8TlwqFr4Sc
         4UpohDWjU0bTr0Qw8sohIlUGLfDcMgCbacM1B5ypUNcdovDv9QAcANELp9bEMGbHhsbR
         u7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yDSw7cLGMZBEj6tDvGzyv6D8i/WyEhVowI6BcRy6/cs=;
        fh=pssgkP3U9yF5E958XlN15I2XL/4SfNLhSTQFnCvSXAM=;
        b=PJmiiFLeBuSfdd236wragLmE31kwnz01IQd5NoVpsTTOQIoyEM5HZoArNVeILkHn3v
         iOnX1BCFVltsWiRTCxCc/zYBGEUP3PUI+vEvtwvcjTk+WPtLxmejuBxLbXAQOh6kKxas
         rf+jsn/XSg3LhW51Q3AvxuVqx30LpqH60s2sFCfBrpH4sCmFfp2xFS3SbnmyaBGuIWyd
         LlXO9vwyziqzA/si/CSxk5PK+hEe45fM/6yeASwtn5F6ajH/lDoH2aiRQTEyr1GrJwQJ
         GYoYMYIpA7YvpFE+XacJfDzlLczEp1ix+Iv8Jm2tsTnTyjykN2yNmquPn9JY6BMq4bpa
         TVxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784793622; x=1785398422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yDSw7cLGMZBEj6tDvGzyv6D8i/WyEhVowI6BcRy6/cs=;
        b=fEx5wA/S3LmblZCkf9nNSELsrBszBgRtde16kb04CjNJmaIVwcPB7OWX8JzWJivoHn
         ZhEnaAa1hsfKQdV8lND7UgkYYu8FKz33EqNg9TABi/GJ64F4zh2Un7l3s9CK4P2AzSVk
         kjOhYcA57Eff11Txase5n4+YT1XcCrWrrTKh0DNCebiTrFX2nLuUfSnNOkw0VeSmSfAa
         7ck7GaBAqOaNFypWYZOg0q8sq/ekMfQJMVt7LB1ipbL7tO2xaWAQ0zGcjBt18Pz+DjK/
         f9H1EFZl5nIetTLh2DccGve4cwRYbWVpiSNTezR0NoWMBQYJOPz0kTKpMnPYcVzlqS6b
         Xn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784793622; x=1785398422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDSw7cLGMZBEj6tDvGzyv6D8i/WyEhVowI6BcRy6/cs=;
        b=AFkxJ9xUg6uwhrsYQWh5acQN9mFnrwBfKDplLOdnes5l3wIRqbBwXo0RVtIwVFaZkZ
         Pz8ceACYcquunYpMo7QFFlEGFqByQNx4N1MxEuUB3dD2vz+QqI56w2PaEObHa+byycbR
         NYgOMHGSprWEYAWBpPCoV0EfopEra7j7Jh0Gxh2sbxLH/gbggG9pydkS5QPJSiUezz4R
         mFfjZt8+bXx5OnHVpRwHGKVMYOF8IUKpV8Rme6Mgp2/j2fsn/3cwGY08qwBPsVuDp3TR
         JHOhPWf4GcmLUDCSJLwqXaxGS+xWikAQ4REgCAs0buL3erzb8Pn/ttdUroOiBXFNLkYG
         B1Iw==
X-Forwarded-Encrypted: i=1; AHgh+RpxQVzdQ1+9+ws9q86xXrQmQR/5eKTXkshvIAnd/eTcaM23+ueywSxy+5JNHHQoAf6HpItxWNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaa9utkgfA0y3PM0NnFlkUzWwouhjwzvmYomPECkdEjHoc4HHb
	r6mENi/cWebCU54fx08JZW8j3Siun9csMiizDP3AlSworCUYSfv6aRLRwwJ1d9mN4yMSGHSNhJW
	NBvOCQ02Br+jvhPtIcxdOZ0LE8O7o0kc=
X-Gm-Gg: AR+sD11SZYn3IV6sNxy+r4SrMcySWHvWWjWA+1MpJ7IBgRVtY2ItLUpjRVXxmJqZVMU
	Kl1+K1i8/57YsApej2311nlhAYca+k9WIMVYqF8xuYi1JrxrB1j3OWjJ1Eo+rvBMibQv9qBv+cF
	sumvdTo9pV4Uyl9u+yYnFs+YD6qHkhBBeU2nuYZ0BUXQLoLSf1p02xpN6kK0BQm4GNG3JKtUNj3
	udgcn5CnWRcSVaV+boMs0cUcA5b5b9A55RgnQ+REE3rsC5qdVFhAZsLfnvhDoO1WO1kuJyuuDrM
	wlqPrGxCsTVKkgOURvNIQj3sJn2HhXxjjj5rszRS0kQXpEPCKmxseDHhSt/PaFpjzNXF5sgmesq
	L
X-Received: by 2002:a05:6512:ac2:b0:5b2:aa73:ea6a with SMTP id
 2adb3069b0e04-5b2b33252ebmr335065e87.10.1784793621839; Thu, 23 Jul 2026
 01:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717012416.168107-1-chenguang.zhao@linux.dev>
 <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com> <20f83ab8-d99f-4b10-bab1-cd5c6202937c@linux.dev>
In-Reply-To: <20f83ab8-d99f-4b10-bab1-cd5c6202937c@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Jul 2026 15:59:44 +0800
X-Gm-Features: AUfX_mxXF6M7l6Naj0d5crzlE02rgEJLqmAQ0OCht2o3jghL2yAtSls3tXpbhGo
Message-ID: <CAL+tcoAtn_eg0qwGf+6BJJGvKztNAgBm7tjY44H183=ZOw7zbA@mail.gmail.com>
Subject: Re: [PATCH net v2] i40e: xsk: fix multi-buffer XDP_PASS skb construction
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:02=E2=80=AFPM Chenguang Zhao <chenguang.zhao@linu=
x.dev> wrote:
>
> Thanks for the clarification.

Please do not top-post.

>
> I agree: the minimal bugfix belongs in -net for stable backportability, a=
nd the conversion to xdp_build_skb_from_zc() belongs in -next.

Right. That's what I meant. But I will let Maciej/Tony/Olek make the decisi=
on.

>
> Please apply the existing v1 bugfix to -net:
>
>      https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@l=
inux.dev/

If we eventually need this patch, then you will send a v3 patch
instead of asking maintainers to pick it up :)

And feel free to add:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

>
> It already has :
>
>     Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>
> I will drop v2 as a Fixes candidate.
>
> In parallel, I will send a separate net-next series (as v1) that replaces
>
> i40e_construct_skb_zc() with xdp_build_skb_from_zc(), based on
>
> net-next. That patch will not carry a Fixes tag.

As to this version, my tag still holds:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

>
>
> Thanks,
>
> Chenguang
>
>
> =E5=9C=A8 2026/7/22 07:15, Jason Xing =E5=86=99=E9=81=93:
> > On Fri, Jul 17, 2026 at 9:24=E2=80=AFAM Chenguang Zhao <chenguang.zhao@=
linux.dev> wrote:
> >> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> >>
> >> When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
> >> i40e_construct_skb_zc() copied frags incorrectly: memcpy used
> >> skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
> >> given a virtual address instead of a struct page *.
> >>
> >> Drop the custom helper and use xdp_build_skb_from_zc() instead. On
> >> failure, free the xdp buff in the caller. Push the Ethernet header
> >> back before eth_skb_pad()/i40e_process_skb_fields() because
> >> xdp_build_skb_from_zc() already called eth_type_trans().
> >>
> >> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> >> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> >> ---
> >> Revised as suggested by Maciej:
> >>  - Replace i40e_construct_skb_zc() with xdp_build_skb_from_zc()
> > I might have a different opinion on this patch: yes, it actually
> > belongs to -next material. The process should be like: 1) fix the
> > issues by v1, 2) refactor it by v2. The reason behind that is the
> > helper was introduced in 2024 while the home-grown part was in 2023,
> > which means it doesn't help for stable steam to cherry-pick the patch
> > in older kernels like 6.6[1].
> >
> > [1]: https://www.kernel.org/
> >
> > Thanks,
> > Jason
> >
> >> v1:
> >>  https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@li=
nux.dev/
> >>
> >>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 73 +++------------------=
-
> >>  1 file changed, 8 insertions(+), 65 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/=
ethernet/intel/i40e/i40e_xsk.c
> >> index 9f47388eaba5..1319a5c22625 100644
> >> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> >> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> >> @@ -3,6 +3,7 @@
> >>
> >>  #include <linux/bpf_trace.h>
> >>  #include <linux/unroll.h>
> >> +#include <net/xdp.h>
> >>  #include <net/xdp_sock_drv.h>
> >>  #include "i40e_txrx_common.h"
> >>  #include "i40e_xsk.h"
> >> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *r=
x_ring, u16 count)
> >>         return count =3D=3D nb_buffs;
> >>  }
> >>
> >> -/**
> >> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
> >> - * @rx_ring: Rx ring
> >> - * @xdp: xdp_buff
> >> - *
> >> - * This functions allocates a new skb from a zero-copy Rx buffer.
> >> - *
> >> - * Returns the skb, or NULL on failure.
> >> - **/
> >> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_rin=
g,
> >> -                                            struct xdp_buff *xdp)
> >> -{
> >> -       unsigned int totalsize =3D xdp->data_end - xdp->data_meta;
> >> -       unsigned int metasize =3D xdp->data - xdp->data_meta;
> >> -       struct skb_shared_info *sinfo =3D NULL;
> >> -       struct sk_buff *skb;
> >> -       u32 nr_frags =3D 0;
> >> -
> >> -       if (unlikely(xdp_buff_has_frags(xdp))) {
> >> -               sinfo =3D xdp_get_shared_info_from_buff(xdp);
> >> -               nr_frags =3D sinfo->nr_frags;
> >> -       }
> >> -       net_prefetch(xdp->data_meta);
> >> -
> >> -       /* allocate a skb to store the frags */
> >> -       skb =3D napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> >> -       if (unlikely(!skb))
> >> -               goto out;
> >> -
> >> -       memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> >> -              ALIGN(totalsize, sizeof(long)));
> >> -
> >> -       if (metasize) {
> >> -               skb_metadata_set(skb, metasize);
> >> -               __skb_pull(skb, metasize);
> >> -       }
> >> -
> >> -       if (likely(!xdp_buff_has_frags(xdp)))
> >> -               goto out;
> >> -
> >> -       for (int i =3D 0; i < nr_frags; i++) {
> >> -               struct skb_shared_info *skinfo =3D skb_shinfo(skb);
> >> -               skb_frag_t *frag =3D &sinfo->frags[i];
> >> -               struct page *page;
> >> -               void *addr;
> >> -
> >> -               page =3D dev_alloc_page();
> >> -               if (!page) {
> >> -                       dev_kfree_skb(skb);
> >> -                       return NULL;
> >> -               }
> >> -               addr =3D page_to_virt(page);
> >> -
> >> -               memcpy(addr, skb_frag_page(frag), skb_frag_size(frag))=
;
> >> -
> >> -               __skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> >> -                                          addr, 0, skb_frag_size(frag=
));
> >> -       }
> >> -
> >> -out:
> >> -       xsk_buff_free(xdp);
> >> -       return skb;
> >> -}
> >> -
> >>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
> >>                                       struct xdp_buff *xdp_buff,
> >>                                       union i40e_rx_desc *rx_desc,
> >> @@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40=
e_ring *rx_ring,
> >>                  * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
> >>                  * SBP is *not* set in PRT_SBPVSI (default not set).
> >>                  */
> >> -               skb =3D i40e_construct_skb_zc(rx_ring, xdp_buff);
> >> +               skb =3D xdp_build_skb_from_zc(xdp_buff);
> >>                 if (!skb) {
> >> +                       xsk_buff_free(xdp_buff);
> >>                         rx_ring->rx_stats.alloc_buff_failed++;
> >>                         *rx_packets =3D 0;
> >>                         *rx_bytes =3D 0;
> >>                         return;
> >>                 }
> >>
> >> +               /* xdp_build_skb_from_zc() already ran eth_type_trans(=
);
> >> +                * restore the header for eth_skb_pad()/process_skb_fi=
elds().
> >> +                */
> >> +               __skb_push(skb, skb->data - skb_mac_header(skb));
> >> +
> >>                 if (eth_skb_pad(skb)) {
> >>                         *rx_packets =3D 0;
> >>                         *rx_bytes =3D 0;
> >> --
> >> 2.25.1
> >>
> >>
