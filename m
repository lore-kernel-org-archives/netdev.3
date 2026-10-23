Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792764892;
	b=dpMhsjZxS9IH53/6Pp6GUBAyKf4jKr/h6LbRa3QBRaydGTb1qnRT2khhcW/OmddNtJH2
	 Dr+nRazIflUivi9eY5nB6VJPhC/a3Aya3jUaVh+6JMNmHnGgH+pV0hA3LNdA9MDOVLJae
	 iu6sQUSE33nz05+D5MInVxyKGwan012rjuLTGwL6W+SzGtVAxQcYTJvnRkE0tQJ5Lc+NG
	 bLGvatDAm5DwNlvo0phXvVbKwsOnbQJuvt4+pQsss13V2E0Qd0h6w2BuDWmNAogZTJ938
	 LXyDXvOweoIzJPwqchIQ36Z4063uyyPlzrtNZwxhMn7+IODCwWt8geMOKtipY2FCGKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UX9XiJ/sX7H9VN90F3Ajif8yPiFt/xrbd1p2Jnn+V8U=;
	b=0MUhbAxenu0W229qzgg9MVDtucRQuahokzBiaUVmbESQ8wrnPhHnFQQODEj+CJL3ZipX
	 CSGTEhk5OlL6xjL4yGIM9pnef7a75R5d6/oWo3a8SUnrs+627Gx2Z+JzaJBjglT6kP2P6
	 JoTDFqGEc4SV1FXu4pUpISersd6k7H4zNCL1YLghSVuIdl5gvdTe7Y8vVcBhxahm5XnJo
	 ydj9YR3ygPJKhijZoLdxh8sIb0JLqedR9dqYJfCIOt2byGV31q7Q8JBCP83ygCouRSQuG
	 2eV10aCxlXvfve+6yIA+HcfQjzKa350YUh2LG8V5K1yA3S0cUzyCtBQdQbHvW1yCC0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Rwux7iZF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028C606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F028C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Rwux7iZF
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-18ae3f47c26so1541c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792764891; cv=none;
        d=google.com; s=arc-20260327;
        b=W/jWyqZ5EVifSn2Lx5mBL6+BouuSlidH0SUmbTrBocmIWemWAr+nK6X+0C7jYKg1CV
         nBmcOWdAblbvaWLhwZ3GPQ43wnY1hrYYbyOCv415Xd/b/f1C0z+r/UzYAoZUeezUhEoP
         w7M/XAJy+/dONc0SAuLoj9O4SSCr2uWQSRQo4QkNZJa8rbdraMUOYhrvl62+v5SUQ0Za
         qpd19vxC/wItNEix/AWFgH54pKX5PhgClUZLWQCpCrSK7sYcXZj5RT0OtjED/VTCt/TD
         d+53+xdTnDfjeUdtrJLBO7hXwpxQK8OrqG6ARKSUN8fGfMRPeFRUxBCljdBmv92DqrdM
         8PRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UX9XiJ/sX7H9VN90F3Ajif8yPiFt/xrbd1p2Jnn+V8U=;
        fh=68oog05yaIp78KqWIKixh5M47wYCUKs6g2HVPbk9tFM=;
        b=Sw8GOC9MD4P2Mdc2++OLE/frxZvY0+ce/N3pGADTeEJ73K4QQoafrOHq38qDRdGFtT
         xhbppAYyOFgXntFIb+U3C65CHPDlOVo2SMtcFGTFHFeMS4OKU2IepEsybFfNdHp64ErF
         gFmypsACIx/iA+1kE5iN2swAA0JFr5SXP8qqJ/izjt8ALqn3sWnUzlroiRVV+S8sjhyv
         w9c27LkXA2osNyOVPDCGXgveLBU2/h2vYduV+6YcOeVFrVOU4upEituTDGoX38Phh7Au
         jJ+JHqQyKi0/lixAyqlrJuEPnT+BOfAxvdHoqD7wv0z5HwTDNxv7T9S1yhvDhAgZLRXM
         2V6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792764891; x=1793369691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UX9XiJ/sX7H9VN90F3Ajif8yPiFt/xrbd1p2Jnn+V8U=;
        b=Rwux7iZFn6X0CnE9a35HXuNBUOwmCdYCTfdalhDNbuEgIHha4Qu6+uLh6qpqggwXyF
         dcY4p8VmtLOSgOrYRPIG3UAPXzueXvXMMTtDPUlEutUhvuUe0tWDEMvCOPiVhLcKIygh
         tAIkT/RwAGVVIk9ij4ZirJaGhso9Ef/PdqktJg9e24+LKxOVFjYuNWWwnuOth4DJsQDy
         Mmr4V+XcaZkLsfx0O5pBGpHl/7tCCjJ2xhD9iFtCPdQC26xg0LMyeVE/31V96KDCGISX
         0/9JyuVuIL9ij++TQiLzOPBP+yggehQP57UZDpsHwffiwT07HJN5aE9KSdUxvC8ZErQN
         Ff+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764891; x=1793369691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX9XiJ/sX7H9VN90F3Ajif8yPiFt/xrbd1p2Jnn+V8U=;
        b=p4CfB/eRhGjeuya0bv6q6dY+k8mqtnmppaNiePpA8DPvZqs0JlOnvQKfCJ32iANETH
         Xg4YRFpDy2Wb0dWEGf+2/A0CrcQg5PR/2EX8kSUuK5flgjFpicMuwK+w3eL7rRr1hDff
         r1RgS7+id88iLXnFX0QO5TmqaG2TYtbjxuTOBOW/++P0D47j66KGtprMshBVbmSHrWRc
         /TMr2CrHUaF8McMD/dBN5UkCHABltapPRcvkgxnmrAgfgRNHDr1pH2PnhkPbnBToSda9
         YF6uoFtJTC3obNODbfRLKGl06PQDZERVRB6ckmwLO0/1WXSR1j8kNM08ajo4QvhKqnQj
         2j/g==
