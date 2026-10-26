Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009153;
	b=QPK1DK37nCblVHKLZ0Ce3VVCT9X5jA6UGitHNZs7LXTpDo3weh1BobUYVSkbA9LOI5l5
	 8iETGjozbVThP4XzmvTsTRSUDUoYXzGduoJ3XMbwPp2Swrj8Z/L52yvBJ443wV1GvTr5F
	 AEkxPtHCuUGLGdtHoitq0n262eyrX/t1SytiApFA7cFdlXv+q47c8V4GbisJEdyRqn/pB
	 YO8dHCCTF6ehYYRBICgZBLDhpfdXkRb9Kr4MtW7uZc9vwZ5oV+g5ufBtM6kOGvQ7RD3zp
	 NESuZXkn0zTUxHQAMMUv7fJNUejJSMqJekR2awYyX5wAmBn6XpX0hMZnr8ouZOijd+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Gm/vkZ/TPKkcuQ8IJYMQfAw8BN32mGEm+OiB1P+AHxg=;
	b=XyAwOPcd55WNn7wfIgKyyNEQwQZ7s2btZ5lGKtuIOKLB4qlAWKEoEmjGuTi0shG6S/Bl
	 j4W7fJ7Lmi6crGv7AN0zy2AWKsSYH5dcK2Iy9fp57bWk0+rFIh44fgnciIgXgBfBaTIRi
	 v1HiNnuEJghPuPT9x0LLiGggqP+UMomOxTWanY0c/nBHTBCD2ct2MxH06BHyoUPkQkrVZ
	 oxX0muJC231HlgKcR7m4xMOslzmWZVAvhe5IkYOFi8+D66rnMKGqMfdfCrYUwPQX4LcUv
	 A0rYjagB9cYcYX5+fOnVed1gR+KXwJuxzRX51GekCyDXFaR+LQc+tV1IiizqmN9DfqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oGltNea8;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74F606A33E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD74F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oGltNea8
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e608cd460eso17496105ad.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009152; x=1793613952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gm/vkZ/TPKkcuQ8IJYMQfAw8BN32mGEm+OiB1P+AHxg=;
        b=oGltNea8Icpks0AKShXXj02HZ9E927nFFfMwJpBRbJKt458wbXwSFBWWA3+ghZw51E
         vAqvMNSIm+aJR5miw5r+rD46K2/d/dLNahVUsw5BatL/CY6yKy/VK3/v7lvIwdYP6Ncv
         2HT6AupXt9ynFYBu9eLulOEkm+OgX1tOE3r2peQ4oxqubYTuOFjWpxRbcTe44ySoxVsq
         Dwa7R+baX9Qj2Gz4dQnI4dqy/BQ392ZtfmWA5pGM61MCheekfpKiVQ4VG4rdGApp3+xr
         1uJESliw7mMLBpst5JWXhkqgGWWWl6wZVtxYFgUGC5oYVY7oMOEffn8aEX/I8WlA+F7W
         /vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009152; x=1793613952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gm/vkZ/TPKkcuQ8IJYMQfAw8BN32mGEm+OiB1P+AHxg=;
        b=YVq/pYOKUFNXYMMjm8JKr82SLa4I8hM/ikjpek8OkU/aSMHvef/egSIz7itKF+X0dr
         SyAN+XerEh34JcQtWUV5ITgh7Xlmgcc/on8UFtb9Rw1tUsw8xARB9LlZK0SNra8GZ+mX
         bsxeEIfy2cQlLUxQeUA/8V34c5m0rdnuZBHU8W9LACJzDbaTXxd+BRDsW6gk/DJfSGOE
         9XNCwNgz5bxbERtyo6l2nSVIwPleX0UHDUZsngTP6F5q+PdZ69nrxOLbkbJ4M9UpkYlY
         geWMkggT8ZmBuKCK1jL9oFuq57adcQgxS9QEXZf5kaXrA7HfH4JCWpCherZ7Kbz+1Ffb
         AMHw==
X-Gm-Message-State: AFq9FYLlNimZrq9u8Jzzk4LFPyxqoYd4emhA73CdW3LvB/ZLnQCKoq6t
	GiF7PrR8qrKyK0YAM6LMjJDKVXfcG70opUQVU5+eFUm0XH6Ut58VaKuL
