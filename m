Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F93AFCFA
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029046; cv=none; b=SaXLxAf1LD1KftTbtnwtgR66b7zi/DrlBVLDhOgNIiQF5qvEaE5wsZCVUsyV9H08blYlX0NcIHf5uPGwYE54qcvBWNKdr1mBfHobXNPsAI7C27S5uX2+pDwyIeWQgBJepABR+2numGp/yfK5g+aUWN2RGvSJfJHykW5fURN9WA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029046; c=relaxed/simple;
	bh=ofD9vuZ8WriYaz45r03nVr4VI+oGJALE7F2gieVLqec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDRWOKyBO2xhUljskF97wZkBxNlvTCAgE6DnQMk7DnrNyxIaTrFWVUFVNpyqEDX/JB3G6e2U/CDws1NzKtgAAPMM9CFGFdedd5cpNPZikP2xaNPM80RJMpIOT2yHEZXVE8MWnwy2D99y7yiRIikFowXlB4oHUR0HMUTNjLMhlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXAIdTxa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXAIdTxa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d8f265cbe6so58704855ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789029044; x=1789633844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6wVmYC8X8kmr5SDuvDPNWubkvtX+YkviT8aumfGWPQ=;
        b=EXAIdTxah2KUEznolYA9QbHZuHtM8f7JXCVE2rZomou/NVA/YKI2D2rIg9gYRBCQro
         l7ecsmLJunERYT8/afzvt+Xy1C0pd/Wk1LUjc8YZJA2RNb9xAF6Whtxzyq0BkTbtecBV
         vaLjrJ/SD03SDu67nHkkFfdCu4D54XerLNQHPgaHNFj1XzE3766AKU9j4MlryQ9XPtzN
         aNV2+m2HIY1SG8Kj/9V/Dm14agA0nhywDSBjhdgjAU7NlScG9S7a5gKELOFdlj2tFNE0
         ErMbKxF6JwFZBrwR2btwcytalwtcw2TSjsXG4mtM2NkmLBowET9HM1MdhJVMqDeNmUl9
         ZkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029044; x=1789633844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6wVmYC8X8kmr5SDuvDPNWubkvtX+YkviT8aumfGWPQ=;
        b=QnR7GBHuoQPC7dG7D/eUDz4bFHbOC2hEWkIQFNfP/wQh0XJ4Sx5F7LJ9OAX3Z+Cc1M
         0a3FyQyoU9RkEcOpMT2eiOnQ573ZUoNe7tvGv8mw7gAT99wyd56QL2M1zrK/3BZJEysb
         fIVvd8IvxasMQaI5TqLBld5iJPKZlt2mSXtBHg52KnlF2ItytBdeJkfTmTngJVCslqbi
         DBNzMDq/V5/dPwv56IBAT1gneCEwrtDGs0G9SabNcTBlXliGTkFvgKDCpWDBLqGff+au
         jhSIBn5lZuxPfYT1tw4/XvSGbwnBTCnMJza5xmrJs8yk7MGp0h5b1opJWnxjeawbOTxU
         MwjQ==
X-Gm-Message-State: AFuF++mgrbOT6gCflfdVBZGpaW3bgaCfg4UTemf3BzhX4yQndB2+kTZ0
	nsjGUk4Z488x6/I5F4d4PJAKL0bukIR3JwuaUZL/9SmBsZntwCvNUH+X+OsWCpbOI/4=
X-Gm-Gg: AYBFou1sgdf68pMT4veMMTOkO0d8MOciiU2om0TyONNwdG8mZuDShoM59hD9PCjJwtd
	cDLvfSfCswaDPS+emeoJ1gmxkvx9DtNexBpsfL73POfbjHjAUbi8ND8rIbH4i/iWH1FyQ9qj0IS
	o8k0cAcwtP4dGYHnDz7UF+Nd6ENhH847HFQSR2iwWlppXRX7I4VztEceQWnnDLVV8vTCsJXhFlo
	Bx8K84Okrp6r/RXt/1IX8RUfrumhqN/J54q7kblmvqXV0F8ICC3vuKVy0lVdCo9V4atnNB4ao+y
	HUXy2TIw7/5+r+KuMGcYUpNGZq80l/dg2jJFRI+9idZLpbynyh7OmrQRY4FEyhXz+XhHtF5+toX
	xalW8RUdwl/k5yqYgEXWwtowSvduyrG5QcFXoELvePXK5gUriRSHXbcQWT+0dVm4TvLSevV9TNW
	hl7yTfr+f5UZEYphofNB3Y5iU+aJ1DLlVStZ0yZX0DVvZqUGR7BDhvxqxsQLse8k2F2Rkm8yms/
	Qo3zQPTAxf0ew2hVI8e6ftNjvidGk4IRA==
X-Received: by 2002:a17:90b:384b:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-39b261e79f1mr57365893a91.13.1789029027189;
        Thu, 10 Sep 2026 01:30:27 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d776184fesm4464576a91.17.2026.09.10.01.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:30:26 -0700 (PDT)
From: henrymei <ljp1205831794@gmail.com>
X-Google-Original-From: henrymei <henrymei@tencent.com>
To: netdev@vger.kernel.org
Cc: achender@kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	santosh.shilimkar@oracle.com,
	gerd.rausch@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] rds: ib: use rds_conn_drop() on protocol version mismatch
Date: Thu, 10 Sep 2026 16:30:15 +0800
Message-ID: <20260910083015.2695284-1-henrymei@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

rds_ib_cm_connect_complete() runs from the RDMA-CM event handler with
conn->c_cm_lock held.  When the peer negotiates a protocol version
older than RDS_PROTOCOL_COMPAT_VERSION, the handler calls
rds_conn_destroy(), which is only safe in the rmmod path: it
synchronously tears the connection down and flush_work()es the
shutdown work cp_down_w.

That shutdown work (rds_conn_shutdown()) needs cp_cm_lock, which is
the very lock the event handler still holds, so the flush never
completes: the two workers wait on each other and the RDS connection
workqueues stall for good.

All other RDMA-CM failure paths (REJECTED, CONNECT_ERROR,
DISCONNECTED) use rds_conn_drop(), which marks the connection
RDS_CONN_ERROR and schedules the shutdown work asynchronously.  Use
it here as well.

Fixes: f147dd9ecabf ("RDS/IB: Disallow connections less than RDS 3.1")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Reviewed-by: Allison Henderson <achender@kernel.org>
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
v1 -> v2:
- Point Fixes at f147dd9ecabf, which introduced the rds_conn_destroy()
  call in the version check, instead of the later refactor cdc306a5c9cd
  (Allison)
- Add Allison's Reviewed-by
- Link to v1: https://lore.kernel.org/netdev/20260908123356.1163970-1-henrymei@tencent.com/

 net/rds/ib_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index d46146887ba4..2909da8363f3 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -115,7 +115,7 @@ void rds_ib_cm_connect_complete(struct rds_connection *conn, struct rdma_cm_even
 				  &conn->c_laddr, &conn->c_faddr,
 				  RDS_PROTOCOL_MAJOR(conn->c_version),
 				  RDS_PROTOCOL_MINOR(conn->c_version));
-			rds_conn_destroy(conn);
+			rds_conn_drop(conn);
 			return;
 		}
 	}
-- 
2.43.7

