Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB84F85B3
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569672; cv=none; b=m2iysno1eGxPJiNMfvZCsP4nOTDUIgurZxDVq74ieaFFcsfUg76IV1+lC+hqGwj7FocUo+9b/7EPlEeJMtZCBCd4e3fZyT7q5MzEcfjWj5ddVHvl2b0x2z8sTZD9LcZj8zecA2ozHoajITQwoSwnGlF3JPprVjBijt/JTfitHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569672; c=relaxed/simple;
	bh=hmhp5aCfAowc1RH1ZLE5xg09F/tgIyMjcgJPa/87Xxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C+hChNgOA/im6N1s/8B90yV/02lxtowwQ9095lo7BnSYKeIjajZmL2hgntkUyr6drlaVooI3Y1c9mm0GvIc8n3VwP7DLGNyz/f0qXBFlh4BUHJqDyUTzIN3d1whT0ANO9cKWyuvoqu1GvEhLt5FRBrneYno3okcqNX9CaCP78XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXilsdNz; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXilsdNz"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917a20e9efeso1259566d6.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791569669; x=1792174469; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BmUaHEAjDqs57lG3N//XR/fYj5yl74K4ovqeCbA5msc=;
        b=RXilsdNzfJ72M8bImGfAbIxRYb5qr3aYOwHWmPo9m6vGwG8yWMfimC92Cz6Zy9Z+Dp
         v6kSmDuftmyOAtvZdtVyL+Odbyg9np5MyEoZ88H/VUJOkuiDmCi5yobSB4FgHO7JmOc7
         aAk9uWOSY3eVB+0L+DqJyU/EXWXgnpbrhGg83fldr2DII0c6ot/uF9FJjic5H3kbDCrI
         3nKp53CEULM7K9qsmeWQc/aRuhGL1y2kwuaJiq0JpMJv0C2purZTqB3Sx6ZO0IY4NUNl
         YG+90gs+T4kCrVKA3KFi798rl2yfjwNb9X3imKAwJRDLj2a22cl9oo05351kL9gbE858
         N1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569669; x=1792174469;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmUaHEAjDqs57lG3N//XR/fYj5yl74K4ovqeCbA5msc=;
        b=hFAQ0bMwpmyxvMoCEuzHCUzbkmC8yZF0fqnKjSD+5U88xxPbGfTbkE0T01TK3PDasq
         ZjOve1eS1eSf/TejPl+PbNqSGifDbpwDb9gylExtKNaMzgphouUO/RAF2U27rgzQBUST
         Fe78w8cbUEHjJpTtDC3X1XH7paYm8zUbPlqSaDxa28j9rKWMSj7h2F62Bm8OqcmGLiSm
         gy1jQD4Y5k830xCWuyCLw+gh9yLM424/X8Ugy4/76lrI6qsovWMBlBZYRk510KzjI3M1
         XKri+kim1Ah7fuNjAp4Q/Jc86Wu3Hnf4uz4aqEqj21Z4IejxykmJhjdEqUJb+csT+5Lm
         6oww==
X-Forwarded-Encrypted: i=1; AKwUvBxyeuUJQzrtdrSAMEKTr5Z8q1O79gx7DIXqkGv++McusGG/VnV2H6hFiGcMKS2dzoZPNlIgHo0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2Nfhbid5VZZJTa4wBEPDdUAzHC5ul/IWz848+XDjpWha94W7w
	HnxFMfFOHKW+hvn3HiaZCkSK8zIe4HjPJtxyavtgazEcRpiROE8RFmIRTGGViU6I
X-Gm-Gg: AYBFou0P1Ic+odL/b9xyOJQ12M8sO7yKoMWzZ219FnmOMxqA4MDRZC0Yq5K9+BRsz6h
	SPbwL+hVQmEEazNgSyPGz6rN4q76dfT2v7HfxudSu0MFvXn4d4G9+vmOMtBdXolbWNfrAXibnXR
	LJu3wsprNVZyDJbvwH752K6+ZCnOh6Aw0JXNXOwd+FJKOJxQnLn4vbX6QecyvA7Rcse5oGPAySn
	rM4DN5tWaJ8bO/YA+YMKhtLPVw7ickdjr8F5Y1ncFcKoEP+Qoa+uIYioe77oFQ3b+Ih7QqyDI0e
	/MGCZATNdGgPGQtPYDptpbzxJWQas+txQXk7L1Z5DxHBk2zLKs2dAQX9X3KH6hVrX4QC5XCqKWI
	2k+QpqepodzTrMfLKL51uqIvrMy6rjhXD9+mHQZJrPULVqGM5Fs6KtTenM/MhmiaiDrGpoIj58H
	o05ilED2I/MLKvwkSdmEHSJG0gYrjXFM1LV0aZ3gGnb99GL5mj1cpCD+75ikmOjoItpO77Th6Tf
	Jg=
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id af79cd13be357-93ebcc1186emr416023685a.0.1791569668976;
        Fri, 09 Oct 2026 11:14:28 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c0cfsm248923385a.19.2026.10.09.11.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 14:14:27 -0400
