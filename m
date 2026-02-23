Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC637C11A
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884145; cv=none; b=jg3iMCqYszy8wIKx0klVB/fpy7q4vDukTUyj++gzy7wpHnPpymisZuLj60JaBrBFUMGjjb1LbRRFXEWTU46tFUEBxvawDYhgQMk3MxF/zHtb0WBg6vz19XzLM4pmMEHYl/celcTzt48Rm1dsn/yB4Nw1zjHZNB7CbGOSuqwRtKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884145; c=relaxed/simple;
	bh=XjmKL5ufHjG1INwngrpP95dTAuCrPWOQDsLmY9gCcrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D83PDGLy0Cs66TUJ4RdK4HsdamAdj+WmGEyPCRyLPUaO40byBnYswc+9Zt2wTXMFmlKUMlC26qhUjz2YTZR12LDyerFLtwZuPwFRnXMYWH5ODwODU2zLmvpN3bO8JvKcvX7pdChzeb6TDnlAtU3cCHQSk1Q2utz+RbXbGPbqeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DwE9Z1wi; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DwE9Z1wi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONfK3RyoK+GwAdc5BjQKSqsRziV8FtwNpHEUC0TGJss=;
	b=DwE9Z1wi1MAekfOAxy5CHviYv+Gq69GI1wMEpsMJBqtg61ztfB9eYixrTe9GUG7Hfh9dZC
	ly6dPbnFr++O1PDHJDbvxcfut9UxEAGb4lr736tQM+4g6UFn0vMVy2nYiHhz9otlaTHqWx
	Fu2RoDei9oEsH7zvdiRx3tqgyEohfNY=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org
Subject: [PATCH 18/62] bnxt_en: Fix bnxt_dl_reload_up()
Date: Mon, 23 Feb 2026 14:00:18 -0800
Message-ID: <20260223220102.2158611-19-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bart Van Assche <bvanassche@acm.org>

bnxt_dl_reload_down() calls rtnl_lock() and netdev_lock() if it returns
0. Hence, bnxt_dl_reload_up() should invoke the corresponding unlock
calls. This issue has been detected by the clang thread-sanitizer.
Compile-tested only.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org
Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 15de802bbac4..1e9a3454bb29 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -562,6 +562,8 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		break;
 	}
 	default:
+		netdev_unlock(bp->dev);
+		rtnl_unlock();
 		return -EOPNOTSUPP;
 	}
 
