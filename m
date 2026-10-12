Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F6418348
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806688; cv=none; b=Q2uJz0nUHVXRfftcKRoaaj4R6D6mBrv0n0TuGKuD2si3OiwYzj9eMAuDeZj6C8q7DyMApdo5m/DfeEjm8QgwVoQBkt/QQREBWgacknwUl1qDojz9oHXf/uoq1l9zgcD3nLcZueNio9U/eKQ9aZSZHGxMtTfzYAN64hlpDQB1ATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806688; c=relaxed/simple;
	bh=GKuNG7l9OxY2iWSagwHzMkiUC0u2XtA1gq+I5Pvevu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S1Zs57rFbjNSQ11Youa266kB8EcSQy3tm4ivsAlHJ8ZNaMG/vWVYKGQMQ1nG1T2dGFpSjWsCtVubXNB4CEsUkzkhEZ6AACILaNO1qazKi8iMihl8izhPHd8uRZuSU95JT+z/QlAILBdwQN2gyD7qNBWX0tzpOYHw7hb4pm2wA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoTtFHOR; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoTtFHOR"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-49dd13a91d0so661786fac.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806685; x=1792411485; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YLoFk8ZNgH0gWK/445CWsD3PptLXhPGeZtskXg4vEiM=;
        b=qoTtFHORoBYic0fpSQBOZN89ce0MAwjZ6pvjUYmSWaD5AFpOyDvsi6WrtWuB+oiLnw
         +wZiDiJNtsdnPRIdKx1RA0P9opaCQpE+6eDJhr76d4emM+LtkzEjbTWqhyg8JgY1382U
         Wu5FtAemEIaVIKjSa9djioYA2rX21WuctHS2QvKw+6cGGrD1B4y3ITO3aepr1AMqoQwr
         zXN+FrrMhHvur3vfV3l25i+p6sctUVMWrvzoW9Ssfk80/mxM2/7BnwlhkGX11IBph3y+
         L+vAj3gHBFVNqBIAh1w4CBEGmy6hT7jkvZqxLXRukcBsacFPdc9BsIqvVK4p1TBxRIit
         jsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806685; x=1792411485;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YLoFk8ZNgH0gWK/445CWsD3PptLXhPGeZtskXg4vEiM=;
        b=iMcIbvoao5nbywPAEgbnSjZo4wAYcS07W5rtQZm5rQHOXaxeZe/Af7kTawyL/796fQ
         quAvefGXyFlb7+zmD0nizlQWf3FsIK//Qap5+kEhliRZR1ngonnMYN28xkSfeonmwbIC
         ZS2zGMgOXhQUW1QeSzRdxHlxZo0foJvHeghDTIZXbFtazSICpad/aNzaovUIVSsZ3hJa
         PlKzr4bexBNz+gTk/swh2lYxY35NarctDuYtw+1VyNTgzmTqBvJ7dTrTSnkvvFDh43Jp
         VuyG0mcfsyF6hV0QXwsTOtkUZgG3CS3ytdEcjlCnzs2kFjRfOi+ZugM9BrhopOZNeiIQ
         BQjg==
X-Gm-Message-State: AFq9FYKjmD342SphIlvSVB1NhV53gsq5jGf7BfXpzyWlsSTv50/3uy18
	mNCs95L5G3IUCDqwYJNXUOjHkj2wme4BYuTZIYPd0zcJVwUlywt17+tf
X-Gm-Gg: AYBFou3xN0ad+fqXsKYt1EYBs6QPUwZUaB00TZtMbWgAYOzLDLQbj3zyEPJjQ/jMOW5
	oq2nmaR0b51MnAluClJLL0pQF9BTkDYibz+9Ww39Lr1RTyRQ/ldhS1Jud+mGyc3YIYKg9KuizeS
	Bqyy/8KfeLdhKOA0rhcp2VTQMADKvI4boEF4JpcR0nox7P87XH0AY9+4OQWnpvCnqxKvcOtCKTY
	Dfl5+lA0MNA3FJX31LwjuW7s4dZIhdS1F8BSNFaiLbTnnnA87s69kE65fy5tFGoMt5buDrfFiYt
	H1iHQqwyLm1QzrNjta3C4SZLDV/FSbDOfepOBhfK5rFUVuM7hqjk13r8wOwu1bm5z3lS818BaNx
	kzWjNzAZXvnG2dvyiaHWTHvFSlOOudbWOBaHqDyDozYjpd3wh8tsnZW60AZ7HiAHLibuEoz4HAS
	JFad9PYL9D11yTdZEcfhISJwzyjUql64HV+YqMhsCBUQ1SVvJJlG9Urg5ad2iGWFTiIQb4
X-Received: by 2002:a05:6808:2206:b0:4f8:4a95:9969 with SMTP id 5614622812f47-50c4e681aeemr8213477b6e.15.1791806685325;
        Mon, 12 Oct 2026 05:04:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1815fd26sm11497645b6e.10.2026.10.12.05.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:04:44 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next v2 0/4] eth: mpnic: add basic netdev statistics
Date: Mon, 12 Oct 2026 05:04:33 -0700
Message-Id: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHMzGoC/2WNyw6CMBBFf4XM2jGlRR6u/A/DAocRJpGWtJVgC
 P9uQ9y5PDm5524Q2AsHuGYbeF4kiLMJ9CkDGjs7MEqfGLTSZa6Uxmm2QkjubSP7YLBXdV2bR1O
 aSkNazZ6fsh7FO1iOaHmN0CYzSojOf46rJT/8r9r8VZccFVY9VWVREF2Uug1TJ68zuQnafd+/5
 Iww8bgAAAA=
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Add basic netdev statistics and report them via ndo_get_stats64 and
netdev_stat_ops.

Track per queue netdev statistics such as Tx/Rx: packets, bytes, drops,
etc. The driver keeps per-queue state for statistics that is updated
mostly from the NAPI poll and ndo_start_xmit paths. The stats are made
available through the usual driver APIs.

When the netif is transitioned down, the per-queue stat counters are
folded into a global per-device set of counters, and then when the netif
is brought back up, the per-queue counters start counting again from 0.

Extra care is needed for implementing ndo_get_stats64 since the instance
lock is not taken. When ndo_get_stats64 races against ndo_stop and
ndo_open, the reader can attempt to read per-queue stats while the queue
count is changing. To deal with this, the writer publishes the
aggregated base stats and the active queue counts in a single RCU
versioned object.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Changes in v2:
- eth: mpnic: count packets, bytes, and drops per ring
  - count Rx frames dropped by the driver in rx_packets and rx_bytes
  - disable BH instead of preemption around the Tx flush stats update
- Link to v1: https://lore.kernel.org/r/20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com

---
Daniel Zahka (4):
      eth: mpnic: count packets, bytes, and drops per ring
      eth: mpnic: report per-queue stats
      eth: mpnic: count Tx queue stops and wakes
      eth: mpnic: count Rx allocation failures

 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 182 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  29 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 183 ++++++++++++++++++++++---
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  30 ++++
 4 files changed, 406 insertions(+), 18 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20261002-mpnic-counters3-d08883b96372

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

