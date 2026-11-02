Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617046;
	b=LO3yhTMOb+Hge2oCx2PJPjohape6H+BzW66NG5kkvZ3X72JbQCh6Cr5hYZGGTqFHJdbX
	 XnoIDhHrX/juGKujjduFhUZYCMTo2Ktgt7mH9DdcgUfTNnG8A6zdPm4USK2ak4qYGthN8
	 O//mTkIuoN+I+3BtKTqM/8jibalPyIsxg9pDMeX0SH9b9B5csDWuBaRtOt1h/qms4SeNW
	 I0We7DRxBUmvDwe1Dbt7TS34/u1C73tIMoN/FxKiwX0+lNJaKO3N6T3Fc96qP9hwy5bRn
	 XuKC9HrDh0g3cD+NNn1g+UAiGED+Dwd1TVgcEVmDBFPKQ3L0hqBIJ7O5GhW6seMDL7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VeIOYKTyw83mYC/9mhXnSVKUy1AE36+b+LMYhY+JUTw=;
	b=VrJgyH5aORO0HtHDuPhj31aMO9xMO9opo4Dz/vhXCEZOrW0XDEyrv3b9SkfqqsXRrT8A
	 O/ATyS/4QwlmFE9T1V5ideLLJmNMRFEwxsxDLq8WXRo+W2PvWm8QkQKAxk1IKjx2QTEUJ
	 AYWQKNRo9EinL+QVcbcdYmwxvw09QrxnXP1EBkWPY31AL/9d7STHr4lC7wMGEx/S8aiWN
	 zDBsMqN2hfsb541myfO5hG2zSbBk6NLj0BwiOpAeOS2IlP6fktO8oyRueQ2O0qfPD9n46
	 JzUU7HmOFT4BdZ5KnGS7cRGjKzujGfGGmZR9GJMlxMq7vwGNGupFQnVv6oQBMaDe0wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="FPtU/BKg";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CA60A2618
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562CA60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FPtU/BKg
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so30088595e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793617044; x=1794221844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VeIOYKTyw83mYC/9mhXnSVKUy1AE36+b+LMYhY+JUTw=;
        b=FPtU/BKgFk//XRlZlXVVoDt45n0O0oBnribR+fBXb7E086GVxde1kLz7uNZxrVwQEi
         u378Vy+wjE9PdHe6NY1Bjwa6/aHqdmJhOhx+noNqYsLrouWULxXeZOhmWwOT9Wq0/bLb
         AVVJ5qgNkWk9Uyd9pSGTify0ec1szO+0ixr77RTLCbiYMvCsvXL2x/1iXFivVFPPO1YZ
         KfIXu8C7iXQoVLmX+TpF7bQr5EYs4rw2xHQPTr9R49aqOD66ByuXq1xsPGZuiewgMopi
         NspaHCP5Pc+tPJ42wLxwumfulfOPVm8tORnxWT3isoM8f1XR63/c28lMeUbyLraV906i
         2xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617044; x=1794221844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VeIOYKTyw83mYC/9mhXnSVKUy1AE36+b+LMYhY+JUTw=;
        b=PlQkap9etqY0cXJ8cO3QbXp58sirCSn0Mecv4ffu7rQZk6GmjUcY6zIbodONARIa/M
         D6PoGtxvkWnWcp5jiegInx4gL2NO5t9kl8ad1xCK96LanBDk6G1AzFotbnn1BCpiGto1
         wKJfPYeGx3GsWw23HWhqjgpBWAgO1/UM2eXFUHHWC37F5rhz5G9n5NXuguz4Ox6GdRPw
         VQAlI/pTxJuVArfL4RqTGyHYmcHip3OU9dAnxzeJwI+byU3BnogkgRctBpYTKyLVKdCd
         FUGQE1AOR53WGDBgj250zmY+RMNhU3OfTA4PwqAUYVJRBAygG261Efd0s0fmobafljOL
         EJVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuR7i4doOZhEy8+jm9nolsJeAfM5a+SCm3LOmbrwsjrd4ERO9JNBXKeAegmB+/EbMwxNzKIg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrLBtHJXAb6QTMu9kBhfLoLjrw6dX+sD8UvG/Olu1GaWmu+j3k
	kIBPBjdTb21fjfY0PADbFdRbirfOn3U/c7Zc02H5u7ai5IvuW9lHAT4nKNHDH/SYbJE=
