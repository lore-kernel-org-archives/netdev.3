Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254321ABC9
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061956; cv=pass; b=MS8mSFAVRQJoLygMopeOb3E1bwQmYno83RZKA7EsOIV+pV9iUo4O68rEzAGDnM9C2ix9EHKYpuDAL2fdxCwN++H+tEoVuwCNTnfvYzFyPnf7cnMCT8kpDTPBZLxZmhwNYAqboDS/W+XeAiEKZ6fyZgJ1Ie88FavqPFsf1/zuhZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061956; c=relaxed/simple;
	bh=OLw7F5+O4Ix+dDCWbCivhj5jjpeD5EwA49kGQoV1BwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnlDdEh8ANxbvtp3QlD4EVCo5ybgRO9UXrOoj69dSCF2/q3xCZfB8fuMLW+lXpPXBP5DSHBri1im1KnGe91mnsxqjucIyLUg0lPl2OgWWkhYSv9t/mR/4bVIquchflv9l35JMf+IgZvaLJr8gUw+bJfBPoAYCCWr7p+an65jW1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMWWXe/U; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMWWXe/U"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so28856561fa.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 17:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786061953; cv=none;
        d=google.com; s=arc-20260327;
        b=JExIXloJbZv+a+G2tA4nXBc9NSJjtR1X/Ul/LcOxAPDoS/seOE786IdlQpK3b/b87J
         dkEp4b+18ddHtBcwErHWoutXGqo8tHFPxHTI1EZfvJVD26Ao61RpV1gNiEkNCL+3rhdX
         A4zVc/BPbw2rMFwQn5viX/1agN6fa9mtgt8jnMH1EJ6EjhAL74r/dwCetkreKBtz9Ph5
         jBTYaRZYMBv/0T/PXyTOJy8MmZjX8bdz8Am8OHW4xnz3Yev5mhrYABJn0ELO8gX8Ks1X
         DKWRQU2r+L4vmabvori4kfBMm+kkKJmQkalV0iTmEiEs2kmqX4nm2A0dzUxPIHorDEvR
         tcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2iQmXi+4UEmQnTAgK3Lk/oOEKoHH/eshJX8JwrI8pjI=;
        fh=PikTLED/nujRtOTjQpN7DMgauMu9tu4h50s83i2v/oE=;
        b=UoupHk+vFGeFjPtJAsuZg/qyTIEHJH62d/YXoAjbCbaGDmtnbHgAL01+X3r6vOvk/V
         8+zJjIl2zXD4YJMRlPrxG6sLXT9HmRjwlTooz3xBFyhNHQyVHQWY8OcgERW/Eed+pwyc
         HGtKP5VbAyOUt23WNAkUYG/leBZ63g+168UFyDiaaK+8cmcPpw1HGR0meq+xXXcgnjtl
         xW59pDdMKQV4X31Wb/hl/G83ii1Ftw2Cv7RJPRGp5kMqP4Q2sORz7K9H+/mc8ZHdcsKl
         bFPQAPMxpnnrxtJTmeb+bb5qcQAng2x/Q4r2ltXs8S0sPvXZIOrW1c6BnQcLyzHTUeiw
         Dkug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786061953; x=1786666753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2iQmXi+4UEmQnTAgK3Lk/oOEKoHH/eshJX8JwrI8pjI=;
        b=YMWWXe/UmXJCgT5IvO5g7L/+5rW3NsvH8nphFYUMq1/ak6zJf1smTq3k3/u2z9QTvT
         iKI/bCUMoXzRXAWLH+PO4ydnsKbPEKodefV7iKnShkEXls+16nL85StAl5tokGMUEkcR
         Utw+uTx5T25NgR2a13w4rko0/pt7R6wCONR5o17mUJcRswb33LRzCTidn7FKi68PsQYH
         e1cKJIK+zvO3REwSJaWl5tIee5FSR94LDH2QSp4nnK/eILTCNxx3RZI0G5DFULdySo+M
         CIl1VIBk1ARlhgrsSYg3Twep224RgmqPTvx1QTk6va0IzwEmuVGwQGK27EGbf2manq4j
         B/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786061953; x=1786666753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iQmXi+4UEmQnTAgK3Lk/oOEKoHH/eshJX8JwrI8pjI=;
        b=CKCf4clXJJlO+HJzl4U1fLLUst0GMnhkL8P4FqnhciCB3RsliOGLIwDtABXes/Uja3
         +tPttGl6GyH1tQ5fo5Ip/iJww/rtlluHlgwdhguXJndpsTXDdMVLNinEk0+JQmDtXQJ6
         AC5oeUSKfVmf16AbNQW9gdqUuvowUtKHz9fhOzUmZ+RZGSr5CX6ArjA/fMHXIGgHpsWf
         D3EoBjoGa3mFIvGzffrgiOvXUCUfwdjV4OLKy5ewjPVgZ7AyzH4OC5WurPGDTKdYwZ9e
         010MwUTyvODvXhEnC5CjX56eHBXW5S2gNNI/klOvTBv4Mqd63rwkrsE0Kn48f3CMEzp9
         qUhw==
