Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404224;
	b=wbVydbOSfi76h4OmEItET0D0FrA73z09cLd8aOYDkA6mMVMiKqSFVQDPyAZwD+9FH9Ls
	 vSwcpuUGI4uODuOzrlfM40QBoeP2TPqJHcAWmuJUs5GHgWndOqmMGPA67I6vW2AQ/PVof
	 w+3fUt5N03/PKbS08HLexMH4H9KQQXdc4AGFcKKpUFv7tPXEesDYtIzZ+UpIoPqMjcTdF
	 cMqcL2YPvthXvUWbG7gIN2KPbGMTP4g6oMVsLXXGpo7CCmsP0Q6lSrPJlQmannevPXNNt
	 J1YyH7gW0UuJyqljS2jrOZB2ASTJ2bQ9+4UMi8E288DUGbvP5EMVbLfyKvIImHzzK6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404224;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=YNMcThRxFtGYoOB1SNTqBnwuJmm8ZLqZ0H+tPlZJ35A=;
	b=Z/VbFXvGLmm8W8RErw4gQfBnqokMEgYWfAp4wJcLfLJ8qJbmK86cx8XcjaeB+WD3bDae
	 ZsBRM5szS2n929NHjCOceuG+1Y6Zy/pPiVggMvYeddSbdy3R4L1KLhew2/J5b7cuHc5ok
	 bv0xtj5xIAAKvcvcXabY6SIVkq6e9DRsej+eOEpxR6/QuX4cBMQ3Yw0TZ1iiGgShqc8VW
	 916AUeRyQUGH0J5McQwmTiKh6vFrc2P9u7oNz6XNGCownrV1jLxcLn7kMKwrw93Lj41Vw
	 apMROx17QB5jvnU1nqUeJx6XloQ3S2dX4xVdpGq83dVkhRf5OAO/LoZbAFv3qUyqohw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=cFvAIY3W;
	arc=none smtp.remote-ip=43.163.128.47
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FE606A331
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD1FE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=cFvAIY3W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794404213; bh=YNMcThRxFtGYoOB1SNTqBnwuJmm8ZLqZ0H+tPlZJ35A=;
	h=From:To:Cc:Subject:Date;
	b=cFvAIY3Wwz62adtuYZvVYZx8542ZLidkoYYP+NGFqe3YydNoIlptz7Zlq7/S+z/HA
	 O1/yvjnb3czKADgxh/+kSPOVdlEjjaGbJCU07L63LFOQBSWFEoXMmrk8/07mVDJlHs
	 V7qIYqBwtH8Cal+KkYETSuAgwuFMmQb8uQ2+pMYY=
