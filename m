Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48522424D57
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198785; cv=none; b=Zp4QfqkNEPpVbaesbk/pPhFECDXjV1KLGLB4zhaz9ods2cR4nu6Nb6917dIi3nvVVFcGd0nAVPVxDlXyTwo7ocuWd42NiPoIq190lQ2JcVKzLHTeMTDtycqTfDYUFwATOoreJvBf6i+Ek1xCn1lzBQhs0CRgGF2nLIurQQr1B58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198785; c=relaxed/simple;
	bh=Z+GfwFMc/MOyJjQtoCD1aqDv5CSi3oNDB5j4sdyJ4Rk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Wa0WWK9qsolFdu/vww3HFZ+DcPvUwCJI56W2KuyeG/pV7clBnE1idaVWUPay9dyX6cBVm2fh1g29q3US25GSAMalVt1DniyIZPEPkdtjCefGV0MmTe3BgZtJlXUKKZ+d72UM87jKRgIuwF0qKENTwrFMaK0TpR8P+NdNYXN7eao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metalaudit.com; spf=pass smtp.mailfrom=metalaudit.com; dkim=pass (2048-bit key) header.d=metalaudit.com header.i=hello@metalaudit.com header.b=MGHatvh1; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metalaudit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metalaudit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metalaudit.com header.i=hello@metalaudit.com header.b="MGHatvh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metalaudit.com;
	s=s1-ionos; t=1790198770; x=1790803570; i=hello@metalaudit.com;
	bh=YH7Iy7WdfGP/9qLa+Dj+ufSMsRFhKINU7oB5ksx89wY=;
	h=X-UI-Sender-Class:MIME-Version:From:Date:Message-ID:Subject:To:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=MGHatvh1wolgvw5zRNJaDmYvuPr4sy/aVBOLufERF6W+AeuEBU9Nxncrg1wm130C
	 tOxS82qgebR03zs8AsIDFc1ChpB25QuGbZtLKebU3iI6A9vVEY3fv4Gel5hoBV2p5
	 R0AodW6RqqvyungRLzFkpblluvOGvbVesQyVy+aZ6MNJ014BFCjIxFLqnCjEuP6yV
	 cCQcazNsZsu3noKMdpcZ0j5ZFU1lrcScWBOJMA4sD3R6sixVdrEUwh04erkGHw6b3
	 JQzmF1BBIdb+LggDeh3tVgHeWhlXWXXBTODm1Atm2BjyhY8YEHFIV36kuN54WpMOn
	 LRP5XRM2TuTfAk5rQw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1Mq2Sa-1wNpVg0Now-00aVDE for
 <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:26:10 +0200
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c20ce3c118aso53873366b.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:26:10 -0700 (PDT)
X-Gm-Message-State: AFuF++nXmByelDBec7jvZ7HbcU+jFHoVwRZrdBGPh1fGZltYIlTuLu1u
	nJKIDss0TD7FqAhg1FmK+Fs0ZURlpVvFHG/8FBVK9YFoxcNlqy1hmz3WEmIOOmMCp0z7CYI7Sci
	hcZ/EonOsvjZDv/1xvrSD+QLSHlcGwlo=
X-Received: by 2002:a17:907:9301:b0:c2a:b008:8cc0 with SMTP id
 a640c23a62f3a-c2ac2382bf4mr38055966b.28.1790198769690; Wed, 23 Sep 2026
 14:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Maksim | MetalAudit" <hello@metalaudit.com>
