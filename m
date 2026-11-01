Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545953;
	b=wqq8Yt0is7ZO4O2+hxCk1Ag2Cqm+QA9KiJu22MNJMi358dMihSLNeoeRdh7x1UMQ8dBz
	 yWrNEqL9notCPt+sVVgSUgQD7sBBh7F4KaNOOcKWW6/J2xc7yaku4In2rWOWVpmV+FwTH
	 5mNxuClVAhjjP5hqBFRS4/st1SYDdkYkplJ0Xr9WExBJnDZyqmDQQs0O1BtS0ThI1dGi8
	 5JpA0HTvZ9HDI5GmbZ8Jtef5tfq+2Lbdrr22k1We7s6H0xyMbxgcfFExtKWiOaaIqJ7Gs
	 s9y8XVyiFvPpaXe2tzYnETCg94ifYYy5ODx9gNCYU8Pnnkc72dki8Ovbr8TRjE5s1MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
	b=STjT10UUhU/jeCHtbm7ss6QYWjy64zV/QZvbOi+mc7X4N841ovRmSIMZurHoS9j5INi6
	 FDNCGFEA3gtcMgqyfjZmNAvJjE3EsULwzyHYGWR7k+QMF3w+EEh1fvB8HDMP46aesivEf
	 jUn1uBSfSSn84pcQvH9shd2pha+4KICJj8cdiw4otHtYTdnSJrRbWLte+HrulMobkLPEp
	 xOAn7wUAZu+ltwIfxitP8YukfJghQSVMNlrfIqltCv419l8rSAE/+8rVLdncFQjBeRrHF
	 Wu09Kcv9clZLw6VvLc/RD3I1z+6DSCHo+/1nmrZA82AJ1IjVCCqyZTglV8lX2xYi+Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c66KTqbR;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C78606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 15:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C78606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c66KTqbR
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eadef147ffso1172931e0c.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545951; x=1794150751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
        b=c66KTqbRspE1LbzUnoODsXMOSNl+w9Gclx4wCkMY+MY9x7ZJYPZ3aOr0JmGnZje5LH
         LlNumCa8xwizIeOxvV31ghNVRoQZ1VDyObHto05hW3nQDlokziU4fv6u2qQMUImUThaJ
         ERA4h8llTxu72O9Bgn2yE3PRwtCawaS07wok0as4cOJesaYTmRKX6bxtMazlzWRtoD+l
         gxz+dtrAQC8ADPmQ56kH9TaJazAMNK6c0V1NnLXnq9c/rf8YFG4V1I+EW8t6iSGVHhUN
         /5GsMi7B+wq1mqHJAXfsTy3ddNvxs/MbQG6Qvg2RUAGb0m/8g3sOW6+zCD2EyBsYZKNP
         htzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545951; x=1794150751;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
        b=J2lnldrvaLWAWZB5Goh0se4yh1ka3eQLUSQP1EEPyE3ctcnk4XP2lJeKQlQ7V4cIfC
         vTONK8Vda1LnM2dHkWKD/3NN11pGvEID7QEK0yv3D5cM2YkGoK36oWBo4c1Yg9gASf3L
         hUiIgatw/TlNVYIFHvyr40YVacuEDf/Y6WHcKjByM2D2Fxs+A3OOEP/drT7/dQEIpXUZ
         rD7dk2VjZgIX3dmo1zsAmo/uT1V+IV1qQYkhLVOQVlKgDLPXWi8Ddfb1zjbEHt6J2Kls
         8BCShGKuGbNCEboPK0zZxMpdkeK4KyhWHxyg2fwIJudr/ft5ELkhIgVHWGM23880pAqy
         6hxw==
X-Forwarded-Encrypted: i=1; AKwUvByd9CHaN+tIVAHnqGU2Cx9AayPUZ5bKANrZFVlG3pPVoUO9Xza1T43/WJAnxVHQYdLfUivLAII=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0vw/lwZkNYQfmN/NwGvbEc+BXc2Dy6vhMoCGL8gcPCVoBEOns
	m7MUIZzXV5PPnI3lKgZHZsqmuzz9Vd8IpOd8hP1zCFLJwZZw3vXQ0bGZ
