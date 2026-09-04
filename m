Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1E36EAAE
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 02:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487799; cv=none; b=uQKhHXQL7YXNzMP6LUaTQWJ23fJjZFfYZzkoEhUv0d8yC/SBoyDBLm2LkEfRHaHw9PFA8J1ud3vVZPC2B88PmUlHzUQWodRN+/mCVSY1WwS5VDhh3/3Bq3XP6r9sjQjgbMBoF8KwDj01Db1ESHf+754y3q9qALzPBoepA71DXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487799; c=relaxed/simple;
	bh=BMeFQ+GZlF4ab0g6//RFRMFJgtNUmqnK7e+RQqoIuyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaL5Nj+1+8J45kL/np520iX6gUstR1BbkdMTQbGotpo4JNsfuXvUwUMTJv0e5b3P6wPsyeqFvlftuxu/Dh8+p5hkN8kGDPTXJ2pxAKatk8LWyuLin9DbTa0C4XTnIiYXCTc/1jB/pDsT+fjwkZqQGh6CEZY0vwBumJo1b46p19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ETEAZ4i9; arc=none smtp.client-ip=95.215.58.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ETEAZ4i9"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BMeFQ+GZlF4ab0g6//RFRMFJgtNUmqnK7e+RQqoIuyc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788487795; v=1; x=1789092595;
 b=ETEAZ4i9zSFCcS2NDDhHnKZ0huI/9TFxbe4HcxC/9JXTrgy7eJn+3UkbODkADQ32y+cZ5XEe
 vNJIfDzy1HqSi2I4dN7OoVmJ5UlT+LfGmL/Xay0b0epVq5fV3+gRu8VepVKC6mmk2NarQBFVhlv
 H2BSD+FEhuGYDBzH3JpjT0y4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f1d90e771c373216;
	Fri, 04 Sep 2026 02:09:55 +0000
X-Mizu-Trace-ID: f1d90e771c373216
X-Migadu-Flow: FLOW_OUT
Message-ID: <56484f61-7290-4e3a-bb02-66c53042b180@linux.dev>
Date: Fri, 4 Sep 2026 10:09:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/2] netdevsim: add TLS device offload
 emulation and test
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260901154914.11637-1-jiayuan.chen@linux.dev>
 <20260903155932.6b4528de@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260903155932.6b4528de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


on 9/4/26 6:59 AM, Jakub Kicinski wrote:
> On Tue,  1 Sep 2026 23:48:55 +0800 Jiayuan Chen wrote:
>> It helped me find
>> commit b17cf742eaad ("tls: device: fix out-of-bounds write in tls_append_frag()").
>>
>> So I think it is worth sending a formal patchset.
>>
>> The kTLS device offload path in net/tls/tls_device.c has no test
>> coverage upstream -- selftests/net/tls.c is software only, and the
>> offload code needs a driver that implements it.
>>
>> So teach netdevsim to fake it.  Patch 1 implements tlsdev_ops and
>> advertises the TLS features, patch 2 adds a selftest.
>>
>> No crypto is done: TX puts the plaintext record on the wire, RX just
>> sets skb->decrypted.  That only works netdevsim to netdevsim, but it
>> covers record assembly and the offload lifecycle.  Real ciphertext, and
>> more on top of it, can come later.
> Please don't post selftests to net-next which depend on a fix going
> to another tree. If we merge this now we will have a failing test
> until the fix also lands.
>
> If we add TLS support to netdevsim it must be paired with a test
> which can also run against real HW. There was a selftest posted
> recently by the person working on TLS 1.3 offload, we can use that
> as the target (feel free to add that to your series, just keep
> the original author).
>
> We can add special netdevsim-only cases but the main focus should
> be writing tests that can be executed against real devices.


I think I just wait until that series is merged and then take a next setp.

