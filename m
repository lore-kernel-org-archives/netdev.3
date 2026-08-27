Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D520125F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833946; cv=none; b=nz0GtFMN1TqTSD6QKaJTfO2Qs8Ubi+NaDgnVKBF7C38+pTqOiDzyifLXe259QDyj3qfQsMsQdtuJ7x8anVYIGtz9s0Qmo5B6stTpG3SaF6aC/2IB6sirBySDblgKbpIexasD4jjrsjSE8D7FK2lqP2ylCzS+BQKblqmSEznGWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833946; c=relaxed/simple;
	bh=RBZB9BXn3rlldYFpbD1GyN4U/QuX7F8ri+NK7+Xtd1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qr7brhwAACPafriU9Ox4szImyMAmjvItbyznJ9mLe+sSF1TN/A/xT/En4b/10bnjQNvNcBAgsQKKx++dGwGpIzQw3szbYvxZ2pwiJOeeYKy52NaTs3UHRi92JR4M6To672V/5YKa/SA0kmmbO1KyucDANdI62ResY9X2BXPC/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=u0WXwYhY; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="u0WXwYhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787833936;
	bh=agJhLpE5CHkUfs7uAAwp3BtaT09Vi1FullFH2L5M9Dc=;
	h=From:Subject:Date:Message-ID;
	b=u0WXwYhYGdvIea7U1Rm0LaBcCKZUGVUDe8JZ8j2CQ6kT+Wbh2V53mgICAE8AElojD
	 a0lGFQ7XFxfRCGFB/kaEiZJuYgQZzi5oGDBpegz4j8NPDalpkR+QXEccR6ndIixAUv
	 83lO1IjPXyyrGXbYK7RiywtglDLk7P8vOkTPCY0k=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.32) with ESMTP
	id 6A902E4500003855; Thu, 27 Aug 2026 20:32:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9179554456780
X-SMAIL-UIID: 48D082B2065245AE981D4AE5203837A0-20260827-203211-1
From: Hillf Danton <hdanton@sina.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	boqun@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Date: Thu, 27 Aug 2026 20:31:53 +0800
Message-ID: <20260827123155.1835-1-hdanton@sina.com>
In-Reply-To: <ao5BNjnM_pwcdk9X@shinhome>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 26 Aug 2026 11:23:37 +0900 Shin'ichiro Kawasaki wrote:
>On Aug 25, 2026 / 16:27, Eric Dumazet wrote:
>> On Tue, Aug 25, 2026 at 3:53 PM Eric Dumazet <edumazet@google.com> wrote:
>> > I think you missed one problem in lib/once.c
>> >
>> > Revert commit e8eef69a99f1 (or restore once_disable_jump(once_key,
>> > mod) inside __do_once_sleepable_done())
>> > so static_branch_disable() is never called synchronously under caller locks.
>> >
>> > Previously, once_disable_jump() deferred static_branch_disable() to a
>> > worker thread via schedule_work().
>> >
>> > Commit e8eef69a99f1 made it run synchronously in the caller's context.
>> > Because __inet_hash_connect() is called under lock_sock(sk), calling
>> > static_branch_disable() directly inside DO_ONCE_SLEEPABLE() takes
>> > cpus_read_lock() (cpu_hotplug_lock) while holding lock_sock(sk).
>> >
>> > This created the bogus lock dependency sk_lock -> cpu_hotplug_lock.
>> >
>> > Every other storage/networking client (sunrpc, nbd, cifs, iscsi_tcp,
>> > rxe, siw) uses static lockdep keys (static struct lock_class_key
>> > ...[2]) without issue.
>> 
>> I  sent the revert request for review :
>> https://lore.kernel.org/lkml/20260825142515.1965654-1-edumazet@google.com/T/#u
>
> Thank you for the clarification. Now I have better understanding.
> 
> When I looked at the lock dependency chain among six locks below, I assumed
> that any of the dependencies could not be cut.
> 
>    set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_counter -> elevator_lock -> set->srcu
> 
> So I thought that the idea to introduce the dynamic lockdep key for nvme-tcp
> sk_lock instances would be the only one solution. But you pointed out that the
> dependency sk_lock -> cpu_hotplug_lock can be cut by reverting the commit
> e8eef69a99f1.
> 
> I did trial and confirmed that your suggestion works. With the kerenl v7.2 +
> revert 19bdb70c77d3 + revert e8eef69a99f1, I confirmed the blktests test case
> nvme/005 passed with tcp transport. The lockdep WARN due to the six locks goes
> away. Great :)
>
Reverting e8eef69a99f1 alone failed to survive the syzbot test [15].
Nor did Eric's change [16] to lockdep alone [17].
Nor did Eric's change [16] to lockdep after Reverting e8eef69a99f1 [18].

[15] Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_link_sibling (2)
https://lore.kernel.org/lkml/6a90125e.1d9ded08.62e62.00d0.GAE@google.com/

[16] Subject: [PATCH] locking/lockdep: Invalidate stale class_cache entries for zapped classes
https://lore.kernel.org/lkml/20260824155129.676096-1-edumazet@google.com/

[17] Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
https://lore.kernel.org/lkml/6a8fa86e.27659fcc.2ceef7.000c.GAE@google.com/

[18] Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_link_sibling (2)
https://lore.kernel.org/lkml/6a8fd74f.4d659fcc.734b4.000c.GAE@google.com/

WTF root cause is Eric attempting to fix?