X-Forwarded-Encrypted: i=1; AKwUvBxUUlnuWP3jqglXDM0yM1U78o7u/Bfrrz4huFaNl01bUe//MbKT1ymGBjX89p06fkOaVvpPIR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFNmnAANv8rfTgvTlEppIRPaKmtxtTXgBbUoQHOJSI2sHNGlp5
	R3Vn1gPb6BQBeGiHdX6MEhRQZna5ab5MetffdHc72Cm5Zmzo/5iGbsuA95EeafttEujPjmYSQ4j
	CiGnOGv8SuNq4VSOFdlsnyNlsg5uRK/44hyNli3jI
X-Gm-Gg: AYBFou0dNrPltDACyLgXs091eEsPseNa33lsozpZkjxdEZh6ESWL919AW4VJj10nMLq
	0ZqhS09zKlyqScmh1v3hjVERUElhasR2Crv2cvii7gIJqEuv4f8iiXQGKPP9uyckY+Gdl0P9dxV
	i9Oj2bnIqyVAtbxT9U8hTvlI5g5/bVIozmHxsE7kXK391xhRlRYiWSJVpVj+gZ2VdXlET4w1OUS
	H5S5C+3m/Dr0RLU3X8kUYQXd1b3eRz99eIkIZlEvkMOGzEvaAWvegHyuD4DmyC2DaQqyy/6U7kB
	Z/t513iMkevHWHUavelGpO9rdZlppuEffW2GTJ8+7NIIn6MgYEmGGoYRgmMg/4cZzhODkOyqKmh
	yK+Y6d+Q+r3Pfm6MylttcTENjD/ZWkjSnnCPi2EZW1HYo3GCPx90UczvtxJadXcToocY=
X-Received: by 2002:a05:701b:458d:b0:142:ef2c:c480 with SMTP id
 a92af1059eb24-195f01c4da6mr194592c88.17.1792764889782; Fri, 23 Oct 2026
 07:14:49 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
 <20261019-b4-skbuff-bug-on-followups-v1-4-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-4-41dbef50b9f7@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 Oct 2026 07:14:34 -0700
X-Gm-Features: AclHuK_2m3TNgrazOeFVO5X_G9cX4zSCYeyDyz_no9CuBf7VcXjYydnmobrYYP8
Message-ID: <CAHS8izPr7b3e6reYUwTKiLiSQLOUkVbxGRayEYQREWb=tC+c9A@mail.gmail.com>
Subject: Re: [PATCH net-next 04/15] net: skbuff: fail segmentation when a
 segment can't be checksummed
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 6:51=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> When the device can't checksum the protocol, skb_segment() computes
> each segment's checksum in software with skb_checksum().  With SG on,
> the segments share the original frags, and a devmem TCP skb keeps its
> whole payload in unreadable frags.  The devmem MSG_ZEROCOPY path never
> sets SKBFL_SHARED_FRAG, so the __skb_linearize() fallback is skipped
> too.  skb_checksum() then warns and returns 0, and tcp_gso_segment()
> writes a TCP checksum that doesn't cover the payload that goes out.
>
> That's reachable with tx-checksumming off and SG on: sk_setup_caps()
> still gives TCP SG and HW_CSUM, so the dmabuf send is accepted, and
> harmonize_features() strips the checksum features but keeps SG.
>
> Use skb_checksum_full() and fail the segmentation with -EFAULT when it
> can't checksum a segment, as skb_segment() already does when it can't
> copy one.
>
> Found by the Sashiko AI review of an earlier fix for the same path with
> SG off.
>
> Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable=
-v1-1-7e2334a55fe8@toxicpanda.com/
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  net/core/skbuff.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 40d2dd20d47d..88ed2dd99dc0 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5239,9 +5239,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_s=
kb,
>
>                         if (!nskb->remcsum_offload)
>                                 nskb->ip_summed =3D CHECKSUM_NONE;
> -                       SKB_GSO_CB(nskb)->csum =3D
> -                               skb_checksum(nskb, doffset,
> -                                            nskb->len - doffset, 0);
> +                       SKB_GSO_CB(nskb)->csum =3D 0;

So I wonder if this needs to be a generic thing to do insidk of
skb_checksum_full. It seems like the previous patch is complaining
some fields in the skb are no-longer set correctly if we fail
checksumming, like ip_summ. Maybe ->csum as well should not be left
set to non-zero if skb_checksum_full fails.

Anyway,

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina
