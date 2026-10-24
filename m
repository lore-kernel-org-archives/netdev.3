Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792811389;
	b=xuDpH3St/M4gJS8x1aSgkfkKelK+FmExUdd2MIZPThLzz9qlRkhk1k3NV4Q3CN6d6Hjl
	 uIZNU9gnSOHIuORgI1JM8CQ16lEzeRdmeRVSPXHvM1VdIHTgDG/ePYqYyJBM6//JfNTrm
	 BZvbR210hG12zbNkgS8a+6Sqk1zD6W7WbDsnxD3tkaLOyFjoslM0WZZQdGrt+xssAapyk
	 tzwsAo6fvWrdFfEduXxtn7NthpiFtNpSdhiE2Jcg7ofmC0Ha3PXJXIE4/MpUJSkVE8taD
	 bPDBNE9sb65zyLCmvHuYWdRpdmOW7Q5B8KFGtaVvYQKdPhwioWySWNgQnP7Nbn0RERg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792811389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QAHjtGgvZD7WoKmqPHPbo9DGm91Bfbu1kj0a9bwrkN4=;
	b=olBWt/gxOnZ9aUyK5mx2oPCyKbjzGCq8b2gqNglDKSyGiDKbC+1xSKuALYbsd+SeIfMD
	 PVT+a+oq30zoSjILi1ZnrePk6uzvoLpwgP6bO2/Qa6GmYpPm9NPQo1D5G9kE/lqV0z64T
	 /Zhq+JCO25o1MIOxH3WuZW32ANwWUrVXrkCzqwalFvTjAJxFE6o2jCJ2iP6WetXPSefTs
	 CJMFZuKBnQZXschIHlVu7LmZ/jp8WbF2Zq9bb1YuSuaCjAdrZWfflXJtjkXNcICeMnPPA
	 ZScKI+uxPF0p7B7BkoM7O8kOKCCsWXTiBeXS/D8bWBcSpSeSR3Avys3Cn/16QO2q4+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=D1dKBVzp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC7606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 03:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95AC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=D1dKBVzp
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso5513a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792811387; cv=none;
        d=google.com; s=arc-20260327;
        b=c2cfaE6ksQo7D5uYhCD7XLfSsomCe74wP/ovehJPN3pbh5kI5MnfwbnJBdQE6p8viu
         lVi5e1XcJbIZj5eXAasKKJv4ZjqdReIyadnpfKGNG4efluVkVswRr+GunvGO3aha41o/
         fabm/COTUuaE2fTcbl5021Cvu4YCyqqBwhzmDRpk1SJj3sz7JF1UYS/zyhSp4zfUCPoq
         gRxm6omwxqKgbqiqhY7IUKxYK+7yYoZitoCzgTgxrYNW6Hq5ghhDFZ+2QC1cYXgJyjbP
         1/DdxJKviYCZZ3nwolSOW4r5z7nA2wdbCJRDDBgC95SYNRP4Lvk2D1yKUkVabfuPubAe
         ABSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QAHjtGgvZD7WoKmqPHPbo9DGm91Bfbu1kj0a9bwrkN4=;
        fh=jnWe0k78oznrrT6plqI5x2n2dR1chLtvJ7z6cLXqZls=;
        b=Hd/ofTOv+dj7WpZEpOwXIiuf+lhho6IFv6YQxkFA55ExodRWBImhyyQbo1NAgI+Hgr
         J7h+4L25GE06/DxARl+8L0tyKK50LeFMLyXmhqS+ZU8ghfjl/HWGaMdnOrtMvqj7FOTQ
         PJ261y5P8UnTPFfV8AkVTYMgxw5vJofzC/sOdDbja6Ur3pD1hBWwATd6kqn1yaoGZ3a0
         rBuCOkqv1WdJv96WRNqLIu/yq4/UDMzSaeoczi6zrhVXmF+NzhYfU5KtwNBtxJMSGgdi
         FVVeuKS0g2kaKGR95vJrfW+f1cMMGwfzRIQM/SERTv6jTbj/aVuHcGSVlSRz0hEf6FuH
         Kbyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792811387; x=1793416187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QAHjtGgvZD7WoKmqPHPbo9DGm91Bfbu1kj0a9bwrkN4=;
        b=D1dKBVzp++9wVowGSloOqH010pt3WuspzRAXv0p+JqeKzXDzZ1vdOuAVEu7kbpTZrI
         itRhuxwdXB6CpgZBt0YKhFwN3Rm0U3jd9XnTNK3cpDVYpBaUzIlMZ6O63tOEnpPHqjL0
         dlBHf7IAXn9Czt0Uj9NFwhhQotp/ju2HX7cvQ11NyHptV5qJAZjjxK1KaS6UVVobeQ/0
         IG5VHjVlee0LyVSv/OHWKR3BgWNQTfjH67bqFZbygn31p7ZHDdju43AL4TKUfW1O/f1e
         s49K7va/gQ+uye/ky+HN5skgrKgIJ03aw72hboJH2A/WABVFufHt9gfysaP8xS7xLHKc
         iueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792811387; x=1793416187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QAHjtGgvZD7WoKmqPHPbo9DGm91Bfbu1kj0a9bwrkN4=;
        b=JYDZUVnmkG0Y79JPvnqhLY989toSt+4OwHvnGxa8QcOb9aNM4h915+upizpYgbsar4
         CL6UEA+aRgU80dOcX4fc+QlMlqN0Dl++7MQJEB2XBmAu+vXxsymOsfYtJ19NJphNZfN3
         E+x17aW4LgwVZOg1qSfMxDElNdp/+4cVHvfs+uI5ArkuJ7frWYhTO3PnbUMUUF38Uwrn
         rcSuYDTNns0RWryWNoLHlmuYxCdisBoG0ehC4Ki94fcuOxmxGNAyC6DjbaNuHrV2h68Z
         QGzsaXTPEHPmBLK6kCJ7wQ88YPiW7iD7bIobhQjxRbrf42BFL7ODCBUToVH6YL3gb4yv
         kGMw==
