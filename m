Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D4387378
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688180; cv=none; b=Uc8jMkPvkN1/8tWVgMdJ5Zolk7e6hJdRdUntEzhTU0BExG4GTbn98p3utP7X/HUK8/INlhgailSCpUGDpI3V6j6UkfHxXyXS5diBLK5PUksOdIMI/pcrjZiLO5QQ0JX1TvBjkQ39PQ+Ogeu+40npTPfEBAqp/Hr5sNwuZCk98lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688180; c=relaxed/simple;
	bh=wSj/Bziwj2nKmZlwT90+vNBfPdmMDOGVBjj/fVWpTQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvmoULg2PU2zO8fI05MTZILi/TGiB8EEZVRnsvo3/m8a1zXcxTCx8AwQgQb4/NMykXkSPtSavCkd0LWeaXS4ZntYP7OQPf+Zosyp/zj+bhUYpJWr9+byhp/ciRXmfSyzcOpiJ0ND5r/dGLedo+1vifCLR/xgRy/koTXMMEMcf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iznWfC13; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iznWfC13"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so368732a91.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787688178; x=1788292978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B3Pi1LU2yqNrQy/N3chmYaA7JCHAIIMXZlkkYLifKOw=;
        b=iznWfC13XjXB4QayCT0wCmxdnlnZbrZbkCPeNS6DUZIyJ25ozilf9yA17tOSp8qto7
         b40Zu0DmVXmKz178Xl1ZEWrDpES6xrHHCZumhAfFShwTv3Eg0Vof7HvHI/ia/RH9e3k7
         q6Kw9Ncu7Wge8Pw9quPK6Pz5+xrOeiw4psG28g4wr54c7d5G+4fg5OmmYzDu9wqYkJLx
         ZW4Y4IxUt9n68+/j5R0KxzloRTqc4GwGRAa0FgIyjmqfmltqeVajY8SmlD7jG3k+AuUV
         OUxUXk//ir0CEDBc3Vauer6sNNz+S5Xz87WHShDZzj5Q5vMGDBJuaqeNzQquBlNnllPK
         FWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688178; x=1788292978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3Pi1LU2yqNrQy/N3chmYaA7JCHAIIMXZlkkYLifKOw=;
        b=TIQ9VSYnB5DaP///+qEYZ3Hzu5zu+ld1SaPfeRVW8Vd7Xh67JykkGyJ06JQHeARirH
         VPnvy9Y3ArPPbnpUccCX5YsUlsJWvUYkYUI8z+EG4ZnfYB0SeyNQVJ6Y/ZPVV0vyUzi3
         S7C6ChSlkGWFrfUNXltdevInnkL1fC/GPdWerYBSjDgrcR2/bk+7DZbUhzrYNQzj+Ux9
         HqpVSHCMF69866T61/J7dp+SKvIqMqooUpd3/Khy+VLnJbKPwTTNH8QP9PcKbma8lNih
         SlJQ5TLKpAJWfPs+qGgtKMsUZb9bxQbacVVQUfaPWu7TWcenR6wHMfZjnOhbXl7OOE2J
         QnIw==
X-Forwarded-Encrypted: i=1; AHgh+RpHMe8kCPMV19gmhxdVt8L0Avamjz/9gwCVsC3NuXlYzI5xSx5/2W1X2njw3XqdpKjH26WHDec=@vger.kernel.org
X-Gm-Message-State: AFuF++lDNs2KakfQcI2CQC5AZMvwBFWBf35gTOH9BbmlGX96tZKQj4ti
	lsROD3qrMnpa+w1mhPAKA/0ivUuTGvtJihYUHkIPyx7bWuA5OKq/IqMV
