Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487543C0628
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495134; cv=none; b=HybCXPn+eU2gdI3r0OhaRo/esB1WIlmTQeg1lAGEk/DwJccWkqw2dTeCut0D+z/ZUwb9Nzlo2fhsglMCfV4ddP1hFmSD7JnBXQvqO0ZR5L50vx0yAdThxFStEE7s0yOOGGssBCI/ArhfXlnpwoYckMZhTfanUtyp1E0idoBviyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495134; c=relaxed/simple;
	bh=175TMyjXYbKvQv+2xfNx1pjOaF88OH/j/aBTVdwcliw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Twn9zI74jMBUclOIZ4Hhx7rm8ooh2Ysng27gTRJzAoRljJnrNKUzvaOMyI17EBOnxCP5vn+SajxKY8VrTlnKJ2JRi0bff4Dqxlua3qY9qRAGf9BCrGe4WDTUETFP6/q6SdAvPpbh7wyzZMwnEf471bdlVCAewU1IIyaS4pT+34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJjKi2hc; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJjKi2hc"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e79c06622so187699eec.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790495130; x=1791099930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+hTRes37Q2KgbwIZUkJQo8Y6gN/vVSdb39+kLswqOgc=;
        b=KJjKi2hcUjp+HPt/aMlZyADyc5W8ychzP9wLrTPZDUXJyAaIi0dHqMc2rMoK5Ohj3f
         bH2/SeIx93AwLowcMlf2v5a5Md54DclHHHgI0uNI64snrgjoTFSkDsFak9Gk26+Jm///
         cKWj5FTuXSEsu1+CjksL4+7R/UwP5Vi5S0ZHVyWg0pnNZEkFpeg2hO/qghcTOS2wy5ZZ
         AEPqN9aCwsRmPwl3azusCSu7+wI7PW6NOiuiq8JFXEwQr/kWX5jq01Xbd9WSb8V37Zwx
         0r6L95cSHKhGRwIs87gaZ+FuQ8GvfqobKV9uoBHvbHpuipIzzZfh7OsnVdp06Nck0SB5
         stnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495130; x=1791099930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hTRes37Q2KgbwIZUkJQo8Y6gN/vVSdb39+kLswqOgc=;
        b=On3LQ0pqLjhTsbZchmZHm15A5AUKX5x+Blt9XH8wK+x6SnnlX8lAmAzcBGiq+FP55S
         aTkdW9n63DJg7x0E33pXSZ845M+1ED1pMIiH+3cxECwSnXaOrtqnfAuGq6tY1dGUP7ok
         dyKjum1gAcLAWNeXCWPkvtZOn6tr0qDR4FlVH1JM1JE2PmFq13AQ1AifS94ly2hkiqwn
         SnN+6HYYAjmzX/CgJjL64ZdgB5mJE49VWpEoTT1hFNPmAFO8Z0WuGYWGwiaFl388QGfq
         gaq57UQfAyn2IFLpnO55xDgb1AiXkZovSYwfZo5SEBvmXqyCSrqThgyyU08z7HFfG4gg
         agpw==
X-Forwarded-Encrypted: i=1; AKwUvBwyH++7+caKoGc52dWEYgIfU0sval2yrnOx6x+7oSqAvwFXn18Wpl0Q6oqGaaXZ7ssNzUmijmo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOuJISzQu655BjarTbEFwcO7tJhpSa+RQXJzAky9ccn0mIUsYR
	GKOL+iP2ffyXTZ7sLW2zSAGVpaJ5PvLkrY0ig75HHvAq1Byvkn5If61k
