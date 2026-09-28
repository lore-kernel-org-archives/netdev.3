Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771A35201A
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577776; cv=none; b=S9L7kpmr2DA+RF4D8MBRpo7euMUmD7GmtoTIPgxFDWfx0gypjYeULGZu68B7KUBF+I72I28nyduX/PEhcHXlZLUvrSABP90gX6H8tP5BFD9efFAxchqQcx+N6K3SzeA8lM2/eD4D1LjRjS1bjnvDZ41lI8snUm6M1/zPX3eCBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577776; c=relaxed/simple;
	bh=7MY9g1VCfYcNl1oUjPGni8Xlg1seVgLJlQYJCr77j3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=imG1zllud7pFUgDY++X4QuK9Xmy8RYOJjELQ2YVztzLa1pWQE1wRYON/asbYl022L/8Wo6XgksDUu1QhL3XGgfnQf/CzX9pIeiL2PiyyKtwdmwCgHXLIyMKUClIx56btesEOSsQtj1mIyJrr40h+gufbmWFAtD41mrZRIC3LvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa5Nzwlq; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa5Nzwlq"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b926f0so1474393f8f.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790577773; x=1791182573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=knKV+ty7Rl97pUKjME3IBtkaEdWWVK7KKAJhTAdQER8=;
        b=aa5Nzwlqln8fPSTMu8dM/uCWK2R337IIkaWtyKfpKEeaG7WxSO+HOrh3HIu4ubeYAS
         Vq4Oj5TOcd5guWzxS/oUmtHTm/V1ZFj+cEG/bq5/87Vk3hpS98b7knDpQJSk0BZWFfUe
         N6iDkdldCo2Q60N1v1vOHyPNy5HZEh7imFuo4zTbI1fuQy5ON7ESe8Nu2yxp44QZYF82
         yrGr0KKoLmyawqb8t8zIMHVLz8BORkwkNWZ0O2pINzPyv5V+CdkW/tm5k7P8NdrSPpmr
         guo1AqxZDd8sffU7gQpIx/b+RGclx7+hhCVQLyH/Iw1ybO2O6fRTCqKwgBekFYJz/kqK
         jiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577773; x=1791182573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knKV+ty7Rl97pUKjME3IBtkaEdWWVK7KKAJhTAdQER8=;
        b=xmO87SNKjviRXNjgcAK3GgF9xS7mTqNdA58JAFAW9RWDBWWeOx1J7IGzpD/91Rco1O
         WV1pQ/PnXoD/yLjCh8RQH8N3dVePU/qLqz1uVX90vC9nVIoJJJ7qBDXzmgYrFaPRydI6
         VhnwzeHdKUl1GvzyryW5tmHycOc1kUyzzdvj/LfJq3S+g6U5AHRBFMgyY4FXZ3428Gqe
         5+9dQK6t5In7oLTbr3ZzHmrNWNC6krv5zvKHZUcgOwCT/urYNZEAP4Emog+oDjwY3QcW
         aoDbivHeTiy9fs8gj6/jkREACxcS7PNS1YRKbx14WIrq1NkdghBJweGCGi9rLyWRV9fk
         bg7w==
X-Gm-Message-State: AFq9FYKJoo6goH+Jq8Vz4hGjL9FvxQB/6uXyGKgBEd+lGBKbpUnFIUY1
	yR1457mXtxYp/XXA1UkaxdDSzEvRMhmQtT3fBgjoKfzUCsb+SSCsppZLiAy4j9eU
X-Gm-Gg: AYBFou3fi3fxYXLwiIXhTdLG7ttpilgRRQ+GNVDOGfne0STsXIZkE2bNQ4UARl8Cpd/
	1yWuApttZKXPAd6tJ7/9rRC/+TYXtm3GOvXCKLoYPC/kJ5dY7ySHsiylMEtmi3NNwVoZ+gp0lGE
	U6TdV83Eak/jic33/BibUJtKSM6+Gj58VAUCad5+krmmincCaqiaNZv1RCPX0ZaEUrM8Onk4LDW
	vtbc8Jpl0C/RFkdT2rNl81JeBx/yB/U51LBtdlS8QfaSkoJs1S9AH0ug9IKV8pMCBKJMhys9/xm
	PuOV4Nk0nUmAq6JpofLO/VDJs+s4yt73GGqYQq1lrh0LnPhHR9xlWcAlYb07PgdftwTAk3m3FqT
	6HmdOLHTJHzSlPqt2dKyYZ8qvjVMhDIutrvbrNoc0AiPgj67it5mvc6v3U5+Hu6wkZv4h176n6V
	d2K8KNZrIBadIu2V36JEhimdL54+QAnSqgRpXOvCvMaM4wmG64w1d2uI4r7xIb9rQsovY2ctuvy
	Zu42a+kNEAgKO2GTjY+eJ2j+62DIds0q4KSC9MVnVX2fVMntc0FysWHzmMKKPvbxIbnpNjMpI5V
	fWJdPCO7jJHzf+IbqKNpLS9J/wy1aVdzMLcpVEKkMswIj8rPlrZ1kLgryTjRDW6nNjuGQ3hQnJs
	+ALVa7g==
X-Received: by 2002:a5d:5f49:0:b0:487:490:8391 with SMTP id ffacd0b85a97d-488717252c4mr22421127f8f.16.1790577773176;
        Sun, 27 Sep 2026 23:42:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm26283196f8f.4.2026.09.27.23.42.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 23:42:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 0/2] netpoll: fix PREEMPT_RT deferred transmit locking
Date: Mon, 28 Sep 2026 08:42:37 +0200
Message-Id: <20260928064239.32456-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll's deferred transmit path can acquire two sleeping locks with hard
interrupts disabled on PREEMPT_RT. One is the sk_buff_head lock used by
the sender and worker. The other is the device transmit lock used by the
worker. They produce independent atomic-sleep reports.

Patch 1 gives the deferred skb queue a dedicated raw lock.

Patch 2 makes the worker try the device transmit lock and defer the skb
again when the lock is busy. It uses the queue helper added by patch 1.

Testing:

- Arm64 and x86_64 PREEMPT_RT W=1 builds passed.
- An unpatched Pi 400 emitted the queue-lock report five times during a
  one-hour run. Ten boots with the complete fix passed, including one
  3,606-second run. Every trigger and post-trigger marker arrived, Wi-Fi
  remained usable, and neither atomic-sleep warning occurred.
- An arm64 PREEMPT_RT QEMU control reproduced both warnings under forced
  transmit backpressure. Three boots with the complete fix passed.
- An x86_64 QEMU control reproduced the queue-lock warning on PREEMPT_RT.
  Three fixed RT boots passed. The non-RT control and treatment each
  passed three boots.

Karl Mehltretter (2):
  netpoll: use a raw lock for the deferred transmit queue
  netpoll: avoid blocking on the transmit lock in queue_process

 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 83 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 7 deletions(-)


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.53.0
