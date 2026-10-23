Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792725333;
	b=rd2ZFr9fKrUaItDxd98iqv7nkQa213612sdpkYh0EZd1q2QCHoj5RAi1TSQrCzlUulu9
	 JXshtj9AZCLanfIEF5mdk/VtWdrxmJfbdMhAmwo/bTbqAP4D3SBzGoPNl+uGJZSIlZOZx
	 awYxejnL+xypQP+xDoFX4z6XwavZX/RIbIbJ8qjr35zQzAV8p3bO+Ob64AJd8rXmhU9kt
	 gXbe1s6RUz+i7sq/8Kt8Z6SnPzXR3NXyehUKcw3gb0B5TGUGCGen+Du9TFXPSeg0bV27u
	 AJWxD94YQfzgOraSSThPF/FU84sknkjI2Qv4vH4Lnh6P3jjqnWTJr3pMAT1Fwk+D9Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725333;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zVAKIg7XqiPBVNuocH1Hoh+zfouG9OOWB6QRApYQMW8=;
	b=A/J8qiGaL0CR+SihXpD7cLSluIGi5ZuxqKYeNMUU/l8DdQ48sk1fsRAXies5+S83agdL
	 fK3SkrBpocAcekQJF+Koa1ftfeZ44LiVtDYFJQI232vSHzvTXlYr9BZ+rLMcKECUOucbT
	 Hs1ruLUxGAb2qKvtRcYVg5TwF1fTt886aq7wee/YMZnjH372BVP4+fN/bFIEVnYnTG8WV
	 mA2UpLM8Azrb+lATVzp4deDv9TmRJlOBzrXRiMnKhDJ+S9/BxWpQs1ArSySyI9oF/ix5I
	 HAs585MTjq/RMx3xao85z47lTGm3BYL1OQOqSTQIm+TYCpD5rnlyfmmmEmNOfu1KdRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="uSSb/ZMG";
	arc=none smtp.remote-ip=91.218.175.135
Received: from mta0.migadu.com (out-135.mta0.migadu.com [91.218.175.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED6606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 03:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DED6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uSSb/ZMG
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/Zq1baKOLuThcBsVDU3+UzpzigXWioU0C5AmZNp+Tio=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792725330; v=1; x=1793330130;
 b=uSSb/ZMGsbNrgeAUaaRKb5W9WcaCySULnJRVa87p12wsAqBHGvEeSbxkwabxqxTvkf4Z1918
 O4YwYGeoQUsMBlsGeWlpgfjCYOBmedfzQkOgaa2o2OVLNBLFd7nQoDf8f0jEgpbYkN3Cckfhev6
 gPUzbx2ivbFijSEWdRsYyuRQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2050942c7c50d671;
	Fri, 23 Oct 2026 03:15:26 +0000
X-Mizu-Trace-ID: 2050942c7c50d671
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 11:15:15 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Xia Yan <yana06070@163.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	pabeni@redhat.com, shuah@kernel.org
Subject: Re: [PATCH net v3 2/2] selftests: net: check veth carrier after
 changing channel counts
Message-ID: <atrRQzn2prYbF1vF@fedora>
References: <20261022085842.2527-1-yana06070@163.com>
 <20261022085842.2527-2-yana06070@163.com>
 <atq8yKbnqtLBVucH@fedora>
 <20261023023350.7225-1-yana06070@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023023350.7225-1-yana06070@163.com>

On Fri, Oct 23, 2026 at 10:33:50AM +0800, Xia Yan wrote:
> Hi Hangbin,
> 
> Thanks for reproducing the issue and reviewing the driver fix.
> 
> > Why do you do gro setting in rx/tx set ups?
> 
> I included GRO off/on to cover both queue reconfiguration paths.
> No XDP program is attached in these cases. With GRO on,
> veth_enable_range_safe() and veth_disable_range_safe() set up or tear
> down per-RX-queue NAPI instances as the RX queue count changes. With
> GRO off, those helpers do not need to reconfigure NAPI.
> 
> The carrier bug reproduces in both configurations, so the test checks
> the same carrier state with and without the NAPI resource changes.

I mean this doesn't seem related to the carrier on/off (LOWER_UP) issue.
Or did I miss something?

Thanks
Hangbin
