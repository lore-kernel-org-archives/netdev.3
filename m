Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A73168EE
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953911; cv=none; b=fvsKzwVoH9Uu7g0h12BSfSks0hk6uOgEk46JDq11LMuDCcu+6btylMOVbGD101RwJYDyHvnq2RPOu/3Nlg3HR6l1h/UXvi9ktrxtzWX8SG6kpI52XIvrEiBTytvQtpZEO+KXCeze0gxaBTF5r9fm57vvJfQql+xz8ofowOmjLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953911; c=relaxed/simple;
	bh=ClZ4xaF+75tE/H7H8q9CGZtUI27S/faw1Lq5OD0A4j4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tF1J+Mb2J/Uu5R5RDwlwnUNJrz1VJSyFZJTSYZy2JalqM3VKkWsI2Xla66CUVtLfTnnLk/tsHh5oOaP6Xn53OQ0z41D/Co0tMrHkqD1qlfYRVeluZLToCX2JPdnRXZ8qckxndjsoKCLW2H+Oo//sPceeiaa4qQgaALAu0XsouEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8gEW03S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6dh0Fle; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8gEW03S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6dh0Fle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776953908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smVdIyCG1HCwZ6beFTzK3ARuW1P/bvxD1KH9T2KrE50=;
	b=E8gEW03SNP8Dzk1whcCh7NekMfazmj7GpqgIUAjSM8xdH2AlzrL6mXcB9hvr7Vt+oWYMcP
	EQVpV8z6fcAlvp+FOgVWum0a/I+LODONqtUEkOhI/5QFgFMfMALtX3vDdUT+9rKuwE05p1
	ab5wS/k0ntYxMMaABQxdmvJjmSTDvOU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-z3mqspqpNFWlFmlZnNu1sA-1; Thu, 23 Apr 2026 10:18:26 -0400
X-MC-Unique: z3mqspqpNFWlFmlZnNu1sA-1
X-Mimecast-MFC-AGG-ID: z3mqspqpNFWlFmlZnNu1sA_1776953906
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b461b36990so71592275ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776953905; x=1777558705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=smVdIyCG1HCwZ6beFTzK3ARuW1P/bvxD1KH9T2KrE50=;
        b=R6dh0FleYiWofxxbOq4X2pBr48sjmZd3DKgp2v0QkwEnasWSTFaQo61VJFm4/cBqQp
         ap2JHOYrBAvupC6v1vRSwSKtS2EPl2+yJuP2Virvfn48hDzfWWRrHl8UXqpS1yb+S9Cc
         8YNJpUXhMNWKheZBcSaBEw6CisQYF+zQPYjpFcp4JNbMOhtVgQ0dohvwcg1fBxLRmSZW
         pkFdwjDGtNuhnDugilmEe9OkANA72xKwAmG+O72AdPqHdKopYbUQGm01VLXutzXCVYTm
         UYRjsWcs8Ei+imf8ZiUGSrCsGmzO4/VX3WgOB4pg1GS53oEkzLVc7FyZnW/GMZmhjvda
         WByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953905; x=1777558705;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smVdIyCG1HCwZ6beFTzK3ARuW1P/bvxD1KH9T2KrE50=;
        b=Is1MS0JCM0LlFkDFokCE2np+nkVTv4IklTi1ntxLesPQjLZt88OUYyJ58d3qkd7fI2
         jbhNfHvAHI9fXQPifpALQy2vyTB2q3Zn/TVyDv0BdQMMXR4L1Ui0SccS8piTYv5hOrzn
         0pmhfkgcQyili3lWoNWLUXDI0m218SwuXMNPBL5+uwv+CbHqa6QjvGdKDJzfF30U+DDa
         h/j7pMoOM+gE5ej4EQmROTBoiefVR0U5jNVs12pVcm3xEs7hyq9bRKM6CMe5dyRLM/LO
         yZPsaYvvr5xONmfUeh5/eXPoxHmIP0kzQAtF1oOegxb+thS1rMJ+WlDLmyhblvdZmwkt
         fRfQ==
