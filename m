Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248960;
	b=IFtjzQ3qXf/06t9LmrrHF2Vwtddbu8pMRR5L7hbjjc8NYdVuOzrcIphnTOYJdVMbRtoH
	 M+R6OQan4XHULBfyXfup5lKaYrfhjZBbWiV9xWuCEDrogw71q2YbCOca6Hqt2T3odmdww
	 RHIwKOFP1NzaBtbua/Hu9/gtlezEEPWlnLEu7tHeMqy4yokeCIShukcIbwkDg1+XpAag2
	 uXb023XLTaUnGT8SlwMdBxeGQapV/QXuuWoM4vaoMj1ZRyvdDur+SBmJ/jSnDaTYP58eH
	 xC1Cy1ZccZAXNKzpipFbShUOjuX2wB7sUE6unQjwmkCksnKlApoT+OHnYGj+d3Iybag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:In-Reply-To:Subject:Content-Type;
	bh=U9tBWhRBh3Q/NIaZ7pvcEWgchBntJxEwV8o5plMJv5s=;
	b=J3B0qrJ09DrH4x7v7OFKJFcSSApiy7yPcNxU8gUn8DzaDt3sjQsSwwABNA8G5z/+qJQI
	 iKOnfBivEOcudBSSsYMFoW5J0sJgX0CiQummACa1hGTxE4DWMFB0OeDsXtKVa/wDZwLZ+
	 ZjQflSPue16m0iM9/tdaqyBfQ/AE99mstCGv2+dhhm3FJD+Qlr7BjSOsbjWSFjTqpMckE
	 fraJVJ0xYm1Mp7a4rXtEisVb+K59DdrEfNvcrc0vuxJDGhYGVvC/QwG0+kTUI5X+NoJfU
	 IjCGhbgYkYlXxsa4JzY15a6qK7PsM4LRFPtGsnBMtjdd1IHGpOo1NBfIddQX2x8tkPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+g8qHTx;
	arc=none smtp.remote-ip=74.125.82.66
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9D606A5C7
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C9D606A5C7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+g8qHTx
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1021712c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248959; x=1794853759; darn=vger.kernel.org;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U9tBWhRBh3Q/NIaZ7pvcEWgchBntJxEwV8o5plMJv5s=;
        b=H+g8qHTx/1ABTl/J0fYJk8LmReb6tQX8eqOlhMogAupx8Y2+3vIn0oTm0tGGP3USEg
         MA79rIdUVkkQHJXzuMLCwiNGH03XRFTZ+Whl3gw4xKlMuZlAPwQyFzIPepp20O/9tdOB
         KO1p8a+HMsYkPSqgOKZWOdnuvMyJ5CNaLDPKYW+7pUscM02XbPSQKdNsKpo6G4voGoqO
         etYxNNkqRu2JxRmdlye1zTQpLJ1Ky7NmprSAuY1Qi2sxsYn6G2QgweRAAZUTpwEioysx
         9qNKmpiIRCgofwmFJkA6ZJe1qLLExTiwsj9Q1sIOpWgHuBNztIMr7nT6sdM6W+8SSeQb
         bF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248959; x=1794853759;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9tBWhRBh3Q/NIaZ7pvcEWgchBntJxEwV8o5plMJv5s=;
        b=u4RlNJIgL1oY2CJfGlSi3TQud+9sCiRd1nHrea5cJ42t7FrqAmJz6puz2kKIJjie2t
         gG2tzUSURTXlfUq6KpUkFapSSbPG/UJyv7NNnShXXI6qQV4BoUNYOrWSCD+WUHj7quRW
         FhaC+Es4bYa45yz5jH85ofnrNpRIWQKKrl6Z06S/94Fw7tYFUGcEHPK8Z/lcIJr295B4
         ehmzU5f0sjX0TAmQj6CSFESgRJirD76vN3NbXUdiIrcChHtweH1S4s4C5omt3TtsHnJV
         +AYo5afQzDk8LYGZ+mxtz4fiaGVD4r0x5bZk2zardrUrj6ba5AytomFj7qohbDFJUuiC
         ml9A==
