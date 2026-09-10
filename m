Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFC3368B0
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073183; cv=none; b=u+o3tWNlcOv6WyexFFO2O3FaEXWSgw8Hg5vlSbqsih2+E7N1EpjscD7OlnCLVpHX5WqgyaFqn4vCnX9NnjbxK8AeUOjmGYbS7T5iwXJuXnuezaJq16LawjvwN7lpst3DAmTZNFStliAp/WjbyI4Bt7KY7tapAkjlFcl6EnwhFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073183; c=relaxed/simple;
	bh=kmuSWd/1ydVs6OE9n/Y7WU5KlI6ep8yAK+V8OCRxJCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tGb+/Tjini0jzoVXLrJN4MiQDfSCq3dkHYpWTAaI1O0hclkA+3QakNRCxAdsAXKiv1O7i6aX/lnkFwtXQceZChUVyYtjG1dbbg568IxgpvJuwL7cBlmNKaDEWOEWRp+wAPS/+firmsUDelEMPqM+m8GfnIRfwepfA1dafnXt3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fab9wptS; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fab9wptS"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939c30aa9a0so11904385a.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789073181; x=1789677981; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3svSRuyti4kjFy8zqW0rCqlX3MYbsYaJDGRoFr520sU=;
        b=Fab9wptSUtsW0g2gznX/IWXu8lEGHp0R6+AU7/6mT1Zfz386MzU1jT86oKuqvld5uj
         EMtY0Me61zruFBmyWBV8zRwmQNfwpK1jTePfWcKCdpx8bglvsSIxBIeTgijfDEF+eX5V
         RxUtweI+eiLXrtYHAPKrOtatFVi4amCMhdJpf/f9rB2gb7b1bJr6QUELE+86cGc50n8e
         GIQ7n+x/eHsZkqpzPKRke76HjBR8ov9QdinrxdfZDr2IW4hXPdDcJr7K824IxHA9i+KJ
         oOBSAT7vdb8vhyIWljUUzX2jx0TY9/h8jK4Y9ekT5Ji2rUPhmGcoyyX0KSlz8e6ok3bO
         mQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073181; x=1789677981;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3svSRuyti4kjFy8zqW0rCqlX3MYbsYaJDGRoFr520sU=;
        b=d5/TqKDlHRwQ0E91Oa5muncN3Ns8uhOtstUxSWORS1AeHLVZwD8N1oeWhf12bgvHVJ
         CFGTz/4i9jb/IDTYDGbKq4b73NTRFj6uUeE4d/4n8QaJ7pVXsyZC003tCQc4B+EWwzdL
         J3V499oIPmr10BHytJ6vh0vBVcpgOxf2/7jc9ha6mhbuIU/lQJnTVM/4H8a9g93mhtgS
         1bpmZJpxY7UtvcPxWnrY2f8BXwFALz5rD41do01lq+7y10DRbTS0ASroTWuHutKS4jUq
         RAYIUSaLShR2B4rDaY2W/6KecbkYLQqwL6BTmFbLRzR3w1i5C/wcfJ3WnYjnqlhlnB6F
         S0cQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlwkEeFO2scVKvIsxoUbu4j9wPjiXrqgLly7AEC2HKhPxDNpq6FpG66xK40NZF3afKxsfpq7g=@vger.kernel.org
X-Gm-Message-State: AFuF++mvVwmvaM02uW0dosTSKFJ9qU4u59WozWnAP83wYBbnVWwvasGe
	fGlfvG5c2/8kfZ/4nLFQJ9r76F/6Iz0tkt7wQFFwd2cdGitTlU+IbFPHRv1Cpu02qYt9c+kdRZg
	XTGJyLq1r3ZnUtQ==
X-Received: from qknvu12.prod.google.com ([2002:a05:620a:560c:b0:939:d2bb:5a1c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2b8a:b0:939:c116:fdd4 with SMTP id af79cd13be357-939ea2045a8mr93980685a.31.1789073180529;
 Thu, 10 Sep 2026 13:46:20 -0700 (PDT)
Date: Thu, 10 Sep 2026 20:46:11 +0000
In-Reply-To: <20260910204612.3762015-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910204612.3762015-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910204612.3762015-4-edumazet@google.com>
Subject: [PATCH net 3/4] drop_monitor: use raw_cpu_ptr() in tracepoint probes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+dc57fd6722deb17e92af@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a preemption warning in sk_skb_reason_drop():

 BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/5917
 caller is net_dm_packet_trace_kfree_skb_hit+0x119/0x350 net/core/drop_monitor.c:519

In net_dm_packet_trace_kfree_skb_hit(), data = this_cpu_ptr(&dm_cpu_data)
is evaluated before spin_lock_irqsave(&data->drop_queue.lock, flags).
When kfree_skb() is called from preemptible context (e.g. process context
during close() on /dev/net/tun), preemption is enabled, triggering the
CONFIG_DEBUG_PREEMPT warning in smp_processor_id().

The same pattern exists in net_dm_hw_trap_summary_probe() and
net_dm_hw_trap_packet_probe() for dm_hw_cpu_data.

This is a false positive because each per-cpu structure is protected
by its own spinlock. If the task migrates to another CPU right after
reading the per-cpu pointer, the lock still safely synchronizes
access to that queue.

Use raw_cpu_ptr() instead of this_cpu_ptr() to silence
CONFIG_DEBUG_PREEMPT without disturbing interrupt state or breaking
PREEMPT_RT locking semantics.

Fixes: ca30707dee2b ("drop_monitor: Add packet alert mode")
Fixes: 5855357cd40e ("drop_monitor: Prepare probe functions for devlink tracepoint")
Reported-by: syzbot+dc57fd6722deb17e92af@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6aa316b2.f81106d8.2ab401.0014.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/drop_monitor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 873155ca72432924322bb7961996dd3430d052bc..795c15dd1771a2a5f15e109d0ef2eed967c45443 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -448,7 +448,7 @@ net_dm_hw_trap_summary_probe(void *ignore, const struct devlink *devlink,
 	if (metadata->trap_type == DEVLINK_TRAP_TYPE_CONTROL)
 		return;
 
-	hw_data = this_cpu_ptr(&dm_hw_cpu_data);
+	hw_data = raw_cpu_ptr(&dm_hw_cpu_data);
 	raw_spin_lock_irqsave(&hw_data->lock, flags);
 	hw_entries = hw_data->hw_entries;
 
@@ -516,7 +516,7 @@ static void net_dm_packet_trace_kfree_skb_hit(void *ignore,
 	 */
 	nskb->tstamp = tstamp;
 
-	data = this_cpu_ptr(&dm_cpu_data);
+	data = raw_cpu_ptr(&dm_cpu_data);
 
 	spin_lock_irqsave(&data->drop_queue.lock, flags);
 	if (skb_queue_len(&data->drop_queue) < net_dm_queue_len)
@@ -983,7 +983,7 @@ net_dm_hw_trap_packet_probe(void *ignore, const struct devlink *devlink,
 	NET_DM_SKB_CB(nskb)->hw_metadata = n_hw_metadata;
 	nskb->tstamp = tstamp;
 
-	hw_data = this_cpu_ptr(&dm_hw_cpu_data);
+	hw_data = raw_cpu_ptr(&dm_hw_cpu_data);
 
 	spin_lock_irqsave(&hw_data->drop_queue.lock, flags);
 	if (skb_queue_len(&hw_data->drop_queue) < net_dm_queue_len)
-- 
2.55.0.1007.g17ff1f9808-goog

