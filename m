Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E041F7E5
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971668; cv=none; b=MZphxvXymLZ9Cpb1Md/TZ6wuNwHxWw1UiuYOdsob4j10NaWi9bOEqZbL6PtijoBiYEz5VsFSISNCn8zSYgN3toJaGsYW59f+rh0JtRCh3520gmBcpkHY5ANGeT6HSXtsOXC4wkmKgccZd7dazNj0D/5gcSF4QYjkdjL4TGKmfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971668; c=relaxed/simple;
	bh=FMvjApJtv3mJWHJvz+r/2mT9/tnwl9+tFIgv++0vW8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GV0PixCkPJSvA6Jfqwgjew67RsLnOyZlpG7n4iEJJfpPwsZil9837Jjb+VLJOAuWpN6GhdMBiyyCSGv7y7cO6zvoLpgU8QxpCZ391GcPfHuecGx9qa5IgKCtMaQqLxcVO9QEhY+v4bqonsxxrQ4tBkBdpFZTw5qnVdEi8Zo6C4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67HCxuXw046439;
	Mon, 17 Aug 2026 21:59:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67HCxujj046435
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Aug 2026 21:59:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7d6d4139-4389-4083-8569-ab2b7265ce3c@I-love.SAKURA.ne.jp>
Date: Mon, 17 Aug 2026 21:59:53 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: make sure final 'struct net' free in
 net_complete_free() is always deferred
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>
References: <34f44e8a-9fa4-4cb3-822e-5db54fb6df44@I-love.SAKURA.ne.jp>
 <CAAVpQUC672LJN_8KQ5BzadS26FnUrh4ayjyu-n5x=W7U69u7fA@mail.gmail.com>
 <CANn89iJd-s+mocDFXgt2rtFQVBGNJ7xEy=tUMKa5Da+brptXzA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CANn89iJd-s+mocDFXgt2rtFQVBGNJ7xEy=tUMKa5Da+brptXzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp

On 2026/08/17 14:26, Eric Dumazet wrote:
> On Mon, Aug 17, 2026 at 6:28 AM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>
>> On Sun, Aug 16, 2026 at 4:08 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>> Since there is no serialization mechanism (e.g. the RTNL lock) between
>>> llist_add() in net_complete_free() and llist_del_all() in
>>> net_complete_free(), it is possible that net_complete_free() finds 'struct
>>> net' as soon as net_complete_free() added it to the defer_free_list.
>>
>> Did you see a real issue or is this based on AI report ?

This is a theoretical issue which I noticed while writing
"[PATCH] net: add missing ref_tracker_dir_exit() to net_passive_dec()".

>>
>> netns_wq is single thread workqueue.
>>

There was a typo.

  Since there is no serialization mechanism (e.g. the RTNL lock) between
  llist_add() in *net_passive_dec()* and llist_del_all() in
  net_complete_free(), it is possible that net_complete_free() finds 'struct
  net' as soon as *net_passive_dec()* added it to the defer_free_list.

Old kernels called net_passive_dec() from only netns_wq context, but
new kernels call net_passive_dec() from not only netns_wq context
but also other contexts, don't they?

> 
> Indeed, this patch is not needed.
> 
> pw-bot: reject

Sashiko did a correct review (despite the typo above) and is reporting a pre-existing issue at
https://sashiko.dev/#/patchset/34f44e8a-9fa4-4cb3-822e-5db54fb6df44%40I-love.SAKURA.ne.jp .
