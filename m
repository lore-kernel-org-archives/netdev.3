Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBA9432BE6
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782149; cv=pass; b=bYD0ewdpYL3J23dPkbgQkjGRSD1qA/K8q0dDkDGEKoTw5hWYh04L4NjDDKUBQk57LOUkg4MNDx/UE8XxS2kNXSZX5/j6a+nvvbr+ZOl6EUGaMFqNEL3bDfGpMpEVqni/foIfZUNO3inaSMc1cPeAErX+tV5m81RrzNRDNS7/3gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782149; c=relaxed/simple;
	bh=r9z/NzCIKb+NzPl+bCBVeBCGM81bEvPm/kS/2iUa9E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfnte3UkZCqn2RyoZuiGFWMuAAnyiiJUrtS4RP/9DQg0TW5X7S0/847upkxQ1XsfiN3/HQOTjNbzVMP5mMcDpdMMLnk4EgmcZdZwFDsEEBfCM709ljTKC6CpnEJzG9S3nHIn0H7kTs76FWJUuBSh5Qs0YhjZWfsI7Bq+kOx6X0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2aPK8Sh; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2aPK8Sh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-498012a61f6so7065e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785782146; cv=none;
        d=google.com; s=arc-20260327;
        b=erYu3An8KyWLiY3aWI9aE5PfRX7+8MHYK5hdeTCUSGKBdUQIwTYe/tuzNHkwbw6iD/
         kYgruhlMRbNlneUzWiFR56+wAPM8DNhOfZ6E40aR43Lbel4IB3vsskUneQrM/FN9OlOp
         b9Mzca2x9AynGLnOT3rPV1Y5MbLj4GMqEeKMKQ3MiIsHEUVSv0019YPidhUdiRG/KOIE
         uyZU4Wkbkp1IP7H1ThM2q4xA2q19eWErf3GpSZxH93FjiKiPtSwPof1D7ngxbrStWDQm
         6IANdOGC1k8+dUg1WZjlOvWjxgghWtCgoqTrMpUStiYzQ7oTK+AS5EKH9+tKkiFuB/Rq
         PC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Nbe9Rf1mvhQHGAAdMRTi8stMekEwl5zMrReYFR5J94=;
        fh=5L4GYuNyZ5E7ppVEF9CJPw3IYWHpMrwIOdnx/AzjSdo=;
        b=gWTDO3h9iTL2W2BYF+Wrbu4uNbKPIrWxBOi64EyvxOP4CaQP9SJyzQmihDGEcuExuf
         JDo5iURF91d4RXd1vCSmGfJv5D9Vndw1l6a+U3mwzdkBgtdxgGrv5uzqOulDwQEOsYKR
         TFwDmpqPQIhh93vlSXNJwbIk+7kk67y/UkXVy1YsIs/+cQIh6I78k7HVfaCF6kc26Dc3
         wE4SjyMRCFmuNqcEauIQT1zLHYOJyb60s/w+jLvLzOZ8whwD/KzAf+N2fVIYPakcDV7h
         Ppasgk7MdcYxGauHnK38j13aPTQJLt02TBA/wM251JMEfCUsW97a3tWPfSQdtmEsWYNo
         PGgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782146; x=1786386946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Nbe9Rf1mvhQHGAAdMRTi8stMekEwl5zMrReYFR5J94=;
        b=B2aPK8ShzLmLlRQ/ni+znLKDR9HVmoDf70A5u+z3necFZ0obqNKP9XMXoPp3th+dUt
         mdk4ae9yd2WYtJBekxMUX8ER3GCbfq7jKL+s5B+mCjVCU9cHg5/TViexkjecj+isu5XF
         tCQ9dha36oZqcRHwjh2ZMAi2ILTAKUnCvI7AURVIOOs3/VDYgOQrLe4X+5q2x/y+f+q/
         z5Q3EBnX06G8r8yZEV55Lc50UlnT0DmEytPx+yx/EKAtOqCP42mqPcAfTxNsCKkVXxFH
         wAtIglSOPXsE7WC/1TYGCYpGMkyy+Ge4e4v5b8rIFJsDFWtgGThAci77BCzN7mp89+/a
         MWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782146; x=1786386946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Nbe9Rf1mvhQHGAAdMRTi8stMekEwl5zMrReYFR5J94=;
        b=jTRkVwJYVNYQs6FoiA1DepnBGeNFTO4N5gQzl8zxidLVA3PezYC/dQzqvo2HCLvV4+
         NMVLAcNf9n79WCTmF0rPGfa9WiZ3Z+0m1MKSQ5dotLmNSrSfi3swPd0183CHn1wqr83g
         rNlZUqtDku9Z0LS9o0d221D4xU0ijGWIz6gXv1NLtw/QI+N58gLztQ2AYnaPe0YyJyPM
         ysFkHOslH2+gPgbmrTw0RLr6JvAdreA+d1/ZarS/iGwge/DpUfKTmW5WU/ZNoeIRFWjM
         Kj4xsmXiUPA3oheNuBm8ItlSpLjz7tUVi8F60B8Ytffbxx+Amx1730V+HRIeF+rqDER5
         j/9Q==
X-Forwarded-Encrypted: i=1; AHgh+RopJItaDtViluMGZqhNnL5+VVwnGDC8v6pSa4Vj+0j2JxzjLNpLhwbBcofUYqnbGrELc9uMQ7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfHkeYuO86tYojSG+TCXVqwndJMTb9G1Vn0nMpwfjbs5C1KPqM
	fQNF+182S9rvBq+xGO1crEqtHKLEIHnGpBiF5IA10H/STgUd+lHcTXTQWQUQLcbcmsBTc1PNxma
	JRvmGSRd14AdFJBla8WAlt/qTWZBgWNn+VKQyg1yoiz3rVpWB1UjTy79t
X-Gm-Gg: AR+sD10XAGtMo53eCSWN0B5KidFSYOMZ92Z9ArKkLuOkabDlbbOmyJLwidtHXS0rg2C
	WnpWgQKgYBrLoXkpfb/FA19ryvKTfIq13qNU4FbO/xx3D7JFrBLo1C2zWMglz1CBF3Qq05rVz3s
	hpobhJ72cR4nutpxPIcq4/5PbueWCNfIv2RWcoV6ejxcTwLUCXgqFdrUm/yMAW59oNBwDH7dN7Z
	EJaIBiJD+qyjkouXrLw3KLufkhJ+wtPAWRpUN6JijbO7iGtdUgXsjRlS3kDJs+wikgoDtRPOEBq
	68icY8idqtcTraYF6LJp8I/2cMs0jQIPzWkOkRwTnZsC0BF7KIBZuZUF
X-Received: by 2002:a05:600c:150c:b0:495:76cf:3bf2 with SMTP id
 5b1f17b1804b1-4994a3a589dmr125165e9.5.1785782145357; Mon, 03 Aug 2026
 11:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com> <tencent_607CBA8237DA438E36B844318B21538DE008@qq.com>
In-Reply-To: <tencent_607CBA8237DA438E36B844318B21538DE008@qq.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 11:35:25 -0700
X-Gm-Features: AUfX_mzZvbKSzP4jILXo9ql1dHu2unE2SpWxs3AU8m0z1F7Wqh6weqI7baO0m4U
Message-ID: <CAHS8izMm9W0_J36RtWbD4kCMtr-taswK3aJ09o9Pkm5QAvaZ8g@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: atlantic: free RX pages of consumed but not
 refilled buffers
