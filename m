Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784C46EF9F
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129993; cv=pass; b=OmjhpUClK7R4xsF4J+jQRyLuDLHMkdHyFwmMhkT/AbhQXYG10HulHgRYqMew0RKbGgfP3fdXn0hSPmwxY+VDOLsT/3ad522jDlOEFq6pz16k59409IzHPDupSVSgw9tC8TL3cKBhf8Coat8hRLX/3EO2FhVFQGDWtFr3LwvvpQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129993; c=relaxed/simple;
	bh=03tI8r4SjmrucNW3FxoNW8oLP/SeEOOAqBM5N79UCug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbUjurmBAPq9RuF6m/2+vQCDm6z7jwOiGT/Xy5RGZzX659VmX+HPYpME97jt/SN0E6AqlA+O41xKsFtrBw27CF36N8VfG4dg48jdDht4X/YXCRo+pt3/VIVJNsaI0eohNC4aYQ2rHx6M+SYD56R7HPnr/6k6In3HM4+eL6/oq4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOTfdwmq; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOTfdwmq"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4c14d66d922so421702b6e.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 05:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789129990; cv=none;
        d=google.com; s=arc-20260327;
        b=bavHbW+RcHyTr+/wokgfOCZRxCPk0epyXDb/9pDmIqoosE2ec3TneBikK6xKRBsKut
         6tq1bfaEvQRZj4zhVzoDShBwl+sN44VqhbW+hmDlX2Pj4/D1en7kzeOYO6GIFlscoiwf
         d+I8kMpzYLT8X7yWmE1Sn0fBXk7z7xzsrjgNhDmTI/BOMXn5ARZM56mRy8RMpTPNkuwq
         g5TCg18z091J8AACr8kVJo8cx3oDX1mp0MLq12e4TjBueK4rUsrFDYR/XAKD9Kec6zCs
         n8s0xe7yYuSdF9HmMElYlsV+VlpbGIWDI+9552tUkKxMfBjHDlGZllbqNUR6LFHHT7Lj
         VAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mSeczAilR4RJwTk/ZWwyqudf5JxWuEGG8/sw7pvO2zA=;
        fh=artBnBkVzPwm9iO1NNiH5QZwOcPl5xPqydNWWenpW/8=;
        b=dPbpeqGB//XmJCA++OINEOmUnH9v1VNcJcMpl/w32Ysfmmr3ZplWIz/wyS6S512fyQ
         x9EUmDeOLLT0bq6JTp0zg58tjXPRU7iHbixaqhllmfEQVM0Oo3yMV0ZCZbugiFtt76km
         0xzTtywkW59V2cJKocSPpf+ZhxZd8Kn8GH8e+gn8BlsjEdDZ0EDH6xg7iR2Xg65b6rYf
         LIPpOlmCAzPkeryXMU7hrZBIMQY1w+pVJ0v+L911G7u8OIImkyy75nIZPt1vfkPtOr59
         YDLjmmXa+naiONoYxW6Ru4YfkIAdcZv5HgcDMAxlDI7fJqayeTqEJvxBncFm4Q6R2fGp
         tnow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789129990; x=1789734790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mSeczAilR4RJwTk/ZWwyqudf5JxWuEGG8/sw7pvO2zA=;
        b=BOTfdwmqJF6f6zbJcWrGKiD0VJxo2Ea+him7H1v/HOhEewN7VSSMxlfH1LMLr3vTgY
         hhvVSgiJrhzb5v4hdaWgn7BxQ7lVYRCgfr/81oVtl67senvOkVpmt034qQ7amPvmKvF+
         q1BUkpx7n/0iGdQKQ8VtyBkmer/uI6zpLLABSknI2e0JnMjQQ7rHO2ghffUJ46D30cjA
         /576vb2Pm7y/tj2Yq8/03UgEnYsidxSvVN3PBmte9fnnEsq+btC2EhJLw3gou784cT60
         LDPiwenUXgZ6tRgdhxllp8qn++rULUDkUR/tdBw2Uq1Q646KKIBkZbi84r2BdK0xIJfj
         HaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789129990; x=1789734790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSeczAilR4RJwTk/ZWwyqudf5JxWuEGG8/sw7pvO2zA=;
        b=RHhy96syZfVS7fGzhqMvR5860ycQrHIpS2C4sR4X9VA38c5ThgtEx3b8Y97e0+hth8
         anPUJb7456qh4wbl+KTXQQgEOyjsjvLCp75Sws8QBWh1CkMEHkaXr05VYigj61uyUYrl
         QUe6e540BUAoryKa5Q/hOSARmAVydGk6X7+OoQQt8kr/8QLTgQalO57ECo6DIeaNBy8+
         J1ML0XQfP2uCg7+UIUF6mgcYrCIeY5W3eIrTTvwxP5NKvRXIe9a+R4Ioc/8CXCKff5ep
         0Lp7aK6MtnxnPmpONUyvbfdUtssEP4wZo7MLA3SS131YPNtbmIfGB3XNkeOVxLgGU0Kc
         f9BQ==
