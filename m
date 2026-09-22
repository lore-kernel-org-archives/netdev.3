Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D9366553
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043216; cv=pass; b=FdDk67U4hB8zaI5EmngDmcpvKsRF/DuWRS/pVMCpsygajL/cF21HBBvushZMcLO8tLDKm/IG5wAw4UeQPfPJEpfCZ/BU99PaJaPk58TMYFle0A0WFfbigK0Llnsu00aj4LKePJw6VJdRyDFnKtx14+w0+KrLBASrAlN7BxnPNZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043216; c=relaxed/simple;
	bh=Ap/YzZGyzo2cO+qILnS+HOrD1LlO3Fjr9oA3SoqgiQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnWG/fM1E+tFWO1NvU+iXyf/ovqRP+GrZ9s2Z44Bqe5NRWEEjlm8Z/osAnBm0iYB7nVUH+GC4cIoL3s0lu+zgQnyj0iuC8amnjrSk6tDROTC5fTe8nhHqwxhNjz3sYn59jZJd0QTJQRblEkX/jjCjjkuaCs9Ynw8qoKx0vOzjlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn7o6r3g; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn7o6r3g"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201f9so3143735d50.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790043214; cv=none;
        d=google.com; s=arc-20260327;
        b=fAklnEwVy2awiyXyGiV86vK0umVx0RrL3do10ytcyhTpIFMPRJfZXeDcaa5RfBdviC
         NecU+QSzESjU1NCFIYQLX48aYeNcNXOcp1G8MBhH2z69QdXq2NNoyr4fGzlHsQP2YblM
         3FhTSoz9SZaqSM/pl4hdSWF8ym409RWR1g4Nkrsef+Lf9RZniBkv39XiUifldSi4lOrA
         WcaS4XYV7BThhLX6PgBOAN2bpT2PZts/8TQWtgMQEMHt5AgoWuo/GwQqMQg352nVjHjg
         vcx/qHwjFo94ph+qgrAFRUtQ0b+qc+kdSYhxC6t0ER4KRRrv7r2wiHhWBtVdi5dNBSYr
         NbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OCxAavhsCK8ZFakY3+2+r6Yw5rmMKHTrZRwA8H/yqhM=;
        fh=WBF1DAhtllOMUioA5laWXKqIwCKkATP9IAub44Qo+SI=;
        b=OaCD7BrmK0SXxJXcbkI2LKOoWDGsWqFXqdhqJlyeHMAwMMU0SbF0hcR4CMo5i0PITI
         7lpsuW7ewzw7fGBYjWCJHvv2EZdBXN+SKNdOHgO8fSuZKgf3fYpM756hLY4b5TGG9Awu
         +59BMDT8d6F6OQecd5La17/ESYecia0JzqBF1Jujf+u9d7QY0xwBYqLaDovy7W7lmHTT
         btUxyt4F6xGfCRXDCPW91rhR2F84+wrOyw061DTBMf9mPtorfjwXARFtrgtb8OBk+7j5
         tlIMi/cE8ya50nvhN9yVoCCvn+CUF2YWq26Ck+fFmMeeg+5GXvk1CuyuK8QZ+/lc0sG/
         Qtog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043214; x=1790648014; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCxAavhsCK8ZFakY3+2+r6Yw5rmMKHTrZRwA8H/yqhM=;
        b=cn7o6r3gMueb+t4GKFvoTSxKU1SJovRPQ+4SbRkDpdy3j/ZIb/rqwd8WMrH0u94Gt9
         dzrto80zXH5FL8YnwxOAAyG2KHbw6QXO9XnR+iYVc6kQxrxUUhSNMBPdaPnM8laUPYW5
         DzAkkf8yeyLQGHxr//dkZNYMfXhGv/bAgEMFJp1g1H8K1ytMAPUq6LZGSHfAE6prNAnF
         V54tcvc1AMnt3aBhOI2QT7UDypM9v3QVVTnTUWwHIapQfQmo9r9gVmLHX5TeLGHzNzHU
         Qnw23dIP/MquuXx7AXzJioBQ2Pr7xOOiDOb6oDFkKEDhrZKUJUeJTSqilIl0LKC+7l8V
         p3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043214; x=1790648014;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OCxAavhsCK8ZFakY3+2+r6Yw5rmMKHTrZRwA8H/yqhM=;
        b=jgAcUnLJPF4YFF/gVeYQiHK93tq/LvZCLrB0m34BxOXb7n88aQEZPfFoOUpNQfvYQa
         /lO/gBTB/WKZZi4qBkOA+lfXXMXtdS589P0OzKGOEo59FfAMMsnxGsQa68u0tH5G24kv
         xjxLmgsr8h+ou3I8i/yG2c7fFklcWU9vyZ6fHU5XmofQLSkPkSCgtv75fGUr02wg/r+Q
         DQTtdYOpg4/AQSXVRqiuPUyULKeOHzaF26f8Lb8I5JKKkO/sgMDhePauhFBL+QWJ0f8G
         TWb6AHw44BWPlzsNJ5xZ3bqrK7YmohdcRTIGdTLZYjukCIqsFNWD8xEp3+rz6p4vNAY6
         +q+g==
X-Forwarded-Encrypted: i=1; AKwUvBy9gdvXY9M96K7pz+el68pqw15IGsbNpHRb53B1Tb/S2iz3PRaRVRQ91mw9PXowYI4emaAKgwc=@vger.kernel.org
X-Gm-Message-State: AFuF++lv5rPlHgrGUrFyUILy964D5DOfGQkolIzmgiTQChYwXNd/JFUT
	lOYGBtOG+5+5WrVKAWxYFb1svevixY6SkOj4xWHyZIe8Pbo30wDjMoFDs9h7z0HHqYM7eHuf2P/
	NwnIt0MYLc8GTfC/IucQ0NIgKpEy9Uig=
X-Gm-Gg: AYBFou3nPROfCZo5w3q1IQAfUHLzkfb7tMRNk3EjoVcTZe9gEk7avzud+7Ioj5chRk5
	TOOjXsddMCzqUJUsbOz1+ADI3SALygb7N4+xrD1C7/lfCDnHSaE3kyHm6Mts4RUoYwP1vF06uj1
	HpKcCCCk/aqbYBzEPlyIng16FTv8qSaB3ONZeB/SkQa/P4dWuMSMsEWOWEX/DSksHhSYeg3AxIz
	4Mh5ycBoZi8dbyqEdQWgbx5gWSsFadcsHKNV7pWYfIcFKtcTSp9xeauckcgYBrSyCTKyiqiVMgo
	m2LSopC0DpuHsMKk80J2TDOfPlJSU9ck8TiEk46MDnP/uBlaJshyYPKjmA==
X-Received: by 2002:a05:690e:4192:b0:672:99e1:11e3 with SMTP id
 956f58d0204a3-67299e1168fmr2220506d50.128.1790043214123; Mon, 21 Sep 2026
 19:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916063118.2924049-1-lgs201920130244@gmail.com> <arFJ_2HfXWuWCsUO@quoll>
In-Reply-To: <arFJ_2HfXWuWCsUO@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:13:20 +0800
X-Gm-Features: AcwNN1VtWhrPTDbeTQKN8w96m2efeF0oPfkRnX5dnHLNyPZ4NdQAmU7V51gzM7I
Message-ID: <CANUHTR84U+tLdA6SCqyB9p0PnZ_Six0nD688goE9q8K2qvXb3g@mail.gmail.com>
Subject: Re: [PATCH] net: wan: farsync: disable PCI device on removal
To: krzk@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:15, <krzk@kernel.org> wrote:
>
>
> On Wed, 16 Sep 2026 14:31:18 +0800, Guangshuo Li wrote:
> > fst_add_one() calls pci_enable_device() to enable the PCI device. The
> > probe failure paths call pci_disable_device() to release the matching
> > enable reference, but fst_remove_one() does not disable the device
> > after a successful probe.
> >
> > As a result, the PCI device enable reference remains unbalanced after
> > the driver is removed.
> >
> > Call pci_disable_device() after the existing interrupt, tasklet,
> > mapping, DMA and PCI region cleanup to release the enable reference.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/net/wan/farsync.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>
I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