Message-Id: <DM0IFYXERNG1.2ZNS2EYUGGPOF@gmail.com>
Cc: <kernel-team@meta.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Dimitri Daskalakis" <daskald@meta.com>, "Mohsin Bashir"
 <mohsin.bashr@gmail.com>, "Bobby Eshleman" <bobbyeshleman@meta.com>,
 <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] eth: fbnic: validate the Rx completion buffer index
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>, "Alexander Duyck"
 <alexanderduyck@fb.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>

On Fri Oct 9, 2026 at 1:53 PM EDT, Yehyeong Lee wrote:
> The buffer ID in an address/length Rx completion descriptor is a 16 bit
> field, FBNIC_RCD_AL_BUFF_PAGE_MASK being DESC_GENMASK(15, 0) once the
> fragment bits are removed, so the device can name any index from 0 to
> 65535.  fbnic_pkt_prepare() and fbnic_add_rx_frag() feed that value
> straight into fbnic_page_pool_get_head() and fbnic_page_pool_get_data(),
> which use it to subscript qt->sub0.rx_buf[] and qt->sub1.rx_buf[].
>
> Those arrays only cover the buffers the driver posted.  They are
> allocated with size_mask + 1 entries, and size_mask comes from
> hpq_size / FBNIC_BD_FRAG_COUNT, so at the default FBNIC_HPQ_SIZE_DEFAULT
> of 256 each array holds 256 entries of 16 bytes, that is 4096 bytes.  A
> buffer ID of 65535 reaches 1048560 bytes past the start of the
> allocation.
>
> The fill side already masks every index it computes against
> bdq->size_mask, and so does all of the ring head and tail arithmetic.
> The completion side does not.  A descriptor naming a buffer that was
> never posted makes fbnic_page_pool_get_head() decrement pagecnt_bias
> through a pointer outside the array and hand the out-of-bounds
> netmem_ref back as a struct page; page_pool_get_dma_addr() and
> page_address() then dereference it and the skb is built on whatever it
> points at.
>
> Injecting an out-of-range header completion reports under KASAN:

How exactly are you injecting the completion? Just overwriting the id
field in the Rx completion with an arbitrary value from the driver?

The buffer id is chosen by SW when the BD is submitted to the device,
and the device just echoes it back like a cookie when that buffer is
used.

>
>   BUG: KASAN: slab-out-of-bounds in fbnic_page_pool_get_head
>   Read of size 8 at addr ffff88800c719008
>   The buggy address is located 8 bytes to the right of
>    allocated 4096-byte region [ffff88800c718000, ffff88800c719000)
>
> Check the ID against size_mask before it is used and drop the packet if
> it is out of range.  Masking it instead would keep the access in bounds
> but would silently attribute the completion to an unrelated buffer that
> the driver does own, which is worse than a drop.  Set add_frag_failed so
> the frame takes the existing error path.
>
> Rejecting the header completion leaves pkt->buff uninitialized, and the
> payload completions that follow are handled before the metadata
> descriptor that looks at add_frag_failed, so fbnic_add_rx_frag() has to
> bail out as well or xdp_buff_add_frag() writes through a shared info
> pointer derived from a NULL data_hard_start.  Key that on
> data_hard_start, the way fbnic_put_pkt_buff() already does, so the
> buffer accounting on the normal path is untouched.
>
> Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 27 ++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_txrx.c
> index 10caacffee0f0..d85daab06c99c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -985,14 +985,24 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vec=
tor *nv, u64 rcd,
>  {
>  	unsigned int hdr_pg_idx =3D FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd)=
;
>  	unsigned int hdr_pg_off =3D FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
> -	struct page *page =3D fbnic_page_pool_get_head(qt, hdr_pg_idx);
>  	unsigned int len =3D FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
>  	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
>  	unsigned char *hdr_start;
> +	struct page *page;
> =20
>  	/* data_hard_start should always be NULL when this is called */
>  	WARN_ON_ONCE(pkt->buff.data_hard_start);
> =20
> +	/* A buffer ID the device never got from us cannot name a buffer we
> +	 * own, so drop the packet instead of running off the end of rx_buf[].
> +	 */
> +	if (unlikely(hdr_pg_idx > qt->sub0.size_mask)) {
> +		pkt->add_frag_failed =3D true;
> +		return;
> +	}
> +
> +	page =3D fbnic_page_pool_get_head(qt, hdr_pg_idx);
> +
>  	/* Short-cut the end calculation if we know page is fully consumed */
>  	hdr_pg_end =3D FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
> @@ -1026,10 +1036,23 @@ static void fbnic_add_rx_frag(struct fbnic_napi_v=
ector *nv, u64 rcd,
>  	unsigned int pg_idx =3D FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
>  	unsigned int pg_off =3D FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
>  	unsigned int len =3D FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
> -	netmem_ref netmem =3D fbnic_page_pool_get_data(qt, pg_idx);
>  	unsigned int truesize;
> +	netmem_ref netmem;
>  	bool added;
> =20
> +	/* The header completion was rejected, so buff was never initialized
> +	 * and add_frag_failed is already set.  There is nothing to add to.
> +	 */
> +	if (unlikely(!pkt->buff.data_hard_start))
> +		return;
> +
> +	if (unlikely(pg_idx > qt->sub1.size_mask)) {
> +		pkt->add_frag_failed =3D true;
> +		return;
> +	}
> +
> +	netmem =3D fbnic_page_pool_get_data(qt, pg_idx);
> +
>  	truesize =3D FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
> =20

