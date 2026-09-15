Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA27381E9A
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465374; cv=none; b=VSVBlHThX1eWZiwwuqDnSbcEK/w6q4C6HuZPYx1/h2Cl8IjTEE+8ra6KC3X4e8JoRFtR+YTss81Xtwh55c61Uv7UvMKyCoMFw3mDc6epCodB9eupV+8wBMpV6MMei3NnpqNYQyLOQJmFNyeHYglf+wV9zRDQOPzEL40PqtuPSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465374; c=relaxed/simple;
	bh=uCvoUHgJLkGvyYy/c5odfUayoHkL5waDu8y6yeP79iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bnn9AJtdiZR+rCwTZN1NcFuh3q/JZR1XahqIGNsPAO7WooTyXJVn2SGwTz7CEYAfBomCJxsLj1wgFZuohZlJdZ7nEw4+mAqxi3ZNj56b+W6E+MDRrqj/Knr5Xdgk1ex+Ii4BJzhFPb1pzevZenDNX9kntmApXIKPU2GZ1IxP4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz3DpKtc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz3DpKtc"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so49819a91.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465371; x=1790070171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FM6LpgS9VGFb0LQ0PAPpvOnM3tsCZP2CYIZnpcmqmZc=;
        b=Cz3DpKtcY3o3gcd6pKt/5EJBSkb5nikXLeP0NjHJELl/dhrxYrO0Q/tS+6SxjX5gpw
         lwK+PWPHf2kAHKg+x7VvUN7Ty3f1CEQoNPmUf8W4wNOhPcReDSkquB6IK9XczAdxmO1H
         7rbRhKUsu5WI8dvqcC0KEI0S5tkGBATG11relaG02ZasA1vCOm1Xsnx97eOISvcCVVab
         pNbW9XtWF69roObeAPWC4VYO50liZ20FpOrLctEm5NxvsP+0pCfFA4GsYESHWv6IMVgU
         g4p4dZO7Hf4RypfPiVZ0l28OlUd7Hri5fINeF0S1ScJ9xdxIapTr559rSkX+QVMLkwm0
         /mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465371; x=1790070171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FM6LpgS9VGFb0LQ0PAPpvOnM3tsCZP2CYIZnpcmqmZc=;
        b=2x0CAsgMGKLLay/SIcJLOdvqUGCnPk8HAdq1kBkvLbM4zGe4iwQdjzvMovnCLm9Ynk
         DfxyDgqDuJGrb6bXpMdHeOQ1GiEcyMOf+JpVPE2H1+FeUmoPH1GG1VkCbUH2wGVUNnvv
         9NrCJtx0lGCnqtvIhJY/UE2AIVy5f2/ANHpFDHGsXZyX3BwpuDtVQZ0MMEKmVYMpbIZn
         7OmcJvTVzgu/XpGcUkchVDsbq11lRf9ZALi3i2/PnV5Zb+avbWaMJy6i8sS3APh0bzPu
         0auqJFwZCEuqItvCafv5UHIEHlok3GCtl9QKHV0TBr6yLj4bqfdlH/ZnncumxKjidIAy
         mPrw==
X-Forwarded-Encrypted: i=1; AKwUvBw5qe/1J49+c/NmDb3+sIYK4rrEn/345d19fh4wsjv+gUqfpH/khCATIYc4boqU21gsaLrOW7Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lLAxDFVPcpByk9mO1yU81Kh1u9Nzxn6HKlRinYKJ45E48hb4xn
	o62613EPGZhZD08ZcKR2wGbGq4uJcKc8oQF7ukn2yvAIhiJS2CYG6Puz
X-Gm-Gg: AYBFou1dG8KK82oRtYq5ZEi3isa4L/DZNzZE0z3lrwmNq4L8o2BlKiCLVTXDGzcvkWB
	P1wvINzKRda6cpnKh54NVntyevacK33us6FdepNfaCMm34MJFtGnV5GFYFIB/wczsHBj/6IjkXY
	xG4nuWuQ+faqbD+sa4hIWLB41/odY6a1X50DIkKtgQZ5wjh01ppe2jvH5Ua6PyLn/AgS748iE3R
	Wtp80QQA5y8ZrydkQG5O38oP8FUdNW2WA5LSQQ5sJhLiPG/IUHmkYMD/kCguOz8uMyCqv4vkP0e
	kH9MBAC9CYu/J3PZTYDeH6zHTyAHHJAw/vLmoiQ4RVvhCIhrSSa/vuoxizxCXyxPpJIsdp1ispL
	PUGpLBdBcUCm1OK9cf6KL7IAjFt612TY1CMPpOX/e4PcWb3PrB/RToWj36z2C598D+PAYMWEIOL
	pPHjj6mua5q3lWviGesEZ1ya3Td2h9Ce3/ZYNDIstxWE4hd49K9qWv2hflYQYrC6k=
X-Received: by 2002:a17:90b:3c4f:b0:39b:4877:ae90 with SMTP id 98e67ed59e1d1-39e110770f7mr236150a91.22.1789465371127;
        Tue, 15 Sep 2026 02:42:51 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdcb54d8sm4196291a91.6.2026.09.15.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:42:50 -0700 (PDT)
From: physicalmtea@gmail.com
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	nab@linux-iscsi.org,
	asias@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] vhost-scsi: preserve event ordering and fix fallback deadlock
Date: Tue, 15 Sep 2026 17:42:42 +0800
Message-Id: <20260915094244.7900-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

The vhost-scsi event list is populated with llist_add(), but completion
walks the detached list without reversing it.

Trigger: concurrent hotplug (ln -s). Each event is inserted at the
head of the pending list. Multiple events must already be stacked on
the llist before the vhost worker runs
vhost_scsi_complete_events(false). The whole list is then detached
and walked directly, so later-enqueued events are delivered to the
guest first.

Queued hotplug and hotunplug events can therefore be delivered in
reverse order.  Fix that ordering first, then fix the fallback path
that can relock the event virtqueue mutex while already holding it.

Patch 2 is based on patch 1 because both changes update the event
completion path. The first patch is otherwise independent of the
fallback deadlock.

Sashiko AI flagged this while reviewing
the vhost-scsi event queue fix.
This is a pre-existing self-deadlock. It was reproduced in a
follow-up test.

Trigger: vq->worker == NULL. vhost_vq_work_queue() then returns false,
and a subsequent vhost_scsi_do_plug() call deadlocks. I do not know what
normal condition gets us here; the normal vhost-scsi worker detach/reset
paths do not reach this code. The only reproduction I could come up with
was killing the vhost-scsi worker. This still looks like a low-probability
condition.

Jia Jia (2):
  vhost-scsi: preserve event ordering
  vhost-scsi: do not relock event vq mutex on send_evt fallback

 drivers/vhost/scsi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

