Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3614280331
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303411; cv=pass; b=vDjIUhEFdPiWeUR+nVB/9ZVwuLfWCs30LVPOUWUJqkw23yYFqhlL2AvjCc69UtKC0KE+0aSNFQvVTmCylfegQcs7qkvwqIIyYxa/8zDKfWbIk0YN3c6sgi/Y0fZ749Ti1ilh6vcoNEUzUMRQGCxsHvn5iK07Xsg/RblFYIgj3Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303411; c=relaxed/simple;
	bh=updZ/VKJHNTIJMz0srEYGly3nAHiJAKoH7YSQ0mbBOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYJRGqnwIvu0U2pVo/t3WBeTUUQAfar0kwaf0h8ggAwC/RbtthQvEGyl2lfxkK5VSw9qiZA7F1G3NctFB/nhZZSCH3vWAqBDSqjtFblCH/KYFXkQfx3Ym4ues8/pFfCQFQgD1/jjeo8Ds6JzdNM4CuIjG1GKR47uve1hzBZYakk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcbyZ+2T; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcbyZ+2T"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5309a20a55bso4993371cf.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 19:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790303408; cv=none;
        d=google.com; s=arc-20260327;
        b=oqqJ/paL/mqdQ1+SwS2l00BIgWsyXmM4Mu8wigbRj7TmQRkW1vIMH3wfgeAD/LRlg0
         Vm9Xdk5rLp5y1I7OxlvSooT3jhGlYMxK9Ks6rVYEMS7Velngf6qboB0sXVX6maBrS7Xr
         oZ62w7vwzqFzq3LM3R5ueQB5B54PX5I4LNa5+w+jK3HuVQwuWsVDewQWpzZzeAkapU5G
         FSoTJ/pZGZDKjq3eQiGtuaGITEpQ/AfzAwVcZEQU3sOvBw59yXtQh8tsNSlleNRgy6cn
         B/XUzR0AuZWhgSoyZWWOfRQxyKxZNNCmL/+dQhYZPyntbm+o8wPi+tzScAuqWYqGRLIy
         qdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vi77hTKJUqRfDM1VWT9RtlhvPRnMvn2iX6KOOByfKNs=;
        fh=ulEvbJWf04WsSKUIW0ZkA6GpingBwK7d/SsRn0+es6o=;
        b=hg0dY5W1z/VRoF5839r33uBwCxJEq8yABYQgYIpYhE+GKPc6hzN1XkWXBAQLQ9lOK6
         sp+ENE5OAR1mFaMqptDHh5xcO9Z8sVtGEXsmwAnXfZxK06dCZINARcW/MjiLNpHR4NBd
         gNISCtnQ+aPaofxPUL3YfPURCooicVW1dDlEThv9NLNdPN1zZAcZXgcDDsaS0geu8Fxl
         cqdF4VFCOAzLWqrF7W661aki70ad3TcCAYgM+g1/P9RCpRryhrpP0AxZLmyZf2xHRzLw
         B2BSsPMChWGEZp8EZrXoTF673IX1iGJZlmQQgC6yBhzg71Z10Vzv3xsEf/+s4HILLWQb
         jG7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790303408; x=1790908208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vi77hTKJUqRfDM1VWT9RtlhvPRnMvn2iX6KOOByfKNs=;
        b=fcbyZ+2TW1WaEpnFhQDTtuvM+ytRHr4HQhr8/ddmaq4/Sbl06G5xXlMI992NFYIUtT
         Mo27nTiKC8aT08j5f+MEzJ6IJIBDjO88A7bdAkUpu1XnBuv2AU4JqMDcyYVSlYKs3SuO
         olxeuMR2//X06quyO3FAWCZWQaTKCtlZFQp3x2cKnatt0ykF2L4+3ZLjy+hFZYFrxl1O
         I7cYAN/AjLe7dmv7ETAORukHWu75bYuzEcIUTeyCIb0r7aDhrBZtrHzCS0NnruJBcHPe
         HDxvfVuM+O1ShFrK5evu3tYEy/pNg9ZZPbCt4YW/qp/6AIbXsxykNz1g9cwB4Qrv5Xw2
         f9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790303408; x=1790908208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vi77hTKJUqRfDM1VWT9RtlhvPRnMvn2iX6KOOByfKNs=;
        b=sPrwLxO0t54/4qCp9r01AqbQPzvSHjv71Vvk7BXHaj8ukFLXjLYmS9OyuUflB3H+SD
         Cgws7zntkNMtw0uZttsUzxnnQt5Dm6PIc6ZoiyBmBf3GwoEe7FcKNWXw/NorltVgtJ0X
         7TYICW/E4PLe4WxfnR1SkEQlRAO3KUEYYtuuUeTXbZacC3wHwdvwvWNOrwdE+y0/HKno
         m1BiPgq3owh5PrpcD5BnlLYPWV9oAHtyonhHV9kikwcrN+GWm0PtXjwBr/NTXVXp+YFP
         Is7czGEh5SkrMsIE77Y/4Npv23VYvJ9qBvwOfNOQPmy/S0oWCDUWfzt9vjJy7CliVpzp
         5+oQ==