X-Forwarded-Encrypted: i=1; AHgh+RrNjOuYstXN0CLrH1e7ooEmQoKjrx1vK0Jx5Ew1+a56Z5uywLD7jqErKM+FmYiy7WyQ2zKVGYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5OQ77To/1x5lE6vJiC74qRKBshL46HOFZPtIyoAB2HpZz9gq
	yuwKle5W/HZ2wm5H+ZxhiHaxAUHIojFM07O5mPpP7ynKdp0RzCTO8pN4E+oUnEmk/Q7NYSPT15d
	22Gh2HrrTam38Fr36hDqCC6cNLNiRF3Vv4KYbV33k
X-Gm-Gg: AR+sD12Y4RMap9ZFpXaDYD24FmKckmzNB+sgTPytFqdmCMahFk6yGPFHC7EKxRwu7Ez
	hQTHMW1o+fG0UFkIwOo84RloXjh0YlntXK5MefTNP6m2cgyMA3qxnb+hyMlxLLqI/pBndb5yDwd
	h9pLhQJDS/cbSG1PLJ0mqneC3DpNCcwU/j/oH9MQ91EERuZYIVF2NpO85J6bRRlDMUokpM22vBp
	wbXDZF8yrV3BII5D7K4Ft1fj3mrDWnDrNjZHFHiiOSDqPzOixYJrZIp+7B21qgfl04ckIVDA0IK
	EIvgDj3KQFlWgFh64BY1XAzxB9JQyDNYoIHzJnsrCBV/30wVlEe1xMQ00hkbe+TviqlKvD3pW3I
	=
X-Received: by 2002:a2e:ad10:0:b0:396:8ac1:53a7 with SMTP id
 38308e7fff4ca-39fbb1d39a6mr23161831fa.8.1786061952286; Thu, 06 Aug 2026
 17:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-10-hramamurthy@google.com> <20260805183711.2f31aa2d@kernel.org>
In-Reply-To: <20260805183711.2f31aa2d@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 6 Aug 2026 17:18:59 -0700
X-Gm-Features: AUfX_mxLEdsv-9T-gvq-o3w3bVO4ym-rfR_8aT9kttq6yWUhMrCBLiJtFct1XnQ
Message-ID: <CALuQH+W6A8H_YhKsqebtD+kMAs-AYT+U_7ygVfTUx_R0LbniPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/15] gve: simplify reset logic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  3 Aug 2026 18:46:24 +0000 Harshitha Ramamurthy wrote:
> > -static void gve_trigger_reset(struct gve_priv *priv);
> > -
> > -static void gve_teardown_device_resources(struct gve_priv *priv)
> > +/**
> > + * Request the device to release any allocated shared resources.
> > + *
> > + * If any part of the teardown step fails, the failure is documented, =
but is
> > + * otherwise ignored. It is expected that a device reset is triggered
> > + * immediately after tearing down device resources, which would clear =
any
> > + * lingering state on the device.
> > + */
> > +static void gve_teardown_control_plane_resources(struct gve_priv *priv=
)
> >  {
>
> Triggers a warning on W=3D1 builds:
>
> Warning: drivers/net/ethernet/google/gve/gve_main.c:705 This comment star=
ts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-g=
uide/kernel-doc.rst
>  * Request the device to release any allocated shared resources.

Thanks for bringing this up. I will fix this in V4, and address any
actionable review bot feedback.

-- Josh