Received: from ubuntu.. ([112.3.92.91])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 9320F8A0; Wed, 11 Nov 2026 21:36:50 +0800
X-QQ-mid: xmsmtpt1794404210t734l17yr
Message-ID: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NopabHnG9nGmy8nTiaVLknyr6iQK7TrHN7teA/C1fjHudoRSXoBW
	 rYc54eeBNen1X0lJwN2CxR1kzmYhi6aZGz5N4WnH6jtOnjF1TfMVib68fUJ5cZLbVJZFgPeZTrB1
	 T7kV5lyNKcX3p1X881RjCVLZOJbQHBU7hmzJUwGuUdK27zEAI6KenwZLrQwWbZ8t4KpmG1OHiyYj
	 FcotxILPRLcdcYQJubmv8M9hzzVOdU0ozYrPqEAioaQfiHDGJ6tfkNaCFynrrFz7iwpNRgJGgy0J
	 /MQpfEp649S26r8TDkZgbTiUiDna47/vr0WTPqv51DljgsFtt0qtmcixMM+rN5speI3wM1483/rj
	 KBnxqE1yV1+Ytdg23zs3nHvFU8eaTcQ8du7woXjZ2nTevDYkClN724/DaEbTh3YaDKMo432ppmF0
	 X4TDAL8xSW/Q7QFVw0B0B2p6PGh9ffv+zeechWzTKS3z+9zL2Q59yflvQ9xKUacieTb49qaoGGCJ
	 mSmFsxuLnoimU3a3hZS9C5Pxd4aNZ4fT1tEjGd+IeOVcNkA6T8XkybxzxP/Fk/5HnxYKitXQH/2Q
	 GC/SMTI9vuHoVNAnaP2JdF1UzlJNVWfvm/5UBGw0Zy4XVEsjurPQqVqp+u+FUqUuhmP1vVAcnHMa
	 R35I8t9aIOiasSz6RdsL8OwnOK2LbMEZZeaTPaF0jGcCS03DPuJj3D4gG5rPzAZeS/B5XqgX8Cr4
	 hjusz+ryfumzHeflcar957hg8hysHVH6pV4KcgqhHwmUBCtCpj1yK+pFV9nhFUmjayByz/b4oSA3
	 PawWZvZ6+uwI6Xe4zEgs5J+7H7oqQncM+na2OSvzbYyxDwsH71+EqcLNYTFVkdgWtPR2bexG7xcJ
	 8g7wCM+c0NyPEdep596EC68Or2vcqSkxCf1julZwilgkSpRa4ISHDlsMf8zRiUeoUagkYgoE03kd
	 WnEIgRTqyz2XixpU3ruyruPYziUD3kQ0h1cQNqjv33QM+hkMBG5uzbSHQYGBbD0O3PYnAePCbPfO
	 kPVOiyc1FfEh3kgLkztJOQGUvazESNgJ2hDO5lpy8BO96EEBjTjt/E7DygWlab5KqVFKviIxQHtc
	 B/yAi9qy6HUyitUC5534EUDs5OnKnLJtJu/EL6FZwWG6vL2Zw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Congjie Zhou <zcjie0802@qq.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zcjie0802@qq.com
Subject: [BUG] virtio_net: RX stall caused by masking callbacks after NAPI
 ownership release
Date: Wed, 11 Nov 2026 21:36:10 +0800
X-OQ-MSGID: <179432914786.2.117574289414299585.virtio-net-rx-stall@qq.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I observed a persistent virtio-net RX stall on Linux 6.18.58 during a
multi-threaded TCP receive workload. After the stall, the RX virtqueue
contained unconsumed used entries, but its NAPI instance had no owner,
the NAPI timer was inactive and virtqueue notifications were disabled.
The receiving TCP threads remained blocked waiting for data.

Completion sequence
------------------------

The completion sequence can produce this interleaving:

  old poll                         successor poll
  enable_cb_prepare()
  napi_complete_done()
    clear SCHED
    arm watchdog; result=false
                                   acquire NAPI
                                   poll, enable callbacks, complete
  return false to driver
  disable_cb()                     callbacks are now masked again

Root cause
-----------

virtqueue_napi_complete() calls virtqueue_enable_cb_prepare() before
napi_complete_done(), then calls virtqueue_disable_cb() if completion
returns false.

A false return does not guarantee that the old caller still owns NAPI.
The hard IRQ deferral path can clear SCHED, arm the watchdog and return
false. Another CPU can acquire NAPI, poll, rearm callbacks and complete
before the old caller reaches its final virtqueue_disable_cb(). That
stale mask overwrites the notification state established by the new
poll.

The watchdog is one-shot. If it has already run, there need not be any
remaining owner or timer to recover after the old caller masks the
queue. This leaves later used entries without a notification-driven
poll.

Current source inspection and local validation
----------------------------------------------

We reproduced the notification-loss condition using a deterministic
KUnit fault-injection test on the latest mainline snapshot fetched on
November 10, 2026 (7.4-rc2, commit b3dfbde62cf1). The candidate fix
passes the same test.

Candidate fix
--------------

I have prepared a candidate change that masks notifications on the
relevant completion paths before NAPI ownership can be handed off,
rather than masking after a false return. It adds an ordered,
non-sleeping, idempotent mask callback to a new completion entry point
and uses it in virtio-net. Existing completion callers retain the old
API. virtqueue_enable_cb_prepare() remains before ownership release,
preserving the ordering required by the earlier RX virtqueue race fix.

