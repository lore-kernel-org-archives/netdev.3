Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16D481FBD
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853605; cv=none; b=kABINQX++QelencDaC3FMzRSJ+z+FeEMZmMM1+cm0C/b1Oi9gQkoqtn3oY9J3czVuBRMUA99NWz4qNmDJiKe/Wf2xET/cAkSIs/k+TZGuI2eo3J3IUjF3dsCcvkn5ZCRg/6crSmQzmP2QXhzIXls9y6cCC2lM+jV5kd7N8suwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853605; c=relaxed/simple;
	bh=Usz/B97VtrR110956ILatJ97eXmS2ovdzWIT8Ytpas4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMhdMzTBu7aab2+YT6Zk1kqiCac0KEX/BwqZrDW5V+/94MSJrU2Ye4flXKmyDL0yvAcgKBZM++OtKmFCETHdj8gkAfM4MUvpephkwUcI9ScclAHZppc9Nqa2vEMYPR/VZEIB2HS99Z3kx/kxwoBnF/d5Yht++0AfZL6rZRp54zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=WMaeIiNM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="WMaeIiNM"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90fbf21d9d3so456068985a.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853599; x=1779458399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hN6SVRJC1Wye8mJdJNrkkfeZqabayMeuzoTHVMW80R4=;
        b=WMaeIiNM6UOvYj3aifenYcMghXhp9svTYwDyh4r7JIL2K3pqubqElUS0Uczu7YIJld
         Gh2XZwCE/GqywrP15U5/P8VTrMy/I9mKyv3txnGmWAFhENcLh0stbcp0EKTfc4KEGWYP
         Kxyls69ifAExbsneSINAPRyQwVfl4ZhT5LmVCmx/faRlHoup2zcuvVdhW1mMDFKqr7zI
         YD7Dxl5qHpzaVbpX5A6t+ZhzSKx2sZ6UW33fiF8OsVcmzn33L6ykN1y/1fPb/hF9JLAr
         Aqnwh+rKXU6exfROL11ssYOkWRiDva2JMYIpQNr5FPeZOzMIoVFEy0lWC6sRd5smCPfI
         mlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853599; x=1779458399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN6SVRJC1Wye8mJdJNrkkfeZqabayMeuzoTHVMW80R4=;
        b=ilEwse1cDyIYrDiyfqj/w13iOICPaRSE79b/6GEV+DxoeqJWOVjyBtDx8eHIdYqbk2
         gyWVpsqcJuMB4m5m+/g5m8I+jJfn5TtS93XCKqCoVoaoa/Op+15SkDL01OGgcTxt+yRU
         aqmD7mO3TZFh78ZrVzzQfGQPv3yNiSEN56P16hb6v255cNTslsil5KxHyoHMOvARFHnW
         5bdIVnycY6+o2r1czPVTADZOCpzBTbPpdSoiFIF/sHLy3bGm4mB1BSZAOwrPwUdtSx+p
         V21DtTjjJe+MzSQE1l58u9B5bBudIvzukrgc09D+NzXg1+j50DBpJuRfUAOtgU5Acyhg
         RWjg==
X-Gm-Message-State: AOJu0YwhTcsIGk8gjosoXd2lMGJZ8j71pMS9p0XHayOoUpMF6IwWmQcY
	EN9XB3vMfucgZhmjayXCKIIdIrpyXJ6OARbWdMlaKGq+RgBWyZpiN7hEk/CX3zEDnfU=
X-Gm-Gg: Acq92OHlyc+5gXY3EvjS/Bn0jtShd0NUyyYBW3dc09tshXIKDFdDpJCNiSh3fKx+HIK
	4qR23XTkP9n01nrvG4w7QsfdrwM7iL5/Y+g6ItMWRivreb6MJgYsGMxkJKOl1N4cv6MQZTI0UJj
	ytjDN0Z8Vjg50qduvSvjJEXWe6RWImqYLB32mpybhbzye6gVZv/FgfvFuKmlsrhUMq1sOOa+J4j
	/Pc6ai+zW9A/CxVi8oTIbg+V3l5YfxvqOLvC4OJY4p/VWLV0PBgcxceF5fdmTrnotDuG4lZth96
	jyqzgmpnnuCXR+X0Az6JKl3oULyO9vjjQ6QMi56WavEYG3KJueeClRDUUkg3UCG2u0zLXMvMNDl
	Ca3MVyNJb8FlXCOFd7wIlXc6RHS509vqB212xuR671uNNoqKKNCj2TgRBIwP0vNhlg9vLQpHgeh
	NA+3JyHAcpZOSlWajEyLv6CXkAoIVB
X-Received: by 2002:a05:620a:4104:b0:90f:57f9:c934 with SMTP id af79cd13be357-911cc6ae514mr661068185a.23.1778853599283;
        Fri, 15 May 2026 06:59:59 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf35843sm543167385a.38.2026.05.15.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:58 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 09/11] net: devlink: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:53 -0400
Message-ID: <20260515135953.2238907-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 net/devlink/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 8edb31654a68..d54276dcd62f 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1497,7 +1497,7 @@ void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
 
 		devlink_trap_report_metadata_set(&metadata, trap_item,
 						 in_devlink_port, fa_cookie);
-		trace_devlink_trap_report(devlink, skb, &metadata);
+		trace_call__devlink_trap_report(devlink, skb, &metadata);
 	}
 }
 EXPORT_SYMBOL_GPL(devlink_trap_report);
-- 
2.54.0

