Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43633E34E
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905634; cv=none; b=KpK4xfbqBX9EuzDs/9iP8iMyikw7D4RpNlJsA+WZE1XFPZsEGdmbBnuOZqMqDf2ieGMCVK1mpUSEDz2ZVad5stX6GGwsqLx69VwpEDILuxCRlfschu7y7dVvV0Uwnr898LTEiE43btLJTmEBcv5bNEAuW3+H4MijeK7yU2cq1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905634; c=relaxed/simple;
	bh=Si+F8QwszeOIn9X/7uuoUtNeu6jhOSRpc0dSuUMJZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m882mA3becolRxVvdA4RISeHEjb2VScEbzSZUvHkRvCFY94Ak2MDoEiuSMoQvKsBCCVGyisvYIPyb7CtDRlXV5dFxEKhPHuYYsf5WMLjXSMzl5f6kWLZfjkp8KqxcxOP0q8D2HSPvfsHC9Q4Jqv7403gziO22uGe58rrkV2LArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMuc1mJW; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMuc1mJW"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so57056895ad.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790905633; x=1791510433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5knTdO8QKiMk4hOKzMIwvsIoTWuR8tgoTbzdeallV4I=;
        b=rMuc1mJWjnssnNP31zfm2Dz3fYcWmOHJjohEhaOZuZBd1WzyGtN4FUVvz7vnSgWFsr
         FQhdtKYu4urb2lnEqY4Kx/64oP2X7R6KKGzRKm1dkd3AkVjGeGNDKt8I67Cy3ZlTg6l5
         hocGUzG61/3VnPSv6a2SXOKaMPzXnKaaTo9RWGFsQDN7zKck1duRXXIIJaDWQTha1LQy
         hC7/MEbfF47qUOvqv4sQ0yWzgHBZtHVsjnswvdzeC5CbhR69FwkrT9S1YQ1jilcb0Ykn
         LUAFEmXuQ9dB6cJlrgmlf25M5Bn/wTZcsbh1KopXvYNjbNU2vVuyni5fOYhN4xuz4s+M
         n0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790905633; x=1791510433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5knTdO8QKiMk4hOKzMIwvsIoTWuR8tgoTbzdeallV4I=;
        b=flMDtII6slfG/kUpH9FLw5rnov6+Tr+KacfwdNydoQvkRIIBoAleS/bdC9gFBA0qRz
         AqYwOZY9tDbmbctv8IBuddg+5cU+IFO1tovsxY7QygcxwwuACNFRErloyMn5/Ck+VNGD
         qsJP1zXGaxuNN4jFRpt/yGW7bTvveGHIZ4TKfSXvXkqIjAS4+rUH8mDb9xdKhVsi8t76
         gAP/qnF30aYIBpelCtuqTYcIb0OLiRj2SLB7PVjdxaKps7sFH5vSb6oI/akvsfp/CilI
         jFUQ1TbkjiNfP7n1huiMz2vSz4ibClp+bHScVAVtplVxbWg2mu4GAuRJ9QtgsjBEwBzc
         YOog==
X-Gm-Message-State: AFq9FYJkujybZY1XmkvPoXBzsIGWD9KtlmBtiO4vcYPWMzF+rLtzSybW
	DmjB68PLckZXbGOrDD/Nnk3jC37ioIMOfNnPu2VQa2aImQh+X0FUUhYCVNi8bdCr
X-Gm-Gg: AYBFou24nlBpZzh0z8o6DCLamxfT6Qs0n2Uhdv6PNsHmV0pFghBiGf9/Tt7rc4HKr2/
	JaqKt8+0T5x6pJ2HqFp6EvB9R1LT/a76fsMM5gEKxMwVhMZYAT2Ney5VQTE+xxF1fVkvSa+VF3M
	2kNoTaEr7hzGOOxnteJH1c9cZmduFCaNn9Ywh5M1K4cYlROCL1eacoweDcaKnTdhakHelT28lAH
	QEOWSDzyOH7gdMrZQgJULyaUWecWY1S9YevR+26ArcwAVoDbWuUFDSd26vl+X1HynbydTOGeBuX
	JW//3hFdfh4KaPNHIdcytEkE2x9Fkl8Gg6ikjd7xeZYIVqwS0AedQlNe2bnXsOpmyEVdbf6T9/e
	5Mh26fYrQtK797qlTO8GGy55jsNsWCR7NUIseIlWx2oTDvNJG97u3OdvhBBN9d+qki/wEmWc6sl
	3oeBeYWpWnqIJ9ml+/GI15JLc07HJaQhp8/i8fhLvReBVURebFkKQsZDgR60MDbCCEJN3x2ygQw
	wsLFs0GQNSOLuDYr31pWA==
