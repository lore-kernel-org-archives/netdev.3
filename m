Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A43C9EE2;
	Fri,  3 Apr 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232380; cv=none; b=J9rvWmkzy6hkDpRVjL/DPWBsm1u6qYL/++54DrJK5Gz4zfJGXC9seVU9h3Fub8ZrsbLbF+TM7/arSBEfli6GOyW7qTKuHZUc1ZAxBUkcpHeQvc96bWQpgpl6JaOH3o9Ju2ofhNO2wHbVGya/GKpkg1TFNrsj5hziGqE7kUCsUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232380; c=relaxed/simple;
	bh=OVA9ySi2NDnxZL1XGji4sBrLrLk0Vex89+jaxSp8wgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oHPPR+1VcMdCrO5tg23xlZ4G+W8s0AYj8fZrg5xWjQsMMf8Qfs/Pdvu/UtvgtyvpGwsP6/bN8CldPKx90OtS6z3hWjxLi7qsO2ejt1rK7M0IQrvkfGBLmT5pvZnj1AWyfJX6Rzw5tWuamO64f75P97X+O76zEiW4LHi9EgTPrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMg1HUCT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMg1HUCT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ABF9C4AF0C;
	Fri,  3 Apr 2026 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232380;
	bh=OVA9ySi2NDnxZL1XGji4sBrLrLk0Vex89+jaxSp8wgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hMg1HUCTuyDeVGx97Qv8ZxKQ+SQCQiaYkz2Z1RO1Mevkcggl6ZsJeqkevFVjVJA89
	 IeN3kanqFQSo/2QHlS1xMNUgEOYzZ0WfEoKsVwKjXZAxzg5Kio1+pyW6sCs4q6RRUG
	 JGRH542ieaq5WdKgoEQFXAuDH/Kg9BujQStMcTeBZjQn4xDQ5bCY/OHRgnevdU/oOr
	 eYJrp2ihLAkhg7oJwRHb1ZkLCthbkTtD8Hlf7K4O+Dv90Qmt+OUkglSlS2uEqbST0Q
	 oLibVpv+hJ8AqI6SDMb8btH6P7QqmYi3f+fdAXKQptl51ONySN5qoS8jOuOADrvDBI
	 qdkkU3UuYAFFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D62BE8537F;
	Fri,  3 Apr 2026 16:06:20 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 03 Apr 2026 21:36:06 +0530
Subject: [PATCH v2 3/5] net: qrtr: ns: Free the node during ctrl_cmd_bye()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-qrtr-fix-v2-3-f88a14859c63@oss.qualcomm.com>
References: <20260403-qrtr-fix-v2-0-f88a14859c63@oss.qualcomm.com>
In-Reply-To: <20260403-qrtr-fix-v2-0-f88a14859c63@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=/IYkRv6TPT121VtWWvMGCswFaIzLb9VKFEQbapivX0Q=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpz+V5/dD8PbvIUlqd0cZdQwy4HKVv9WbX7+cOM
 ACM0pPpT2iJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCac/leQAKCRBVnxHm/pHO
 9f3AB/474jeE5ogQivj26joZxxPOfK7BJtqUVJPmApO/uhzYcsqAwTA9TAJMgfDZNJ5yE7uHIuH
 bpMxWSe9wPrhLeAG1sD+xg114iQAvNPyeIO9q50MYf0Q5XK3Wv4NBm9PVKg5swtbUtwhniw0UZf
 1YrdxMc41+yof73Kp0hOrB7RNSqxrl5Y2fppGtDYudx3oTLcGHGPhm5Yt19fPHhPZajLDDRg5op
 VMDxwcPGsvMx1JiZufRvekQ+RyWOJf9LMSs+VbUbnEuSdcTm3EAROtejcSME000uOjTb3tx4Lia
 OGCOuGjfEI8QRHqnfdrMljj4IklEscCQLniZ1kqCfnKSIGCT
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

A node sends the BYE packet when it is about to go down. So the nameserver
should advertise the removal of the node to all remote and local observers
and free the node finally. But currently, the nameserver doesn't free the
node memory even after processing the BYE packet. This causes the node
memory to leak.

Hence, remove the node from Xarray list and free the node memory during
both success and failure case of ctrl_cmd_bye().

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 net/qrtr/ns.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 5b08d4d4840a..c95014673135 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -359,7 +359,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 	struct qrtr_node *node;
 	unsigned long index;
 	struct kvec iv;
-	int ret;
+	int ret = 0;
 
 	iv.iov_base = &pkt;
 	iv.iov_len = sizeof(pkt);
@@ -374,8 +374,10 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 
 	/* Advertise the removal of this client to all local servers */
 	local_node = node_get(qrtr_ns.local_node);
-	if (!local_node)
-		return 0;
+	if (!local_node) {
+		ret = 0;
+		goto delete_node;
+	}
 
 	memset(&pkt, 0, sizeof(pkt));
 	pkt.cmd = cpu_to_le32(QRTR_TYPE_BYE);
@@ -392,10 +394,15 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 		ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
 		if (ret < 0 && ret != -ENODEV) {
 			pr_err("failed to send bye cmd\n");
-			return ret;
+			goto delete_node;
 		}
 	}
-	return 0;
+
+delete_node:
+	xa_erase(&nodes, from->sq_node);
+	kfree(node);
+
+	return ret;
 }
 
 static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,

-- 
2.51.0


