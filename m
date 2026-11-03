Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730499;
	b=Vlg4R5yuoHEtwx4YYpsI0AGnOogjGxXe31RRwVX5juVAoHN51q4eIaP7nvaA7WswfUxA
	 XWt+wacHRbev1o5Ij1KgK0nsv6KDtItRQSpQi0QgR1hseEBIgmWspsNaxUR6z5VJWLSSl
	 9c9MRUSi3IR1+Vw/R8bHH7kAUi1QEffJKuqcERLaLOxyFPXHDP6lRIqizi6Bte43ePObs
	 bSkV8bquc/aVvcqBlrLU77djBS1oiRSWRteXysl+NUG1zQgO0U2aiDieBEJKRR5Yiarx/
	 d9AYtAIbC6okhbhp93h+C5tZkZ3s0qxIaxdHDK9DfvNTHHtPFGfHXNZ9d7PlnYh1tKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bW4zFchgwCd38Gn97uqR7GAWxBtqtJfDJkTR9LdNPNU=;
	b=NWUtGcYJ35v4jMxYuiA8vs44XqcK2y6SQ8thRB1BUr5tu+aowg+DdcmCaQUmxbvMM94W
	 Akq5c3lnqypqun0+o4twm/oqPgmo3nrXxcPwZ0XIOZjLtJQAB09Zm9OyN2vhYK4FmdA1I
	 VxM93547R0SnryaThmGNmBS7fsevb/akN0fxA8sH6v0AA+1b/cbc0QS0+aVlOgomF6PTl
	 7gf3Qjq0/TBCk7JtFh77eeRudxQcReg2EePO23VVmA0F0xrJcxUvl4hLDqJVR09Ahj/dY
	 7ZNrn6Vd39k0TpHqe5FqvxGYIadEpc02QVJEXQ9Q/sB9xK/pOvVlsRcdtHcpxyhWT5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=d0OUAfBj;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80720606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80720606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=d0OUAfBj
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso36145615e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793730497; x=1794335297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bW4zFchgwCd38Gn97uqR7GAWxBtqtJfDJkTR9LdNPNU=;
        b=d0OUAfBjtGUfKMrxOtuMRqTHay96J1tGMVbyhbReblic/KdOLxwc/eTAcLLHEks05R
         Zss1hp1Fnyc4hyebEx2sK8hethHEninETc+QVrHNP5rALjqdO3y3jUtqSKXp46JDMGqJ
         YIxAjJyDgrwen4Ejf1J283MrSjcDZiq491L3CIEPbzNO6mWfQtQ8hJp10Bojssi9W+lw
         6up96s8lv6TCjbfZpRUktpYWOI5gz4452tJpFMiHkr/zWnHWESRf07CIOBy9C6qJYY9u
         ynhBYIk9tvy2lzCaJQeL8Y5jB3zQD7ohhvyf0moraOGjVQHSqGXcc49TyVn2w3vYcORv
         +7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730497; x=1794335297;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bW4zFchgwCd38Gn97uqR7GAWxBtqtJfDJkTR9LdNPNU=;
        b=x/nhbOKU/aG1FraX0hvOAv+O7RwaNupjh3VfyTyYd52qMXQ6barwG+xUcOyTQU8H/G
         Qchuaf7wwciIwPE+4bwZJEhgQzvGGPfPeck/frFiDpB9kaqgZ9tdmgo3RnrVf7Bhzeyb
         RLBDU3gJKm4aHfFlMviNvJ8zG8V/qymbrrykp6P8hOoeG3Yrsk785WxnQFTK4otSf2TK
         h7D3+QAM5mZavVXuRsM2uJZ2kAhwyWK955SPwDZClUBELJfCx1Vc6kHPGVAe4yY/Y3Wg
         +a4PMi5MilUixmwLz4OLxYszvAYqJmaVuaOdynUWs7/3nejJp29SzqHIbjK4j9L4h456
         V8tQ==
X-Forwarded-Encrypted: i=1; AKwUvBweGLUTzf4U5JL6iTRPJWyup5eIwZgiW5O2DGjnqVbNv9vPVwNHzhwU966oPZw7sKBN0iYNKvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Fqi6qNgIik1VigBvVZDlOTvhaXeZFxh0/LmIiY30u8zay19U+
	cOQ6z/+Q5rl0Ufwb3qSi3+ls7pkJgTAQfz8wmY7XxFxqi44EdrmWm00doGQcC47WtV0=
X-Gm-Gg: AYBFou0yRSCMmU+Gwip6B6KDbF9JKF3w/jESohpVjt9pxUyY2fcAoyNZU6CcZPipjOB
	FOJZ578fZtsaZSljHK5iof/Orf0bU6ow4jtJsZRSkKIzu+N3JhIhO91Dxa541L3rRisuU1UBngs
	NrLZH1dxQJjvIP96jVawuzqT108NjwGMN4f2VK662BoVyhxAsSjCBzdYimqOTtYBpC1/3lb/Gzx
	t1wZTukn6muJoJHlJ0IIqTEG2TJ63U06ZLcqV9lsNyDotKqFowJYm686PDkTHt6olm1yS50iAqS
	BhdQMb9G2MMUQX4alcPPk3hEC8E3OtZqE1dEUQK99UHnCCyGSQRCSyR5l96Xekn+WAwflNLI6fl
	uLesj7wfquamQIV7Xtr8MoSaxHQfoB6opzztWjtxn1euXG3Ps7+wKOi7RXjAmoTItVrU530d2Jg
	BpYsvGN16gr3pUziM59WzaLXg2CxZGxD3rELgSRtIWcUtYxr02InSOtPOHKmnhqtQ2ls15STy8M
	yIxvC4owo8DndMrWUT5Cld8Mc55lZ/hZwvgFoNv7hcRQ8hMtGtFc9ovDINhhLevcJ9mFEkDmmTT
	lFGgPxbzaBDRHdmliGbzspXg9bimcpRTNvLNxcJ+bUhvyuCi06ZnxjAqFQ==
X-Received: by 2002:a05:600c:3484:b0:4b3:6900:280c with SMTP id 5b1f17b1804b1-4b36def42b9mr49914725e9.19.1793730496518;
        Tue, 03 Nov 2026 10:28:16 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm26640902f8f.43.2026.11.03.10.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:28:15 -0800 (PST)
Message-ID: <1bace3e3-b3a3-4a8c-8d2c-6df29fb96d21@blackwall.org>
Date: Tue, 3 Nov 2026 20:28:14 +0200
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
Subject: Re: [PATCH net] net: bridge: use one headroom snapshot for ND replies
Content-Language: en-US, bg
To: Jun Yang <juny24602@gmail.com>, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, roopa@cumulusnetworks.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 Jun Yang <junvyyang@tencent.com>, stable@kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>
References: <20261103075439.43644-1-juny24602@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261103075439.43644-1-juny24602@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2026 09:54, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> br_nd_send() calls LL_RESERVED_SPACE(dev) once to size the reply skb and
> again to reserve its headroom. When a port requiring more headroom is
> added to the bridge, br_add_if() can increase dev->needed_headroom
> between the two calls. The reserved headroom can then exceed the space
> accounted for by alloc_skb().
> 
> Take one headroom snapshot and use it for both the allocation size and
> skb_reserve().
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> A KASAN reproducer for this issue is available if requested.
> 
>   net/bridge/br_arp_nd_proxy.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

