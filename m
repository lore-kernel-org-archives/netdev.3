Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61F392C39
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662657; cv=none; b=fbYWb1Q08O/PXDW35Q38pUF64ZB0qke9D5RzB6N1t5MO/S1i9Xh9/fIfH6cpCzXS+MO8GRgX4dVcYa03Dyg4NUpZcSBRvZr4nbsSYtk1THoBR2HdRX5Fd8CjcVpPZrs5VmVgjZQfGX7pDgjREjK8yvuQE/HyjH1yCzpbh8mn+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662657; c=relaxed/simple;
	bh=9f04z2+fz2qu8sHxFaO1amcu5gUQRTCYK3gRGCdsc14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpQ52qNg50STp9NVtla1E6jIFMS83KGOKVZ0yupWnyVZMf0PZ1T537HHrb2lJ+pExvB8SYQuDIQ8+Z8yXz2vP07uLKbvIdDxYWV00kVK9SsRnW5+BfFfXX6Ma/ww75V0UpOv3GT+fwnwcUoyeqnlKtr5zvLr7uGU58zx1GkSrAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=AWWDe8il; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="AWWDe8il"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1542765a91.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 02:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785662656; x=1786267456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ceUadGwYvW5886Ohy9WYdANAvpKRZkwCFtMGWcPPY8c=;
        b=AWWDe8ilJL3A7q1y9UN8NmUtUWnAbN6A8kVYF+AlW16Vb27bdnJquN6KbNTvW8kIVQ
         kFjtuYHEyNEvo5AvOPzAlg7FXoKfqyjVc9nsPvJpc6Sp6lAf9vDUg5ki+iUPgAio/tnq
         yuG/Bhnw3jvlijlmKo25wy5X7vd+YNvrX3m/QULzlWPuUq2KNUgKYdhbwQTiitCfpEeE
         NU1f+Cyfl/IoMqgT6zZo0yZPS1bj5LB0zhSUSzdK1ItUkKdK6XpiCQzE2A7VjioaQOEd
         ujS2w7PfQd9nZbxLAUfcrEYTq2m/3tiURcjonhOQPJkM1dtcitHAN3MmyM2KfuNIFdUX
         fkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785662656; x=1786267456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ceUadGwYvW5886Ohy9WYdANAvpKRZkwCFtMGWcPPY8c=;
        b=U7E7JYCawZOjwkySOzswHdo+GhJg8eVUxQuIax0KU86dEYSk1dGWOvouhVwQnb0ttQ
         yN292g1H2jvzXCjRttkWRhN8s3OArCfZhACSMk3cxO/jFyTQDlSfqZbsTXmJMQy1ble4
         H3M23wugt3fma7jksTkRN69Jp4tTT6J7S7G1oqO7ZCLKt/pGAxhsljlsJGGRcLCz2OtT
         NBsQesqPgn5A3W4CRKzGka0tyc5ZUdZxI3eBSPZRR6pnPbcAWmgJf0J8Qy1Fa58shXeS
         tP5QH0btAcIpmWuoCiq+DoLSlTuIPFT5yqrU6edSS4djzBcCyftgk9n9Aj39eq9e0i5e
         WI7w==
X-Forwarded-Encrypted: i=1; AHgh+RoFYc/GdyskITbD1bhtS9E0xSBdStd5ogricVNtM33i/TIrVBIQs9NT6Th30ztHxf1xEXcggkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7HY0t/4HLI5EnqNavjhJe94nosEOox/LHLu5p4G6nYh90gXDj
	JBe+nhYZYokBKIJhNjwjP/fpEMZnDADaEvMRT+UXlACkGLzeUhXVJoMZCEKVZP1HOtaN
