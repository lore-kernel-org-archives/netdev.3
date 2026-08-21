Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3834F24E
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279947; cv=pass; b=sj4NE/B42b/sj2mMI6IBXHUeUxVRc6a1G+QHEXzENQl8Op+iGtk1tf4Nbq8KIIKSA+3V7FXLV/KkHE8koCp/wZnmOJla5S8+7dUSFdgnquXjwB7qnpqkBTul3Mpay4ckPJkAM9fypd8Gspo3s7ZxSCX/ff+ofVgvEJBereSqZzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279947; c=relaxed/simple;
	bh=y3RDWkI0uVrukA3OR08R1nV9fmmt4shyqkH1HY/Tm1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEsz4fQJWlKI0N7YapyrNUViKHhqzHUT35ynOKU69LUxfEBXM6bPRCbqwO9D8qNgDJagLk0SlP1P1XMSLfDTk0MxzQ+s31bmvl+JUz+h3jLMULm2LHN/ti8+dglSsBe6wvojg1cGHp5rvBVg2kA3tLv/NZHH5HVrPkrRXxH3bEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF1muAFz; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF1muAFz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf228a910so4169335ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787279945; cv=none;
        d=google.com; s=arc-20260327;
        b=B12TzXE2FRjZ66eUGB4oMMXoJI3KmnoSmMlieckRVBwOZ82mPxzJdhw7/JpnJNBIkU
         vuWBaUQHlW147tK4oHV6WCRN6VqfEkSjGVfRGtkzNX7V5gq+mLiRBg8V3GVNp8E6xJT6
         fdx0G0Eo7A7SxgL82y84VdYTVj2KUQ7GWjEA2YDRVhwXSzQotjAfxn4iFtnZN19qsNwv
         SjMy6wcNd3yIX5Hwvfe1077joWZlNLMdCLO6HL2F2/hXUiNloSjCKkQQx2ZCKSPAwDsM
         7iSYYzOKhCDrCIfYWnXjmJBUfLJKfK8RrOnJESSCGor6KeQVFOHNAwwO9LlTp7zPWUt7
         BvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y3RDWkI0uVrukA3OR08R1nV9fmmt4shyqkH1HY/Tm1s=;
        fh=XzY9htL35Q3JZ+pHpqebA3y1YclBflGJrxSTrUV0+zc=;
        b=dG/feY1jPwFBnIw3zB7VJIIh8QYm0oOKyC8LQiYv5nR+lIWrwfFaIfbcqkbrGpylJa
         3au3wFbLmcELPP2O5ZGB/LVVNL9rxQueZfkPNl1xo1Qtn+a1bYWY+UoBpVBlT8BRU0tD
         7f4bOkuavu/qYILR4XCliSR22TOje0s6hOMwugoZ54ZATL4KibDTjOJw+gpnK5k+qLEs
         893XmraFjAbf/TwVUyGLKqjZ6Mf5uhSN68avswCkxlWzuHUn4Iv7wvKtlLncw8cHGZUm
         NJH+XYq14kNl9WfXaLrGJ1mpFItuzXkyMsWVpoWnWiAcJ4Vhsq9g4Qv/1wUgLtDi7GHp
         g5Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787279945; x=1787884745; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3RDWkI0uVrukA3OR08R1nV9fmmt4shyqkH1HY/Tm1s=;
        b=KF1muAFzYnvz99M0AgccdH7AwC4qyJMaEw2JPPODnOHJvtehzkBfaMf8b1kiXztjMS
         xh6PgsFzHnkhIOm+AlO/PpJ/aofmfYAXREIm55XMijXWqhIxkEbcpDLbQZ0hJYIjOzVC
         ArFfqfoXD1QDmKH4O7B+F27t6b7U05DIhogKld4dOpa0bdyGohr/clYs6TuAWGBMAiFL
         vQ7UKj74SyVMgkQY0gvoBQ7iOVf+kCijofgxQV9cabR60k1cOfJ4oDd2JgMNfVCNV1AG
         0DAWmUDEUMrPNs/5Oz26s9+oZQ4wtKRAHuIa3dkxDs8zLzaEEpDyBI+TrFS2qziVkxbN
         swUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787279945; x=1787884745;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3RDWkI0uVrukA3OR08R1nV9fmmt4shyqkH1HY/Tm1s=;
        b=StrX9/zFwc326vYA6y8Q83pjH/h6qpYiqKtKAxFVNaxx3E3WG2nJRCBndZ/vMqzB/5
         DnSUMgerQFOGYD3QLHgWJgwqyEe3hbQ8gwlvFQ1moRbfxjQMIG+wEnYfoBL0OgfXWiaq
         NSWthvueNJCqU0rywvE5IZ9vOrkaeNwM8fgmMaDDYy1oWoQTnsMJDaoK5g8QBJWvBCJC
         Yxm7ZL+jW8Fvyx5zJ+jdand11Xw82cdJMgCN26BJbhU4auwwF5TXw8qc3imp7zK1AiJp
         B1VSbTJ1237V+kA7iP/X9adcwO4l4vmb5UzV+Q2gbZ4rmyXhYDaHF9jHu/m3NbsBHoPq
         T1fA==
X-Forwarded-Encrypted: i=1; AHgh+RqP9AtLNrCYdNWi+JPp7vOmQBvLj2JkkvvRrSBElv8tYuiqrnyn0cJeSOrR56JcK8xi1QnGRG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKs8CBSJvngCp9nSMEUsmwo+UQZ7oFZy1cSHLPDxdTjaZnR5PG
	+TuBCp1KVKk7iSw7uGqwlXnrj1D4Pgyi5vW494G2XGGkWsLsBRPiJV/OrykxlYta6mg5H3H08bf
	HpCfyMD436P8ceC3J3NbNDuoOLt7rn4w=
X-Gm-Gg: AR+sD12r1zAX5kM3Up/L1KmDJhATpzjBAICFIUs4Oan5kKpS+kW3lXb2x45PH7HcLjO
	8NtJ5kUi3xVTUaHr29gRKHvkMqi+sCS6JQUV2+rYnD0sSLHSI1m7VBLco5Pq2kwlJUjUFe5PUET
	TdidvIVNGH7h5KohAMBbqN8EqaTV8+5n0nRGPXQ3pLNWu8NVZJq18EP3B3hxJ+42fd9Vgd5ra9w
	bc9+9WeCXku9mlwStSq9znpiz6baVNXS8ibGcGNoNbsliGSNv8CblcKMytcujHpvOZ+XmvWjU7X
	sWYsDVM/KAElMCQEmuxX2us42PSaUWLeblPjzSDrEkA+k8baGBqWW7vtQwFXH1sy4G6D92cwqVA
	aTiOpWGMvReEYl7XX1YZWc7WTqk0/kchyMhxcBrISE/qfqP4//v+5TauA
X-Received: by 2002:a17:903:f84:b0:2cf:82e6:a5 with SMTP id
 d9443c01a7336-2d64b06e5d6mr63721745ad.13.1787279945217; Thu, 20 Aug 2026
 19:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820111456.97947-1-phucduc.bui@gmail.com> <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
 <cc18ef57-4f5b-4459-b110-b29bf2c8b8eb@broadcom.com> <1958a140-a3ff-4f0c-8982-9695d1dbd8a1@broadcom.com>
In-Reply-To: <1958a140-a3ff-4f0c-8982-9695d1dbd8a1@broadcom.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 21 Aug 2026 09:38:52 +0700
X-Gm-Features: AcwNN1UcqvdWEHtPDEgVs8sqOwbmA9N175C8Qm8syHK5_Cdur5uwM5MZNGuidiA
Message-ID: <CAABR9nGr+cYmGsj2eXHCRRvN7TkcsT_bTS2LkA537Z2Ns0VORQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] net: broadcom: Improve IRQ error handling
To: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Paolo Abeni <pabeni@redhat.com>, 
	Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Florian, Chen,

Thank you for your feedback.

> >
> > Not seeing much value in these patches, to be honest.
>

I was looking at how platform_get_irq_optional() is handled in other
network drivers, such as the Xilinx and TI drivers:
Xilinx :
https://elixir.bootlin.com/linux/v7.2/source/drivers/net/ethernet/xilinx/xilinx_axienet_main.c#L3020
TI :
https://elixir.bootlin.com/linux/v7.2/source/drivers/net/ethernet/ti/davinci_emac.c#L1444

Both drivers explicitly handle errors returned by
platform_get_irq_optional() rather than treating every negative value
as "no IRQ".
I wonder if they handled it this way because their hardware and software
are already solid. I used these implementations as references when
considering the error handling in these patches.

> Agreed. I prefer the current behavior. Even if the optional WoL IRQ
> exist, but fails to initialize correctly, the rest of the network
> functions will still work. No need to take down everything in this case.
>

What about -EPROBE_DEFER? Do you also want to ignore it and not
give the driver a chance to probe again?


Best regards,
Phuc
