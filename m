Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95753B6354
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783641206; cv=pass; b=qAnsxst2angTpRDrePNETMGozN0fDETK2CGrckrRg6pyz7m24f4p3htjOUtF/ddcPPsdS+LSCY7GG9G6oAXDWqTIUv4jv0Gzq8YsNv3V5Y8/0cPZhJjsm7GMIJmwmzTx2s7JgTY4XToVbNMBR/1AdFveQ7U6oZla3wYsYjVkapY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783641206; c=relaxed/simple;
	bh=QxXJ2iYC74zZ1k//RBChmroSQvJ48Sy3zPw9JY9QGNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgNJmxerNbn0TrLtdBl6qI20+qS8l6JDSmfTzNCgMkUTW9H73AdGMRs9iqnKeK3FJ2aw/ViyTvIBwwVLT0kAK332B5MQ9YL/40lIDazBcFN3jbjGXkJ3GTRHjzfGme/SGBPI7PaWWsbUonuqSLJYOyhNNnAKrtf8a4ngHWCml4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=La2HozxR; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="La2HozxR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccdf36f63dso53805ad.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 16:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783641204; cv=none;
        d=google.com; s=arc-20260327;
        b=gwGZD8KuhUzoRZL9yed1RA9i77osnJFyd6D0GYDAwWwBjrukTZkmpHN3Qv99wVs2Fi
         hVexGVTH9z7+4ErVFe7DWpj5d8oxgQ99yAyOjfkVrZs69IJietey9P1VzcFfG4hcBQbW
         w6Hrn6LKAQQtDCd/OnFl6KF9JtsTulJShILskYcRlwv5ajpzmTFOlScaBnI4hO5TyUwz
         Rmj7Z+UaxIBoBnmxLFgVnuZnB6ATr6vLdBWuRWN2tHsfDe6Zg/yc4UUzMcE/ev1xrIeN
         +lv1fgonuXwYCogbHdxuTmPTPOzXj9m7jVsLAnLZpyXO7UBqe9z+mdYO/9l2PATg2uRQ
         0OAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOivgKSF2Ne5xcZXKv/1fscB/+VMh3Ha5+HjjR37dZ0=;
        fh=3cVnJoDFD297L/5QJoUSzs7DdLcSK3m5Hp3SvR99rXc=;
        b=BaeySlkvgSc6cghdTxeCvf2F6ap/Ow9tqqk1+7HFXhFpVEI4UNxoDqtLsZVmlhBDNa
         bqVuw1a/jIuj/Opf0QuvZsHKEH/mZhn2Ridbant3hxDgDa+/t2LjcMtk4ve1dRiUPIfs
         NTvkmLodd7VFU2ZKQW8e2ILNkxzUN3rpSUzCV113FaEi+RvOALgaYczX2bHYvxS4fn+t
         N/j+j7KmIxJTVD7c5cSr1iRKK5DgX85iJiYdht2cjJSJt5tDNybIJicROEoDaIEyPs5Z
         x8ouFfPNSVh5DWf0LPOoZ9FQ/BixQv9v37dHiSpjbnTqjbOAoW6ShRv9PvDiKLPbwBaC
         jcDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783641204; x=1784246004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOivgKSF2Ne5xcZXKv/1fscB/+VMh3Ha5+HjjR37dZ0=;
        b=La2HozxRnblxV2ePLS7hkd67Dheu3EeW8apCI1+fK29/+Beu3dez2MNcAlRk3WHta7
         //qc3zmRPwIQ3IQIOayLeU/iKlORauT0l/OMP97RybLj8dT6T+13yv6vHChvWyQMnHGM
         5dzFmF0nCGGf3YVnozzOqaYHviE1jb5onuQoTsZnYNFEexqr1M5VuJHOb31A9WXQoxNH
         L57BlexjBBpLyjsWYlj/o2ehDBMgs3Ym6bqezaVgmEKZAZp49S7lTl1WF9MV7Qt5JMu2
         bGQsYyQJ6zQ1GOA/S6x8LFKNqKnZgC+1yvyFjZj0+k5Mn++5VrpdpJMJCgVIZLTuQl+b
         U5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783641204; x=1784246004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOivgKSF2Ne5xcZXKv/1fscB/+VMh3Ha5+HjjR37dZ0=;
        b=bfyIjWMBhk3+QqRI4DxIIOMRhGeqrwE7+7bZPuvmiCXfIQTvgdobg9siXZI6n2mrtG
         G/r1KYD65MHgfmYWl6WWZlEyzDiCUIwBdaWW+Zpz1MGXtz7977rRDV1lficYTyBlLeZE
         R4GfaA/Z8o5Hgl2oly/OEy5m8OV9elHKunMKKICSautD9/91SxWkORz6D7FGm9HCdWB1
         44lr2pz9G/jSWpcf45EI138hrO1dzN5K/TmpkTDWpTn5SPrczig5XlF7Ok8Y6JIw1dih
         A5ZAT6Nfo66bBMoet5s7+wT/sdNHTlEciE1U+QQC8ZzmZWZUMOw7fwRP/lYJWTAiw0XE
         FElw==
