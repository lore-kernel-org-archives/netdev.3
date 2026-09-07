Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF42C234E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746959; cv=pass; b=JXxjZ5aOWRgC//rQXqZMhFBkHW0vJanUb7fP3Jtu4gvYDnTyprzWAiGb3wNXCAbSD4Ercd1S7fluB0p/pbDQ5Qhtlqb11s7GeArFa1pbiWOZwjIcjmh8sbVmH6KG7FowvV+RsOor8uwbFRKZ3bOsEl6vwWKHhlVDJfJce49VJFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746959; c=relaxed/simple;
	bh=8S72JqxkYPUq9z1NSraK1E2YCrYZXXPbtGqTQ8XXHWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skTDG/cedVEgmbLvGWhuE9FXGlzhZR+MgU5OR4hU+PFjh+RGcaauCgqzhcV+XsBUYnrE75LRQWeqmFK2Ei0ImXrZ4jGdNetsPk+TvRBgZpJK++zGEWMc6gMVegxeD6tKkA+dAhSmDcL7B0dSMwxSnoLam+YR3j8B6TwUDc8OsnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WndSt6tQ; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WndSt6tQ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so3248944a12.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 19:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788746957; cv=none;
        d=google.com; s=arc-20260327;
        b=M7zs2jerAqnTFH+g3xQy2CL/TK01x0IRAasJt7lDD6y4/oZR+qjLhOLdrx/joE0kQt
         FElL3at69w/mMSA5uNAPuek2asdB7+raIO3V5YouGU3kyyPZN4TDC1PFlAmk8pI6B8RQ
         HiBTUbtPhYar87GBybZ1jfPU8g167wS5VdZO/rSyq8JMWfKkROBYVHicQEmU+uN/CTyS
         rr731k+FGgaX+S4d1gdbdSZPoJAiRZZrL9rniGHG08OsRISGP4oLAq/+9rzh+QwzcAFh
         gx3GviZDufNYOg2LWN6xQccawLUi/3uuHW/DhyWrjvBtBm8nq7FwJfhr3taXgHHBob1T
         8cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=41ZPJes78E5JqYoluCCQhPdQKZKpfLEU7Pxen/KxT9c=;
        fh=o54u21qJaV7NuQzzg4dA6Z4KEB/GX7m3yBka0i1+vRs=;
        b=dTNMhuhAXzA9YlQQjHgar9iaLB12k5wVABpDUHgS1frJn56TC+dMl3C0f+B2gqiUTJ
         9MG5vIRPckR5w9eWSKxRCA8qOQ/sZKcD1FUDt7SVCjGL/cBBYclzQ1F20uAyzicbQ2xy
         ji6mN8F3OQZ3uYmPwn0AdBQkjiPmYW0zsksdtWPl0boB8zvRdfYVHe14N39qjmHYJ/TJ
         48myT+bNTB8OSy1vGvKhw3nTwtHYCDXYzVkxIThvZGruC60Om5BEZg/dDdF94euhwAXN
         cMVDH3OoGUXgv/owNvnkO+YklnzxCIh9CTexqC6L47OkSjV/hO/gAQvZ+DU5a+uCVOuI
         N6pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788746957; x=1789351757; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41ZPJes78E5JqYoluCCQhPdQKZKpfLEU7Pxen/KxT9c=;
        b=WndSt6tQJQ2c0Ehdw3NdNaUy1FFbMSYn1EsD8Z52tfpoj3pMVFyRmlP6yg59H8GAkh
         +Sk03o5+ftbULYpEbc3i61bnUKIyCJPa4fMB+twTBpH0GDKePBaCgVOKxyjJfFvYkbOW
         xZbFozSqClOQA4nHVnlx/OXdtZn+cgv3PxTSxUD/g+tPbJOXkAK4YwDCqKRk4Kx/sw4l
         dMOajq8HuqCmCmjDSeSprfp7NP+/UNf7bFAknrITjbYaPtQfzMc/9oPHu9zfECCID0Ul
         26EwFtrAV2GM/c1k1PEkxn9QBtMfHDQKggrLCLn//lu69+5LC9bM+F4iLTmNZw5FY52r
         FOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788746957; x=1789351757;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=41ZPJes78E5JqYoluCCQhPdQKZKpfLEU7Pxen/KxT9c=;
        b=As7MI8jrpKT9JaqNdmxDJX+CU2gfP+JBeuRwbSg0XlBrW+U4NzY2tu00jfsew8tgRT
         vz2+yL+XY+Na9NHgJLSEUeohvizhP7sw5eHonzbcJdsOgv55phgkjJkt150iZ93oM1Ro
         mDPflnnrnWSg7tJqy0TJ1lJ3eiXNXn8ID7n1UhQNX0LFwXNZMCM60qCNoY8BtAxRFUAl
         yM0Dj9UDt0ChaTyXOTOvl/48O75qUxpALHRVSXuH2SGBjBpfOd3y5EwiGVQNEnLgm0pG
         OlYaQbS8ulrhZbEkoOQAYDsYXR/GFkvlUDA9WCKE8gToEq5qfoOk4NpJSlCMmyKkWQmo
         KvJA==
