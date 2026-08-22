Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A038A70B
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389683; cv=pass; b=JIVyBBzHUg/RjEdZbmy0IXShW5T9m8Krll86wWnCnwhcKKeFFqsji5Ds/Io2ChniLJogc+PaDOE2CkkDX7sl0j91GgdqRM4TCx3OsbIkYEa2Z6LnmzXRE4tiTyjY5/ti9/Tf2HmruCLmQR2OgHe4pzxi/FIxroCZcoVvhjzRu0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389683; c=relaxed/simple;
	bh=LSY6pZTY0pN1XLw/IWutO45ypUvbEMPOBZu3gQ9gNVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5g7+xiJm8/LJgM4GRubujPqbjx2P+IythVplXyjwx3fPHmb65ze6Lv8tcP8wHwhyXoVSVTpHEY4FUbQFf4nHYOpzqAY/n/EIe9tBwyi/4Hojw4mrkJxzdyvrrUMxNFdBq42Vth5afougnWlbFNoRRRce1VhunAC3/wshFn4gSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5j0/gde; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5j0/gde"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf52d15d88so15372915ad.2
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 02:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787389681; cv=none;
        d=google.com; s=arc-20260327;
        b=FCm+IHl52R+9QSHUClGKWnRsbhVgRerAiQWvnlubyk+CWgu6tkN2bT7pNNOnD3g3XC
         n1q/Hx45WsAodgDsl/9bSEVBUqnUiLzTBQk9DhDQZy6+IcNyoi/1ELJB002C+IxvVAa4
         8kxZZ0B981cD7Vf1WnBS95/fU0OURUKZX/zEnUQvnmAfAMoWBFSTRN0r/F33HGJeud95
         krjlRHCXzMVI9Gim2KnF6dMUGoIIf+wNNHp+8JI+F0ifs6PWdk/eh9ykhFcafATTpCJs
         lZf5V//Qm7lxuILzOtijTXU6hMrgRaBdoBmKdWRyRxYJkvienGq2kWkQbl/pqsefj0yN
         D21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6woqWYh79iNFHKYUnyFN0FJNuKmn+PKqFBiyiz14Gxc=;
        fh=Y4t95OSII3ojq+ql5TMZeXnny7UDpmcYwfEX9/JstmQ=;
        b=BDKa2Yr4IdRbMasoxnqedV9CQnUv92ZtcJqKkVtirDuxgbUG1zWqiXTIoZXmaufDHL
         /kMGDd4hoj4FTSqru7wAw3KiQF3YDqeO8GY72n9secgRVaqhMWjZgF4GKk34D+VrWUtI
         UXqcWWmxQwExzi+ZieDV7gyuUu4tRC0hZ5iJkZJPu98mO8q6KD2IL3K75oFyIN4+o33E
         7v60oEQGYeuhD2UJreRXB2HYtOlIXc+uWU5qX6biBE/liAZ3oit3id6FjS8kLnuNo3Ao
         x8z36Btyvriec8F07FIl1Pm3YQb9mvKKVds7mYWYXvi2N1uicoSKcEdorV8wCD0bTrTw
         +FyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389681; x=1787994481; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6woqWYh79iNFHKYUnyFN0FJNuKmn+PKqFBiyiz14Gxc=;
        b=h5j0/gdeXSWJd1o0UcnL6cVZG8ZpGA+zVi5VpfyAYWwT2cJiuZSkFJ+lXxizsitDZK
         15neFEVmHwuRJ+2T/mner9qd7Rj2yetChUg70DnvF55bytyqcZ0Lt1gfJmkiBuEsB1pp
         V1SAIqdbVC6LiLrBVSWOTYg6kA5GDTMKuwz9mwuBOJX4D7e3NInfCLU7BnHFRK2wfrEG
         ZdSM3O8cRCgE+bFpM8mz6xY0nmXvvUAG8khUSwbsXe8BatQPJ72Y7xZUN/YOwU31bymC
         UV2iwph/1zqThjXQNIto1SdUPHrxD+APLFzQIBaQFoE2UZxE5GvP7c7ncCN0zbRfCIxP
         7ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389681; x=1787994481;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6woqWYh79iNFHKYUnyFN0FJNuKmn+PKqFBiyiz14Gxc=;
        b=Nt+8h4RlqXSu7ghn3YoqzCCL18S5wML16XexcyfOqfOR2UGQ/iuqv5viCDyVogrxC5
         6Bhm4cJX7eDZAsm5xFwSP9BEQQqNPcVyP+KS4b1536BVPLt2e/zQt9a+5IeVo5jNLbxf
         JCZ6AEABEaZQGJ+47wvvFcg3b1mfd72QmfMkwVQw6J7xkIKFvDtrMJq/ifCGYB2Gask9
         F3LkzL9lT45R2tsrPVOMrI2fWeyWDoovAlic1CeGpi0c4oft3dh8tI8fW3apjhMh3IuN
         7cUFkFmUQ6I/UPwogtEUt+d7WlKn0gG6oabLnWnVuKZgWlIdwblLZdQaW3wXiYf8JjDi
         kVaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMq8hgqgAFgK7dm34s8XiuX6KFUJZXNqH190jnADG68bZ0S9GbnQdLsAhGrM2Um7qkncmQ8yU=@vger.kernel.org
