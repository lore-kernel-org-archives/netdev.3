Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793748916;
	b=49W9yG3M5P3iK8P23gDQy+FISPFl5JRRsjCZ0PROcYkp10jCnVLSl5KOJNjL9ET6h6ST
	 fW2d9vzzp0SlfPl38uANA1mymEQi5WSarAAQA3rCobD+WFZj9zSWUNCDrnMK3CLfWcNri
	 /hZgwXP0opoe5tP/JqbsKGGBtJQ0FsyaRmN365FqBVwUzIBpslRI7HP78E6wb9mMsdi3J
	 RAgvfoAjhyMckuyd5KWqLu7CuFxLC6Dnp0yNL2B33mfZsb9e/ZQoEJbojvf8VCwg8Odx0
	 Yuy4tvBXFjTuwVVq5UqRQzj0A6trH7vj1/S+IpoQv0KUiKc81cSsNTRF6UXz0unnPVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=nKxJiX2hq5njbsbRPPasik6GSDqBNI5NA8L85r6kDpk=;
	b=V0hOceQwWNm7SYFD3lAYea0N71xB/Zt+G/a9+BpQsGqJLFGaitfKHyGqtFZjf7n0t/LJ
	 N5CNCw4eYwM7vRyOotsU/KSHwZlNCeOjJbvEnsqO/XU4S3QessIOPTnQ/chqtdv8s8qXK
	 sIz4dz1C+lV0Fm0Wz5aJJVQOYMZzZUDkus+T6D+Iz+PHvYrjK8hoyhRzKGmNeDDJmHlUI
	 tdzDzE9D6S45so1SFAfP/ioL175l+dzr+FQTMQd/YPm5iY4blVYx2godvEfuLCLv66N11
	 vVr8nZIOFaO7HomAU0OfMCcIUfcDf711ancvA8KJ3EAtCMBK1otwAbEDDJrG1dlSLpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxTJ+4aJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E28606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E28606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxTJ+4aJ
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c73c63116so1981946d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:35:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793748914; cv=none;
        d=google.com; s=arc-20260327;
        b=P2jmtb2BWKh1wOZn28Srbf6azgPuthXiHy3/p/KrSut8HGDeoiXs0LksMc9uO9q+ZF
         br34gDkJ22JXP40FwaYpx5iK/0hT88OqaE+BDiNH1PxR6YddQggemtV+kaLyiWWWVN+i
         HSMPZkwLhRM3z/PI/GgoT9J1r5ne9sD5+U1qneBbCiJmHPotq2wsGWaapCDX9txVp3L5
         0yh+uk9RNAxPdLfnjRI1Uap/jZbcobJdiZQbzO4MlQHYlPsCdDnmGPKOHKZlwcT88xkx
         DkaUuM/UYQXd4tc52+mkwgzYR+IRmST0fSqEAFJKdyIrBjT7pHMTnmZZIY4c6NxeJeSp
         DmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nKxJiX2hq5njbsbRPPasik6GSDqBNI5NA8L85r6kDpk=;
        fh=upGGgx/ImqNXeOoZiuJiAEw4lkASZQtilggUoQDSV1Y=;
        b=ERHeS1poHjM2C3SK5p82djtMpSZcKa/1KjEZcfT+oSLSY4M6TmGR6sakfjBUL/5rzt
         IF8S99+O207b6R66y8Oye6IB4EwkTWVXcKmp27dfgx+SAlOog54EhEiH/qHZ+2zDsELF
         rT3mEZTOQhOuW7aoELmyYDZmc6bgjum5L6e1PYlat2oOQMG+A+8/NjZoyS+94VPlOOy2
         ROgE4m6fTRr9E/ZamMvvnb86OM0NUoLQBwy7ju/02Bf269F9lMWqgb/KsJLaivE4T6Cz
         KNAJaEbDjfwY76+AAWpuemuQ8F4/uZ0dWaGqU5QPWlQmiyUhGBWahEBxWCDIxqelyeTm
         mVOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793748914; x=1794353714; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKxJiX2hq5njbsbRPPasik6GSDqBNI5NA8L85r6kDpk=;
        b=VxTJ+4aJ4hoGXlN0OEblscqsEQ8ZIHoVlcPvCs4QWOtOxiB6KfhsX9LnWXJ1+88jC5
         0JTCj2E5N2/3fs3r1e+RvaE9uLU+ENzivEnj2ssqal8mv3UOGemtl16V1KRc5jm/UX3C
         RxanjYA2i4+D/A+cmNKKG0E8C4enpHVo0ZPMBVFtUDmR5OiNohPGtyk0ZJGJRTkv93uX
         v7hCXNF/t2IwvnBd8lnfDtMCDVh7ykrqTzVw9MjHzF74JPrJRs78yx3S2MLuciYisYU+
         qAU9pf9YwEGQt2oG/HcPePOzm8xYVcD/4WEYZIKmHy4+NwBYlOcYGNmtY8HhfcBa5r8h
         1msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748914; x=1794353714;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nKxJiX2hq5njbsbRPPasik6GSDqBNI5NA8L85r6kDpk=;
        b=f5kOYssQUeGln3qHzoYSQQPW3CwfwCgPdBsfXaT+lKzP7UNiPkBOmwcGjtDCU7O3IS
         TEOSg4fcg1wvew3kULz8OkJxAcwTAT4uDdjqc1FhgzanvT7hiIFOGoohdOHxWe4jK09n
         d9fmUQ9GVlUNHsFsXVJ0o3n2MBhFQSygXOZ/0tpUriFvr5uJcvXrhgsa68CyHrNxkj/7
         uSktFAEv9c54HKotDC0WNmS4CHg8No/d37c2GVla9OFDFVY/vxxN/K2sRyIhzrtvUEyh
         /wD1O4F6RDbBIhmhNUUvb58X9cwd8eRtKjycNyC4lvwWb2LrxlU+sNF7irgyM/9NHMQ6
         gXmA==
