Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6C524AE3
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865023; cv=pass; b=VFrb0jl0c+u6FDD0rCTIFP5dOXRGqqA8ESnlW2X2Jzida9yb1SoTTYSPRsQKUAcQe0ca+lR0PwoIoyO8JXmnCsiPIY/22TUB+UiXcCYJCQ148rhMtzxzSG9u2fVSX9u5qRLn5b7jH7+tbRDSip2+M+4/PH1Q0Yqnjw+3evl2rxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865023; c=relaxed/simple;
	bh=V8PNUIhnuSxMXu7bv/hFvQS8+NwLBC1vm1+K70T9sIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYRTZ9wO112aWQkveqMGSsy8ilujN8Jx+4yGG14C+gOShgg6DqRMLupeBxvgGAcKCH2YNbt34sgo5M7H231UNVPVDJ2NAerzLgqiDfDta+UvVhR2H3enU9KX1lGYu/jd7N0Lge8SicgILRdZqN/PkhcCPCH9LEBNGxEh9tj+/fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJrfD3ZR; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJrfD3ZR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d01663d816so31205785ad.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 03:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788865018; cv=none;
        d=google.com; s=arc-20260327;
        b=BmGqwwwfqHOAHmvW0CdMxUK9SGn2QDCps9DXnEJjwiv8EPQaWf4SSeHakJWoNkuV1v
         jM202mAyi+S04drcR+QUxc2DyF1WLQ6qu+pgDEasIK7MKVRpu0ve2tJ28JNy5b/XUstJ
         /87q8bklzjcGLmBKuOmE8u1uttatLaP8hs9z/v5OSOSnGQn+hodMXFy1q85sihiPUDT0
         tXs+fbCCqH588ztjK3tJFWU6CuDWIu/cdyKUs6dqSWfub6xzqWLSbyGAqiEHSXgiFNAF
         ng1C6BWxxw+hZP1qTXdCsChLJ/ELjbOLuLeDDpBKnt85DBkaUbNBDaFJvMrqM/QfGo++
         J/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j4pKWv8axLBCBa+7S9xcrFVMWNZcwuk2DrI/wzHOezE=;
        fh=xHHHxaBOd8L6ZXd12jlc86yN51wlYBH08vy9AJKU6Tw=;
        b=ktjDBt5PqEUU2fxuy+DQ4Foz+acDXR9prUdDrpeNOE7u9UJdpEWVq/mPnc39IL3xrj
         MinWacLf0omOaVIfnQhbcJN3HkdSVd5gllZ8juFoHQTGoIhsgMlVc5KLpluF9vffE3GQ
         1WIeTDDSjqz2SoATupSTNY5rY7LfloK3DB+rafhDzd7OIsLi6r7YctAydZBkc7GsRec4
         MylCONOpd7TbuFrSIa0LWaJgI6Uqh0ucDxTYOCdqfIkJfxP/+6d6scaGMs+q7rCUJlWu
         Z31Wv3WsSCCo5MpPNN4e9LWadKBWTK/vBBjBNEph3SbLsuw9qvKpTSgkorueBnyJuCr8
         oYKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865018; x=1789469818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j4pKWv8axLBCBa+7S9xcrFVMWNZcwuk2DrI/wzHOezE=;
        b=qJrfD3ZRYCitY6Rv54OkP5s8eOZ0Mya4DkRlrfXzr1FqMXG68PrnI2kpFOSfpTdgpH
         jHBVVPCtyfwz2nc+pAyakjca5sZH1bxNsn0fej5//XzH059w0Ra1BC4rMlhPnL7v66LL
         bEosRR3AZ2ueKBSxub9uNp+dvZIrUPJLmr2Ok1JnFkocp5XugHYkaNRVqw+7sD2TJWj0
         IT4sFK/PWVp4sakvccgVYAQnxCyYaHt6bK0rXmO+dq2GfspQWR1jEYZ4PdJ6ZPehKECg
         w9jU2FZnu7xFnjSgMv79aEgPEcaLIGSjYZ1GDpmiF5eFxwUL2u5c+DPikYNZC3rwMPKJ
         9epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865018; x=1789469818;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4pKWv8axLBCBa+7S9xcrFVMWNZcwuk2DrI/wzHOezE=;
        b=NYCbXUlo8GmM2/ml3mUvZW/Lbhjfsk78TD+zB/lFzQyJO/+H+8IN3tvjLu/eQGiPda
         jQLTRR+/h2iBIHeuA3spMbpp+QY2uhbxLGp5/Hyn5R64VoGkkF3a8PSBbILvYp2MHTYk
         dFjQDCZ7hetGKGjgowLpwc8QeV++Ew/w5GWsbOCpl5i/Rwjylavh1NJGEoUg/29iRlJc
         nVbmVapUYMBwONGQvPj+1qSwHVkx20S39rIiW4s4z9mlSRWFIXW9LORRNsBdd/G2/NFu
         bB9r7HydJ+RUfPTmCC47CQdOabNwy+bXCJZnQC+wOe3yXuDjvdfnMVZSfmfMz7DVp+Sb
         UVXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmv0LXqyxpHpb5RylSikNL1y0rUPvMhDXef1D5+X22bdDlipDfnwUDkCZlABWJgaLlGq2qKUU=@vger.kernel.org