X-Gm-Message-State: APuU4Z8S8lTmZ7Z1EXaMHUxcBpKgcfMFQrU6Cu0KNDZSCn8RAZ23pAwS
	EJRMg5iLISxbL1/qdIK2zdAOwVJifQDCiA0oJYdKv9Izf4P5Qd13shCm
X-Gm-Gg: AYBFou3146auc2Dafx6UxPu4yGCKzegA3rco97vCEUZO6Y4MCtAi+efv6aTyuLRCaB/
	+WH++N2ahgAYAOUndFgoKWMZZbHXuK1R/nyI8IOJyUu5JFEN1hoIiPALaFsjD0/3Bd1m8WszNYJ
	XrzxtXmxLVN8BuWTMqYAxVgaiNB0pQMcFG9ompGVMjg+aGBD/7NFLcoUtWMXgLt2gVv/J24+kfP
	1AP6brdRkMM034fcrMh7q4n3O6qJhzFOHZAopNII7RpKMdJj5fqDTVmcAQRdpgUs4qQq8SDDKBy
	uXTrfM9vaknKU085cqaD6s8Ne8HFEtKSDwsg5zvIGfVnp4P2MmDPDA3SyiysspS6u6+fOCiSGuS
	XzuuXFyZ0lD0oEoNnDWeZrbJoVMF0/rm/IYbpcQUA+mBTfs2HVl/vKOEL1kretk4AXqghP6O591
	I27tY0Z19KLEtbsiTKzESzfE6NG47ZtNl5/8zzQiSVBe4GbhWVAEySr6fk2wBOmECif1puILfF2
	ckpNP1eAoSb2X8t8wLiCfpwr+bXo4Ufe3kENk+czi55nVw3DkMvohip2xlfxEoQWO78Yru7sPCI
	bNXRDqMNb0oyWOl2Po8Bh3X9ng6TxBELH2QA/bBxVIWj
X-Received: by 2002:a05:7022:5f0d:b0:194:e9e5:11b0 with SMTP id a92af1059eb24-1b3b5e27137mr363920c88.14.1794248958814;
        Mon, 09 Nov 2026 10:29:18 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm684335c88.9.2026.11.09.10.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:29:18 -0800 (PST)
Date: Mon, 09 Nov 2026 10:29:17 -0800
Message-ID: <08dc804d3ce9bf9b8a1c0193ee7443c5@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 edumazet@kernel.org, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 sdf@fomichev.me, dimitri.daskalakis1@gmail.com, almasrymina@google.com,
 dtatulea@nvidia.com, bobbyeshleman@meta.com, asml.silence@gmail.com,
 daniel@iogearbox.net, razor@blackwall.org, leitao@debian.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, leon@kernel.org
In-Reply-To: <179418737922.994134.6838913010792422653@kernel.org>
Subject: Re: [PATCH net-next v3 5/9] bnxt_en: set the netmem TX frag size
 limit to 32KB
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

> [Severity: Low]
> The commit message says:
> 
>   With 64K pages it lowers it, 64KB frags would otherwise wrap the BD
>   length to 0 with BIG TCP.
> 
> Isn't this a bug that already exists on 64K-page kernels, rather than a
> side effect of the new limit?

[..]

> Without the tags and a note about the dependency, stable kernels on 64K-page
> systems (arm64 64K, ppc64) would keep the wrap. Would a separate minimal fix
> for the net tree work better?

I'd rather keep both in net-next unless there is clear evidence that net
is buggy.

> [Severity: High]
> This isn't a bug introduced by this patch, but the same 16-bit wrap still
> looks reachable for frags that are not netmem. bnxt_start_xmit() writes
> every frag length straight into the TX BD:

[..]

> BIG TCP has been enabled in bnxt since commit b6488b161ab2.

Ignoring pre-existing..
