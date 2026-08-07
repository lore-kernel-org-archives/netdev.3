Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7A446075
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082546; cv=none; b=FuNZDKoxlh5C5oS9oDqsB5Gk/8Zpo838Hk9S4glsiFkbmUL/2veBrue6f+sBxm/4n1Jj77sYCqLyYnDM/2S65uuBHzKkLerBpdVgJg81iZO3a1yqgSL4Zmk0Q3pSlQimlPwCnBNJxkdmQP6w2GN6gmxlnzDxSYO+y7GP7dqM4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082546; c=relaxed/simple;
	bh=4Pe3fdbiUy56V6BI+59EUtDXrTynQb7K5p4rZeNG4fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQbDe2rDP7RrLFqHgeWN9Wa+yZZ51y9tvTlvLY2end+Z2ROLOPam5nF/UBLsj33mHJPvxWBetdhUsd9fGU1OT/MvfEfLOZqcToPdBm4Lq5V3XgdLVmJAaqMRbfu1bF8j1POGioVOd8rYOO2S0ygvLL4Q+JooEgbwkwKdkTTTPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iH6Prn/b; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iH6Prn/b"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786082532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s3sPKaCX17XtWEXBh7qWAvSwR+mehRTWCUCIxQOvnvo=;
	b=iH6Prn/bfs3c7xTnHOrUTVrGdjQPbWkYbGseSpJDkj8fbePRn0rB47N0fe8DmblNjco4+6
	cu1mwEh95g441fKfYGjiH9HarCOpBAD2z0Ykt1bjfUNZVHN3TjRvd4vuoocKPXAkPX3yh/
	fZqzBSMFiS7YZPfe6mpkRP7CvMvvG/k=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH net-next] ppp: update channel locking comment and doc
Date: Fri,  7 Aug 2026 14:01:50 +0800
Message-ID: <20260807060153.1380548-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit ec4215683e47 ("ppp: defer channel free to an RCU grace period to
fix pppol2tp RX UAF") defers freeing generic channel state to an RCU
grace period via call_rcu().

Update the SMP locking notes comment in include/linux/ppp_channel.h and
Documentation/networking/ppp_generic.rst to reflect that in-flight RCU
readers can complete safely after ppp_unregister_channel().

Reported by Sashiko.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 Documentation/networking/ppp_generic.rst | 11 +++++------
 include/linux/ppp_channel.h              | 10 +++++-----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/ppp_generic.rst b/Documentation/networking/ppp_generic.rst
index 5a10abce5964..4c81a0c64fe0 100644
--- a/Documentation/networking/ppp_generic.rst
+++ b/Documentation/networking/ppp_generic.rst
@@ -213,11 +213,6 @@ The generic layer requires these guarantees from the channel:
   ppp_register_channel() is called until after the call to
   ppp_unregister_channel() returns.
 
-* No thread may be in a call to any of ppp_input(), ppp_input_error(),
-  ppp_output_wakeup(), ppp_channel_index() or ppp_unit_number() for a
-  channel at the time that ppp_unregister_channel() is called for that
-  channel.
-
 * ppp_register_channel() and ppp_unregister_channel() must be called
   from process context, not interrupt or softirq/BH context.
 
@@ -233,6 +228,10 @@ The generic layer requires these guarantees from the channel:
 
 The generic layer provides these guarantees to the channels:
 
+* The generic layer defers freeing the generic channel state to an
+  RCU grace period in ppp_unregister_channel(), allowing in-flight RCU
+  readers to complete safely.
+
 * The generic layer will not call the start_xmit() function for a
   channel while any thread is already executing in that function for
   that channel.
@@ -453,4 +452,4 @@ an interface unit are:
   fragments is disabled.  This ioctl is only available if the
   CONFIG_PPP_MULTILINK option is selected.
 
-Last modified: 7-feb-2002
+Last modified: 7-aug-2026
diff --git a/include/linux/ppp_channel.h b/include/linux/ppp_channel.h
index 2f63e9a6cc88..7332e32a448d 100644
--- a/include/linux/ppp_channel.h
+++ b/include/linux/ppp_channel.h
@@ -79,11 +79,11 @@ extern char *ppp_dev_name(struct ppp_channel *);
 
 /*
  * SMP locking notes:
- * The channel code must ensure that when it calls ppp_unregister_channel,
- * nothing is executing in any of the procedures above, for that
- * channel.  The generic layer will ensure that nothing is executing
- * in the start_xmit and ioctl routines for the channel by the time
- * that ppp_unregister_channel returns.
+ * ppp_unregister_channel() defers freeing the generic channel state to an
+ * RCU grace period, allowing in-flight RCU readers to complete safely.
+ * The generic layer also ensures that no calls to the channel's start_xmit
+ * or ioctl routines are in progress by the time ppp_unregister_channel()
+ * returns.
  */
 
 #endif /* __KERNEL__ */
-- 
2.43.0