X-Received: by 2002:a17:903:41c8:b0:2dd:9b53:f9ba with SMTP id d9443c01a7336-2e499f0d051mr11523125ad.1.1790905632439;
        Thu, 01 Oct 2026 18:47:12 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ceaedsm2675645ad.49.2026.10.01.18.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 18:47:11 -0700 (PDT)
From: Tim JH Chen <tim770802@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johannes@sipsolutions.net,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	chandrashekar.devegowda@intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	linux-kernel@vger.kernel.org,
	tim.jh.chen@wnc.com.tw,
	Chih.Hung.Huang@wnc.com.tw,
	Tim JH Chen <tim770802@gmail.com>
Subject: [PATCH net v6 4/4] net: wwan: t7xx: complete NAPI on the not-started RX poll early return
Date: Fri,  2 Oct 2026 09:46:38 +0800
Message-ID: <20261002014638.47981-5-tim770802@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002014638.47981-1-tim770802@gmail.com>
References: <20261002014638.47981-1-tim770802@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t7xx_dpmaif_napi_rx_poll() has an early return taken when the RX queue is
no longer started:

	if (!rxq->que_started) {
		atomic_set(&rxq->rx_processing, 0);
		pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
		dev_err(..., "Work RXQ: %d has not been started\n", rxq->index);
		return work_done;
	}

work_done is 0 here, so the poll returns less than the budget without
calling napi_complete_done(). Per __napi_poll() (net/core/dev.c) a poll
that returns less than the budget is assumed to have completed the NAPI
itself, so the core does not reschedule it. NAPI_STATE_SCHED is therefore
left set and the NAPI is never polled again.

t7xx_dpmaif_rx_stop() clears que_started without completing the NAPI, on
the MD_STATE_EXCEPTION teardown path as well as on system suspend, so the
next poll takes this early return and strands NAPI_STATE_SCHED. A later
netdev close then hangs:

	t7xx_ccmni_close()
	  t7xx_ccmni_disable_napi()
	    napi_synchronize()	<- spins on NAPI_STATE_SCHED forever

napi_synchronize() runs with rtnl_lock held, so every subsequent rtnl
operation blocks and the network stack wedges (a hung task, not a soft
lockup).

Complete the NAPI on this early return so NAPI_STATE_SCHED is cleared and
napi_synchronize() can make progress. The sleep-lock retry branch just
below already calls napi_complete_done() before rescheduling, so only the
not-started branch needs the fix.

This is a pre-existing bug, independent of the TX/RX data path vs system
PM suspend race fixed earlier in this series. It was only reached once
that race stopped soft-locking the CPU before the teardown could run.

Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
Signed-off-by: Tim JH Chen <tim770802@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 0e1174ee611d..6272956fe053 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -848,6 +848,12 @@ int t7xx_dpmaif_napi_rx_poll(struct napi_struct *napi, const int budget)
 		atomic_set(&rxq->rx_processing, 0);
 		pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
 		dev_err(rxq->dpmaif_ctrl->dev, "Work RXQ: %d has not been started\n", rxq->index);
+		/* Returning work_done < budget without completing the NAPI would
+		 * leave NAPI_STATE_SCHED set, hanging a later napi_synchronize()
+		 * in t7xx_ccmni_disable_napi() (which holds rtnl_lock). Complete
+		 * it here so the queue is cleanly unscheduled after rx_stop().
+		 */
+		napi_complete_done(napi, work_done);
 		return work_done;
 	}
 
-- 
2.43.0

