Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3245303A0D
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548850; cv=none; b=O/EdDQJ9JP02EOjmRuo+AraB3I749uYwdWs9YQF9AWLkCapimp9dFiAHVKRxszOfWZwRe/8A1w/7NttGx6ManfZ8uwqhXkfapbqE+HYKX2XGXJTWRHVs6mFN45lRof7qC/Cq5PV7nhVLWMiC+ptbRjgufo9lpD2s/wXM2kAi+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548850; c=relaxed/simple;
	bh=T4KtAs/p1COsGqPsSALMgLG5ONwNQ2GuB4Zupj+iO4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgRMSF4okAuKsNLH20hr5B6VL1p5gIPTd0o84E1E7bmAfGdDiPCFtGqiSmL09QJQ36jor5pf07/bmHkJFV2zt+QyvXM3iqw2FLcEN/wgN38GyhMkCqDD58BSM3tekX3DKKBEcpaKj+tT3aw82k0MUCi88Of8pLVoMTpo5IrMT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zcjrm0Lh; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zcjrm0Lh"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-6c3154fa46dso1690989137.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781548848; x=1782153648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqNGPPl5V4iFMffiJZeBFRXSyip2Xd75o3rTK8JKfoA=;
        b=BJ7WS1rcso4gTrO4zlYGinrlZnUvcDGx525VfXva4/x6sVQuV+D6LviMSrSuZZ/eav
         D3EyOaq6Se1LKoiKmUdRS0ozdwfeAhL2eJpq5u0Nf4wodBNq3b/U5bju7WMKZPvPnQWt
         Jc5JpvoeHnMC1ejFhFOk8LdNOugjBMh0zPgb4s4DmpVELa6tkFSYrx+2Lke2d9L6+Opo
         O0HIMoDkbs3IvFXdHIkMgzEbxXjwbd5R6uuvOk+pUifGSHc+bRF+WYI3P6bv0txsipkY
         ozSTn0kR+VKeioEd+PWh3yrFWcdA9JOZtK9j/2/nu+1ze9zOB1XFUxbblNR3EjGQLvaP
         abfw==
X-Forwarded-Encrypted: i=1; AFNElJ/6q9uimsRZdfOcMjaY79nB3fs+HW6DvGHAvC4x1N2wSG8I5arhuk+s8XWigp9c5BxAthzNyDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0XiHK7exoTMsNRGkzXdOW2jzvsLSl1VdqpZY18dLU2gjnEFQ6
	+3G5nwrrwtOjftSWQK8nTxWeNjYB2p89Z3qlGrdG/jYkeMA80TxVkXNKK4Od1WAa565rqlZQNNz
	NkHgyh6d1LiLa5W3+iKDdHzemGHgW17yltHzQ4YMmzmutXEv6GuQrZGtwvwj45sxqAFv/VERszM
	sYP82dkNCO+MdAtYyMdGheyXGBTx5dlMIKcVOMasFKuL1j43VSmqDMV2FjuXBiY03/MlOWq2Qij
	OEjua3GGg==
X-Gm-Gg: Acq92OEl7POyh9aNA80WvKUjYHbWa4soJegkwxsj7Q198nTfSpIg4PbAb0+LIgpiQNK
	19Esxb5HOFureaAfLZtaW51DQKQ54J0+wEXCsloS5QlWujbTDtvjYVdqUqk3wqlZ1BnKdHjk/+V
	earg0NvgCVE1m6yaQem3RyRpJW4JGegIYFHbxYPjGETGqM3bFdzu9f5xhufa4AakNv7v7UgDbSA
	hEuABqy1ObMRpGKncrE5VvZdpf2NdYG2YikKryxd+XSR3q3KNSLqfinxYMAEnN8fwghkS1ko2I0
	gB4JdqS6qpqjX7+Re2z0eZ36jS09C+cFiuzzcJAiz25+Sx8fRu7aIKkhyjWBj7ovqGcImu/SUr9
	hb7pBMEt/v0TqFY0gS6zZJZwcsQmj7wtThZwAwWMltfCfkIinyF9ZEGpJt9gWHCm4Kea6QY9iR+
	CSzQq2rt56Z9fao5H3f8vUqTlFbdmWH9bEkzq097IZWNl3LWE3XI9Jt09fKw==
X-Received: by 2002:a05:6102:3906:b0:636:46ee:2f0b with SMTP id ada2fe7eead31-71e88b35f70mr8808732137.12.1781548847676;
        Mon, 15 Jun 2026 11:40:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-966a0566c05sm383500241.8.2026.06.15.11.40.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 11:40:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ccf62978bfso84968776d6.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781548847; x=1782153647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqNGPPl5V4iFMffiJZeBFRXSyip2Xd75o3rTK8JKfoA=;
        b=Zcjrm0LhVWeYu7XggZK7UtXUb3sHyN1FOj4LKXrAIP8Ln+jxL0hNIJSW1QJjn7gaBy
         jvWhDDXBtcp9pxNBWWKasZhg1f0xjMeySA8X8D7W5QDabr7sTM/FpQt9QMtyY5zIELa0
         qILXZtoiigP4OM1HxlEldqZg7vMn0ch3UsLkw=
X-Forwarded-Encrypted: i=1; AFNElJ8BIefyhzEvgf9Uu04wzfbiQ4iDSORMIV1zN5u9Fs14DVcFA1b/xCO3zom0MyK4Ahp82PNmx/A=@vger.kernel.org
X-Received: by 2002:a05:620a:3703:b0:914:c82c:79fe with SMTP id af79cd13be357-9161bd3547cmr2244894885a.27.1781548847040;
        Mon, 15 Jun 2026 11:40:47 -0700 (PDT)
X-Received: by 2002:a05:620a:3703:b0:914:c82c:79fe with SMTP id af79cd13be357-9161bd3547cmr2244887985a.27.1781548846334;
        Mon, 15 Jun 2026 11:40:46 -0700 (PDT)
Received: from [10.14.5.238] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006ef0sm1152286585a.24.2026.06.15.11.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 11:40:45 -0700 (PDT)
Message-ID: <07208224-0b16-4149-9d93-3eac3587ef0c@broadcom.com>
Date: Mon, 15 Jun 2026 11:40:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: bcmgenet: allocate a single-queue
 netdev
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612205915.3156127-1-nb@tipi-net.de>
 <20260612205915.3156127-4-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260612205915.3156127-4-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 6/12/26 1:59 PM, Nicolai Buchwitz wrote:
> The driver only uses TX ring 0 and RX ring 0, so allocating a netdev
> with GENET_MAX_MQ_CNT + 1 = 5 TX and 5 RX slots leaves four of each
> unused. Switch to alloc_etherdev() which allocates exactly one queue
> of each kind.
> 
> No functional change: netif_set_real_num_{tx,rx}_queues() already
> clamps the visible queue count to 1.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Tested-by: Justin Chen <justin.chen@broadcom.com>
