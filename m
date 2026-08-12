Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498613128DF
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515293; cv=pass; b=Cl8gZhOTgLNZEQpgXaQ3R43BsNfamtbHgFUaX0j60GNuXiDDUPzk80f60e2sGe4cHYYHYGM+Z13bSYxWSjsHxJJ180Ytwc2y7I48LYpSpVcusMGYSC4mx/J+vM1s0m1FXF8rAQ9UR1pTykuWSDQ3IoAqWiDTz+t0/AbBS6gQocc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515293; c=relaxed/simple;
	bh=gpqdIXWurtNmFZ/FFlmQUckin2s0Lf8qwDro0RQ1ooc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2CMzTpVvamb1EOSu+1Al6nc77r55IKbhhczXisG3o53prUYas8b9drcBXZ2Z1uDaAPazFqb9bnMUwczimCE6FqvPuS8SM7tT4pnzf2ZLc9ttOUWi9qS77tF8uUzDjFbtf97muSHq9toq2djuEQ0vGMc6WWKXGg82o6jPGRfkIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvi/WjMs; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvi/WjMs"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84847482584so477158b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786515292; cv=none;
        d=google.com; s=arc-20260327;
        b=EZvugES4J5OSd9+leExcoteWGzSW1qtjPYPOqOwwFJLpgsCG1egrifFD/cNI9+kFN/
         RX/1tJmvmotzyCh/v5Ct6OFIt26l4JI559N3aLeoFvNcgj3N0dEYs1WOWHec/EQmVFdG
         5I7uyeKZBfXLrgXo/H/7iw4MmHd/QKPj5nW6Zu1cv0hDn518ashDb5J1yffyUZwPsTlx
         32AvnS6lbvv5ECoXpJo37M3SrOlLK2ENiLa3uj7jeacXEAf8Iy0QPXMpfNLV+hLZecGY
         qzb/+CTtjSwFV8IbZMA/D/9Qot29nEiuXf8sBdIH54jU5eaChlNjQhcgqdkdRMVqqtr9
         p17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OGpcKaZyDGIQV074XSBk8ZsfBy3nSYlr/HYg40wKCL8=;
        fh=b1l1XxlNaymTpKYaQvD3KDnLWFVpzIhvrTQj20YoQLI=;
        b=pIcf4Zaz86PDQlG/kVx97SKH8eT5IupaHogxVshgU1t/VE/zohZ80Ic7QM06rYD7sM
         Xz7E39X/2mdNUoYI8iuxJ+H5pdmPmRvucTbcaf7yYRior2XSx9OqP+mrx8K2vKWCtE1s
         lcFmb/Mp9UVugf12jWaatQzbMl+4cHyydAXIk1A6UPVxie7ch64jh+WnDkOSB88QznEG
         v2mvj6BSthKRcUrRJFDtpzIjlxFKoksMQOX0Zn0+cNaO7+I+8pdP8VilwuZ7Fe74wlr9
         Mq28RTXlFaMAabeYIZhRpQBHHAzdONiRNoc3qziDdn8QS9Yx6gRqNgpdTJmFNntEAjVV
         nksw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786515292; x=1787120092; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGpcKaZyDGIQV074XSBk8ZsfBy3nSYlr/HYg40wKCL8=;
        b=Qvi/WjMs9u6FaPXocJrAsFAqU3LY9kslcvw5BEiz+4fK9j4yD8tmkGnxbubpTPCFQk
         fXuYltd9eTUsIAelo3FmcIc/z30KAkPyvx4pmzd0yymEyeau04yVG3QXxGmzxpBzWOCh
         OTHv6o/pwW+mmlP8fYqlVQ+MFlcl/rMp1D/SgI/5FNAdjr1tcwH+dJwRN4RaSBtFvEzM
         DtQx7IlVgZIZbsG6dHyGpPpWtNgNod5kXaGDBb7VFocHWOh/C+2BQTZJ2PkC2DZq8Yyh
         k0Gy3wcz6kRAxJYIv4YoDng2eXm1aqg8gpUU4kB6PmomOmn1CsXmQNb83JP7EYZN5wuA
         BZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786515292; x=1787120092;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OGpcKaZyDGIQV074XSBk8ZsfBy3nSYlr/HYg40wKCL8=;
        b=WCdJkyVSKRrmlLnDQHwyOq5GyuKgKYtNtqhK4ER2KfE/0eBD4ydcYb/oqey9Pc678P
         WDRkRogtSCseWXpEBJHwfwYHCypYBx5oo3lh4eFDI24NSSkFxkgegtPJ3gck9i8ZYBP2
         RpFI2SgEeZCp4i1f2+wCUrn7HoBsGDaWJuHxxKlCALe4Y5w9s8aJoTMcXhPMbfJ7Bi9S
         IXZ5cu+CotTgH9K009U48JlWYvskuLQJeEwpGj0tlxgRHTL0gAsnFbT+/A8IJVrYaCA8
         fKFePkz5MM2/yTp6gfveAHZV5D9WK/20OQEDC1w+Ges625goTOZgjd5EJh5eg3ww0LfJ
         vlfw==
