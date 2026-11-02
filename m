Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617043;
	b=WWB/AS3GL6oqRxMOBo/0lJ9fqQ4FinaxROg2GDUVtnK4tMHrf//795gVUZO37kg9BuAA
	 anLl2r089xvCzspYxmgngz2QmcDXoMDdJk1Hx9iPm5m7ME2nbGsyhBQMvAayYfEPOgPjw
	 +LlPp3xIutIlAgusCtCZ73593X/of47obaOIStoU6hNMotfi1N8c8aPwZt7+BJJc4UPMt
	 rXPDzyCXBCqeLVEeIzK2fBK0KXK/PSwhe0dy76AQsmLK8ExePAPjZcVfkFj9AV7VafvwL
	 qVg25ADRENzwhxsSWz3N1gIpwkrJZD0JR+fAdokSsqCxipWxQpN9qcxkI8HH5dO3DHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FVUrfemyNnwloOlUvhimVc5x8NpDNzjKpz5CjJJeqrQ=;
	b=I2/b8tSAxQJjvGrGrG75EE3sdu8+ss61o8oyXT+v9tgoLYYfGYorZwhTD0XMybiBafGM
	 1z6h/GOrJfoXK6wdvh8HQVgHb/58JxthH4uM5lmgmcwHmnqoJlaf5lhpwtGPTlNzdk3B5
	 dg0kS4uUoCVC4qwJdh2bVYARrweM47CI5G55BGX2BSRXYg1u5Q6syJHO93iM0hq72Mg0v
	 TwkBnZScu8A7tExFA6DrE4XfXUZcxRYEkTw3WKMAut4ThIzBUrOw8reu4VFPs9RHD6KQE
	 WnWzL3brh1q9NUs8TwvYxr4I2sLxb3d8Jue1umNyhqMJ6AC5+vdt2Dh1CD/4pDmRv3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IQ6xq5jM;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA7606A33A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FEA7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IQ6xq5jM
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1639391f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793617041; x=1794221841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FVUrfemyNnwloOlUvhimVc5x8NpDNzjKpz5CjJJeqrQ=;
        b=IQ6xq5jMSDjR4Z76wkqzg/gMzCMOdQ2vpiTlu1RJwS4cOiTjdu87XtWHC3pfF6MzSO
         pbRfYB0UUE+BhKcYQPm+2gRBNdCRuzXldOl2vG7cVPWvjzFqZSKgQIhDSdqtK6pYr49O
         AZkyh8sAQKZ4FDV0id1vB+7ZmzS8Bf+GSUZQt6raidgQCpCC9Jzu6BZYhdV4bYmqk3Hr
         55FJPGe5U5oYT2Wl7HUaLFoVewnmOK7WPIiSQpN/eWH3dDnzm9+6+1CdQU+LllPPE4iu
         nvmGQY4gYvL7yUNiYQMZ2gAh9oOXql9jTU9D196CKisAHe1phlkZlW7bBFbxpsDawd41
         d2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617041; x=1794221841;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVUrfemyNnwloOlUvhimVc5x8NpDNzjKpz5CjJJeqrQ=;
        b=jRQ9Rg1olpcZ62lr4mIGkzVBbce/cCrHX1vRX01Zm2E49EdYTqGSew+rvS3qfQQpl5
         9twQ0Cvmajp50co5XlPaH+cgXOP4FIKZCMmjwzX8iX2IV1uSHWCy001mUZ4FWOeiXwtH
         ybGxuBvqBtGullewDWvd3SWC5Ka6bMwkEn+nnU72tpsJi41pZcBpgK6ZwE4vi7FJTIE0
         AwSBPn4DS7FHpaoL1z/+sCX1WdgCzPDLzLMmc3wGi+sl/i9LGjIKOT4MGmoyAiEY+Cpd
         zU92eA5dKuiqXP4zAoZlKZQXdpLOfaTm8a3hthlAHNtd7nxl7brt0mrkcWzwpp4sVOYX
         Wmtg==
X-Forwarded-Encrypted: i=1; AKwUvBxVjZ1vB3GmlEuFC+x0N1akLjH0nlFzu1HEwLBPEpGhZjM1PkZQvaeVew6GWG5EHypp1jzH+YM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtiHCuTXzPOtehZDoknxvPX9GpfDm4YbYdtOzS9OLVuJImmn7B
	3Dd0m875j8j9O3JE30RJmGzBpJKuO1GIe8DpLlKGxsxfgwORVFeNxs7a9tAx9ag/vb05pUoZWku
	dFrrhUGM=
