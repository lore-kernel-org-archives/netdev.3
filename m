Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5949DB8D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186074; cv=pass; b=AvehkkwfpjNl02U9SCaN6t3N4Pa0UzMp9tzAa7yxV0Xl/prFotVsH1ydimtteK6iluy+KKXl3YNAQhbfI5/jDEdbUIwogUrwrrb7iUFLWuUG/1YMDkzyX1DQwWTUKPEAVEjEGr8+1HTYjEQc5/pOsnLT011G6rxd7j9ryf1R8l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186074; c=relaxed/simple;
	bh=fXMTA8R6RxSqJZAmaKVosJePA814Gi0PiEsxt5rDwtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFYVuFAeUd1PKVjBR5+jxmg6bNz8li7WsVsWaVQqZDP+Q5WGVqubxDYv9ZKtyz8ACYyeT+pTXZoOZTS+6vRherL+yxMCOnwNeovvnjJQiTcEy8rv+Bz2JKmLSJOtW3AyPbtjD0ryS0m0LX09MS8spxHMNwb+qMlZA8S2k65yfMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hiRQNM9c; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hiRQNM9c"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52ff0b7c98aso24107641cf.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788186072; cv=none;
        d=google.com; s=arc-20260327;
        b=VK+635WhyTCl1t/L0m3WQmjR/qqj+f6Ra6Dwv3rnXtfMqwL85G2YcvCBn0LipznJp3
         bXzz9C9cceRUY3MM//9/aI3QWHl/CMh5HkMy00Z35BFEyCnzCzG3Apgtv7R1w7bPMQgr
         ZnEgdo6UlHxZpco0bvkY9nIToTZFbNhcgyvmRJGhiez4PKi9B+RuNG7Qk9nG6GfaWmYI
         ZW2SCcMHNW6jSN6TwWBB1oqj5mW8jZbXz/5y1hE+RZ7x3yEwHrVIsjX8Jxdo47QFxQCe
         /xIGHhvYtUFs+ShLNZG8WS2/7DB0UL2BkpRBC5NjfWhrE6e2Fgy91DA9eEgmASu+PHEl
         7lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RL1vRxunTSJTFDJSeHeGcvXBm9gGOpDjpaN6wUzR4c=;
        fh=4MnfXe5gGh8EssbtTxa79SGV3IgXzMNFWNbr4GT596Q=;
        b=a9befohXPH3zAQQ2MdF68ZXs6F3W/3Cs9Knx/cvmsk42iR0xHvvUVLkNa00sfTSPci
         Bv/F5b3mRYkBX8ussVfd56fJRqmCouuYuQ8bOmETVfS1XFh07RnOAcIEHgtyn/9ln7yc
         DpGaOfM47URrQ0mk6Uzfxzr4/ZBZ0N+7XiQh9clY+1PWePYdlHIzCByfV0+13Q/8ZxEa
         5RVY4TTjRRzqr4cCBj3U8Xbwc2hE04jg7pvdQZYSepVQOWF2bvTIhttv+vQD8tWdITN4
         jFAS050QqeyXquBDj5aUIE2UPaGzJAuNhL1R0xpfaucIer9I4JQmBXRk3yBej271iGHZ
         DfeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788186072; x=1788790872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7RL1vRxunTSJTFDJSeHeGcvXBm9gGOpDjpaN6wUzR4c=;
        b=hiRQNM9ceQb6xqfsUahC3VaJLlsyN7JWcneIf51MA4JNf9KGhU/zAHrpVoIN6T845z
         9EC+lr1ZbIuLevg9cb3P0TS0PefXvVpMtl0qVdZLNDay9VqXHzJ5JyZJT9SQx9ihAs1t
         O2La45L7uHMTq6Jgrno0x1TwStxdUkDXPJ3ef1tPlIAaEl9tPXzyS1MOwJRDuv+mjrSE
         c7hRH/sZGgBmm/TasNXNBeKzZeBE/9fWPU5XVqB05hpwzqU0C1wUvRCiBm4f5XHmrGTA
         VTs4EwJrYB1dvJ5b5yZomAIwY94CX+/EXJjDMx2MFoTVdyM43ieMWIF2fNDuOR9JKB7z
         eerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788186072; x=1788790872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RL1vRxunTSJTFDJSeHeGcvXBm9gGOpDjpaN6wUzR4c=;
        b=OEfGQEvPbPDJACZkCam++ie6DdvliIOyu0RJXVa20J/66Dx9aHYiT7rxgVUOZh5vXx
         M+Bn23oqS0gYM2RbSsjjfY6BnuAf66a9AdXVit8BkpUfilLOmmY71QAfwW+hlkqK8qbq
         6AYeOGkBt18h5dXxyNUjWkaQU11rkXCgcv7hhzGJj7CS0XShhhub03fwi+NeK75iBK6E
         ey0L8BEeDmkBlo0OBIa51IQQlPv2ZTciRhPrHI3fkbJj90GS6Ha/CrHf2HVmCh2YNMJa
         KDeKuwfNm6+Ig7r2dpxyljYv7kNht6/qnBpJ2R0Lshc2wTOuBkEnoglKiDB9vWsUa3xc
         39NA==
