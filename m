Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02893545D9B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921818; cv=pass; b=bir6oAoSS+yjVLu6gUm0Lkuy72ta1ycrvNSBgJN2W9gS0WxJUHQ2OQkUcn6TI99ibNyBb+giHQwusv0LkrcG+daKcEZUGx6pRZwP+hmnk+JtnyZO2P9SZ0qNDu+r8BBoNcIDDEXEO6rjj9Bro9HlFs4WPdH9piareNtFh+N3ygI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921818; c=relaxed/simple;
	bh=wXw6JHPaoi8GZR7MHv9SvzkiwDSQOxjrJsI9ZNtm4ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGo3HwJy2qA8eu6U6yptY0GD+o1GrC7Hs3gKuE7SYq6wHUi9aLz3OomRfOAt/73i1dnLqovAfKJE1s7iVch/9T3FCc+Bt7E005icNJB5tRhGDp9oDnPAjTMMbnrIpqsJ+higr24kqEnnRonqhS3di+lj69MqEFTqUCGTPueVYTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H68qEmmv; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H68qEmmv"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso2554676a91.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791921816; cv=none;
        d=google.com; s=arc-20260327;
        b=R1fIVIYwiLiDGf3NN8LSOjkn74LZrBqVvnEhZq9xVcAAVWmbJGwdE9Z7pWqAKK5Q1r
         lN38OiR7hBjAcOTKNs/3FGY05atq73Y0ww4BfR7/+sWLhaZNfi9KGTEr8L42jrTF4ljO
         Hrm/0uRDuFYSrINFZOm1HOgPumaB9Q09qoz1sCa+YcIC8EStnRd1lnY48aexHq7FITW4
         IMsXBqXk3gQTym4pY8lYUKkrWVpYTcBiH5MlVFvTKRQG3+b+vNUmuv3StY5ftLa3pC58
         VlAOHpn7GqXviinKKWk5ZFpl8P4X6fjuH8Yz4dFdUK+FNzeamJfjiALzmh2t8RrAuIav
         nWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFuEyDlYHgdcnxzN9A5B3Rxn2gC4ba2X8EOvUAd6hpo=;
        fh=8opuYjMv+Fq5tVs8vdpWBFKl0N7BGARuizFCyajbV5I=;
        b=dnRYSHXzBhOtOhKFDNKGU8dvFfqFGk/L8/AECF1BVO72kWbYCMH405Ezz0oykobCXX
         YRogK9s2zqK9XxQsOIrATjBrkr73r4G8oy+VDU83PrGJCvG4Kp+ESpyXSdTkpfYFpUOG
         cMo+cykspLxgjTc+/8+tEasGHKg4Q/EKU+wAl83dHV6dJmH9M6kwFsYCcLEa1J/16GTw
         gcIw2a9+CWZ5h1N4ijvB3yANVn1pEo3kHH6a0P9ut318Q09dKKmZVKEny0/jifaOwYZW
         PFJqPPhR0rp4qePwkU2opqYMwYa/FcrFPTYo7SKfeq1q+MYXhfH5VZsu+LU3zbD1FVGd
         5yEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791921816; x=1792526616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFuEyDlYHgdcnxzN9A5B3Rxn2gC4ba2X8EOvUAd6hpo=;
        b=H68qEmmvpyeJu6G2IWTpJv5xkJLsQricUPc9Ou+f/mdzwVgurR7CgIAJqefXR/HWFv
         1GS6S2kbzYndfoUwgdNO4oJqEoYcUms6HZZcjVlz2bWIM/kimLfd+ATGU5DAfy8WxRe0
         ZRy8vvW/qw9GD1Mu4nE7HduUirNj0eQvIxchf7dVa578VTNPl0xAYNJpuVFgzcTwdtvq
         7Q0tXKG2IOdDJdTxBM9H/3ZoE0N1z7XLxBg4OGLAcwkybTiStZ5KCDQ+LL92UPIHK6qG
         x6fAHnX0GMekyGe3F4od7NOlepDoTGBP8nKq2XuoV032TaxxzAX5u9Q0tgqsNfVa0r3O
         HFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921816; x=1792526616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFuEyDlYHgdcnxzN9A5B3Rxn2gC4ba2X8EOvUAd6hpo=;
        b=mfkBMoYrpIgxOo7BqgVmuz9kAc/BafGyQBUD82XbTEtlIYCJOtn4YpZocOKwIi/IFG
         KK4Pqo8SrY0Ixv+8so5WXiakMtZw23grobkKqAb+NRU+U/PF3cyShD5noiIv4ByS/9y7
         MtIJ8Zo2ksmIFABTfThYpdPKen6aD1rzep9f8zjaG8QmMxYzQBs7nO2Rmr7y8hELc83p
         rQZNXhSnxFATgugZfbECBsqAcdbqyxbA7k57eva/xMYKLjUh5PaALhVDtdetpa7YfTPk
         Z0Vy4pPD8clrbGDXkCSsCM1TdZ6SK9dQJ4USVnccPqHFtOurH1xKAMrvXoFJGXjgP1EW
         Le8w==
