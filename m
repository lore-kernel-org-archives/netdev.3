Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C3382393
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950398; cv=pass; b=u/2145t9Kw6SsH8PtmDfn6GiSCh66s1kLqqk8oFONsdUWnJ61YUJSZ8lghor61wNwIHauy4VlWjlpUGCAuQa+fUf7Kc4Xheb1xI2OJM/2+kYRZITcNB4BctzXQCHWnctHt3hiTXT8GOAEin6isYyX6Lk8tzQPFAhtz+oyCkQwco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950398; c=relaxed/simple;
	bh=nMk6YIu/HJFxj64b+fZMk5CqLv1z4gaw54JaGg+DSGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hT+S3YfLoXaIWyXyJaJ84mu/s+F31gWP/Npp+eDBg4JQ+4F5sUG6uM4iJELlJhWg6T0O03pslHxmMur6AKvBQp75bfICTMAJ6fgHfMgomaIdNa2Xz0sO+btD5zDcP1tG+xCXYdDPsrfnD7UnvyHqHhDhm9MTcWJE7ypX47ULhh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ju8C2oo9; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ju8C2oo9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cede6375caso31765ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787950396; cv=none;
        d=google.com; s=arc-20260327;
        b=NPur0zeHaCgREcntlvkhq90t0nOOfvO8TJjm+9ShuJUriKvCunmHe2xyzDmjfT29j7
         39pJohoWF8Nh101IMCGdXYdOGr4Jxk+JaHf5iA4jvZhrJ2TUc+R8lUvyCj22tTidFEot
         7DqZKGZj4pY80pw9QkFljloc2NIFQZbemYjwjHjhaUOtdoGLxtMAT3/whGrcZCUH9Pik
         N02u8D1gxFQYkmDaInEZAJlcfp6wG3yWmrtXkCwv1AXcrJzSpB94t2WU94FpqQVcQa32
         avS5kwXdQJ5S2fbj6Nxfbh/+CzX0YMQ2VEIkPQuXnVS32a8lh4mlAoZIFMF2o2C+/emq
         ZuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CjwZCbIUlQx7f/5ABrSJyP1/dVlm3TRTKEOHbWjYFh4=;
        fh=0sqlDPaV7PRKdjjJjCnTwu0bb1ey6avr/srxtgOo7tI=;
        b=r8h0P8Sxn5v4yjPVP3ocrbfv3lJHR34tw97YZgGnSHrOjoonErChuCxsr95SLKRhRm
         yIJSQkqpQC1My6NKHT/GkecITrIKhkXE42lONBDThrE7eaj48jDz8O/cRM7zn3rXNyvh
         NvnX5CKKXV7tEe9aGPvLQaemaEsKpnKCyDaaIY4JiCkXLNS+xzzZ8Kl8eLzH6EnGox3V
         Pry1E9MAaUo3rMQoGDQyMD4U2JYhQ7yTu99ReZvw8IjemlaBYEH8peBYVOrrrVzdZ2pk
         mk3t57ljR9CmHgIDM6H4jsUyAqP/lQSQiZgEOXDm8lZ0hlZF6HuWTT49BLVB+qwn+kLm
         5iYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787950396; x=1788555196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CjwZCbIUlQx7f/5ABrSJyP1/dVlm3TRTKEOHbWjYFh4=;
        b=ju8C2oo9uY1Lqp58aRh8shZCNPVIL7y30VKZqV2em068+aET0AmP0XrwFrfgKWZ5t7
         PbFYwoGeOi0WAubhPKB89QXg8+ntXxSY66aE3+TorCwaJaeattFCv+GiUgFIgop1N/5j
         wjqG0eU1NQ/Ib61TE5ScD3Ld+tcbuz7z9o7fgWIE8GnR3AuVU+r509cRRK0yOBdER9GF
         oEllQ/gALmoP8IxmnGww7Hg5r/jHt8CQGwQ6XSJNOmRew9zxWkqSID1Sk5+PWomGaAjG
         ngOtAISJLaSilNnMNqS6clgdTGu/LWohyPT+KrlSYpxW2fPx3FXJOApcVOpUJkg0Rn7w
         Io8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787950396; x=1788555196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjwZCbIUlQx7f/5ABrSJyP1/dVlm3TRTKEOHbWjYFh4=;
        b=gK1jOBwH+hLWzxN+PyTYjVo6R0Ka21q8X2AB/UpBJZmUWcW5fePJoQMtxxOYX58vqO
         6mbYRSHLKpFJrfMyjuofxzwzIXkzxQZClhHqRq3YD5z3a40ZL+am051GCNCqTaN/ALb6
         F0uh8XYZARtqcLaPWyXVUi6e1SCzOSqZ5oAQjCuL6bLi21UQssHKnn8TGrgmZPtw96v4
         wa3WYbi5BVDKhyP/K8dkDS/fjxWluV/ewdfvQcEMyYjunKPfzfn96MVSbvYI4lzX0NyW
         m/MukJ+4vwLQyd3yo4NQyLyxbE9yrxC4nlIIwVT6+c4ABw6YiITdXLBSeE4Yqa6k2Qio
         +9bg==
