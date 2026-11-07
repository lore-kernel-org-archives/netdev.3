Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794021235;
	b=L4ZajPxutCGonPrbOupec7fdE56bizVS+F6weN+Q9tcG3CCclrQ2iVQ5VWYs8cELr1zz
	 0Ibj/MiTiU7xeEwmP2+X9tQ5WjZ4j4qyAXw0TI02dAP6uH1OApSYCQ9FIrlIQZj3T0N62
	 8n2xJIOZiepz/W3wBRaYW4e5suFvrO2QMyb098K03nsGeWvCLkj9yU8FZ9HFTdxCrW2HX
	 ILsuCTC4RukzMPN4QSakwSZ4vl17s0sLYnQIYpMk5qv63DquwWzcoy+LkkVfI0YBXZtyB
	 FpvQxA1XKFCud8UNBFAleuGPxFA91tTq4/GQ+EWc9WjVd5XsSgvU4vbq1GMp+y4C57A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
	b=sFscw3vfLlBbxt4FEVhHqXJLfbyrp99bQ5JhfWtEyH1gRuXXvyTOPXwCTxWXqdP/GnbU
	 XN59+BMlO0BfFn1IObZ9ioYkKtv2efKb3XnOGW1wunoMVRtBbSvq6zVp0tiamDTthJUf/
	 eme2YQGk3kgN1PW7exzneAZpYV9288/Z5L6HVW+3tyI672ChHgnsqoq3s9m+QEW63Mltq
	 1zF5EoGz5U1KtckbpDHtpTZ7RZiLKkYTAt+8hRbHWrPaYdKTR2wA8XRbb36IW1yZMDMRr
	 OcR/90MJVOk9YoPAve7OAaJFrH3fXvERCKB5muM5yD5EqlFja8CDomdqcAj9Xj9RAhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="K5/xSYU2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA0606A330
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FBA0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K5/xSYU2
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c434376dbebso48101666b.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:13:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794021234; cv=none;
        d=google.com; s=arc-20260327;
        b=X7QtFHT5llHqYO9LcIALH0PYYN3Iw3f/MgouWbvNdK73NNIStVb5PeGcVYaT/1FPm7
         UH3qv1dbu3hKI3KrOvXeT679RpUAR7HN2ExUYox78T2lhV7Grb7JEgEQdCTUAatwY5EM
         pQglgLUv+Ozx7F4IvKObMGGdEKT1wxmhrRC9JNEtou4oaVB4BH0PHTm6BJDsxMtJ1xx5
         4ec0tNUT09YRXUcDDj0WxYz79pqGfJHehJOTlUeVoO8yIrWar1tFtFq22+EpN982KhDN
         K1XLn4keNImaWMoiFeNBCrUgO9kaLarLy5SL6RfrnfLmA7u9N7o/8NX5AdztICDvVgcD
         LzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        fh=FNetVJa7K4MYOSQ4gBQlsJ3/dPfHoNdpttK2LTvPMI8=;
        b=AeTEPifd/v5HF2WEp2sRW/yht7jlQh2vE+oohxAzpADT54xQJ1w1Yb795Y8QLxyHvZ
         iRW4z2SrkjzrdKIjW7AmZpuYMpfY3pj/TIwVw5zg4vxymDgCM7JQJTpM62rassO88el6
         yWDD9XR3QqGurgDGHrLoPiGSaS6GWXBa5yrGqU9JzdeXWVrjjDa2oge1Ij6XzlwCXa3e
         bKfKAEwgwxnf4ZUcvkiwCw04cz+BiFnjUjDyy6LNx9YrcX5bOeO82RPYyU1NsCWvq+js
         sk0M5oJXZXRglPy4i2ivL925+RG2N8zX4RHyG4sOc9ws4gt6WWpIXoAisAKuj3meogIj
         jnjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794021234; x=1794626034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        b=K5/xSYU2sTp+9F3Ssc9dMvDglneH6jUV7uspfeiii9TYyO072Qw+6C37+H2BuqkWhv
         4rseU2AYAVe4zjHmf0l6pCh7AK5v/CIYQC/ejfCs4DvYqK+kQOJqajhjMCEatzHYNUvQ
         gfRiiZd87mSWTSTX3Xc/Q/VNX+3fTAXEM54dMFBptzvI+h/iN+vLCb/DZOm7Sb5iV45p
         2r1wL6zEAzXVmcSmcQ3RIuZcM/htexTLwdbXmAfWmJ+b6mrIuA8sA3+ogMk7BMgA55G3
         +V3fAM9PBOvMP6b964JFduPMQPJVNzLOmEBClMyhd1REGDF4dW8Ov33ous0HAIWn63Uu
         TPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794021234; x=1794626034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        b=PuGpsQigveGa94XaAqxvMVgiBLi11cf7w6DTwD4rCcf4TO0zlJrQlG/7YDI6Qsv9Mx
         tgJlQuAwhBWBuwVeGcQ6WIF1eVdY8i1dYLRXM16UnCaTLVagNiNMuiaY8iq9wNxWzXha
         6nMXIXGhelilZk3+h19K1q7DV+2FyNHJCgaU8he/Z9RwsnIV0FvGvZWOgfRDiY5bwiJU
         1tq5BvQgj8+JGBd4hlLfNpa5qAshCGIE82zD/Zsp/vhhHplnueZYa/jh/oBN2zqwQ/wL
         nKChAJng3ix+yvszfcTtJF06DLOfD6XNMRNrKi9JQHDk3KbRuE8oEbz43Xmmz8+g6w8H
         IL2w==