X-Gm-Message-State: AFuF++npjWLD1s+cPiHUox2/0rd02rJNcvGpViI6O5KtmKwtuWg2Z/zs
	7qut/UCRn+vq1VnBsKb0LRffeJyM1PBCilvp2FBVMNmhwDbSVxOVPUv8HnhUZYsNgIeaAqN02tl
	pW2Z60bxy9mRArZF6W9ZLoR6A1d0Rf4U=
X-Gm-Gg: AR+sD111Q163LDuri9Wqtf+nWF7OVCWGFW69azXM3Hz7gh87UQje28z6WrcWVRp04iX
	KWPpGytbwAT0w6ECtwvTt+hmyLQkNgmJ7DynFbSo8nl+ekipisJ97MM64zGzNHtRIPKZVFGECc7
	Um7ZFrUkuLOKU3T7jSeWNgVXUlgPPbrFH7CjUt8klqszHrYs0jB901VGEorqY8YpVsUInSS7sd+
	TDet9zRJWI2sbE3fYyanDig7Q2PFNQf9cpAs46ew1PNqQBPLvZ28S6xdoNADZE5vzmuOuXwcHOW
	n32AOkYycjD/3Ww5Y8Npfk2trMamsR1EcVRKIkm8qsS+CW8lOgNSkBZ9wGmX3cBfnBqI+Wk5EJZ
	KzDDewjwGrhW1MS44mxkN+z9SkV/mwigwCNAKIVLYofolX75cVQGylwLaKcQayFcAbUaEJTqbpL
	H4/Uxf1fAx/W0sRg==
X-Received: by 2002:a17:902:f70e:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2d64afd7c86mr244956595ad.11.1787389681421; Sat, 22 Aug 2026
 02:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820111416.97917-1-phucduc.bui@gmail.com> <GV2PR04MB1173976A5DA80B2816493C84788A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
In-Reply-To: <GV2PR04MB1173976A5DA80B2816493C84788A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 22 Aug 2026 16:07:49 +0700
X-Gm-Features: AcwNN1VGh6KPneuM_bjYGwgQLpofzFqg25qsf12ZcvTaHcRYfF44Rr3qalHtEew
Message-ID: <CAABR9nFeaLMzk=2_HGvCktZwU7DmNWsHV-vHSBGwbWU8k-TLfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: fec: Propagate PTP initialization errors
To: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Wei Fang,

Thank you for your review.

> > +     if (irq > 0) {
> >               ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
> >                                      0, pdev->name, ndev);
> >               if (ret < 0)
> > -                     dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
> > -                              ret);
>
> Why remove the diagnostic log?
>

The reason is that the error is already logged deeper in the call chain,
after devm_request_irq() goes through several layers, with sufficient details:

-----------------------------------------------------------------------------------------
return dev_err_probe(dev, rc, "request_irq(%u) %ps %ps %s\n",
                                    irq, handler, thread_fn, devname ? : "");
-----------------------------------------------------------------------------------------

Therefore, I removed the diagnostic in this function to avoid duplicate error
messages.
If you prefer, I can keep it.

> >       if (IS_ERR(fep->ptp_clock)) {
> >               fep->ptp_clock = NULL;
> >               dev_err(&pdev->dev, "ptp_clock_register failed\n");
> > +             return PTR_ERR(fep->ptp_clock);
>
> fep->ptp_clock is set to NULL on the line immediately before
> PTR_ERR(fep->ptp_clock) is evaluated, so PTR_ERR receives NULL rather
> than the original ERR_PTR value.
>

You're right. This was an oversight on my part.
The error value should be saved before clearing fep->ptp_clock:

---------------------------------------------------------------------------
if (IS_ERR(fep->ptp_clock)) {
        ret = PTR_ERR(fep->ptp_clock);
        fep->ptp_clock = NULL;
        dev_err(&pdev->dev, "ptp_clock_register failed\n");
        return ret;
}
--------------------------------------------------------------------------

>
> Additionally, the second patch can be merged with this patch. There is no
> need to use two separate patches.
>

The error propagation part in the second patch is directly related to
the first patch :

------------------------------------------------------------
-       if (fep->bufdesc_ex)
-               fec_ptp_init(pdev, irq_cnt);
+       if (fep->bufdesc_ex) {
+               ret = fec_ptp_init(pdev, irq_cnt);
+               if (ret)
+                       goto failed_reset;
+       }
------------------------------------------------------------

So I agree that this part can be merged into the first patch.
However, the change in failed_init is an independent pre-existing bug:

-------------------------------------------------
 failed_init:
-       fec_ptp_stop(pdev);
+       if (fep->bufdesc_ex)
+               fec_ptp_stop(pdev);
-------------------------------------------------

Therefore, I think it would be better to keep this part as a separate patch so
that the Fixes: tag can correctly identify the commit that introduced the bug.

What do you think?

Best regards,
Phuc