X-Forwarded-Encrypted: i=1; AHgh+Rpe5FqYYn1YD/YIopIueRDi4t/TATV/VqUXgpCuM6E4IPBY9B2qEhYECiAEoFl2p7SKVrd2dl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpUdvhjdW9Ar+MpGChjwM6gV58+NanEOu1L54gA5c4FzzoKd0
	g2khiT2kTcqDITjINmkYikre76gZdsQa0xuOgk9Rp6HistAFFM2evLQT99r7a+saChXQoocdcAl
	fHuxyPnTFYCy1pWBGtWaFAYjkKvMcoNc=
X-Gm-Gg: AR+sD13p48LTwF6e8viUMTm4RYkppY7oWLjXUYkISknxUQH/rUIEXHGa/hjwRX330CO
	Pgvwh/SjqwWF+3PyLAj/Urxb5IxBcq5MWZwXRghshZ6DWGzOsWlkzDwBCOSh/djElBAPPsrIGmx
	yE5aMyr6VHvlVeNosUK0N/2UFziLiCU7QhC9zu4Q2P62oGBuuI+WymMOEpjvm3/0vBPFOUcLd9t
	lxbB9yYQtSJ3RZcqTQ7ce5E3AjvpmurGKFw+CIPrcrtbFo8xrMlCWkDRT9HIhaytZIfOcgLu8kf
	ebW8LAULIf+SuOOEigLtNG8YAsutj/QVat3kAFfO96DAGaSIPumMBFZzIp+W5S8P5nc8rgmOb6t
	T5JJk6WaUUopF40r3vYaXXzW5RIhNlAhdwzfW+1wi1XAKIce7czhxWH84
X-Received: by 2002:a05:6a00:3a26:b0:84b:e69f:1b3f with SMTP id
 d2e1a72fcca58-84fb64a72e2mr2017392b3a.8.1786515291613; Tue, 11 Aug 2026
 23:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811034715.6034-1-phucduc.bui@gmail.com> <81a38486-d4d8-4ca2-8d22-d3d178c17665@lunn.ch>
In-Reply-To: <81a38486-d4d8-4ca2-8d22-d3d178c17665@lunn.ch>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 12 Aug 2026 13:14:38 +0700
X-Gm-Features: AUfX_mzER_EgLNEvpTJmfvYgwL3eK_-FLtBiAbxBe6igcUypPzt7NIe6sQB_xgo
Message-ID: <CAABR9nF4q=eyUbzmo6-Co7NfVcg_bufHnffy8Ho4ZehHFZpqJg@mail.gmail.com>
Subject: Re: [PATCH] net: xilinx: axienet: Propagate errors from optional IRQ lookup
To: andrew@lunn.ch
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Simek <michal.simek@amd.com>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thank you for your review.

> > platform_get_irq_optional() returns a positive IRQ number on success or
> > a negative error code on failure.
........
> >       /* Check for Ethernet core IRQ (optional) */
> > -     if (lp->eth_irq <= 0)
> > +     if (lp->eth_irq < 0)
> >               dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
>
> What has this change got to do with what is described in the commit
> message? If you think this is a needed change, please put it in a
> commit of its own, with a good commit message.
>

lp->eth_irq is assigned from platform_get_irq_optional(), which returns a
positive IRQ number on success or a negative error code on failure.
Therefore, a value of 0 is not possible here, so changing <= 0  to  < 0
is directly related to the error handling described in the commit message.

Best regards,
Phuc