X-Gm-Gg: AYBFou1nPlnAwtHWlJZpxT149cyol0UbKsZdPZvoALNZLIGcKVy8YY9TChGov0xV9l8
	uRHRDu+FjrdB9DRinunRfhA/MgJv18ZWL+hZ/h1QLua9UlPYnFceIj10we3nQD6e5CPWBB16RbV
	KSqShAaVkH/EZvUNpIk0+iDf/NWygg5JxIayMOjFgJ984wiRhLOqbwbVXrSAz2d3loGFdIh6QCm
	zTGDPXPO5WwkB+9RKbxh/9u9FvvuhPzsJe++8o3EedOXB9AiEHkcVrL2HsLq4IiWsB3EXPHkty4
	fHqB5kuzPsDcGBRvDwODVti+OQLIbtwp950W+nExFZktrDmfZOwJLmhYTTX0iXPS0WdmG2WKLPh
	rD4cKjGOJU69jdBCOqXW585Gr80bhwMP90PX6ZJC5L46YFNfH5zWbmEPTvuaBJhJgQmd6pJ4zsV
	1Syju7THXp03f7bvCPLd41E0s0TmPZ05nHO1lR5yZbZ0n40TwKaFkKhd5IzbASJI6M/HTcz+viU
	Ho/tT3GdLgqpX0DXEAXxIlwZCZMntjRXcZgAJcrkgo2v2mLPsyCOh0F4TnnMt4OIfuEsQ==
X-Received: by 2002:a05:693c:2589:b0:340:f698:fd56 with SMTP id 5a478bee46e88-34273249209mr8814184eec.2.1790495129005;
        Sun, 27 Sep 2026 00:45:29 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145727589sm19752996eec.23.2026.09.27.00.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:45:28 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Ursula Braun <ubraun@linux.ibm.com>
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/smc: serialize link group free work scheduling
Date: Sun, 27 Sep 2026 15:45:20 +0800
Message-ID: <20260927074520.3694663-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_lgr_schedule_free_work() checks lgr->freeing without the link group
list lock held by the teardown paths. A concurrent smc_lgr_free_work()
can set freeing and cancel the delayed work between that check and
mod_delayed_work(), leaving a timer pending on a freed link group:

  CPU 0 (smc_conn_free)            CPU 1 (smc_lgr_free_work)
  observe lgr->freeing == 0
                                  set lgr->freeing under lgr_lock
                                  cancel_delayed_work()
                                  smc_lgr_free(): drop lgr reference
  mod_delayed_work()
  smc_lgr_put(): drop last reference and free lgr

When the timer expires, the timer core accesses the freed memory.
KASAN reported:

  BUG: KASAN: use-after-free in __run_timers+0x86d/0x8d0
  Write of size 8 at addr ffff8881186902a8 by task swapper/2/0
  Call Trace:
   <IRQ>
   __run_timers+0x86d/0x8d0
   timer_expire_remote+0xd3/0x120
   tmigr_handle_remote_up+0x4f4/0xab0
   __walk_groups_from+0x40/0x150
   tmigr_handle_remote+0x229/0x2c0
   run_timer_softirq+0x1f5/0x250
   handle_softirqs+0x18d/0x5b0
   </IRQ>

Hold the existing link group list lock across the freeing check and
mod_delayed_work(). Rearming then either precedes the freeing transition
and is caught by the subsequent cancellation, or sees freeing set and
is skipped. smc_conn_free() retains its link group reference until after
scheduling, keeping the group alive while acquiring the lock.

Fixes: 8e316b9e7260 ("net/smc: improve link group freeing")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/smc/smc_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9974149659c2..8feb486ada56 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -80,6 +80,10 @@ static void smc_ibdev_cnt_dec(struct smc_link *lnk)
 
 static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 {
+	spinlock_t *lgr_lock; /* protects lgr->freeing */
+
+	smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
 	/* client link group creation always follows the server link group
 	 * creation. For client use a somewhat higher removal delay time,
 	 * otherwise there is a risk of out-of-sync link groups.
@@ -90,6 +94,7 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 						SMC_LGR_FREE_DELAY_CLNT :
 						SMC_LGR_FREE_DELAY_SERV);
 	}
+	spin_unlock_bh(lgr_lock);
 }
 
 /* Register connection's alert token in our lookup structure.
-- 
2.43.0

