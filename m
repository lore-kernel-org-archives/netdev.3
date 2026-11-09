Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228128;
	b=fiHpbmDPueerFOcWtdSwysYIPU/0jg508NzeW/mxrv6EiXNFFrs04sEmjKE9vISQlYEN
	 uRq4XhF8ICRH3yV2uPT9QHlceobu4OxRdNmekd4Y2IweQVCJ0BCbjR/7yExxDKgHrS3Uj
	 06+te6BPlihYVz6Hc93ze7sUw5FlKUGi9E3ATcmoYSKojmgx6goiSbOE78ZvXmFBIZHMO
	 qMvya0Xn/+cEcDr23+gGqiMFbgmB8I2H7wDbEElDR+tn7h1aJz24dqnoN0UmOYojAA4MD
	 Tjc4rIPGNhuGUZH6oEGif40B5+4BjRLfBzZvBmwW+YtSP3/mfT7lEPbjdZU/4+P5rxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228128;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DrzURu2hMkOt5wV2KmTwMR0vxjunx4pWdrNMPocltYw=;
	b=CwOFvcEUhTlHVwGo4A6X4bDNG7WbSWgrf0uW/7QuJDD+601QGI09IJANLRLCkxOKBHpu
	 Pbh2gwgg/bx3g2iTJfopVmOKusWdzhA2hoGbs/bao690iVB2ByqMPZFnCJM5ogFFZxfeA
	 1ZVZgP66IEqHFuUpDOAzFQ5wJXLe+k4zF3DmMbNXWDJGvsGlc1z9fn1riTConfnj0Fv24
	 4rdUbSTXRifv4gGMnj2UBVlbtBVua7qjjnWceMAXB6cnZQvtSNnDl6VdhuyJwCazx2tSB
	 Nri/K5nmx51pHQw1dmnHhP97xI/zPdyIYnLLyoOH+Q9v/Cn1v7RhtAqZM4SDHsWG1kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ubC5f0Ba;
	arc=none smtp.remote-ip=95.215.58.111
Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10218606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10218606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ubC5f0Ba
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5+J6yPtxySZ9py737kBbAvcdrUciAK2XoEQbohvbbN4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794228125; v=1; x=1794832925;
 b=ubC5f0Ba7K0KgYyw2dR1OSX4NfJo3kenDI+A3eDJizPU/xr99NLqWFD/65ubtDkY7axsZmvc
 FOu1go96elsXEbA9Hy2zjeSyuM38cBBSvv4VcvfYIrRC8GYvyJ7o3yj9aqeWMN3gua+MWA4AEun
 Sr0xeI9IUKd70XALh507MeoA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 35c9b1b43f44f0ab;
	Mon, 09 Nov 2026 12:42:05 +0000
X-Mizu-Trace-ID: 35c9b1b43f44f0ab
X-Migadu-Flow: FLOW_OUT
Message-ID: <15481cbc-79d9-420d-821d-6ad559dc246d@linux.dev>
Date: Mon, 9 Nov 2026 12:42:05 +0000
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
Subject: Re: [PATCH v12 net-next 2/3] netdevsim: Implement basic ptp support
To: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, horms@kernel.org,
 almasrymina@google.com
References: <20261108201503.85000-1-maciek@machnikowski.net>
 <20261108201503.85000-3-maciek@machnikowski.net>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261108201503.85000-3-maciek@machnikowski.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2026 20:15, Maciek Machnikowski wrote:
> Add support for virtual timestamping inside the netdevsim driver.
> The implementation uses two attached ptp_mock clocks, reads the timestamps
> of the ones attached either to the netdevsim or its peer and returns
> timestamps using standard timestamps APIs.
> 
> This implementation enables running ptp4l on netdevsim adapters and
> introduces a new ptp selftest.
> 
> skb_hwtstamps(skb)->hwtstamp aliases with skb_shinfo(skb)->xsk_meta in
> the skb_shared_info union. For an AF_XDP generic-xmit skb forwarded to
> a peer with RX timestamping enabled, writing the RX timestamp into
> that union turns xsk_meta.tx_timestamp into a PHC-derived value that
> the AF_XDP destructor (xsk_destruct_skb()) later dereferences as a
> pointer, corrupting memory. Orphan the skb before writing the RX
> timestamp so any pending destructor (e.g. the AF_XDP completion) runs
> against the original, unmodified union contents first.
> 
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
