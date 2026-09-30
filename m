Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768234D916
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785192; cv=pass; b=p4uLik96+kkpFMCqIXWxc8DdqMOIrJGjIo15S7SZpHIeouOoItulrek554FI6QpImjlmm2MtARtf2kZRGD4eVo2WIXQpyeqblLmge2CSnP/MDkuVYiUQ1iGCFFegNexcEy1ny6cU4kpOob3gh94UB4CVy93AtoBynjN6OjHYzYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785192; c=relaxed/simple;
	bh=xbtri7KQhu+zwuSa6E8DT3Zb5oL69TJr8mD7f5rtmL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daSQoaFlkzX2ecuUsXo/mK8JH5XLY7KCrUayL0wKvxbqGYoAtgYz3wEJ3mO7QVfZ61eODaiWJdzDf6FSAQXN0CkA77sPMbpNQOfbDHnfT/T9g4ki5BEbpL1u2X04nb/kcHMUfeL4t4wAvqm3Wg+ieAuoFXbf3KE16zSxHKCqWl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmew/MLy; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmew/MLy"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af7721e4aso838148166b.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790785184; cv=none;
        d=google.com; s=arc-20260327;
        b=JYBiXVmPSJZh8VsdmNFx8KXDbThPGyqND4gFNuKFeQg8sp7fb/Qkoib4rD5pdBlgYb
         xSvxIMN30De1ADYioi/FdSRL337SyEIXNJtaRBtJ49wczZUZ8MQcdcVlhJ9svjuRE0r1
         7r74vxQWIDoeLqlt9AeM+nqiazH1ChIECeul/RG6mgX3+KnTQcP3N1/BKIZ/ByusfDGF
         puPvKoCmHK+VVnOJvF3gSn9vt4yTthLenySXhMhY07CvJxu5tmsMf74lJGiAOC5qfu6L
         PdJEaTETJg/sdKoEArRe82ZuhPV0wilz53EWVdWduMoEWz61H33ZBJKK2rJFWXgV9ZW5
         DjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nG2T2Alp7V7AR4zEW4H2cF7/r2rfzmYJ1/XwqhpbHio=;
        fh=vZ9dS23zNWweCniIMdg5FTA0DwE3HUxjZwEunL+J8wI=;
        b=N1ckvA8UHd4Yt/W72uw0XIjfMShRGuKMsxqSo2aqmy5ztBZuVazEJbsgm6uod3HlDu
         a3X8vIHGpi35sdlx7R0TB5+1qcIXxRyCakUcPu79sJR7KwmcZYs2cX0IhK6KQRPtpTTt
         u+2Btv/AYyrLnVsmVRO8VKBA64TqbumNYaUpzZPjhicz3/yl3UrOyWo7qMu+ifSRDSTR
         sgpal+3VGY50IhzK6kK6UGHsUsc8hbb6JcmStZb3lJurhHtVhRIZYS64bq1fHf8Fs6gN
         ReLrgiJL/B/78DZxNg5ti0Tgc9dZwaWEbGcrAYdFjLNCuBpT6BC52CpY37SJUhKDfTNm
         GwnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790785184; x=1791389984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nG2T2Alp7V7AR4zEW4H2cF7/r2rfzmYJ1/XwqhpbHio=;
        b=qmew/MLy19s99PQrRuGDmnTXHCCSORCtzrDtVbqeM7CXQaUJ7HJCfZ8U9QpQcucFLT
         L2+3eJS15xvcFuZbXRDTSSGeiaAzrfpz5i2RjgGWkbwHyRRknDPhZUPosenNAxsFfYyA
         dUnDvMbsqvC2KIlWzxqm2RpNcPMZI3ShyaQ6zQpgqzuhFV5fg7Y4hIvTCSca9wY4wMkI
         +V6UYm4QdwixPrLNAjD4o98YaQYzUgqqqaLqqwpX0B5k700CN7o8D2PURBZn7Q1wGLAN
         3LkTic8DAoOwz73tF6hKBujIyDZZX9wpMW9XkM8ahRyYlEgRILNVm3GUtVnv/q2pLIWn
         /BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790785184; x=1791389984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG2T2Alp7V7AR4zEW4H2cF7/r2rfzmYJ1/XwqhpbHio=;
        b=PMGNABQwHxgU5BwTInVKw7kpQwqjKTGCJNOCvRkOK5KSKMYDIGH3b5ySnY9MRRW8YI
         drtmrNSo26vOwH0WwD92n7T3Hcrt/8c2Hsxr+wxGj/Q+S9b3/PdKrtTUm97k9Rz1UCra
         gqO+nq8QJ7DbDDjRLq4FVNA/xKiJWNERoPNqUpSE+zRvQj/5u8E/s5PT86e6NFhVhpMs
         NfqknUOK0I4hVe4PV/flAy8EpDzgmL78jbgt8fxn5SM9bxbNlSSmJ2stsndVf7Fx/XpK
         c7Ld6P5vCO2r53cUp1aDwdf2vgBipzcuq20sbs2+hv4sw6xsgmWRpe7jnDhLI8Wpy2T3
         4fQg==
