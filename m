Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CB337BB8
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125000; cv=pass; b=cnYSHIiIu34BShhKjPh6q43AGtEMSvmeZflo/pfWTib+pUsoLb9On+Yi5mgJYFOAW14uLZTzdi5DDx1eDxOJlloceDTiK75wv+nJU6YOMxq7t+fRNUOL0blokSSLp92K2SF0HGYw3I/xO79RjiIZjaO3VtNTg1Fu19Sbuwu0kwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125000; c=relaxed/simple;
	bh=Sz9OhUvy17uN3r0jRRJWXp9FQDhhmnWxO5tzwmvFSQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ou4uEDEHlTYcyVxRqzd38eYgo0uoNuYL/YnSpIEZxLyYVZa8aOaklP/DvgVpYY7ScrasMqbWSO08G7yOGybgxomtIpwVh5l7IBGH3pE2IaT/6VqvXrFWznHF6/vp9SzYUqw5lo18RQTnzlRNkHrmGMppG5COXsEy/hL7Ug3vG7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=F+3ltjrD; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="F+3ltjrD"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9906c85122cso496219241.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792124997; cv=none;
        d=google.com; s=arc-20260327;
        b=bHdTSDiNohhhX0DlJ87T/uZ9m69X3CSUj+AicH2q6YXkqvlbUp/5jJ2e3t2FzYGzEV
         XlhW0xukPHwsPzK2bU4l5c7r4Jxr4XhNO7bNIsp2zYeTy/Lz4M4fVR5qnTcl/HNgXJTx
         OwL5zqd3t0U7jZ78YuKsMSmcBjl4xS2JBz4LrZSIrkSwi5gNnGyz0EeeBCQC8PJBRpDC
         9c2UBDNkCXXsG6UEkhg9iEChibLdPvu4je5joB6H6eH9KGGLTFdI0SK/mO5Hn5hRgSkB
         hxIEtzbm1DsEmSFg7ah7F2lrwNUPI2JOaBT+qrOnPAkRq6TJ4vPyJyHhvsaBnhWWU/bn
         ai6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IoDus9+fiVmSa/kb08+RPoraKoW4tfU4BAbfm23za5w=;
        fh=2kkB9A2mwhQ6Cq1sSCTavtbIZ1G0Re9Ts5xBRrOfXZ0=;
        b=F+G2YNkXpiUsskMvYKZK7+UR/vICMs6QXXtwUXGEn5nGyRWcuFOkhj3X/9RmAcd2y7
         BWNOrFeIQftc+dmKtioG36NGHZVD6IZb6JpXj5+DnhRdhrBzCyxTs6z2ExUcfRZ90e53
         SsD6ghkD0dwtx+DIm8VcwlrzKJwu/TdWv7Sixy06qbX5ssywkMsUhYGnzuRZc0LGiOJp
         iKdcv+D8DwDS/0/B1HZCQQ5/IIbbHhAay2+26gdC+q6SkDdBM/NkktAxCo9+doNyEi4W
         KFvve+6RbVx6LuVOtREsHaMBJhqyLLMAyfr/mJFB8i2TUdm4NvCMukN54kSa4uj6eduI
         DHQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792124997; x=1792729797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IoDus9+fiVmSa/kb08+RPoraKoW4tfU4BAbfm23za5w=;
        b=F+3ltjrDl3oTOm7FneHgnEH8d1La+dtqsDipBFPDnM35Hr01O0Ni9bZEUjpf8R/Bex
         FytC+IxTi5WQ3fFEnM8qt5WJJj7bBXk8ywSGc6WS05PwxnILMRTn+Z73oLlwK4J18hxl
         PziHLTcpo1aorZEF/NMb5my/ifdtonNmkuFn1rroIRYm5Kr0KXhsoe3K+iwmD1WhI4x0
         qWVTzyn4ZxfCiM+9RMk/w3cTo9rhzKeGYlyLu1ZbWyZAP1J+dv8rtFDjCzGA1nztPg/A
         0wiICC8s4l2X6hZI66dzJGeuAK0JGUEWU0mwbmqfVJbQxbf+DPsYmLZBwMxFOBUTEnDd
         w4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792124997; x=1792729797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IoDus9+fiVmSa/kb08+RPoraKoW4tfU4BAbfm23za5w=;
        b=xOtw2PpbcdCSoniwnUYCT0lZUO9O6uhMyEc63N5m2mifa0DnSgZ27ggbLki6Cul85i
         xNYrvrchNVCPFkGUVSR0ZyMfgf+qSfO1LFPLkv7/eTsryGzI1z/66OhLeVRPj3VOO6fQ
         LFQxDo0nV/aZCjDI28ucEKLYuuwy4LSgIrwm75tIDgYRFcZwP3OxXjgf6+LJ2oBs0etc
         AKD8RTyvy9KeayKw9h9FEC+mmNXULsr1NQYtxQsWhZhQkWW+ZATivNQcvBtcYmcocBpm
         XOmZdkpmRNoLgdV3ofRZDMBLjhSXtf1akac7dQ25NcO72ktNYEJDlkW9ao7cbx1KBy0x
         Ashw==
