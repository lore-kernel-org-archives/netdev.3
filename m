Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617041;
	b=N5jGSFXCOTfV/u34AfQCqPE0vSPvsUCYIKeNL2GzPtlYrKPcXXILLnuSjHcmBcG4YVws
	 ALTQvppFi1++mZI/kcyKJdeWSDynA7+5PMi5Snrkv+eu19Cu44ydbT86pMddYFD+cR375
	 NMGEzUfh2rVxgn5JsSYCbWZm/v2chRDkmWWeMi6LCyjftNYJeFoBzLuBLfUyYX1oTOTz/
	 WQL1OtpmT0fnMPXRzrCQaELpEVixNm0LRImWHbRgPT33Piomv3BANcp87jXqSdQk6QRAC
	 /aWcJOF/MydEsj5vkylbgRai93aIv5iBKbLq9nj8urI1MKoFgzaJIA9VgrXyibr8Bmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Aa0YS/IQUjNBJsPU0/wJHEsRFIdEerQLiIg1zgEc56U=;
	b=biou8xMANAWrLIVboTGXJFnc+v3SXV3GlJ/rNva9/pIlsLB5mq3Yk8s/mDzDQcvNt2Vt
	 RAvjmp2J1Ynn8iMCs2Yg0C/sWsZP92qIDj0aS7OC26ZvRmdyBRlCMpC+JRlLYy/d9bv7Q
	 XdmIklVgcjIyU7hnN3yg60bvuy92Cm7a1Ka2ouJd+2eWkcdHOC6IXhKQw0fYpMkHCO46Z
	 XZc3MeyydSAGTcuRAyDcpwa9j8djD7FeX4Fcj59TJn90ESbnYtW9rMqr6DbjBpq0Gtd1/
	 mY3E9WAmVsraLzwpkCBLJfnjVt4FqWSzixh7FcpzLCcYzthlXTRq0kpHna5RuAQYj6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OZfi+NFE;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E67606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69E67606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OZfi+NFE
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so29925195e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793617040; x=1794221840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aa0YS/IQUjNBJsPU0/wJHEsRFIdEerQLiIg1zgEc56U=;
        b=OZfi+NFEoqTTtCNTXjvDvQrFGnXj+9roklJuDGOywKU2iAs4WcKWgE1X7m7+Rupel6
         ze1o0i8qyhVYg1r+H+aWzjxK0BL6oUcC5E65Qe63GMxqpM7/SUoaaSvYywGF36LTQip0
         i2R/lrXH5/naR9jpGWQGgoqXNhzSFgWZ34HphBqi6eDa42hofT2tba8tghxeOpMtgjoy
         tYBpTmXVFAlrK77cfUyFPvrYsE4nJ4HQzouQoMq3iXK+IbAZq4OW+sj6OJPke8l6r+yn
         aHbqI82pybsVYXVvWvp9H1Tn4M2nVoBN1edpYreapn/E0JJCtrEeGqKao7/DaaWDQCr2
         Qs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617040; x=1794221840;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aa0YS/IQUjNBJsPU0/wJHEsRFIdEerQLiIg1zgEc56U=;
        b=ixx5ZZ0cPqp7KdxUJgO+yTjOrejNtMlQazlqpo9fBbfdda4KpBtJVuKZLNPjsPdNhj
         j9E0EvBC/E2b0mMdK7pfMtDcRst1gDQmPhAnxFT8w3gENaUzRCDlYCzChJ5S3q0LI8ZD
         1HurMLR5Yg6azV/IrAwrh+x1D8osk9VqVgrDpsNWJAX4zEZnjrJOy4T8FQGH+Wae1xoG
         Bs244HYREzd7mrlhR6BmdcUbScdz/TFruT8ZwOVxlSxMBEk4EHcD811gdCX6GmPB+xQq
         tEjcwYBNwdVyO77vl/BWhP5AaWGVZIo4bUymmHmvOb6JeOCUVir0d5a79ZxHL9PEAiLN
         oyug==
