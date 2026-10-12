Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A33EEAE5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807065; cv=pass; b=JYLtBquhXtukFzL7imt9OUGvo1nOrTAE9cnmKPk3j3TPxSKopY136dkExcBHhi6cY5zMOomLCTW0Yzwcn6BPsKffUbVZ7BJbOb2phDoEEdz62uVCaJ+Wd/tpq3aMNc1F/wJQSdapYLnVzsq6GH8+fKx6KMqfwhchqjIG4kGKvbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807065; c=relaxed/simple;
	bh=5imneF5bi5jgun8fbbTMbMv1DWb2Fv2Q5/2HNHuLOkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+6LSAmde16hHq/cexH7nQ8AHBg58ehpv+QqBj9ZPNRNCJx+UCC4llrNfjuc8YRCwmbVUvsOHVrUjf6tY2K57vHvrQ+pctobmPQeghLPHih9xws33wiHewZdsgpdnIM+qo+orLEEmCWCp/e4SzTP1k1xN6v9x1dlZjf0sWKNEQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=O8wXIpmj; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="O8wXIpmj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e61ac64ec3so16634355ad.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791807063; cv=none;
        d=google.com; s=arc-20260327;
        b=Ux/ohBRyvj4lsg7AjCbRv+BPaLjuILkWcQiPXTgtuHzLuHI7f0W9klFPS9+pYJmmmB
         6lGmw/UJr/uraCj6z8KanWFmGrlYaAMBZDj/KoNzhHQWKAP1gzEBJCCRxfyMKOdCWabo
         JycBTdyxMf1z+3PhI2McSwkcveY0JSTqLXafd24/RrWpAhRn9v3lE5J3sxiFrfj7/jGA
         AIn47xfZg+9/bmNG8Qt9J7YE4lF22cgTgu8kvGPdc5YaGxkwRhuxl96ifcgcKeUPo5vn
         mS5LHCtT0FXZgZRDPxHVL/0Q6D5t7nzK0MuovM6q53BQjlQmGBnDNcQ6IIfdgo4PZcHr
         1EUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5imneF5bi5jgun8fbbTMbMv1DWb2Fv2Q5/2HNHuLOkQ=;
        fh=/rs/fgyi9w9QUgH09l/T+kGtjll/c+C+hvhImozp47s=;
        b=DWTuDi61fR16x0oSH+CLle+q9QUB1OkwEaiv1VHS8P1F8+OqjE6VyEcNZNne2NZt0Z
         iy5HzD6/QKGopSEKsEudKCCIhzixS9mUvlJUU2jKZTxJK6X6tZ+5Y+b/YJirtOOE4zzr
         LCWr3kQccFvKWbrxJ9H48Y9hY2RtEonwpsQpqhN4LSjONav3CLMnlUmAJLG1gYx0lX1T
         wHqJUi+GSeeS0nYT7v0kfZtTvvlLgzehL6Rvf/HCN8EnBGil6bJJH291nOp/Zl7G4hrM
         mat+Jnpu9fECfB7KPa9H7U+kbeeJP7oj37vwbzYPG/IceEIujdKSmTL4/Kx8fFfZgSD0
         QjiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791807063; x=1792411863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5imneF5bi5jgun8fbbTMbMv1DWb2Fv2Q5/2HNHuLOkQ=;
        b=O8wXIpmjCqQb2c3pZiZJd1h3FrNYD97RxCU9+GuWMu1dQJjMMyGD+m4vTRKvCyRuAI
         ekegyVpPpUAouF3pCuILzCFwOCQOSm9yKlQ/l2DREEQNjnahdj4zVbH7VlCgTlniWwAk
         vIuoY0BvD2AS16x6H0DBIu2Nr//UklzoEbwAYLohfEtNFXs6SWe+Pz1vLZR0HtPjhX+l
         g5bebGFJlRG6cOd0NmpPwXVx4ZDreoFxjlNeaJ8nd+Gi2Jc8UF/1iu1qJ1nG8ThllUeM
         x3gXLiFjdMYoVTYW8RRM1uQq931z8AlL0msiobydw6SZhOx1zAR96uxivzxaj0+FUGlE
         fcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791807063; x=1792411863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5imneF5bi5jgun8fbbTMbMv1DWb2Fv2Q5/2HNHuLOkQ=;
        b=yBgyfyl1VcUzv//672CbxsnvaaGcYFsMKXBx8N9SEIGfBdP8ohfdUBur6wEaJGS4j6
         EZ7xonFLYdVTMacqSGJw6D9cKmWp723Wj2/ojEbx9/s86kGJ6PVYc34JnarbJYD0W7GI
         pAIOxXXmPVCQzgnl58oX1vCormj0rnqFWFczWzchzBpykSThXTH/e2nkOf/RK7dDcJG+
         gOGn6dzbZym3xRU885PorRvEITbh93JPv303ecHQXt7ZiUN/QX5irQ1FVS6p8fAy8nEZ
         14bh750H0OGQNUJ2bTBHft/nMklf99urBWlJCy+WxqPfpk51Irhx3Zd3M9HkfOuA1AHy
         fJOw==
