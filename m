Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEC47011C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190339; cv=none; b=esgd3m46UiD5lKmxUFdG32GNb9qljau7zI8o2BJLrJnPFWEJpmsJ7fivAE59k1WujOK3JivlNvlzC7fnnXbZBG2dRkrhZWOxi5m/eX7svh2LOuucjvBAFhCiEeJnDtJ94C4dnluUyyEJY7WhSAfvSTw+pOEZEJlUYyRCjPq/8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190339; c=relaxed/simple;
	bh=iL708iutZzG4sxHhMOIapG/EQSh/zR+kX9wEAG+cnTM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mIvaAJhbZRsmjWV1VavgXXqyQ52KvIxFmFg1Zy4dIwXV20kUCHK7/8bnKShJ4stWKIISu6oeqrp7/H9lSQ5NbFtWUrsFqW3Fv/vYIBlwfTwnIt578y3TVN35vd6RKUmpJyQN9q8yiCPjjML8fDY85FrzT9a4HBXhC5hu9eXt7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0n6KEQy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0n6KEQy"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8588583a7c3so44706867b3.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788190337; x=1788795137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BwtVhvcFmoiTsSegBgPx3Rjv6sHyggIjk52ZY0i+baQ=;
        b=l0n6KEQyebbzcoAcQLBtwTMsZKxzZGPet7VKqV/a8nzbSmnjOGxzQ3euJut/JAbNMp
         065KC8fItgZVFdcJKvcxAgA8ISsesXMy31PJvn4MJmFGNCw7DRX+pyth385/chvNaRFA
         /RPWdejCkZ3Dm8KerfE2XaWglgVqVSlfQ28EqMSQLCjWbRORG4L7canbYjQibDDsznMo
         +LTr+eR8qSpnpFk6cfFxUM1OM5xXIn6fPvNjZcoUvyLKXzfa9iottR42JRcg+nM7NJF4
         nWhAws3PMzHsqq5S2PHHMrhBc6E2wOoghze3GWrNk/rSTqx/FoJIt/pmUQus3IRa86+r
         KFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788190337; x=1788795137;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BwtVhvcFmoiTsSegBgPx3Rjv6sHyggIjk52ZY0i+baQ=;
        b=DkJjCa4FrrbTyfKjtOvHjd4Tz9kuAAAPzIMTT2U/vf54d/nJcD+EQPC5qVKOh08AMf
         8/0IqTfeMrMYv2imoO7UROI9mSBTI5PwxN5wHeyABasItDJDDTGBzmoKH02iQnOAhaup
         vjF45+vOYERhVvXfVfEt4GDuesBV7vHy4VLnfytMkbszJjFhpJChhqrukJYNHmad/vpt
         TPYAaYY5Nl09QggLGMSnPMaClGvgJ0oA2Bwswwhr4ToNJqUrsgEGIhBpCDVLvVdat/dJ
         osgC1RaCxoRqUND64hf5JqTWnxc8G6nFbu3W6nOGmW2DOlPXqR4i1HzwjzNE8KitgamJ
         a4eA==
X-Forwarded-Encrypted: i=1; AKwUvBwhlq5hlUwuuFJx6lMA/AEBiWdTQnlPNZLxu3mSNAKeWXiVyAJGXwHFIYcGzZH/taXnIFfJ/Ik=@vger.kernel.org
X-Gm-Message-State: AFuF++mE0p/6yD6tjgct2Y1fZiqcisGWHhPXcOcDn0WNALXsiVPXbO4m
	fsJK1nWr5b0UqhP6ram7CUUmmRFh9v5ucvOTF2nZdiDBjWqwJhqG2A7A