X-Gm-Gg: AYBFou2q95w8Goks4zsDnPnmuZmq1Jn8U5T7whXfhnQ6nw5OG1NGMVCiMa9cLfZh3PH
	KBk6+C5vY3WMz8SQfMVMbnF2D9tKnD4vZqCVgPw7Z0rEMdJ8yesy+jETRSgBevA9ZzRlcFD7aT9
	oKoOX+Fb56x7g6kz17Ke7T9WQEEp5y5qUFU2Wraf1cdgGOc0xvEuvxOfVeNLV1sSXSu9uwjE3J+
	MQ0htShYHAAlOS/bl4p5m09WEUEgTBHocLqzB1KDblMWQgIH4P5XAU+byLF8Yo5tGQuFnXJDSey
	Ev99y3sh7aHlpYqmJbPK9ItYCM3JIyfsWM02QmDy+6lWtl5NteDa5D4TahtNskllGPJ7PBYKZf7
	TncDTVEJ1PXg5IPDSTGX4OCRygvphfbUu4NALnUCFu5neVu1/K/R6GGa1cs5Sp/kEQd0cXU+1St
	93E1BTgyd0Uk+wtiTQ+MVDo41B3zCvBQzr6BgjSIOo0PaFMqFqqVGgl6gJJtVfDajeX1X16PdCf
	ZGIlE3ft29tkun80A81mcVtwwXfBpH/TBDHlAxFNsUPfqsgSvpwsWtHde6Lk4/ZyT9ZOUww8/3v
	9ihZsMeyRUW5S8cMDIdeovv4IBLQJ+wveWQdjMQPRZoDEaud6uV1
X-Received: by 2002:a05:600c:628d:b0:4a2:397:73e9 with SMTP id 5b1f17b1804b1-4ac17d1995amr224936715e9.18.1793617041562;
        Mon, 02 Nov 2026 02:57:21 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm363171175e9.1.2026.11.02.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:57:21 -0800 (PST)
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
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 1/6] ibmvnic: Change system_long_wq with system_dfl_long_wq
Date: Mon,  2 Nov 2026 11:56:51 +0100
Message-ID: <20261102105703.111844-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102105703.111844-1-marco.crivellari@suse.com>
References: <20261102105703.111844-1-marco.crivellari@suse.com>
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

Currently the code enqueues the reset work items on system_long_wq: the
ibmvnic_delayed_reset delayed work using queue_delayed_work(), and the
ibmvnic_reset work using queue_work(). This workqueue should be used when
long works are expected and it is a per-cpu workqueue.

queue_delayed_work() ends up calling __queue_delayed_work(), which, since
IBMVNIC_RESET_DELAY is non-zero, sets a global timer that could fire
anywhere, enqueuing the work where the timer fired. queue_work(), instead,
enqueues the work on the local CPU, i.e. the CPU that requested the reset.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the reset work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Both work items run the same handler, __ibmvnic_reset(), and every reset
request is scheduled through the queue_work() call in ibmvnic_reset().
So convert this call site too, so that all the reset work runs on an
unbound workqueue instead of the CPU that submitted the request.

Cc: Haren Myneni <haren@linux.ibm.com>
Cc: Rick Lindsley <ricklind@linux.ibm.com>
Cc: Nick Child <nnac123@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..d4c284c8ef43 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3229,7 +3229,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	if (adapter->state == VNIC_PROBING &&
 	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
 		dev_err(dev, "Reset thread timed out on probe");
-		queue_delayed_work(system_long_wq,
+		queue_delayed_work(system_dfl_long_wq,
 				   &adapter->ibmvnic_delayed_reset,
 				   IBMVNIC_RESET_DELAY);
 		return;
@@ -3267,7 +3267,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	spin_lock(&adapter->rwi_lock);
 	if (!list_empty(&adapter->rwi_list)) {
 		if (test_and_set_bit_lock(0, &adapter->resetting)) {
-			queue_delayed_work(system_long_wq,
+			queue_delayed_work(system_dfl_long_wq,
 					   &adapter->ibmvnic_delayed_reset,
 					   IBMVNIC_RESET_DELAY);
 		} else {
@@ -3454,7 +3454,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 	list_add_tail(&rwi->list, &adapter->rwi_list);
 	netdev_dbg(adapter->netdev, "Scheduling reset (reason %s)\n",
 		   reset_reason_to_string(reason));
-	queue_work(system_long_wq, &adapter->ibmvnic_reset);
+	queue_work(system_dfl_long_wq, &adapter->ibmvnic_reset);
 
 	ret = 0;
 err:
-- 
2.56.0

