Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14646EC6A
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788109; cv=none; b=TonX97AJTTgN6nS3ltN5dMsqc1IL1a7RI6WAxmgJB+XpuQb0w8OK1UxaGxcQMZPg/6feVimbd++BdObVrQE8qQIMck3bAtJossB7DW5xG8KePVC4k+B7kFINNuZs37iWORSy5U6uDxbZaAgBeFKbFUz83/QSRkjpX2cpOsbaX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788109; c=relaxed/simple;
	bh=wAtWM/hfeS3jpiaKFdtxYS7UyB1KGr86tNchBo63Iu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCtgB1cwSt7GBrEb0bsZQej53Xt5/LR1rwUw0v+6BDeoMYEan2lTdU8dzjhokjH1Xhl9f55rZjWwbl8JVMxbZGmZSzSLWjjK5QjHc8g88T9XC9UvyvLx4UC23GUT+6yN2A9IJx0KjEvcW1DX1iVf3+kE9SE3OjW9ISD+CM1U/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL3rBv0Q; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL3rBv0Q"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b6036e9c70so2689338e87.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788788105; x=1789392905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1utksJgoKAcBBVDcs57ghN3fD6lkAp5ozwsC08r8c1c=;
        b=iL3rBv0Qd7RUUFWl0H3x5Z9Hc9bZbVeEZ2UoqD+TTbqgMi5q/BKHU6u4o6d/vbXaeM
         EUscj7Mi2V4LmaHmapbRkNNCyMUskuELPCtU0KqpGjva+KaxcUEAAenPHwzFrzNFROUV
         tl0bV9qR5FyvwnlZ5kx8x3V0pOYIeFj0HjJ9xh40PyJTviVJpfkXPNnkS9o9ngPlSo5k
         o1FTmpVIDMDeSmlN8RxFOxiurgFNSFsjtDQYm/i/vjrrm4y1ZQBhRW+Pq1ElJKv+384n
         76xz8aBpz9g6lL0RNVq+Q4DNCuCiP9gxa3PGnkzBwUZkSK19XUT1lNCSCJX8nkB32Yvf
         BDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788105; x=1789392905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1utksJgoKAcBBVDcs57ghN3fD6lkAp5ozwsC08r8c1c=;
        b=CJVWBFe4ibxx3smn/+vh2k3sJ96pvQLET9uByCW83Q7OHtCozoNPeTrUQiZVvEl6ma
         W8lkCF/ph9yxDVU7Tq8e656O1aZPeyNac7HvxMSRPD92NoxLNlohcXfNbDTErUhpQ5/T
         vB8BtvJLB32DIrMbZqbNiRQfcYYvadSnMKbYrlanVXYx063sQf7pIs0HAPZJR3uE3jBE
         N96G/+X1yVn0H9B7YQji/JeDt8GEFkBYC7/Wq7bspUkbmg5Db9/zkXwXDt8lODqBiwqM
         oUSmQx/XzcLq4gYxEj7in34PzFC5+0zckT2VX5BNvZ3TnHaw314lGTEpbNkCXbjhEiag
         DaVA==
X-Forwarded-Encrypted: i=1; AKwUvByf+LcuxcL1ODp3/ueHnlxcfdq7bNx8xkKkiWOnRw/C3qt20sUS0bKc8sXX41yFjuhKoq6IqII=@vger.kernel.org
X-Gm-Message-State: AFuF++mrTUqOtr9unWUai/+2PhqKUdzUJAbzoMAZM0zOpxH7d8IPxghO
	m6EWEKVVS3K7MJKpifUNk9WGmdBYcjnRQ7PLsI1J4Ff/7GqDtsoXMAAo
X-Gm-Gg: AYBFou0d4T9ullptr4ENgRtSLuNS27ZUq8tv98t8E6Gg8WFJYh9M3dkVCPZK+jF9FVA
	Pmz5jy87xIHl/r+dzEDL1kw4v4FKrShfM3RSz2S/Vfg02kkm0sMYk/roC/3LguZBX4gWPyZNW4t
	NRy3F61mlXznXd5fCcZXhfllDdJF6e9UbsDne8NirBbdm/8xKJlSHSN5O6zpk8wWYI5H1JTAAMx
	yzc8YdXe0Vb400pvT5VinAiQkuSPgvhC+MIWcYPEbm3JVTffqbi3VYhtTTHOSzG57I8LFxciwrt
	24f4bspRqHMwINlDfs9bx7lhyNQgv5XcFdrTaKaTXhRYZR6Z/bqia/HBsYpeDUtlUKN+Vk0VZm6
	L9iudSgetSvfCPaP77magtwxpuVKm0RTmP9rxTUXkRpKAmf2u2Lk/9bUay9t2d1Z8HGmRYcWWym
	77eGKCyW4DE0/IRfqQWGIb9x0Zif00P3KrA5AZCkzfUccT7CKVKpxBPgfkCIoQIcPFA2RUe0W48
	pC8mbX2C4wH1BivBngruZrl9tyPuRIwaSxAsA7Rpuh9cRrkWbq3Vg7+aao=
X-Received: by 2002:a05:6512:3ca7:b0:5b6:1a7c:37 with SMTP id 2adb3069b0e04-5b61a7c0261mr3283856e87.58.1788788105369;
        Mon, 07 Sep 2026 06:35:05 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166fe10asm2328484e87.47.2026.09.07.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:35:04 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 7/9] sit: dynamically allocate struct ip_tunnel_parm_kern
Date: Mon,  7 Sep 2026 16:34:52 +0300
Message-ID: <20260907133452.5266-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907075846.2913645-8-edumazet@google.com>
References: <20260907075846.2913645-1-edumazet@google.com> <20260907075846.2913645-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 07:58:44AM +0000, Eric Dumazet wrote:
>  	ipip6_tunnel_unlink(sitn, t);
>  	synchronize_net();
> -	t->parms.iph.saddr = p->iph.saddr;
> -	t->parms.iph.daddr = p->iph.daddr;
> +	t->sit_parms = new_p;
[...]
> +	kfree(old_p);

At this point in the series old_p is freed with no grace period: the
synchronize_net() runs before the pointer switch and only covers the
hash readers. ipip6_tunnel_xmit() doesn't go through the hash and
keeps tiph = &tunnel->sit_parms->iph across the route lookup, and
ipip6_get_iflink() is reached from iflink_show() with no lock at all.
8/9 turns this into kfree_rcu(), so the end result is fine, but this
commit on its own is a UAF and breaks bisection. Moving the rcu_head
and kfree_rcu() here (or squashing 7 and 8) would keep each step safe.

Smaller thing of the same kind in 5/9: check_6rd() gets
rcu_dereference() but the rcu_read_lock() around the xmit path only
arrives in 8/9.

Artem
