Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07A23EAB3
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451472; cv=none; b=PHChpHExJBkzFJeGnwjvq+P2Gd77p+Yx4G0C6qqCReyObeiE8PHHAX3kSt3pyW915PFiQAwP3VtIWsSMq6cBrk47V2ejv+KSAr84XxnqZOMa0V52tpXCe+/3n+YUewvK/mZfryl2tTL5k9IKYCVOWk6c3NZGmlrjJRsi1xq73Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451472; c=relaxed/simple;
	bh=C1kuLSYCef2MY+GOSG1SmOl5L0Lh9QDvQLUVPkcNd5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alfnvx5Q5EPPoIz+hQY+bVxxiiQc2VsKfgWEAFEFadZHCFL7IqeiKNywvQjxuGhf3Mbug7zMlZIuC5rTA9p3f1zxpG22BEo9sEgAw0pn5fF0ZQn6nqzT6U8qLfctp1UXnWAitg+mcW8+rZNDbDe/9LpVhpFZdb6hGuqP+UUVlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W3enk0BU; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W3enk0BU"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-39647184c73so512104a91.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 22:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789451471; x=1790056271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NQrvJhER/Bu49ErNEuCaQlg+8YWhjMoKLn5TZgDjQm0=;
        b=HDbaibaSWXVc+P/KMJ992xwbJ26REueR1lKnM/L0E+oxoiw73nEA3C2ffumNjFcphe
         B34pyfEZXnIzewQejMXVQkyz0QE9InSYVPtOfx344bC78XJ9fTzU3hhZq2I1FgtxFb8A
         47l5aNlk9fovfGUA3CRIXYVieo9wGvqswtfPe7VdhGlmoPQgnQdyFwP58M2fCmzob0cu
         ifxEsnwcCsr5ayC+c67TYU1xDRx70id/YCtrtG89kJfD7yQu6+b/B1gynxQg2ruBALy+
         l0kA2c2FBVfxzxYwfdDlfZsqBQ+ZohfeXen68or463Y5t/b6aQkm43FPR6p0BsL6PkZO
         W6zg==
X-Forwarded-Encrypted: i=1; AKwUvBwFq6loWfGf723lCftOXyZFPLCfHdfl+ZqyZ/XibCYgqp3Hqp9lRwWnyH59XZXg4alg9sISJ6o=@vger.kernel.org
X-Gm-Message-State: AFuF++kFopsYOsM2v/a1JQKDTqrDmBN1W9s2x7QQuEJLSYXDUT6zAckI
	YrwY1N2YqoWkphvnT9I3w1jS3ZjPeo/bmSNVpEBe3+xE2b0UFORtX5meVE42pp2l/l2eKV4VXlC
	lF8uP2Tkdq+gOM6jpFkHAVCA36hx6PPVOuzvZA4WSU7AZdmDIRfKGFJgvXirb0rhGB3S0cCVwG5
	aEl/rTpbKF8tk5NBTExcfT+6cF7R5LB3/6PgvqTZuTlKNarFciVNOYKpkXywG0nvB59fHke6wy3
	SWJcX8js5o=
X-Gm-Gg: AYBFou28eYGCJoRyvl4MjX6ZNvT+myd5u2iQUgLvqo5aLiMHM/UAVqqnhRRLJQFnBe+
	kXs8zgAXVTOyyWtFdH5ul+BtT9jUGeXsFVpsqEn2G/Fd8umGXQz7LBjlth6B8docsHwli65xjP+
	hukrY+ujTYRn02r8LYb0cifmp0t0DCMyaiichhDYqaAUpG3qpdWprUU0cIQGOM8Sa1X1vabJRbR
	FHGYoUcofmb7mmvbPZLp6rQ+JYfC9yLr2cRS2GTITdgdxPN5ji5sD9BveHvs+Wb0h72n/zwtka/
	z1ND8gIp4VV8APTug+VeRfis2HCSWZUQzErWcVRABMHtBVT4Kb3vIWXoH+GfmS+2g5hmpJcZ+zn
	YV6L7T+MiJEHxybNE5add18TiFsUjhwnEYbUq7N8VjcclLuCC1KzNyLZJgEKuL+8j5Z8Y/h7Vg1
	GhxT+B+D15xADTOMrzmKTUsNxWpdoqXZBkAhCcZg==
X-Received: by 2002:a17:90b:2e49:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-39dfe0e21efmr2748000a91.9.1789451470300;
        Mon, 14 Sep 2026 22:51:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39dfb6f265esm237350a91.0.2026.09.14.22.51.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2026 22:51:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so529177a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 22:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789451468; x=1790056268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NQrvJhER/Bu49ErNEuCaQlg+8YWhjMoKLn5TZgDjQm0=;
        b=W3enk0BUjbb2Z1Im28we83y/wd7s5hp+IUw1d6xsTYbXuK87yV53PpCYqmu0sg2uIb
         P1+r+gxMixhE52mx2gr0KoATwd8RZxKot7UtS1+NbUOSBIVa2j7x2inreKzS3L6QuDE3
         p5pjgYR8T++44SibWbO4J5tO77SSjdP2yX638=
X-Forwarded-Encrypted: i=1; AKwUvBxz/J2xPI6UqhAzIyy8mbMMfzcxaF+ZDVxZ50/9dBfqHino6NmbArSjQkV4G8nu7SFDz23KyaA=@vger.kernel.org
X-Received: by 2002:a05:6a20:729d:b0:3b3:a66e:3911 with SMTP id adf61e73a8af0-3db4fffca36mr3426395637.19.1789451468336;
        Mon, 14 Sep 2026 22:51:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:729d:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3db4fffca36mr3426368637.19.1789451467892; Mon, 14 Sep 2026
 22:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230521.GA1400582@visor>
In-Reply-To: <20260914230521.GA1400582@visor>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 15 Sep 2026 11:20:52 +0530
X-Gm-Features: AcwNN1XOgRKTP4ypIWcAXzRPLRWQ-1TDUxIQp-2l3HjXxuTA3t5fwuOcgORyT4Y
Message-ID: <CALs4sv33JL3e=a1LApivnGoWvH_jZ5UsHJdjP_iBtMXtX1nsuQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tg3: use random MAC address when
 tg3_get_device_address fails
To: Ivan Delalande <colona@arista.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, 
	Paul SAGE <paul.sage@42.fr>, Vincent MORVAN <vinc@42.fr>, 
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 15, 2026 at 4:35=E2=80=AFAM Ivan Delalande <colona@arista.com> =
wrote:
>
> Some of the tg3 NICs we use (BCM57762) reset the SRAM MAC address to the
> placeholder address on link flaps, tg3_chip_reset, etc. We've typically
> fixed it from userspace, but since e4c00ba7274b ("tg3: replace
> placeholder MAC address with device property") was merged, tg3 just
> fails probe as we don't have a way to get it through the generic
> device_get_mac_address infrastructure as fallback on our systems.
>
> Make the driver assign a random address in this condition instead of
> being fatal for probe.
>
> v2: assign random address when tg3_get_device_address fails instead of
>     changing its logic.
>
> Fixes: e4c00ba7274b ("tg3: replace placeholder MAC address with device pr=
operty")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20260903233255.GA4109366@visor/t/#u
> Signed-off-by: Ivan Delalande <colona@arista.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Thank you.