X-Forwarded-Encrypted: i=1; AKwUvBwVG7LBfBOmh6jua5BMihbTYnmCrYM0EJwn/rPjDlDeFnFjc2AHbMb3l3xr+SFmOZ4kn2O00Y0=@vger.kernel.org
X-Gm-Message-State: AFuF++nrZTZGToQiWGdTFJx1XlwuYuru7ApTOzXn0lAbErOXzaUFKRzw
	Z077uNO1wFtf/B1SPLY3R9ktlrVfpkoUq/CRlds2mKC79ZGOk+epDg6E0EWH4O73CxEQeU/T7kI
	4HrFWuG4g9ATragX/YgDgJIX1DmE0TRK+9KmNXi6M
X-Gm-Gg: AYBFou2GDsUtnQ4bsdzpMLW9zJhPzmk/BO/X7QdHbRPmOAL2W1fsjbs/8XqeG8vnm4d
	s1Bozp09TN7XKq5tkk7VClmbXAb4kKiK7OTtlG52RrLwsjWdw0QdDjXxCaKfN15r1EIZvKFwDva
	wY9i81Fhah4hLwKatLKLamOnHO+tZIYOW/cpXq0iXzGgIVMWHVg1pOCZ38Nwp0JOLzanqNsRW6m
	Px4RRcspyo4M/B6qPREzSqJxyTycTB+b0glGU4UEldsDoUn9eiSgCPiZ3JrWUwl2vuxTZRME4yO
	SMhHVMAUMxIkgZIriLfAyeZxLzwiLdgEzBXhLqlwfn36xAhIlG/o3k8aJtWUig66EMTgGdoBI87
	4lCcAiMuhT/Joe6ww/0y8rXAzlXdjdgVpCMezpxDbfg==
X-Received: by 2002:a17:902:d4d1:b0:2cf:4353:f117 with SMTP id
 d9443c01a7336-2d8df23260dmr1944515ad.0.1787950395666; Fri, 28 Aug 2026
 13:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCgforg-XzdODxh9axazFP8M+hFj1wk=XE05oSGz9B2Zzw@mail.gmail.com>
In-Reply-To: <CA+0ovCgforg-XzdODxh9axazFP8M+hFj1wk=XE05oSGz9B2Zzw@mail.gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 28 Aug 2026 13:53:04 -0700
X-Gm-Features: AcwNN1VGv8Y7N556IkOEUqeS40HHYOe-n-1fUfpBJ9k3A9wyQexICTfuT2-fSyg
Message-ID: <CAEAWyHfU-yo+H6Ss_wXPSzMnsU+bd9EP8Jz7bPJ17xvj2Kc6Yw@mail.gmail.com>
Subject: Re: [BUG] gve_adminq_release -- unbounded reset-wait loop, WARNs then
 spins forever
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, falemi@asu.edu, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:23=E2=80=AFPM Farhad Alemi <farhad.alemi@berkeley=
.edu> wrote:
>
> Hello,
>
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
>
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/129-gve-ad=
minq-release-unbounded-reset-wait/
>
>   Unrecoverable platform error!
>   WARNING: drivers/net/ethernet/google/gve/gve_adminq.c:378 at
> gve_adminq_release+0xff/0x260
> drivers/net/ethernet/google/gve/gve_adminq.c:378, CPU#1:
> syz.0.63/11869
>   Call Trace:
>    gve_adminq_release+0xff/0x260
> drivers/net/ethernet/google/gve/gve_adminq.c:378
>    gve_adminq_free+0x78/0x140 drivers/net/ethernet/google/gve/gve_adminq.=
c:392
>    gve_init_priv+0x2a8a/0x3450 drivers/net/ethernet/google/gve/gve_main.c=
:2509
>    gve_probe+0x61f/0x970 drivers/net/ethernet/google/gve/gve_main.c:2892
>    pci_device_probe+0x461/0xa50 drivers/pci/pci-driver.c:489
>    really_probe+0x267/0xaf0 drivers/base/dd.c:709
>    device_driver_attach+0xdc/0x1d0 drivers/base/dd.c:1206
>    bind_store+0x1d0/0x220 drivers/base/bus.c:267
>    kernfs_fop_write_iter+0x2fa/0x480 fs/kernfs/file.c:352
>
> Our reproducer.c is available upon request.

Hi,

Thanks for the report. Could you please share the reproducer too?

It's a good catch. The driver shouldn't spin infinitely if the
hypervisor is unresponsive/misbehaving. I will send out a patch to fix
this. Would be great if you could help test it also.
>
> Happy to test a patch if that would help.
>
> Regards,
