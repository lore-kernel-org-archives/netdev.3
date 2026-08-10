Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7084399D9
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386958; cv=none; b=cRtJVlk7/AFcu3sEUHkt8gn3oQrxm6WuQyWEE4WWdlus4zgh7GcRooe7hF54feMJ7rp79ke/9zJ69vND7kEtMbhKSdFtwBqtb2EJFhtGycEilYEz0tbfMlwQ/JX0K3bu19E8Q5Y4jfLckiABYVNOVuwmwHMStRW6pwKpHPK1RNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386958; c=relaxed/simple;
	bh=ZYUXC9ZCR9/rWG9taTTSNiMU973B/OZYYTLibocIZFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA69PcZEvbso/FwA2KKMSytqd66LeAiGHXAKxTlS5nr3t/qVRkZwsBbwkAkyOqhIM4VIYH0qGuJ/6/7DErYPIF/c39nGmbC626TWOSBeSPEV9WARP7KylpPH09P36mlI56Wv9+VWIL4YijY13/tGoxTadcWYKHq7pBCrDKHCX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHewxEPE; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHewxEPE"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-39292c67dc6so8015a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386957; x=1786991757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nhslA0jkldnpPP+YQhiwhTMBXASBp0nWG2npEOZu6Bo=;
        b=KHewxEPEl7HSBU8BXHOVyZPEDaViFEvJArXGJj7JBwFdvvjhIB3FlF5vYiNAIHoGJy
         SfYNXJdVs9yzZYKJSGDpUqZC66mTKwnUUqQV+L4zEbnSDcPbaoNbUGQN7fE2ek8/goix
         76TUT4XL6JHwYf6LNBre4DReoy5UVq2ebkPb370y4vLWHkmoiqKunPoPMu5c0PoN9C7G
         jVU8MKz8OznQgwvbPyLCupykHDfPxBoq/DxTRNZPpc9HfG134GxbWhstcs4BDPZXpc9U
         /NIuIvBAJYPX0MiRCKYb6STgXOCFlbKLh83W9TKCJ4MG33dvWdNMwFwuElsKGjktpj1+
         jBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386957; x=1786991757;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhslA0jkldnpPP+YQhiwhTMBXASBp0nWG2npEOZu6Bo=;
        b=PbMbZ1B+nvuzZN+YDrDip4wro8570od28j7W9rK2nI06pa6lvVw2wsHtbz4FwFHt/D
         X8LybR/6c3YgoNqBmDD1m8T29vr22FUvyqugdG7NwAbRTRT3JHYsbtFpbXIcii0xFKKs
         xywWrQrZRzqvLhBLBixwjHbB+lvMEPLbDhubFXUOyhb6AXaS7wRVsKaC/NIgwy256M6h
         p/zp7nG6s9zlcMELuaugpr/1Cy7/iHIGyZJNtFVzz2P9gDFPtTGKFVFgYUd3s3NCZxd4
         VwiVnGGCDqR7Ad/Iu3zqzJPMsSDEYbIMk1qJnpDKu0fSoAUnXg2oBkZqBO12czgn9ZeI
         ZNqg==
X-Forwarded-Encrypted: i=1; AHgh+RrGPHtCs5jo9CH9A3PaQy02w65e+Q+HAKVHWAHfCZcum7DaOzl+4B2iXzXJCnvi89gKOVIMb0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVki3XP4+EF8veIsysAWdwV8PDcVk2ikgcWvlCsgViFDEwLAH
	c0QMdLhtsrtN617fV+3TPvG9x9dlCz5BkvPT2j3miuSpMTXkghk3dDKg
X-Gm-Gg: AR+sD11Re5bMcfbVznmYvYQLUgT4Hdib/Jl3TJtoLatY8cbgoup7TYY0kus2E5U3A6C
	OAPv3YWc5XbgY4kr74WU9n/lNmxJPgXz9c0cgxr0PFlL/XDkSM8TNKtByGM92+wndHQAZb2ZzAv
	ZPpHSYqsLzZUgkAsDcqZFttmdN8z0/VT7Dc0E16vvhMyX+L/hkdlyasg3URBYGQqX8EBYXKUK3z
	SUCvoKai+KCL7uZrbIgm4StPWIZl8rzJffKW5UwFTmfZRd3WxahH/PW0qRtanr2Pj0BqyPiSftZ
	7V7RSp8hUGDBkp4/KwtlsDgFEkfd2EVQdV5W7RS3v9I6R+ywie0+jiiS0XPlOjCu27IcZyTgdj2
	h1dO7cwPMrD6C7fTZBFKxpzM2Q7qOYu/lIJJhR5Chn2oqh8IBmngjwNcUgWCGOHhIUsaTComttd
	t2z6C7WF+FSupXHBELTZ4qUSmQqT4UDxBcaAokQVolTwAzxSTbkiglSg==
X-Received: by 2002:a17:90b:528c:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3903c5448dcmr47307071a91.4.1786386956804;
        Mon, 10 Aug 2026 11:35:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51c2a39sm576472a91.6.2026.08.10.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:56 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:35:44 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 5/5] selftests/bpf: Add ksock test for async
 callback guard
Message-ID: <anoZ9ygbuSZPru0G@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-6-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-6-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> Because the kfuncs are going through LSM hooks, allowing their use via
> workqueue callbacks would expose the wrong credentials. This test
> ensures the kfunc are preventing any use from these contexts.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
