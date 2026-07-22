Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6230BF69
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729871; cv=none; b=t37xJme7t7bc8FIxFp520y9c74YrK0m2+bn+ikUPVX9RqT02VCuyr94nh8SzSCc0U5YQbFhEQm/BXrkka9m4iJYPLgMyEy+E9qBHxyuX+YArZbRuXa6ZPnw74Way3+h04LRMZRCoMcv5/2g5Hr/hWhaFwNlAkQdTEPy1TPwPcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729871; c=relaxed/simple;
	bh=+1qy2IJfveVfijowPzyLUvNqEYmmU5/CslMiUaTPM74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eKxvTX1VkClQ5canpN9WyP3GivZTGkK62ngtVSeOJmLAyV718YnH/ipthoH51s0ALfTiQgS03+RGoUHEdt5ubxY1Nouc/xd5TG8CihUB3w3xc9pXX53xx4LWsZUUO1feb6Ez5/3qfm5OUyaUAoalH8yq4jfj+FIr+anyOSqkxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmGgAlVB; arc=none smtp.client-ip=209.85.128.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmGgAlVB"
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e85096e65so59004417b3.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784729868; x=1785334668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqJ+oi02pmXIuiCQFHznDizJFFec00PwaQZM7SZO75Q=;
        b=SmGgAlVBEBP1XOX5xiDsaLjj6CKs9v5g6M3FK8AGIP9s3JJYXN5a8LCM5wqcvCHns8
         95roSMYsQYg7sTvu88Ylx+wXTohGolKghN/+l/EO/pyo3DGTF4ofD2YYxKMhzKr6lfmX
         ribNOHZdZxOulpuNqRLcTxvGO7BAO15fZ02CWYXCmZ4hRO7FehlCOt+dfC786FXo+abg
         nBofbOVXteW25iKDab/ruhQZSavc1f7+apdJZ5aj78/+jEo1CR88CFoEFPuD8M26w9fr
         wuj2SnSxe0F7G41yRZ1wHMnlvNRSXijYohxoiJdN961CC7/+PQhJa9R/fZ3oBdFsbpO0
         Zm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729868; x=1785334668;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqJ+oi02pmXIuiCQFHznDizJFFec00PwaQZM7SZO75Q=;
        b=sPNbIWt7f9ctXer0VofdJZacKgT2Kavz2pEKFqdGnAG3K5dCpcMvO0mDQzP+/Xd6wj
         8nHTSTlIlTwTtzCW44goqHINUfVsSQdmqMat1y0zmEfn7JD4qICvuHFn7T68PAiIvObn
         eyszLb0r8vOwVBSoUaaJpIcb1OqtV9v9aajvJusj6dxbSY78Wgh1uLufsFJbhcSp0vNf
         PDQhUAjcVO9hgikE38IYEY9cI4D0+ZSKy2q3TbXlf4CLH1qVNzuwdXd3Tw6ST6oOMdDo
         FQHfaN6b9HMivKUjPQMHFAKe05aEYDX43jw2qv25JBkU9F6/Thw6nxSr9JzglQqRUuR0
         73tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0TnbnCjL0HSkTBdZwYUK2ndMV0ZG7rGJls+F0VOB9yWnus4vhGwUGAnFDKYki4e2oC9Apji0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kzqyyOAj+JuYtCHNlzCFjpBhzV8F0pP7kJQsfuOI1oFOY346
	HstpC6t0EAGn2QcLa08ehO/rdt3WIvsZh2Qvb4/t0k595LSzmNiUi+2bOUpdfOX4Cc0ln+p72Es
	UDP7G0jMs24Kj2A==
X-Received: from yxfk4.prod.google.com ([2002:a05:690e:284:b0:668:2560:60ab])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:d105:0:b0:668:1c09:aef1 with SMTP id 956f58d0204a3-6683bb2e9f2mr4713069d50.6.1784729868092;
 Wed, 22 Jul 2026 07:17:48 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:17:43 +0000
In-Reply-To: <20260722141743.3266924-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722141743.3266924-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722141743.3266924-3-edumazet@google.com>
Subject: [PATCH v2 net 2/2] drop_monitor: perform u64_stats updates under
 IRQ-disabled section
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In net_dm_packet_trace_kfree_skb_hit() and net_dm_hw_trap_packet_probe(),
u64_stats_update_begin() / u64_stats_inc() / u64_stats_update_end() were
called after spin_unlock_irqrestore(&...drop_queue.lock, flags), when local
IRQs had already been re-enabled.

Tracepoint probes can execute in IRQ or softirq context. On 32-bit
architectures, u64_stats_update_begin() disables preemption but not interrupts,
relying on seqcount writes. If a nested interrupt occurs on the same CPU during
the 64-bit stats update, the reentrant seqcount update can corrupt the
seqcount state or stats value.

Fix this by performing the 64-bit per-CPU stats update before releasing
drop_queue.lock via spin_unlock_irqrestore(), ensuring local interrupts remain
disabled during the u64_stats update.

Fixes: e9feb58020f9 ("drop_monitor: Expose tail drop counter")
Fixes: 5e58109b1ea4 ("drop_monitor: Add support for packet alert mode for hardware drops")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/drop_monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 5d63cf2c230b4368e8a84e52413d37da26fb279a..8800a21ded084025bd1a4e5365de9971ab660808 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -530,10 +530,10 @@ static void net_dm_packet_trace_kfree_skb_hit(void *ignore,
 	return;
 
 unlock_free:
-	spin_unlock_irqrestore(&data->drop_queue.lock, flags);
 	u64_stats_update_begin(&data->stats.syncp);
 	u64_stats_inc(&data->stats.dropped);
 	u64_stats_update_end(&data->stats.syncp);
+	spin_unlock_irqrestore(&data->drop_queue.lock, flags);
 	consume_skb(nskb);
 }
 
@@ -1001,10 +1001,10 @@ net_dm_hw_trap_packet_probe(void *ignore, const struct devlink *devlink,
 	return;
 
 unlock_free:
-	spin_unlock_irqrestore(&hw_data->drop_queue.lock, flags);
 	u64_stats_update_begin(&hw_data->stats.syncp);
 	u64_stats_inc(&hw_data->stats.dropped);
 	u64_stats_update_end(&hw_data->stats.syncp);
+	spin_unlock_irqrestore(&hw_data->drop_queue.lock, flags);
 	net_dm_hw_metadata_free(n_hw_metadata);
 free:
 	consume_skb(nskb);
-- 
2.55.0.229.g6434b31f56-goog

