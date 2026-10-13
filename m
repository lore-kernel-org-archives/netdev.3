Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F03D565A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887235; cv=pass; b=TrTyPlP29YBtICEMstEWqhBXRdyO9AJj7kHKuRDvKO/FHGiq+kYWM0wBEMdMcksdFx2PGoVKeRsiqVh6qVtDfcT+Aq1M4sFxZKbTJ+OUMB2DXgrviKkv/efl92XVWajWqO+vB01fKiL24CxzSdfSpRXI85xoedyNXEGmwTvN0e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887235; c=relaxed/simple;
	bh=EvYg/nZFolqpHH6bGHm5NPD/0IrXIoVtlIW4jSDafKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbzKj3qrPcq21+2Uszij3MXJVKjlXQ+qpj0Cyu8a83wT1L23baOMmusk1XtxUMU9LofWFOcuNMKQOYuwjwwD5KS6Zq1/WLCj6YX19xfSo6a3xFvmLpbSXkMyAd8MCQ9dgsszFTXe6CXXupH75lul7Sp1G/prP7lD3R40FIouaOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfIxWMiJ; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfIxWMiJ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6deb848ddd7so1809795eaf.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791887233; cv=none;
        d=google.com; s=arc-20260327;
        b=D4C3lmkoFDpUcSEaLlLWT8A7C3/8JQ8oKWSzDDtWPUaLIKURHicYHR7fQPwSXdtr2W
         S3SStiXEIRRqHgUz5tNfhv0kDTZxBXrOsjMEf5OR0DoBLQlEHN23c14FAvhuu45FuTFx
         bHuq0WFTuwyFHQKc+PoISRt/SCVBfrcfg+9QgFZDJmqRhNVFaPsq2y1da76I2iDowUlq
         pP9qiYHFKFA25X1t7kkA+qnIkbltLjpUAFFvNfpafuGIVriui56fwmPpR3V81rQo9/Mw
         zMbE2hMGoX6J6DUKJcK9VX4R8hK9u+1ZFTd9WGP0nCvKEjqo2zUGObLYGVqFrhxmKSDq
         Xp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EvYg/nZFolqpHH6bGHm5NPD/0IrXIoVtlIW4jSDafKQ=;
        fh=rvRL9wb5QH0sCG4wohn5BvcwarqA9Y3ukITxlTtLUVU=;
        b=Rn18Ngwjn58k3li8j2bQ5dFLogvNyT1bh4N24sKDL+645eItJebYNZChplKEs9LJko
         CxdO9WoALnyyOXKepVuwAbj6HVOF0ljRq9/kkjnjYuXYuVghlPFgNIL9DkXxYSHaNka2
         rIIzQfSt+q9aJK5TAZTbfuz3OtKqMwipPSS/NPD9Bn7ekfvl5WRuypQXSbxzR1KlppTs
         rrcCRFL8qxe817dedBs3aL43EqOAdRON5N285kAjQLL14pcIFenpT90HJr0VwQI0dJQO
         /HOeGwYPOdxgZZL4ygy4Y/W8PJ1ywoacxTB7ZpAcciVdM2MhacJmt0dVBpzUfpduUb2g
         veMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791887233; x=1792492033; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvYg/nZFolqpHH6bGHm5NPD/0IrXIoVtlIW4jSDafKQ=;
        b=SfIxWMiJkqp6kmt48++eyAfDJaR9KlsXFMETo/S8Bsf2Ds/L3W/HTgT/kiAy245Hrm
         Md/pEww+uTrpeCm1Bnm3b08NwMILnVUQr0WO6ZQSXv9b9BJsmL/V3+2iRnV/4Zd0s4gT
         0nSfvvqsoY3Nb2TYBJ0Y8hJfB1w9KfgDNYN+nKGokqVG7cFluCYDrtsliIB1sS6Eo+dg
         jfch+Rcgah4YwfQ1aufIrdBANrw5bQIaMJr4w2VKlOsviHtIsjicIpmdR2fLTTxF2Olc
         zCQiW7Mz0fDgcVqTD1ChhKgKwwQbfWO/bPHrK+4Gjh0TI2J4kVGY8rODwXbKJ37KcLoD
         scRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887233; x=1792492033;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EvYg/nZFolqpHH6bGHm5NPD/0IrXIoVtlIW4jSDafKQ=;
        b=UvDZqvTYEBLkGChr59PCe6B+MXX7c7SB4SCtjMEi/6bGa8EZySIkg1ZiZhn98A8Hv+
         fhYICkJwe6PjP1JQdu4/I/WG9k5bcB2t2mlu+k07SP+r7Y0BeDYWBl/OTaszN7DBnC4G
         CQ9CM9ihjF1ZfYjaT820gStaVQQDqM2H6O1g5FfTrlSwMGh2pzwn/9rhAkXhZDuTF4yo
         O7UwioEbQQm84UmaFFoex1w/SV/NxerjRdtK7RvyvhQ3NfqnJy3b1CoQ3mEYHVrFHDdp
         z94WZAmgC4o4HtY0lkT1wZr81G+EK8r4UZ19oYGr5KSg9ndGyPcS9jz9qFj7qYx1L1/Q
         /m7A==
