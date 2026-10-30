Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793341915;
	b=wamP/qKkhyu2FOY7VT0/HEZzJERziSAP/HGeuBU7O95Qci6BDVRggjwOHAOJXBDTA3S8
	 YCUEhtvGPfJ+zpiQYMc5tQwB/yHs/Go+8cAygnaC+dOLY+x7OlgQvQa7xDbva3lg1r6hv
	 ZKVzxny7HFlBbC1qG44D6lU0oWMNvD4aaPoopITaE7R/ezTpxVS4rdNxZIVgYjrbu+A2f
	 RYjHUfVyneoBNoqN8FwgbjfrIlqMWjsSTskHBztJFDEvPRy7cI70S+TPAxkaTwds+Xtjl
	 khzUt3nuYpVebVj6doVnSXe+3eqV2eSVaejlxvUTvXrbLWHRtwLXNO2yWDpQP7biSZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
	b=OTbUKxoh5ue+VqgLf9zbkip/EPuTWUB1Bzk1OjLN2gwzw3xhqITfoF+Xeu8Hcx6933DC
	 0XUnNEMgfstAJR/wFs5eD/m97a78Em2TONxD4vPYQ5giTZrg1shnPhahyfOigF9wiPDED
	 gWWIqHDKSxyjWPideEP3DWehfhRAFGJnf6xrmsfHhBH3Qi82eUMVznCBhZ3ON8qAxlXll
	 22h/1qsPOT52AHGfEndmTaler+/BRPcjtWzugRlVnSD8CsLq6YK4uS9ogYjZVnl0krQXC
	 4cOexrkt4jGNSboDmfFy1qDXYM6YTJC3dvtMrHtvZwmcqTzAbzwmCarJm6g8fWoC8zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHhGZfld;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE54606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE54606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHhGZfld
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1044252eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793341915; cv=none;
        d=google.com; s=arc-20260327;
        b=k4NkCEEUfUcyhN89MTsyMj7z0b4qEDml7Oylrj3On0T1OLmGywzpDXXKsdhPDatw90
         wjdQW5NeIA/QgxOFROH7UUZU1+5J/ZqGAg22r2mItbBaCzsIykqVEE+1AEGwXEc8ZnC4
         jLOiSUJmUplJ7ZclT2QZ06FMx3qIslPL/9E03RqoowgQROvWKFv+9FhyzfItJj3ZCE5z
         krhg9o+mUO1MuFb7leo9xIWBUm5QDLC1UvN/f4Tt5naEfqF33LL8GLafv/wAV5bzRktQ
         0I1DA+y0TPoH8CWjuMwpf5LCuWQ29pxuXJ+YQ9/5SdswA0h05bUL2p9lbCAxQWzoCA/v
         8KUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        fh=sV6U3VdpRX1J54OJeX2LQRgm4HfURvYJx5UQW9jTQds=;
        b=NpENHL7MHNHfOPOeU4U1jq2JY6bpSLnE9narUcvjk02iNcdKCqxeEy8aN+VzUGUc4Z
         OnDK6fMQIv0NVLlReAPUS5+Wq65KQwUPdfeiax3e+vp5ZBGafUJlLapM2O+ifX3mNto6
         jZri/RO+lspOWGRN2CMXa8ue6UY9uHHD7yOnl4dpXMumirKy4gq1So8Ymxtpd9xqvAzL
         jTtUZCixdoTnc5nmnCtzMibjb1d1tdpLJ0COysUOqTVID6RPpTwV1eEU7kQyd/IQFThB
         ADf5KiCCdbLWLTMTkscHAaSZtmx6fgraiN2+Z/abmb/FZa4L2qvb/1a0AtpGrf0oWfPe
         mw+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793341915; x=1793946715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        b=cHhGZfldf7rwLhH5KKbJjNDRKRapNAbZx8eScm4G6BCmNEX/trTh3APCkLfh7RB+2A
         cOLu7dpCFuIi/m+jx/yTUFUZMcJ/kJsLk0BeCCxGTjWwhL7Fcn2U+1mjgVSS+5x+MocD
         3qorXUcfIr3oq9+t+uVpP9+qFn8OYOWEu8f4WNt8FwjsiisYzVDtYEsHOQZK7cmuVU8s
         3WGPwDeL6kTP/eAYTW0bJDdrufMyckcJZzLXjlZWf5QW4juLEPZ3WWHwuz41GyBX9HjW
         PKxwgfe8XIQzCbxMVJIXkqmN2gVFfKVlfxMITH16qONvocH7wAlowIOwo20nkYQaUR7p
         pDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341915; x=1793946715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        b=oiFFDABVSXlhBF7MisGuE7n0JL8wLdVtNxkvhFcPTsiyG1Je6Ep+YM0vYP7lnbF9je
         kpPF/VHQN7VXIx6evfD1fGxGkRGYu3geoXGthyIOSkB9pZeeiZn5fmZR9f+N/CQlD8bF
         gsICUJLJ3JqibaL2X3GlZNxkdESPglQCD5Nm5BkboITMjFETqc1qW5WGvkBUwuQyx68s
         QmUEJ7xJ7XatrtTOxVDwQHBhbothEM9en5Gnk1AS0tnv6B/aKwT7JTYAcIu8ihn4Rvi8
         vDQvLAGX7fklvOg9gaEm9FTfyVHS+qLu2p3Lo9gyGrtwUDVTnml27PTZ0ukIn4Tkc1Ws
         cJvg==
