Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5730566B
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789946833; cv=none; b=LVJTcNgJ/TjnAOikuXw2dzAhreV0jvArFbWVtNX//aBAga5o2+7bhlbf7d/quS4S7xDJZ3FRp9/zz5veImJFl+MezJaybZPCJWdQ05a5NtTWhLhvwq2t8nQjpTES7k5tQXMzDxFdFoiGt9MOp+44dBc8iI9LYfi2hf436HKrjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789946833; c=relaxed/simple;
	bh=+ZCrD9TfbuBLeSGTKd7X9CvBgPip0rrnQ/QrjwlgDJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZY/rCo2akJdjZWSx7O+E7hp3wQlQJe3thrFhticgfYNurtiEEhtuHVPELHmOUgvmPoTMOnr7HeKyIJVVgtkZ5SWDOzpw+sfo7BhyqnBcxS6fGQe7PHVpae1G/6tEtNgw+SLS7HRJzmco6M0BJ8TXzupHPtmfPQCf7Lv+WzGghi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=gC4iKAdZ; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="gC4iKAdZ"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 31ACE5340694;
	Mon, 21 Sep 2026 01:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1789946830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S5H8DJugfiQqXqE+zucVCQWOxAjqhPaEgOBGdJavRsI=;
	b=gC4iKAdZYOde9ceZd/2S8t1hXN7ghMF6WhGKg9OOK9ljzsMz0bKehpirHJ1/y5wTWAyu/G
	E9TkSsd7M3uK56NdYBoOkRDdJEG664y/du8fo3RAUFBXxzOCmd3vPt5YjyAz/pEH/IarGv
	xIuJxGkZJUHXCpv3XbXu5l+lnsYsZ0A=
Message-ID: <532cee91-122f-4c71-9b4b-3c48159f501d@ixit.cz>
Date: Mon, 21 Sep 2026 01:27:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] net: nfc: fix use-after-free in
 nfc_get_local_general_bytes
To: Simon Horman <horms@kernel.org>, Ren Wei <weir@nebusec.ai>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kees@kernel.org, pengpeng@iscas.ac.cn,
 raoxu@uniontech.com, rosenp@gmail.com, dddddd@hust.edu.cn, joe@dama.to,
 ian.ray@gehealthcare.com, kuniyu@google.com, linma@zju.edu.cn,
 vega@nebusec.ai, rakukuip@gmail.com
References: <cover.1788841682.git.rakukuip@gmail.com>
 <3cbaac3bee23f8ff3a3284ed32d347696eb1d208.1788841683.git.rakukuip@gmail.com>
 <20260912101633.GG48209@horms.kernel.org>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260912101633.GG48209@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2026 12:16, Simon Horman wrote:
> On Wed, Sep 09, 2026 at 01:19:24PM +0800, Ren Wei wrote:
>> From: Luxiao Xu <rakukuip@gmail.com>
>>
>> Commit 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
>> nfc_llcp_find_local") attempted to fix a use-after-free (UAF) issue by
>> invoking nfc_llcp_local_put(local) after accessing local->gb. However,
>> if the reference count drops to zero, local is freed immediately,
>> leading to a use-after-free when callers access the returned pointer.
>> Alternative approaches using dynamic allocation (e.g. kmemdup) introduced
>> memory leaks because callers consistently treat the returned pointer as
>> borrowed memory.
>>
>> Fix this properly by refactoring nfc_llcp_general_bytes() and
>> nfc_get_local_general_bytes() to accept a caller-provided output buffer
>> (out_gb) and its maximum length (gb_max_len). The general bytes are
>> safely copied into out_gb before calling nfc_llcp_local_put(local),
>> ensuring safe lifetime management without ownership transfer complications.
>>
>> Update all callers across drivers (microread, pn533, pn544, st21nfca,
>> digital_dep, and nci) to provide their own destination buffers and pass
>> them to nfc_get_local_general_bytes().
>>
>> Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
>> Cc: stable@vger.kernel.org
>> Reported-by: Vega <vega@nebusec.ai>
>> Assisted-by: LLM
>> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
>> Signed-off-by: Ren Wei <weir@nebusec.ai>
>> ---

[...]

> As far as I can see the return value of nfc_llcp_general_bytes() is now
> ignored. And for a bug fix the approach you have taken looks good,
> as the interface provided by nfc_llcp_general_bytes() is only slightly
> modified.
> 
> But, FWIIW, I think it would be cleaner if nfc_llcp_general_bytes()
> returned the length, or 0 on error. And the general_bytes_len parameter was
> passed by value rather than reference.
> 
> Something like this:
> 
> size_t nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb,
> 			      size_t gb_max_len, size_t general_bytes_len)
> {
> 	...
> 
> 	if (error_condition)
> 		return 0;
> 
> 	...
> 
> 	return general_bytes_len;
> }
> 
> Perhaps that approach could be considered as a follow-up.

Yes, that would be really great!

Thanks
David

