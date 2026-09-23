Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655756B863
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192150; cv=pass; b=lK6bkY9vFxO6d2dCeN4aZl+Vyc+Xl9AWugSLjwBZG0goOr3FWpG5bVkWcWUKyaSfMW4cAabGLJJRCGEaXkmWC6cmY+a27G+HSm2FaxNF++BkYOWXw/lRWqTnWk0PDqHuoAyCJFwiWTg3hs8X+17QMt6CF5MH4LztM9jjBY0aBAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192150; c=relaxed/simple;
	bh=EZs2yTHGHgc/H+9erze7KHx0zUn4fo9Pqk4m4t/Xv+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR17il9pktIq48oCJ4Tt2WOMBK6HMIGxkdBlh9lXNhQtNKn47EppT9fIJj0ItUme7GbouL8WrVL1fiyoX7KZ1GKa4XbaFoHmxNLFGQpcysH5rWXzqEJyydYNHpcoIrK3mqkmWN/7OSloBfagUep0G4DI2D2zlJfkJAIla+Mkdx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LemBavEi; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LemBavEi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2db33db4de9so20965ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790192147; cv=none;
        d=google.com; s=arc-20260327;
        b=KBMSBVwGl+ABkr12sLY8gdaCBo5GuyZ3XvAJ+DbD9YoPoYgNm2gijnHrz4Ch3v3X6R
         Ii7DvrXdMe661k2Sk6SZUvdb9gwspDuclrXMiQJ3TVpoezVNVkBSdwuV6+Q/wLjDFMkk
         bxOovf1EtcSpq5p5qOY09EZdyTaUFrtZF6dj+j/AhFZN5CA+MDK+kombhScL1XV7uz4m
         TVxpod3+9JiB6WtOefgJpI9K8S9xrOQdIZ4Xbyj5MCndCQZzT45ZmBC5DWrON8n29p0O
         o/RfxDutCYqhK11gEvKZjSsZRGEo5iCpvRfcNGnF3BcIPfAlpDN5oaYQ7SniUMWCjybX
         PcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ahkj5py/DGmuONP0wzWw1kFoghkrm3l2BE6lSw3LIdY=;
        fh=nSLHrUeCME3WdvnHK++t1VzZYih8pyPPFWMeT6clvlg=;
        b=Sr1m4wTZzCvYtF3s4v/RHlyXP5JwWEDcsNW6+pANv+fhessz9eYZBSIMkQK04PIuXC
         1gRSJgJVTYaJ5LRVZSchqQSGMRifItnPajBzmwIR7jOpheFH4DAHEbq8ldN3SV3/lBqU
         z69w5IF/g+tp0lk7CGPoxL6eUrX1Iog1kkvTKZxBbKCs6W2xtWvNg+1BGFjvdHCMKDnb
         jDL9Ybl6i8cCH7xw8GepBbR6JwOPfwnpCBjiFFnZEnIj7B3iADbNcL522ybOYzVzFyHc
         dYmcsOB2yv4YXy715anXPnzGuqPSAp75qTgfEaVV11Ab4CRYl7DJi9vJj7Gv31+Exzmv
         5fuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790192147; x=1790796947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ahkj5py/DGmuONP0wzWw1kFoghkrm3l2BE6lSw3LIdY=;
        b=LemBavEiHRXDBGP3kiewlDpy/YjQ5HahgYQzLIFZU7nSA+kpbJN1wKwomSsk+3ZlcT
         ykaLZ0WIHV7zdvYTa96sQm1UWo6czW4MU9KaPpR2gQkh+i2EmTm64spmFA2kIwnn342U
         tPoWsp/Cee3ZsG3kFENoRxXuEI/SfVkwxZrAM2pXRLb+D4xvCA7jDIMvqsqdQMoc+dur
         NbL9QsGiYIH62xtglhNPDSOqrHJ6uQGgTztz7duMsel4TK/l11yw0sJzHuNjEZz6dhsw
         rO8Ha8zxgFu2yp1U+9+PizDcKVn7wQwYinSm4ppkooM5mY6SUszsYcXyryS1HnxHeLZ0
         36Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192147; x=1790796947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ahkj5py/DGmuONP0wzWw1kFoghkrm3l2BE6lSw3LIdY=;
        b=wqdSadWfG7aNLEz/VAAN5R57OqkK4wyctTbAuDBS6KuVl0P57QiIXLBjcPfvRlg5oj
         yhqc0r2nXRpwEv/oO6xgOrkkU65QVcT325by4In9M1JI6qsfBLOUPaKPHcHEO37dinPt
         Ukksb/kNjMlRoXjPNi7vte0MxFrMgV14lKzcBxHectVALZWOecr0VmIeFA7sojHum8B/
         1pCtgLetiiFyBnTD2F9b0zhzFBLKv+ETSYsTc7yAtn4Q54g2Q3TXdnx2zyDhG2fWRzv9
         7VKmt4yjtlGwt2un836NtN+Wd6VdG3GfRu228/Mw9+R7HktaH/rZBzGSrD0xM4HCBVzE
         E73g==