X-Gm-Gg: AR+sD10Z9lHXJ6/EUpeLT8R/+GjtzMaBX/Rvkp2xRKw9ekIAbGFcTcBBRG1rWpqqMum
	Ud9hLiUpSDIUCcgYT2pGx5VbXvVRTiQfqew/RbOErHkBQEb6zaiT0o/nSDFYxqAO9BD42CzrrtC
	+DmxfiScl5TAzAGaaCcZQnF51wjee9IMx0LXlV+0plBxiGAN5/a40YAiQrKYsLBUUvcAWpFKo1O
	br84BSbm+lbc9TDRS/r1uYoTTZpIwtgDvDK2NR4evKjwVTamqfqkqOfYiipH1plk92l33Yr0NBx
	k29BquKjfmVwd6aXWBWOEpmJ4/4ge4YnkXb9hi0Hgk96CL57e+uhv+l2csqVP4ONm0hW4eCQKGF
	1lBoSoeFb51X2RsWULM3O5Ym2CJ9LTHIQHoQxBIyR57KuHLbbU1lIzy8t7Vu7OlGstguxGeZqBJ
	OvrRtQk4wk64nhT7MlKvZ0Ew/7yWESevmSkYw6Az0KZ1OOziPYCO0zEaGUDDqes3J06x+u/w==
X-Received: by 2002:a17:90a:d004:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-38fbc4da0a8mr5614092a91.22.1785662655734;
        Sun, 02 Aug 2026 02:24:15 -0700 (PDT)
Received: from localhost.localdomain ([115.192.251.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30a3c75sm2655325a91.9.2026.08.02.02.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:24:15 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	david.girault@qorvo.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 1/1] mac802154: fix netdev use-after-free in beacon worker
Date: Sun,  2 Aug 2026 09:23:34 +0000
Message-ID: <e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785596603.git.zihanx@nebusec.ai>
References: <cover.1785596603.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mac802154_beacon_worker() reads local->beacon_req under RCU and derives
the sub-interface from the request, but then drops the RCU read lock and
continues to use both sdata and the embedded wpan_dev.

mac802154_stop_beacons_locked() cancels only pending beacon work, clears
local->beacon_req and frees the request.  A beacon worker that is already
running can therefore continue after interface teardown and dereference
the freed netdev private area.

The scan worker already pins the netdev before leaving RCU.  Apply the
same lifetime rule to the beacon worker: take a netdev reference while
the request is still protected by RCU, and release it on all paths that
continue after the reference is acquired.

Fixes: 3accf4762734 ("mac802154: Handle basic beaconing")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/mac802154/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 65089826f..ebd092d40 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -416,6 +416,7 @@ void mac802154_beacon_worker(struct work_struct *work)
 	struct cfg802154_beacon_request *beacon_req;
 	struct ieee802154_sub_if_data *sdata;
 	struct wpan_dev *wpan_dev;
+	netdevice_tracker dev_tracker;
 	u8 interval;
 	int ret;
 
@@ -427,12 +428,14 @@ void mac802154_beacon_worker(struct work_struct *work)
 	}
 
 	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(beacon_req->wpan_dev);
+	netdev_hold(sdata->dev, &dev_tracker, GFP_ATOMIC);
 
 	/* Wait an arbitrary amount of time in case we cannot use the device */
 	if (local->suspended || !ieee802154_sdata_running(sdata)) {
 		rcu_read_unlock();
 		queue_delayed_work(local->mac_wq, &local->beacon_work,
 				   msecs_to_jiffies(1000));
+		netdev_put(sdata->dev, &dev_tracker);
 		return;
 	}
 
@@ -450,6 +453,7 @@ void mac802154_beacon_worker(struct work_struct *work)
 	if (interval < IEEE802154_ACTIVE_SCAN_DURATION)
 		queue_delayed_work(local->mac_wq, &local->beacon_work,
 				   local->beacon_interval);
+	netdev_put(sdata->dev, &dev_tracker);
 }
 
 int mac802154_stop_beacons_locked(struct ieee802154_local *local,
-- 
2.43.0

