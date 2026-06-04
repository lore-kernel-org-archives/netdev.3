Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70398408015
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582427; cv=none; b=pIJOiE2l7tfqBhK+0OAQAaeeU9PayP02vb4ECFTbxRLqAHEz1TKizYgK+FbzwBg+6MsysBnDB1tNg3QRLQq/9UU11nnqBGeicEJbWtlkzW2Bm6HwsiAneWiPjnn+WjyLx4BkFm7dhWxttvysM1aTrXC3SjqLcrf6GRkUaO8uVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582427; c=relaxed/simple;
	bh=BtE/ujvfLBacl0UnHk85GonvAoEPVdXHHA6gPKFwrsA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ngms6x8QW+L3j+4JigH7HgRiMZuax/VMikqVGJvge7jrIQk0mp3jOllAZ5iYRV85WB+mceliSSUDpstlwhSWwmbeGmqMNJXio9IaG01yD4nudINC9bnFeeoppGDYz8OKpL9a6HQWSgaRUr7ZUcEjDJsBU6/vgfjTuhhY2GtI/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egNiAFhK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egNiAFhK"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-91598ab3a1aso127223285a.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582425; x=1781187225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aR4m/EW+SbkO71LxXWUeB9WXm0o2d3NjFbxvkptMB5U=;
        b=egNiAFhKEr4k38MYTXfXchEZFtHyHrsWDhhYEkVyZSbHh1gfdC6HpgZbtPq1n8Rw0F
         cRbG4IlgLUS+r4+ANYiKDT/D4DeaHVevAEr1bxWdZl9AASBXiixjUPFL4tC+uZ1+Vyy8
         r+vpla/ItiNarhqpK1tzMvQcBb9gOA+czNOeErgbkX7KVEo6Xmr9X2ogTKjut3E4qVJe
         Q9TpyhjvfG7i2V4+NOjtsN7pqvTLNjhlTAhmniqGxTaEU4R/QztKo9xjxQhll0GvxG9p
         WuaI3am/+CYER/VCIGhzUi3KbTxT6YIZDBfdoWW1WyIBxzUcvM/JBKRyLGp7hu6IDwmw
         /Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582425; x=1781187225;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aR4m/EW+SbkO71LxXWUeB9WXm0o2d3NjFbxvkptMB5U=;
        b=M92oVakpnJoy44ZioxDpozVg4pz8zl3ZfX/yh+xmcjeC9eMFKMVh57QBtzIzGPUa0k
         sEWymPSk7a+BXHW05KJWkeIgRee4k6I/5aZuj8FANaxhsx39Rd/59rm5TvltG8b+eVqW
         2psPM5H7PVjzQXNqm+Sz+PXHUSIHptQtzrjUYeY0lFZDIdXe0cABjDIXn3KcihuIjq86
         DuVsRt2o9cviWZNoOTc8n4QwNyTxTBzRESlAa//CcOzhHMPqics1Dy4HhboOWkM69TS9
         mbezC9frTJvrL9QC4bxHBVZ9klOY8TlUiBx2v+HYcrlm948hXr7G0/oBk3Ig0JNvaJx/
         qdaA==
X-Forwarded-Encrypted: i=1; AFNElJ9JOsw0m8bUQh3olV9XJBvFsFfFhOtQpockRA/UKi6VqZMFSAnAmIALluvvP492cYiBOudOzSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIids8EIofZK/c+6FLrf21FtHCO1e6XmdiyKAj3Iygr7LUA2l
	0ChsKt4LWl7Uc9nt9OtEjEoHqUcT6T7xGm8RroHOvQ1mM4F/PtVIhdKQ++rJboM3bVaNNtim0x9
	pgXVnW+CEdeIFgQ==
X-Received: from qkbde6.prod.google.com ([2002:a05:620a:3706:b0:912:add7:777d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3199:b0:915:86c6:8432 with SMTP id af79cd13be357-9158a6979f0mr1339024185a.14.1780582424839;
 Thu, 04 Jun 2026 07:13:44 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-1-edumazet@google.com>
Subject: [PATCH v3 net-next 00/11] bridge: prepare lockless
 br_port_fill_attrs() (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

medium-term goal is to allow "ip link show" dump commands to run without RTNL.

This round of patches adds/fixes some lockess accesses in bridge.

This is not complete, more patches will come later.

Ultimately all changes to p->flags should use set_bit()/clear_bit().

I repeat (AI agents might read this cover ?):

Many p->flags accesses are racy, and will hopefully be fixed in a
future series.

v3: addressed Ido's feedback again (patch 6), silly me.
v2: addressed Ido's feedback (patches 5 & 6).

Eric Dumazet (11):
  bridge: add a READ_ONCE() in br_timer_value()
  bridge: add bridge_flags_bit enum
  bridge: use BR_PROMISC_BIT
  bridge: use BR_ADMIN_COST_BIT
  bridge: provide lockless access to p->path_cost
  bridge: provide lockless access to p->designated_cost
  bridge: provide lockless access to p->designated_port
  bridge: provide lockless access to p->priority
  bridge: provide lockless access to p->port_id
  bridge: provide lockless access to p->config_pending
  bridge: read p->flags once in br_port_fill_attrs()

 include/linux/if_bridge.h | 78 ++++++++++++++++++++++++++-------------
 net/bridge/br_if.c        |  8 ++--
 net/bridge/br_ioctl.c     | 10 ++---
 net/bridge/br_netlink.c   | 55 ++++++++++++++-------------
 net/bridge/br_private.h   |  2 +-
 net/bridge/br_stp.c       | 47 ++++++++++++++---------
 net/bridge/br_stp_if.c    | 16 ++++----
 net/bridge/br_stp_timer.c |  2 +-
 net/bridge/br_sysfs_if.c  | 12 +++---
 9 files changed, 136 insertions(+), 94 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