X-Gm-Gg: AYBFou0+GSS18ZkHoYXV9vYxxbXnR/ixvlxXwE3alf8U8dVX0kSR/XXw2th2EuPUe3m
	iq7YI9IfxJDqv32isg8R/fZXCyHsdMC6vTqjERqF3xKcl0VMDZuCIQtLfWfTkPyB6ldXUUZFZgK
	c8EFb7lSQVV2BCwYSxl6YYeV9bxyISNAzauo5zxTDOxe8pgXrkjA9vDqBu6XEigQuXe3vksi5F5
	KqO7A3IjqE2B/mTa2fRSwAnxVpLfYLNPiwT9a87jiqW81Mh6kDazeWhYiHbRoAI6ki6HNDT5TM/
	JmeLQe6Nfl2gpQUPwVa7joZsbmKGhpWCUJy15ZFojsxssDp2JDGTX7BC1emfV7abcJBM3YHgl8r
	xaJe/pd610pYGmWGBlGGjI4dJHpod5TwhMUSckXXbm3qu6gvlKfsBqFYgWfjEUlQeMnxZyC1eJU
	s7RMhQ0YXJ+rdlj7dTy+tVrmvLv41ADBf/4JNegOy8R/M5Y0PnBubjETMOHu6rcceytHgweLZcG
	q0zZw1KbY6aTW7QAjnnxR6t7sKfvsKdXoxit9F41w==
X-Received: by 2002:a05:690c:309:b0:864:a8f4:faf0 with SMTP id 00721157ae682-864a8f521femr40827247b3.10.1788190336805;
        Mon, 31 Aug 2026 08:32:16 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5f5f04e4sm54465287b3.21.2026.08.31.08.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:32:15 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:32:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Johann Baudy <johann.baudy@gnu-log.net>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org, 
 syzbot+73df3f89e1e13089e466@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.d2d2557ce1cb@gmail.com>
In-Reply-To: <20260830180915.260225-1-kuniyu@google.com>
References: <20260830180915.260225-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net] af_packet: Don't cast tpacket_hdr.tp_len to int in
 tpacket_parse_header().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> syzbot reported BUG() in sock_sendmsg_nosec(). [0]
> 
> The problem is that tpacket_parse_header() casts user-provided
> tpacket_hdr.tp_len, which is u32, to int.
> 
> If the length is larger than INT_MAX, the following condition
> in tpacket_parse_header() passes,
> 
>   if (unlikely(tp_len > size_max))
> 
> and any negative value can be returned to the caller, up to
> sock_sendmsg_nosec().
> 
> The repro set tpacket_hdr.tp_len to 0xfffffdef, which is cast
> to -EIOCBQUEUED (-529), triggering BUG() in sock_sendmsg_nosec().
> 
>   *(uint64_t*)0x200000000008 = 0xfffffdef;
>   ...
>   syscall(__NR_write, /*fd=*/r[0], /*buf=*/0x200000000000ul, /*count=*/1ul);
> 
> Let's define the local tp_len as u32 in tpacket_parse_header().
> 
> [0]:
> kernel BUG at net/socket.c:803!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 5628 Comm: syz-executor176 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:sock_sendmsg_nosec+0x145/0x180 net/socket.c:803
> Code: 06 67 48 0f b9 3a eb 95 e8 e8 3a 22 f8 48 89 df 4c 89 f6 4c 89 e2 4d 89 fb 2e e8 32 a5 5c 16 e9 51 ff ff ff e8 cc 3a 22 f8 90 <0f> 0b e8 c4 3a 22 f8 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 28
> RSP: 0018:ffffc90003aefb48 EFLAGS: 00010293
> RAX: ffffffff89a578d4 RBX: ffff8880764c67c0 RCX: ffff88807fb23e80
> RDX: 0000000000000000 RSI: 00000000fffffdef RDI: 00000000fffffdef
> RBP: 00000000fffffdef R08: ffffc90003aef747 R09: 1ffff9200075dee8
> R10: dffffc0000000000 R11: fffff5200075dee9 R12: 0000000000000001
> R13: dffffc0000000000 R14: ffffc90003aefbc0 R15: ffffffff8aac4310
> FS:  000055559101b400(0000) GS:ffff888124ce0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000210 CR3: 0000000073dca000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __sock_sendmsg net/socket.c:815 [inline]
>  sock_write_iter+0x2de/0x3e0 net/socket.c:1266
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x612/0xba0 fs/read_write.c:687
>  ksys_write+0x150/0x270 fs/read_write.c:739
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f173130ecb9
> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd67e44248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007f173130ecb9
> RDX: 0000000000000001 RSI: 0000200000000000 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd67e44388
> R13: 0000000000000002 R14: 00002000000000c0 R15: 0000000000000002
>  </TASK>
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Reported-by: syzbot+73df3f89e1e13089e466@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a946ffa.1d9ded08.62e62.0123.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
