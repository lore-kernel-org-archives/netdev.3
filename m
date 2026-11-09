Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228143;
	b=nBOIGmw35bQYrgoMtWn/nP9vMAyg4ybIFxQtqK4yDi8h4yPw5rTjpL3bBOOrEOqCSOFO
	 IQITR5Ovjr9NahiIMwt3NfOPNZqUbAHYDSiwsaRU9xdOoq5pQ8G6NJ0IEKQeqR7dlDKCd
	 yYD6SfYxfW+0q3/lazHe3k1HLSxPGvvvOUqQDWSX9eLcDjgsAkdicxUCSmr0bZxPaDfe2
	 Ra/SwYpvZpPa/nfo8nhFItBVK7hUZQK/rk/MPQZ98/w7Fcsw42LFPoE2MRR5oQhYsTI8V
	 6Gxv+gz6Q1XuWM3D85MBwJYIt+YW8bYnPCPX6xlO12GpmE4qESTTe/4MBt13ZjXkAog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228143;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=V+3HVjWEowtOGtnG/qmLKA0rLDXIDYuTm/6tAXVFsMM=;
	b=WXWQMICH6MqCk7HD6R9t3M4r/6DvSIlNekWRDuh9zLjFmmsLf0GoGqtWyX0sCREpUDid
	 mvfMWwJm1j2wm7otpvDHKnV/S0+Qhn7khouhl4UIinLfQjDs0ULK7qxYe8HDpNXUiRDC8
	 +vxhd8PXapAsXWNFVVQFB3RfXajQ6wshkfPVZmjPVhDNYAmGOK0ODMUP6/T6TpfaJwypJ
	 bxvH44MRgAwbtkhLgkbrbumj1Ws9tCfWdmTRQtuAETnt32+uypa4lzd8/yvsLah/XwXz7
	 RLMcrPhC2cZE8VzdkMnwbPaCTeEslepqJh1nqFwkLHgwk9mEwr964QCf1hTIgyql2fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q7UM4Rq4;
	arc=none smtp.remote-ip=91.218.175.144
Received: from mta0.migadu.com (out-144.mta0.migadu.com [91.218.175.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F06606D807
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F06606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q7UM4Rq4
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bDQswonbWOTNrdgEaeANfUIibnRB2MSOI3/tEp4TByE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794228141; v=1; x=1794832941;
 b=q7UM4Rq4nlXtVJkpfkdkHZ3JQBLAPV9VYRU2BaowBsA+R9H4SyaUw8p21weXmR6oIjkWIA5V
 WltOFlD4eITsBKOSzwEHVkKKLFdAywfXgfcJrnoc2qt2HQaU/cvgYsu2YTF9tiNyrMuKd7ZdrAc
 Xolz8GcLLJxI2wubw08ZhzNk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 74be730348da55a6;
	Mon, 09 Nov 2026 12:42:21 +0000
X-Mizu-Trace-ID: 74be730348da55a6
X-Migadu-Flow: FLOW_OUT
Message-ID: <1534821a-4d31-43df-9004-af2ddf5eb87d@linux.dev>
Date: Mon, 9 Nov 2026 12:42:19 +0000
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
Subject: Re: [PATCH v12 net-next 3/3] selftests: drivers/net: Implement ptp4l
 sync test using netdevsim
To: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, horms@kernel.org,
 almasrymina@google.com
References: <20261108201503.85000-1-maciek@machnikowski.net>
 <20261108201503.85000-4-maciek@machnikowski.net>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261108201503.85000-4-maciek@machnikowski.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2026 20:15, Maciek Machnikowski wrote:
> Add PTP synchronization test using ptp4l and netdevsim.
> The test uses the NetDrvEpEnv to link a local netdevsim
> device to a remote endpoint, runs ptp4l as leader and follower
> on the two ends, and waits for the follower to report the
> synchronized state (s2).
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
