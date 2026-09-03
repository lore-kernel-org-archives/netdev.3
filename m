Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2141A551
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420025; cv=pass; b=cqbvE1RReqGbNyipQfnVP5da0zsbBt01pgwIF4O3VUx9fm22hApLP2EsQskCTfC/NNHgeGPBZ4eO3GmX1P1zZnAZD/oTi5mQp/jwggfknV1tOM3idjlP4kvngJ6DH7YiRoZDVgHO8VcORQUXzLTWY8zXdO+n+OMCE/Hu4ciVDkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420025; c=relaxed/simple;
	bh=0bPXTCVYIWQmAaMBthNvhNfxfDaP7U3BOuuHFTmahRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC4I5CLjFdqbYLhafFl5vlLfZaFoNgjGa8K9xdBFZuQGZqih9tLchw3s0eMWxceFymqDNv1mV8g/Ept4m5h1J/7+TWqe9KSDGMedmYm7fnXpWkPbTaxjzvHkxA5moJtvaq9J1tBUyAjCzcoKrBB+0c2/49nxb3lif0RLgqItnGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHLsDPrd; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHLsDPrd"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93959320373so166085785a.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788420019; cv=none;
        d=google.com; s=arc-20260327;
        b=m458HhCDzsfVW4rsjHlEMche3NmfPyL62Jsk3fmEmcSRQZRvcAF94zOcOPVLptXN/q
         u2QWmgnxDM8EX0hAPvhtKBmlEn8mocvxDt/XqjzzCO/v8vFYDTV84hyOlcYXyQNoMFE9
         yNOA/ZohnHBw6EhyNvqJy0IuGSG926Uhbhujq2t00LTPLzDdqLua/D10KevJYuTkETYX
         5TUTyxyFqXYegcj7SeKCnxd5twmMVMgGA9fIS5Q3jyHi2YQSrjyHVsHU5eXq16NJsYJQ
         jMOyD7XAffEYPX9G7B/0LOlnrC8drZ/pJ+tkNDkJBNWXs+Ctl5FyoDwgE/hgcayQkURz
         V57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bPXTCVYIWQmAaMBthNvhNfxfDaP7U3BOuuHFTmahRM=;
        fh=+ztWO9dkwjwS6nN/pNHR7Bn/Oit5qJ47ci24OXTBMnU=;
        b=k+IkG5pnrlSjqPS3EwDpeEHFh3OCLU6p9GnmbjAcAgJxuF4aeNehhkbc75slfrI2F/
         LaaeYcvKlfYF8Zr01y6fQBtNEReZs06/dfw7k+BlLfnS6v19zo3rjgSWqMaSkLkPWL68
         HJdSdjEtt3qrx0Cnznk4mVPKu5FFJguhEnbuW/V/HFZEf61Va0iv1Rd+Xn4fyAjtwpla
         5ouv9UVo0tZ4AT8uQFQ6KBeV2Y75z1Sbt0mh3o/4WJ+EMRTx4Fjr8Zny2Ni90lXtV3Y8
         uMfR/jVQmnikU7U6f5oh3SufmmiBiyqaHD02XEddkfefz/tO891tOrgyppo9Oc5lM5KA
         XQSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788420019; x=1789024819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0bPXTCVYIWQmAaMBthNvhNfxfDaP7U3BOuuHFTmahRM=;
        b=DHLsDPrdeW6FYsknCRxS2WIWmPAE+2mpZo5q9iHyEhvC3rWa8SzRW0019TzWTwLQwt
         mjKjfM+RyLKBxL1OMfeV7qrxGVJGJtbZuuQ35cvjg6H//759aRa8SEsA2zr5QtG0IOAp
         J5V6cOjKG5LRl0P4+w9S7xfADvLq4aD4JgrHKdzD8HIova5vUbuX6g4JcswmUiP5LzMK
         JgsQdRKjkVBqdsot9lUeN2jJR5HRTdLtuF2VtJjRDYRYMmGGYvtLgxh7qMiRjEFgBIpT
         FYi6CNDraFHBf5HGMRyPA4xWDFPo2q2+B3QvOP36Llw8H0w9X0Gi0mYniIKsPRQb9pIN
         57jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420019; x=1789024819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bPXTCVYIWQmAaMBthNvhNfxfDaP7U3BOuuHFTmahRM=;
        b=S/paaNna6AAcumQFckWqUrM8/xfri1yukNcBjG0jdLknCujhP1lE4CnP7NpbUqI6wA
         luvk4Z3D4Pnas0KvERnKngQ/8KeohFRgpH4eI6KhMOWRnSPz+OZtXlAsiCUacI9nw5bj
         yblH0kgDJAP8kNj5HiCfvefeh/SSSYOpdWfpGYC24ZImovXn8lwTNMqLVFUx4c4XwRAZ
         OZ1cdbkkXwTxAXSNelpHY2Ned6h3Pn7jrtOya+Tl46qIfDmxgjm6lC+ZQxinJiHcPBT0
         3+UYGFkKlg9f2zCZBr/weNMO2KL8+2jkVCeqYesjr7KP2kFkpBWGkmINtWSeSg2SbfbL
         fCfw==
