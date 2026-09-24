Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02B488D92
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263063; cv=pass; b=u2KdseGfsPvFnHmZLDtafJrcNRfnyBF+CYKocBX+M7piSQl14d8nkrY+ZFOlKp4jJVAspbuzPGc073EzEQGot9AO8GlbZBxa5wxTwxgXvWel+Mw27+2BL/94aGVfQQjD8bU6mNLHuaGgaKTQZZGVChDCbzQacAILDjdnhgGZCKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263063; c=relaxed/simple;
	bh=1I1E6wRdGsu9y/k0KGTrAucA4SvUli4Di21FGjhjaag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r517V3dEPTavHMZz0erwxUyq1mVk3rWRYOly3TENfAyzt+yJEwfaV4q6ee+xEK+RCCUmhiSF8FZ1L2+/ZABmbByFFqT9vp/jAHqCr6QLF0mPUvLLnnAGZPzMKw9bpkaPjMl1ux2pwfcNK8Z3TUT9gfO2wfq9c/XaA+Yf1MXQ1V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mao1aYaa; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mao1aYaa"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8a7af43a358so5286697b3.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790263061; cv=none;
        d=google.com; s=arc-20260327;
        b=nrHoaqOD2K4OaJ8EAXpv+A5yich1ymBspAnezhNozyYUx4jug7mQSr27/H8dhSeEUM
         4pXfl4A/gqx9GtvYgy6zRISESSrYElR/eSj2Lv1aaW6/kcd3Bu+as68ozch9MjQJIneH
         QdASJiQhEBMV+MFLlQMQPieLamvtou/ELEGeiVPaOL6QdvboVkVUGV+zjGtlMs/7j+ag
         yFwoijmCgObPqg3v61j8J/atvmkhBauV8Sh5kovJvJ+JqPFRUjswdvK2Df63VuI71+kS
         tR4H6s4DStwdayneffl4g+Wa5zgTbdNWYLsEcFL/+eMb4QndPUGo8/lxeS5RKnF9vgqr
         VkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1I1E6wRdGsu9y/k0KGTrAucA4SvUli4Di21FGjhjaag=;
        fh=6tVDxTgyu/Z6wXo3PdIDZcZ1qPpExDJJ0U7jpD+kRKA=;
        b=J02HK2yUCpTCN8BDVZCeGWz7yDpUvr46lxycb7Y8Bvp62PFMwFzMqpWzzC12WxKM7H
         M2p6A2NO+gKQHsDq6sg1bksPUv0uZm6TWvGz2GyyA4Bh6nG8wfOXlpUVM8cIyY3wKfBd
         wkSnIs7e55Urxm4i7KSJswrfTKC2JWnpj2ei0xKsz5omuV7IEtD4iRMC2KH2ffAVU9ww
         yzjAbL1eqyNQM6rwZjZ3ND7Rt3lz3RKV/GL9ZLUrBg167wb44NV0el2g5NVKkbGJ8Vui
         eRxXorn9tvOWq0NqIvOaL9HLCk5ESbJ5mE05UxAASsILHqGOsKCqWOXtXn/KAVYEnora
         ktew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790263061; x=1790867861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1I1E6wRdGsu9y/k0KGTrAucA4SvUli4Di21FGjhjaag=;
        b=Mao1aYaa1DpJhX2AfArQ6GlARc5TV++XuqsFTFE2rBTs/eoPekJEzJJXAvoaklyNPX
         f7LblXx9i49KNWi9U60NNjBGH0bbQqtJ0YrGtM9Bd2cYeDrLYvYZtH8Tykw/l0n4WtD1
         oWyBAJRLzT2F+LdPbHeEd0PeLsQ9+NvuU4UmQbey4Y8Adt+CJEf7K8qCA7WUpW9A1XA0
         gR2HIGqI4QCbo148EE+nJF2qq2TWDavpuG1GFW6dBd/Mw7RydULmNhkr1RFWx+ci1nrE
         FeSNtpQ64rd/yzBv19WP/NA1JICBsXy6MMNtvAHF4pA6h5NnUZTb+aL1f9dHlTk365/M
         YH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263061; x=1790867861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1I1E6wRdGsu9y/k0KGTrAucA4SvUli4Di21FGjhjaag=;
        b=R0jltVfzpbLMOsK/Pdjn3k4klTcGMo9JpxI+fAiQu/xUQ9igZdbe3mt2sN4Q65wQUf
         JltyZ4Rkg6RZNxTaJjpJLybc5g8yAdPOW1bhbSWnCjZ3xDjDkWF5McFKy8UxDyAEM4lK
         qvuIP9B/YhElR/P7NTh0b4JuHbq69hHCgL9P/fbP6lfb9BXMLBXlUnLI3PruamuvSG2O
         /L8i7ezQatfNM46v+jePCe4N9daExbXwdUprboTqY6574luWz2URpSgItwHJKNmCJXfI
         z/QcE0iHZqMCx99Fnowh1lb5eIzN4GzHYdoaWXOpoBCjXZKZKyBoaVthz+WIgyexleLd
         sveg==