X-Forwarded-Encrypted: i=1; AKwUvBxtXto5X+c9pT9iybCUOVOsrrUr8gGYftdjrNb2lOwuH/Q/zDqTYW4H44LwMYdCmShCdojgGq8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfMziS43bXUamyh9q+Si4PRz+2t1wYx10kvPjha0/3NwLMeKEh
	sT95NgprU+v6JdMpd82WohJNcUpRjLsc6/nuD+mhrBE8/oyuXrJCidLqoqKMspRciyg1z5FeVU+
	7stDChDAX1Fms0Xx2R5UaClfbIS7jB+A=
X-Gm-Gg: AYBFou2hsI2pPc4pnuxxvoC32l2GA/z2v+lXtBuHTHv/4gNS6Gf17zGd7oWkOfmiANe
	InmLevjLBOy5YRuLLSfo/ocLQk18IBn3ps9NeSHEVPV6yPkOuGzI8NzPoqBJ5LdNRCXsELl4Z9k
	agoGaj8/Ob+R0UGm3QNf+5BtLZziC8P4eDoBLYuBodPoY2ZCZML3ULpdgcOZnWob+UdlpcuBmid
	273tYfSv2qceQMb6dCfogBkUPGOaxS11Hnt2E1LHnxJUrp8ifFRh8dz4JtJdn3/4vtyFdHo27Ey
	8aU9pOh6TpVHY7wMGjBfq8Q+joU4jNYbrFn47aNvvApH6WlgCx0sbYG/hzCGDdd0SSZM7btZz4Y
	mqq9AeAig6ko=
X-Received: by 2002:a05:6820:4b0d:b0:6ba:3635:800f with SMTP id
 006d021491bc7-6ef12202b9emr8317434eaf.69.1791887232748; Tue, 13 Oct 2026
 03:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012011707.3378-5-sigefriedhyy@gmail.com> <179185710223.434549.6133926948819737320@kernel.org>
In-Reply-To: <179185710223.434549.6133926948819737320@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 13 Oct 2026 19:27:01 +0900
X-Gm-Features: AclHuK8JAnqsEY2qHAL_CL6PzjdPWfJwCgFSVzJgmZ53WVtZSl4NqYxxzMIIVrs
Message-ID: <CA+7S2vK5iSraGLz2BP_akbYMHAtjV1FKE6KNx46wZNmuy1TCew@mail.gmail.com>
Subject: Re: [PATCH net-next v11 4/6] net: add AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> - [Medium] dev_mc_dump() is registered with RTNL_FLAG_DUMP_UNLOCKED.

This was raised on v9 too, already replied in a previous thread.
