Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D98635D
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988809; cv=pass; b=YSUDgnWEPrMZKooecnPr8sag1rQXaFdcpnjj3k0g7SDpnYWuml2TyzsBRum7vnpXxt9BHlB0bs762f1TWTaFUTg+PYyU7dAxjUtT/7+fzGXNiO4bBm5GGMVoUvhPmdLh+bLd7oRmVh1FQcHfav6pxWzDQP/N6um43g9ZUetO80g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988809; c=relaxed/simple;
	bh=9671fBcw+fxf0lItIU8zIdDNJxy4W7vfPqUaYuQRpRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8KvK6zUg6YGGho4N2O1ayzGk975KvLpSIz7VkYMDCMgeKzkSu/V5l71vrJoj2fajy7Nu7/YD072jLPR7roJnrIXX6er0C6PHQELJB0WzlHhmSwl9eKe1dAvpK2ralsrphyIMbZQ4/VbkvhZ0Ny4FrCiT5uZgiVIDofQ5uiFdYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utiGgJ4B; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utiGgJ4B"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e2e4ef20beso24595ad.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 17:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790988806; cv=none;
        d=google.com; s=arc-20260327;
        b=n0NcYWTBsWiGno5QT9dpFqQcStQ+IWpfTQ3gA7emkUcl4v6og3hy2OkcehWHVGTmuh
         ZRcaRAjIe0BpX7bpU7do/ho6XcY5PS7X0OYDj5lTWTOi5r/0AiPBb45SOJ6lUPX5ezv8
         GhEgQBRXcDqpirxewoC2Zp5p7/fLIN1vsJjp8v7c32IIDgwwb7kFtwmxM5ybxKWdh7VW
         oFd+KZlgm2oVS694zQ5omCQKgVCR0fKCm7GsTCpnogY7QnDrRX5JbHb0BEJDpvAeIZSc
         +KIGeUA+1pbILVxCNeIAw7CD83Y8dLtUDQUpSWILwLKvgnqQGK53IgBO/Vt2iUrkfNfD
         DUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lw/QJIm9h+PtVPJ9rpycUDupDmU7p2Boo9EQVykvxQk=;
        fh=ovxa8WWv2mLiTfcPQsCBNt/PpRSBILrukf+V5TFaOkc=;
        b=shmvrC7lG66M0nfIjTKiQKfr4WykPXZuLj6q/lAXHgOq+8lZ4unkJXM2KE3r54aT3y
         smNlqyLwkO3Kv7xxkGVNONQBZ5yvk1/9+M06kPjAEpZIJd+AqaFM1g5OA9RgAc8cbAu3
         8Kix6S8bgZodTJKYGBvuzBsD9S1X1lGx+IhPOwT+08GsuwTNd/Zec/bP9jHZVCRpHttu
         xFGzSdYc5oDdRS5oz9Z0QlDIp9EYDU1BnTMbvry2dEpHhHVg0iQdYB6DsQftHiZlacyl
         lZoF3JpwWXe83kKtaSAYle4HcnEdAd1NhSwek+n3Ieu19/J5dtUzbKdjPQOSMQsJp8v7
         Yl6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790988806; x=1791593606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lw/QJIm9h+PtVPJ9rpycUDupDmU7p2Boo9EQVykvxQk=;
        b=utiGgJ4BYJa0YbloKNlm+fJKWs+f8ivcBTpWXyXknKUWNg23IlKJDf5d9cThw5zYb2
         p9QdhrkhpstBrEZAHUMUyGB3segBViSlHWZ7B75lYbO8wYdSCizXcTHrF3AGPv/nJ9KF
         fwkkyKs5A6P7Hm9+TkyMWcin6DRFQVc3lOhUj3BweJM76Oe54Gsry3DVlar0GfA7WY0y
         D1MYiPsDZt1R/XQcBjwrqeShkzRN2RfOhHunnPJmoQowAnY7tBPBMVUadB6C3kF0d+Lw
         0NgY/Bg/gIQpv/VeBwwVjGiPYmIiABwk9JYqIncKGhFFweda93VJMDhz+rMAUCn3xUek
         ju4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790988806; x=1791593606;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lw/QJIm9h+PtVPJ9rpycUDupDmU7p2Boo9EQVykvxQk=;
        b=bWPD1yKrL1Ag8iDpDzuyvlB1KZmSIUswuaV/Op0OR7w9IRJM0SOZJ1m27lBiTU0j35
         w4nXgnrIxG7vjfVNhWWEDSzCU5G5N70D19rzRMtqqlh/mN8NWD6A/OJCwrHietEJz3XB
         HT6zz9szhsFXnYC73zBj0oJwm4+6MYFarsIeMLPhgtUWMa0wCNJtrr4MsohXmj+iwdmU
         l+rEfvDsAxMKkQZCPoHXKia0J95uS8O4cwa8VERsksJUyhAzR+TzE7vjP0Td3wYxUXvG
         Hne5PiQx8SwKH1MBVXlGMPzbwYGKaUxjISOZ+RpdJPv9Ge6BFkV5b28GPt2tvoIvGt/Q
         yp4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzgXtbLdaMr3nXIoQSwANFQnbaWlPXpCc/4KgWtqmDje2Px5NvvqrqnPwASBZ6CatFX+hdfzSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsXbBWBAJZq2eqpQD5bp23Yg1r94d1CDYAqU4fA0pgj+7Sy52F
	xAvyekgKr+/kE1kv5AOvPidm4b9uMCdbW1F0JcL1dB/++SrCJnrngAakJKK4Wc1nyohz46SdRko
	t8asIskAoutqbYS/MhzC/UGBwXWw4uoTdmAv4O+TH
