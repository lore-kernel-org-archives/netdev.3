Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1352EEE89
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988616; cv=pass; b=IQPfQM9EeKXtd4Uo+17hT6OsQFMvY8q67PJHEVux8GNGPKmq9ZlawaI7n8mXjY/B41TWlGTr7FWC/LraNBOytXsPzzzhEUPh74iJ2FZp+AsCiKcGMA3dyc0ywB1E4gbVx6BfiiM/1pZTzwh9YT2GeM1+kmy05WeAjAfnxPrcN4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988616; c=relaxed/simple;
	bh=E0ak9elnGovBcibz4dgEqttF9r+fM9/fIhkUL+dWNSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIIMouGlnUjPxiSp8bCvh6knAIEqUqjq4coKr2lQpLEDI2xH9Wsa9T5ZsYWT0ORlDORuMj6ZgHJE/Cv13CsI6jCZAILkjE62Sdl5RwAz9dhFRFvm15BWF9i9Qg4MWaaSOe1ad0NAeOBPLp4U4aydgfAnRRkuUTNsxUYP23kluVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iB+hWCxr; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iB+hWCxr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2db33db4de9so4825ad.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 17:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790988612; cv=none;
        d=google.com; s=arc-20260327;
        b=iJr4M8p4SN/tHw6uTMA9tMIiAtXB8hZXyC1kzPyVKcj3vpUFUQoHi199/bhDeJDQ2J
         RUZ8SzBYRSHY2cNtv1oz9Nh1+bXrkCcNQfZs3Hhv+m/UZMnn/ngaTdyMAkk78nYes6b5
         uj+GsX6WzOpT5RNSg4IGU3r3fiYlfAmAzBLnQ6VmnLRMOWPj36YEwPbLCkMJMsehdHpz
         I7H0RIYVSPq9is69k25mfg0/N0EQE8tJFJ+AsJc2hZfxPvPvGHi1cEGp6O4YtldyEIXR
         CmQ+3H7dc9F3XgJsFFgiATWyEuCBbdnx3+GF2zgpauLx7UA2/4Fw0MLXoAj8GXAskluJ
         Wg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nkzjtExVPkivkjjFe+rV1AWglz4vv2i2oMPXYlHYHoY=;
        fh=qIm+w9ZiH+fj4X0RMx0KCo18fN8GS1zSyvA6D1kSQPM=;
        b=A7H6J4Wqx4SKXKjNt6/RavIVEOnRdx6WLiEYOtE5an9AGjX4PRXIbWA553e9AMyRDz
         CLE83oYGQtCkDY/qHB0qzwCOIbz7jHoBPnFkvwIYSEAlzvnPIHK6fUKkKihpvy7MGt9m
         8lDY3zTavsNsgskEUdZEgz7wNol0bq1moraUpKwJvYtjJ+puv37xtxZHUn2Cac32LM2w
         Q8k+somdiLyxmou74iuNSEcfGy39JgBiULtaIeSeyeDB9MSddCp/ZaWWy+eZLvqnCHQh
         /7cZxuEhIceZuAlEN6ACCdmkcNAL+4mCnFzF23UcmKth7rcBRyAAxqWSWwUt0Ohz7m2/
         U4dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790988612; x=1791593412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkzjtExVPkivkjjFe+rV1AWglz4vv2i2oMPXYlHYHoY=;
        b=iB+hWCxrWhzmOzjLv0oxkXZWQP8Ug85gjp+TtXtGb1w6jfSi0rEvuUNiYFOOBaVzx4
         Z7YENzpvMz2Qnj0LnGKndz1b/KebzQpBk0BQBrkeR0cedhz2bZcUQIXu/y8l3bcJdA9Y
         T9YvCqwviMPfMSdvxvIaH8FDhJzxGuu5o5S+Qtt1nkydFRiuwgVXVExDttfR5QxhDwfi
         MAZcmqaI8AzupwqdcKTLbt3dXLGg1LiNWn7a7SbF/Yg8bHIFTgs2V68y3zn8zyh9SC77
         dSAIr5zfAbuBWBnOpDKUjhftNA41dXfUov6Mnh30Sr09xxhXbAvH0GSZ4Q6JmThbAllX
         uBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790988612; x=1791593412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkzjtExVPkivkjjFe+rV1AWglz4vv2i2oMPXYlHYHoY=;
        b=EviwEEVHkTrryVT+cdpa7hih30O4Vp8UpD1KAE/un43G5/LdqxVt7epJ2F7F1vIWzN
         WYCFXFmE2/OGH2V38OT6o0/GK2J/9HyvUozGp0VRygfaA5vBgvSWT3LmKV7c/bSWoysE
         SKON01yhq6YUdpRWKEizgpcDax9XAdRBFIKZhy9LLSnnBN1YwsyFH98ugdWcPb+m9/IS
         CACwUg6WfEi08hkt0yZSdRqhjbVIxhQ40B1a9iSocDnb0Xc8GlWYS1POhSRx9Lh/i4RL
         zhhGBpKLgWSPWTDGUjAP24nkX9eLhOTtq8rPsP3oEXTghcyy7Eca59fE+/qpkR9hyl6d
         HD1g==
