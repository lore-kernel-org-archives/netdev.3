Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329998;
	b=Crd4wNqmsmsB/bvgr7yWIe1OvHs9TKVbcdEaSPzrzISmVPW0yQTOLIfTjFl7m3DGsF7W
	 spHgUjXp8iCP9N/WHRzHX3WIzvsfvTEtBA8YjHhLKEaRm79yausgIbblqgcHpivpRZ83W
	 X+s37XovsNkixoaYZWit5uwNUZi8iUbVhn7E8LbrxPuT4fcvLV/kUJLbG7Lu9/1cUSUo3
	 bY8WX8zYAEHzCsN5va5x3JQrAAcar+oTWxFOxSSvELy/iN8bwY05Rep/8/K7m3aXThKVm
	 MFid2uGPO88jb7xJnu9RDD6dK0tQMBOOfnlNw4SwnRgt/CE8lIa/NmL4N02ttwLqf2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Kf7w354TnqYFz6mNyIxqofoq3s7JBFyBYZ6UqKXQCes=;
	b=3BGnNB09r8jh+2omIPh/vt4vMoOHUrWimG8H9gt906SCvuTkleYphG1w9kGnbULcCQQP
	 XsjUqcA0w5fZT+I3aC2b1KrPsKh0Jz7sP4IWRzVB9LnmQu3bH7NmGyStOBDyzH6FmBzks
	 g5ol4VY1kWSDOupRBCE7FLroAOuMj0wJHIq0EFgOkT4GD552kDnLDGvUGp4RsAiJd5aMJ
	 aXVOScs+0efLeuL5tGAEqdkn/VEF+nJziCf8HZhVFHvBA/8VWm+bqSLLSLM2EhquV1m72
	 5YIqE+fZzqYs3ftyGep7+L5lkVJjOaPpxQ1piVSrhjyJoffY50SyVwA8q07dPcWEbfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VMlRc/dY";
	arc=none smtp.remote-ip=74.125.224.132