X-Forwarded-Encrypted: i=1; AKwUvBx5LnPWun5ZdVUlsk+Xbkh8zlJE8NtnVAugxv6KSX5ZO0uiQFAQtuMZRrX8IbVocr6Owcn/Zxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKn6Otx60TW1CRaowR/BRCRdBk2m5D2adM/htIEN2cCmIRJA+jJ
	1BCMN0qoWCa/8AVhwFT4wnkrYmDy25/I6JAxv5CsLJHSoxW15oFrnG5NGS5BYyzUep6k9Ayn5XH
	4AbJXdFtdYOCFuzg9GilAKuWVbf9DG9G7pjia60t/jXyb0tbxCXLqHc3h
X-Gm-Gg: AYBFou2wRqag5DYGqxIFK+N1fQsKV9j8+9c/+ZPrLQzF30mJ8u82XCrX0CBwOMOIxAx
	elSGV3Hf7iOJdHqnz/oPfobGS+8Z5cYWcyVKiAtK7imyLwXQnhl8TFTZ9JJK5gFV0bu1kudNrjk
	/3Ql3EZsl1Fbz5LXCVsvFb0QVueoRUI3rZWhRQF5ytK7lDWhAOK7OOndzjRJPvfB/oO32Fh6W4R
	aPT1xznVkMyXBmw6Czh5FUnG/bpDA97zG48do+t39zdFcwy3yGnty+RwB1HaCMFoV6z7sFw66zF
	3P4fe5Qz4KXye5jtO8x/vAVMFz2e4Wmqb99Q61Z/X2zHsGpSZzU46FWEDnXC17Ao4tTMpmNv2yU
	wQ/7Ae9VvOqDcEAwr0vCRIwqM6unNJCqZHgfCo6bUp64rNkKHnDvaBqW5WKsvTbtsAyjx
X-Received: by 2002:a05:690c:7487:b0:8a4:ab7a:a1bf with SMTP id
 00721157ae682-8a64765919cmr21887247b3.22.1790263060029; Thu, 24 Sep 2026
 08:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923223545.3815583-1-kuba@kernel.org>
In-Reply-To: <20260923223545.3815583-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 17:17:29 +0200
X-Gm-Features: AclHuK-7Qe44Sh_0wKYz3clEGNb6K5bExdxDCwvFVw1s_BUj8yaIwDNfzvmObp0
Message-ID: <CANn89iLwPTnjK4FFdOXj8VqLsr4zHOjp3KYNP6iOYg6=iOj4-w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: use a single lockdep class for the
 netdev instance lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> netdev_lockdep_set_classes() puts dev->lock in a separate lockdep class,
> by type (netkit vs dummy etc), with the intent of keeping the instance
> locks of individual devices as independent from each other as possible.
> In practice it does the opposite. lockdep only calls the cmp_fn for locks
> of the same class, so netdev_lock_cmp_fn() never gets a say when devices
> from different classes are nested. Instead lockdep records a dependency
> between the classes, and reports a circular locking problem as soon as
> the nesting happens the other way round, e.g. when devices are unregister=
ed
> in a batch.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