X-Forwarded-Encrypted: i=1; AKwUvByezJAkeKfByYUNSpeQpNQ/jgq2K25uA5Lsj8s6AYRloeD+lLjpvqaZU62q8vbX/DGoN1a44+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMtHKDcvIVM+Gw/7MCMrAlTXSFIIYQlSCBJYVp4V8vLWd36K8C
	z15aHcP0M5oMq8nULHgp3gSNgWwKQG/qw4GY3dSjsE4GGATDKsb0Lfdq2/aZN3zijx0=
X-Gm-Gg: AYBFou0jCqniTqzLbiPWQlsgIU3DD3SwYXh3aDERhIEsjtjrW2w9tDomrg+H/LMeS3g
	x9TAtnbJJ1yS6IrHCJWJ8rDjH/Z4ZW6IzNNVlsULlPjFvyUYBD6mV+TavIp9/gflt0ofVlJBETs
	VX0YBIw7XxdPbeFhOjweEbBwjzdm5SI4BE2+ELVVwYxltSuzNUcuTW93ezc95NLv9lQerL2yRGL
	AR7EweTdsj/5gBOooKMMcHR30BTQukbE539Nb0iAoYLqdEoiNAWh9wpaLDgzPGKhf4XOZ0UrcDz
	1M6FTnBeT2pFLb4mfgf0q5vJkofmQPIOhVuZdFzUHfp3fJF+SytNExdu6j0RmHkImW1bxTQQLLN
	njYYs85BPypWz9bkJzhoaCiIDm81wTpVGdHOmuYI63l1hyxfmMcjf5Q4ECKKcOyiYTXonva1kpk
	6W7xKSViNwJF+v5Q6VLsNuNLT07HUlDAYgMB+NT3GmidXcoweGQ/1ZQzdCZllASzRODQxqHOw/s
	mB4+4DRunS7nDLvUBwuGkuUMbIWoH6mo+mDM0PUMRLPQy+1Y3gxFXXbG2oOfetuPGuWPIP+1pR3
	Yte7zLtXFN+XIKSz3PmUMzKObqzl9irmg4cL3BGXL1z/AGd5r7Sh
X-Received: by 2002:a05:600c:8b55:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4ac19234a06mr214806565e9.31.1793617039764;
        Mon, 02 Nov 2026 02:57:19 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm363171175e9.1.2026.11.02.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:57:19 -0800 (PST)
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
	Mingming Cao <mmc@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Richard Cheng <icheng@nvidia.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Roger Quadros <rogerq@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH net-next v5 0/6] net: Move system_long_wq to system_dfl_long_wq
Date: Mon,  2 Nov 2026 11:56:50 +0100
Message-ID: <20261102105703.111844-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
Changes in v5:
- rebase on v7.4-rc1

- add Ack by Mingming Cao on Patch 1

- fix commit log in patches "ibmvnic" and "net: thunderbolt"

- addressed workqueue change related to "icssg_prueth_sr1.c" where
  queue_work() used system_long_wq.

Lnk to v4: https://lore.kernel.org/all/20261012095452.135828-1-marco.crivellari@suse.com/

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
  ibmvnic: Change system_long_wq with system_dfl_long_wq
  net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
  net: ti: icssg-prueth: Move long delayed work on system_dfl_long_wq
  net: thunderbolt: Move long delayed work on system_dfl_long_wq
  net: usb: pegasus: Move long delayed work on system_dfl_long_wq
  net: usb: r8152: Move long delayed work on system_dfl_long_wq

 drivers/net/ethernet/ibm/ibmvnic.c               | 6 +++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c      | 2 +-
 drivers/net/thunderbolt/main.c                   | 7 ++++---
 drivers/net/usb/pegasus.c                        | 9 +++++----
 drivers/net/usb/r8152.c                          | 7 ++++---
 7 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.56.0

