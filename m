Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495108;
	b=q5rzbM62ubmvCoAz1bfcu66xZoAa5IPQzLoL323Mezztm7Oa5/Wkh87hgeCV1j41Xouw
	 IGy34VCihq9GXjaVaTNXK4baYYglqIHD3Pkvw0a7jV8xosSVxOzh4soXZiLlzaLeNJtY6
	 DZEKm+Ey5Mn+C3Xb6y1ltyAdsVgAsXFUhfOvAMpgadxEDXiwk7MMRMW2SAq0N8CkEcPRV
	 8xp+ajs/VZop/aQZJaL0nsU8v4+ShKHeFUl2Tncv2h9za3Hh5qADCsCNgziGrOdsGc6a9
	 A5GTxbHtsPuTSHEqBkDjlyj87gCOpNpcChjMGMTVd5rp3QD/+Z5QTomtcxPDCFiNWWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495108;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R5IQJPZPaZ722ekjdLCDgWz4ITlLwSuM6xAfRDg9ni0=;
	b=AJQB2rdkJ7QW9y9YTGVotW+2quma0v+N81NswQXsoeTC/Cp1h0DbfMxhXywtp6DVW2Ob
	 7gKddZ3LEAZ0ufdbYUwAxhwtdeo6kiA871bMsS50iDe9nuL/lbsq+Glm2enD0kIMugaki
	 otlckaRcFgEnQvRpyMC5si2oIUp0ey5to04G5TrxwZPrWjI7evkZAQlbyMDD4bETLJEZy
	 gkf2h4dLUldOc1gjKNW5i8nBu6wQgfKlwi+qY7W3clTl2LPkkS/nx0wVKbOMu52uR1X41
	 94+ZyxtU/1dVz9tkjqtmgyQqD0UwAxvLkFo/Ew4KCxuRKrHRc2ntcGkQ8L+/3K8u0NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dk4k5rJ2;
	arc=none smtp.remote-ip=91.218.175.13
Received: from mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F414606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F414606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dk4k5rJ2
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=R5IQJPZPaZ722ekjdLCDgWz4ITlLwSuM6xAfRDg9ni0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792495099; v=1; x=1793099899;
 b=dk4k5rJ2uBJQaK0Ebxj+ZRKGeR7+0Dzboqmb1PAWhUgNDcQrvmS/Q6DIv+x0/jUNhCjPP81I
 hvVMRm2bPmIP9yN8+OhNAY907Bgu2YUyLLpGSbukh7MLi0HivgX9e9PTJ2XIn9ooDJwHKZLE6V/
 OOJPryfOPQ5r4u51Xx+w3T60=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 380707f91af7ed82;
	Tue, 20 Oct 2026 11:18:19 +0000
X-Mizu-Trace-ID: 380707f91af7ed82
X-Migadu-Flow: FLOW_OUT
Message-ID: <21053bda-1be0-45c3-80a1-fe012886ab0f@linux.dev>
Date: Tue, 20 Oct 2026 19:18:09 +0800
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
Subject: Re: [PATCH net] tls: check the right open record in
 TLS_TX_MAX_PAYLOAD_LEN
To: Sabrina Dubroca <sd@queasysnail.net>,
 Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, wilfred.mallawa@wdc.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261019222626.745408-1-rjethwani@purestorage.com>
 <atdJUP6Jb0jODBYE@krikkit>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <atdJUP6Jb0jODBYE@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sabrina,

Thanks for your reminder. I totally forgot that thread.

I will send a v3 and update the commit message to address Paolo's comment.



On 10/20/26 6:58 PM, Sabrina Dubroca wrote:
> 2026-10-19, 16:26:25 -0600, Rishikesh Jethwani wrote:
>> do_tls_setsockopt_tx_payload_len() refuses to change the record size
>> limit while a record is open, because both TX paths size the record they
>> are filling against tx_max_payload_len. It looks for the open record
>> through tls_sw_ctx_tx(), a plain cast of priv_ctx_tx to
>> struct tls_sw_context_tx.


I guess sashiko will complain the same issue:

https://lore.kernel.org/netdev/20260901031931.1636980-1-kuba@kernel.org/


> There was already a patch for this
> https://lore.kernel.org/all/20260901072927.128688-1-jiayuan.chen@linux.dev/
> with extra locking to address sashiko comments.
>
> Jiayuan, were you going to send a v3 to address Paolo's comment? Or
> maybe resend your v2, since it got marked as "changes requested" in
> patchwork?



