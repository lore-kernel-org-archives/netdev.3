Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830592D2486
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783861519; cv=none; b=T8WcW0GK80cHOgdM237J01T/nNH9MBkmLg6575nR/uy5Ujuupmb3XENoD/ncX0O4uRwu6jBW/67t3ef745nkO0bNwWoYdz+MLIHysInyn9nchJq/TQq9P/QmUoQMyMYz716y2Dz4dWV3SsS2HqgoZEXLpRMUf/dTgauDueK+ees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783861519; c=relaxed/simple;
	bh=GUp3PmnFmXHoEhrHLOH8q4YGU/QcMp1uvL4xYuiuYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5whh/4krpk6E4YKkYfTz/9dOc+PILPbrlmCqudRs/VzM3GbGS/NkDlL/0OP8ZZUsYQIOdBLUEO7/xb6IMjAYgcaWRt4x92PFz3ldxs4pIPEYrfUx8EwiFo8ND2Xrh5eT2FYvZaf/vdz07aW/sUTKR4CxU8w27UEm1Yja1KmH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tkfF8o5e; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tkfF8o5e"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783861505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9T+JTQqyK8bJsfsDIZygaYxhXti8DrgIowVgz9xghEw=;
	b=tkfF8o5eMabajNpylI8gbbgnE5DL0YGvdMF/rAtKCIWIS7Uf2/FWsv4tkb3EqbzcqH87yG
	PHI02nnFXKnvCYIYqZOU1SDsYlwtG1dKZgyHqpEq0rLew3wluoKUEhTUWphPVZLT9TxlE+
	rfEzr1ljBwNgkxpQYhUQtO2CDlsCK4w=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	opurdila@ixiacom.com,
	tim.bird@sony.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] llc: fix SAP refcount leak when creating incoming sockets
Date: Sun, 12 Jul 2026 21:03:43 +0800
Message-ID: <20260712130343.518797-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

llc_sap_add_socket() takes a SAP reference for each socket added to a SAP,
and llc_sap_remove_socket() releases it. llc_create_incoming_sock() takes
an additional SAP reference after adding the child socket.

This extra reference was balanced by an explicit llc_sap_put() in
llc_ui_release() until commit 3100aa9d74db ("llc: fix SAP reference
counting w.r.t. socket handling") removed that put. The corresponding hold
in the accept path was left behind.

When such a child socket is removed, only the reference taken by
llc_sap_add_socket() is released. The extra reference keeps the SAP alive
after its last socket is removed. Remove the obsolete hold.

Fixes: 3100aa9d74db ("llc: fix SAP reference counting w.r.t. socket handling")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/llc/llc_conn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index e8f427375c68..260460d50f54 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -767,7 +767,6 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	newllc->dev = dev;
 	dev_hold(dev);
 	llc_sap_add_socket(llc->sap, newsk);
-	llc_sap_hold(llc->sap);
 out:
 	return newsk;
 }
-- 
2.51.0

