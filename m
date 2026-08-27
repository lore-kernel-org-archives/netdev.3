Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F7330676
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814428; cv=none; b=T2y/gKSEUOB+evxgI35YZOQptfFnYmk4FwoXutP+nKnopz39E2teHREcvxzSGIM4rQfKUtqET4BUnrr3U4VFx6Nxo+5hjGJW5xjNftsfzj8YXMNh8IK1VgHm+/ERBf7cwNZ5/rPHnMdnPSmK+zZPtMpm6fDC+R7z6bVmD+UkxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814428; c=relaxed/simple;
	bh=J/q53GV7BVk1Lr8b5iatkIuwYAEhyAk7tPRMPNXwllA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt0AQjP+p/B74xWih9ykVAnRfJNOEXJx/2HfzRUW2r2IzvFXKySo6NVJeUG7tT9TjcCvaZdFZUrzUP85sFj/zHg+hOWbd1xo3Tt2Rl6ukiSKYtbE3HwYZ518/SdAo2knqBgYOGUy2EZZNMtl6ZQCz60kGA3ADStubHULos3TM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eCtFLpyi; arc=none smtp.client-ip=91.218.175.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eCtFLpyi"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J/q53GV7BVk1Lr8b5iatkIuwYAEhyAk7tPRMPNXwllA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787814424; v=1; x=1788419224;
 b=eCtFLpyiJ/pqzJ5arMpwY39cWJo23eeuWr6ek0GWSub7vw3w16px4DDph2Qwr3wTgVyftWNK
 YY74e0pVUj2iNHCKFWUj1PzOqtplIsnSB1BWMvywdb3YaVN1bIeawHQu3Zsh5hnzMIOd0Ghomzx
 MUguFZXAc+8QYyyEw2WXtgj8=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2408:820c:b608:6660:20e9:11e4:d882:2911] (2408:820c:b608:6660:20e9:11e4:d882:2911)
	by smtp.migadu.com with ESMTPS id 8e5ec811f77e8d7d;
	Thu, 27 Aug 2026 07:07:04 +0000
X-Mizu-Trace-ID: 8e5ec811f77e8d7d
X-Migadu-Flow: FLOW_OUT
Message-ID: <01794194-4a01-4725-ab41-282b8ac93d1f@linux.dev>
Date: Thu, 27 Aug 2026 15:06:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix refcnt_tracker use-after-free on netns
 creation failure
To: Eric Dumazet <edumazet@google.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: netdev@vger.kernel.org,
 syzbot+d3f912a2e30e2079a512@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Jan Kara <jack@suse.cz>,
 Qiliang Yuan <realwujing@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260827052219.290380-1-jiayuan.chen@linux.dev>
 <CANn89iKK5jxVa34F7QMPjp5wormMQrZgoK4THJCqVp76Tw1NNA@mail.gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iKK5jxVa34F7QMPjp5wormMQrZgoK4THJCqVp76Tw1NNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 8/27/26 2:56 PM, Eric Dumazet 写道:
> On Thu, Aug 27, 2026 at 7:22 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> The copy_net_ns() error path tears the net down via net_passive_dec(),
>> which only exits notrefcnt_tracker. refcnt_tracker is exited in
>> __put_net(), which this path never reaches, so it is left alive.
>>
>> Since ref_tracker_dir_init() started registering a debugfs file per
>> dir, that file must be dropped by ref_tracker_dir_exit(). The missing
>> exit leaves the file pointing at the freed net, so reading it walks
>> net->refcnt_tracker.lock and hits a use-after-free.
>>
>> The missing exit has been there all along, but before the debugfs file
>> refcnt_tracker was just an in-memory ledger and empty on this path, so
>> skipping it leaked nothing and did no harm. Only the commit below, which
>> gives every dir a debugfs file, turned it into a use-after-free, so
>> Fixes points there.
>>
>> Exit refcnt_tracker on the failure path.
>>
>> Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debugfs for a ref_tracker_dir")
>> Reported-by: syzbot+d3f912a2e30e2079a512@syzkaller.appspotmail.com
> Missing `Closes:` tag makes analysis cumbersome.
>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   net/core/net_namespace.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
>> index a91d2b58aadd..0c3f169d9afb 100644
>> --- a/net/core/net_namespace.c
>> +++ b/net/core/net_namespace.c
>> @@ -591,6 +591,10 @@ struct net *copy_net_ns(u64 flags,
>>                  key_remove_domain(net->key_domain);
>>   #endif
>>                  put_user_ns(user_ns);
>> +               /* setup_net() failure is not routed through __put_net(), so the
>> +                * refcnt_tracker (and its debugfs file) has to be released here.
>> +                */
>> +               ref_tracker_dir_exit(&net->refcnt_tracker);
>>                  net_passive_dec(net);
>>   dec_ucounts:
>>                  dec_net_namespaces(ucounts);
> I am a bit confused. I thought this was already discussed and fixed by
> Tetsuo Handa?
>
> f85dc137aabf ("net: add missing ref_tracker_dir_exit() to net_passive_dec()")
> should be fixing this?


Thanks Eric, now I find it it in net tree. I should anylyze it base net 
tree not net-next.

Please ignore my patch.


pw-bot:cr


>
> Tetsuo also followed up with 3220b62fbb8a  ("net: fix a resource leak
> in copy_net_ns() error handling path").
