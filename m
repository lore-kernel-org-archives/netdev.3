Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC42496D33
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177909; cv=pass; b=GeO2+VA9wLDxCFb35neZ0BwOxpyDpPkUIoYgQ3sEyFyx73xKQPTvO9zRtmWWtAVoufq54ytOxf0J7/n2hGqzn7tfZE3pkzr+PLterm08ELNoS0TRK6eKO1lfhby0/kwG0IfVDiwlygEA5CxU/EtZNmadhomR5W9/gT4A6hKfhqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177909; c=relaxed/simple;
	bh=gEeSEkSOfRu+0wU1/5d2sKj9+XsQVOzf6RYN8jzfDRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4tvjI+WgCxKOr42WGDQLAlYcnmJ8M6FOtun8BwJdfUMPh0hZlgMP/ZAikIdO6m/Pv/pB3XdiKQTfZurVE0fIdBcEK5bMrlI42A6KCEtXoKX0JzPUzbZk66L7XldL0WMmbXTU/Fz2zyMg79VpFVPclBYLHCvPGwvnXMtA+m5JQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1rfZCpV; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1rfZCpV"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b34ee88df5so139536b6e.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790177906; cv=none;
        d=google.com; s=arc-20260327;
        b=AGkA4oAsPzAc3XJtr82/tIoZFNTJ+brBDsD2ZzbBb/AxtV4IKQpQukQcrjqqrDrXGC
         cmM1ZhgcyIiZ/JLZoYxKOADoXz/2zDJ4qGwE9pxzCmjg0JG+cJTebbjRek05yIkkOg1r
         9sGpUr+7WPX6v9ZmqipR77hDGMNwvIjrzV9M9ta/HbPqtCiIjX5wS8/1QjD7wT3Nfw5t
         kPV6niqK5dVuAXMd/4/5lN6I59s4cJCIQAyuW9fjI2vV7LEGjb9JUGwDhZ1t0cWrkysE
         Wc17cdNbbCT9Q1qCjN9leEu01WdQs5g4R3CC05aTauAxVd+4iutcrktB0Mg+H0XP0MBR
         h7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gEeSEkSOfRu+0wU1/5d2sKj9+XsQVOzf6RYN8jzfDRo=;
        fh=6hluYE91nby+wQ5qRT9CeUYPv5enDaaaFjLbwqxDJIw=;
        b=PISAMMGKj5gq/mXLQPg6wZYJjqqu4j2z8gxOqGenzIgNdxH5Vu2mh02poU/6IVrfzA
         auGOf7YXm12gW4KFlxQu99FI8I7+hGkWucZp5/FpRUO8NXY/yBMyWRoLepyRC4NPbvcO
         Rv0c4XC7j/4q17ul8Vz5czwv/3Qm+oZsI2JbU/dJ8OjLxc5E2+DVvda8nNpmTP+sPmuq
         +GWr/dwCrd8/OzFD75Td1xMVkahGsSYoP8M3WqNYIbnWtA6mIENzINMhwnEQ+7k5kPyY
         Vt29/0gsy/C5znPtgfD+GRWD0R7iacBSYzP6fmj4VNIRDeROUQZijTNsLBPqLWk7Sh8R
         UePg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177906; x=1790782706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gEeSEkSOfRu+0wU1/5d2sKj9+XsQVOzf6RYN8jzfDRo=;
        b=R1rfZCpVaoeS1I2e9V3K7gFOBN4qX9lpx2qWsDz6TSFzILf9pqdosDuJZkprYzJUqy
         mPSNCdaCsCRHbpk6WVGCjxaAALCpoiyA30X/TtQbkLIz1p4ceuY6XUPBKEdEBXv4EE9S
         2fnqvMF+M+RxE6Kgwj8mBgt12nP7s+GU9YdFI7tJbg+4wH3JmHZwJNGEVvwPJVaBrIo2
         VbHltlbqfqRtmHgK6nkQyVs7NwGN4y/3T/7N7X0qCtJvrBZ5D8pCB62U4Vz/hOvHUKi4
         seRU0faKnD9B/KzQxPXca3DwxLerTBl0nDK9kHyaN+DvX+i5ebUXe7rwbaDdIJmBDZuH
         CJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177906; x=1790782706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gEeSEkSOfRu+0wU1/5d2sKj9+XsQVOzf6RYN8jzfDRo=;
        b=cpNNqlLmvko0/V4o23gT0PxP4EABzYI7SWTBJPafGbKsNHiKZrR8+ZwBWvg43Aufrz
         hQMwrZlNi8aq3L9plw+8aQiyynx83lTeGssMOEudycnbqEnRaQxHDKwm8mgjjBdy1byC
         yKqRe3mb+SFXdEjyzyhHvCkQanWo8V7h0b5igddxz/g5uWPR0zqpWzVEUU4q48DYktZX
         LKHUSXvRtWbpsEMXnlNAprojTKvWMytU57TbmS50ifJNt9vYGAU3/CphuyeAOdF7+je3
         8YcRp95INJtN30QU08j1bheswA4jVkQRFmZZCDWMp4f+NuqPLdGUDwfOssCpRjmqI+m+
         uiIg==
