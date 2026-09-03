Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EA4F30D7
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470025; cv=none; b=fIgZuNcEOWDrm9UOu83Y0p25llxRmtY+n1dmLuXr+DQpschMjd4UBcUBnBaSViq4nwSb0UO+jY50lAiDMhIhTj3A/HZEi5A2fhX45udiDgEjXluameL7pKertHaLM+SgWtN85RuaZvp/IS6FvZU7M39XeLS1IQPfBsZ/eyeSg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470025; c=relaxed/simple;
	bh=b0/HSCJZuEl0PGtn9azoPzkS0dWwxnYHqdvEixO/txA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jam1b5bQwB1ZSm5pooMJiYfprN2oEZ3n6qOf9JwNQGpiJC8T88VK0kdb/Kke2K7jCazUUhrMRoKyH/UAk2daphgfWBvxTEtD7Q9PKrMJh0sM4N0oPajCvXJuqhX8RJ6It2CnYa1Fro7CAGNeTnxC828ChLkTtitkAWjRMM33x8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwXtRlJz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwXtRlJz"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso273600a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 14:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788470020; x=1789074820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEtsy+Nj496tWyceVNXPO2QTuND+7hvS8GahA09Q5S0=;
        b=rwXtRlJzrk7DrNzUN5tfH/9eOKUU1xx62/i3MLPpqSYw7ddJEm3HxcJb1EavrwGVtq
         cmeh1Dl4QDUjVrOSr+KWDlrZyC+bdWdOEwZ3gb8230eQ6RJJi9PCJM3r4P+4iZ9B/BN+
         ypl2iWV0FO4OEs+a45o++xhF+aEhDo6b4KTSRoUyaXPkrEoG1vBQrtyJ90wnQ36Mgq4S
         tGi+9mGaMumXklppqfUIDCQP3/6PMAz1JFYh1s/Zc0SwHdnQGqcXf26UFDwXWEb69uTt
         wjCoty/hSl6CHvi1bM9l65nBtTak3aY6bs1XSJM6ICcfR59a/EpfGgsgy0UbYBRl+/eT
         O96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788470020; x=1789074820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mEtsy+Nj496tWyceVNXPO2QTuND+7hvS8GahA09Q5S0=;
        b=Ga2LiihdaLlaogMaMTp6ruXVG2Gu025WZZCm27ucXGn6xCISIggedS31899r1wSxvp
         Xnpe+y9FXupYqpG70c924gixq8qRBGNIpAQxU9Jodn0lFt4n/GToxRvO/31rlTYj8f+8
         zWZMF5fP8mzcl1mpcGurs/yXEybiEVYlQG4eXAqGmxGXbwHAYtOdT6EM2jVFghBPrsdB
         17RmPp+WgL2zaOqdBCWhVtBJ79RQg31vvKbBhwRGtTYtZkt0zVWhVtSzfeGlgAdsgshZ
         x8hMMA4I3lhTa1TaaKqv7sarcchWuhdhDutIINWcH7CwayRvgIIEtGKVxcn3noGRL0xb
         Vq1w==
X-Gm-Message-State: AFuF++kspyxwsdrcr4cBo9pGIZoXPnq3rFJ6hH0hstM02Rc6ZciFsG42
	7FvtWaYh80ZaUt7oqx+CGjso7r/zz18rCq7T4gsUKUivInRBIUn5buE=
X-Gm-Gg: AYBFou2SL6va6ohqtC/YnMMsq8aMIYn4WKpqItpBr55cK71q+AqzKQActXwzpbbJkum
	ASJqJoS9snQFZWPlVhFdnYI5RrII33Bjs4ksCFfhM33oDQcdQhLY99E74iLe+o931Oc+d6hWoxP
	vFOEk1eQnIEQm08XM6dMM+gkRHBd7LGVvgAw0ep5/7wiW8IsILzUrJrRbT+Tt1wy580b9DHo+6n
	YHL/yGxbZl3JMPEg/wa2IHYcIQ/Ll2BUGtpmlK5jAaXaDKHPir2DpRotyaud/28kpoRZRPEFyLu
	Qp5OIqag1AfmN+QR1dQjYV04D6Lj69+xSBcTBwWEKURrfVk5gvR5qrRH7/IN96fRMFYU8qLRqE3
	NgKJCmfiGn4KiYy5Xh28OU95eolNYEDdt19kie5AnbYZYS/fS1rSyrkjVFD/ZAA4wXOCVe2kHkH
	crUeFZQ3DD6RIe4sjl8iiCiJ3o78y7jY9acHpCEo0MUL0TwLT6ht7D5i+rfg/6cg==
