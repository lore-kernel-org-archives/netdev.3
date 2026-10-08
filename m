Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD497472096
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448434; cv=pass; b=AExdNl7Jus9th1C/nLaiz+G1PVhXkbXI7tqgbgVkxv2LqOiBffuBz6WbCuKxadTGQLYWUGyEKGrS7y28pjQ7kTiDXQYEy4P0MlOhXEkH7XeapM24NA9f3RNaWt7UwKhy787Aj4E4JyDsMy0qHKXPuignNGVFDyuaCGqkiioRkEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448434; c=relaxed/simple;
	bh=ZLv7mndY62+Es2DZMTILbbLAyosW2ZzatKjypIyEaX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPN4/lrMP/uFmhe2e1h08ZWQpBdu/Q8VAjO6k6nNjTjMKykpJAk0ordtEKJf8aNTIbBVCRu25S6qoYsHqR1CLVkj95AbdZyltV2c3AgrnInUN8iP6i9jd2RYOVLLIcalR5NBoAvFyQuQuJxdSycSdNbrSqU2qE2zU+LmRahIHtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPIKOYC1; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPIKOYC1"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ae8607e8afso28865347b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 01:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791448432; cv=none;
        d=google.com; s=arc-20260327;
        b=GZ/cjryjKqQOyirGMR8N3jma0YiSjR0BVVLd9miCijHCJ9h+UD+zav+DYJSdJxNbAB
         4NrvIcto8mDTPGqghzikoKlxW1TXfs7j7cDO0/PUb7VNru7Tbu+QOjQO3+nBiWWDTdSS
         kSOwBQqXavW5SQ1HifhOGbPAdaiktfi4GW9jaFc95O+bI/H1LmacFUCBJoz+3N6UGxz5
         aV55xwoe2NNStMV6U1s/DY7yImfHbVOAlxL/cDgkXx/5J5qcdauiZtb8V2tdytKL6UZ4
         mwH8RMo8+6dGodAguy+bVndmUo0biDV9Uk4RNScMbGItKVD3gHqY1JoLWqkUaCRc0BVN
         R2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZLv7mndY62+Es2DZMTILbbLAyosW2ZzatKjypIyEaX0=;
        fh=TAL3pdwquiEyiYkeJqq2ynJumrXFIEU37oIpbTafLUs=;
        b=FL4xZc0r2oMUV5NYyxTF+XFa9PeMTgndX9PwUlsEgMjrMCY3Y/s0g4dQcXJTtZxdqI
         w1oJBu+G/teOy6PloK9FGDtznE3lU8Bh9kNWDGeokc/gI15vvT/kg4nfvxvGgOcMbTg1
         TB14Dmlt5EhmB5Rar6MQ16essPsEWUFuzmmfgi76tMIlVsy6E6OaAHyC6U2x+T5g0Gbp
         1WduMNhNHMqEuIIm3p/fJsKWZMEndnsk4T2JOO9HKF7BxxZKNGSeq9OqfjBF9JioyiQd
         XQ923M10LO2iFrnXSqUi2lNFvS00TQll8v+anEmVrpIa1YKg5SOWH2FSlogcJGPi+eVE
         ZmTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791448431; x=1792053231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZLv7mndY62+Es2DZMTILbbLAyosW2ZzatKjypIyEaX0=;
        b=ZPIKOYC1mgaw1D+nMkrfz2LZTyYd5JSqaX0/XBsjpkumjUSHM1XK+qPTx4/NATH4wQ
         FS7o8mNK5GZM+Z4fZFCVZ5GUdAH1OBxLY7kp6I1Ki0r5Jnbe6L36SpZRcR4TQtOxTtxo
         LZRhn/SV2ixO3RhjcqBesyaQpDGHxuFI4m6K+CI1QTSBp+VsDGfJe9tXC6V89+rySmgI
         O8BJM8KIxWGBgos/ja7xmlkEzYiNrD+nqqWTJDBbTndXTxhesU+wtHSDTqNdZYZrbXng
         zSVJlg5sBzvF4QPz0z9KrVyxWPVKyzDFxPSvQcph/KPSOj91jf80mIdTDTvUB6XlCS6t
         /mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791448432; x=1792053232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZLv7mndY62+Es2DZMTILbbLAyosW2ZzatKjypIyEaX0=;
        b=dOFBNOa9/X0dJaEco/fln9o53s5I2IGXBZn9ThuRTESeor+jpNfKtScIIXgs7ulWUD
         IW9IoNY0GW8YlibXEiKHQ6Bh9ymvHMkIzRZRsKZNH4V6AAOz9mnF7+teyW72h0amjHTi
         A+y7Kn2TckOMCriPYU/gN+wJDNV5cXeeeH1HOK/ia5veX+ohfvxEoEr85HlGhV0PQQgv
         b8DUZGNJ2swrJsMdtXkma7DtjRac3UHOy2X7nURmUoZqiQyTJA7NMQsJZGc6VsErP+QD
         u+QdWfY1iHT+k0AOoAdhDeVwG5abhKHWGjv7JavBpCfjMvV6FdxsQI+m5nRHm3d+J88c
         tASQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrN5zC2VQ1Teepjn7nBW1JqIpgX62VmlNPHzTlYYZ5uwF6BeFLSPunkhjX0Qa29RjZoTFYEkU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJw5D86INW6pF9rxBracZk/n+BLenZVPXOQf4meOLWKqgGvvX8W
	UDIcdKAuiLaJ7xKynVeYQc2iMDe5KtvPNShfPn2U3IrqhVGp5HGeSKvCu0Se3gjj6JHa4E/yWTV
	QutKgpwwVwQCBeYFJ4EVwHY9SsigCPnI=
