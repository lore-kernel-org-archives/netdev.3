Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218874;
	b=cFkbLDhl7PXDAnNUP+XyKoeGaJJpfzC3+o7bB19/wDYnY8uWNFRbhBctU6qCTg61GePi
	 rxoyna8dD1TQkM9KQw3GBBUgU6FbzJO1/orz3uKVF1DG1QpDMuRB3WX1cd5h3ZxMpa5SM
	 T1Yvl+F1WDyZARt+cw0YtJPqWVZyPASMMOprYuJfvRkADkQH3PkRuX1F5iuGSOXHAPBem
	 dfQl50rh88x+mbM9mGwegxMJYTeCnVZesYO/1poOX9ltom+oUhn5n5jHDbD9FqiGPn14J
	 mfmVFgB4t5aA9lBkdHBNrtYMPFcUr8o2hreOjQiP8dmVx9T0vbbX1PlfQgzprbgylEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References;
	bh=om8tdBMSIgCokEYF5704NEkqNK3MfST8p47zx4fkZms=;
	b=1aS1pdzhdVio0ehNM8LBVygX2RLfExZ6yd1z62mNGdRFg85hlXCzELm3JEMCcY39/3TU
	 7JyV5xS6mrF4Fm6KPZF/Q+hUWlRl8kGlL+zZ8qinSIgCQdA/zq21nv0exWrYx8PVGVmub
	 oobWT42HlvcgbhQFYxt5NM22K2f0ok7mk33+fbEmA2NMjMv5iwJ3YRd7pxMRd14QvPwTw
	 I8uHSW7rP9APm+JbA7ZykOCy2yN9kcGo1pxlugEwehItowkTV/Hhme9s2wSTU8z+lWG7E
	 drxft9pZLnd3sD0N+1pB+D/VIiVWV2lhlxtla5m44uA2WYYgTu4wux7Iy1/QszUa11A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpkoAJKz;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98C606A334
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 10:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC98C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpkoAJKz
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b147e06befso233899a91.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 02:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218873; x=1794823673; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=om8tdBMSIgCokEYF5704NEkqNK3MfST8p47zx4fkZms=;
        b=kpkoAJKzvFfzZWas09VUhTVQbKE6mMVHk7VYyT4No3RzCxcp4sVNimwy0AyQDM28sp
         cqmK/yGpv9hWnwAZDWLsHp0IFjVnX/ApP7MlXDPRoSQdd5kDpggGgE0GtVLFEbS0D5xk
         6LyczAtegNxWS6GMsk2+IsAyEfoHzZY5Kawsjx5kga3fWdLjLN3FPou51j1drws8/Uz3
         l0Ns6Lw+V0cj2HUBFV+in3YbBvTqnkLGfQ9Knij5eGFGM73H6Cqv2J9xSo8Mwy8nIZJ8
         fJe+Jh5nzQyuzUvZH7A9VSXOyVDCbA6iogszClRl8z5ecI2nJXeiNXhOW/zIoozOBU+o
         abOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218873; x=1794823673;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=om8tdBMSIgCokEYF5704NEkqNK3MfST8p47zx4fkZms=;
        b=zrPItER+Rd3/i5urfc3XH8KsZKGek3FO+hhhraw5iT5YCkaTeI58Atp6/1/kdY9jOi
         lJuq0DFgDSCGz3cuIWf/vxso3ZHfeMYYtCjJYLiRxmcZuRd8Hwmp69nlTGNR7hllU7Gf
         wkQjsZ9GERHyDJXcsNTc/XQodfgSGhTCVpTgJV9T3HYYHHjt3gawPJlWTX/kIuMIf7aB
         O/+lEMR09SsetsP9GgZydeseckOJfVjUXecJz4/vykXTqIynqlRs5VtwvRYdVOmN7K+n
         FxRlYAx32KIetWsPBW86QtevZPKHqek+W44/pLwbYSRuxtfjXhaFH40ERrLtEc4GDkSG
         BasQ==
X-Gm-Message-State: APuU4Z+R2q6pkh8EpJ80opb1F263uTn0xh5zOkuNUWkI8ZXxlS+rddi7
	5FKRg2/RL20lUeeUllkc9A7zuLYodYyKBKe2UiN5hQNg2vGDtBirzHWn
X-Gm-Gg: AYBFou35OhIP83O4c1q9AVIqEXkHPPGYUBKxemUaakbirz6WhEeEm6UfVyryatI1zzc
	5N/vlM03qwdaBeznlsqfoui7l2JfVzpWoV/787mhQUiZcddHc/5qjEhFc5oPQvHKT5NkEXoJbKJ
	ci8cyyOnEcOAmoNGJ3HG294WAvfV7ZQP3GgNp1f9WCgvitwIObhiRi2qq/J6GW1ajTS/CD+7AHO
	rDiy/JQk0sk9//fkodYrFbFBpkg31VDXKa53nC32ZDI93PEVMUj9Alon9phxQS+pmfL38li3iZb
	7lSviyYh0Tuq+9ARwtOpvX82Tgn+APhUi+udjh28gbAvF1zJPz5E7kqTeAkSHjy89KUWDH5VEaT
	+rrmFF3Z7eEdCScuUaiphIuHRAFNrTKVSRcCM89wrf+qFF/Tjak7BVmzrAoKiu9yQABjx1m16Wb
	+SZQg01dETFnX/VMpPno1Ied/VXlcecFJM19ykWRKbLcfD5eur/bVjH/7ZwckLF0ykm/LRZMgAA
	wQPfk9U2z2/6ZRI0Bu5qdn3zi4urJMSOXBNcRViZ0mw70qUWjdw/dDhK54LNWwqNwnRMjSt1WaR
	2OL40XlG+SG428FG5YHqsGsG66sS23GwapNBZA==
X-Received: by 2002:a17:90b:3d86:b0:3b0:92be:ea4a with SMTP id 98e67ed59e1d1-3b12d441c8dmr2831006a91.45.1794218873254;
        Mon, 09 Nov 2026 02:07:53 -0800 (PST)
Received: from [58.206.202.11] ([104.28.215.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm6303578a91.6.2026.11.09.02.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:07:52 -0800 (PST)
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Haoran Wang <haoranwangsec@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org, haoranwangsec@gmail.com
Subject: [PATCH v3] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Date: Mon, 09 Nov 2026 18:07:48 +0800
Message-ID: <20261109180748.33682-1-haoranwangsec@gmail.com>
In-Reply-To: <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
References: <179241614797.5916.13928836073297916808@whr> <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>

ppm_get_cpu_entries() disables preemption with get_cpu(), reads the
current CPU's pool with per_cpu_ptr(), then acquires the pool's
spin_lock_bh() while preemption is still disabled, and finally put_cpu().

On PREEMPT_RT kernels spin_lock_bh() becomes a sleeping lock
(rt_spin_lock), so the task may sleep with preempt_count elevated:
scheduling while atomic, reported as a BUG by CONFIG_DEBUG_ATOMIC_SLEEP
and a deadlock once the lock is contended.  Any iSCSI offload I/O
through a Chelsio NIC that reaches ppm_get_cpu_entries() triggers it.

Read the current CPU with raw_cpu_ptr() without raising preempt_count,
and derive the global index base from pool->base (initialised when the
pools are allocated) instead of cpu * pool_index_max, so the base
always matches the pool that was locked.  The owning CPU remains in the
debug output, now derived from pool->base.

Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>

---
(Resent with the complete Cc list; the earlier copy reached only you.)

Hi Sebastian,

thanks for the review.  v3 below addresses your comments:

- The commit message now describes what the patch does; the review
  rationale moved into the changelog below the --- separator.
- PREEMPT_RT spelled out.
- pr_debug() keeps printing the owning CPU of the pool, derived as
  pool->base / ppm->pool_index_max; the global index stays
  i + pool->base.
- Tested on: x86_64, compile-tested with CONFIG_PREEMPT_RT=y and
  CONFIG_DEBUG_ATOMIC_SLEEP=y; no Chelsio hardware at hand, so the
  change is not exercised on real offload I/O.

Changes since v2:
- Keep the owning CPU in the pr_debug() output, derived from
  pool->base / ppm->pool_index_max (suggested by Sebastian).
- Reword the commit message to describe what the patch does and move
  the review discussion into this changelog; spell PREEMPT_RT.

Changes since v1:
- Drop the cpu variable: read the global-index base from pool->base
  (initialised at pool allocation) instead of a cpu captured before
  the lock, so the base is always consistent with the pool that was
  locked.  The per-CPU pools are shards of the global ppod index
  space and not tied to the running CPU (ppm_unmark_entries() derives
  the owning pool from the index itself), so locking another CPU's
  pool after a migration is a cache-locality matter, not a
  correctness one.

 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -119,16 +119,13 @@
 			       unsigned long caller_data)
 {
 	struct cxgbi_ppm_pool *pool;
-	unsigned int cpu;
 	int i;
 
 	if (!ppm->pool)
 		return -EINVAL;
 
-	cpu = get_cpu();
-	pool = per_cpu_ptr(ppm->pool, cpu);
+	pool = raw_cpu_ptr(ppm->pool);
 	spin_lock_bh(&pool->lock);
-	put_cpu();
 
 	i = ppm_find_unused_entries(pool->bmap, ppm->pool_index_max,
 				    pool->next, count, 0);
@@ -145,10 +142,10 @@
 	spin_unlock_bh(&pool->lock);
 
 	pr_debug("%s: cpu %u, idx %d + %d (%d), next %u.\n",
-		 __func__, cpu, i, count, i + cpu * ppm->pool_index_max,
-		pool->next);
+		 __func__, pool->base / ppm->pool_index_max, i, count,
+		i + pool->base, pool->next);
 
-	i += cpu * ppm->pool_index_max;
+	i += pool->base;
 	ppm_mark_entries(ppm, i, count, caller_data);
 
 	return i;
@@ -375,6 +372,7 @@
 
 		memset(ppool, 0, alloc_sz);
 		spin_lock_init(&ppool->lock);
+		ppool->base = count;
 		count += ppmax;
 	}
 
