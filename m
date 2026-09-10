Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58621CC5C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073178; cv=none; b=nLAy+WVovglLlK9iSgeAHRKWgnp/4tWd/K2ip8I/4xZ1OK3nDniWMtZ1jSGk6EriqFepRHlujcd6kwUqfWusEFBVQsHDte16uBEb2MpZWKucAlLimuvxRLwVCj1dchnFiQqPjjQfkpRP22B2fycm6ceJfa3FP6zESunzWRNfkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073178; c=relaxed/simple;
	bh=qQkxCfQa0xfHcZDNntGrxPnVOQFH5f87ViSihjt/FsU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=knZeLOvaJVpky5In56ZCdqRXQiGAdqWc3PkthXsayhTWXp3lPJQn6fzPCJ9sQDqcHapKjURgA8B+Fww6JNjH4go70VrdppULg+7JgdkaFWsK0n50qObouJhgcge9TmP7l31anUb7Gp2/qomaUqkLRH+GfRl5QR2vXJdc2NvaiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmhukZUG; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmhukZUG"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so23477285a.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789073176; x=1789677976; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2XHl09WRgI0VFj4kMSGlDDe7cs53HgQ4kau/UMQ/Qt8=;
        b=PmhukZUGd+MRRaDfO9PUTXtEq8qYDaAnjSSPmUHCvbFb3rDOaxAzj2SkHwKdlG7aI0
         CbDTsyBudJ1geinPDAJzmVPJ4yzg/YLAw4+ahvzdsMBotAuAvyV0fe26EoNwe5ELmAKt
         t0kj1JZ0yLDB2Qedy8OSBBW+ulwMeK8MgYd9W9zZlvtajwRAxO6+EQT3T966gfpDrCzr
         ZgMz868CZ/lllImVVUBor8uNT7oBqOdGNb/tRGSNJasigAWFZK5ZluPBnbSWm7wtjahW
         06hVmUESsV+S0sur/B1FfvOBxLKkCcrmcIEKFVzUlo+WzsVTBJ21uMI3RthvVWRamZfK
         Z1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073176; x=1789677976;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2XHl09WRgI0VFj4kMSGlDDe7cs53HgQ4kau/UMQ/Qt8=;
        b=r+Z1YOvFDIYGsgGsyc+fAoHhGBWLsfyEIpY8xP4LPoucjPLnrwApdGHpp9Bk961f4E
         Jpmc8EH22DY2Ffb+PeQpKJHdSB8AKMhDWFG/pZwUvvhLueQNznCX3/p587oXQ02m90k+
         4ArBpPitGtLzU+WzD6eKxIVNIrbjZKExmk25XRc8iY3EtIvw8roPf2nfcUZGfRAmF1KJ
         JIRMn2qbG3UXrStaBxVNmHA+TQDmlAIkt6ysqr04QNcDt8VQDLElCp3GtLBbMTjhcLv7
         s/seeACSSWR11Cn+68+mPwtgKsEIDc7dfyoBo7kvQd0y0vfgs6K1/uK2A9gLCK+GLQYL
         TWOQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7BfRksTNx9AT/EHMS4c5W4Q7J+dXGj1SeaPLZJSDTCB/B4Uwf7QafEsWuNVoKV1SIWY80DTw=@vger.kernel.org
X-Gm-Message-State: AFuF++k7zPHdowSgM1UYJyDumjX8OGPhfHDJSB1NeGQIvyYOGTc06rQn
	Q/w49De4zDYBtyavynpA3+Ic42G2m7ms7VKfifhKu+JJPLhoJ2jZ+gPAkh6T1aBcvN2AmvdJr4O
	GQ/sY4cYJfikqag==
X-Received: from qknop14.prod.google.com ([2002:a05:620a:534e:b0:939:e027:3df2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:371e:b0:939:6132:62cc with SMTP id af79cd13be357-939ea14df7amr96494885a.27.1789073175866;
 Thu, 10 Sep 2026 13:46:15 -0700 (PDT)
Date: Thu, 10 Sep 2026 20:46:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910204612.3762015-1-edumazet@google.com>
Subject: [PATCH net 0/4] net: drop_monitor: fix concurrency issues, preemption
 warning, and buffer overrun
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses several issues discovered in the drop_monitor subsystem:

Patch 1 adds missing tracepoint unregistration synchronization to the
net_dm_trace_on_set() error unwind path, preventing in-flight probes
from scheduling work after the module reference has been dropped.

Patch 2 resolves a race condition during monitoring teardown where per-CPU
timers can be re-armed after deletion if a concurrent worker encounters a
memory allocation failure, switching to timer_shutdown_sync().

Patch 3 fixes a CONFIG_DEBUG_PREEMPT warning reported by syzbot when
kfree_skb() is invoked from preemptible process context, using raw_cpu_ptr()
since each per-CPU queue is safely protected by its own spinlock.

Patch 4 fixes an out-of-bounds write in reset_per_cpu_data() where memset()
overwrote the allocated SKB tailroom by sizeof(struct nlattr) bytes.

Eric Dumazet (4):
  drop_monitor: synchronize tracepoint unregistration on error path
  drop_monitor: use timer_shutdown_sync() to prevent timer rearming
    during teardown
  drop_monitor: use raw_cpu_ptr() in tracepoint probes
  drop_monitor: fix out-of-bounds write in reset_per_cpu_data()

 net/core/drop_monitor.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog

