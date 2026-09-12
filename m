Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09B278156
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220385; cv=none; b=Ys6zAmFogqivRbu38oT3LhJRanERLC4PmATv1P/BDzdonZxVvOxg6DgnwxO4rPV/FhzsCqGNAILQWQGg6dNQfGtZ+kq91XKMvB6Rb0Yar3rQ/7e482YnLnu3W7/Ajp1nhNnOzMlO8Ag9Kxmbq6Gzfoo9aK6UkhjDYdY7Yfn08U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220385; c=relaxed/simple;
	bh=Z0wkZMgUuryJXwEU2UXNLzI9px7nThxGSXCtQFdQV1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfMDK1EM5KkaztoNlSEkiXrQqJ0NzuwlcgQcxilBKgCmxpCS5bV79uQ9MV6NyAz+vNyqekdW6m9AcYpWSXLo8dlojqFI7uVn4ofG07/6li9dCPZmca7X7w862rF27mogiLtPMmRCToQzIs3WTfH+iGsY91LYTcQ+DzNlsXvYGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n2n+2HJC; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n2n+2HJC"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z0wkZMgUuryJXwEU2UXNLzI9px7nThxGSXCtQFdQV1E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789220377; v=1; x=1789825177;
 b=n2n+2HJCrITPfd1xniEEts+cfciXBMFLPi6jhZwGBmFjZVpRUn2ZJas68Q/BO2/W5EqQDuyJ
 3z9AVJSPS4RqQtfwxxIWMSYVlErBYEV5tbNrfjjCp6KdOt7mXhLUAxhJ5l2fVvA0NH8JlTaY5ZB
 7/VsTwVrjFkFpC0UhRY9Ftnk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5d04fd228bda98b6;
	Sat, 12 Sep 2026 13:39:27 +0000
X-Mizu-Trace-ID: 5d04fd228bda98b6
X-Migadu-Flow: FLOW_OUT
Message-ID: <d9cb00fe-85fe-466f-b6ee-c5694d134ed4@linux.dev>
Date: Sat, 12 Sep 2026 21:39:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: skbuff: do not leave stale header offsets after
 pskb_carve()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com,
 Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260911114922.621937-1-edumazet@google.com>
 <a53a81cd-88b6-4db2-a0e6-ee3dccfeef42@linux.dev>
 <CANn89iJw5P-wARumRgxdPaHXBJ3qF0zu6FNaNOFKonyww9AJpg@mail.gmail.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89iJw5P-wARumRgxdPaHXBJ3qF0zu6FNaNOFKonyww9AJpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/12 16:57, Eric Dumazet 写道:
> On Fri, Sep 11, 2026 at 11:38 PM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>
>> 在 2026/9/11 19:49, Eric Dumazet 写道:
>>> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
>>> the first bytes of a packet and reallocate skb->head.
>>>
>>> All the headers that were present before the operation are gone,
>>> but both functions call skb_headers_offset_update(skb, 0), which
>>> is a no-op : skb->mac_header, skb->network_header,
>>> skb->transport_header and skb->csum_start are left with their old
>>> values, now pointing into the freshly allocated (and possibly much
>>> smaller) skb->head.
>>>
>>> For pskb_carve_inside_nonlinear() the result is a zombie skb with
>>> an empty linear part (skb->data == skb_tail_pointer(skb),
>>> skb_headlen(skb) == 0) but skb_mac_header_was_set() still true and
>>> skb->mac_header pointing far beyond skb_end_pointer(skb).
>>>
>> Could you please clarify how the MAC pointer ends up beyond
>> skb_end_pointer() here? The carve helpers allocate based on the old
>> skb_end_offset(), and kmalloc_reserve() adds room for skb_shared_info,
>> so the new capacity shouldn't be smaller.
>>
>> The dump shows mac=234 and end=384. I understand how the stale offset
>> causes skb_pull() on an empty linear area and triggers the BUG, but I
>> don't see how it ends up beyond the new end. Am I missing another
>> condition?
> 
> skb_headers_offset_update(skb, 0) is a no-op, so mac=234, net=248,
> trans=288 and csum_start=288 survive and now describe bytes that are not
> there anymore. skb_mac_header_was_set() still returns true, so drop_monitor
> does skb_pull(skb, 234) on an empty linear part and hits the BUG in
> __skb_pull().
> 
> pskb_carve_inside_header() has the same issue, the remaining linear data is
> shifted by off bytes while the offsets are left untouched.
> 
Thanks for the explanation. The fix itself looks correct to me, and I
understand why the stale MAC offset causes the BUG.

Could I check my understanding of "far beyond skb_end_pointer()"?
The dump shows headroom=0 and headlen=0, so head=data=tail. With
end-tail=384 and mac=234, the MAC pointer is head+234, still before
end at head+384. For this nonlinear skb, did you mean beyond
skb_tail_pointer() rather than skb_end_pointer()?

Thanks,
Xuanqiang
