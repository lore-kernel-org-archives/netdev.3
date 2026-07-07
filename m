Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9839937C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416946; cv=pass; b=EE2/V3bgoYpmxSJdvWjWiz4Xg71ds7U5bzsCT7rEIem4ywhw6pWcf79uUPAhw+kp5QhhrhFZTt24cmm6veNHIXcq/OYl3r2XHmWXQa91GAI0wAHZSgdomNToYXfr7wU/C3wd3R8mOY21nfwzIvUfi8m7vbfxnSuJOCvgVxo5TkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416946; c=relaxed/simple;
	bh=uLybiMWMjmE4TRojd9HQOPaGaWZeCtzCpL0SPNTzJx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwDOMJdRuKN5HVyjYBYiJ7qy77jb6icBZ4WVR6Wa22SxSQuJZvQLrlM1XPveTIKNeDNaBuJwb3bBG+XIJ+tlBqL1BC0gPLlNgdsy7XjnDDJVZq3lW1PrU2rsVesjjWsl9o6DgIB1V8JQ8m5AkVmLPMop+o8s/d8/V+5hrjqcpBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=S7JQDAE4; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="S7JQDAE4"
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80E723F527
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783416936;
	bh=bbT/31W+nDI+goBOogRFsrx2+HdUbut6Kmz6fgFzHhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=S7JQDAE4E5CD/4AHpJ6qVSF1mqvol6EdkTCI/SUrz4xbNguPJFc0eOhr7wC1T4CgE
	 p4w9azv+i5Y1JeX3UJReQ/tpOGdb1drIJu1Ca8095BN7EKshUskm9DgBq6GBfQZ6Es
	 6XDPjt09NB10eWkOw3AU0ZjgMNE7luI7Yo0SggDj3Z+epxUMyoucCmFaztdfRqhWVr
	 L72VJeAT0OnruEV4TY+r+rBYcFRKkRqlrXlVtUGMqIMUbq/tVcKadL1JVFkL2yruDz
	 HXVGXzAQMm2IEAFnicg8eReQoWbpc06/B8dnSYA0NtOSuDzNAigKVTJdkpGU1FufXZ
	 OhHN+L4sFtkJtBeDQqGgpaeiLMjbcTmqzi0PsU3Jrw4ABYSiqfDcQHmDpIrPj0Glvl
	 km8BFcOoB82PLweejoRL8UqWwfCHYHsqUzr7tcyf3Bmwkh1/FV9+xicjeO1dVxNpo7
	 MfTE/NnZ1PPfZQPBxWYeJCePIF+iRxuV1VxGbomaM3t1xe83sb05jubUQBHtOO7kmr
	 Z9pV7k0w0AVnZ99M51QH0W2lRkGxNgaJFJzXZjlNBB6xwwqFRGD8EjirkoVLpBEDs/
	 XQ3uHgDmgyA3jR+55RkJop4SnL+4wWbonjGFCO3OYjMM5HCQl/tqyML5sSDdURi1q6
	 x/QMXU6Pj1NvQAv7qYmt+h2k=
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-847a225cd91so4164900b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783416935; cv=none;
        d=google.com; s=arc-20260327;
        b=eHEpt/mKPx+TrmOSsBrfBb1hAaOtuKm1d25KHW4f4XwY9OdkBohKqeeBlxq1POGWUS
         olm22u3XtmwK/fuzBpbwLQvCeKv7gQ2bJIzmgj9ZGwRlJoCWB6hdNA2iprTaILVmV2m/
         yb5qg74RGposk1LSELfrCwM+drL4tkLYQwqm8nTuaOiDY/nE61Cv1VWHlAko3+C8M2/Z
         olMEHm/bOddGvS1kKl9e9Dg28RCrhj4QIObyHA2V72YqgHb3+jwaZcteY3aPJKakEXOq
         xwURJ32uXSinbbb1C3aBvI1TDz1GpUOrcKh1QGWPawNuXgcGoGmNDT0mYmWRXiFn201M
         yMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=bbT/31W+nDI+goBOogRFsrx2+HdUbut6Kmz6fgFzHhY=;
        fh=URfISgeGRy5DTcqeY8uNeSytDXK/HzwCuapdgvTVm0Q=;
        b=INR8CYVi/owqLdQ1L3O2kIn+H6yll34eY0kpE0D5X+lHXzs+tQEBwyCV9aE5R5XqAU
         WH6dcUm6s4yjR4wOiBAMuIrXn6vgNqI5jTEZ/5WYATw3QmxK16KLHQOPx0TtL4TMJBCR
         itLY8lQ99XUOyQbWzL9fnFDdh+e7EOaXidJv0bp4SK99LZC+r7lnGSB/uKVKhHAznJBJ
         ELVANLZ3fxWahFhzAxBjRoW/+6+EzKnvqbGx8JQowVLwd1nyer62hL0s4CmArbrEeQdd
         NWjV6gdFWFEWRXKAZswOx9/MjgEROdTONE468tP7FXWTcTC8L3UNU4foewwtzvfma7BY
         GfVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416935; x=1784021735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbT/31W+nDI+goBOogRFsrx2+HdUbut6Kmz6fgFzHhY=;
        b=kb/062lzXeCVLg1CauZzSFyKnoCIe5IGNnF/nm2cVWoDyCSCVMcBmXHgpJUrVAV/4j
         WFJql0sbMmo/HjkfuY7xMaJpHDc4NtOz/7NbP8/K0cmVs2ByQs2hR1wE9twEkRpQthYV
         y6nTVFj968LSdJAyLsda1w36uD6A2Eel25PvThnC/Nf8/ZotQZaFvHOkzXKtxJYJDYcd
         hFnETigrFkweDIm6lOMDX+UeZc7YPg26DM8U6xivGBjxW3l3VaYT9+zTihWW9ZFVs1Y7
         me0tpkrlPwrJHhMx9VsuznrvwW8B27Q46mpofbhJftEwnUMPyOVdJuyXBsloPnxsiTRW
         os+A==