X-Gm-Message-State: APuU4Z+DNeSgVKbX8OZIlu5zIbbICFuSd5c6xEkPZOKIAC20t9zS+CLq
	o8+hziQFeIsvSmNoBPMgRuRMHYVwnMVhnXcLnmEkUfTZGH9MqnEnNWAHzeJr/QiMOFZvF9QGwP7
	DrZGfGhiB2ik+RzLH50k62glRM/N/OSUElVqhO6BZ
X-Gm-Gg: AYBFou3pTgl05nrE9Vr5ofdx34r6/xTq7cz+H4SK6zV1Cf0qZfZJiTl9DI212eotqJs
	8h5r2xN6th1N9Xejy7rlLwZ6zfB39CEzrnhj/hpWWCr7cil/dC/v13DhQHLSP35eWAOfjC1zB+6
	8s3wtS4f3vCmNbgdJSWE3F8y+dUWvv9k620Fynhb3ThSLU2if2FYEF12YNEjE0usl+V+G0WZ+Xv
	E3pMyTkwFWkdOd6HLX6FqGXD2qebKkwqI7UmQ3azzqCY1VxqSGhM08XMpFwFjIzrJlZdRfarLZi
	KoLC8VbPcymtoHegRMmilx6CdEGPZRIBWos1B0IDC2KW/StGTCfpAXOno+NNLW3heBwAw1oAy6R
	koYpnv+rr5y0IQ6Q8mMeIxXQR+Om0b7Pjd/xkL4F2sDoYZE1tlijOk8cPQbEv2Bsllpo=
X-Received: by 2002:a17:907:d22:b0:c3f:2:6faa with SMTP id a640c23a62f3a-c4d523bb4f1mr41862966b.1.1794021233358;
 Fri, 06 Nov 2026 19:13:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106114551.212675-1-amaan.cheval@gmail.com> <20261106114551.212675-2-amaan.cheval@gmail.com>
In-Reply-To: <20261106114551.212675-2-amaan.cheval@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 6 Nov 2026 19:13:41 -0800
X-Gm-Features: AclHuK9hqj7STkrMrTFdH3gqq3iNgCshZou6dOEEbH9VmQvXrAu4YpDfrgJPse8
Message-ID: <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
To: Amaan Cheval <amaan.cheval@gmail.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	maciej.fijalkowski@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 3:46=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.com=
> wrote:
>
> Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> verify_xdp_configuration(), which until then refused every format but
> GQI-QPL. Nothing replaced it for DQO-QPL: gve_set_netdev_xdp_features()
> advertises no XDP features there and gve_xdp_xmit() rejects it, but the
> core only checks that ndo_bpf exists, so a native XDP program, and an
> AF_XDP socket on top of it, can still be attached on DQO-QPL.
>
> The DQO-QPL RX path was never written for that. Its page accounting
> assumes the driver keeps a reference of its own across every handoff:
> gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> recycles it with gve_reuse_buffer(), so a redirect target that releases
> the buffer synchronously, such as an AF_XDP socket in copy mode, can
> drop the page's last reference when pagecnt_bias runs out. The page is
> then freed while it is still DMA-mapped and registered in the QPL, and
> the driver posts it back to the device.
>
> Refuse XDP program setup on DQO-QPL in gve_verify_xdp_configuration(),
> matching the features the driver advertises. A zero-copy XSK pool bind
> is already refused by the core for the same reason, and a copy-mode
> bind never reaches the driver and is harmless without a program.
>
> Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 2437cd8ba633..4e9e692a0ed0 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net=
_device *dev,
>         struct gve_priv *priv =3D netdev_priv(dev);
>         u16 max_xdp_mtu;
>
> +       if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {

Thanks for implementing this!

Minor suggestion: Can we check based on dev->xdp_features
(NETDEV_XDP_ACT_BASIC) instead?

> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "XDP is not supported in DQO QPL queue=
 format.");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (dev->features & NETIF_F_GRO_HW) {
>                 NL_SET_ERR_MSG_MOD(extack,
>                                    "XDP is not supported when HW-GRO is o=
n.");
> --
> 2.47.3
>
