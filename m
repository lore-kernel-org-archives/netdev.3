Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292738;
	b=c4FwTJoHI/RiFMacD6/tQBbNWDJqIXTP1tm6tSi2P/+z0Q+w50sUS8JRd/AQeTqbQKZz
	 /6pC9neEux27KqLlkVC9gZj4lv5WbXZ9Ud5ntR++zC/snoJHrDsJdeRcz6jPoSXqLXnSE
	 8hNBWpBg3JRNBMbZKKeh4hU0UWZ78PJkjiDtHWch32ZDLcgPXidDXSJLx5c3ex8Sf+f1L
	 eBmFGD+JAuPml0uWqE0iRzGoVoldm0ewIIdQIUc2RNhu96wPchOA/ehMrxJmEykM10bkW
	 eRJwMudkHijMLZn70QEkSDFfWaC8e/XzFrrAIPwttLLMDhxWLFzPVCVevvYhFBeKoEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xGnzNpbW5HBJowHbelE8TIAH0CHLKv+3lpr5Rd0UybU=;
	b=x2kgVQdCJrHu9flVPXQKKxp5jY1rLp+FFodPBYfHnU74ZWn0M99miODsfjBQ9yMo2aFp
	 PXHV2YPrAevI+Ldz1wO2QjBxCqNH43rjsl8mhefhGgSvLnsXRC5EQJEREK+TwWbEcEc5l
	 LvGB7sLzMwHUWytYpgdBmr3ppN5Hh2C6jAM+afIMKSXnQFn2CpmPcg4DM5eX+lUvbgirN
	 iUmhpV6Ev01ut2Dg64PoWKl6w+GT6EmUABbkpXhV9IvMTdwB0vtui4JKqS/WnxazW1icj
	 fbkJuJaSfgk5eJBKp9v2ZREuJ62wS1+0UKujHthyprdi5AyG8TUPAXhQFprrub0JYrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lUjbyjdq;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0C606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A0C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lUjbyjdq
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so1854964a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 22:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794292737; x=1794897537; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGnzNpbW5HBJowHbelE8TIAH0CHLKv+3lpr5Rd0UybU=;
        b=lUjbyjdq0Cdy/5hmHfWdhJaKgFI7fDoSFMrmNdT1apdPUGgqHYEJPpK602EQgZubA8
         lI5KHZU8Baq2CSU7na/Plt9wQEnHzajJ1QzZlUEi34qjWkKzxqExnCpGW0YHA4AljIvg
         wX3ZtrFSbSGq46i6xgqbhdxIyzwP6i0o2Mw3d4DdZsOqIw57bS5eVSo2GbBKFCFgEcdK
         AlvrGGoqmqcR3R0LDxkFNvbnlEIpdT9im9A37TihAhOjc5WTrd65PRbnrZvdM8WZvVGB
         +aqz47nKcu3/P9gsdfAhMVxiY4EN1qK+NBbQF1ahO+m2wUwYjqZVDjvBR0ZGLTNAl49+
         mNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794292737; x=1794897537;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGnzNpbW5HBJowHbelE8TIAH0CHLKv+3lpr5Rd0UybU=;
        b=04FnEA1jXC03uJzrBPUwXB/mSRzDpvGnwK0RwkhWOLbd7S1jwvOKkx3j4NPlJWjNLj
         j+L/lWJ14T88e5oQrnxE0StPTGbr2Qi+yIpp83A8i/GKB7HobXA8JgleiUn2i4GikNRZ
         aUZ6QeVPF42AJOOce9qu9dEsMBpS0N8bq/ygyOUaJ1MEj+jR69w34Oox1KTmIuxyjjtH
         c7wOzqm8xBxA2voRaNbyippei6rxxEs5kn2mp64hzzsPmUKA+8EjGqmqveVOj9nM61jL
         51+hm/F7bg/VfqXYAbW3dxvWqkkWEEWm/Qj2HpJqN32J55kafRyB/sziupae/jErl7Lp
         Lm1Q==
X-Forwarded-Encrypted: i=1; AL+hErHi4fAnkA23lf9x/Ulkz4ob4t7oIeuidDMPUY1IiO2+Up8DKDwjw+W+qv9Ct4SVx4NChNDjTvQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zztCSoWlxF1GJUik2XEAnLiYldz7/v/eWSVibJyY3D/hI9wxy
	Yl+noED/joHGpyoHl0xpDc3UyKKRlUw3Tlb+OeH3IwDs02V7Mtb+PIrNGJHDMuUlQBL6GUtEbg+
	P4YhErw==
X-Received: from pjsd12.prod.google.com ([2002:a17:90a:bf8c:b0:3b0:994b:db90])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3889:b0:3ac:3e42:60a2
 with SMTP id 98e67ed59e1d1-3b166cebaa7mr2018376a91.33.1794292736895; Mon, 09
 Nov 2026 22:38:56 -0800 (PST)
Date: Tue, 10 Nov 2026 06:38:56 +0000
In-Reply-To: <20261106051905.218638-1-sidchintamaneni@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106051905.218638-1-sidchintamaneni@gmail.com>
Message-ID: <avK7nGo4aGxJ7QiU@google.com>
Subject: Re: [PATCH net 0/4] af_unix: Fix inq_len and scm_stat.nr_fds
 accounting leaks
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jann Horn <jannh@google.com>, Kirill Tkhai <tkhai@ya.ru>, 
	apais@microsoft.com, rlmenge@gmail.com, hargar@linux.microsoft.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 06 Nov 2026 05:19:01 +0000, Siddharth Chintamaneni wrote:
> This series fixes receive-queue accounting leaks of u->inq_len and
> u->scm_stat.nr_fds in AF_UNIX sockets, along with selftests:
> 
> - Patch 1 fixes a u->inq_len leak in manage_oob() when an unconsumed
>   out-of-band (MSG_OOB) skb is skipped and dropped during a normal read.
> - Patch 2 fixes u->scm_stat.nr_fds leaks when an OOB skb is skipped or
>   freed in manage_oob(), unix_stream_recv_urg(), and
>   unix_stream_read_skb().
> - Patch 3 fixes a u->scm_stat.nr_fds leak in unix_dgram_disconnected()
>   when purging queued skbs from sk->sk_receive_queue on disconnect.
> - Patch 4 adds SIOCINQ and scm_fds (/proc/self/fdinfo/<fd>) checks to
>   the msg_oob and scm_rights selftests.

I planed to drop MSG_OOB support in this cycle.

Could you repost without OOB changes ?


> 
> Siddharth Chintamaneni (4):
>   af_unix: Fix inq_len leak when skipping unread OOB skb.
>   af_unix: Fix scm_stat.nr_fds leaks for OOB skb.
>   af_unix: Fix scm_stat.nr_fds leak in unix_dgram_disconnected().
>   selftest: af_unix: Test SIOCINQ and scm_fds with OOB and dgram
>     disconnect.
> 
>  net/unix/af_unix.c                            |  69 ++++++-----
>  tools/testing/selftests/net/af_unix/msg_oob.c |  12 +-
>  .../selftests/net/af_unix/scm_rights.c        | 108 ++++++++++++++++++
>  3 files changed, 161 insertions(+), 28 deletions(-)
> 
> -- 
> 2.43.0
> 