X-Forwarded-Encrypted: i=1; AKwUvBzoJoI/UEpe1v/ABTOBx1MCeDRnG/cCCML/s9gWic3tI48XA/NF5wtCdSyOZ56nwTUhIMbvAr4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfsz1cskZzbqZSXZaRDIHVW+Dj/LrBqSFp35LXG067cz8eAaLL
	E+BqDD3/3K6i2w0exB49fIUtDjKRPJmJ/JOPTv5MpgYl7u0zO4Jn/TY2JphETffWtpG74aHx29Y
	6bPcRvBrzUoDUKwxeoNGatImcALr+LCgfN7hftWbWYA==
X-Gm-Gg: AYBFou2cum/c65KKpgswk5r34Fzcr5twWQnWl6/4XkGLNdhXJDZ7PBpqvpEexEFiVGB
	NPWQzpyjsNdMmbemKX5J1pSmJvDx/RKadk+lZTUPJnWrUmT4t4Dd57FrN0Iu0yrVHRnJL6VSi2p
	yMFCV8TezA4Ga4b/ecqyxGOwA5RrW4zsKBgJ1gZWrtx8exUGcT9m+Oa+IrJFIAYH6yerP89zeLc
	yGW1QNlr1FlkEX46a5woAdvh1UAKDG8JCeYCBaTEYvK9UviHNWmZBkaQ1Wz4GUCDNnymiMkEZG5
	3s9RM4N6xl9taro/ComYBVtobtr8osiOEwq+iGmeMxqu7LIL55JaifgrA5fQqWlL8runupqduMt
	zCalGBwChd7+lc7qC9juiLqKHFSF+Bn3oMz9W2RQjYNgj3N1jfQGlCa942QlXsQ4InEjwyk78Gd
	I=
X-Received: by 2002:a17:903:230b:b0:2dd:c100:a5e1 with SMTP id
 d9443c01a7336-2e842df9c64mr84761985ad.53.1791807063406; Mon, 12 Oct 2026
 05:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010145106.773639-1-edumazet@kernel.org>
In-Reply-To: <20261010145106.773639-1-edumazet@kernel.org>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Mon, 12 Oct 2026 14:10:37 +0200
X-Gm-Features: AclHuK8DRF7h4yoRuEUgqqSib73XTa3xTkHTUF9D0mRimi4RFLmab13pLm3GGQY
Message-ID: <CAPa5EdAioOoMNj+kH8+Ko822tSyLJL-CxpXr3Q=ZWx0jwFNdOA@mail.gmail.com>
Subject: Re: [PATCH net v3] vlan: restore HW VLAN tag insertion with
 reorder_hdr off
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Stefan Agner <stefan@agner.ch>, hitchin999 <hitchin999@users.noreply.github.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

as I wrote in [1], the bug also affected cards using the r8152 driver,
so I used that in my setup for testing.

I applied this patch to v6.18.54, which was previously used as base
for testing, and I confirm the issue is gone, and the VLAN interface
can be normally used. On vanilla v6.18.54 toggling reorder_hdr to off
triggered the issue (even when the VLAN was created with it enabled),
so this step was enough to verify the regression is mitigated
kernel-side, so:

Tested-by: Jan =C4=8Cerm=C3=A1k <sairon@sairon.cz>

Previous v2 of the patch was confirmed to fix the issue with r8169 as
well by hitchin999 in [2].

Thanks for looking into that!

Cheers,
Jan

[1] https://lore.kernel.org/netdev/CAPa5EdD7tFRyDztEanTwQXTzVEE8T0FLkbXAtWx=
UcGGaLYt_bA@mail.gmail.com/
[2] https://github.com/home-assistant/operating-system/issues/5019#issuecom=
ment-6065756866
