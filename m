Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6533B6F1
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864403; cv=pass; b=iaDJBxUIZk8j8Hy20ThTZcYCsTkiqhVU0EaUzPXdnPr2ojf57WknoXPHKWiWAUflu+sWL/5GkCV2iBxQFvCxELTA1nuSY+YurpRUAoapkzH39PRzE1yRozM1bIbCr3uXf7zJOb5g6jwwYBc6GG9TDpCqtbkkq/zAw+R8Pfe1pzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864403; c=relaxed/simple;
	bh=pB8/V3XlrG5omt7Gz5mMSVLoHIr+uYCl606AtWvg3WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jokri2aFyqbho8WEYCH37zp8MQAItaNoXh41gSZCh/gXyBSBfkayUWzHsM0cJmt03/v1EhsRJ0Y2qqzOjwrTjf7dYqPPZDJyLvEPE9RnsOLg2TmgFiB9QEuUy8rpvV42uLZyLFFEj12iwUpqyYARDz+sYOFMjNJO0KDp4uq91qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bjjrxLZ+; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bjjrxLZ+"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so1558299e87.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 20:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784864400; cv=none;
        d=google.com; s=arc-20260327;
        b=JH2hR6V8ryGvRX/DQvUn/4ciK54gAqe2+KwMd13NZ5YCRRaxlAb/5hN2k3SX8HmsPw
         UaovTstq2WfHwb17fgDFFFg8QgHRyvt9AIPUBzsz5bsJS0h/5lPRxX97Zir4NkLAuUSf
         wSqmMqBVyfnn8uNY3/BlIUZWQcKgJRPgkN1/t03TLg12t1QsF3wyvirNvNjJ1Quy3VPX
         W4WNa71DphpPDWC0PPchOCMgh8msyzdP7WjMAF60yi9hbrgIj+AIs8DyqFXg3hR4q212
         V/LLBk7Kho4PUZTPmju7ylJbm473+Fx7orh7wlVzoNbs6vLAi5jukdbC/pIT2KpGsMnq
         dSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/jUaUCz0UWiUWGL5mMfIye/RyD1iev9TqicEqDX5xhA=;
        fh=YxWEdPGKRwJAtpXDu6LSidktygnL2ejlab4MUF1mRXM=;
        b=R7Vvid5ixrcczUV4JGhFeHm+x+QURRLKyEfSc8uCyBnACHXkXz1b6oV9gEjRpRqs3+
         teCAjNTlO6qIUtiliVK4PsTRBte5ZovFF67kPFf8/UaB6nHeYO8A+bpN1ZBndffhbDz0
         8aTMUSrJX4rZvek5lVv/hV36aXHo+/VIzpjcMTL0StsyL13Wnn0IIr4gcPCsZYwxbJhS
         6uXl+yEZFZKd9GwO025drSrPmtRaxBNGOO6qd3fVDkHO3zeBWu/LduRhXb5dWZu5E+xD
         UG2ed9PrrxeB+g5aVS/XWUWjW5+DN/RQLJ9ibRHnEJrgwGC/u3vXfSIDVQ8tZSUK8YdG
         oSUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784864400; x=1785469200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/jUaUCz0UWiUWGL5mMfIye/RyD1iev9TqicEqDX5xhA=;
        b=bjjrxLZ+i/gWyy5RQCwU8Vfgpz+ENMx1x/29cHdjXXaRjprqEu20bNsYRUGrzO1jdv
         57xGK6z8HCfD/0p2h3Rh4fsoTIqPXr4iW03mu1af1pWWxCtd2yY8ueP4+vGcgll1O1gc
         +bDfY3CTFSwDR+8idN2dOZsN0p7tWExLG6Fj2T6oQKhSKdyQ68aQ2dRWcjYVCwrZoLct
         EKeBCcZ5ImXdhDvWFddpZPelArV8vkSlk/TbX65jo2HW5m09I4saBB27nwhZ2CdLSim7
         IKcz2nNiXs9lHXGfqZrKPbGFy0OcvkU3IT9UX4zsr4TyKFFAVVy3drKGvCmHal87mTxF
         inLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784864400; x=1785469200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/jUaUCz0UWiUWGL5mMfIye/RyD1iev9TqicEqDX5xhA=;
        b=BActdZPSizN+iioLTUF4pPt5GGsZmmvXN/j4DlSbSmUqIimnABisi4RPN4snmMgy1A
         LJtUixt9zQWUdwbzxlg7G9WbKxXDYGw6ls2TPcrOTZyGloFcEJIW8fvAK2fe1N1wVD5g
         +rsOacw7NKXw30DB6+o+eYLtQO2rw4aPVIPuAeU4tbGJB/pVBPLQPo2XmAZtLD5VfxcF
         It+NjT+X7ype9lAvXhF5/CFjl8d0/yMlwYyl1aw098t9iVBX/6el/QEMo6uhA0fWfeIj
         S1zA9YMEJR4BCufR/+jcVf1WlFjr+aBeyG/2tB4cSlg0k/lO3q2ZOZAh7pqMdIHcjV7F
         J0rA==
