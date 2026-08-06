Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFA3AEB5F
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030466; cv=none; b=XIakpEtOnIjEgBSq0dfdr4q4iiUMs6RT9S7lptBRJc++j7A97sMpsDMYsMiOujS0yfKVeULmqlQSHKuRzJpX8VlwIRFldzMoJ4GJkwy7FiD29R+CowprZibIICSbD6vTec5naeG+u2oH8g5t8oS6m9G4RmT04pQ8hdAJHsgIZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030466; c=relaxed/simple;
	bh=FxObtbgqm/ZQn5/T1KiHkx1b4gmdzhL3J2edlXpdLe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYU5L00gEWOLY2BFdIQAd3QaJqWqU2ZBeJjuDqKxq/eMKRQ63cz5+GfCF4SQNmQ51osmMqzjgbtGJM3C95Q+SUx7z2N9ik7lqO5KpatwlAlDY6dkwL5t3XKrOkURNMRtWOKtYQa/Xta87NKg+zBx3ljprj1cYjqH7Bm7IRG3iIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 676FY8RG002933;
	Fri, 7 Aug 2026 00:34:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 676FY8Hm002930
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 7 Aug 2026 00:34:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bde6aeae-42b9-45eb-90f1-7616770c09ee@I-love.SAKURA.ne.jp>
Date: Fri, 7 Aug 2026 00:34:06 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net: udp_tunnel_nic: reference count leak during
 network namespace migration
To: Eric Dumazet <edumazet@google.com>
Cc: Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>
References: <73ed3aa5-f6e1-47b6-9e5d-428ac1f4cbf3@I-love.SAKURA.ne.jp>
 <2175f74b-00c7-4868-aea5-ed9c171c41ee@I-love.SAKURA.ne.jp>
 <CANn89iL-ghxRFqSGeqpOfxNnOdyBRO_Nik+6chu6-eLw-wdTOw@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CANn89iL-ghxRFqSGeqpOfxNnOdyBRO_Nik+6chu6-eLw-wdTOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/08/06 22:57, Eric Dumazet wrote:
> On Thu, Aug 6, 2026 at 3:18 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Ping?
>>
> 
> Is this a dup of
> https://lore.kernel.org/netdev/6a632b15.dde6c935.cf6c8.0011.GAE@google.com/T/#u
> ?
> 
> If not, please send a patch.

Symptom is different (memory leak v.s. refcount leak) but fix will be the same.

I will wait for your responses on
https://lkml.kernel.org/r/bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd@I-love.SAKURA.ne.jp .

> 
>> On 2026/07/18 21:03, Tetsuo Handa wrote:
>>> Description:
>>>
>>>   syzbot is reporting a reference count leak when a netdevsim device configured with
>>>   UDP tunnel offloads is moved to another network namespace, and then the target
>>>   namespace is destroyed.
>>>
>>> Cause of the Leak:
>>>
>>>   The root cause is a structural mismatch between the namespace migration logic in
>>>   __dev_change_net_namespace() and the unregistration path in udp_tunnel_nic_unregister().
>> (...snipped...)
>>