X-Gm-Message-State: AFq9FYKFE90Po65Z118lEgqnMj8jSAprFKiItb7DWEllvWGY8PRm43rt
	VHfLq3C526wTeJLvlc61D8z7P7tfW7+zmzfe9LaKYLSfrQlV8rnLqZwJXOKmlrJxWo3PsoHZRlt
	Yr3o+e+241xKeXfI59ZYOe3VRhVkCL27ttWUrj2Q++AXOBeFKAZsDZzIP4w==
X-Gm-Gg: AYBFou0it6MBYcw1Nu6jNO4s1tfesV48qLDa2VREPqBSjw2OTcH/8JZnrOWxRge9yX6
	jtvtpOmgaepwTPX11bciFWofGpVR90eJ6KQMDcEU0zhiFd5WmyLQacKdv3cB5bexzAk5Osg5dhP
	rEptCrV7VbESAZVK6lz//3Dnbk8gp1rGQZ3/bYAUw+jcbfDUxgIFKygDrWytp7z+/9UVzqo0Nee
	pB7rkbtnoa1p9wDi4AfKdBKuvyJi8PkJPendLIZfigvnouoxYeZtqPPAb7bzVAwqmqQyimUkEWd
	Mm5pG+B3iFcAfLQ8QErnJTmxA7moXBvr2BdRY27XmJBvjuB2e58RwOh8e6pafOnjpYyeqVt2xi0
	dcGpyWsz/uPELGXawFHY7j1XPUxdWRbIXVG+hYOxAkUckfjtCmAvU7sgJZHZYTu9dYco5HCeY7l
	BqcP1A556zMDeLOrmAhE1yocTPDJcjWSFIhir5jjM=
X-Received: by 2002:a05:6102:2920:b0:7bd:732e:c615 with SMTP id
 ada2fe7eead31-7cc0578f039mr1214282137.26.1792124996651; Thu, 15 Oct 2026
 21:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016025059.289202-1-rjethwani@purestorage.com> <179211928626.408196.11462572316325227032@kernel.org>
In-Reply-To: <179211928626.408196.11462572316325227032@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 15 Oct 2026 21:29:46 -0700
X-Gm-Features: AclHuK9JE1HblWn8NEsRrb8vx-XgSINAH7CN8OiC52gEqVR1UjkpNwgjg6SQC2k
Message-ID: <CAKaoeS2xhmzvecznFuy=i_i3Nbm_T3xWJ_G8enuaiwwQV+XmBw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] kcm: don't sleep in softirq when the lower
 socket uses kTLS
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:54=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

The issue fixed in patch 1 was found by manual code inspection: reading
the kTLS ->read_sock() path, I noticed that tls_sw_read_sock() can sleep
while KCM's psock_data_ready() reaches it from softirq through
strp_data_ready(). I then confirmed it with the CONFIG_DEBUG_ATOMIC_SLEEP
loopback reproducer described in the commit message, which hits the
splat on every run without the patch.

Patch 2 comes from review feedback on v1, which pointed out that kstrp
is an ordered workqueue shared by every strparser user.