X-Gm-Message-State: AOJu0YzSrCpAUhblEZZVMdexbNqEKW37jPQVKkQpyFqM7mjqouFNBG7l
	AssXq0LkonvNosgsjwwMy31MxEXkjWarGMR2rNUkAVFXHdzknalZGavkfYmYskIYtqZTxEqZ3Z5
	Cgb3zL4laUiMzQfWwlIihB5RnpOqdtP2XIIAO9vUF1tKajYeNgS5v4Y9/Mmc=
X-Gm-Gg: AR+sD124MVY3OJ3mqEcLUlH3JCGguNPa+ywZDt7nK2pWswESufEWlIeyU9oHU1YqRaI
	IOkE+5CAVflE5gdYGVgfuSfBuk+Aqo9HKOMfxDCQtLWsQPDnzFIRo5KFQ9RMWkz2sHQ6YtYAvri
	DOOalHPnjDzJtpcpVHFkQZfvv9jqUg4wYMunrslStwR1Qwu8WUmx2+e2S1uT5nH0Z8GrQeZ7GUs
	9YFKSir3NHn62sAsZlzECArd6guMD6bSecDFhIIe6tky5ee3gikTJjJ9tlC1OVeS6wLGSNHDA==
X-Received: by 2002:a05:6512:8019:20b0:5b2:a353:e4af with SMTP id
 2adb3069b0e04-5b2b2f7a8ecmr887529e87.56.1784864399706; Thu, 23 Jul 2026
 20:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722221634.186886-1-joshwash@google.com> <20260722221634.186886-2-joshwash@google.com>
In-Reply-To: <20260722221634.186886-2-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 23 Jul 2026 20:39:47 -0700
X-Gm-Features: AUfX_myiu_NuloPmeS8ZU_Op_ds7ofTLCGS4h_nAjcrnVJa1oicB1rvJdCghtG0
Message-ID: <CALuQH+UFf2oWTnrSK6mW4+PAqPTyfwJ55Zr8hNF5MTPC9KX2wA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] gve: use xdp_build_skb methods for
 XDP_PASS case
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jordan Rhee <jordanrhee@google.com>, Tim Hostetler <thostet@google.com>, 
	Ankit Garg <nktgrg@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:16=E2=80=AFPM Joshua Washington <joshwash@google.=
com> wrote:
>
> Newer common methods have been introduced to construct SKBs in the
> event of XDP_PASS because many drivers replicated very similar
> functionality. Update GVE to use these common methods for copy mode and
> zero-copy mode.
>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
> v3:
>   - Newly introduced. Ensures that XDP metadata is passed onto SKB in
>     XDP_PASS case.
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 02cba280d81a..907a0c15bf30 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -736,8 +736,7 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, s=
truct gve_rx_ring *rx,
>         }
>
>         /* Copy the data to skb */
> -       rx->ctx.skb_head =3D gve_rx_copy_data(priv->dev, napi,
> -                                           xdp->data, buf_len);
> +       rx->ctx.skb_head =3D xdp_build_skb_from_zc(xdp);