X-Forwarded-Encrypted: i=1; AKwUvBwvVwAXzWVcluISJTmH2M5pGnOV5QNlSqXLSvZO6yxi/3Mfc1zc6XCrLIDyim4W4BBFj8oPw6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDF07AQS4Lr1LPX2v6McYCd9AaLdsqdchdyDe3heXWdcswn9Tc
	P28EqQnmlW+efoVhpV+71bTinq16nhjp47ao5lFYivvYeT5J3LvHHVUzJY2IBVj2Fq/9L3ygyCQ
	Q3Tr9MYZxzIV65tn1CN0Wzo/VC/+NtCvx0ZLQahh9
X-Gm-Gg: AYBFou1720yFXk8/mm8fq3M7T/cPIlnhvv38x4Y6G+sOSsrM9fzRb4vBxTStxO2CeFn
	m95pkqKvriGpYaFWB4s91mA1+FOr3tLAJuvu30SwXY/t2018RnuiotvA2yoXCrdRsgFt9LhAvEv
	ajQtZuoTe8khbYbyoJWg9zpTRZ6EfxaHsU+gNu+xvcwLC5WU5EaAvZOvOGbVoE5DYToKuQTszgL
	A8pDNqLB/GY/fpbsXIJbZcypP7ekgJWJRt/Yzudu5gVrNRWqNLR9Qnij2jqHnjUafr2lE5zQL0o
	Vn/xPAb0jte4vTzbOZHQHVj1x0QigazHeMuV92V7KG4UsGBHOvbTTsDXY0GqBS4TqLqjvUlbIVB
	FGW6blegYJNurftpClQ+jqdhf/hN+6XPv+Uew
X-Received: by 2002:a05:6402:4244:20b0:6b3:87d4:d849 with SMTP id
 4fb4d7f45d1cf-6b445742acbmr18769a12.10.1792811386607; Fri, 23 Oct 2026
 20:09:46 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024030401.852598-1-almasrymina@google.com> <179281111897.3327.1602182931669010390@kernel.org>
In-Reply-To: <179281111897.3327.1602182931669010390@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 Oct 2026 20:09:34 -0700
X-Gm-Features: AclHuK9aQ9mPKuc8syQv-nOHKlvMhCXRxy7Cv7t39JmN3yJsSBB9ExnYbakGgzg
Message-ID: <CAHS8izN1uwKZm1iyQ6kg2=81aYTPw5jQm8hxvvsHVtPnZ3yzMA@mail.gmail.com>
Subject: Re: [PATCH net] idpf: free the skb on TX DMA mapping errors
To: netdev-bot+sinfo@kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This was found while we're working on an unrelated feature that
involved dma mapping/unmapping, and noticed this isolated fix for
unrolling dma-unmapping. It was tested on IDPF indeed.

--=20
Thanks,
Mina

On Fri, Oct 23, 2026 at 8:05=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
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
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.



--=20
Thanks,
Mina
