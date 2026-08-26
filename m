Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E61C84AB
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740070; cv=none; b=k1bNcTlWZzJF0aM059Rnpg9ogu2cwtQlZmffy+Cu6NKr+zrzveyQ7BQPKuMcooSK/dfyqOeyORURMKwP934WrNWoG7ZKQVDoiT+Z8YwnmoErwFmWJm0qkz9qMLW4/oEVzzpYZUmsFT4MONoOHyTlJLjTcwYiDE1ByGCdfSNchdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740070; c=relaxed/simple;
	bh=Y1pHpqz9//ulna1bs7VQAlliILT8I00xc0CdnxJv0VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyF70QMvfUCpVKMLu9O8yo8xyo8zuTrB0hwxecJfb5t1RpxvpBAMDCfPrMMU4uBpDVVizBJI1F+30Q6CHSMlutSXa7jU9zfKFMjyTIejZ2kESeQOjtpIX/99i4NkOZuXkKe+i0QcSpOWYc+aDocpSRCwDXjqbJdG6+7+A+dOdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=G9Y8OzQZ; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="G9Y8OzQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787740064;
	bh=6xTlKpsDlJOqs3W/yjXrpkuyHUwmKAvYUndEqH2KEDA=;
	h=From:Subject:Date:Message-ID;
	b=G9Y8OzQZM3tTwYtM3LRAxi2LyyKUb4HN2eG8W0Un17ZXEuspjzkd37mf+4dF6lv5i
	 OkztcY3njYIa08hBcL5Ulas05FQLFspFatTcXpe0lnwRwsqkE3FHriYQ8yCEPD8yPo
	 PxgMki9nFZZ5K1SpSWrvGRGHR5lEtxi3EC9qNc+A=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.32) with ESMTP
	id 6A8EBF8E00005DA2; Wed, 26 Aug 2026 18:27:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2621944456833
X-SMAIL-UIID: 5DB360D79E3D4E9E9F65D737821476E2-20260826-182732-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	boqun@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Date: Wed, 26 Aug 2026 18:27:16 +0800
Message-ID: <20260826102718.1550-1-hdanton@sina.com>
In-Reply-To: <CANn89iKEVEs5=K1Uhj_CHagbt+eV0QGernwz9EBFkLEZOB1FAw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 26 Aug 2026 06:05:15 +0200 Eric Dumazet wrote:
>On Wed, Aug 26, 2026 at 5:06 AM Hillf Danton <hdanton@sina.com> wrote:
>> On Tue, 25 Aug 2026 22:26:25 +0900 Shin'ichiro Kawasaki wrote:
>> >On Aug 25, 2026 / 14:45, Hillf Danton wrote:
>> >> On Tue, 25 Aug 2026 14:44:35 +0900 Shin'ichiro Kawasaki wrote:
>> >> > On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
>> >> > >
>> >> > > I think 19bdb70c77d3 should be reverted.
>> >> >
>> >> > Just reverting the commit will reintroduce the other lockdep WARN that the
>> >> > commit addressed. I hope to have another fix to avoid the WARN.
>> >> >
>> >> I do not think you know the root cause of that lockdep warn, so reverting
>> >> 19bdb70c77d3 is the right thing to do because of [11, 12].
>> >>
>> >> [11] ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")
>> >> [12] Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
>> >> https://lore.kernel.org/lkml/20260816014906.1149-1-hdanton@sina.com/
>> >
>> > I took a look in the commit [11] and the discussion [12], but couldn't follow
>> > why the commit 19bdb70c77d3 should be reverted. Could you elaborate a bit more
>> > about the reason you suggest the revert?
>> >
>> The Fixes tag in d532cddb6c60 proves Eric delivered a HBC, half baked croissant,
>> to lore. And the nvme-tcp tucked in the HBC hints Eric copied something from
>> somewhere. Finally the absence of ffa1e7ada456 in 19bdb70c77d3 proves it is
>> worse than a HBC. Clear dude? Or go to read [12] again?
>
> linux development is iterative, we do not submit a single patch fixing
> 1000 bugs at once.
> 
The iterative word fails to justify you can submit any fix before understanding
the root cause.

> I decided to ignore your rants a long time ago, as many others did.
> 
Your HBC forced you to quiese instead just like the ostrich burying his head
in sand.

> How many bugs did you fix last year?

More than 150 [13].

[13] Subject: Re: some works in 2025
https://lore.kernel.org/lkml/20251112225650.9224-1-hdanton@sina.com/