Sashiko says:
---
[Severity: High]
This isn't a bug introduced by this patch, but does this unconditionally
overwrite the SKB head on every fragment for multi-fragment packets?

If an AF_XDP enabled interface receives a jumbo frame (e.g., 9000 bytes),
the hardware splits the packet across multiple RX descriptors. For each
descriptor, gve_rx_xsk_dqo() allocates a new SKB here and assigns it to
rx->ctx.skb_head.

Since this ignores whether rx->ctx.skb_head is already populated from previ=
ous
fragments, does it leak the SKBs of prior fragments and truncate the delive=
red
packet?
---

Multi-buffer XDP is not supported in GVE DQ.

>         if (unlikely(!rx->ctx.skb_head)) {
>                 xsk_buff_free(xdp);
>                 gve_free_buf_state(rx, buf_state);
> @@ -745,8 +744,6 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, s=
truct gve_rx_ring *rx,
>         }
>         rx->ctx.skb_tail =3D rx->ctx.skb_head;
>
> -       /* Free XSK buffer and Buffer state */
> -       xsk_buff_free(xdp);
>         gve_free_buf_state(rx, buf_state);
>
>         /* Update Stats */
> @@ -899,9 +896,17 @@ static int gve_rx_dqo(struct napi_struct *napi, stru=
ct gve_rx_ring *rx,
>                         return 0;
>                 }
>
> +               rx->ctx.skb_head =3D xdp_build_skb_from_buff(&gve_xdp.xdp=
);
> +               if (unlikely(!rx->ctx.skb_head))
> +                       goto error;
> +               rx->ctx.skb_tail =3D rx->ctx.skb_head;
> +
> +               gve_reuse_buffer(rx, buf_state);
> +
>                 u64_stats_update_begin(&rx->statss);
>                 rx->xdp_actions[XDP_PASS]++;
>                 u64_stats_update_end(&rx->statss);
> +               return 0;

Sashiko says:
---
[Severity: High]
Does returning 0 here bypass the copy-on-demand safety check for XDP_PASS
packets?

The gve_rx_should_trigger_copy_ondemand() check at the end of gve_rx_dqo()
appears to be skipped. By bypassing this check, could the networking stack
hold onto the QPL pages indefinitely?

This might drive used_buf_states_cnt to num_buf_states, exhausting the buff=
er
pool and preventing new RX buffers from being posted to hardware, ultimatel=
y
starving the RX ring.
---

DQ QPL doesn't have XDP support, so QPL pages are not in use.

>         }
>
>         if (eop && buf_len <=3D priv->rx_copybreak &&
> --
> 2.55.0.229.g6434b31f56-goog
>


Sashiko says:
---
> @@ -894,14 +891,22 @@ static int gve_rx_dqo(struct napi_struct *napi, str=
uct gve_rx_ring *rx,
>               buf_state->page_info.pad +=3D gve_xdp.xdp.data - old_data;
>               buf_len =3D gve_xdp.xdp.data_end - gve_xdp.xdp.data;
>               if (xdp_act !=3D XDP_PASS) {
>                       gve_xdp_done_dqo(priv, rx, &gve_xdp.xdp, xprog, xdp=
_act,
>                                        buf_state);
>                       return 0;
>               }

[Severity: High]
This is a pre-existing issue, but if the first fragment of a multi-descript=
or
packet is dropped (e.g. XDP_DROP), does the driver fail to track that the r=
est
of the packet must be dropped?

When the next descriptor containing the middle of the payload arrives,
rx->ctx.skb_head will be NULL. Will the driver incorrectly treat this fragm=
ent
as a new Ethernet frame and run the XDP program on arbitrary payload data?
---

Again, GVE DQ doesn't support multi-buffer XDP. This will be addressed
when support is added.

--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