Received: from mail-yx2-f4.google.com (mail-yx2-f4.google.com [74.125.224.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A5606A339
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 134A5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VMlRc/dY
Received: by mail-yx2-f4.google.com with SMTP id 956f58d0204a3-67603b254bbso482761d50.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329997; x=1794934797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kf7w354TnqYFz6mNyIxqofoq3s7JBFyBYZ6UqKXQCes=;
        b=VMlRc/dYo0gG+xfLo/0j8ixz2semg2ZuvI3E8PQY+x4HxTGob782iCF9vJDNiutK3/
         cybGhnZmlzPzZ3o9Dx2IZMw06MVNhJS26tA826PS2yNQiQc+i1Xz+laPs3C5xf6uTRfx
         E9iARkRgmd7apWFoaDw0aSKRaohSqG3oHo+EyOSf8CFEM31Sk5iAhgjyY3NU6lwlT2DG
         2CsbJr/caRHdjZi+TYdtEY8r6vjtFqO+XkM8si4qQDTYLLTw8LYznx6kmOMxt1YLo7qK
         X9YaQ7p/whE9IuG6a5jrkTuqcLQgiKCiq7OqnQm3H+oqDVLLodeSQ5PWXxVYZPKmSiAg
         oQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329997; x=1794934797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kf7w354TnqYFz6mNyIxqofoq3s7JBFyBYZ6UqKXQCes=;
        b=z8/hrI81n2gB0MmDLdHvcKIjrxEMEfEm4BDiYKLAtA/CEIg+sjIltZYUWxFgjWTtMn
         Q47BtDE3sBPLaeK5vyYOXsT4/OLEc73GMqvPqUC9nov5TVvJxIyzTzMeHlnZAx7cPOxc
         UK0MNl0ihjn2udRxap1DnEn+h14+/z0rUMe2UiRoJD462qsZ54iGftV7bLsoDv60nRFz
         wmGtzmS5Rh84PwGXyNz+SGZf40IwwgXEfsrRU6sdzJcBhchDwwHkqftkvh9zztHfLouV
         ruvO3PJpqmLte72+3cxKpHL5ofM23xCtshkRp3lsggP5/6ikWSVcl6SBVgk2UqaERHwa
         Ma0w==
X-Forwarded-Encrypted: i=1; AL+hErFpfaMKYyJyTY/QrPFar2+r2M0JLivcMGk/SOU1fWMetKgrPThpyXiOvoUOkfUr/GSCBybdQ/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4jCMVmGapWc+P1NFEsJcdVxZlJpJ/wpwgVVBj/UtCio1TQM93
	VIo0Q4daj0zxD5Hlz0yjSW/xlIW2fVsJyo9il0zkpwEHg8YJiLYqQJoK
X-Gm-Gg: AYBFou09AGqviAT+h3BJAYNNquDhK1EDR05YevluQW1QT/r1dQ9HTQ/m558ntnK06yp
	9AzLzt+UiU633WHaO1nRqe4ReXB+8R5hyrrxT07lTr/exvfxgsk8V/W/7Aum/Pi/UeP52eooLp3
	OyKUdMX39cdq/hvOUXrw+tgytfrriCoiRgJmKSXT95ZXnRBPRfoCQ0rE+7C0OIFgyn3TLZx1fXS
	67m6x4pho1PSO6HOu5S4UJvATf2uBGgXAJQDUbnLpkD0z/Mi2idgbtvLJlkko2Xl/P9R1Du2EIN
	ZLaJmHpfKmBLzqTR6SlNz1fyUwMdWnS9dn4NBcplYB17fcIvwK9NJs7hWlUX77A6Rxgs2KeaOKM
	x2h7vSHltOOabjpwBLiS12GAm1nIKT69j+niAmmV61BDjFcgcf43k+Ftf3z/8P9tmuJOL3DjK3J
	lEW7bKsvlw3fNqC5qS9fVmCm4Z4X1jCMGn+pi+LBs1rHjlGSOG7fQHYAS8Y3gO5a68zKCZPEL6p
	EPyunjrkjeBLVYPZ44X3i416rczjoPfJVInmV+5j/jatT1W8aJirRHz/p3BEUxaYHnyT006upFD
	ZWqahvKKx0Izr8s1aROLPfJcIAeUL4eb+DQ=
X-Received: by 2002:a05:690c:e211:20b0:8b0:6d2c:1895 with SMTP id 00721157ae682-8b392b410d1mr14729287b3.32.1794329997081;
        Tue, 10 Nov 2026 08:59:57 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393b2e455sm22746087b3.41.2026.11.10.08.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:59:56 -0800 (PST)
Message-ID: <85e09745-7bab-43b9-9982-4428f5b61750@gmail.com>
Date: Tue, 10 Nov 2026 11:59:55 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/6] selftests/tls: add KeyUpdate tests
To: netdev-bot+sashiko@kernel.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, hare@kernel.org, cel@kernel.org,
 kernel-tls-handshake@lists.linux.dev, alistair.francis@wdc.com,
 martin.belanger@dell.com
References: <20261105-keyupdate-rfc-v6-6-99b695f9eb4f@gmail.com>
 <179424471492.994134.1896421329544039632@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <179424471492.994134.1896421329544039632@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/26 12:18, netdev-bot+sashiko@kernel.org wrote:
> If the AF_ALG hash interface is missing, should these tests skip rather
> than fail?

Yes. v7 will skip these tests when AF_ALG HMAC is not available.

> This isn't a bug, but does any test check the next-generation secret,
> key and IV against an independent calculation?

No. v7 will derive the next key in user space and compare it with
getsockopt(TLS_TX) after a KeyUpdate.

> Could the test also check that a KeyUpdate sent from cfd now reaches
> user space on fd?

Yes. v7 will add that check.
