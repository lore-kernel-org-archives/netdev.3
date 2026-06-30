Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EC3CF211
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799043; cv=none; b=iICmCQyw6zQSYFmzY3QBChG5tnwWStPH4Y0hUQM4suceoX8XTn/j+v9eeeshp0XTPE9XPKrQh5ukhX2x4ho1TLGsqZOrUrNjac4cMGlrZtFb0HKE8+G6fu4ApLAiAs6cI7h34Lu9dLrY+oZL43LGEcxm9/5E7bThOlCc7nOYzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799043; c=relaxed/simple;
	bh=VUkzefoP3syEwjoxsM0jd/kwkWaM6ARSRGBzCCPvXC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGYtZEROLAwqz6AL93ALMXAMS/lGv4yGPp4Z8paGWF7t3cJuGb/08xNsIKugTtB7vt7U9BCwU6waX+VOnGkshvGvypw8rDw4sX/9ph+mFyv7oW2zsnbzNW/GY/TPMHrzAfTiW+jTuhNTETTIvCuloIfICwK5ncSI1fUoDkJY8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tz2Wpuk0; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tz2Wpuk0"
Message-ID: <3b746d04-33f3-4d86-bc8c-292a341557ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782799040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa2f4+8S5Vvxa/LNjMGjEcrUuIesTqSX7RxqUJee4vI=;
	b=tz2Wpuk0Jrg+yFgC5g2nhNqrkcERbK82CyZS3N/BSOVMhqv0oAZ1F61ptkqPHZRW7L3NUV
	W7Oz0pl2AkAybIU4PYK+qB7EGtOrvbNTJ1nZ48gE/A7PNnEhZ7Po76AWlNsfS1qbq0/KvY
	tIoyTI7Tt3igjD7TWgrz6pOE78XPfWI=
Date: Tue, 30 Jun 2026 13:56:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1] tcp/dccp: avoid parity split for socket-local
 bind range
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, luoxuanqiang <luoxuanqiang@kylinos.cn>
References: <20260626093856.61864-1-xuanqiang.luo@linux.dev>
 <CAAVpQUCayy3o59i2vh9hHRPi-3pw1BJgEYMwZYRpZnYEUoqsGw@mail.gmail.com>
 <F6AFD54C-1618-4501-80C2-88F796BA95C0@linux.dev>
 <CAAVpQUA+yKA773dtgr2E=mu4SbMCjWZk83sFYrWS6f1sDphdRQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUA+yKA773dtgr2E=mu4SbMCjWZk83sFYrWS6f1sDphdRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/6/30 02:21, Kuniyuki Iwashima 写道:
> On Fri, Jun 26, 2026 at 7:00 PM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>> 2026年6月27日 07:40，Kuniyuki Iwashima <kuniyu@google.com> 写道：
>>>
>>> On Fri, Jun 26, 2026 at 2:40 AM <xuanqiang.luo@linux.dev> wrote:
>>>> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
>>>>
>>>> IP_LOCAL_PORT_RANGE lets applications override the netns ephemeral port
>>>> range on a per-socket basis.  __inet_hash_connect() already treats such a
>>>> range as an explicit application partition and scans it with step 1 [1].
>>>>
>>>> Do the same in inet_csk_find_open_port():
>>> What's the use case of IP_LOCAL_PORT_RANGE + bind(, 0)
>>> without IP_BIND_ADDRESS_NO_PORT ?
>> Hi Kuniyuki,
>>
>> Thanks for the question!
>>
>> The use case is when an application wants to restrict ephemeral port
>> allocation to a socket-local IP_LOCAL_PORT_RANGE, but still needs
>> bind(..., 0) to allocate and reserve a local port immediately.
> IP_LOCAL_PORT_RANGE was introduced for connect().
>
> Unlike connect(), bind() occupies the port without SO_REUSEADDR/PORT,
> so I don't think the step 1 or 2 makes any difference.
>
Hi Kuniyuki,

That's a fair point — bind() takes exclusive ownership of the port
without SO_REUSEADDR/PORT, so the parity split only changes the scan
order, not the set of ports bind() can pick.  Correctness-wise there is
no difference between step 1 and step 2 here.

There are a couple of smaller things that made me think it is still
worth aligning the two paths, though:

- inet_csk_find_open_port() already consumes the narrowed range from
   IP_LOCAL_PORT_RANGE since commit 91d0b78c5177f ("inet: Add
   IP_LOCAL_PORT_RANGE socket option"), so the bind path isn't
   insulated from the option.  It just didn't pick up the relaxed scan
   step that __inet_hash_connect() got in commit 207184853dbdb
   ("tcp/dccp: change source port selection at connect() time").  Eric
   even noted at the end of that commit:

     "A similar change can be done in inet_csk_find_open_port() if
      needed."

   So this felt more like completing the companion change than adding
   something new.

- The entropy argument from commit 207184853dbdb applies equally here:
   the parity split drops one bit of the 16-bit sport for RSS hashing.
   Whether the port came from connect() or bind() doesn't matter to the
   NIC, and losing that bit hurts more when the application has already
   shrunk its port space with IP_LOCAL_PORT_RANGE.

- When IP_BIND_ADDRESS_NO_PORT is not set, plain bind(, 0) reserves a
   port immediately through inet_csk_find_open_port().  If the same
   application also uses connect() on other sockets within the same
   IP_LOCAL_PORT_RANGE, connect() now scans the full range while bind()
   still biases toward odd ports — so the parity heuristic works against
   itself inside the application's own partition.

Does that make sense, or am I over-thinking the consistency angle?

Thanks,
Xuanqiang

>> IP_BIND_ADDRESS_NO_PORT is useful when the application can defer port
>> allocation until connect(), but it changes this behavior: bind(..., 0)
>> does not reserve a port in that case. So it is not a replacement for
>> applications that need the local port before connect(), for example to
>> publish it to another component or set up local policy.
>>
>> This patch is also intended to keep the bind(..., 0) path consistent with
>> Eric's earlier change in __inet_hash_connect().
>>
>> Thanks,
>> Xuanqiang