X-Gm-Message-State: AFuF++lPC+/wE+wUkhxW4RhyLAA4pGWGnDA+YWIyN5UbdL8H1Cx09iG3
	0DMdPmL3wtEsnKSware+malN2AYqZVGjBlRCHGXAdRUpi5ppqY9SUd9GqW86YEIXUt9DAS3Vcp8
	Ifj+YSacwgvQZeNVYJadyHqwCC8mnVtQ=
X-Gm-Gg: AYBFou1q6TfmokMfmEMq52Jtc5L9aLFGTl9gZdIZIkFOA86VCGBirfILHnUcVO6ql/L
	YYTPZme4PqWOaZniK/WLm5MfY/NN6Z7KnYzjkEOyiefwJt2Zu9Vw0Xod0LZ/Odqkk4oKiMC/Ote
	54wwR6y7OOyD0lmVI692LjUxYVVQWysTuunutVtAVl+3DauT+vGNzA42pTEVVTfNovY3sogWPxn
	5Tv3MCFzVT0LCtjdFiBEmR54Y0gc3oLsM/It7tHmYZ5SsH6mL7TZuxGD+HziKY31GeTcZZDZf28
	hlJo69+ZqjoxAbYE8vKhe/GUPd7ouWCESNSv9qy0o3YmEbPa92r0sg8Sr6YLjbgfXBvKEcIWwb1
	s7R7Ms0L7OXVRD76OhwtyZL+9i24YYQ==
X-Received: by 2002:a05:6820:c446:20b0:69d:a4f0:4191 with SMTP id
 006d021491bc7-6c0b9a57494mr1869587eaf.12.1789129990178; Fri, 11 Sep 2026
 05:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909190541.466476-1-mmyangfl@gmail.com> <20260909190541.466476-2-mmyangfl@gmail.com>
 <40e425e2-7d0b-4e20-9880-41e46ff340c6@lunn.ch> <CAAXyoMPG6s_z3g8fZ5CAF8BJa0OY7uzzO5PccaR6amfmYrYYHg@mail.gmail.com>
 <39ddc2cb-46c9-4754-99c1-0011a4cfdb7f@lunn.ch>
In-Reply-To: <39ddc2cb-46c9-4754-99c1-0011a4cfdb7f@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 11 Sep 2026 20:32:34 +0800
X-Gm-Features: AcwNN1XrdIHW7rGAYpHzilNP49ei_5I8KTagB7CK3QwEYAPqeS2TUQtky4XcYJI
Message-ID: <CAAXyoMMoX2rhjKKeWtxuid9tMSs956eubA1YXdpZ7AeP8Z=9ug@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] net: dsa: motorcomm: Split xMII and SERDES
 port masks
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 7:46=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Sep 11, 2026 at 05:37:45AM +0800, David Yang wrote:
> > On Fri, Sep 11, 2026 at 4:59=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > >  #define YT921X_PORT_MASK_INTn(port)  BIT(port)
> > > >  #define YT921X_PORT_MASK_INT0_n(n)   GENMASK((n) - 1, 0)
> > > >  #define YT921X_PORT_MASK_EXT0                BIT(8)
> > >
> > > I'm i right in says YT921X_PORT_MASK_EXT0 refers to port 8, because o=
f
> > > BIT(8)? And YT921X_PORT_MASK_EXT1 BIT(9) means port 9?
> > >
> > >         Andrew
> >
> > Yes.
>
> Can we give these better names then, YT921X_PORT_MASK_EXT8, or
> YT921X_PORT_8_MASK_EXT.
>
>         Andrew

These indexes are used in the vendor reference.

Or maybe just BIT(8)? Since they are not used anywhere else and kind
of leftovers.