X-Forwarded-Encrypted: i=1; AHgh+RoFzobbsJk52hPvBHgnZASUAOE3fT8l1xI3ME3eS3tdST7iGyd+t79ALAkzv4raa00YuJoHCME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lJk1bXuWKuV21c4zh6vph8s1ogbBMP67+1eRJHfkD6Mmd2XX
	mQLICcvWK6HMf++ViJI9/iqx4X5hYVkawWQvkfKZXUrAvDnS2aguihD38KlZnbJWueHmwwCkDJy
	l7LADiMOG/LrwoKeWPEGM5554BbKR8OeNXn9Ld0J84OvJ67qmmRm/rTqZyh8=
X-Gm-Gg: AfdE7cnnLHVzc0TOgh37E2ef5fKm5hcQRWKJ2bRqqAtPB9OU0cfh2svAwyT8Kyqb+bm
	Re1pON9a+739kUoYdbJEsayCOKIQlqYN4Nqtt2qtGZ9Q04hqBLJ0HLQ29gbZ/AnvkGRjWgn61xt
	3riJYA7LyMA/mXopj9vhszNdPj+nYJjhBY9V6FfFp/vHGkVGAcmsEQSAndluSbcLJ3nl/dTmM9j
	i1hcbdq7tF8rQys/E8emC9UZaumlN3KHkVilAPrwaYwX1zEeS5ViekXxgwZIEiBlbu/hs+xTwHS
	3SXZulpmjBJ7uAr6k83rg0XYuf4fH3voy4RuEUnAM8lsUSbJJ/TpEoTtjcWmQfcChSUCTClz
X-Received: by 2002:a17:902:ef46:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2ce86df6820mr902405ad.9.1783641203766; Thu, 09 Jul 2026
 16:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709082713.829446-1-johan@kernel.org>
In-Reply-To: <20260709082713.829446-1-johan@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 9 Jul 2026 16:53:11 -0700
X-Gm-Features: AVVi8Cd5ZRhOi_vLjftB610oSlNn26rSijaAnAjkQUi_bYjoJyjhZsIDCoXkKSU
Message-ID: <CAEAWyHfTBcPxV2zq55mQmvprqwViSvhvXFNRW0VKxv76KRiTgA@mail.gmail.com>
Subject: Re: [PATCH] net: mvneta: bm: fix device reference leak on failed lookup
To: Johan Hovold <johan@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David S Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:32=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> Make sure to drop the reference taken to the buffer manager device when
> attempting to look up its driver data before the driver has been bound.
>
> Note that holding a reference to a device does not prevent its driver
> data from going away.
>
> Fixes: 965cbbec7f20 ("net: mvneta: remove data pointer usage from device_=
node structure")
> Cc: stable@vger.kernel.org      # 4.19
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Okay, platform_device_put() has to be called directly instead of
mvneta_bm_put() because that takes in the priv structure.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

> ---
>  drivers/net/ethernet/marvell/mvneta_bm.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ether=
net/marvell/mvneta_bm.c
> index 6bb380494919..128fe1f512b4 100644
> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c
> @@ -395,9 +395,20 @@ static void mvneta_bm_put_sram(struct mvneta_bm *pri=
v)
>
>  struct mvneta_bm *mvneta_bm_get(struct device_node *node)
>  {
> -       struct platform_device *pdev =3D of_find_device_by_node(node);
> +       struct platform_device *pdev;
> +       struct mvneta_bm *priv;
> +
> +       pdev =3D of_find_device_by_node(node);
> +       if (!pdev)
> +               return NULL;
> +
> +       priv =3D platform_get_drvdata(pdev);
> +       if (!priv) {
> +               platform_device_put(pdev);
> +               return NULL;
> +       }
>
> -       return pdev ? platform_get_drvdata(pdev) : NULL;
> +       return priv;
>  }
>  EXPORT_SYMBOL_GPL(mvneta_bm_get);
>
> --
> 2.54.0
>
>
