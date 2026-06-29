Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706B36A01E
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757878; cv=none; b=Nm53rEWyU8Uk5n1TBmN/m1t60YT2ml0/EODI0YrJXMRR6tppZhyg8i9gtTG9X5cdP90LUMR0jr5+g+LxbPwQvSz/7r6pKxRz5yJdg/5HMgVkU9Riwa859pTBSmwAIvzFAEogguqzbgKM5Nn4J4mK4odNDiMp+GALG/VeFZu+0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757878; c=relaxed/simple;
	bh=OwrnCwQOhMDuGnx9pE7dZOEyMC8AyvBKRK+CfPd0rpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXl6upKbJ/OMUNtEC6Y+Kb6dAHNdCp/kHNGNgzqTVjcOfpDF5ZYn52Ace7Hk0q28PJP0qWUl1lpskDQDbQsUfrvPikg7dd2k5CpQVo1TxMWVCfD90aDYhjgM3Zy3njS14pJsyQvLgD+paJqCB0QcvYsaRvtKi13fFtXNWSoS4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRY9IU+V; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRY9IU+V"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e50a650a0so98460985a.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757876; x=1783362676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FH0W5s30/m3phVMwbdnAjH+UYTF+M+YW+Mbz2wNV4c=;
        b=pRY9IU+VXgXW33L2qO4qarnzXzzBggJAlVEc9qvuVZZd3s1mnc10zY8JeuMxzOWu/9
         r/L/z0VjC5Ytsi58o+ScRQHBdxzhb9HR7HY50vjls1drH2UrWzLcGtr3Up4YM6yiljgY
         BAocPwv7+9m4dhqZVcG59Qz375e21DPUy6c4uuEKZysqgnp89JsPxM5ctjniMullrSO5
         CSOOwjkcYU90sgFOrhTphRQi3Gyscl0K8Xco3REO0KY1mhE9TE1CchQs5K08ebgKT5ni
         64T3yWxbVgzpVcO81unSlDtUU6Ztc71g+uY5vQ8kLAh9E+VjfDeFP//w4HR7WbMQ6Un2
         0V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757876; x=1783362676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FH0W5s30/m3phVMwbdnAjH+UYTF+M+YW+Mbz2wNV4c=;
        b=Yjn+flNgWUmb+wIGFfmOoa7elU3FHBHiEk8jDKkIUg9js/vQhnqgXAYXMAaGsysdNA
         2U3nsdTG3WoyETuvq5jdFi5uFQ9GDa2VcPjTX0gmymkddTxkn8DeDIujkpYzmiwkIwa/
         ClE4u4598+1LYB5JAa0Avg3yJ8B1KTkqHn6TrcfwkDZed7JyJ+tV0WkOOHBtpxICnNrz
         VyN3k6KLzkPPcnoNECenuSkQ5uQ38SsLnWXkSreaHh5OAhgQG9SfSpOh1UYjkm4Nd60n
         khHg6/ceH3cHXNM2iUQm/1dnCL18Ncl3xZBLajT3IqauKx/qlQ3RHFKYeyvvQoiL9fkj
         ZisA==
X-Gm-Message-State: AOJu0Ywj9zE62NsUjigDDFd42XVmYQG+Rn1ybSkVIEHYjvSb38HCJthy
	Z3rVYUvDOwi11dI4k7dTYhRW3KFehpsZ8xHVE8IOr/4HHNLrFuGV5fxT36wHnA==
X-Gm-Gg: AfdE7cnQfZI3Qzyy9adb4t035ThjQ5ZKluUz0hCPQ8B4uhdik95ff6tIdhzVSknSLKg
	L59WlQUkQ64FM8/x49k4gpWX8USYsVlSrBj05/v6g+8pACohpzbcFYOAjyNTjy5PuWXWF5n9TFR
	23h3rWKbaFg+go8fHEWgs1CW1nbGkV+noeDVRqlXmtFWePCqzo7h8WNsEqandT5eYMCKqempyTt
	3BCqbWQ5u4dDs0TvOrQign1RKQaAzU57FLBXDRxl4XBFyjcdKUOigY0i68QCJNCRPYUrJRWxrpZ
	J67LZFt0vyeHhz+NZQUs/ijNF9oXKopmswslZNU0e3CkLYE29i/z+OGt2DhhywUFORr6DxA7m9D
	WHTlyHhhjYhEs8IMDDGcla6hOs3ATxHj/yI2kPrBu1odb6mqWS86vTvsHyZrtodPGL1rjL3RvlM
	sFhQY5vfiyAynJDhWu8Dtdtg+y453E/AgbUj6jyfOOtgeax0gl8cY31tAgcCgzqgqRoa8yeC3Ds
	LaieA8GXsRfMFqJFjTEXFcXM3plC+twxp9PPQTfpX64OUkY/U1X7JE=
X-Received: by 2002:a05:620a:1d01:b0:92b:67e6:8ab1 with SMTP id af79cd13be357-92e627dac3emr118120985a.59.1782757875730;
        Mon, 29 Jun 2026 11:31:15 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62388e43sm46547485a.46.2026.06.29.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:31:15 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH net] sctp: fix addr_wq_timer race in sctp_free_addr_wq()
Date: Mon, 29 Jun 2026 14:31:14 -0400
Message-ID: <5dc95f295bdb5c3f60e880dd9aa5112dc5c071cc.1782757874.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_free_addr_wq() previously removed addr_wq_timer using timer_delete()
while holding addr_wq_lock. However, timer_delete() does not guarantee that
a currently running timer handler has completed.

This allows a race with sctp_addr_wq_timeout_handler(), where the handler
may still run after addr_waitq has been freed, acquire addr_wq_lock, and
access freed memory, leading to a use-after-free.

Fix this by calling timer_shutdown_sync() before taking addr_wq_lock.  This
guarantees that any in-flight timer handler has finished and prevents the
timer from being re-armed during teardown, making subsequent cleanup safe.

Fixes: 4db67e808640 ("sctp: Make the address lists per network namespace")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 587b0017a67d..cf335494bffe 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -663,8 +663,9 @@ static void sctp_free_addr_wq(struct net *net)
 	struct sctp_sockaddr_entry *addrw;
 	struct sctp_sockaddr_entry *temp;
 
+	timer_shutdown_sync(&net->sctp.addr_wq_timer);
+
 	spin_lock_bh(&net->sctp.addr_wq_lock);
-	timer_delete(&net->sctp.addr_wq_timer);
 	list_for_each_entry_safe(addrw, temp, &net->sctp.addr_waitq, list) {
 		list_del(&addrw->list);
 		kfree(addrw);
-- 
2.47.1

