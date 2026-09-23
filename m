Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C854CF6B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183231; cv=pass; b=KG6x4lXnOtePMkKaxVydLfIUycSfkTVjsloofWlOGo7F2RxIilEOQFq5kl+PmGCZeWuxDI14p0vuwD91SvjvuP3lRbbYMDDuR8Yot1NqAPv1b3a/Y2JB7G4P5WYCN8XOiwmUxhkXce/X2SivGFWtb0SUwJg/Oh+K5KZ5llo1NmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183231; c=relaxed/simple;
	bh=rPk1WmRgW+vkdY4l8q8pizZwggvLwOADMhn4hpuMAEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mw1rzPv5pU5p52X6bd16yivkVusZ0W9dBh6X2rGn1rLFcAsyqa+wf/+c3l1iFYJpWVXTOaTrmFYp4XVsZCPT4juOEF9i/Yt+VKGAZBT7QrM57zhWtK96Ywtw8H+7aoaPMvFMrklxtzbM9llz3FPNQZyLGvF0slPf4NxFd6NZtKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7dDRPNF; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7dDRPNF"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so2026796a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790183223; cv=none;
        d=google.com; s=arc-20260327;
        b=UEBwIZnvjfn1L+HHxnq6dX0tg2/n8hLTmyp0kBL0OllvwMHUZRWEoujABERhw6Mep8
         dLrHge20h1HbwJgeLegXMTleiYpYeOZGgu57uGJ1q2/b4yZjNoc50E9KyFXMl1A59gV+
         BK/vaXEgH1NPnZzF84QutTcEOftEwqeEwvLqGNHO2Pmpda29w0BtKpXEo95sIOjGIDHg
         HEVMqoSypb+cWKMFO/lQh1+ZnEsUU1MXrHLm+e4ed+XgV9x45rLYLtV/HSMU7nTui6f/
         FqCczkIIiSAsh8trMdOZkNASRDMZE645j49+AZOjcTCtadnnt/xxiUhUGZcycahmmDu1
         PZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jfrb4lXbFWGI+7sNgHqFiK4m46fI+P0AggnHGzJBuUs=;
        fh=Na08YwEcmT1MSEpDd/vJzSg5l5oSNeest7v13Ibw2Ok=;
        b=lde4hUFC/U9LfehU8HvXg5YNEBnqtsomfIHyadUjL2BI0RAdKPWbGbRzGJ4HW4bNhU
         8UQNyRPZjs+psiPYkA0oNjyI3INZhzqs9N4UJqFBYMQIL4My8CV2kqm2beAUy2RPHUaR
         oPA3DB5uPYH3r4HrNKx+W2JQtxByhRUi9+nYBW4bbSi5FTxSaDfTLfmH86/VdGLnFmAs
         pMEeNHFgq60Yy1rlmmkKRzII29PNYDQVz3tYlYEDNvS+x39OuTxHzBzM/Bnb7S+y4SyW
         l8qB207K3RaD1jZTJYRAB/NEl1alMH+kjYBIhPzV/i9cNBVRIMWXByA5/yDZwxronjqi
         gt7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790183223; x=1790788023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jfrb4lXbFWGI+7sNgHqFiK4m46fI+P0AggnHGzJBuUs=;
        b=t7dDRPNFmVygiJSHSxA67GL2NSrH5BwfKtO8F8MeQAH47u0PXlXmA+TBBl0MigCirO
         f8yKqHzromrQsBkh0OJtYH55yR6AWtacMweRJH6FkNmHj6on/4XxI5X9IC/3Hu10dExH
         FVXl0J1Q96NnpwpoDZ37m3HVSFlLGIac6lRlfESheICqCvknH8BhpwCREKlbsbEMhjd8
         lvoKlGbT0j+h4y3dhnS8gfb49X+rfRMVL5nFV+ogrM4NksX1Wu/P2fnPaZYo31H6VstF
         ieJcLeENlzweOZeVH8wPh2B0g0OG01FFaB1O7M3TlBycxZdEAidZ3EtPH+nvTrDg/d6n
         pouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183223; x=1790788023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfrb4lXbFWGI+7sNgHqFiK4m46fI+P0AggnHGzJBuUs=;
        b=ATGka2o1nyyPoFZZG6AJNOmke9S+icluW+OkO4bvUtBdL2qifWGROKaAhMgOENo0qE
         uIm/LIdGCfixCJALEubgl3kXE+9Ka6TY8GXuq8vW8IQOGBV+mHFaZXGyIJh0igK0WFrK
         dpPzG1VJlGdDt9G+mR8cQf451GWprIKAd/1bwzVSC+GkwGrOoSoYv8Etw9XBAaCYKpfB
         W1B9Hsc6awzXLVyEaA6TpJYNQfxbfcABSN6Yfn1JoCtF0j0hx5k9mtBnHVvEGzwni9f7
         8257v1pkcz2iDOMiecpvn021wrpJaJzXwkZ1GuVQ7fRkDscQ3YE8bHAO6mzCPYazSk81
         MsOA==