Date: Wed, 23 Sep 2026 23:25:56 +0200
X-Gmail-Original-Message-ID: <CAH-x+gEV9vAwYOX_kWQR4XjLbVu=M3_M8G2XP-crxUThg+GkPg@mail.gmail.com>
X-Gm-Features: AclHuK9Q4ubnU7ctkPZrhlQA8CIfTTufqdZ0zRb5mTS4bnnm0JOnrNqL5xdyblE
Message-ID: <CAH-x+gEV9vAwYOX_kWQR4XjLbVu=M3_M8G2XP-crxUThg+GkPg@mail.gmail.com>
Subject: [PATCH net] kcm: fix data race in /proc/net/kcm reader vs kcm_unattach
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/B/bkR0gmRWqx4u40BJniAMHbZa5EESs7AxT5HZ9PGsCbgBSSuO
 r7quue/aghfpby67VDTGGFUn4o2ddMOr/2mHfqcstR1mDAafXiqr5x4QKtrX0U0jscgWfRx
 o8OhJUhSWV8ewPA1HXhDCyOJevzZ++JQpijB5aKOOQ1uVCBy9afOcoz3VMNpR35Tso5nelg
 duDHY3AC/GWZOmAZU0aGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IYfr5ip9j3Q=;EZQ8+uRY1j0GVCK3wdiMaLBBSaO
 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
 vIbJT

kcm_format_psock() reads strparser state (strp.stats.*, strp.stopped,
strp.paused, strp.need_bytes, ready_rx_msg) while only holding
mux->lock. Those fields are protected by mux->rx_lock and are mutated
concurrently by kcm_unattach() under rx_lock only.

The reader is reachable by any unprivileged local user with access to
a network namespace (CLONE_NEWNET in a user namespace is enough, since
/proc/net/kcm is 0444 and per-netns). The writer is triggered by
ordinary KCM socket teardown (SIOCKCMUNATTACH or close).

Currently the race is a torn read of strparser state exposed to
userspace. The ready_rx_msg pointer is only tested as a boolean and
not dereferenced, so this is an info-leak / instability bug rather
than a use-after-free. The lock-coverage mismatch is a latent hazard.

Fix: in kcm_format_mux(), take mux->rx_lock in addition to mux->lock
around the psock loop, honoring the existing lock order
(mux->lock -> mux->rx_lock is already used elsewhere in kcmsock.c).

Reported-by: Maksim Solodovnikov Novikava <metalaudit.contact@gmail.com>
Signed-off-by: Maksim Solodovnikov Novikava <metalaudit.contact@gmail.com>

From adfd837eba0d064f84455adbb90010d8ab31a0c9 Mon Sep 17 00:00:00 2001
From: Maksim Solodovnikov Novikava <metalaudit.contact@gmail.com>
Date: Wed, 23 Sep 2026 22:40:38 +0200
Subject: [PATCH] kcm: fix data race in /proc/net/kcm reader vs kcm_unattach

kcm_format_psock() reads strparser state (strp.stats.*, strp.stopped,
strp.paused, strp.need_bytes, ready_rx_msg) while only holding
mux->lock. Those fields are protected by mux->rx_lock and are mutated
concurrently by kcm_unattach() under rx_lock only.

The reader is reachable by any unprivileged local user with access to
a network namespace (CLONE_NEWNET in a user namespace is enough, since
/proc/net/kcm is 0444 and per-netns). The writer is triggered by
ordinary KCM socket teardown (SIOCKCMUNATTACH or close).

Currently the race is a torn read of strparser state exposed to
userspace. The ready_rx_msg pointer is only tested as a boolean and
not dereferenced, so this is an info-leak / instability bug rather
than a use-after-free. The lock-coverage mismatch is a latent hazard.

Fix: in kcm_format_mux(), take mux->rx_lock in addition to mux->lock
around the psock loop, honoring the existing lock order
(mux->lock -> mux->rx_lock is already used elsewhere in kcmsock.c).
---
 net/kcm/kcmproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/kcm/kcmproc.c b/net/kcm/kcmproc.c
index 25c1007f1..cf1516b4a 100644
--- a/net/kcm/kcmproc.c
+++ b/net/kcm/kcmproc.c
@@ -210,10 +210,12 @@ kcm_format_mux(struct kcm_mux *mux, loff_t idx,
struct seq_file *seq)
  i++;
  }
  i = 0;
+ spin_lock_bh(&mux->rx_lock);
  list_for_each_entry(psock, &mux->psocks, psock_list) {
  kcm_format_psock(psock, seq, i, &len);
  i++;
  }
+ spin_unlock_bh(&mux->rx_lock);
  spin_unlock_bh(&mux->lock);
 }

--
2.53.0