X-Forwarded-Encrypted: i=1; AKwUvBxerra2Ehi4lY0MV8hKIdseuufuuQFtNRhi8tbOU2plikAzPMrUGjLZUDq+KTRaunR7HIotPbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI25/iX6PgLcTmuP8H+ISHh5btYZByqlvlKbPUFj1Y2T1yvFosk
	aWQzHKCL/SjETPFILHSC3vyfLm1dTFZhdkiBHMI1expXmdvgFaV5UHkJ0arTwzph11JhiLpwZ+Y
	nPXGEerf7T7RZsyc7pFydjYk1QCtF835aDnDZDwbH
X-Gm-Gg: AYBFou0Aww7/VOsjzB3cpPHVjCsO56a9WJBo3ltA4xYznU2sToQOmriSLVVHRTaQJxX
	zQ/z8ThGM/tjWs0wauHZqRDjPYTbXsvkTmaCGl35JMFqgb7JsFahIVF9vZz/VGOf+cYFOgt+nup
	0L+nzhHIIsww6EF652D9MJAf4eMCmUOcyImSMuxlLD4yY8rLnO5Aj+sxmTWUPsCmWGdGxRaWnOo
	2oR2sC7gJlvrFKGbb/pC8k6xeAHZzzk5LqL9jAwGA6TKokUm/jPEig6Y35ZOfExzfY61Ealgqla
	L2MzRkjgBqvcyKGeBm2fwoYoWuUg8aP420I6VDVmq2j839PqHBMf72FJWnA0lqnTtMs89QEqe/2
	KV3itUr1kWJM=
X-Received: by 2002:a17:90b:5886:b0:3ab:be66:ddc8 with SMTP id
 98e67ed59e1d1-3abbe66dfdfmr8069651a91.14.1791921816217; Tue, 13 Oct 2026
 13:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179138670045.80227.16155454353416856947@gmail.com> <179188620452.191181.12068195457732970673.git-patchwork-notify@kernel.org>
In-Reply-To: <179188620452.191181.12068195457732970673.git-patchwork-notify@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Oct 2026 16:03:23 -0400
X-Gm-Features: AclHuK-x8Auj0GJS-cFhNW52kGpl3z0EMRffxOk8nEUcDwL-EM60rfxC-vuurWA
Message-ID: <CAHC9VhQuBJQmwZDmK+rKFUcfsRkBBjTEP0yGeoTjn-V1qaaLHw@mail.gmail.com>
Subject: Re: [PATCH net-next] calipso: hash the cache key, not the option
 start, in calipso_cache_add()
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 6:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Wed, 07 Oct 2026 12:25:00 -0300 you wrote:
> > calipso_cache_add() stores calipso_ptr + 2 as the cache key, but
> > computes entry->hash over calipso_ptr, i.e. starting two bytes earlier
> > at the option type and length.  calipso_opt_getattr() looks entries up
> > with calipso_cache_check(calipso + 2, calipso[1], ...), which hashes th=
e
> > key itself.
> >
> > The two hashes only match on a jhash collision, so the CALIPSO label
> > cache never hits and every labelled packet takes the full DOI lookup an=
d
> > category conversion path.  The memcmp() on the key keeps lookups
> > correct, so this is a performance bug only.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next] calipso: hash the cache key, not the option start, in cali=
pso_cache_add()
>     https://git.kernel.org/netdev/net-next/c/d538cc3ec0bc
>
> You are awesome, thank you!

My apologies, travel last week for LPC and LSS-EU has me a bit behind,
but this patch looks good to me.  Thanks for identifying the problem
and providing a fix!

Likely too late, but for the sake of posterity ...

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