X-Gm-Message-State: AFq9FYJ1LrDatYpHjbk0ooMV+j3wDYBNs2hmAh/T7aVfhs9x9yTID97x
	Hgeir+cFMgEmwIPSHa/CHWkT1ptZtpGKncvSnJRly9gBR79dt1taZsGkq6gcAVfCxdcf0ZPWVWX
	KZvEyZV/SCO2Qea6AUGrpQno8kKJR4nrVkmCK+CwfeA==
X-Gm-Gg: AYBFou1yhBndv+Z1uaOUrRcrH0AHcjiJmxuLAwISr7yOBw+PLNnBOto3nq3xBDwMHIY
	hWMiLCwXaqSVW5S/jzFrY5/TfbY62j98HLMWwXUdBh6EZ3wBz4EKwohVUd/pFA0YF6iA1XkCxqs
	RHQtAaEkCPnbClZyiRMIH3yhQoZVyxi1U/PdlGiGIEScOb9ahegrY2/dO5p9jlyhZHf09Om//tH
	C4EOBqMSyIoSRmjsEs6q6q4cPVh1GQ9iMIRex8G9qOy+tGMmQUV+guqAfm++ozsfY1R+WEZ63JD
	n52oci3NjipgzJ3x8XHWOI529vlNSmEwuwrV13t3sZQrGo+eMmPmJwAsUVfFwvyKICnSWw9WwLX
	alrLs0s6B4fgnV/WxsmQJph1WwLNeY4MTqvIBF6QLHw==
X-Received: by 2002:a17:906:478d:b0:c2b:ca9c:1379 with SMTP id
 a640c23a62f3a-c2e23d80235mr174035666b.28.1790785184054; Wed, 30 Sep 2026
 09:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820085941.380401-1-pawlik.dan@gmail.com> <20260820085941.380401-2-pawlik.dan@gmail.com>
In-Reply-To: <20260820085941.380401-2-pawlik.dan@gmail.com>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Wed, 30 Sep 2026 18:19:31 +0200
X-Gm-Features: AclHuK9VCY3Sjvtv8H3qKyzm85-MwnmIxc92I19Mmm-MRvCk9MqeBH9bmWUgmek
Message-ID: <CALC2AphzQ=dHOk2Yjtaw=i2euCLxo+Lk0kO50ixtYydO0yzBHA@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
To: netdev@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kuba@kernel.org, lorenzo@kernel.org, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, yangshiji66@outlook.com, 
	upstream@airoha.com, szymon.datko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuba, Lorenzo, Airoha team,

I found a concrete lead for the unresolved cacheline patch in the vendor
firmware. The installed en7581_MT7996_npu_rv32.bin matches the blob in
linux-firmware commit 1043c0303910 by SHA-256.

