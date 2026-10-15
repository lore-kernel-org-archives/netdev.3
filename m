Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E154D09EC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060373; cv=none; b=uW4jSAT6MICjQqS1NVqmvW/J9afASXvNSLX9glIiw9TAXnRy890Lz2CFe8wixSmoRMRGegL0E6+GB4AJhDmAGiNkyk7nRrDwtwaW+iBhDy4bV29evSPEbX9vLT7YDHYfVbhcvLiNYUuH7kYk5Y/1CxvogRU8LudFEfL50Heqnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060373; c=relaxed/simple;
	bh=eMV266QkYY8RlZ8C+nBcH3jrH0fic53m4ZGDmaazAgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PK8oFAv/JQLblJbaL2Q9ZfRc6r5XnXmyxCjkUj63xPMThx7Z5QEDJC+rYW1avUcpQf7iBR9x30YZzTaZMDluLo+jf5JtFkGVtNv6Umcpf1HcgoxH+vq5So2x00NRXbHZeuB3KN4B4Py9f906aotVPhf407hdbtNWWPA9UUK5Qj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=QTI4Ptc2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="QTI4Ptc2"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e76469b93so90228885a.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792060370; x=1792665170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbWQ31kC+1e1O6dmGLccpcVqgjxaFazqw0r7gj5HHA4=;
        b=QTI4Ptc2hjGoBrlA2PYQ+orM3cLeuH3gRmRTO+mJX4tLTu+kB9n9DDOM4QneojEF6P
         R7mSuV8RGi0U0QeRSWvhYeiRDLd+WeXFkWnP3HcvswXFeFjBsLj5BiedKeqkOPZMzYgu
         r+oHVqxJwAuEIBl6IFvrN0plrP8wkvmnai7ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792060370; x=1792665170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbWQ31kC+1e1O6dmGLccpcVqgjxaFazqw0r7gj5HHA4=;
        b=H5QII0HRbaxOjZaWEI4nBWzzjoMO88Tda+bnRjzM5JaaR+3H/sRlBh/a4S594k/XEv
         qKrqVWMxA6ODa0hHprjCPoOHRqBjblXX4GPhyvsXUz/5ERYXEN+9fnHsODAwMmOajinG
         KEuY53+VbzG0vmQKK2JiOERArp+RMFvTuAc+W45z7z3xmjuU0Dr7TxaGnrkpBt9frkq0
         T4BX0T3Q+CBBk3k2BhsArrz6v6FtJvecz45EoP1N+HhOffOI7uSTzzZbOnh30vrNuPDt
         MEV33JDW85xlj0V7x+ZTJdLzmCaHeHmx0KD6cT26ATlGYyQlzM4xkU7NgxOZlUjuse9s
         IxKg==
X-Gm-Message-State: AFq9FYL+KFmc/RrLRR5XOUEl0O9W+nEwZU2lF2foYnU2LC4cUdx/5sde
	oNXFLMcCymVBKw3tjys7V/ddGLyypCI80qlY9oCXp3AfYAucW2mL3fpZnzz2GSZFht8WdvleVm1
	ecRM=
X-Gm-Gg: AYBFou2z63mTUaMpv17iaAJvlOMCdkdZGQahUHpmk/Wm/pVXo+nfSapUctlXBw/yNjG
	RJtYb33R9NKGorOiPQQd2n2R0pqiMMMbO7JWymLTvp5a7Sgi/JJgU0enlZhYkQYhc/BeiJBZ/FE
	hvzx6TkuG1Cw7Wbz0EvbXRObG6xUBYIxIJgb9bAF1CdUdDJ6OrJGesaCtW93YzJU8+0ltxkruIL
	YVDOB32uQCV8/B0kEddfnQtgOU19/O7qgFSrU7mg41l8VVJwXP7Hyy63OEMoeL2ZB3jCvk/uJ88
	qieiYW7PwNjQyvPtC9uzk2L5yUmR6vFSbC3d49fLikYVtvrp+Do3U4/JvgIUWfGM0aaFTLl5h71
	C2eS3Fwf6FBfG5niWsOp1MpTDeS9UC81O7uDiOe9E9WXYvxzq45JxrNceRmM3pIK8CdCqUSLZb+
	rP7P6XPYzlERDlzECk3DLTmC910d9mFNC6h0yWH8baujmaCvdBFgPfrDgJFSse13f5n+KMcCuN6
	WPXbEpmOtxr2bp8nsgplcLWkQe50R4AxtEWnxo4kMZW
X-Received: by 2002:a05:620a:170d:b0:936:e18d:763d with SMTP id af79cd13be357-93ebd0df184mr3132629085a.8.1792060370178;
        Thu, 15 Oct 2026 03:32:50 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ba684f404sm55261936d6.31.2026.10.15.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:32:49 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v2 0/4] net/sched: sch_cake: fixes for accounting and reconfiguration
Date: Thu, 15 Oct 2026 06:32:41 -0400
Message-Id: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four independent fixes in the CAKE qdisc.  Three are follow-ups to the
autorate reconfiguration work around commit 7cbfb180945c ("net/sched:
sch_cake: fix autorate reconfiguration throttling") and the 32-bit
admission-counter wraps fixed in gred/bfifo/plug by commit 4c660ee8c809
("net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue");
the fourth is a dead-code cleanup found while auditing the dump path.

Patch 1 serializes a 'tc qdisc change' with the datapath's autorate
update under the qdisc lock, so the netlink writer and the autorate
writer can no longer lose the configured rate.  rate_bps needs no atomic
(it is only loaded and stored), so it stays a plain u64 with
READ_ONCE()/WRITE_ONCE() annotations.

Patch 2 propagates the backlog reduction of the reconfigure-time tin
purge to classful parents, so a CAKE leaf under HTB no longer leaves the
purged packets in the parent's qlen/backlog forever.

Patch 3 widens buffer_used and buffer_max_used to u64.  The u32
accumulator wraps once the resident truesize passes 2^32, bypassing the
over-limit drop loop while the configured limit is a u32 attribute; the
u32 MEMORY_USED export is clamped so widening the counter does not
truncate the reported value.

Patch 4 drops an unreachable 'nla_nest_end() < 0' error check: the
helper never returns a negative value.

All four are hardening for net-next (no Fixes:, no Cc: stable): the
counter wrap, the missing parent-backlog propagation and the
reconfiguration race all predate any contract we could anchor a
regression on.  Patches 1-2 were reported by Sashiko (gemini) and patch
3 comes from the gred 32-bit-wrap family; patch 4 is a static cleanup.

v1 -> v2:
 - Patch 1/4: drop atomic64_t; rate_bps stays a plain u64 with
   READ_ONCE()/WRITE_ONCE() annotations (per Toke's review: the accesses
   are plain loads/stores, so no atomic is needed).
 - Patch 2/4: no change; carries Toke's v1 Acked-by.
 - Patch 3/4: clamp the MEMORY_USED export to U32_MAX, so widening the
   counter does not truncate the u32 stat (Sashiko nipa Medium).
 - Patch 4/4: no change; carries Toke's v1 Acked-by.

Jamal Hadi Salim (4):
  net/sched: sch_cake: serialize reconfiguration with the datapath
  net/sched: sch_cake: reduce parent backlog when clearing a tin
  net/sched: sch_cake: widen buffer_used to u64
  net/sched: sch_cake: drop dead nla_nest_end() error check

 net/sched/sch_cake.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

-- 
2.43.0