X-Gm-Gg: AYBFou3lkN0Or+gj4DlQzT2L0PzYFdjiFQjOryxxvODRQizWkZvZ517r+fa2ZHU7wIJ
	wJ3juDZuUo/owSzPAGXoMoXF3tbF9HYftmo55Ug2ReWd2fewvDWwvtbvcArKNIbFURldzsWJ3Bw
	BQbH/vqi3TpmHGeeH/W+GnRQEDCtiDb9NcNTvUeQ6Jqj69z13GTiCkYt7xU0Ev9mles4cIcMK/q
	aJWm4FHUreOwz+g+802T29gv9opZN/QODdQiJSKvhDZ5keNB12OIG8wUNwbFgFPW2OeVYRhxxd1
	jMM0x0mUbyKLpBgDUqEZGiZgZHY8sdduKNk6DkXrJ9VNMRSPFvFfe5ZGPwzf5BX6IeGbrXLxMNx
	1mQSxHc8/UiD+wRpqN0CrraGGoU6mnZ/MW9GoepcgKIRdEDErZNne0A==
X-Received: by 2002:a17:903:244b:b0:2c7:9e6a:1a8d with SMTP id
 d9443c01a7336-2e5339e22damr1093475ad.12.1790988805184; Fri, 02 Oct 2026
 17:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com> <20261001-linux-mpnic-v1-4-6422ee74233a@gmail.com>
