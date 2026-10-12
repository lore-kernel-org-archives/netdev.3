Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3146AEF0
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798909; cv=none; b=AEU9IYempOXngMkrkCX+2G5EpcFqa1VlsPPfONF+Wpy97JzXH7HQk+43BOo+/DP7W4vlfV8I98RgoVrSRF1uNM7cePMcn7aiPCmtz5vmPEnVUg0BI3z+12O0OInAAICEbpSKP89zCI6Y9KK5xoI/IBQHaZMhV20WNjaWRmn4QsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798909; c=relaxed/simple;
	bh=sDMuLxeEzbRgqeYq9AruGzBsPzZYJLQbxcH0SOUV7NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LUZoWR3DLaF8PPhxuPIclcZrNi9vfY6t/5LInEkJt9HKJzm1+xkWa2iu1Ybad4lq+U8EyBy69RDDyG6zoGL6BcrxjkPX2lw1oavmaJo6fkwW3vNcLqgYDn0F8dS3D70iwR1CxyY7c4tLwXzyXC4lhiVtyulxh2FNgpGv5feX9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S5MYqxCP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S5MYqxCP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48af27fe287so1435879f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791798904; x=1792403704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oc8KVWrl/1bTXSFXHOfJ6AdPh/E0VhbTYjHSfv/v5Fk=;
        b=S5MYqxCPw/Jhg37YuDI0l0opM0OvSkru62mZa5VrOEjmailDNfTfWiNf32SOi964fb
         AChPNUiA5InRLIvIb0l6Givg/qqqsAd+0vI4t4hzXZdW0Ob0G1F3Ly8Jd3U1482YfrM9
         9nSvsP6uPB/yXRZyOdY6P48AwxbowD2TIelFgLxQ60wZKRV2Tiln13aAlNeS2+XuAkyP
         9XfKK9X/B+HNg/R8LpKHJTdypOa8VIQAn3oRNWKu2nxOj3zE1vCuaPU5sLD4Ep6PlGTd
         8M2o4AXqG3y7El9RoKcAvpz7feTbHDAOJ87ZG9VaX8/0Nwy5OyBx1Z0ckHQjgVcSgVm2
         u7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798904; x=1792403704;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oc8KVWrl/1bTXSFXHOfJ6AdPh/E0VhbTYjHSfv/v5Fk=;
        b=GyJmU2WOeHFRaEEG0XKCR01+3q6U+m0zyDy+Td90tLbkpZ56g/2bSoRj4bzNLy3cZm
         OVb99IwcEdDBiskdBKU5W11eqWjsshexOPSgAzNuNLA1vXADWYpGtlO/gdB7wFMyuKUJ
         Ik+iqZhrPRqiDGOY6Z29EbB+rTcAAB3N736rArzIaYFie7tX+0QHzkeTwx4RpU/oDlvh
         aDN0c4Rf1+jm2c078/XVowYw+Q+mTWgMqpC91/iX+RRu8wRryF2jq088KWSBNOUOjUJk
         cLQATNbmzeMA2gTgE+t3qFDgal+6iHSANhasNkqahvIsOUZbB5/+g1OzmlQVIqMDcMKa
         70xg==
X-Forwarded-Encrypted: i=1; AKwUvBzLsGgj/DsqsOcubzCVnEYPn5aTy88dXwDuDRBvie7Qoq3Rk+yy+SEz5+6v0Q+ml2eMjtO7/Ok=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLDkW7Wtfhrnn2gFEvidNr2F4c2JIX2SgV+U1yUlWerr/mpufl
	Y1kjBGfVATqXlUBxPso9/+/kj/NnnKVrKDuL8gU6zRfhACPk61G1VZi0d62IF3SnzgI=