At file offset 0x3a9c, the Wi-Fi mailbox handler converts the supplied
buffer address before reading the command:

  lui   a5,0x40000
  addi  a4,a5,-1
  and   a4,a4,a0
  or    a4,a4,a5
  lw    a1,0(a4)

This implements (address & 0x3fffffff) | 0x40000000. Both 0xbf6cf000
and 0xff6cf000 produce 0x7f6cf000. W1700K has 2 GiB of RAM starting
at 0x80000000; its current SWIOTLB pool starts at 0xff6cf000.

The handler also returns 1 (success) for an unsupported operation type
at file offset 0x3b4a. My earlier claim that mailbox success proved a
correct command read was therefore unjustified. The traces do not
establish a read-succeeds/write-fails limitation.

This suggests an address-window problem, but the NPU-side bus mapping
still needs confirmation. The cacheline patch avoids the observed bounce
path without constraining the address of future direct allocations.

Can Airoha confirm which host DRAM range this alias covers, and whether
mailbox buffers above 0xbfffffff are supported?

I have prepared, but not yet run, a test retaining all 2 GiB of RAM and
the 12-byte DMA_BIDIRECTIONAL mapping, with the SWIOTLB boot pool below
0xc0000000. A successful version response through a verified bounced
mapping there would help distinguish the address limitation from a
SWIOTLB copy/cache issue.

Thanks,
Dan