X-Forwarded-Encrypted: i=1; AHgh+RqcGsXS0Ov5D6QtCs0Ja3UgM0NNzB2L6VHSS2aNHBRiPYZI10jNVpIlkB3MznGF3bCbHRPOrd8=@vger.kernel.org
X-Gm-Message-State: AFuF++kWoGB0tbqp/5spi6B/mFhk4ese1pAgsYJBRCSonK1Q8lie9XXi
	iA97mAbUzTcVVbWHsfCb7qotCXrwVj+MRnWgiM1/LmkA7GQOj3vcRdDemvnV/HgdsG9sHisWZpw
	PsfFFolrD/FpXV9IyMnKzJKH2uOOBjY4QYwevzNYCbim5n6HZK1T3BPV8hz4=
X-Gm-Gg: AR+sD12skCLXX8pLoDasRre9/7iIlSm6wfso7jOUTJAWqbCqC7NvDNlfL7yhwuPDy4f
	BTV6fctvqukn/CkMMYbB/plL+4rfPivf/7GJp0k8Gt3Br3jer/t+KU9BMsHLOl60Eg1s3PqlNRd
	6EmtdElNTFYCuiE9aUKaKeoYQJWeOaErFBWBYD6e1r+XVR6vTM53ZIDaL5T0J9v0/pa+xb1B2wO
	il+920J2bjtTJJiLBqhAgbzfuzs0iPRTd68z9VR4oTisuKBHWPANi7jRCVLX4YVVsk+vUxrw5Xv
	b055WwgwkhyUTOZfIBUHpJLV32DH7GWkATnCrkL4z1H0w2aLBorbEU50NUf4Mv+O12mugXusEax
	ihi71LDFdvbjiL+YXlv+e8+EH83aDiy4WLK9AJpoyh8WgY9aDvOz+LzqxDw==
X-Received: by 2002:a05:622a:551:b0:52f:b0f9:e4f2 with SMTP id
 d75a77b69052e-52fb93d5108mr311650161cf.1.1788186070817; Mon, 31 Aug 2026
 07:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831140710.469576-1-yaojiale02@163.com>
In-Reply-To: <20260831140710.469576-1-yaojiale02@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Aug 2026 16:20:58 +0200
X-Gm-Features: AcwNN1UtMqrwfvDxQr8FPDhi66ZCqjZw9Lv5F-5kNAiQHG5_h_vuarhspOvFTKk
Message-ID: <CANn89iJthuCa-BZD9vik7LUw1to8aqTFKRgQfmOGozGvMeLanw@mail.gmail.com>
Subject: Re: [PATCH] bonding: reject IEEE 802.15.4 devices in bond_enslave
To: Jiale Yao <yaojiale02@163.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Aring <alex.aring@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:07=E2=80=AFPM Jiale Yao <yaojiale02@163.com> wrot=
e:
>
> Bonding already refuses CAN devices because their protocol-specific state
> is incompatible with the bonding model. IEEE 802.15.4 devices have the
> same constraint: they keep protocol-specific state in
> dev->ieee802154_ptr and do not use Ethernet link-layer semantics.
>
> Extend the existing check to reject ARPHRD_IEEE802154 and
> ARPHRD_IEEE802154_MONITOR devices before bonding changes their link-layer
> settings.
>
> Link: https://lore.kernel.org/netdev/aohMHTTH4VqqgZA7@fedora/
> Link: https://lore.kernel.org/netdev/6001bd73-ef68-4820-8371-a22775fb820a=
@hartkopp.net/
> Fixes: d5ae67bacd96 ("ieee802154: rework interface registration")
> Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/net/bonding/bond_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 522eab060f9e..c716336c5172 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1894,9 +1894,11 @@ int bond_enslave(struct net_device *bond_dev, stru=
ct net_device *slave_dev,
>         struct sockaddr_storage ss;
>         int res =3D 0, i;
>
> -       if (slave_dev->type =3D=3D ARPHRD_CAN) {
> +       if (slave_dev->type =3D=3D ARPHRD_CAN ||
> +           slave_dev->type =3D=3D ARPHRD_IEEE802154 ||
> +           slave_dev->type =3D=3D ARPHRD_IEEE802154_MONITOR) {
>                 BOND_NL_ERR(bond_dev, extack,
> -                           "CAN devices cannot be enslaved");
> +                           "CAN and IEEE 802.15.4 devices cannot be ensl=
aved");
>                 return -EPERM;
>         }

What about ARPHRD_6LOWPAN ?

I think it is due time to use an allowlist in bonding (and team) to
stop applying bandaids.

Plan of action:

1) Add:

static inline bool netdev_type_is_lag_compatible(unsigned short type)
{
      return type =3D=3D ARPHRD_ETHER || type =3D=3D ARPHRD_INFINIBAND;
}

2) And use it in bond_enslave() and team_port_add()

Thanks.

pw-bot: cr
