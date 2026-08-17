Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FB19AD90
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786926932; cv=none; b=p27Ok5w+wWHpXbVUWwG7NDpvosVmuIPxcVxHxgWng293J3YZCnoXIB+vj2yl960DAU67ToS1eQR0e9rFK6OboEuCJ6hkdkqWUvHDJbRP4RoByLss1DUZKi0rUEUULOv63u/fs1H5VFILKcIEasY/KMYBGwD+wkaMnE/SBTTwn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786926932; c=relaxed/simple;
	bh=1f1Z4MBW/XoJe2K9oEW57m5NLO5VbDoaOLqmmuNtlg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGdMpITzVv5kPcP6ZkVSac+G8yU0HF6Uv8Qda3oWqgZAEm7i1Nz+Q1+M/5NfFuvsOBZzojBN+wA9Y7uDxgjXJfoI8Cb7bBEtx9KpK7deeHpSx/BjUP+FnhDZw6Je3UaS7AwiDJWeWTcGTcey9ZN3qW8RjqNma8hpgm9shUUrzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Qgcqzzq9; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Qgcqzzq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1786926927;
	bh=6+xXhRkohpflekplecwqyMdPW0YNzOLFlu7gBLbhZP4=;
	h=From:Subject:Date:Message-ID;
	b=Qgcqzzq9OjjLA4RGTn6ham+9ZcQNjPrDxXzLecihgyM5ZBizKGFGX3txcOskHVCyL
	 XjHNjUAkccuXxD06NHZTXgriealBHqXl/gC8RSAU0MIImZ9fvx0qMci0kL7rPTEoE4
	 A06zp/Cit3/k6azDg9JgGS6V1vuheOOfjG4ViMrM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.33) with ESMTP
	id 6A82574800002A32; Mon, 17 Aug 2026 08:35:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3469806685492
X-SMAIL-UIID: C6ACEC40819142E59DADD02F0ACED4A6-20260817-083523-1
From: Hillf Danton <hdanton@sina.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Uladzislau Zhauniarovich <uladzislau.zhauniarovich@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+19d01f6082ec61dd45b2@syzkaller.appspotmail.com
Subject: Re: [PATCH] net/sched: taprio: enforce minimum software scheduling interval
Date: Mon, 17 Aug 2026 08:35:13 +0800
Message-ID: <20260817003514.1241-1-hdanton@sina.com>
In-Reply-To: <20260816142847.227167-1-junjie.cao@intel.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Aug 2026 22:28:47 +0800 Junjie Cao wrote:
> On Fri, 14 Aug 2026, Hillf Danton wrote:
> > Better if you specify why interval like 2us is ruled out.
> 
> The yardstick is the service cost of one expiry. On a release build I
> see ~5.1M local timer interrupts in 5s on the owning CPU for a 700ns
> single-entry schedule on veth, so the whole per-expiry service path is
> around a microsecond; Uladzislau estimated ~10us per invocation on the
> syzbot debug config earlier in the moderation thread. A 2us interval
> still livelocks a debug build, and on a release build it pins a
> permanent ~500k irqs/s on one CPU. 100us keeps margin above the
> debug-config cost.
> 
The 2us interval survived the syzbot test [10].

[10] Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in exit_to_user_mode_loop
https://lore.kernel.org/lkml/68885247.a00a0220.b12ec.00c8.GAE@google.com/

> One more thing that came out of testing this: the floor only covers
> half of the problem. A valid schedule that falls behind replays its
> whole backlog one hrtimer expiry at a time. With a 4x200us schedule
> and CLOCK_TAI stepped forward 72h (think ptp4l's first big step, or a
> VM pause) I get an RCU stall with the owning CPU stuck in hrtimer
> expiry processing, and no admission check can catch that; syzbot's
> reports show the same stall with advance_sched() on the stack. A
> bounded catch-up in advance_sched() fixes it. Conversely, catch-up
> alone doesn't help the storm case: the 700ns schedule is still
> admitted and sustains ~1M irqs/s.
> 
> I have both halves ready as a series - a bounded catch-up in
> advance_sched() plus this patch with the exemption folded in - tested
> by syzbot against both reproducer buckets on net.git dd057113ac7b,
> with a tc-testing case. I plan to post it in a day, keeping your
> Signed-off-by on this one, unless you'd prefer to respin it yourself.
>
The guys on the cc list know I hate SOB because cc is enough.