X-Forwarded-Encrypted: i=1; AKwUvBxGuQxnBnJTq4ARrEmRvqmpqnp1vo6zIQWglhMYbbcXS4zGZ9tvBGwu1oD1U2XgJ3RdkOARfgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPXRQsqm42Ha8+1SS+Apu01kzga9zO1TTggJysd7HB5qrr67Wk
	DcVQq6yMc8DB2ofwkqXr4qE+L9WJ1v7la/KzdGRirp564sf4O631Y6gmKTL+A+dQQWQjptePWGR
	NifQdwNm/MoAM6Rq7+w0Yy8wImbCN/Z0vChQVQZsc
X-Gm-Gg: AYBFou0teYtLctwB7SGblM4iLAHYG/KYYedKMGqj9sUFd+1q+1iaOxAZuRpgj5OhwMS
	scVosxnPGhZXufLOpLA5SMnmkzBrXgTaJ55tgZR+6CJk7ZG/Cj0XWZjl8KG9QwJyMmFyRa6O7rm
	7OlaJnoSPbPkRhNhxNgwB1G6TAKiYdbmIxuuaSfQ0VVpLitb5PZuUF2FJIn8RGDMouGOGR26IrQ
	rhgi6TdpBlbLXaOLiEGpWYwSOeaaMSjU6hHQ6AaZ2gITuz01zeTLAK96VRN5BZh/k98MI/zBrQq
	jbu2eVD541XCgrxMTuAtJdZ6KILPR7CWqEz+1G4fVgtqhwoP/swk3eCjed6Sx0F/K4jZG55QlMi
	YLn11TZV1Moc/FVVWz0L3Gw3yII9YHzl8Sh/5+JVbj1tx0kqe7sHwQa8v74JOLDvc
X-Received: by 2002:a17:903:2c06:b0:2dd:8958:f8d5 with SMTP id
 d9443c01a7336-2e5310be739mr2414635ad.6.1790988611797; Fri, 02 Oct 2026
 17:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com> <20261001-linux-mpnic-v1-3-6422ee74233a@gmail.com>
In-Reply-To: <20261001-linux-mpnic-v1-3-6422ee74233a@gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 2 Oct 2026 17:50:01 -0700
X-Gm-Features: AclHuK8MmjgjIkQ-hlqZizE4Eo7pGHiHcfRGfCiZpXQ2buJsOrddTJUzbSOeDvE
Message-ID: <CAEAWyHfRqE5wJTi7jq6LAK4-+i0bTFGzVU_HByEGUJJ7sGcGbA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] eth: mpnic: set Rx buffer minimums using
 page size and mtu
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 9:46=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
> Set buffer based drop thresholds in the Rx path based on page size and
> the max MTU supported. The device will drop packets if it does not have
> at least the minimum number of completely unused buffer descriptors
> available.
>
> These thresholds are currently set to 17 BDs for both HPQ and PPQ. These

