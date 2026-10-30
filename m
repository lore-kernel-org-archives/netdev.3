Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793327441;
	b=ujIK+IGp0t8dc2ma4NyjRTpl6QalipNqGkP9fNiBk1lqU43VEcybiZamvC+8jzCDvzh2
	 dfE/W9NvZ1KvtHo7YFyLLgt7C3zYuSdJfbhCO9DC6NC3OCtOFf05P6K81SAVWk6A9ApSL
	 Buxwv89iiFUFK53J4DG6yvBvidCq1/slpdOmtnqlKRXGjBT2rNZedzzuFBbKXhtU4kD8k
	 LtzsD2jbl5/0+sB1ggx2/nYPnFcF/4CMd1sFckXIi5dZvbJTX0/JK3QXycCP/enClYrUw
	 Ic2i7JAzoZjt2L8oDcmpn95Oa5pQOgex1rGNwIAEvm2+rRCI+tpP1VNlFNt+MkcYaOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
	b=stxk7F+Xge9XXdBG2LyCGDKeuFZo/9C/5pr9/MXGQgBjjhASMMRHXaeycg2UyC4Pu8Rg
	 NvIr5mcBRL8DCNfzAFBHMGmMRJ1D6wTpNmCuJLxbut0ByeCLqpLEtgImEgHzBAY9NtU9E
	 Got51xzfeFiFxlUlO6PYIy2rF/wIouMq/7On/Z+WEZXCqHvlvi53yTnE5l9J8lJEEQac1
	 sPw3yYbx3xN1dPObVrLhHmArqh+V2KcpEshls1gr37a1YaFM2xOIypLfyFCoxeVD9MYSa
	 vlrcNbEOPxjOoklLQbUNQRcSI2yzyj82XAvCHM8kGhVwEU+S66NxuHnjZ/LpXufYAzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8gfzGoR;
	arc=fail smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3A606A321
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 02:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8gfzGoR
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so330518e87.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793327439; cv=none;
        d=google.com; s=arc-20260327;
        b=ANPR9v9rj/lGHh6RrBJu0KKpIjExWEHV5MgT1X1yTIc6AXQFGvzNajMOeYQ+7iAWBE
         eHMCLQSnZAT3Vd8ovmB7fKLrOVCan2igpz/FO8VHBzBTZtaera8gWMBqssATUTUBITAR
         U6Ns6YmenLn/jd6zdcritVd11Taa4zSOPUkX85WI4g36+FrIiR1OvH7X4nRivOOo2efE
         +FOQCEHcAevNsJCafhpzB2VDbeIWF2QUpvpxmEX6mm32228wxtnMQhCDFLI9qa0R5HPb
         UI7ANYwlcHn9BjYkctu9ku5YmRmRrZOLq6P6NQFaZY3xaIhID6Yv65Yw/W2ZLcuTqEBL
         F6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        fh=/hltoDyyeBhz8uH4+cuLPgBCUgXdaLj4R1UMybCgUn4=;
        b=T0tqeDt7C3nc9EBypFc3fe6usLAwgHw+wItYHawlA/jcUC4dhJPmTLqEriUGhuS16y
         9auP1gvSLdbF9eT9nU6Z+wjcwgHFMCFjX7lH+xHW3iy/oCYzdD5eOe2X6w1lry+JfUQu
         +uyD+YP4nJvOyvnZb5jvb+XGtMAZ2m4xI6ICk62pe9So5eabC9IDbODMbOD0LkjCPkmv
         yloaBPz3roBtNC5HTgZd42s1yDXVt0nN67y28Us4TPzirABWscFmroJWwPlFlojTcwZN
         K1U9pVDiFiCvMJWvDLNOfN+QOgv5JQoFY24GXsUa6/l1R2fQvcbDWkjcmK+Xbs3GFi3w
         /LWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327439; x=1793932239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        b=e8gfzGoRM385FEsKyD02HVJxEcPcs7T3QOF/fJWMMm30PlbFERmKncV3Hstqsx2052
         lf0xfBvCVoO5IbSgaLtFUi3IOlIFZz1uzqLANxW84fUcWsKuv/UhGHOgEFLFNpxKSITg
         iZr0fs5CcKrN13lt42exXW7GYdCcJsaFZq1uGXQ+jrn6ASA4gprfcgsdP4KKcpG1aYfU
         C+NMi78+7JV7NTPtMAWIFI7q/n2x8uJES+rD5YbbVVnNBM1jrYwFbIqfjStrL9BYr9jO
         zsfza/TSP1s8HBRuKorim1idzGf7awlWuP58iN3WCOzZWQE5eRHJv9Wta5sLZjEEvL0F
         LSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327439; x=1793932239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        b=QAuBs2sM6DNpYtvRLlp7b5wu9QSn/pCUxWB3PfTwcRBRqrZz2SywmMuQdRkA/Ptoe5
         jinl5P0FSrnTOYQijI0NieCXKCLiMKgRidi38k2qos3xaUshm4tBoUI8pLHpbKDk5mgq
         crFVFnNOor3s1L12THwJSmXytcEplLLz6Eqz0bxBjdLesghIiSSnVi+tMsS2mxh+ByOQ
         ywVPas/HHuhORbmawuNInCR2xjdCayZjjCnSZ1YQKcfwoS2gXQF7p0G2PYuik0BBwVcc
         8yx67cn6AKdljs6V6S5xLV43Nw0RSTUvrHOrbHb2QP8fj3sBlrsD2m698qRn+LckQkVH
         AuWw==