In-Reply-To: <20261001-linux-mpnic-v1-4-6422ee74233a@gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 2 Oct 2026 17:53:14 -0700
X-Gm-Features: AclHuK_ridEYnSAvuKBNXkw0ZEQCvmwPGRhQzMH7rOZvbpheiH6O_c6u-_ITow8
Message-ID: <CAEAWyHdJQsKgHmZSAA3M12jpKhgb_pq7QmBRW59CU-Q_JT8cwg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] eth: mpnic: add a NAPI depletion check
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 9:41=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
> The Rx path can wedge if page pool allocations fail in
> __mpnic_fill_bdq(). The problematic sequence is: page pool allocations
> fail, bdq rings are empty, device receives packet from the network, but
> drops it for lack of buffer space and does not raise interrupt,
> mpnic_poll() does not run, so page pool allocations are not retried.
>
> To break out of this cycle, we can add a depletion check to our service
> task. The depletion check checks if posted buffers are under a low
> watermark, and raises a completion queue interrupt, so that mpnic_poll
> will run on the corresponding napi vector.
>
> A note about the lock free reads: We don't bother synchronizing the ring
> head and tail reads with mpnic_poll(), because a false positive signal
> would simply raise a spurious interrupt scheduling mpnic_poll(), and a
> false negative signal will result in a retry, where if mpnic_poll() has
> truly not been running, should then report accurately whether or not
> posted Rx buffers are low.
>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  drivers/net/ethernet/meta/mpnic/mpnic_pci.c  |  4 ++++
>  drivers/net/ethernet/meta/mpnic/mpnic_txrx.c | 31 ++++++++++++++++++++++=
++++++
>  drivers/net/ethernet/meta/mpnic/mpnic_txrx.h |  1 +
>  3 files changed, 36 insertions(+)
>
> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/et=
hernet/meta/mpnic/mpnic_pci.c
> index 17eae5a9ba16..125fb26edf93 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> @@ -11,6 +11,7 @@
>
>  #include "mpnic.h"
>  #include "mpnic_netdev.h"
> +#include "mpnic_txrx.h"
>
>  #define PCI_DEVICE_ID_META_MPNIC       0x0014
>
> @@ -61,6 +62,9 @@ static void mpnic_service_task(struct work_struct *work=
)
>
>         netdev_lock(netdev);
>
> +       if (netif_carrier_ok(netdev))
> +               mpnic_napi_depletion_check(netdev_priv(netdev));
> +
>         if (netif_running(netdev))
>                 schedule_delayed_work(&mpd->service_task, HZ);
>
> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> index 49061c7316d5..5495e9a9aa65 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> @@ -55,6 +55,12 @@ static unsigned int mpnic_desc_unused(struct mpnic_rin=
g *ring)
>         return (ring->head - ring->tail - 1) & ring->size_mask;
>  }
>
> +static unsigned int mpnic_desc_used(struct mpnic_ring *ring)
> +{
> +       return (READ_ONCE(ring->tail) - READ_ONCE(ring->head)) &
> +              ring->size_mask;
> +}
> +
>  static struct netdev_queue *mpnic_txring_txq(const struct net_device *de=
v,
>                                              const struct mpnic_ring *rin=
g)
>  {
> @@ -1393,3 +1399,28 @@ void mpnic_napi_enable(struct mpnic_net *mpn)
>
>         mpnic_wrfl(mpn->mpd);
>  }
> +
> +void mpnic_napi_depletion_check(struct mpnic_net *mpn)
> +{
> +       int i, j, t;
> +
> +       for (i =3D 0; i < mpn->num_napi; i++) {
> +               struct mpnic_napi_vector *nv =3D mpn->napi[i];
> +
> +               for (t =3D nv->txt_count, j =3D 0; j < nv->rxt_count; j++=
, t++) {
> +                       /* Check if BDs posted covers a max sized frame
> +                        *  + 1 BD held by RDE as a spare
> +                        *  + 1 BD of extra safety margin
> +                        */

Curious how the "+ 1 BD of extra safety margin" was decided. I
understand the "+ 1 BD held by RDE as a spare" is because of HW
behaviour but wondering about the extra buffer descriptor - if it came
from testing or guarding against something specific.

> +                       if (mpnic_desc_used(&nv->qt[t].sub0) <
> +                           MPNIC_RX_HPQ_DROP_THRS + 2 ||
> +                           mpnic_desc_used(&nv->qt[t].sub1) <
> +                           MPNIC_RX_PPQ_DROP_THRS + 2) {
> +                               mpnic_nv_irq_trigger(nv);
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       mpnic_wrfl(mpn->mpd);
> +}
> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.h
> index 9397010557eb..767d87a36c35 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
> @@ -148,6 +148,7 @@ int mpnic_set_netif_queues(struct mpnic_net *mpn);
>  void mpnic_reset_netif_queues(struct mpnic_net *mpn);
>  void mpnic_napi_enable(struct mpnic_net *mpn);
>  void mpnic_napi_disable(struct mpnic_net *mpn);
> +void mpnic_napi_depletion_check(struct mpnic_net *mpn);
>  void mpnic_enable(struct mpnic_net *mpn);
>  void mpnic_disable(struct mpnic_net *mpn);
>  void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd);
>
> --
> 2.52.0
>
>