X-Forwarded-Encrypted: i=1; AHgh+RopZB2nQcasVSFRoeavpjYWLzo44vE5cNlsUHwLz7BQmhYjf27dW3fVK+3PyqdhAHaR54D0g3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmlcsZu0i7Zq+jp1MHiwYnsXqT0knzm4QQYTujAQO4nuPIUzfj
	mu4rn9NEXlrlju2xPti4NvjEuNLcEXyUgxxzqmcDqz8nebl91SLYdUCbABpDpA7N+is/ztonDCm
	S+P8FiPwAu1nd8uwoJEl7o4aaSu8Basf93MxUMniFNWBCnCB6AMS+CwHwAJscNmly06FxWZALnt
	DuqLIjYZu1Ym4gVB76Njbnf9GLar1F4jz2FCiEl6ZhIYXBAJyP
X-Gm-Gg: AfdE7cmQ3uPl8e9W0Uhx0+dbktuydUTQz2LiyKUYhU0VCrLzqu0ssgBwkSgaVAiXlpm
	TtJRcUi5sBXuBVp12nISm+ghWgRt1xl3ErQzI65O05uFofTGhcKs677Ic7RbY7IKMvMvmxiozZs
	a3G4QOaZWYznewaHV4s8StDtljtn9JGsDmeL9U2OgCLIMP7buWON9xGMHr0+TD+IgnfhfTt1PhL
	Nn/S1IxGicp/ABDMeabZaH6lUN9AUiuPqEQk6+3dN6JPJbTJbUCmGODzv/KJonYjxrNt0+u4lR5
	aMA9aGE=
X-Received: by 2002:a05:6a20:c5aa:b0:3c0:9c1a:8948 with SMTP id adf61e73a8af0-3c09c1a9c1bmr2553458637.64.1783416934867;
        Tue, 07 Jul 2026 02:35:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:c5aa:b0:3c0:9c1a:8948 with SMTP id
 adf61e73a8af0-3c09c1a9c1bmr2553433637.64.1783416934523; Tue, 07 Jul 2026
 02:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
 <20260630214404.930923-2-anthony.l.nguyen@intel.com> <0496c117-0731-4de4-9f5d-7fdacf34bd71@redhat.com>
In-Reply-To: <0496c117-0731-4de4-9f5d-7fdacf34bd71@redhat.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Tue, 7 Jul 2026 17:35:22 +0800
X-Gm-Features: AVVi8CfFkGBoEQGbtTlj_qWkJDI5c9F_6NwSBaUWRPxR7DFsx1-u2mFLOdzGCoU
Message-ID: <CAJ6xRxVwD9nLk96y6-HNSFt1AL8o=24UMUGxCYZdht2_+36Xhg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] ice: wait for reset completion in ice_resume()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	jbrandeb@kernel.org, stable@vger.kernel.org, Kohei Enju <kohei@enjuk.jp>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Nowlin <alexander.nowlin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 4:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 6/30/26 11:43 PM, Tony Nguyen wrote:
> > From: Aaron Ma <aaron.ma@canonical.com>
> >
> > ice_resume() schedules an asynchronous PF reset and returns
> > immediately. The reset runs later in ice_service_task(). If
> > userspace tries to bring up the net device before the reset
> > finishes, ice_open() fails with -EBUSY:
> >
> >   ice_resume()
> >     ice_schedule_reset()          # sets ICE_PFR_REQ, returns
> >   ...
> >   ice_open()
> >     ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
> >   ...
> >   ice_service_task()
> >     ice_do_reset()
> >       ice_rebuild()               # clears ICE_PFR_REQ, too late
> >
> > Reproduced on E800 series NICs during suspend/resume with irdma
> > enabled, where the aux device probe widens the race window.
> >
> >   ice 0000:81:00.0: can't open net device while reset is in progress
> >
> > Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
> > for the reset to complete before returning from ice_resume(). In
> > practice the reset completes in ~300ms.
>
> Would not be better to (eventually) wait in ice_open()? Why? AFAICS that
> would be also more consistent with i.e. the current wait in
> ice_devlink_info_get().
>
> Otherwise why don't consolidate all the wait at resume time and remove
> the other one in ice_devlink_info_get()?
>

Hi Paolo,

ice_open() is where the failure is observed, but it is not what creates
this race. ice_resume() schedules a PFR and returns success before that
reset/rebuild has completed, so userspace can call open immediately after
resume and hit -EBUSY.

Waiting in ice_resume() keeps the fix scoped to the PM path and to the
reset initiated by resume. Moving the wait into ice_open() would change
all opens during any reset from immediate -EBUSY to sleeping, and ndo_open
runs under RTNL.

The devlink wait should stay because ice_devlink_info_get() is reached by
DEVLINK_CMD_INFO_GET userspace requests and reads device/FW state. That
path still needs protection from resets unrelated to PM resume.

Aaron

> /P
>