X-Gm-Message-State: AFq9FYJFW92KIIBRxUFHeylaOzLxSJVhOPNmgRtUWdTDW4VD7S+5QLdb
	CPd3JS/0LFX8L+pv+/pv82rs5xeh0YI5Dtz3UeYMUQKD7MZ/vc4PMWBRIsQf68x9LcLunle3ErY
	0Lj6NFajzHsdl/1+Se+wkmL8F8z9efxE=
X-Gm-Gg: AYBFou03GCLrD5YguO32e39/sYlY06ZNCOaRsHQbs9uXGTvrSHBDegkznH78WOg92A9
	smjKjeTR3Ey9j8ya4ay5px4Vo5pa3Y6va+ohY8qbnOas89kdS9KxldhJ44qhZrfcgGL5LEvyGxZ
	XujGPBwt7dt6Z25C8lkkhIvUG1uPb9QpRXaskW3dhQm000ooeAsTOjmcdJctRjG6cfJL3VkHjqj
	x9betRr8cjgTEaTg9r74LoPoa/DLQYTpnQ0mIqWOfY0C3OxqQqsijyXDhwxcd1mGdE2TAWMwEx7
	YVX/0bkRUgXeLZtGjLqdV6EkrO32lvaBnyUkdI0opRajfAwbO4pCn+tNuqmcYURY3TR77hknyfa
	v7NMuwnG/fAl64E3XpH5Q8TtfBmKmsbWC/0Fzh9ThX6aYPS1Cf56gP+ntKH9if2RJxZeqXl6kWp
	F4ISRmqv1ZtqTOyB1yB1vNjWoif2KZSN3WRqH4EDWwSBTXzbLxSi8wieMLV/nETYoZCi7kc4HLk
	uMPmX3aXE9O
X-Received: by 2002:a05:6512:2251:b0:5bf:cfc3:5954 with SMTP id
 2adb3069b0e04-5bfd954b9f2mr211780e87.1.1793327438692; Thu, 29 Oct 2026
 19:30:38 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-2-testwrzwrz@gmail.com>
In-Reply-To: <20261028025026.11401-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 10:30:00 +0800
X-Gm-Features: AclHuK9V4fvZWJ4AFY9w_N67m8fmBuNScc36Y8vzCOEgxwll8I8B9GuAiObXkno
Message-ID: <CAL+tcoA0jyxR875KocG6fwNSOPjfC-pdhJt0xCbsDQMtiNx8qQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:50=E2=80=AFAM Rongzheng Wang <testwrzwrz@gmail.c=
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

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

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

nit: since we have 'continue' here.

> +               } else {

How about removing the 'else' branch to avoid unnecessary indentation?

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