X-Gm-Gg: AYBFou2PXEPqiTy/W8Gpv4B2E0ZI0trNYyUmUTjqSa7zD/Bd5yViy5wQ5girMAdQ9bD
	7mTw48UYAQa1d4E2CGsZzcOIO7AyOjuHmRflHFf6B2+pPDz4YUF1bi+aDlYAal5P2jIbgerC03M
	+lwKCU+dTgxo22omv/2tr/PZFzy9+Mr4QbbAkJgknh7L/sWEfYoi8IlgjV/6nm1f8J/rAl8ID1R
	W+1GXkEalNtH+MFPx0p5+oFP5b++lT46BL6TM67TZ2ue/Nwp2rGL7hDJV1lLaifXmAp3Np3yI8d
	hEErHO0h50W7mBxcgMWkNzMCQ8EgJtUauQs42F/oEmPvrzbcHrYgItuKXg==
X-Received: by 2002:a05:690c:e3ce:b0:8ab:56b2:8111 with SMTP id
 00721157ae682-8b05b07d7a6mr29202687b3.39.1791448431675; Thu, 08 Oct 2026
 01:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-ip-core-objects-candidate-0002-v3-4af089192b0b62b40b9c@gmail.com>
 <20261008073001.GA1257678@shredder>
In-Reply-To: <20261008073001.GA1257678@shredder>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 8 Oct 2026 16:33:38 +0800
X-Gm-Features: AclHuK-MXw_G0Coo3lKPdsQ0QDQq6I5kCxMiGwC3QXXfBm4YpKcReQYWJQK8FCs
Message-ID: <CAFRLqsUD1RtmK-04_E-xCGnmn7JKxX6h9tbVFdTO0U+1FPSkTQ@mail.gmail.com>
Subject: Re: [PATCH] ipv4: Serialize netconf GET requests with RTNL
To: Ido Schimmel <idosch@nvidia.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ido,

> The correct fix is to use refcount_inc_not_zero() in in_dev_get(), in a
> similar fashion to commit 0e243671bc7b ("ipv6: prevent in6_dev_get()
> from resurrecting inet6_dev"). Please base your v2 on the following
> submission and the feedback I provided:
>
> https://lore.kernel.org/netdev/20260815172032.79740-1-baul.lee@xbow.com/
>
> And please read:
>
> https://docs.kernel.org/next/process/maintainer-netdev.html
>
> Notably:
>
> 1. "designate your patch to a tree - [PATCH net] or [PATCH net-next]"
> 2. "don=E2=80=99t repost your patches within one 24h period"
>
> Also, trim the traces (preferably decoded) to what is actually useful:
>
> https://docs.kernel.org/next/process/submitting-patches.html#backtraces-i=
n-commit-messages

Thanks for the review. I'll fix the reference acquisition in
in_dev_get(), returning NULL if refcount_inc_not_zero() fails, and
keep RTM_GETNETCONF unlocked.

I'll review the linked submission and your feedback before preparing
v2. I'll base it on net, use the appropriate subject prefix, trim the
traces to the relevant paths, and allow at least 24 hours between
patch postings.

Best regards,
Cen Zhang
