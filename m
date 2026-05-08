Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBB346AC2
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232161; cv=none; b=oj5LS3r8FaDEO8KH+//usGxqyK2WN3X9BxSwc3KD7MVurE+8yY+S8JgZARHghPEHyeL9UAWMoDIQnvT37QiAAlYEx8t4TTqlCtedwg2bzWZiRUVqK9deW+RIqEmsnB7twTbj6GX7FCTESXbjflgAW79UtJLcaR0geqPgRVEiwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232161; c=relaxed/simple;
	bh=hv2NETYo2I9M7dPx7h5jpVQA4n0c3N4NMGvDoMF7Bpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsaDQS8Btb3g5bNSO2RFkb23qlGMRcHR5TUl28iDPcl786/GqFKIDJjgcLYCSQpbpLeNykj/V9gzplLrtcagw3EVpqtKTttmqP1giEp7F/GK6UuR3U7Xj0ltWLu2ASrBIX2Xj7fuWRKq7aE6sgthIM/CXOc4TgaI7Ryy8QBeJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=HMPT7Qxz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="HMPT7Qxz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b4583f0a1aso11469565ad.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778232160; x=1778836960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KU2uqSMH44pMMKukBSajP4+Sg2CY7L09ZEK1/3akP0=;
        b=HMPT7Qxz3fXRbL/x3JxZfTXZODe2gMQyYM2NHMlUUvY9wdFVOoDLYsR5ivcF5z8yU7
         s5ucTc6RSI2LkNmi2q8N4D9qlNM+jjcqC8rzULMioBkmeicu/xkmUNkvIxACHFyet0q3
         UlgwFLdSc/AkFqXh7LUtIDVhw7PTZzposzVX2SomGfU45jFAfuTpnTDUTWK3E/sEoibJ
         yZjRejiy0IUIpv4cN+LGkUUaLQUWuy0Rkl8FUg7u2WgXriahiPSOze8/drqQIY0rd61n
         r5XD6f853YFo9iOxLMWDMwZZdwRs7Rg/d3bgL7gpG/fD3pRsWNktElV1QN1wQlSj8KkC
         Kzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232160; x=1778836960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KU2uqSMH44pMMKukBSajP4+Sg2CY7L09ZEK1/3akP0=;
        b=eRaQOyRXm01BW6XUC8BQC9LfLoArTyDFicxlzZVlFmhvC5XfCZjhAJfIXFGg/ci909
         wR6ilTz6Amp0vAzCGCZ2bLN7XqJaiMFV+xYssqJABPDSUqSjWxIetDbt/l7B3vUufDeW
         ND2QCzlFRAeaozbkn/cvoWkke5yatuGu295pbWOnar+8q8bjOqnV1nVKpUjXsXJdTCO5
         Bx3w2ODXeWeIhc6tH8ngbOP4xUe9K4ihvtDbyP8+y47KMzPna20QfjI/9Qnc1i1zUCLA
         HVugbFy3J1A4iB2ZmaRNEzZOlpfu6HZldS1Z+1smB0Z/h8VzUl5qby6w/jsBB6hOLmTm
         pYyg==
X-Forwarded-Encrypted: i=1; AFNElJ/rG83JloMNQb3tE9Q/9SaH2b8ZPwAwK9m5n1glM8ujaBPVuYRoCjKN6ASopfoDvCsLeG2yxog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzlZSoeIB8h0LlT/kE/R44rCTj2kj9RIrXPom/6FGs7uvjsfY
	JNP7iJ9MOJcM3uN0gY7EfAxt5aGaohIeY1XrregHMxEBrdz7DU0zAZG8lqz9Ph9w86A=
X-Gm-Gg: Acq92OHSvqwBwOHQ8o/1uSUX/peDdwBHs+bcM9i96V+52JcO/nWnmPzSFzlV5FQTJwn
	GjB3tu79NNSWxQHmpD/Ch5J1PtAQgKWy9mfbx42LpgfxAGHVGG2tvol/58BAP3rMNNj3fabbnMq
	gQENcfLas2N/kMQ0UpRwPrTh96stU+n+2fajC9K0KDEROiCGA1leUlgysktNLfTF7qSIi4w7JDH
	Bh06xtjYvNF5dUQqoKsKVwgu/GwABtqAGudJFprTLYg1h/bCWaM6n7FJBA6+Dh+RwRPtfTRWGGt
	dN/MBs4Q31vK26Xrntoblt2llAWXjmlO/+eSp3G8xE9cWmMjSpgZ1jbzYB4Wtxf2H9m42MVYIVB
	GYQKM53MuyA8D1IuUqcnoycfu8bMwUiEgnex+SsbEYR5LWGZR6M3GAR69BTj3FZKmdIgR4GDM9w
	RU7CGvUd1W7O1x5ryP5VO7JsrTYGkblKW8m9rcS3HVT77A9IaauRhOj8G6u+fxGoWLsCQxZUzW0
	hPKDMI0O+c2RpGLSNdGWwHEdacdM5Mene5Wvv/nmQHzBCM55BPoq6nHPw==
X-Received: by 2002:a17:903:947:b0:2b2:5857:583e with SMTP id d9443c01a7336-2ba798bb607mr118453155ad.31.1778232159686;
        Fri, 08 May 2026 02:22:39 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2baf1e36c65sm15107615ad.40.2026.05.08.02.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:22:39 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: loic.poulain@oss.qualcomm.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.chetan.kumar@intel.com,
	stable@vger.kernel.org
Subject: [PATCH net] net: wwan: iosm: fix potential memory leaks in ipc_imem_init()
Date: Fri,  8 May 2026 14:51:39 +0530
Message-ID: <20260508092141.82495-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated in ipc_protocol_init() is not freed on the error
paths that follow in ipc_imem_init(). Fix that by calling the
corresponding release function ipc_protocol_deinit() in the error path.

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wwan/iosm/iosm_ipc_imem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 1b7bc7d63a2e..f4edb277efd9 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1422,6 +1422,7 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pcie, unsigned int device_id,
 	hrtimer_cancel(&ipc_imem->fast_update_timer);
 	hrtimer_cancel(&ipc_imem->tdupdate_timer);
 	hrtimer_cancel(&ipc_imem->startup_timer);
+	ipc_protocol_deinit(ipc_imem->ipc_protocol);
 protocol_init_fail:
 	cancel_work_sync(&ipc_imem->run_state_worker);
 	ipc_task_deinit(ipc_imem->ipc_task);
-- 
2.43.0