X-Forwarded-Encrypted: i=1; AKwUvBxR6Jg2mrCCqn5jlhr5obOK/cPda86PNFP5TX827Fp5fQGPwNmf3AfkwBdGP6sRj0FYXXgu95E=@vger.kernel.org
X-Gm-Message-State: AFuF++mT5MRC9OFRuNWhvetFdC5a0vfIdKqBOYtH8iTu2PQ6hvkm+GUj
	GdxmEakw+VIBHAIpPOjsysm/sMy+qStlbW/nLViYNmVBMoUhIDkXwJ9+v51vqUhXTLDTe9Yrzcb
	yqheqkWS4y+ySNkGNbj8/Vl/uNGW6Ut8=
X-Gm-Gg: AYBFou08toCcXc+Lc4h/JaI7JD53sAYeFXJTwduPLRvmeCes1LAwv4u5bXFF8m/Q5U2
	CX3FZMDvh2XKcg03bNhzksEFvdFVwRSs9DNXU/EX3yYI1msArZAXM6ZN0XwxNUFnAwO3Gpyh5Ud
	MEf76WIyK0rMoDY5f1SKKHvGirLTETxmDw8QOU9blPx5amh6RARI+jC/McmUR1Y5FF+Wc4qevYw
	30yzKMhxiR+t0W//tkYh7QchrTEN+QhBFYnSZ65N+ArOPijpuxO2zpiJl4jTbVxw23Q5EQoQoY0
	55Fn7MhP215i+BdSCxE/nhIjZCIjsRbZODFnefvPCy0qAuDMs3eKV3/g0lTbcZUB+kTM2Hc=
X-Received: by 2002:a05:6808:ed0:b0:4b3:9985:1734 with SMTP id
 5614622812f47-4d5ba3c4acbmr3726514b6e.4.1790177906420; Wed, 23 Sep 2026
 08:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-netcons_ratelimit-v3-0-8e81b789ab37@debian.org> <20260914-netcons_ratelimit-v3-1-8e81b789ab37@debian.org>
In-Reply-To: <20260914-netcons_ratelimit-v3-1-8e81b789ab37@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 23 Sep 2026 16:38:14 +0100
X-Gm-Features: AclHuK-2YGSrpzgft7by3_dFRSTPGzkf9KPty-TIWRA5mQOXoN0qwCVvVkFO1d8
Message-ID: <CAGSyskXex-Pu1n1wp+YfpVgbZnCRrd3CmGcLR9XWxenVNnk6NQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/5] netconsole: send the oops when oops_only
 is set
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, paulmck@kernel.org, asantostc@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:10=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> A target running with oops_only=3D1 receives nothing when the kernel
> oopses, which is the one thing the option exists for. Only a panic
> still gets through.
>
> netconsole_write() bails out unless oops_in_progress is set, and that
> flag is already gone by the time netconsole runs. netconsole is
> CON_NBCON_ATOMIC_UNSAFE, so console_is_usable() keeps it out of the
> emergency flush an oops prints in, and the records only leave the box
> once the printer thread runs.
>
> die() wakes that thread from oops_exit(), by which point
> bust_spinlocks(0) has cleared oops_in_progress again. TAINT_DIE is set
> in between, so test that as well, behind a helper.
>
> With oops_only=3D1 on a netdevsim target, an lkdtm EXCEPTION produces 44
> lines of oops. The receiver gets none of them before this change and
> all of them after it, while ordinary messages stay suppressed.
>
> The taint never clears, so from the first oops on, an oops_only target
> sends everything instead of going quiet again. Sending the aftermath of
> a crash beats sending nothing.
>
> Fixes: 7eab73b18630 ("netconsole: convert to NBCON console infrastructure=
")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