X-Forwarded-Encrypted: i=1; AKwUvBzru/r/ycuHYFuDt2jPaQl353TYEZpZoLSiusOJWtF3Qo07dvEISGxe2+ritJ81c+AelirdZxs=@vger.kernel.org
X-Gm-Message-State: AFuF++n1+rpL2mXGNzLZDh55m8dX7fJX6W63Snhr1wGBqjzjEVJvfaJ4
	jmgHHwMLxhJ6HeYmlbAxazOnU39aoVGokmd1VEUHQjYZlP8MaOZPAUvVaHc5CA5qpG7JPS6u/CC
	iv09LKXM8YKxv9tVdw6va7b6oqdAm4v2WapapkyR+
X-Gm-Gg: AYBFou3/6RJjI/ftRhR6qOsC+Zq4pTqvnpdQni3n2f2LP6f9ycppjFsBAnOCcPKODT+
	iO8DmiD2wR8IH083G/M7+1rSFZhOMLefxAlvrqZ9ZXKn6+eK94dtQLieT6jVXYpQGj6QRjfQ65N
	dmam0jGUfi1NkZ33FoywZRAxngW5/K8cybBnF/Td2jaduk8QK263OgIzASejO49+UQha4OpCdWp
	30guY2T2F6EB8Mca4RfKfs5t4lY6cEwxWRE1FAk8mxpcgoS597xa6mzI2i17JkyZd8bIHtWJ8uS
	J1A2VBV/mQod6X7t3+3ls5mbjJ8uq+ovSKW2XS0DSkV0T4TdLfGb5T/YM0xfe76/9rBhG0bdIAt
	5qFvGhicZOFMI1cZVAV2lcl/aL51gL2LV5WSAlbB2H9bVVKS5hCZjwVJOLTeOdsk7Qb0d
X-Received: by 2002:ac8:6103:0:b0:531:e8a:7aff with SMTP id
 d75a77b69052e-5330b5ee2f7mr21768621cf.16.1790303407639; Thu, 24 Sep 2026
 19:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923141047.14047-1-hannu@varjosoft.com> <179030240275.2160803.7121151150196393029@kernel.org>
 <CANn89iK7kacaAnx3nTCL8=OrCQF5kyojeoXkWU1Kq92n5gMyUA@mail.gmail.com>
In-Reply-To: <CANn89iK7kacaAnx3nTCL8=OrCQF5kyojeoXkWU1Kq92n5gMyUA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 04:29:56 +0200
X-Gm-Features: AclHuK8tifC4_gqDeoPITsI5tt_LT0BoYK6kfemz6qWaM3-BQoSOrbYPGKUgJNw
Message-ID: <CANn89iLpkPN=qHkyse=Bdz9WvOgtgm1erL1fn=sYPRE7GSibjg@mail.gmail.com>
Subject: Re: [PATCH net] gve: DQO: accept TSO packets with non-protocol
 gso_type bits
To: netdev-bot+sashiko@kernel.org
Cc: hannu@varjosoft.com, joshwash@google.com, hramamurthy@google.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, nktgrg@google.com, willemb@google.com, 
	pkaligineedi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 4:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:

> Indeed.
>
> Please Hannu send a V2 of your patch squashing the following reload of sh=
info:
>
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> index 616c1921aebeacb4eb711ed3cf87821559eb421f..f7511aa835082e4f9b2514a21=
2c497d5319844af
> 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -595,6 +595,7 @@ static int gve_prep_tso(struct sk_buff *skb)
>         err =3D skb_cow_head(skb, 0);
>         if (err < 0)
>                 return err;
> +       shinfo =3D shinfo =3D skb_shinfo(skb);

Typo,  this should have been:

          shinfo =3D skb_shinfo(skb);

>
>         l4_start =3D skb_transport_offset(skb);
>         paylen =3D skb->len - l4_start;
>
> Thanks.
