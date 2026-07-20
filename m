Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5CA3DB635
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542160; cv=none; b=T99Sv95v2Y+AGzRYTHFXw9/Ta+T4bK6kDsdKoYWg/sYTGQOAxf+eSggngtpYVOJguZxc7R+jtihyqCsH1MUzav0KvnFG80Gxl5Brqwb9zq17xbEREiYhVYhxLGVH4K/kwicOU8husoeMmFjzVERJYCDBcx6jxh9RfEU34i7/kcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542160; c=relaxed/simple;
	bh=KcJJfuTcPZ42Gffl+oijDCOzJxqVQLs1QaqJvlj/W7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i+UWxLw/6t0VvFvt8+2MQU52Pny1DcZ21ZbSNOj8RuNYiwzm2MyIyexr1Mx2/LCeysZyMndeafr+xpgV0zPHkr6yd9yCpDVsnZKjOUx3tn0d2p/K4dbLWs3yGmVYD08GbqoDCn9MdMgVctN5KjhvE24fyNntegWca9o5QCtqK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Aaq8p2F6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Aaq8p2F6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49558ce01afso9759095e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784542151; x=1785146951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T+SPKWaxytnGRImorl+1NdLSvi5YBLe2qcoISSE03f0=;
        b=Aaq8p2F6EfNHFK/19GbYqT8l1nN7cHp+4AjjJQnSUZMLdNyyhDvIXF9Iimid3jKKU6
         QLZSKJu+grU8t3L9Cw04QcHxadnhUyc1kHO4yPJjOJ/eVwqAmqkT7Pg8uJDrk6GVVxYh
         7+9NKWQ6CLTAreO9PcmcYL96kJSyx3sarucWf46jTrX9Eqi1UeHU4hAqVfxmOH4l60ce
         b1YNWomH3BNJOeyhOsFN7WTKYw9PJECmSc5ceCR2pX6hN15EZMpl0bRKZYxNyGE2lhw5
         bwKZ/m1PeTcyYMwEc1yyW10nWKWfx2kkapyufFXZX/JLFr/jIYJtmGSriKzjdZtZXXAO
         I9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542151; x=1785146951;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T+SPKWaxytnGRImorl+1NdLSvi5YBLe2qcoISSE03f0=;
        b=ae6xFdWRjsF1S+tIDoRRtfk287Epc9G9+viSTZf6FQk0DsupwDc0WWkeofFs612qy6
         oDwcZf/34OFtsJuJkh2CTGvLBAKv6EjxGov6nwa9+hCPsO1FyW42h5gq/wI+ytsNtHpa
         1EgvTE/8nuYq0v3HYb6JSHjb0WAalYYkyiW3MaD6ZLJUmX/Lvxu96bDEIy2drfi1koNB
         cZrV2g823VaGfePwNMmr0Zmlv16kR44YBAnvVtOFyhdmFuLhOi3xlq4ooqesymdK9cwu
         hP6l1Wu204BScujVp+pAO07IyzRPOkYX36pgp9rxXIcDUPrVqN1wrz1Iu1cszKuEg7LD
         8k1g==
X-Forwarded-Encrypted: i=1; AHgh+RoxBhLXF5RNcVoyjV5Rh4ROdx0Ic+S4xJNDmQadsebQQ28W6k9hMzwbzxixctBTn0tbcDYaJyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGicubjELq/ivLPZhOFRezLZQw/MusTiA+kyCvwlBmMVh96rb
	Hf33f6xARTVPMiIyD8Y9z8D6cIp3AtTljjOw2CVYgUgZQ9cg4McxzMu7F2CYEELxHbc=
X-Gm-Gg: AfdE7ckL8+3wGrF2tSc2IsoVP5f5QFkX1ISNrUmbj5tSEiIgncRcuiwaRQ/N2RAKR2I
	9MrSmflVe0Ggz9dx1GPOge3Giw3oSL99rXda2yI8IR1T95t316mPlFk4RwsxTfEudmkIw8p3M5X
	9C4osumSTeniAGOmzs7glbPfT/YRNM2oSp2Z2NzEUOMWtTpd8+Tv4lM4gkPRXjRHTmG71DEW2+k
	s9NyhFz0vSW6Txlyg7IuNJaNaBNUNImjE0E2u5C5yqEJueCavCSGHKcaLqEoBEcPa9hnKc2BYwD
	nTjfEKgSEzND+O3+OL6TyW8hr+DPWItBW1LBEYSc91mFmFeEpkGwR5XckvccE2VNWAoQy26D9BO
	y44wpTbsd86lxXDUQlu+iBys6AsCgA9Kb8hEyiZ4A5wXAnk2rMaUg8TNgFpu1/PmVNGeRG1Ekp0
	JyQoO0pSZCbpz1aeWddbJS9DVInA==
X-Received: by 2002:a05:600c:198e:b0:495:4f88:598a with SMTP id 5b1f17b1804b1-4954f885a12mr129671915e9.13.1784542150854;
        Mon, 20 Jul 2026 03:09:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2504sm294792995e9.2.2026.07.20.03.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:09:10 -0700 (PDT)
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
Subject: [PATCH v3 net-next 0/6] net: Move system_long_wq to system_dfl_long_wq
Date: Mon, 20 Jul 2026 12:08:50 +0200
Message-ID: <20260720100902.155605-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

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
2.54.0