X-Gm-Gg: AYBFou3BiJTob84NEh3kd8bpcfGow6NQ6HKcnT00DwzLA6ImfyruvUc/KK7fZ/0Gucg
	D9B8IOrZwc+o+v1qKL9w9rg8GlbXaDUqsvB6ze/KvEWY5AUs4Bc1hH+CYGnOKO+S3956VnM3xRJ
	+UcY4ha02tXigkOpQmywR+vp4XaVMp9I3aWM5fluUaDjhTP6ApPvjH0NZ28s4bG/KJNqxpC1KmI
	iUt5UuJhS0Oe+7Pb6C8+QwxBRJLGgrp+Yp0JcLui4eE39aWLSCo09nUCI5KnfMYW7Lxz6K8vnKG
	O/ltwdMbJfofuGkAGvocF/Z0qwrGatPlmi7Qt6eWC6teWV68+PSpv2JxiDkFLUbwoavJG+7I+Kp
	ZhIjTiDSOul+gtZIfggtAAB9PcCSIFpTSrg86h1QS0wGOcQb0aT0BKCq6e8Gdahgg2OerKJhLtH
	B6WAiJTG5AmarY6S5NUwOORciC4czHE5VnEpDgFi6TkLrs0VYKMuNeSOpy7Q+gsBKlLiZD3Ncw+
	8PVtyqUXzS67pxhAiW/t6SWNyfWHzxG
X-Received: by 2002:a05:6000:2082:b0:488:89ad:56b8 with SMTP id ffacd0b85a97d-48dba6f52abmr16620045f8f.0.1791798904225;
        Mon, 12 Oct 2026 02:55:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c2800sm18539103f8f.26.2026.10.12.02.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:55:03 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mika Westerberg <westeri@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Richard Cheng <icheng@nvidia.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Roger Quadros <rogerq@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH net-next v4 0/6] net: Move system_long_wq to system_dfl_long_wq
Date: Mon, 12 Oct 2026 11:54:39 +0200
Message-ID: <20261012095452.135828-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This is only rebased as it seems the patches didn't land in the next
release because are marked as Rejected (likely because of initial feedback
on 5/6),despite the general positive overall feedbacks (also on Patch 5/6,
later):

  https://lore.kernel.org/all/20260906080818.GC6356@carbon.k.g/

---

Currently the code uses the per-cpu workqueue system_long_wq to schedule
long running works.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Another good reason to have this unbound,
is the "queue_delayed_work()" function, used to enqueue the work item.
More details on this will follow in the next section.

Recently, a new unbound workqueue specific for long running work has been
added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

~~~ Details about queue_delayed_work ~~~

system_long_wq is a per-cpu workqueue and it is used as a parameter of
queue_delayed_work(). This function schedule an item that it will later
be enqueued (once the timer will fire). __queue_delayed_work() does the job
receiving as "cpu" WORK_CPU_UNBOUND:

    if (housekeeping_enabled(HK_TYPE_TIMER)) {
    //      [....]
    } else {
            if (likely(cpu == WORK_CPU_UNBOUND))
                    add_timer_global(timer);
            else
                    add_timer_on(timer, cpu);
    }

The timer is global, so can fire everywhere, and the work item will be
enqueued where the timer fired.

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change the
workqueue with the new system_dfl_long_wq, so that the used workqueue is
now unbound and can benefit from scheduler task placement.

Thanks!

---
Changes in v4:
- rebased on v7.3-rc7

- added review-by Sebastian on 5/6

Link to v3: https://lore.kernel.org/all/20260720100902.155605-1-marco.crivellari@suse.com/

Changes in v3:
- rebased on v7.2-rc4

- added "net: ti: icssg-prueth: Move long delayed work on system_dfl_long_wq"

- changed also the workqueue in ibmvnic_reset().

Link to v2: https://lore.kernel.org/all/20260706134033.244295-1-marco.crivellari@suse.com/

Changes in v2:
- rebased on v7.2-rc2

- dropped the RFC prefix, kept Ack and review tags

Link to v1: https://lore.kernel.org/all/20260511092846.120141-1-marco.crivellari@suse.com/

Marco Crivellari (6):
  ibmvnic: Move long delayed work on system_dfl_long_wq
  net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
  net: ti: icssg-prueth: Move long delayed work on system_dfl_long_wq
  net: thunderbolt: Move long delayed work on system_dfl_long_wq
  net: usb: pegasus: Move long delayed work on system_dfl_long_wq
  net: usb: r8152: Move long delayed work on system_dfl_long_wq

 drivers/net/ethernet/ibm/ibmvnic.c           | 6 +++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c  | 2 +-
 drivers/net/thunderbolt/main.c               | 7 ++++---
 drivers/net/usb/pegasus.c                    | 9 +++++----
 drivers/net/usb/r8152.c                      | 7 ++++---
 6 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.55.0