X-Gm-Message-State: AFuF++lHnlRKUW6JtMS8In38FPKKnC9vBwArWgH9HCebjxFc6b4oMCmB
	kn9LBrpAiLQOmy61ssv1t5nZE1jc4tChjnqv05ArgRm8y8K+L4n8O9uydhukL4/DSb7L/85WRXT
	/dGp1ZgMw9E1yoL0qOFNtfNucCm+i1bs=
X-Gm-Gg: AYBFou3C/HggBTP3nXIv2b52G4BQ4Mfajz3sflHbl15RoIQqYWB6bx/C9dLuvWgl5IP
	BSKHdgigoRFR6UhR/yvnu7hMRn1KLpsYUAh/7otIf4K5YlOntwRk5DDq9jMMRntQ6M5qkmI8RM9
	qUaSC+MeatwKWJST/pu2+OGCm9POSb52ikKq9cIynOLGx2mrJRYoe2NNRYoQXt7RVDxW0vlBQ+M
	iBqQNkkX8h7HIqVDEFCNhyieWsvKUx2KY/ZcoF2E+T143oKs3Dv91zb1F0MK4E+zKG9sdBOWfxD
	JSPPce7Bo5DGstxDTJWqS7RtJv4icO1EViZpybiW8B4OAFKTWNA6bhkp2tzBqRuHxZ6+NBKbsw5
	bDl8WEhH+XQN76UsyyewCGNCo8BeOXgqkN5Y02++B4fwrm1vDqehLHtRC
X-Received: by 2002:a17:902:cf08:b0:2da:f8a5:afd8 with SMTP id
 d9443c01a7336-2db1220e898mr402860255ad.0.1788865017806; Tue, 08 Sep 2026
 03:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903102656.370039-1-phucduc.bui@gmail.com> <178882012336.219967.15894359577050376625@kernel.org>
In-Reply-To: <178882012336.219967.15894359577050376625@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 8 Sep 2026 17:56:46 +0700
X-Gm-Features: AcwNN1Xbg2lp4fbc4ezWtbMEH7uw5gip40oD0YN2_nVZLMuXLhJFxllUnLeYZN0
Message-ID: <CAABR9nFG2Mk__ptdWrhkPTTmSpnL8keaHPGx-wz+kgck4EDFhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: davicom: Propagate wakeup IRQ errors
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, paul@crapouillou.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> - [High] dm9000_probe() now aborts the whole probe when the *optional*
>   wakeup-IRQ setup fails.

I agree with the issues raised in the review.
Since request_irq() uses IRQF_SHARED and can fail, for example with -EBUSY,
I will address this in the next version by only propagating the
possible errors from
platform_get_irq_optional().

There will be no changes to the existing handling of request_irq() or
irq_set_irq_wake() failures.

> - [High] The newly added 'goto out' after a failing
>   irq_set_irq_wake(db->irq_wake, 1) is taken while=E2=80=A6
>

This issue will no longer occur if we keep the existing handling for
`irq_set_irq_wake()` failures.

> Pre-existing issues:
> - [High] The wakeup IRQ requested in dm9000_probe() is never released on
>   any path other than the newly added one either: the pre-existing later=
=E2=80=A6
> - [High] In dm9000_probe() the shared wakeup IRQ is requested (line 1521,
>   IRQF_SHARED, handler dm9000_wol_interrupt, dev_id =3D ndev) before=E2=
=80=A6
> - [Low] Documentation/devicetree/bindings/net/davicom,dm9000.yaml
>   restricts 'interrupts' to 'maxItems: 1' (and defines no interrupt-=E2=
=80=A6
>

These are pre-existing issues and are outside the scope of this patch.
I will leave them unchanged.