X-Gm-Gg: AR+sD11SEnTjUMsLBP+aZLhHLH4I9WDzaNK6R6JOKKc6GrJhvwIaMzbwkKLHySXpPEP
	iLNAnqD5EzEf3pQzZUWsCTXipXTjF2qM7G/1LajrLLJINFArGq0t72Uh0CLdfxtvniFlpWthxkM
	/JqD92GIBHHFV6Dgj6fcpPIey0CCGPbF31VML5aqTSf17sleXmJYYQVBMXEnChfzXNW+OKjyBYB
	GQIdHWFMV8jbISgdlG4jrnAZBeHKBg1xxoyLHFDdfTF34ipnFNegeJfuWMozDd+xeqjDhYPz6QY
	40fX8acFM3r2jNo7V0uq9rO3DMUSRgCFLWiB5CR7cF1GGBDlPLpfjjkhVVbs87mfUC4CRSHNMg5
	MmzQC/IdFLFvmBI3WUTk/KYr6kadpAHInse/pZQ+qiPSnjkHjYoWDAW7c6KSjmix+JQDq0vxR+K
	7o9J+ZHwp80eVRYJEp0h9RHv53D3YlDqDOHXctHiNOm8VZB1hKNClJcoLBC5fW8sA+s4vFc79f6
	jZK4uzoZBQpkY3+wTedbA==
X-Received: by 2002:a17:90b:1d46:b0:396:5fce:8e24 with SMTP id 98e67ed59e1d1-3966d197b6dmr3482328a91.4.1787688178216;
        Tue, 25 Aug 2026 13:02:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1012:54d7:ed:5a29:eac3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396686e840bsm952049a91.2.2026.08.25.13.02.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 13:02:57 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: phil@nwl.cc,
	horms@kernel.org,
	xuanqiang.luo@linux.dev,
	kadlec@netfilter.org,
	kees@kernel.org,
	enrico.pozzobon@dissecto.com,
	sbrivio@redhat.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2] netfilter: ipset: add synchronize_rcu() in destroy to close use-after-free race
Date: Tue, 25 Aug 2026 16:02:43 -0400
Message-ID: <20260825200243.23077-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The child set refcount decrement in list_set_del() was moved from an RCU
callback to the synchronous path, so that userspace sees accurate
reference counts immediately. However, this broke an implicit invariant:
previously ref could only reach zero after an RCU grace period,
guaranteeing all RCU readers had finished before destroy could proceed.
Now ref can hit zero while readers still hold a stale index, and
ip_set_destroy() NULLs the slot out from under them:

  CPU 0 (softirq)                CPU 1 (control path)
  ---                            ---
  rcu_read_lock()
  index = e->id
                                 list_set_del():
                                   list_del_rcu(e)
                                   ip_set_put_byindex(index) // ref->0
                                 ip_set_destroy():
                                   ip_set_list[index] = NULL
  ip_set_rcu_get(index) -> NULL
  BUG_ON(!set)                   // crash

  kernel BUG at net/netfilter/ipset/ip_set_core.c:754!
    ip_set_test  <- list_set_kadt <- ip_set_test <- set_match_v1

Insert synchronize_rcu() in ip_set_destroy() after confirming ref == 0
but before NULLing the slot, so it only pays the RCU wait cost when
actually destroying. Because synchronize_rcu() sleeps, ip_set_ref_lock
must be dropped first, which splits the critical section in two. A
recheck of ref/ref_netlink is therefore needed in the second section,
since a concurrent netlink dump continuation (which does not hold
nfnl_lock) may have incremented ref_netlink in the interim.

The bulk _destroy_all_sets() path does not need this recheck because
its is_destroyed flag prevents dump from taking new references.

Fixes: 439cd39ea136 ("netfilter: ipset: list:set: Decrease refcount synchronously on deletion and replace")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Closes: https://lore.kernel.org/all/20260820010617.46851-1-blbllhy@gmail.com/
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/netfilter/ipset/ip_set_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 0a86a170ba90..1295bea7944a 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1225,6 +1225,8 @@ _destroy_all_sets(struct ip_set_net *inst)
 	/* Must wait for flush to be really finished  */
 	if (need_wait)
 		rcu_barrier();
+	/* Wait for RCU readers before NULLing slots */
+	synchronize_rcu();
 	for (i = 0; i < inst->ip_set_max; i++) {
 		set = ip_set(inst, i);
 		if (set) {
@@ -1286,6 +1288,17 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			ret = -IPSET_ERR_BUSY;
 			goto out;
 		}
+		read_unlock_bh(&ip_set_ref_lock);
+
+		/* Wait for RCU readers before NULLing slot */
+		synchronize_rcu();
+
+		read_lock_bh(&ip_set_ref_lock);
+		/* Dump may have taken a ref while lock was dropped */
+		if (s->ref || s->ref_netlink) {
+			ret = -IPSET_ERR_BUSY;
+			goto out;
+		}
 		features = s->type->features;
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
-- 
2.55.0
