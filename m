Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715A442B36
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744998; cv=pass; b=iv/EfBskfy30Uc/mCrA3YYoFybdhl0TXYyfaj79MDtkDcdsFOI9XlUHG30iG3qx/ADKhu9QfNjx4rRXp+U+DjLcbPaFYsBrsYdV7hsAGhfdHQOP6A0FvJxwhsUnlCJa1Oo06VnY5r34B7tmDPcVYjOHDaydFYPhWTo1yKwXRHfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744998; c=relaxed/simple;
	bh=/l71NXez5IBHg2o5uvalxHKgKhdxiODPMlFk8RG5G6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM/3ekRqRt0qgV+LhhxOOSo5FyxNZcU0AG15Z9p3UxCAjDogEpPBL30M0rCNhvo9iZSP7CtZCZDqcenNym6qWjjoMmBjfC0NpUYZ8j+03678FFbXDwbTP+dZWFssYFdS6jfC/Pwg0TnDovTA26SrIZt2zfqE2cb5jW8IWI1Xh20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLv9dXbu; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLv9dXbu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cab97c86bdso7855ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784744996; cv=none;
        d=google.com; s=arc-20260327;
        b=GM08uQEWBMvHQUFGKCCtkW1lJsHkwqsFYCRuJ/JO3gmc/dp8VcmS0yHe9zPHyxgX4n
         wy7weft7WXL2yr9CyOg72igkT0wdFBDbAIkedQfNe05o2mGzbQEYLEkUzN5GDXhGBytW
         A7bPjnDXJYPJe5QyCKy+8qQsMcsoLBNgiYzwrR1iorewbybyolHV0ywPtJTPz3R8uDf4
         P1alvgFyd6xNzz2I/uI1Zmhu/6u3pDAZCNAKShger/JmB8walOMVYd06z2M6PKDUfvLT
         NseyTSe/7y9dL3GcmQbmhMxG7rSEUrYSTIfuLgnBLSwuCf0rTdHpPMEFNHHY3zyGHd9P
         F1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EFjIw+YHhZOGu9EHRZwkadgAAA6y6Xc2ZzPm9AMLH64=;
        fh=ZxkG14nNxLC8PKIgCmf1/c8fDJxwkaVpJYsrwqXsrzc=;
        b=UemctPywtsxbWmNN/GpPesOm1+Lec+R0NtLjiqTM3i7D/bhbIY5/mBUKZo0Fhx3zEG
         b6wNEdXSdZGbmgIxm8/pPU0n/1XAwNcNiTDNH3gfj6XiXzqvr4ur0N506dHkxE/OZEm6
         o8RQ7P4pjX7yTJbEy98UraEzG4KWh/xkaEz5Pa9eXh4EePvJ84T/FVochHgH/3+HMifz
         iasExyuIRehKc3Hm+LKomTkqaYxBULonTj0ZSCjv2Re0ak/aCU3UBTQwG0AWvQwd+KxV
         GP7rMZ9XjQgSKPWxAy3OFeuZYtp/J6wjhJ7Xfq69OPOVjlVIyXmGOfNwHbtV4SikcRPy
         desw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784744996; x=1785349796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EFjIw+YHhZOGu9EHRZwkadgAAA6y6Xc2ZzPm9AMLH64=;
        b=qLv9dXbuiZs4OgRQjTHMs60lWeLrqtl8W0Kj3quzkzcueC5owi6iTnLsPCTpDf8jlT
         HOcrs1ggqQmLOIALs+r9cgKfuzzb6c95qD44Akl0V+d6/9vvsDn3sGZgFpbhCQMm4zGo
         luw2bl3TGlHYoGDtHCX0zI2vzHQa8OJwytkMUW6hfb08+ULpZh/WOGkmNs4VphUMtWTQ
         BgujSYZgalBUWPkOnSh6Tz1GkFkLY16XzQAQkBhELvzG762l2YukaAheyWPCZZaS/n5+
         6B8LFpllAD4MLAq5dgUkJDydxwudYLyM5Ho8Ie0rAet2K9uS0OM4lnPDJDQTypQ9Q8Qz
         lsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784744996; x=1785349796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EFjIw+YHhZOGu9EHRZwkadgAAA6y6Xc2ZzPm9AMLH64=;
        b=KiRRSG8YtmkTnQ8bz29m3zDAXFk+FKXEQxyjnOmDyHTtfTCYieyzupR1Tvr8lCZPXa
         6Z6gWFVNEMlr19qhB4p6u4/AxDr8ZqiJHqxGPiFSmiTDJAOlZ+NKSvqv+c1OyKeN0pZ7
         jrDIonwY4hGMyQeBUwHV0FWGei73UjlAcOR8LV+vxQcqjs8vQYfRMD6Mce9RWgrezaEZ
         FpXXGPIeb4iZRS0WBPdxOiynwIYB1jR1yf8KlcF8KZds8xbuq4bfDi1ASF0QsMUVFgRO
         K7rpV0LftAQAMoSTz5n8CikyCKIaKaJwFysXIV25dJh7uZKqWYH2tJqD/uwBijm+sUdD
         KyjA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7t6V7v9HNW7gohoNbg1xyqpb2hHXGcwm3zFttAFWV1dibrlJ2Q/Zf92vRVCIQd99MrcjN6rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyehDLl4qCHPS+KrOHFeWSa+y7II7wAfN5JbF8Em3qxk7ukS2cX
	/y2QbdadmfxWBakx9+zwTPraqeS6lO8lu1p/Poup7r9nc35nb8GiMiKMk1kl0udau6lxzTWs7+H
	BmjVIqpflm8tJ50SV4slQbmVbliAvd5YwA17G40WI