czw., 20 sie 2026 o 11:00 Daniel Pawlik <pawlik.dan@gmail.com> napisa=C5=82=
(a):
>
> On non-coherent ARM64 (EN7581), the kernel's dma_direct_map_page()
> forces swiotlb bounce buffering when:
>
>   !IS_ALIGNED(phys | size, dma_get_cache_alignment())
>
> The NPU mailbox buffers are 12-24 bytes, well below the 64-byte cache
> line size, so this check always fails regardless of physical address
> alignment. The swiotlb sync path itself works correctly, but the
> EN7581 NPU cannot DMA-write to the swiotlb bounce buffer address
> range =E2=80=94 it reads commands fine (mbox_status=3D0x7 success) but ne=
ver
> writes responses back, leaving response fields as zeros.
>
> This was confirmed through five boot traces on a Gemtek W1700K:
>
>   - Boots 1-4: all streaming DMA through swiotlb (is_swiotlb=3D1),
>     bounce buffer byte-identical to pre-map after NPU completion,
>     even after explicit CPU cache invalidation (dcache_inval_poc).
>     NPU version reads 0.0.
>
>   - Boot 5: kmalloc'd cache-line-aligned buffer bypasses swiotlb
>     (is_swiotlb=3D0 on all 169 mappings), NPU writes response data
>     directly, version reads 0.1111, WiFi fully functional.
>
> Fix by rounding mailbox buffer allocations up to
> dma_get_cache_alignment() and mapping the rounded length. The original
> payload size is still programmed into the mailbox length register.
> kmalloc returns cache-line-aligned pointers on ARM64 for allocations
> >=3D ARCH_KMALLOC_MINALIGN, so the IS_ALIGNED check passes and swiotlb
> is not triggered.
>
> Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buff=
er")
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/202608141=
10017.2795022-1-pawlik.dan@gmail.com/
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/202608091=
52813.585797-1-pawlik.dan@gmail.com/
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/202608050=
70851.2885888-1-pawlik.dan@gmail.com/
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 25 +++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index 4045d1eb93ea..3416f921f961 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/devcoredump.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/firmware.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_net.h>
> @@ -160,15 +161,21 @@ struct wlan_mbox_data {
>         DECLARE_FLEX_ARRAY(u8, d);
>  };
>
> +static size_t airoha_npu_mbox_size(size_t len)
> +{
> +       return ALIGN(len, dma_get_cache_alignment());
> +}
> +
>  static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
>                                void *p, int size)
>  {
>         u16 core =3D 0; /* FIXME */
>         u32 val, offset =3D core << 4;
>         dma_addr_t dma_addr;
> +       size_t map_len =3D airoha_npu_mbox_size(size);
>         int ret;
>
> -       dma_addr =3D dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL)=
;
> +       dma_addr =3D dma_map_single(npu->dev, p, map_len, DMA_BIDIRECTION=
AL);
>         ret =3D dma_mapping_error(npu->dev, dma_addr);
>         if (ret)
>                 return ret;
> @@ -191,7 +198,7 @@ static int airoha_npu_send_msg(struct airoha_npu *npu=
, int func_id,
>
>         spin_unlock_bh(&npu->cores[core].lock);
>
> -       dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
> +       dma_unmap_single(npu->dev, dma_addr, map_len, DMA_BIDIRECTIONAL);
>
>         return ret;
>  }
> @@ -333,7 +340,7 @@ static int airoha_npu_ppe_init(struct airoha_npu *npu=
)
>         struct ppe_mbox_data *ppe_data;
>         int err;
>
> -       ppe_data =3D kzalloc_obj(*ppe_data);
> +       ppe_data =3D kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP=
_KERNEL);
>         if (!ppe_data)
>                 return -ENOMEM;
>
> @@ -354,7 +361,7 @@ static int airoha_npu_ppe_deinit(struct airoha_npu *n=
pu)
>         struct ppe_mbox_data *ppe_data;
>         int err;
>
> -       ppe_data =3D kzalloc_obj(*ppe_data);
> +       ppe_data =3D kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP=
_KERNEL);
>         if (!ppe_data)
>                 return -ENOMEM;
>
> @@ -375,7 +382,7 @@ static int airoha_npu_ppe_flush_sram_entries(struct a=
iroha_npu *npu,
>         struct ppe_mbox_data *ppe_data;
>         int err;
>
> -       ppe_data =3D kzalloc_obj(*ppe_data);
> +       ppe_data =3D kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP=
_KERNEL);
>         if (!ppe_data)
>                 return -ENOMEM;
>
> @@ -399,7 +406,7 @@ static int airoha_npu_foe_commit_entry(struct airoha_=
npu *npu,
>         struct ppe_mbox_data *ppe_data;
>         int err;
>
> -       ppe_data =3D kzalloc_obj(*ppe_data, GFP_ATOMIC);
> +       ppe_data =3D kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP=
_ATOMIC);
>         if (!ppe_data)
>                 return -ENOMEM;
>
> @@ -434,7 +441,7 @@ static int airoha_npu_ppe_stats_setup(struct airoha_n=
pu *npu,
>         int err, size =3D num_stats_entries * sizeof(*npu->stats);
>         struct ppe_mbox_data *ppe_data;
>
> -       ppe_data =3D kzalloc_obj(*ppe_data, GFP_ATOMIC);
> +       ppe_data =3D kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP=
_ATOMIC);
>         if (!ppe_data)
>                 return -ENOMEM;
>
> @@ -466,7 +473,7 @@ static int airoha_npu_wlan_msg_send(struct airoha_npu=
 *npu, int ifindex,
>         int err, len;
>
>         len =3D sizeof(*wlan_data) + data_len;
> -       wlan_data =3D kzalloc(len, gfp);
> +       wlan_data =3D kzalloc(airoha_npu_mbox_size(len), gfp);
>         if (!wlan_data)
>                 return -ENOMEM;
>
> @@ -489,7 +496,7 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu =
*npu, int ifindex,
>         int err, len;
>
>         len =3D sizeof(*wlan_data) + data_len;
> -       wlan_data =3D kzalloc(len, gfp);
> +       wlan_data =3D kzalloc(airoha_npu_mbox_size(len), gfp);
>         if (!wlan_data)
>                 return -ENOMEM;
>
> --
> 2.55.0
>


--=20
Z powa=C5=BCaniem,
Daniel Pawlik
