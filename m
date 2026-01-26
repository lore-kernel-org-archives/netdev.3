Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB9271471
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438789; cv=none; b=RUv9UzsXgtq4gBunKlT11DMbbPFYon8LDWYtVHRWAxSU6kkiHZF4V/bxqwWJTBkKHqdnNU2X/3YLtu/VimK8tv52R79W3pQ4tnIZNDocynnnkl0n+218HrWeuz9tiDKOTHBRvu8Afzz9Khq/pQnRB75GqD7U2PvlkKEtfBz1odA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438789; c=relaxed/simple;
	bh=mfnvwEVinwQcLoRmbP07RppW4AQrQqar1hRNwrdvI7s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bQ3MUWp7spf2jRfZvs7QjhRmQrfKsJo4e2n7jUHm1dg34YxfJB1rQiNMhZu3vVLXaAq+mXwScwrJ164J37d/vq1GnFLhvfCl2n1h/Vs1iGru9adjAJIjK7s6pkSUnMgz3m7Shgc10kxxR7q0goTRnRC+q7NliWX6xxkoxQpR1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHAHTHgK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHAHTHgK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29f1f79d6afso48481605ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769438787; x=1770043587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tOoCJ3J/mhZhm6qNN5V8ECkie0PBrx5I+GgAxlTdJmY=;
        b=BHAHTHgK8X6kXqW5H+UWQVK0rXfQ/RlMVkBBoUMT11diM0nsPmG5XErpjXV2l2MWQB
         NAF+WNWlFoAT9iC/EM59jsjlvGg87WPNIvwW0ehKw+w/HA4qGbh4uN1nzvVvwcu/3Ic/
         k3IiPcalST8/YWWFS69Mh75QeCHYbaUtD0/d7wdpbKSHl8tNsavOJI80ptGrS7GmNQ9o
         drMSEoCJIf5jidQsrGXmBFxGMwsBo5qeHKsDrHzdU+EcqXgCyvdn4k7B5Mgz8Qpg1Spt
         5F2sv4JPQVnzWZzjo03nzW+l1oWuG2MeIJXAB+Rawl7CpQM7kGUA4KEht0qD9eco3p43
         6WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769438787; x=1770043587;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOoCJ3J/mhZhm6qNN5V8ECkie0PBrx5I+GgAxlTdJmY=;
        b=JcYFRcylRvAdlIz2AA0dLSyhVlGYDjr7pg71ma1EmwZai1qFurvZ6HEAt9QVjOtFx7
         wdQfbumUyUXohSeN+LJoJctc0KrYxZYvvKBm8GklblqJ2AEI+j4As6zTd6eI/AvLHEDp
         gIzsYjJNnk+zh+tEKehbxF+PbZAZWz24x6xxeoSj007KXBzlAgbPGmgaaUEwMMrxLpdZ
         Meg9ba1cRjCfuqoffshjN84x8ermFTYbo0lpBNmHGs/7P5ktjDEAdFA5pIttkUFETVQq
         z5KmXPwbS1loIzpx7pkEawx7AIMRuChoT/0tj1uxoe4hG1N+sYoeSOHWRlKJwZJIQcf4
         vcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc9yYapDmRtRQKowftoH7GfS/rjdZ3vWiXxm+ThUMfcvvldtQMT9/cCJQ/IVo9fRMtQj6Mmwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGomK1e6qeLTHChq2Q7EeJimBhIpLmHsOmT365PXJ3wy7UDpN4
	whUDdkPc1pB7Pv6UlzqJ279hY0kl2P/X+iRWqw/pqJuNz+AecF1F3ozX+QObZ5FDHvgHERatV/t
	w8EAVHC5XAA==
X-Received: from plov11.prod.google.com ([2002:a17:902:8d8b:b0:2a0:b327:1816])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cc:b0:2a0:9d16:5fb4
 with SMTP id d9443c01a7336-2a8452310fbmr45605755ad.18.1769438787122; Mon, 26
 Jan 2026 06:46:27 -0800 (PST)
Date: Mon, 26 Jan 2026 14:46:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126144624.2319784-1-brianvv@google.com>
Subject: [iwl-net PATCH v2] idpf: change IRQ naming to match netdev and
 ethtool queue numbering
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Brian Vazquez <brianvv@google.com>, 
	Brett Creeley <brett.creeley@amd.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"

The code uses the vidx for the IRQ name but that doesn't match ethtool
reporting or netdev naming, this makes it hard to tune the device and
associate queues with IRQs. Sequentially requesting irqs starting from
'0' makes the output consistent.

Before:

ethtool -L eth1 tx 1 combined 3

grep . /proc/irq/*/*idpf*/../smp_affinity_list
/proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
/proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
/proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
/proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
/proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3

ethtool -S eth1 | grep -v ': 0'
NIC statistics:
     tx_q-0_pkts: 1002
     tx_q-1_pkts: 2679
     tx_q-2_pkts: 1113
     tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
     rx_q-0_pkts: 1143
     rx_q-1_pkts: 3172
     rx_q-2_pkts: 1074

After:

ethtool -L eth1 tx 1 combined 3

grep . /proc/irq/*/*idpf*/../smp_affinity_list

/proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
/proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
/proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
/proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
/proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3

ethtool -S eth1 | grep -v ': 0'
NIC statistics:
     tx_q-0_pkts: 118
     tx_q-1_pkts: 134
     tx_q-2_pkts: 228
     tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
     rx_q-0_pkts: 111
     rx_q-1_pkts: 366
     rx_q-2_pkts: 120

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
V2: Add mising Fixes tag

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c2a1fe3c79ec..c1f8dfc570ce 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4093,7 +4093,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 			continue;
 
 		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
-				 vec_name, vidx);
+				 vec_name, vector);
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
-- 
2.52.0.457.g6b5491de43-goog