To: Yangyu Chen <cyy@cyyself.name>
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>, Igor Russkikh <irusskikh@marvell.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:46=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> aq_ring_rx_deinit() only walks [sw_head, sw_tail), the region posted to
> hardware. Since the page reuse strategy was added, a cleaned RX buffer
> keeps its page (and its DMA mapping) in the ring for reuse, and refill
> is batched: aq_ring_rx_fill() returns early until AQ_CFG_RX_REFILL_THRES
> slots are free. Slots that were consumed but not yet reposted therefore
> sit in the complementary [sw_tail, sw_head) gap with a live page, and
> the deinit walk never visits them: up to a refill batch worth of pages
> and DMA mappings leak on every interface down.
>
> Walk the whole ring instead and release whatever is still there. Also
> bail out if the buffer ring is already gone: a partial
> aq_ptp_ring_alloc() failure frees the ring but leaves aq_nic set, so
> aq_ptp_ring_deinit() still gets here on the unwind path.
>
> Fixes: 46f4c29d9de6 ("net: aquantia: optimize rx performance by page reus=
e strategy")
> Cc: stable@vger.kernel.org # v5.2+
> Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>


FWIW,

Acked-by: Mina Almasry <almasrymina@google.com>

> ---
>
> Notes:
>     Without this fix, the page_pool conversion posted for net-next turns =
the missed
>     pages into fragments that page_pool_destroy() waits for forever.
>     Reproduced on an AQC100 with the conversion applied and this fix
>     reverted -- ordinary small received frames (<=3D 256 byte header-only
>     packets, e.g. ping replies or pure TCP ACKs) are enough to populate
>     the [sw_tail, sw_head) gap:
>
>       ping -c 200 -i 0.005 <peer>%enp99s0
>       ip link set enp99s0 down
>
>     One short ping flow left three of the eight RX rings' pools with
>     stranded fragments, and page_pool_release_retry() warns for each of
>     them every 60 seconds, indefinitely:
>
>       [278084.929092] page_pool_release_retry() stalled pool shutdown: id=
 123, 1 inflight 60 sec
>       [278084.961064] page_pool_release_retry() stalled pool shutdown: id=
 126, 1 inflight 60 sec
>       [278084.961087] page_pool_release_retry() stalled pool shutdown: id=
 125, 6 inflight 60 sec
>       [278145.346737] page_pool_release_retry() stalled pool shutdown: id=
 123, 1 inflight 120 sec
>       [278145.378745] page_pool_release_retry() stalled pool shutdown: id=
 125, 6 inflight 120 sec
>       [278145.378759] page_pool_release_retry() stalled pool shutdown: id=
 126, 1 inflight 120 sec
>
>     With this patch the whole ring is walked at deinit, the pages are
>     released, and the pools drain immediately. On the current code the
>     same gap leaks the pages and their DMA mappings silently.
>
>     Applies and was build- and runtime-tested independently of the
>     page_pool conversion, against the current page reuse scheme.
>
>  .../net/ethernet/aquantia/atlantic/aq_ring.c  | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index 81685a4dc5a6..e1193c6719d9 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -950,15 +950,29 @@ int aq_ring_rx_fill(struct aq_ring_s *self)
>
>  void aq_ring_rx_deinit(struct aq_ring_s *self)
>  {
> -       if (!self)
> +       unsigned int i;
> +
> +       if (!self || !self->buff_ring)
>                 return;
>
> -       for (; self->sw_head !=3D self->sw_tail;
> -               self->sw_head =3D aq_ring_next_dx(self, self->sw_head)) {
> -               struct aq_ring_buff_s *buff =3D &self->buff_ring[self->sw=
_head];
> +       /* Release every page still owned by the ring.
> +        *
> +        * Walking [sw_head, sw_tail) is not enough: refill is batched
> +        * (aq_ring_rx_fill() waits for AQ_CFG_RX_REFILL_THRES free slots=
),
> +        * so slots that were cleaned but not yet reposted accumulate in =
the
> +        * [sw_tail, sw_head) gap, and they keep their page for reuse. Wa=
lk
> +        * the whole ring and release whatever is left.
> +        */

I don't like these AI-generated comments FWIW. It's describing the old
code, which is now gone. No future reader is going to wonder why we're
not only walking sw_head -> sw_tail, I think. Do consider deleting it
if you submit another iteration.

--=20
Thanks,
Mina