X-Forwarded-Encrypted: i=1; AKwUvBzBljIEoTBAbvX+Xjqj8azJKMtzzZgAEagezaLOxIsvtz2eHqgoOXsEiVYoShGEJNfBrUnJ5eo=@vger.kernel.org
X-Gm-Message-State: AFuF++lBxCFX36/nTs4HSAyvBcbWIlamsqtl8cuBQLwZDA8sUL1iRImV
	yGUEG72VBC0t9KGPupZ1WRpAp/7EECBw+CceBHfiNen1X/KEI3yUtenJhOXaMrvWnIymxKCt9Lc
	2+oxccaD7pO+WzIxnuB6o3G8widwUi0Q9BM6E0WBR
X-Gm-Gg: AYBFou1wpKwMMi6ZtEVE6fbGNqUpdESjqT4PZZpamlNke8AzUIRsE2bSE2O0gg4a2l0
	RNrr/FUWlXrVy5VaHZ/jZizB9osJmysk8oeyiLkLR4NczIxygykJ2Th9BeZZAoPmgI0jJpium/I
	2VxCxqLdL7yc6M+ZCzUkTOAzbiFjQgjGUp1X8Uhbd9FLQnFBY4hrc3G/6hPakHQIViNcEnpk7Tb
	im7ppe2PeycubIkjaNdT9h1iOBLB7g6AQq8aygX2HSo50TdPKiU4raKPC7gJvZKqRTEwmFPg+oZ
	qcjwCd2o056+SB2eadlpOI2cvtB6qBtuL0PnvSN5jM5T3dkeEi5R6lAidOPOka3yza4GjIceOs7
	04Hmgiv/NjWO01HTE3kyOooqaj9nHC1uTcm0cv0+rA2xcOVlnituLm+8d/Q==
X-Received: by 2002:a05:620a:7f4:b0:936:b923:4828 with SMTP id
 af79cd13be357-9396e07ccb9mr389968085a.31.1788420013484; Thu, 03 Sep 2026
 00:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788417128.git.zhilinz@nebusec.ai> <d8a36c317f6216d20f9cfd7e49f1888f62c35f7c.1788417128.git.zhilinz@nebusec.ai>
In-Reply-To: <d8a36c317f6216d20f9cfd7e49f1888f62c35f7c.1788417128.git.zhilinz@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 09:20:02 +0200
X-Gm-Features: AcwNN1X3WxNp9qXHHmQ5-xLjWE6FBKNDo9oAoxB3J-X5WBuzsbbH6MEbh_Vf3u8
Message-ID: <CANn89i+Eh1Gdqgxaf_NhPCjp+2nNPNgDbYBQbmxUejz-_jXYRg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] ipmr: only copy pktinfo to cache reports
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, dsahern@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	leone4fernando@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:38=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai> wro=
te:
>
> ipmr_cache_report() builds short IGMP reports for mrouted from a packet
> that may be a synthetic RTM_GETROUTE query. That query skb stores the
> netlink requester portid in NETLINK_CB(), but the report is delivered to
> a raw IPv4 socket, whose receive path interprets skb->cb as IPCB().
>
> Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
> msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
> original packet and then copying the entire 48-byte skb control block to
> the report skb. For synthetic route-query packets, this copies
> NETLINK_CB() bytes into IPCB() and lets a controlled portid corrupt
> IPCB(skb)->opt. With IP_RECVOPTS or IP_RETOPTS enabled, the raw socket
> receive path can then copy past the short report packet or overflow the
> stack option buffer.
>
> Keep the IP_PKTINFO support, but copy only the pktinfo fields prepared
> by ipv4_pktinfo_prepare().
>
> The WHOLEPKT/WRVIFWHOLE path is a related leak: skb_realloc_headroom()
> inherits the original IPCB, then a 20-byte header with ihl =3D 5 is
> prepended. Stale IPCB(skb)->opt offsets then make ip_cmsg_recv_opts()
> copy bytes from after that header as IP_RECVOPTS. Clear the inherited
> IP options when that header is prepended.
>
> This changes the accidental IP_RECVOPTS/IP_RETOPTS behavior for these
> cache reports, but that behavior was only a side effect of copying or
> inheriting the entire control block and was never intended to work.
>
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