X-Gm-Gg: AYBFou1EgPVfOsUolh+EDT3/ojtf0bbGGGyUoiwOMJwfB5Eb0v7IPPjrL0BRMPMXnjz
	yg1y4NDk78Hq4CpxwUaBFb5zAuE1pC6Qkcwk02Bd5yHMuqlRWisw3sIc1FImGZKE6v6HjDTWiC6
	QnfuThGeNlIM8FNPotXDbG/8HfL1OtBfDwaoNnv01Qtr5PLzajQ6yamlonsN9ElVlAE18zvQ5F0
	7vaNtF5O/Q7vDMbt5IN/O/cc7hrl76PgSkthLycdDU+Qb286NLbwHObQvlnsk16C3sHOAC6e11+
	mtaq85PJuEZj9nh3XKEnzsS4h7B6+PGiS/lK0n0M470S18yOLh8vveub9EeIzikt3TPCwTB26Bq
	zEnqYVa7CKLqbdpGh16bsBezsyQkeO95mINQWybNf2QGQ+acoLBwIcA9CAp+3rNpniNcG1blskQ
	KT0kY+2pdJifE5uRxmtmaSiMEe7KnDs8mPA5vvSArSJnkiwG/K2rmOaoSaz5ZvfYQkFRo4Y2r6T
	tqLyo9ufgHItUhR4ghF+0Z33ed2slCiYStSYaUh2fT6vdn9D2k135Om/Rwq5itBuU0HGDHXGYKL
	IWqFgDnhGCpNqpDHSv/62B/YpGJa0OES4OttfQrIsQNBOIUcvEZyKKvYFf9BLQ43Y/+T6ldcoYX
	FH85dJtZpjsWYu4elVVJ+wTEDCOVb0CrAQO3aXDFpUJ0lX9vNdUlOiZ06jCoOqwEryxfn
X-Received: by 2002:a05:6122:c250:b0:5ec:7589:f9e0 with SMTP id 71dfb90a1353d-5ec758a14bbmr1957487e0c.11.1793545951557;
        Sun, 01 Nov 2026 07:12:31 -0800 (PST)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bba011sm8346081e0c.5.2026.11.01.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:12:30 -0800 (PST)
Date: Sun, 01 Nov 2026 10:12:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org
Message-ID: <willemdebruijn.kernel.9c17365c41b3@gmail.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
Subject: Re: [PATCH RFC v4 5/6] virtio-net: add XDP rx timestamp metadata
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Steffen Trumtrar wrote:
> For the skb, the timestamp is read from the header before the XDP
> program runs, so XDP_PASS keeps it even if the program changes the
> packet. XDP therefore works with rx timestamping enabled.
> =

> Add xmo_rx_timestamp so XDP programs can read the timestamp with
> bpf_xdp_metadata_rx_timestamp(). It returns -ENODATA if timestamping
> is not enabled or the device did not timestamp the packet. Install the
> metadata ops also if only VIRTIO_NET_F_RX_TSTAMP is negotiated;
> rx_hash returns -ENODATA then.
> =

> Like virtnet_xdp_rx_hash(), the callback finds the header relative to
> xdp->data, so it has to be called before bpf_xdp_adjust_head().
> =

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> =

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 23af10c613b48..e79b65653fad7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6848,8 +6848,30 @@ static int virtnet_xdp_rx_hash(const struct xdp_=
md *_ctx, u32 *hash,
>  	return 0;
>  }
>  =

> +static int virtnet_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *ti=
mestamp)
> +{
> +	const struct xdp_buff *xdp =3D (void *)_ctx;
> +	const struct virtio_net_common_hdr *hdr;
> +	struct virtnet_info *vi;
> +	u64 tstamp;
> +
> +	vi =3D netdev_priv(xdp->rxq->dev);
> +	if (!READ_ONCE(vi->hwts_rx_en))
> +		return -ENODATA;
> +
> +	hdr =3D (const struct virtio_net_common_hdr *)(xdp->data - vi->hdr_le=
n);

    Reading `hdr->tstamp` in place from `xdp->data - vi->hdr_len` violate=
s the XDP
    metadata area contract (`Documentation/networking/xdp-rx-metadata.rst=
`: drivers
    must copy device-reserved metadata out of `[data_hard_start, data)` b=
efore
    presenting the frame to XDP) and breaks standard XDP metadata consume=
rs:
    - `hdr->tstamp` sits at `[xdp->data - 8, xdp->data)`. Standard XDP pr=
ograms=E2=80=94such
      as `tools/testing/selftests/bpf/progs/xdp_hw_metadata.c`=E2=80=94ca=
ll
      `bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta))` first, in=
itialize
      fields in `meta` (e.g. `meta->hint_valid =3D 0` at `[xdp->data - 4,=
 xdp->data)`),
      and only then call `bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_ti=
mestamp)`.
      Initializing `meta` overwrites `hdr->tstamp` (and `hdr->hash_v1_hdr=
`) before
      this kfunc runs.
    - Calling `bpf_xdp_adjust_head()` before reading metadata also shifts=
 `xdp->data`,
      reading arbitrary bytes at `xdp->data - vi->hdr_len`.

    Wrap `struct xdp_buff` in a driver struct on the stack (`container_of=
`, and in
    `struct xdp_buff_xsk`'s `cb` verified with `XSK_CHECK_PRIV_TYPE()` fo=
r AF_XDP,
    matching `gve`/`igc`/`ice`/`mlx5`) and stash `tstamp` (already extrac=
ted in
    `receive_buf()` and `virtnet_receive_xsk_buf()` before XDP runs) and =
the hash
    fields before `bpf_prog_run_xdp()`.
