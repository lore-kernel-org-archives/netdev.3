Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E83F7A94;
	Tue, 24 Mar 2026 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356299; cv=none; b=Ax8U5WsQe9Pe0KKzu1xNbJ6oCMBDLiMHFC3uSf2snYCuC5858E4jhr/ot6TidF1wxA/WA5DpLmuBvxPgAP6cjjYsP6M6tc83ERFX0R6DGeo00FrUnN+FAm8SYNC8BbGZtS2Dto0t71SG7rUstNTRp+aHGYmo3mOxDckdb7Ea7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356299; c=relaxed/simple;
	bh=MECXmf1N7eTDqIEEtE6cjyVHRV6CSyjA2h376sZKcSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHN3mqFRJVfETx+bPPo1cOcLOX3aw44KPcuaNQdytIFzBqdWD6iI+0ngnnwT6XBcbBUUCHge51JrYlGbHkqZyezvNBdjNVYJVYR8zBysYeFAuQIYgdHDyB+XqvwtBSXBwjg126tmWlORYL62ItuZmqk2k2VZu2lx2NpXGvPuJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX8FZp5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX8FZp5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD92AC19424;
	Tue, 24 Mar 2026 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356299;
	bh=MECXmf1N7eTDqIEEtE6cjyVHRV6CSyjA2h376sZKcSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XX8FZp5GU6E6W7uR76IDePM795l6hyDsdm13tTnpyBYMah4ZB34htc2F3B+YiOZlE
	 Jz77MrpT70UFBtQZJzrKm6loXrR11BKmb3THeOzilL8mndF4e+HgcN1V616yfo8DSu
	 wq7h6tEofDIc3n86+AkLuqZgT3//JE3loMXpXRy83xAJ3k7RUgZigmADEnr7Bgvi6Y
	 K3/B1XCCkHKHuOcMi3TdMSlJUr8+idPM4iAbvVCS7mbr8MLrSi3mzr9gLUky42NqG/
	 0jCEzpUIHgSe2AQVFRbnfk885p7E1HfVeckKE6QIpIuifgL8bOIXKuBekl5MZhe8ag
	 C3bRZ0ByeM8Nw==
Message-ID: <26496470-4868-4cd0-8d10-bd8b1a3f1473@kernel.org>
Date: Tue, 24 Mar 2026 08:44:57 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption
 in read_sock
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
 <0cf288bb-6ab1-4f2b-8a7f-727b3e1fe0d2@app.fastmail.com>
 <acHDJNNqZlFIm84n@krikkit>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <acHDJNNqZlFIm84n@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/26 6:48 PM, Sabrina Dubroca wrote:
> 2026-03-23, 17:28:27 -0400, Chuck Lever wrote:
>>
>> On Tue, Mar 17, 2026, at 11:04 AM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> tls_sw_read_sock() decrypts one TLS record at a time, blocking until
>>> each AEAD operation completes before proceeding. Hardware async
>>> crypto engines depend on pipelining multiple operations to achieve
>>> full throughput, and the one-at-a-time model prevents that. Kernel
>>> consumers such as NVMe-TCP and NFSD (when using TLS) are therefore
>>> unable to benefit from hardware offload.
>>>
>>> When ctx->async_capable is true, the submit phase now loops up to
>>> TLS_READ_SOCK_BATCH (16) records.
>>
>> It appears that async_capable is always false for TLSv1.3. Since
>> TLSv1.3 is a hard requirement for both NVMe/TCP and RPC-with-TLS,
>> patch 8/8 is moot for us. For the moment, I'm going to drop this
>> one from the series.
> 
> Then 7/8 is also not useful, and the series boils down to a few small> improvements (tls_decrypt_async_drain, spurious wakeups, checking the
> backlog), which are not limited to read_sock. [nothing wrong with
> that, it's just a different focus from what you started with]

I think that's accurate. I can adjust the cover letter for v5.


>> Once Alistair's KeyUpdate work is merged, we can revisit.
> 
> Are you planning to add support for async crypto with TLS1.3?
async crypto would be a pre-requisite requirement for batching
decryption for TLS v1.3. At the moment I'm not planning to add
that support, but we should discuss it once KeyUpdate is merged.


-- 
Chuck Lever
