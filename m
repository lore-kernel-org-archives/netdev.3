Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105040;
	b=PCIOmWkO0fTe6YBFpSDVywWSeJFjRFEV5x+gmYocuchBHBNvAnV6nFTHwLZZXpXNOK2T
	 Rr53Xmf71aoAteUm2FW/Bp0zM8wt6prhSKh0WrEilUtV+VWHSbOTgwo6TUFKhcHD2R1ma
	 cW4b3uzEsbqQkv77UcUMU/RgXvbaxnDO5bkbepkN4PNGuOScUrmYjb74WZN4zqdgW7JOe
	 bzcLeiCso9jRrf+OdGZd4gqxFD9yEj7huou4+jjXXfHI4xOZywIaDfK8U3XB5GJwHHt0o
	 rE9W1WQm1j3QZvBGBkzxbBdQB3iWTdUnbog7yurt5+zHULvXlILN3p2jN2H+ltL9/8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105040;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eb/61ru4rVEXautmCBJ79YrbItkTpxD25OGZkF+zK7I=;
	b=oaHb0d7aOX3sXaToGdc0o4NeLwHU+5IHkKe6hnqM7kqIQrAVxQg9vrZN4riRmzfgXWZC
	 v0IrgQoejIrpjUHcPkDTaT3XZh9WrxjJR1XgRORyJ/DatUGWPqvLvKhTuwkfyI/4vlRWv
	 Aup4juSztctfbbMtovWPydEM7NHiVC2Gs0P7AvqJ+cTF7IMo+6YmU0m8R31NErq+KS5Ud
	 VgYNSXFTfG4tTQp93G+JJNkQe4IBNVOeKpcGcwy0QdEFCHvfOSh3ooaWW0qiESa6gs3YW
	 EW/gs3C7OXPdVylH7zT6/DUyCxrkU8awOdiccSVi5wafZPEmYZpghg6/l7qa56Ga78g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBxTbubK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4605606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBxTbubK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510BF1F01829
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793105039;
	bh=eb/61ru4rVEXautmCBJ79YrbItkTpxD25OGZkF+zK7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hBxTbubKKniiQVC4RFgkZj4xzE4r6Mz3h3zkomOGN98Ahx6zKh1GE4zeMqJvnkbwJ
	 CE/dtXVBBw+29DOGEpGFpzpqWd4FUtCIS0BKxb4g9a8pjagTIEt+j7Svo1fnPDRrve
	 AS9D7QBjjLGr+JLRFnru34z55WmLqhQhcrXK8OhCywTRJpnMDkThyup2ZcHnGIRuBR
	 J/mKf6AhWFdSCeOwHJkw4bdhsPfujNSzXnxx6OF/ST3RPgL/WllojFcWfMisxUZRVD
	 mTqHNRguPnvX9bGRVbevSuVIql0UQ2tATPRl44pcOb5n24SL1TOvin+LIE17rUAbCg
	 Uur0KEeqi/ycg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43bf9548df4so3669577fac.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:43:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzmAXm5soGQVvHzxN8OxoY6b7eGqDc8ViWZoIqMwIvSUL2t3ldHEBeYPdE2BhMfK6vwJ5xVLgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/HsSsdgQKU4wi+6TlZR3VRn/d/s4h9XbFQunw9UdlFCjb6GT7
	uosRNAPOrjRubGOndN9sKHda9iSn5+/uvRP4LgPcUk+nSdmxg/vOQ+Qtzix8xAU8E5EK99EgP0p
	xlmbHgN6GqkxwksY50Ta6k5A+tethT7Y=
X-Received: by 2002:a05:6871:73a4:b0:499:c29b:93b7 with SMTP id
 586e51a60fabf-4a83f57ba5amr5113061fac.53.1793105038536; Tue, 27 Oct 2026
 05:43:58 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027121442.907414-1-magnus.karlsson@intel.com> <20261027121442.907414-3-magnus.karlsson@intel.com>
In-Reply-To: <20261027121442.907414-3-magnus.karlsson@intel.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 13:43:47 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
X-Gm-Features: AclHuK91OW4DpBGjqcfgsApUmrjxZO4uBmfJAeEY0HoTj3dKfQfjf-9tJNng8XM
Message-ID: <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
Subject: Re: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
To: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org, 
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org, 
	maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 13:15, Magnus Karlsson
<magnus.karlsson@intel.com> a =C3=A9crit :
>
> That USO works for 64-bit systems is just pure luck. Currently, the
> computation of the UDP segmentation header is performed using sizeof()
> a pointer instead of the sizeof() the UDP header that the pointer
> points to. Since the UDP header happens to be 8 bytes long and a
> pointer is 8 bytes long on a 64-bit system, this works on all those
> systems. But no such luck for anyone using a 32-bit system as 8 bytes
> !=3D 4 bytes. So fix this by using sizeof() the UDP header that the
> pointer points to instead.
>
> This was found by an LLM while implementing something else that used USO.
>
> Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")

Missing prefix? This was really:

Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")

Other than this,
Reviewed-by: Eric Dumazet <edumazet@kernel.org>

> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/et=
hernet/intel/iavf/iavf_txrx.c
> index 8982cf75466f..2c290d7788d2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first, u=
8 *hdr_len,
>                 csum_replace_by_diff(&l4.udp->check,
>                                      (__force __wsum)htonl(paylen));
>                 /* compute length of UDP segmentation header */
> -               *hdr_len =3D (u8)sizeof(l4.udp) + l4_offset;
> +               *hdr_len =3D sizeof(*l4.udp) + l4_offset;
>         } else {
>                 csum_replace_by_diff(&l4.tcp->check,
>                                      (__force __wsum)htonl(paylen));
> --
> 2.38.1
>