X-Gm-Gg: AR+sD105MU73crXn39ADYpsU19l464R8EgvsXqk4qT8pF6nvEp0GYh0PuPHrB4BygRS
	RexOfq5Uj+79mKClNbp03wTgERgSBRhkWwRuyW0ANZ29GhTYsxc1YzmWj1buyFIx9KRuw/N1Z0g
	flzlIl4K7u5SsIvNaaAhgCoxdlbZe0mHuU0FW52mie9964THu5gbXd+dm/Rq/r4k54x5klZDEH7
	3zqLv3KpuldZdUzz3fHECfoIHzWRxf8ncAbClDh5xynPJMDPFZwvvqyepTzVhncs3C314sUB+xN
	w08ixZ5+JhdEhWv0
X-Received: by 2002:a17:902:f60e:b0:2c1:ee6e:4e49 with SMTP id
 d9443c01a7336-2cfa53828bcmr546965ad.26.1784744995317; Wed, 22 Jul 2026
 11:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com> <tencent_8FE30FDFA32089B69BA3112E4A4C5E886D06@qq.com>
In-Reply-To: <tencent_8FE30FDFA32089B69BA3112E4A4C5E886D06@qq.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 22 Jul 2026 11:29:42 -0700
X-Gm-Features: AUfX_mzS7_PqfH6KstmDgOCBUlGwA2ixyTSez2IFSShyi5JJI7ari5NvR-MmgQI
Message-ID: <CAHS8izPBvv4ENCcnSpsbcL9+TEMj9nBE6CAj4fg9_aDBdhrBaQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: atlantic: free stranded TX buffers on
 ring deinit
To: Yangyu Chen <cyy@cyyself.name>
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 10:41=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
> stops at hw_head, which no longer moves once aq_vec_stop() has stopped
> the hardware and NAPI. Completed descriptors beyond the budget and
> everything still posted in [hw_head, sw_tail) keep their skb or
> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
> the buffer ring and the references are lost for good.
>
> Today this is a silent memory leak on every interface down under
> TX/XDP_TX load. With the following conversion of the RX path to
> page_pool it becomes much more visible: XDP_TX frames carry fragment
> references on the RX ring's page_pool, so a single stranded frame
> keeps the pool's inflight count above zero forever. page_pool_destroy()
> then never completes, the pool is leaked together with its pages, and
> "page_pool_release_retry() stalled pool shutdown" is warned every 60
> seconds from that point on, on every ifdown, XDP detach or ring resize
> under XDP_TX load.
>
> Bring back aq_ring_tx_deinit() as it was before the removal and use it
> for teardown again, with one extension: TX rings can hold xdp_frames
> nowadays, so release those too. They are returned with
> xdp_return_frame() since this runs in process context.
>
> Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Looks fine as far as I can tell, but don't you want this sent to net as a f=
ix?