nit: if there is a v2, it would be helpful for review if terms like
PPQ/HPQ were expanded here.

> are overly conservative. With our current max MTU of 9742B, the settings
> we should target are:
>
> 4KiB page size: 1 HPQ, 3 PPQ
> 64KiB page size: 1 HPQ, 1 PPQ
>
> The HPQ and PPQ rings are always given PAGE_SIZE sized buffers.
>
> The RDE_CTL register encodes the thresholds as one less than the number
> of BDs needed.
>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  drivers/net/ethernet/meta/mpnic/mpnic_init.c | 13 +++++++++----
>  drivers/net/ethernet/meta/mpnic/mpnic_txrx.h |  6 ++++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_init.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_init.c
> index 2daed458f5fc..ace4124158fb 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_init.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
> @@ -10,6 +10,7 @@
>  #include <linux/sizes.h>
>
>  #include "mpnic.h"
> +#include "mpnic_txrx.h"
>
>  #define MPNIC_MEM_INIT_POLL_US         500
>  #define MPNIC_MEM_INIT_TO_US           5000
> @@ -272,10 +273,14 @@ static void mpnic_rxglb_init(struct mpnic_dev *mpd)
>          * the per-queue prefetch FIFO.
>          */
>         mpnic_wr64(mpd, MPNIC_RDE_CTL,
> -                  FIELD_PREP(MPNIC_RDE_CTL_HPQ_DROP_THRESHOLD, 16) |
> -                  FIELD_PREP(MPNIC_RDE_CTL_PPQ_DROP_THRESHOLD, 16) |
> -                  FIELD_PREP(MPNIC_RDE_CTL_HPQ_LOCAL_DROP_THRESHOLD, 16)=
 |
> -                  FIELD_PREP(MPNIC_RDE_CTL_PPQ_LOCAL_DROP_THRESHOLD, 16)=
);
> +                  FIELD_PREP(MPNIC_RDE_CTL_HPQ_DROP_THRESHOLD,
> +                             MPNIC_RX_HPQ_DROP_THRS - 1) |
> +                  FIELD_PREP(MPNIC_RDE_CTL_PPQ_DROP_THRESHOLD,
> +                             MPNIC_RX_PPQ_DROP_THRS - 1) |
> +                  FIELD_PREP(MPNIC_RDE_CTL_HPQ_LOCAL_DROP_THRESHOLD,
> +                             MPNIC_RX_HPQ_DROP_THRS - 1) |
> +                  FIELD_PREP(MPNIC_RDE_CTL_PPQ_LOCAL_DROP_THRESHOLD,
> +                             MPNIC_RX_PPQ_DROP_THRS - 1));
>
>         /* Receive side coalescing is not supported yet */
>         mpnic_wr64(mpd, MPNIC_RSC_GLOBAL_CONF,
> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.h
> index 834eb9bfffd1..9397010557eb 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
> @@ -58,6 +58,12 @@ struct mpnic_net;
>
>  #define MPNIC_MAX_JUMBO_FRAME_SIZE     9742
>
> +#define MPNIC_RX_HPQ_DROP_THRS \
> +       DIV_ROUND_UP(MPNIC_RX_HROOM + MPNIC_RX_MAX_HDR + MPNIC_RX_TROOM, =
\
> +                    PAGE_SIZE)
> +#define MPNIC_RX_PPQ_DROP_THRS \
> +       DIV_ROUND_UP(MPNIC_MAX_JUMBO_FRAME_SIZE, PAGE_SIZE)
> +
>  /* The page a buffer descriptor queue is currently handing out. Records
>   * how many of the references taken on it are still unused.
>   */
>
> --
> 2.52.0
>
>
