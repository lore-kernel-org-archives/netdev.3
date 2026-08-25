Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB927471433
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667919; cv=none; b=ousfZzG+/HjNtsoGW4t079xsackUbX71kTD4drkwEDjcPS2dec6Rp3dXJ6Go3yEimAXGKF3hkSzdC6eI6EsRm4yzzvdE582tDfLb8HllYF26i8EnCXzaXS95GXbe5MzsicdoiBqoOztwc5rFi/jRweU54gudISYctEmpywfe61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667919; c=relaxed/simple;
	bh=lcussTpnEkYB+f6r4eYplK5pAVZZaGO8mmd85E/qMmA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aPd1nlomaw6hx4c0HMjyhn0DyPm7AntqeJRVxQznUt/95cRNLA+AuVZusdJBYLWfnn1e7djEYmmn9nKOd6qUSU39w0ifHB7k0+VtskcF7F2Nb2sbuhR24MCCj1QgBZ/if4X2WsubLFMsFfChgEvRyd6kL2qA1AcicF29vzdKIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYWpomNR; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYWpomNR"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c01ff996dso53396981cf.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787667917; x=1788272717; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rdFSlUVmHWGUJbLkl9/wAY3JHKLpZ3Zt8SkFUaiSwc4=;
        b=iYWpomNRKyufYrzjWt7bnv0TmXZdxTNtk+CA86Ziv8BBx0vVW4/kdvvGlCagiF8x/f
         epQX+z+t4B6c/c6JMY2BVmw1N1MfAvAlFqpPQ7Ixk1PjsfR2grdMd35enBMhMVzAItXY
         eVfTvlkzwF1QekNLnYqReVL/r64Xe9/UoFNOvNfa5h18kz6yP78W3nVYuBvn6yRRtdIQ
         dcu6YLwn44vATiH2ChATWN1FhrCdF6uWXSl1vgwuMbl2zs8um4JaICoQPC02Pi+iQMHb
         m+m/SxH0Gj8RJr5cOEbQlJZ1GphPS9LoQ4A2vDNcj/y0lqnzFDh0VuTiKTPwsuCGBwu5
         zlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787667917; x=1788272717;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdFSlUVmHWGUJbLkl9/wAY3JHKLpZ3Zt8SkFUaiSwc4=;
        b=bB5H0MsGxAaLDnY86Bhp6rSmJ1aIJpe659qrb0+Vx8CjRtYR8EVytm/3CYqnc1QRyq
         0dimyWXZIp+P93AKzFEY5sNw3m1sr8YFQxK0TYsdH1gRONigesKwe/2HgqmY7h59jNea
         d2w4he58Gbo7Nx+KZE9ozSRbQz7vkRlljegfgoW9F1X7DH6n4FYySKu9E3eRWDdrXOCZ
         rv2dgntGGzu/RtTTLNlhvt6QuGVf4hHubn4TkhZ5N+pdj1QhE4xlvMHrfWNkyuDIjqWr
         0lkPsVjmgC1Z15oe6dwuKxK6J9kz/psOSE7yKZSxAu8fSPeAPO7tvyjJqbEP/eOsRMQP
         8Juw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0GikUDn3uVFt8bOmlkNvp/AK7DHy5bxHENNFHpIhWiayS9OPuhnr/BZW6k1flvea2iGHROU4=@vger.kernel.org
X-Gm-Message-State: AFuF++n0++Klm9tu/Etu7P8tD1wRtW41r3kjdKGSNbymnL3rIBrKxvlk
	oK7ZuiY+qFnk8RsmP6dkqF9cM6VDVacU9nouUT7WDbjCSTdPulnKp1NtiPqVmu14GmMY+cl8wCc
	HUzqreWsS2tOrvQ==
X-Received: from qtqb13.prod.google.com ([2002:ac8:540d:0:b0:52d:4e72:d2ee])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5d53:0:b0:52d:4f43:d5b0 with SMTP id d75a77b69052e-52e2f127d41mr69938171cf.22.1787667916432;
 Tue, 25 Aug 2026 07:25:16 -0700 (PDT)
Date: Tue, 25 Aug 2026 14:25:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260825142515.1965654-1-edumazet@google.com>
Subject: [PATCH] Revert "once: don't use a work queue to reset sleepable
 static key"
From: Eric Dumazet <edumazet@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Keith Busch <kbusch@kernel.org>, 
	Nilay Shroff <nilay@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit e8eef69a99f185e75909adb24ab93d706e07bf27.

While DO_ONCE_SLEEPABLE() is used from sleepable/process context, callers
may still be holding arbitrary subsystem locks.

For instance, __inet_hash_connect() uses get_random_sleepable_once()
which invokes DO_ONCE_SLEEPABLE() while holding the socket lock (sk_lock):

  lock_sock(sk)
    __inet_hash_connect()
      get_random_sleepable_once()
        DO_ONCE_SLEEPABLE()
          __do_once_sleepable_done()
            static_branch_disable()
              static_key_disable()
                cpus_read_lock()

Calling static_branch_disable() directly from __do_once_sleepable_done()
causes static_key_disable() to synchronously acquire cpus_read_lock()
(cpu_hotplug_lock) and jump_label_mutex inside the caller's lock context.

This introduces an unwanted lockdep dependency:
  sk_lock -> cpu_hotplug_lock

Because cpu_hotplug_lock depends on fs_reclaim (via workqueue CPU bringup
allocating memory with GFP_KERNEL), and storage/block layers (such as
NVMe-TCP) acquire sk_lock during I/O dispatch, lockdep reports circular
locking dependencies:

  set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_counter -> elevator_lock -> set->srcu

This false positive previously prompted commit 19bdb70c77d3 ("nvme-tcp:
lockdep: use dynamic lockdep keys per socket instance") to work around the
warning using per-socket dynamic keys in NVMe-TCP. That in turn broke
asynchronous socket teardown and caused syzbot warnings in
tcp_tsq_handler().

Restoring once_disable_jump() in __do_once_sleepable_done() ensures that
static_branch_disable() is executed asynchronously from a system workqueue
without holding the caller's locks.

Fixes: e8eef69a99f1 ("once: don't use a work queue to reset sleepable static key")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/lkml/ao0mwtt8ePAINFni@shinhome/
Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>
---
 lib/once.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/once.c b/lib/once.c
index d801bfa945e6..0a0a919156e0 100644
--- a/lib/once.c
+++ b/lib/once.c
@@ -93,6 +93,6 @@ void __do_once_sleepable_done(bool *done, struct static_key_true *once_key,
 {
 	*done = true;
 	mutex_unlock(&once_mutex);
-	static_branch_disable(once_key);
+	once_disable_jump(once_key, mod);
 }
 EXPORT_SYMBOL(__do_once_sleepable_done);

base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
-- 
2.55.0.860.g4b6b3295ed-goog

