Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792492159;
	b=Mo19Otwg5K3/ZmEaoy+Cb+9A+IYdAzgAa3E3d5huqPmixYeuQUSuG/IWOQKCxijnJIjL
	 IJHo1rnft8Q5Bzekc5M5OgQOQ5kHMmWy+zg9G/vVeIQXlQv2XjeEXqMSW9vxiH4RcqsoC
	 EKQ6UTiKqlPn7Jqe98OahctsfWQdDcIk+8dKlvsIykGMGzA1VqdeZPVJS8FsHTnwxxgPR
	 kwv80khFCL4s1phCBL4E+EeQv+64YShBUkJvkCHljRoiGhYMDZV5/bmpdVUJfnE33o6Bq
	 9c9J3uu4hYch36Wj0tjM1d0kHGEKR8GHdsEx21Jlg4koZX3tufcCOABE1JVSHbWj56A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=DaGQmjJp37UYSV/iBuExkFx+biffzuBEmX37u8YFfQg=;
	b=t8FpyC7rseM4B2tlHOIql3rP1L/kJ4WJGmmoGEIeTwL/UN28ypXWXVPiqn/RwcCKna7Q
	 YukNxwOkGR4hNK8zpk8CZ/VYWsULi31SOAtWdt8kDQpmTMis8uCCW4oDaxookCFawQJ+K
	 oOok9sRdR5dB0S6xXkylbhOSA45gk/u3lABLdv5QcWR9tC2V9NkaxJpTMfpJ+ZD53X5Jw
	 0DCVfSkDpitPeu15eQtsW6ah5Lzjq5R7F+Ksd6oDQb6CYc+CYblJ5j0YWNi2o5D1iIgjJ
	 6YGAoFlXFyO0RxFrVJBeR5sHUb5mfbslL/Lw4HZtlz4ezwuy5j//JG4yIg8Idacs9Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UgnKyVx2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445A606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3445A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UgnKyVx2
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-846566246e8so202261a34.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792492158; cv=none;
        d=google.com; s=arc-20260327;
        b=VI3u203WOc7BK6CeFFbGOCrbwf5ERrmeT5BFB83GyldyyLf2nEglheClyqpAmvxoz2
         k1kpV8Uo2vwDcUpZvA+/NSd1CKdZ85csXENmOb3KbPn1h7cpJ47KWhJl+Nag71USGRsu
         RqgrQV3Yu0pWdwgkPseqkaUBvAbDLvDAcQJ4aMiuOFygSaBTRJko7rUBK6toOwqNv0Q2
         WlxRPj4M+2Lk6zayQRo/3BEdZye4Y9N552MUMN1CZ6z1/zRIfmDOShApSTTXlWJsK7oJ
         xWdtqpainoKH2ugzNirJxoYGKcrQyPX4nyNSTpCUaaDD4BNwNGkNgWBorQ4AGka/D6Wa
         bhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DaGQmjJp37UYSV/iBuExkFx+biffzuBEmX37u8YFfQg=;
        fh=XQUCV8MVMYoJTWnh8edFfwg5sROK3ZX3mt1jKYPRNmQ=;
        b=NGlXus/STN9l8XFofDHe9yn8O/tgwOngQhccdUhKeTklHU6+Yd5ImMB02s5GXa2eBL
         TB6VCib5YwooKhNn5I0KgSg7KW17vrveCVgpYFYeAsXzbLXP6i0ujtLo8OaBE4XA1NFz
         DezIxSEcvkWT9GEJ2E4xxLIAxS5L/HPbVhlzAMJN/UNK2DO23CyKEaEbaec3pll1rFqY
         K9Uiqli4/bYqw51tKauC11fb9b5iUIjXCbwpl/OsQCn9z5OrofcCGp5vbT2Jtchwoc1b
         9mhpKjYpGiuEtf7RX0779nMSZpAw3swgIAM6NXACJ8jM2pIzrFw+IwrCLWlTMqx8XT3K
         7wIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792492158; x=1793096958; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DaGQmjJp37UYSV/iBuExkFx+biffzuBEmX37u8YFfQg=;
        b=UgnKyVx2lESGArjr2dtbpJZ3jxb2VUQkASgb/7srbrB9yEt5S5buntFjZhWHJCK956
         pd+3dJ4g4voSIxoWT0Yt203YWp0OjJuYg5evDFQDWD54kt7mlm1tiypQtc6YwpK/agtM
         wim2UG0abVcfEgQ7eHJe23+TGR/pfnSmijn01DT0zfIqh/5T32ZFtGcjmdAP2SM7kLaX
         RrdYEFZa+nGtPwwBGLiNUxQAchKquKrJX5eb0tPojBTEQmUceLGp9+PBaWXCZe2qh62s
         vZxYvMCf43HvWKql2UJmSrAvvnRI9J9ysDF2pGSzqeuQlEtxugzmsnHozByQIAgdt0GY
         Icxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492158; x=1793096958;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DaGQmjJp37UYSV/iBuExkFx+biffzuBEmX37u8YFfQg=;
        b=wqybKkY7QtlWnHuKPCGUnO+dOz++e+FAFertoV0Se9P/xj/TvnqekTLASoGM9m0PaN
         /qy3o49uoGvfsYmPHzksZnk5dX8+i1u+AcCxeFwBP+Zh0nalXeNOVicT3x4MSQLWEawM
         8oOJyhWIN4WN+JSsHfYqq7sFWTpzrZaEP5/fulSFe9mwntb5Z2AHVRDQXO7PjUBcjqYo
         OpqDENdLigRYgDhtJBpbpjoXrvT3j+EY4Lzv+upHw5TNmMDczY8n/8w/XrhPfSIt0psu
         moiEwB6VzJUdRLWXeZvgkTlU+rbicpLAltz+iGwO7UGIVwr/ijB9WoAHAQWjaIZ5KQrz
         H2yg==