X-Gm-Message-State: AFq9FYKBBURPDKf15BS9HNvWh2hcM7t/jweUNSwkoosEk4RaGIKX7RRq
	HqYVR0DlS8TQpxEWrRypsquyzusSZ6te2ITg/o3TX/x6RmfVVKGyUC6O4g3drQcuHFKdzSzlS8E
	zxHNbZEFcq2COpFv75QsSqywQsKVS7bA=
X-Gm-Gg: AYBFou2v7o+p7Sn8CrF3rOC1DjuauieNeUHODFLLXVlCB+UpN/3DdVhfCvjne7LHt+G
	YWXJMM+elU6f8xh3HlgVICBy+ge6Laf6w6Emq6P+Y5/1kwh/vdDrddt2nEp1bj8G8ibljsaKcWE
	Emkm4kOT6RX6IzCARq/CxfE6PKO9WF8zdhbZWT68TCvThpctjDBXdCjJclnwzj0p4Tq1hYrzEUq
	kEjN9fRszMUXy4zZC7emuboS1RNhZBprq3T60IQpw9/iebxa5az1dqIMkXgKq+13UlWNBoMDlIp
	sAY7VaqLr5xYJ4P+sd2HRJUtGKMLss6VGW2V497agCv7FaF9MJ0FArgrpU5UBEtM4ZBIYUy2z5G
	ovOoFiwEaKepyPdWGzcdjhHgxjZb2QZpXpXzB9OT9O9w3zyQqWApl61XdnRv8mYK6adcKBcwXMg
	Z5OSRdf+E1Q1w3XTvmYttXbWOtWikouIygNM0Rt7skK5kVKBrnY+k=
X-Received: by 2002:a05:7301:618f:20b0:369:fa8b:d725 with SMTP id
 5a478bee46e88-36a42440a69mr2479370eec.35.1793341914428; Thu, 29 Oct 2026
 23:31:54 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com>
In-Reply-To: <20261030023248.78802-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 14:31:14 +0800
X-Gm-Features: AclHuK-3MmLI6pDH5EvsdDyQjqZxLAj0eXtw9LqREvrfIl7g5xpi_yP0zHn6NUo
Message-ID: <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:33=E2=80=AFAM Rongzheng Wang <testwrzwrz@gmail.c=
om> wrote:
>
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added =
to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
>
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
>
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
>
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> ---
>  net/xdp/xsk.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..aa6b010192ad 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>                 skb->csum_start =3D hr + csum_start;
>                 skb->csum_offset =3D csum_offset;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
> -
> -               if (unlikely(pool->tx_sw_csum)) {
> -                       int err;
> -
> -                       err =3D skb_checksum_help(skb);
> -                       if (err)
> -                               return err;
> -               }
>         }
>
>         if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> @@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>         return 0;
>  }
>
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
> +{
> +       if (unlikely(pool->tx_sw_csum &&
> +                    skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> +               return skb_checksum_help(skb);
> +
> +       return 0;
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                                               struct xdp_desc *desc)
>  {
> @@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
>                 if (xp_mb_desc(&desc)) {
>                         xs->skb =3D skb;
>                         continue;
> +               } else {

Why are you still using this 'else' as you already posted a new one?
Please take a look at my previous feedback.

And please carry the reviewed-by tags through the version next time.

Thanks,
Jason


> +                       err =3D xsk_skb_sw_csum(skb, xs->pool);
> +                       if (unlikely(err)) {
> +                               xsk_drop_skb(skb);
> +                               goto out;
> +                       }
>                 }
>
>                 err =3D __dev_direct_xmit(skb, xs->queue_id);
> --
> 2.39.5 (Apple Git-154)
>