> ---
>
> Notes:
>     Without this fix, converting the RX path to page_pool (next patch)
>     turns the stranded XDP_TX frames into leaked page_pool fragments, so
>     page_pool_destroy() can never drain and the shutdown stalls forever.
>
>     Reproduced on an AQC100 with this patch dropped from the series (i.e.
>     page_pool applied without the tx-deinit fix):
>
>       # reflect received frames back out through XDP_TX
>       xdp-bench tx enp99s0                    # or any trivial XDP_TX pro=
g
>       # from a peer on the same link, flood RX so frames are in flight, t=
hen
>       ip link set enp99s0 down
>
>     The pool is destroyed with frames still stranded on the TX ring, and
>     page_pool_release_retry() warns every 60s with the same id and inflig=
ht
>     count and a growing age, indefinitely:
>
>       [161110.753385] page_pool_release_retry() stalled pool shutdown: id=
 361, 12 inflight 60 sec
>       [161171.170756] page_pool_release_retry() stalled pool shutdown: id=
 361, 12 inflight 120 sec
>       [161231.588685] page_pool_release_retry() stalled pool shutdown: id=
 361, 12 inflight 181 sec
>       [161292.005886] page_pool_release_retry() stalled pool shutdown: id=
 361, 12 inflight 241 sec
>
>     With this patch the stranded buffers are freed at deinit, inflight
>     drops to zero and the pool drains cleanly.
>
>  .../net/ethernet/aquantia/atlantic/aq_ring.c  | 30 +++++++++++++++++++
>  .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
>  .../net/ethernet/aquantia/atlantic/aq_vec.c   |  2 +-
>  3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index 8ff07de2bd52..c59b6c0b37f1 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -360,6 +360,36 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>         return !!budget;
>  }
>
> +void aq_ring_tx_deinit(struct aq_ring_s *self)
> +{
> +       if (!self)
> +               goto err_exit;

return; here and delete label?

> +
> +       for (; self->sw_head !=3D self->sw_tail;
> +               self->sw_head =3D aq_ring_next_dx(self, self->sw_head)) {
> +               struct aq_ring_buff_s *buff =3D &self->buff_ring[self->sw=
_head];
> +               struct device *ndev =3D aq_nic_get_dev(self->aq_nic);
> +
> +               if (likely(buff->is_mapped)) {
> +                       if (unlikely(buff->is_sop)) {
> +                               dma_unmap_single(ndev, buff->pa, buff->le=
n,
> +                                                DMA_TO_DEVICE);
> +                       } else {
> +                               dma_unmap_page(ndev, buff->pa, buff->len,
> +                                              DMA_TO_DEVICE);
> +                       }

I would remove the unlikelys that seem unnecassry to me. This is a
reconfig path and the unlikely is probably not improving perf.

> +               }
> +
> +               if (unlikely(buff->is_eop)) {
> +                       if (buff->skb)
> +                               dev_kfree_skb_any(buff->skb);
> +                       else if (buff->xdpf)
> +                               xdp_return_frame(buff->xdpf);
> +               }
> +       }
> +err_exit:;
> +}
> +
>  static void aq_rx_checksum(struct aq_ring_s *self,
>                            struct aq_ring_buff_s *buff,
>                            struct sk_buff *skb)
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.h
> index a70b880ada67..6431cc62962f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
> @@ -202,6 +202,7 @@ void aq_ring_update_queue_state(struct aq_ring_s *rin=
g);
>  void aq_ring_queue_wake(struct aq_ring_s *ring);
>  void aq_ring_queue_stop(struct aq_ring_s *ring);
>  bool aq_ring_tx_clean(struct aq_ring_s *self);
> +void aq_ring_tx_deinit(struct aq_ring_s *self);
>  int aq_xdp_xmit(struct net_device *dev, int num_frames,
>                 struct xdp_frame **frames, u32 flags);
>  int aq_ring_rx_clean(struct aq_ring_s *self,
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_vec.c
> index 2f9033ceed8c..05814fea0f5f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> @@ -275,7 +275,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
>
>         for (i =3D 0U; self->tx_rings > i; ++i) {
>                 ring =3D self->ring[i];
> -               aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
> +               aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
>                 aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
>         }
>
> --
> 2.47.3
>
>


--=20
Thanks,
Mina