X-Received: by 2002:a05:6402:11ce:b0:6a6:32f9:d7cf with SMTP id 4fb4d7f45d1cf-6a7e90bd161mr434390a12.20.1788470019849;
        Thu, 03 Sep 2026 14:13:39 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6a1dsm255242a12.7.2026.09.03.14.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:13:39 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Wei Wang <weiwan@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: yield the CPU on every exit of the threaded NAPI poll loop
Date: Fri,  4 Sep 2026 00:12:53 +0100
Message-ID: <20260903231253.292576-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902154836.19a497e5@kernel.org>
References: <20260902154836.19a497e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Rebase your OOT patches on latest and test the tree you're targeting
> or keep this patch in your downstream kernel as well.

I could not produce a repro on the target tree, and the reason turns out
to matter more than my board being out of tree.

Since v7.0 the non-preempting models are gated:

  kernel/Kconfig.preempt
    config PREEMPT_NONE       depends on ARCH_NO_PREEMPT
    config PREEMPT_VOLUNTARY  depends on !ARCH_HAS_PREEMPT_LAZY

  kernel/sched/core.c, sched_dynamic_mode()
    "none" and "voluntary" are compiled out under
    !(PREEMPT_RT || ARCH_HAS_PREEMPT_LAZY)

ARCH_NO_PREEMPT is selected by m68k, hexagon and alpha only, and
ARCH_HAS_PREEMPT_LAZY by x86, arm64, powerpc, s390, riscv and loongarch.
So on those six there is no way to build a kernel, or boot one, in which
cond_resched() is anything but a nop. I checked it on an x86 guest built
from net/main: the set offered by /sys/kernel/debug/sched/preempt is
"full (lazy)", and none and voluntary are not in it.

This patch therefore does nothing on those six, and I should have said
that in v2 instead of describing PREEMPT_NONE and PREEMPT_VOLUNTARY as
what is left. What is left is PREEMPT_VOLUNTARY on arc, arm, csky,
microblaze, mips, nios2, openrisc, parisc, sh, sparc and xtensa,
PREEMPT_NONE on the three above, and 6.18 and earlier everywhere, which
is what the affected devices run and where the Fixes tag applies.

Since every number in v2 came from PREEMPT_NONE, which those
architectures can no longer select, I measured VOLUNTARY as well. Same
board, 6.18 where it is still selectable, untainted, no out-of-tree
module, 30 minute runs, the two halves differing only in this patch:

                          before        after
  mean                    13.38 s       0.19 s
  worst                  135.95 s       0.51 s
  over 1 s              10 of 55      0 of 89
  RCU stalls, classic          12            0
  RCU stalls, expedited        20            0
  packet rate           80312 p/s    81532 p/s

add, mtu and a no-op netlink call stayed at 0.01-0.41 s throughout both
halves, so the delay is the grace period and not rtnl or scheduling. The
splat names the model itself:

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu:  0-....: (5999 ticks this GP) ... (t=6001 jiffies g=861 q=830)
  CPU: 0 PID: 200 Comm: napi/qdma_eth-0 Not tainted 6.18.44 #0 VOLUNTARY

For completeness, I did try to reproduce it on net/main in a VM, with
threaded NAPI on a veth pair and the ARCH_HAS_PREEMPT_LAZY select
dropped from arch/x86/Kconfig so that voluntary preemption was
reachable at all. The worst "ip link del" went to 0.19 s against 0.01 s
at rest, but never to a stall: below the band the thread sleeps between
batches, above it repoll stays set and the existing cond_resched() runs.
I could not hold it in between, so I am not offering that as a
reproduction.

So this fixes the architectures that still have a non-preempting model,
and the stable kernels, but not the tree it is posted against. If that
makes it not worth carrying in net, say so and I will keep it
downstream. If it is worth carrying, I will send a v3 with the numbers
above in the commit message.