X-Gm-Gg: AYBFou1RegHkCTA6g02UT+1YelUJ60ssHhs7T0RMaG+Q/ZrMWfgfi/1CpoI27HQeINa
	QW9i3jas6N12eSBeRPgkiBzqW72H/jq1fQwOMR6NagNVkbzEcv43df7GjuaHt17zd5Pn71/RFUO
	uvwCm4b0ICSNNYphbmY4fwsvEN7qu9ZcncVh4T8LnWfIzqSxA4AqXTo97iHNASjF3ofcBkaM+d9
	duDhYZ2yzWqwV034y+pu7mBUvy/3v/pzs+zT4El/D2dh9OaJGmrXk4XVNnmEzlJAQo3Nsb99AX4
	X9Ix/IBOCM5VzArivoOSbi/eHCiydaqFtH6J9o+ekHI8TKNG7lxLElEN/di9vEoQeCe4aL0r1OY
	Y12QCw44W1UWnUhZ/p7PeshY/j7FQD1ulCa26vesIw4iq+bMXkyLgiAm2tp5+DfKK9m8CV3b+uw
	HQySG9lcPJVG7Rwvgh8m4+vxsWL7rLLRODFLjq9wzA8nFIyarh8BBKmPPlqbRzpBB83lYMPVjM3
	8/okfngGqW6WU5EOew6pfhRn6LSwkZbcr+D2OZimEoNTz56XWwvIIDuyoCqYG5/lAZz2234Pgu3
	b/7F2NZUAqh2U14/t4M+5SWec52o2Q+1HdlqqwAuHv+VcZEze4I++bFQPZgTaGJgG1wgRXwTtgX
	DdLwrpFiwI965NOKb5eRgt/BgVK7v
X-Received: by 2002:a17:90b:224b:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3adeafd6bc7mr4882037a91.53.1793009152103;
        Mon, 26 Oct 2026 03:05:52 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb83b35esm4837686a91.0.2026.10.26.03.05.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 03:05:51 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] ptp: fix use-after-free in extts_fifo_show() reading tsevqs unlocked
Date: Mon, 26 Oct 2026 20:05:35 +1000
Message-ID: <20261026100535.68114-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

extts_fifo_show() walks ptp->tsevqs with list_count_nodes() and then
list_first_entry() without holding ptp->tsevqs_lock, the spinlock that
"protects tsevqs from concurrent access". Every other accessor of the
list honours it: ptp_open() (list_add_tail), ptp_release() (list_del
followed by kfree of the per-fd queue), ptp_clock_release() and
ptp_clock_event() all take tsevqs_lock. extts_fifo_show() is the only
one that does not.

A per-fd timestamp queue is appended to tsevqs on open("/dev/ptpN") and
removed and freed on close(), both under tsevqs_lock:

	scoped_guard(spinlock_irq, &ptp->tsevqs_lock)
		list_del(&queue->qlist);
	bitmap_free(queue->mask);
	kfree(queue);

So a read of /sys/class/ptp/ptpN/fifo running concurrently with a
close() of a /dev/ptpN fd can have list_count_nodes() walk into the
queue that close() is removing and freeing, dereferencing freed memory
(use-after-free) or a poisoned list pointer.

Take tsevqs_lock around the list walk. The fifo only ever draws from the
first queue, which is the registration-time queue created in
ptp_clock_register() and freed only in ptp_clock_release(); that cannot
run while the sysfs attribute is being read, so the dequeue from
queue->buf under queue->lock may stay outside tsevqs_lock and the lock
order is unchanged.

Fixes: d26ab5a35ad9 ("ptp: Replace timestamp event queue with linked list")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/ptp/ptp_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index dc398c6..7d09256 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -80,13 +80,17 @@ static ssize_t extts_fifo_show(struct device *dev,
 	size_t qcnt;
 	int cnt = 0;
 
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 	cnt = list_count_nodes(&ptp->tsevqs);
-	if (cnt <= 0)
+	if (cnt <= 0) {
+		spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 		goto out;
+	}
 
 	/* The sysfs fifo will always draw from the fist queue */
 	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
 				 qlist);
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 
 	memset(&event, 0, sizeof(event));
 	spin_lock_irqsave(&queue->lock, flags);
-- 
2.43.0