X-Forwarded-Encrypted: i=1; AKwUvBwebjidRgGk467/SofV5S5FESwjm2q4QuBUY6+XMoxg2DHjZXi4A6b/po6NG1KK7vAFnDHmXEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUb7wz9dJOO0WZdAdcSP9VNikIrlZqDoKqbqWfq2qeUs57j7rL
	uyZ1iouse+hk2YcYT3PGp9ntQgVS7FWV8sjQb2mQMrRwQrEkn/SG/eLpOqqLxdv7Hn/ZrfugQqx
	8e7sWri8ZbBAUs5XUaEOmFlvMw/CaDjg=
X-Gm-Gg: AYBFou1tRDPcDSzjxVkKzMSDPpcdfVUqvEJSBLbudKM8H/43A1SQTx+y6TVUeSL3sJY
	ZdXf9fTvUlLOiwMQYCEJiU8ojc1u8fOqJ6oByeAGNUg1i/Wlpvuim1ob2g2jqWKarf+rWtBCNDP
	nAuNSTXBRLCNxFKVgQWzvJ31WORYhepCC0Cpiv7r7MBUbYOY0jHL63DDyLeV22z3dHUNO0yQC+i
	/8nz8Tq3rVZwn9mrG1rwH/auAJllv+jUwUKVsnSo646Pxjtt2w8rCYI+F9VZI4MRfS7tk7GlIm9
	sFXA3WjzZgeZylrNN85vXUg0zQO95bMYANFjmkRDiQ7DBsFEUFRkMmhl7zgEj2W+aQbD1BMLOIP
	U9MEUamMn2Z0q8E5dH7EQKKmkcT5c88wYbMQnZSNxjkBc+DuHzEc1eFLP4RwvtnOiZ60uMH0pUS
	Fu3ZtiwVVGKId7d0r4TKpvFuTi2yVxH8bt/DPSHnlBdVLA7E6F9eE=
X-Received: by 2002:a05:6830:718c:b0:821:dd7e:330a with SMTP id
 46e09a7af769-84b74767c52mr1172363a34.8.1792492158132; Tue, 20 Oct 2026
 03:29:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFcZKTyCu7K=1OOETBvVrKf-9YKHRk7wXNRyZW7m5P0PEPg1zQ@mail.gmail.com>
 <20261015092200.GZ219304@unreal>
In-Reply-To: <20261015092200.GZ219304@unreal>
From: Peter Morrow <pdmorrow@gmail.com>
Date: Tue, 20 Oct 2026 11:29:06 +0100
X-Gm-Features: AclHuK-Hqleao73VUBziUblRp_E3tFyPASV536hNnVlfimnJbooKVRRcaLJeklg
Message-ID: <CAFcZKTyLm3P8Jr31sQSGpE62W=v9+Jj3iZAQ7MNDM1DcXzroXw@mail.gmail.com>
Subject: Re: mlx4: no ib device for Ethernet ports without IBoE since v6.6
To: Leon Romanovsky <leon@kernel.org>
Cc: tariqt@nvidia.com, petr.pavlu@suse.com, yishaih@nvidia.com, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 10:22, Leon Romanovsky <leon@kernel.org> wrote:
> The best approach is probably to add a similar mechanism for mlx4. However, since
> that driver is quite old and has limited test coverage, it would be better to
> implement something like this:
[...]
> Can you please send proper patch?

Thanks Leon. I've tested your change on an Azure VM with two
ConnectX-3 VFs on 6.12.111: both get eth and ib auxiliary devices,
and DPDK attaches both VFs and passes traffic. I'll send it as a patch
this week.

Peter