X-Gm-Gg: AYBFou0bA+zf2ijcPASd8cr7Xm5x0sWegO6nKQuzT7GwQW9z1+en5vm+7vsV8FdNYWQ
	UXg9IRfilTcFUEZ+2X5DHqZTw+DXKbBdFtrphAuLpRNot3oN/h9szonW2xQOXmPXZBgf43OyOjb
	fc1c+JM6pDYPNc3TV/u/Xgo2ixgvBAqIE8xMz/n9/fNWN+9MSnQreI0bRS5YAzFybgdnvTanzzy
	R/GM0FFDa8VyrSZgCwRIplj4fhataIYBjTunAYtAjCcm2Q3SuB0E4qLmU0LtLBbsqlRew98iCB7
	6u3FjvQ3JUY/1j3gen/NuLFjKfkopS5+s52WYp81+8A5gp+C3pFdnSI+6in2DBp6tokU4EAkT1L
	zqHZPiqBJrrZgy/7dQQ4x3TJp+caMlMzcS3hCOJV0NMEcEiHISfrwA8wHPsRNNwKJtF1C2QL+zt
	Jdtrf7bUePTCeU5xJzVmhTPm7uaDWyeu4AubHDnXgoScwB48ymfCE9HW+rG1B5uDsNb7HkJngTF
	fbXIy1EONdYt/KyrNikGXmnvczO+P0mQYGH/sNitupO8p37bvMh5jMWsAq2FsSycZEQY0rCEDqV
	cCowj3XOR0QijOaqxMTCSNFZrLVPC23qVhI94c4lcuksFwpBrSqp3mqKpLxHPRVhnRyZacSI3g=
	=
X-Received: by 2002:a05:600c:3e05:b0:4a2:cbe:bebc with SMTP id 5b1f17b1804b1-4ac1765e5c8mr214514365e9.23.1793617043731;
        Mon, 02 Nov 2026 02:57:23 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm363171175e9.1.2026.11.02.02.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:57:23 -0800 (PST)
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
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next v5 3/6] net: ti: icssg-prueth: Move long delayed work on system_dfl_long_wq
Date: Mon,  2 Nov 2026 11:56:53 +0100
Message-ID: <20261102105703.111844-4-marco.crivellari@suse.com>
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
Content-Transfer-Encoding: 8bit

Currently emac_ndo_open() starts the stats work for the first time with
queue_work(), using system_long_wq. This workqueue should be used when
long works are expected and it is a per-cpu workqueue.

queue_work() on a per-cpu workqueue enqueues the work on the local CPU,
so the first execution of the work is bound to the CPU that opened the
interface.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

The stats work handler, icssg_stats_work_handler(), already re-queues
itself on system_dfl_long_wq. Since the work doesn't rely on per-cpu
variables, there is no obvious reason that justify the use of a per-cpu
workqueue for the initial queueing either. So change system_long_wq with
system_dfl_long_wq in emac_ndo_open(), in both icssg_prueth.c and
icssg_prueth_sr1.c, so that the work may benefit from scheduler task
placement.

Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b..0fba22c1046e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1100,7 +1100,7 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	prueth->emacs_initialized++;
 
-	queue_work(system_long_wq, &emac->stats_work.work);
+	queue_work(system_dfl_long_wq, &emac->stats_work.work);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index b8115ca47082..fb7140330671 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -602,7 +602,7 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	prueth->emacs_initialized++;
 
-	queue_work(system_long_wq, &emac->stats_work.work);
+	queue_work(system_dfl_long_wq, &emac->stats_work.work);
 
 	return 0;
 
-- 
2.56.0