X-Forwarded-Encrypted: i=1; AKwUvBz6ZvMgHQ2sQpgAsVALNP4XP+U/i0+GGdjtJrw68/VSnN8S14ajxAqgqk8l9in67vkeNohY6HA=@vger.kernel.org
X-Gm-Message-State: AFuF++nqDsUDsea3ukMwLFzSUdjhpFzXIGT4YDNIIfTT4hxalUtR5Tp7
	1M4P7WpeJwVAP5FFPq3CfSss35mV2fy9VcblG/5oXsPIFmas5Def5q03Z/JTIQBAkr2HwgYWfB+
	DPCauQ6IaN6vqLVLphGTiyaIymWBzPUs=
X-Gm-Gg: AYBFou1fmVnsOLX3gyMAVjvbpI6GbqDidVHVYITZeyled6ob/V+b4T1n0mCJzg4rf9T
	lW1Y1hl/r7FBU9FRWxJ52jIX6WXuhhJ1U5FpHE9daAQQHK9Jw/jABGY8O4zQQuJjhC5VPD8b01s
	mMVKoGnCQPa3USEGxkx1p/ApUVzWoVFTUna7oIdWL9K5Dj/Uh4CQ8K1N6/QqrqKhTIYePsw0BGO
	yGtCtm57vmtyimmpAfoBfnp3y8RP8kVUOLgYMRaxAMCLk7JCvkqiAYZ5Nm/H9VgwIEvdhZcEyBx
	BWRy1kOEY/0l3YfU8qJC1VGJE9eq12rBp6RFKHMJGghow1TClFhkcMYfPw7eWZLTPXSL9iKAmft
	Gcl9a4c5TzqoYhrhXqWDP5g2hGUyRti0BXqP4cOOeyuX/ME0NnrLmLhol
X-Received: by 2002:a05:6a20:9c11:b0:3d2:3e73:29eb with SMTP id
 adf61e73a8af0-3da39bb596fmr30384101637.1.1788746957096; Sun, 06 Sep 2026
 19:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904105542.70540-1-phucduc.bui@gmail.com> <20260906131711.247708-1-horms@kernel.org>
In-Reply-To: <20260906131711.247708-1-horms@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 7 Sep 2026 09:09:05 +0700
X-Gm-Features: AcwNN1UpBlL5kLepkt3Zyceqrsy2K24obNL5eruf5Z7G_SgnSgff3Tb-QiV2bYg
Message-ID: <CAABR9nFYrmteCtb6E_txg13U31Bf50p0PUBvaOXi3gmT7Z+0RQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: fec: Propagate PTP initialization errors
To: Simon Horman <horms@kernel.org>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	swboyd@chromium.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -             if (irq < 0)
> > +             if (irq < 0 && irq != -ENXIO)
> > +                     return irq;
>
> [Severity: High]
> Does this direct return bypass the error handling cleanup at the end of
> fec_probe()?
>
> By returning directly instead of jumping to the failed_irq label, the driver
> bypasses fec_ptp_stop(). This leaves the fep->time_keep delayed work
> (scheduled earlier in fec_ptp_init()) active.
>
> It also bypasses free_netdev(ndev), which leaks the net_device structure.
>
> When the driver core cleans up devres allocations on probe failure, it unmaps
> fep->hwp. If the un-canceled delayed work subsequently fires, will it attempt
> to access the unmapped memory at fep->hwp and cause a kernel panic?
>


Yes, this was my mistake.

It should be:
+ ret = irq;
+ goto failed_irq;

instead of :
+ return irq;.

I will fix this in the next version.



> [Severity: High]
> Does this error return leave the devm-managed IRQ active while propagating an
> error back to the probe function?
>
> If ptp_clock_register() fails, fec_ptp_init() returns an error which
> propagates to fec_probe(), causing it to jump to failed_reset.
>
> The error path in fec_probe() manually frees ndev via free_netdev(ndev).
>
> However, the PPS interrupt was registered just prior using devm_request_irq(),
> so it remains active until fec_probe() returns and devres tears it down.
>
> If the PPS interrupt fires between the manual free of ndev and the devres
> cleanup, will fec_pps_interrupt() cast dev_id to ndev and attempt to
> dereference the already-freed ndev structure, causing a use-after-free crash?


This is a pre-existing issue:
https://lore.kernel.org/all/CAABR9nEkci1OFoHx2qmJWvKabUN=JSu5AcPynQ-tH02wxHEmOA@mail.gmail.com/

Previously, I suggested using request_irq() and free_irq() manually,
but that would add more code.
Another option is to replace alloc_etherdev_mqs() with
devm_alloc_etherdev_mqs(). With the LIFO cleanup order,
devm_request_irq() will be cleaned up before free_netdev(res->ndev),
which should resolve the issue.

Since this is a long-standing, pre-existing issue, I think it would be
better to handle it in a separate patch.
