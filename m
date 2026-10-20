Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518657;
	b=wNwnFPPmBIfFFyqpBUjcx9zhoVt2f24eGtQP6Q1HxG2AiE4Yvms80K21yLub09YcGaLf
	 ubWKMl8KzmvJmf38Gr3Ztw9v2m5KGKiAIMNjGLdnK+QoepCtF2c61U9JorhzAbASm4xai
	 XKhdcN9DU+NbeERDMp/LOOH8/GwA4KKm9XvAtlE4rCiFTz9MN/dIzoxNO9T5nMHIwgfvW
	 en+96Azu7v4tIuQRqJKKiD0LTUyjx/g0DnZYT3zvbdNOQLBZMvJ+9vQHza/ZMRqH2EGnw
	 95QIA0f8OfFoCYfnq46MW+IsDL2FNh20OSxgaxNPFtz56145+W3urH3nz2la9YhkdIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
	b=VdTMBQnNa/cIXGijnYUN3uAUaU8q+Sa/6peQQ4PPXuGEhHfkuwdSGDtazrkdBhPPyeJw
	 ufE5ycmpWUysozFcXOG+XB34if6dW2HwpdcWy3dsfMn3sQtMh4b7IqmS7JdcBDcmNQYmP
	 FDPysvQdCiJRfnG/UJ12uaVNx2XSzEH7T3FclQhN8mEhW+43N4y2f4ozGSj0GBFoMYOYh
	 Vs6J7oVHfEWs8sUHf2oWgYX+HitSSKotMFC91enEANnot7eMmUfFLHhOLrM0BplgayMVP
	 /ASgBeF7bD5e/LNCoq6wbR05VeFdDNswDjggZ4nou3GP1/6X8yQMyhFZvHdhi1QKZ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=FaXZZkDT;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52483606A325
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52483606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=FaXZZkDT
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1cc392d8bso4405159a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792518655; x=1793123455; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
        b=FaXZZkDT4JTAJD9dls5zNgoYwqN4YoaMS9ggdsn9VJDCOrpWIPpIJtnKJc5VsnFaa6
         NstxfC4k9ERrs0kvhRAeH1sHz2ZLoi6fy7GQyMHWaqdZYp+tOqS9UKf4ZqNmZ55I/VYB
         BJUlcKtqh1qMtChxYdXTyHU7LwFIy0XxNhEeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792518655; x=1793123455;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
        b=p486oEabfHqqL4oiu3azkWKIiD1xinEqZdrvASGwxTviaIzzcZIod/jrYFvYKJcbk7
         9IxzqzRCLtsVCVovQ4eUFgvd/nghMCbnc03GHIUzKZgwB0vd0hYitOa/BeHPcgjgPGOW
         Tk0ibPZOjYfjlDgfqBH577HYJfCtdgBFmT751evE26zDlbOWZwvAOViNSsKAlPv+ghjS
         OZn69E+kHHbjbO3XOPSkt7SQNimueLbsqEob9VufahKK9QF1Mi7ER5szW4ENvc3Jdjks
         uc4zkkDyWLuvEMN78qiwVV8L8dkunWn8LZ3QyLwvgD3z4KuI5t0TmN9ycogo5/rdY5tM
         Aj5w==
X-Forwarded-Encrypted: i=1; AKwUvByGeSZKt0npdpDI3jWx8InG3xtd7GciEop2W/wysZAd7eZXTe4qPet+FkS3Wppmrj1bX2fD40g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJmBk7YLUQln+6XxM77ukCmaDw2CPs3RH9cEVgqQntgudO7Elp
	GN+MJ3649XRW0or+TbIhXw+JqNxSeCkg3rVjKVVEqwgN1Z7InSfVulF/wVBvYnoVe1UoImb4gzg
	/LC8NlfU=
X-Gm-Gg: AYBFou33k1NKb2G+lBRcb46nHxp0fk6E5FFy2FlCLxqES9pB5HzK/oBzqWdPrEt/j4x
	gzGGJCvSQZWVECYlb/5R16Cw/qLQYTgsnZGLLh7uiaRSSVUJZFjmktTT0lCqqx7/FLMs9XBplfg
	mMHyhoycRl10JCQlnFYBBzGpCIE0UChgNxTrGdM4/gNzf39ObRsy5vMcRb8faFBzHnTJqAeLlmB
	DPFAXAjwGeXc8dY2G0X17TG8PElfc3G9qukcM4oXjPU94VVhBofFgVgHj70fckqDGLxo/Utf7bd
	2ButIH2wOOnyK/HSw73azsNB/ab8+tm+50IFhgPem5rhHukM92YGbn5ISrhF0klowsNhQJkfPFK
	R/3lOUxmpxOYHX8hjsSUZH3XNFhUXVRu+ZxQ23BI2mqsGOedaBey7vDVPvvusHXC42klPNr1/UZ
	r74I1r2FqJdXljHwOxYCjtpzrJPX95cLaGMzHYMgSCv70lvot61GQC1APPEnPwIoiBNe+rcevWf
	lqxg14LJTQbDcyP4HDDOVOCvXTnTWC46pTMItaT/1rDQcG/RwB3g1NzIoZS66dNdGW5JzWocRhk
	a3xjwdTVZ+p0FwU+G05g7qwHFwQpYkL+FYusJvkOX2fNa9GkxA==
X-Received: by 2002:a05:6402:11ca:b0:6b3:c878:3c93 with SMTP id 4fb4d7f45d1cf-6b3c878476cmr5073207a12.6.1792518654573;
        Tue, 20 Oct 2026 10:50:54 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4028dfabasm45887a12.6.2026.10.20.10.50.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 10:50:54 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c37b612635bso476557766b.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:50:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxZ1KO27Qed3fSIDLgetF86PK1jVRM9ejq2/z4CW2qhZ8iC0W5lIDhVG4mHt95sY3oR1tmL1Qo=@vger.kernel.org
X-Received: by 2002:a17:907:d2a:b0:c41:21ef:26ef with SMTP id
 a640c23a62f3a-c419ef2407fmr811663866b.20.1792518653997; Tue, 20 Oct 2026
 10:50:53 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org> <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org> <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <20261020102134.745ff48a@pumpkin>
In-Reply-To: <20261020102134.745ff48a@pumpkin>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 20 Oct 2026 07:50:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjUb=G+9gtaSO4bfUYKL+tVBVQq-Zfn_pGbCfxNWbz9AA@mail.gmail.com>
X-Gm-Features: AclHuK9rATEm1NS_MFfAyhy60SuMBv6wKyZqfF_GIdeIDY7VES_ZxkiFI1mL3aE
Message-ID: <CAHk-=wjUb=G+9gtaSO4bfUYKL+tVBVQq-Zfn_pGbCfxNWbz9AA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: David Laight <david.laight.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 23:21, David Laight <david.laight.linux@gmail.com> wrote:
>
> There should also be very few (if any) access_ok() calls outside of the code
> that implements user copies.

Note that that branch only removes __get_user/__put_user - and only on x86.

So there's still a lot of valid access_ok() calls left. Some are
around things like raw_copy_to/from_user() etc.

But some are around things that just want to verify that it's a valid
user address for other reasons. On example is in fork.c that just
checks that the stack that is supplied is ok.

But yes, the branch does remove a number of access_ok() calls. Fewer
than you'd maybe think, though.

                  Linus