X-Forwarded-Encrypted: i=1; AKwUvBzrTWndBfw4mS1igE/FjlL2T0xSw4xw0hx1GClDTW0aotVlZYQl0rylB6B70OK/p4Uxzau2ee0=@vger.kernel.org
X-Gm-Message-State: AFuF++mIKf+RAemuHZ6tFKIp6yXhXQlroL4EZFmLnDilwA10xS/cMJVY
	LZMWUFRKYlINst/KbLaRqQlMrPw8VPuFOgzV+Pv++lU5XJ5URk0TY/IfQYRv0OW2BhSvj7BJK9r
	OfgQ48z0uShRBzmVfNh2OPx0LzjfFaBMTXLdWdndX
X-Gm-Gg: AYBFou0pU7ogOPw8ofUiJWDYYqBcdfAksdlaxrPGxysKfAwQuMTGK82+pZPGJQXkDRH
	wCdqaEHbbiPXgzw3j4Car21tlLs2F3eZU65t5+ZHtFzeZrMRLzTFfUV+BpZDeTE8yDLmOeRQRql
	1AnbxYHJEq3xwa4IQJFTGtiLV/5hLBd85tycaDnDNYkevEpskprfQI9661D6/Cyam7EjNTmVMwM
	9fWpBpnLcljJF9+ysgGRC02yaSZFeEUTiNfAsYYBRfV+abSRRHh8FEXLbdmUUgDhCSVOqEvOvUj
	uDn/GRQvmHfUUNfyz93GKAGEoLI1g5SF6zWfxAQzFTuDSKxWbDHoLYXehaehByVktsLr0If7DTL
	1yZMSjL7RiTblSpNyinOguFnlbiDsS+ikdQ9YrgqyKrgv/CU9Sx/PMRvgwJFnksQZ4l4=
X-Received: by 2002:a17:902:fc4e:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2df7b50ea52mr1595475ad.12.1790192146814; Wed, 23 Sep 2026
 12:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923145942.731365-1-edumazet@google.com>
In-Reply-To: <20260923145942.731365-1-edumazet@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 23 Sep 2026 12:35:35 -0700
X-Gm-Features: AcwNN1W1jljyHf7nCT5HH9LbUeUfjaW1t9rw5pTKkBDrZ0SyyaXGisH0Zlqzouk
Message-ID: <CAEAWyHdbd5rPoatghjRHxC_ahkhRQkQhpnoOQLof=m8yv21jYA@mail.gmail.com>
Subject: Re: [PATCH net] gve: DQO: fix header length used by
 gve_can_send_tso() for UDP GSO
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, edumazet@kernel.org, 
	Ankit Garg <nktgrg@google.com>, Joshua Washington <joshwash@google.com>
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

Thanks for the fix, Eric!

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

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