X-Forwarded-Encrypted: i=1; AKwUvBwF/fXFQ0Vzjyswx6UGh6vhujKAdRGynjnFKQED3kh3Z0fdvHHKUiZTRpBa44t+TXkyIj2NEWI=@vger.kernel.org
X-Gm-Message-State: AFuF++nyd2uceYISzf7isdNvbZX0wpK5/UCCQS1Eq32QdNI0f1cdARPj
	4PVvAdMY/xf6kUD0vnSsmMqpsgauJUCrQXOVPUWUdjMmKAB8d/7+r2dxSCyo4zwzuewwMLjhb1t
	8j0Tg/HPCgH3nbT99XxDA+/cTONkDGBobTRSSSk70
X-Gm-Gg: AYBFou23ed4AxcUhuF31PE1OLDPaTAijqmv7YxB1mzknnn57VyRbQqECc2QtZ8LWMn4
	cG4xVvwbH6fyIRNHw5xGc5I8bSM6DVGDiO+hjt94R8fgtKgLdsK9V5xOw3uOTOYY0To3MAasmzu
	SmqHxj2bGgEVOax9T9Yp7yqtrZSEXRl5IKMnvShNDrLgLkNXQ2sEDPg8wXe+cF/v65XlkNX97DD
	SoYTA755n0qHWKUTJeU7KBm/a+56MfZPZ+C8R+m3fNDR3ab+vT+9QHNNVh6U7sOKR12R5LikZ2c
	Eovfa0BlKheoA9hb8HnqwM2KsSrXqTzzTESj0XN9WG2oZ25CofeuRd3nWoAMnUT/IFLueYJ6YiJ
	cyb8LWxgIDA==
X-Received: by 2002:a17:907:c8c8:b0:c29:f5d8:9c82 with SMTP id
 a640c23a62f3a-c2aadd0bfc0mr294806966b.49.1790183222265; Wed, 23 Sep 2026
 10:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923145942.731365-1-edumazet@google.com>
In-Reply-To: <20260923145942.731365-1-edumazet@google.com>
From: Ankit Garg <nktgrg@google.com>
Date: Wed, 23 Sep 2026 10:06:50 -0700
X-Gm-Features: AclHuK9MIUS5VVNKWTcEatplkxCPyf50XuWCGDM7HbwvtDJx23EJH7NKtwMDnH4
Message-ID: <CAJcM6BGfShOBWkAUVN31DLgNQJ1HuhvwQ8jK+zQssyp9GzpAig@mail.gmail.com>
Subject: Re: [PATCH net] gve: DQO: fix header length used by
 gve_can_send_tso() for UDP GSO
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, edumazet@kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> gve_can_send_tso() computes how many buffers each segment of a GSO
> packet would span, and for this it needs the length of the headers
> that the device replicates in front of every segment.
>
> It unconditionally uses skb_tcp_all_headers(), which reads the doff
> field of the TCP header. SKB_GSO_UDP_L4 packets have no TCP header:
> tcp_hdrlen() then reads one byte of the UDP payload, and header_len
> can be anything in [0, 60] instead of the transport offset plus the
> eight bytes of the UDP header that gve_prep_tso() programs into the
> TSO context descriptor.
>
> A wrong header length shifts all the segment boundaries computed in
> the loop, so the number of buffers per segment can be over or under
> estimated. In the first case, GSO is needlessly disabled for this
> packet by gve_features_check_dqo() and the stack has to segment it.
> In the second case, the driver hands the device a packet whose
> segments span more than GVE_TX_MAX_DATA_DESCS buffers.
>
> Use the UDP header length for SKB_GSO_UDP_L4 packets, matching what
> gve_prep_tso() does.
>
> Fixes: 014c607f86ab ("gve: add support for UDP GSO for DQO format")
> Closes: https://lore.kernel.org/netdev/CANn89i+MS4L60sFQ49=3D-f-mibeveUfc=
rpVkD5X+Qy6SOnEpd6w@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ankit Garg <nktgrg@google.com>
> Cc: Ankit Garg <nktgrg@google.com>
> Cc: Harshitha Ramamurthy <hramamurthy@google.com>
> Cc: Joshua Washington <joshwash@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_tx_dqo.c
> index 80ab0a449ff54e3d19e9c69226949465d48dfe3f..0f6f7c5dbb2e027bb0a45eeaf=
76cfabff558ec79 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -918,13 +918,19 @@ static bool gve_can_send_tso(const struct sk_buff *=
skb)
>  {
>         const int max_bufs_per_seg =3D GVE_TX_MAX_DATA_DESCS - 1;
>         const struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> -       const int header_len =3D skb_tcp_all_headers(skb);
>         const int gso_size =3D shinfo->gso_size;
>         int cur_seg_num_bufs;
>         int prev_frag_size;
>         int cur_seg_size;
> +       int header_len;
>         int i;
>
> +       /* Must match the header length programmed by gve_prep_tso(). */
> +       if (skb_is_gso_tcp(skb))
> +               header_len =3D skb_tcp_all_headers(skb);
> +       else
> +               header_len =3D skb_transport_offset(skb) + sizeof(struct =
udphdr);
> +
>         cur_seg_size =3D skb_headlen(skb) - header_len;
>         prev_frag_size =3D skb_headlen(skb);
>         cur_seg_num_bufs =3D cur_seg_size > 0;
> --
> 2.55.0.1082.g2b9226bbc0-goog
>
