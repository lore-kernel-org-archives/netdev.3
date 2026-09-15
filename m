Received: from mail-yx2-f30.google.com (mail-yx2-f30.google.com [74.125.224.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849D466AE6
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515850; cv=pass; b=CsNnpURWpb4mrW5LHI/RpkgxgRAW5Pd4ONQfYbhKs2ndhoywt7yzqqdDSILy/HfFxAdsuJrsnr/ULSqIfjAov5GCQZoSp0y2kMPOz4akw5B8dGpV8OtOoTUnvSYeXfQv49Pd0Mm6NaWHTe4cn1fuOenXpY8QSB8e5hK0j1jMNSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515850; c=relaxed/simple;
	bh=SGIjU28TwfoxKzBSfbsOu+03oHMa8aeBE3oxpeVz2OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyAVRZQrAlrfwGEVYZea4aro2CIimGGR8jdI2lr7XpL0gVUn8Tsm2Adr2RzTGYtDxY2OrV6VA6nWQKWeAcyBC4/RxU498NTofIONvcGHkppiQ26hp1dibFrYTVtRyMMSwNw53CA+0JUS4UQ6EIihduLJqC1lbGmEms+U9ADYooU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRsIQu34; arc=pass smtp.client-ip=74.125.224.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRsIQu34"
Received: by mail-yx2-f30.google.com with SMTP id 00721157ae682-85d440939efso3218317b3.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789515847; cv=none;
        d=google.com; s=arc-20260327;
        b=s5iDkPS3QLq2wH5DtwpDFgAvwf5fcQ4jo8858eVdSPxDIrTSP8batM+Kbq5tSWEFY5
         BzvYXKWJyBILR0A6qywF608m3d7Rjlg3uzmchyeGY81/1up8PGGLW14OIP3gXZ9TuIf6
         QyFeBAnFOzbJInnUZfvC/bAiNWEI3qPOiADZqZiaQoPScmEekuLjWM/zh7kumSSXF+LY
         9110OlRDdp5r0XblnEwUSwAgT4gWeZ8MBeprvesNQPQ/iNSp2SdUlbGSy5EpxLXJu1wY
         24SaFHe9zduMgrxRLQg233SYXmi4P7/p7+L/S+edv518tinX2jdHtRVN3jqtt06Ie+YQ
         FOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ESrn/qED2M2tTRTVQuuTadkdChzosu4LGKtajzfHSeU=;
        fh=iLql6UweJyFd14lb5zDyt4GbQG1HxOwzwYf6jpQe5Mo=;
        b=rfgJbtPGSkV4zkNJK8scKA5vDKvJvesQ5Rlr6cVjfA+rYrPIlVV9lAzjW0wtCvBJ2l
         zTzuqRdE/q3FY0v55LohST8MpXh9FhPE80E8iuTE43HtOLrQ/RWsqgGbovgEFcNpXrlp
         Ohd0kHT4R3lxF38N5wjZLtsnagCJdTV2QUPtMKIAejMg/EixIYwOelAX45ZyWPBP9tU2
         lu8djjh/Eiupy7tfB9L0nZWArsmTlrGf86T4s4I7hiMgV0UlMUGmwa12MbXH/tHbCiw5
         SFm6BC1pNFbD1owp4CWZ6C8Tm0fvbipuliu2PDAhRtJhJc30Kra6Me8rxAv/Gs9dKSHz
         BYYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789515847; x=1790120647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ESrn/qED2M2tTRTVQuuTadkdChzosu4LGKtajzfHSeU=;
        b=gRsIQu34LidJntSFtAU7Lg6RftJa+4Rpc84uuZ2hZdszOUeTEqeTX2MPKVidS0IN/v
         EinUEP+tMbtuQXIM1ahhct/s1FRWltBDH17Q0TDUsQNmz+4JjCEWTLEHMUobulNh+Ujh
         CM+LZqrijLL3vaqpuKETN4O4CpeTZ2sJbJDjS5HLjLbnYrBDsAikyeuhPmqpMTYua5rf
         P40V+fqzrZ/1R0uvzf1UP73wmxZtqBS6Dgg7+SrVEqbyYP9H9Cu71M8z/XrAycC+4SBd
         VdZm5iE+MoRwbnWTQTg4NTY0ppy+TjhfIk/d1VhsiR/ZxiLtQaEJZKojWUg8tFbM+61r
         G7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515847; x=1790120647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ESrn/qED2M2tTRTVQuuTadkdChzosu4LGKtajzfHSeU=;
        b=db7s7XL2N1+H5SN8owZpbb4G8IUSzLsLpEC3wa6HLBsha2HW4f9hErCYRmiO7yugw+
         d92yeHRTpxaH7WpNKsXcn7PZJ1KwpF116VsDbYAzsAK3y8kFxVP6kZY4P5wUchkI5xJ7
         7rJJQibnmTYnoAVbNbSHayfbIyseYVxOsL5BJtjvUHUwcI9iuQsN46bWIg3DHdjtx6TX
         X8Uc7gw7iq+qKk0GbpN2oy8pobIPodDtDkowtzu66bZKa6AeQ5TsfZQ2hdrwamRcUEMr
         GzMlcZBWEqs4/VuIK4YeDnUFzI1K2K3zw40yooAj8BGCBiZaz+BnehIV4lU4NQ2qDV8I
         vcRg==
X-Forwarded-Encrypted: i=1; AKwUvBxcbT0Kx5ke6B/m8Ijz59XHnHhm39geoYJAQ6lMfsylQ3EzuGz3w5LqZbhvOGNlvzHZ8uLpLZI=@vger.kernel.org
X-Gm-Message-State: AFuF++mr9pKVjq5pLd/B0Q10Vtl04ZCjvAMa/7BFT1wKLmxw2Sp2Byd4
	aBE1ydxaCcxsBr5G5qcwGbOpCTujTSPxSFHtkr/6/GL/srbeaWHUxvhvzkTVoZwdTI7073xSvtc
	dtfuQ62pCP9H41TZUyfciXXDI8ix2Y7aHLKyRfO2b
X-Gm-Gg: AYBFou3/evaSN0YxEjZpS22tp1W5O3QgQemSyonLafuSbTvDrGlmdF89bKdlVR0M8GH
	7UiaDQgfIU2IBjgRg4FzqmxtSeXYVjqLqnvuWlmPTXOSAAvWFU/EvucTzlz2gB5QYOIibcbn6Qc
	LTi7lEVnV74CeJHZwsAagPf1jPNp8JBo0G7icHotOb6sjI7Dr2FuT/6JU4jMSeLJjjeONN9gksv
	GnJPPI01egKyDoHBbYzfUNNzJQzYkgjEK1mDczMkm/kV6y8NrS1juobDkD/MRpEbNwpovwMYuD9
	LJx/VrJO9w6aceDlVH7hn4o/Gnswm0Rk1HIFQI0ksKBQFlmrWxsKxR3JeXawhYCbxiXlEQoY3/0
	qlL+T1HZdZ6qkQpz0B0R/A4RSRXXOnxc0jKUpWyMxA5BIoz6WNDKztEvBqavhKTBMFCpljx5O2g
	U/29iK3+JP66BxjntDRpHsi5IjFNG+4GU=
X-Received: by 2002:a05:690c:c045:b0:873:5bb2:6c1b with SMTP id
 00721157ae682-89226db4172mr1528937b3.69.1789515847086; Tue, 15 Sep 2026
 16:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908060410.3982-1-nashuiliang@gmail.com> <20260908133636.2ea807d9@kernel.org>
 <CACueBy4BvJ6E0RuUDsQmwPq_zt9Xh6T19DOAkA5MW-uU1yNpKQ@mail.gmail.com>
 <CANn89iKYQMPm_LyYY4v48QmoFc0MwkkKQwggd_BLGDJL78=8qA@mail.gmail.com> <CACueBy4u-2yHHysZvs_a=VQLe4PtY9-qjkdZ3gFn_eVKmyspOA@mail.gmail.com>
In-Reply-To: <CACueBy4u-2yHHysZvs_a=VQLe4PtY9-qjkdZ3gFn_eVKmyspOA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 16:43:55 -0700
X-Gm-Features: AcwNN1XvjZOB1E1lMNws61UgnRr4-SLHJpFjowvX10dxrWry6rWUlTn5Utv135Y
Message-ID: <CANn89iJkPPXruitnot9D28Xe5LWnD-irtgCUEOpmFfVkG4M=-g@mail.gmail.com>
Subject: Re: [PATCH net-next v9] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: chuang <nashuiliang@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:01=E2=80=AFAM chuang <nashuiliang@gmail.com> wrot=
e:
>
> Although there is a slight semantic difference compared to
> net_hotdata.rps_sock_flow_table, meaning the CPU recorded in
> `sock_flow_table[flow_id].ent` might not perfectly align with the one
> used in `set_rps_cpu`. It is still the least intrusive approach.
>
> How about the following simple change?
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3a0dd1f98084..7c513bf14221 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5236,7 +5236,7 @@ static int get_rps_cpu(struct net_device *dev,
> struct sk_buff *skb,
>                  *     have been dequeued, thus preserving in order deliv=
ery.
>                  */
>                 if (unlikely(tcpu !=3D next_cpu) &&
> -                   (tcpu >=3D nr_cpu_ids || !cpu_online(tcpu) ||
> +                   (tcpu >=3D nr_cpu_ids || !cpu_online(tcpu) ||
> !rps_check_llc_affinity(tcpu, next_cpu) ||
>                      ((int)(READ_ONCE(per_cpu(softnet_data,
> tcpu).input_queue_head) -
>                       rflow->last_qtail)) >=3D 0)) {
>                         tcpu =3D next_cpu;

This diff in get_rps_cpu() has two issues:

Boolean logic / packet reordering bug:
Adding || !rps_check_llc_affinity(tcpu, next_cpu) inside the || list
does not prevent calling set_rps_cpu() when the queue is drained
(because false || queue_drained still evaluates to true). Worse, when
!rps_check_llc_affinity() is true, it short-circuits the || expression
and bypasses the input_queue_head - rflow->last_qtail >=3D 0 check,
switching CPUs before the backlog drains and causing packet
reordering.

Per-packet slow path:
Even if gated with &&, skipping set_rps_cpu() leaves rflow->cpu (tcpu)
unchanged while sock_flow_table holds next_cpu.
This causes unlikely(tcpu !=3D next_cpu) to evaluate to true on every
subsequent packet for that flow instead of once per migration.

Instead, place the check in set_rps_cpu() under #ifdef CONFIG_RFS_ACCEL:

diff --git a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5113,6 +5113,10 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *=
skb,
  if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
     !(rxqueue =3D dev->_rx))
  goto out;
+
+ if (static_branch_unlikely(&rps_feat_llc_affinity) &&
+    cpus_share_cache(raw_smp_processor_id(), next_cpu))
+ goto out;

  rxq_index =3D cpu_rmap_lookup_index(dev->rx_cpu_rmap, next_cpu);
  if (rxq_index =3D=3D skb_get_rx_queue(skb))

This skips ndo_rx_flow_steer() when the CPU servicing the current RX
queue already shares an LLC with next_cpu,
while still reaching WRITE_ONCE(rflow->cpu, next_cpu) at out:
so subsequent packets take the fast path (tcpu =3D=3D next_cpu).