X-Forwarded-Encrypted: i=1; AKwUvBzOBI4nMeUuwMyfJ0RKBH3IXMNJeM7GMqXTgc/lyUJ1R3C26lDi/o7wHgogTbKJJWzBkBegidQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oxd7YAQlR8bTHhhijFIkguYkRP690uixaBpTPaLxOReb8wvns
	osUuDVpB+8ZZmjBLhCu6NypG61yKi/x0nJJ1R6YLhIPBHghyQNmE9G3WhnXj7K3j20RCOJKuAty
	21RcaXL7hb7CdmN3sCdnHzIqpMICD/sE=
X-Gm-Gg: AYBFou3Wl4aN0KOL+f6bop/Iqx23hu+kJ7cTSmoUVXbJSP1NrG4LUsxBWwtChY7pGYt
	3i83V+J4mDRRe2npeAaVylM3I9CY7ZyMyQ5R4ncUxhC+oLg0WvGLxFW39EA56M7WeB7rvFji8xr
	EFfGC4bfCJrmMRwGuYFioVL0DmAqEEHo8rgXHtN/g036TVgTXckyYsXVrINWUYtq2mH+Y+83wAR
	nkqhJe/vW2CMqZsz55/n5TQ3vrdJe/qrWe4Hsw/fyuzVBSMxOShduQss0dxlOyv9Ed64EeuzOHp
	dt+dpapsRLDfTP22JfFrqD7Yoh0yQ5oaihe+4d+pEYxN5+RhAe2/TV2urNo/avYjJkMlw7KPJAn
	p3PuFJYcDPJqkkZOWjlu36Kg0yBL4lJHEwLEaefp/BXN4fRLwdnyYetKZRnXpnzA4iX5bMmGdtC
	Dw30oMhkn7IivyWDNE155G8BeDokt7xBeFroKgG6DlAdE7RZrVR/qKv3jU+4LkkKCEOxRGVujpQ
	dAsV9cnrizFCJFBWpveoDm8MQ==
X-Received: by 2002:a05:6214:300b:b0:91c:7f1f:2c9e with SMTP id
 6a1803df08f44-91ca4c1bea5mr239516046d6.55.1793748913967; Tue, 03 Nov 2026
 15:35:13 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com> <20261103-keyupdate-rfc-v5-4-de1ab90a88d5@gmail.com>
In-Reply-To: <20261103-keyupdate-rfc-v5-4-de1ab90a88d5@gmail.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Tue, 3 Nov 2026 20:35:03 -0300
X-Gm-Features: AclHuK9j19hhkEsExp91lQWmWztn20ZPkjs1fSHVQiEkHUWk4-OotQ7EK4u8uqk
Message-ID: <CAMAsx6d0kMWT+QLBVGnGjfbEUDuOfrBaoCaizMNKZKn+NmkG=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/6] tls: update the RX key when a KeyUpdate
 is received
To: martin.belanger@dell.com
Cc: martin.nvme.dev@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kuba@kernel.org, sd@queasysnail.net, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	john.fastabend@gmail.com, hare@kernel.org, cel@kernel.org, 
	alistair.francis@wdc.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"

<devnull+martin.nvme.dev.gmail.com@kernel.org> wrote:
On Tue, Nov 03, 2026 06:57 PM, Martin Belanger via B4 Relay
>
> From: Martin Belanger <martin.belanger@dell.com>
>
> When a KeyUpdate arrives, kTLS blocks reads with -EKEYEXPIRED until
> the user installs the next key. A kernel user such as nvme-tcp or
> sunrpc never does, so the connection stalls.
>
Hi Martin,

Reviewed-by: Daniel Pereira <danielmaraboo@gmail.com>

Thanks,
Daniel