X-Gm-Message-State: AOJu0YxSELJSp5KCtIXorn0vXM180XQXeElpOnMNYFY0M0IxmlBNPwmt
	DZQJWagTYrcFeJp5CRoGj10W1aroDw/sMqeIQPNGaQnfyP1WlC4grqprl/r/Xrw1sYTmD+HWrf6
	ghpcc9VZcsFrOOOVYvwKHwu2gt/ZeBhGd+4sISq2yHbGRtWoNo8Bzok4fSA==
X-Gm-Gg: AeBDiesyYRgJMhSHzeDWwCZcjI54LvbDINkNPjHrm3ovloCAg7/qmWdavwkGMZuHtsf
	XRnISLat0DatfbB4z4bhDPP9NejbARS9LbjhWl0fz30hBa/CmUkORCNBbtKP5sHAHJFQOT412fx
	Vahj4N6jjYcB6f1E5qRODnkMaozLOpz1MeJct+AIwAhWMiXG6CEdHDsMpYdw7ZnOuQvrGWH0IjL
	plaghLxBbsZKuy0UaTS8QM9mhmNGP2OVDK1NMxe2/z4LBOhOtFWIDQSD0Vi70gzTl+f4q4oDFtn
	506wPVFdnEUIOYOxwOVTxLy1GMX5KggOTaWgrFHjv2WwEEete45s+CF/FZZXS/kGmsnN6sPlW1l
	6tGDj6K2PVN3NC5elXe0KjlZlywyt3+uEIOs3NXcJ6n3GjvQmgaQUMBzReOAYCZmjbbQ=
X-Received: by 2002:a17:903:1a88:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b5f9e85ceemr278654505ad.7.1776953905279;
        Thu, 23 Apr 2026 07:18:25 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b5f9e85ceemr278654025ad.7.1776953904639;
        Thu, 23 Apr 2026 07:18:24 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20695sm194915885ad.56.2026.04.23.07.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 07:18:24 -0700 (PDT)
Message-ID: <534ef6ba-e4e8-4ddc-aef4-196e7a91e81e@redhat.com>
Date: Thu, 23 Apr 2026 16:17:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 federico.vaga@vaga.pv.it, carlos.bilbao@kernel.org, avadhut.naik@amd.com,
 alexs@kernel.org, si.yanteng@linux.dev, dzm91@hust.edu.cn,
 2023002089@link.tyut.edu.cn, tsbogend@alpha.franken.de, dsahern@kernel.org,
 jani.nikula@intel.com, mchehab+huawei@kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, tytso@mit.edu,
 herbert@gondor.apana.org.au, ebiggers@kernel.org, johannes.berg@intel.com,
 geert@linux-m68k.org, pablo@netfilter.org, tglx@kernel.org,
 mashiro.chen@mailbox.org, mingo@kernel.org, dqfext@gmail.com,
 jreuter@yaina.de, sdf@fomichev.me, pkshih@realtek.com,
 enelsonmoore@gmail.com, mkl@pengutronix.de, toke@toke.dk, kees@kernel.org,
 crossd@gmail.com, jlayton@kernel.org, wangliang74@huawei.com,
 aha310510@gmail.com, takamitz@amazon.co.jp, kuniyu@google.com,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org
References: <20260421021824.1293976-1-kuba@kernel.org>
 <65cf5447-9876-40f8-a802-ed21b976a91c@redhat.com>
Content-Language: en-US
In-Reply-To: <65cf5447-9876-40f8-a802-ed21b976a91c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/26 4:11 PM, Paolo Abeni wrote:
> On 4/21/26 4:18 AM, Jakub Kicinski wrote:
>> @@ -2316,9 +2316,6 @@ struct net_device {
>>  #if IS_ENABLED(CONFIG_ATALK)
>>  	void 			*atalk_ptr;
>>  #endif
>> -#if IS_ENABLED(CONFIG_AX25)
>> -	struct ax25_dev	__rcu	*ax25_ptr;
>> -#endif
> 
> AI reviews notes that this leaves behind a stray doxygen comment. I
> think we are better off with a follow-up that with a v2.

Or even better, I'll clean it up while applying it.

/P

