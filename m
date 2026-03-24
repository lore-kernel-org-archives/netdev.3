Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D7388385
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363619; cv=none; b=o6LO2/nT2YVy7neRiScl5mM67ULNo8xyHDUWdcWbYiq53VJO3oDEYXR803FWCzPyJsr2YFEnoGJ3fEO9bn5ibeLvQYO5nYjRLo/3ehUSi1v/5Ik5IM8vlMhrFNPhLnqtjLMnBuRsht+7UQXoU5nZprOUvgkiIXqdgXgi3Ax2hCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363619; c=relaxed/simple;
	bh=+vw2JkvCXKRoQRcER3jPQEIB++vTT0CoMaEKfyNHHnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/hhwh7uTzIn2A/uDQ2acxxl0ieGJ9NLODGnXky7vYAonUTNCpYV/duEtT64E7FmlH1z6HtGGybP+Qbye1VszEUTJoSnw88/7pFsayGUweYna7kSN/JVpYJ7L4z2aJtslK4oyg+k9R/M5MEqFkMinJuh94CmTfOGIoTQCiDsSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LzZiI3Ea; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LzZiI3Ea"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCZCqssiuCqpmDoMVvWj4+RE/eoOZ2EbUqziqvm6HAE=;
	b=LzZiI3EaV3xqq8q2cS9KbpOrXyVJPdlw6PFnemCb943VNufnok1Vu1LyHe0hZxrfDepRON
	wSifnPrhgC8LuV17KcCqVSh3cQdN5C7Ua2Pp7KdEFgLSROMCscYZmOtT+ehb8gibbvhAL7
	/cSQR3R+mWvcYU5F8nL3wsO6b7BjfUY=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 1/7] net: hsr: constify hsr_ops and prp_ops protocol operation structures
Date: Tue, 24 Mar 2026 15:46:24 +0100
Message-ID: <20260324144630.189094-2-luka.gejak@linux.dev>
In-Reply-To: <20260324144630.189094-1-luka.gejak@linux.dev>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

The hsr_ops and prp_ops structures are assigned to hsr->proto_ops during
device initialization and are never modified at runtime. Declaring them
as const allows the compiler to place these structures in read-only
memory, which improves security by preventing accidental or malicious
modification of the function pointers they contain.

The proto_ops field in struct hsr_priv is also updated to a const
pointer to maintain type consistency.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_device.c | 4 ++--
 net/hsr/hsr_main.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5c3eca2235ce..90236028817d 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -616,7 +616,7 @@ static const struct device_type hsr_type = {
 	.name = "hsr",
 };
 
-static struct hsr_proto_ops hsr_ops = {
+static const struct hsr_proto_ops hsr_ops = {
 	.send_sv_frame = send_hsr_supervision_frame,
 	.create_tagged_frame = hsr_create_tagged_frame,
 	.get_untagged_frame = hsr_get_untagged_frame,
@@ -626,7 +626,7 @@ static struct hsr_proto_ops hsr_ops = {
 	.register_frame_out = hsr_register_frame_out,
 };
 
-static struct hsr_proto_ops prp_ops = {
+static const struct hsr_proto_ops prp_ops = {
 	.send_sv_frame = send_prp_supervision_frame,
 	.create_tagged_frame = prp_create_tagged_frame,
 	.get_untagged_frame = prp_get_untagged_frame,
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 33b0d2460c9b..134e4f3fff60 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -202,7 +202,7 @@ struct hsr_priv {
 	enum hsr_version prot_version;	/* Indicate if HSRv0, HSRv1 or PRPv1 */
 	spinlock_t seqnr_lock;	/* locking for sequence_nr */
 	spinlock_t list_lock;	/* locking for node list */
-	struct hsr_proto_ops	*proto_ops;
+	const struct hsr_proto_ops	*proto_ops;
 #define PRP_LAN_ID	0x5     /* 0x1010 for A and 0x1011 for B. Bit 0 is set
 				 * based on SLAVE_A or SLAVE_B
 				 */
-- 
2.53.0

