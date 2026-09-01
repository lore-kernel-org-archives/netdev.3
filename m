Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0C37BE7B;
	Tue,  1 Sep 2026 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268852; cv=pass; b=fKqahGA6nq6chhBvDLB3OtlrATYaSfTc26xxhLP2W7bJzbCMtS2Bdap2hSJ/dFYK8j1QbX5/Wlp+/V28Uxt4lOGNOpC5MDWefIBE2Ey5xSptVMRAiNbZQQGoEI74pmPnbyEO+lpTrgZ+bGLqlI0nIiBYiU2trhqC0+zg0reMZWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268852; c=relaxed/simple;
	bh=mnCg6IjXPDA18F3gCIoGu45zsMeW4iiwBq36VbdhGrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0oU3lBchfg81GuOodRzERnlJhQEtpR0N9M+Gj3yZyXKpg2o2+ttJ9PLk0r2qajNZ3goEtdQToA1sRDtYyRLjo1m9C2ic+H6SVN8DKYKnrRfHIYe10PXiAaj1gdabaWJnpgdbUaFJ4FeFcspbRmHOlGP0gNB066KIBeQj9Rq+/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=foDnk/vI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="foDnk/vI"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ61R3My8z49Q7h;
	Tue, 01 Sep 2026 16:20:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2arz6d4RrSmlewlrh+D8m1nv0qdMIfe9W1Or8yisS4=;
	b=foDnk/vIZIMSWCHM+A5m0/nYMD9G9G5v35GeoIXFocFzWBF36CNCuiKcDYMhIa7lRgaXwH
	P51MB3pVxMc16Ghpydb4pd0jVPSTuq1o0enQDzK0tZV8aDrlB2NrUokAFB300yPtaoePPG
	9dmc8hL9IM6kTrNLHrP19xT2knTMftuuEdtHzwOeP0u+kcBHmiPZwncgkkHTaUBc36lheG
	eVfA9Z5UY/o6XUlxgG7hUUiNVJmDJxY1g7XwnW3AlkyK/yIq3gZp24ZnWkcjmAFrcEmtuS
	dKryAHFO6rhCcGhnaVIne2NlM6YCltDbfUHVHoENwwQRFSZ/oBGA058Ho5uF+w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268843;
	b=EeiwNAvAdHhH6YbaQJD6YRX8LdW+QHeyr25oWEcaLYaSrEdhyFJVvv2DoAH/1KoVuuCFni
	Z+602l9MukNV+iEShknDtET1aSg7NYIxifX1A4EuZstqRqQKS0dCnPVO2RmfiRV6XF/U0J
	BZ1orB2G22td30NMpkFblE04WAGBmN6c9GmcAkR0q8w2rML+Cd3mOeT3nlbLqOrivVOBLJ
	To6a/3wfHGNrRtgLllAQzxEbIl7P81QJdXNHr3J7KDOw5bnOVCig+fNMkiH0JnYSYIfS3L
	j28NHccNnLfupCUPgL487aUenSiIprIRfaXEMoqBddpZ0FMAoUPD3n/bGm3BKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2arz6d4RrSmlewlrh+D8m1nv0qdMIfe9W1Or8yisS4=;
	b=Gg/366Upmp1QOOBd8xHEHKRAkguGhdOI2cFcGw2hZqGFRI/1e71Kse6IUOeHsnuN6fQF31
	siCgQSI+LyJHkMwfdEpRCI8FYMyrSjh+JS/D+iV++hKFxU5UqVw309gGWPSDh3DdzogDy+
	GP/4yKpNypbzzxg/a0ZhWddlsDH6pEBZBhH8grsu2ud4wt+FzBtT/hW+hp0KPT4XRsYr9T
	Jy67RsmdOLn4x6UhxJbIcP2APiKM9ogAJ9ZpclG1mABHr6PJe4aotRB55R5PFSwpbRbrhe
	6HbRP3o12lvz30weSNbKgy9mq/HrfuhLy7DiexcZ+LIZmpfR+q4c3B85S8VoYA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 02/15] net: qrtr: allocate and track endpoint ids
Date: Tue,  1 Sep 2026 16:19:21 +0300
Message-Id: <20260901131934.225991-3-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

Currently, QRTR endpoints are tracked solely by their pointer value,
which is sufficient as they are not exposed to user space and it is
assumed that each endpoint has a unique set of node identifiers
associated with it.  However, this assumption does not hold when
multiple devices of the same type are connected to the system.  For
example, multiple PCIe based 5G modems.  Such a setup results in
multiple endpoints with confliciting node identifiers.

To enable support for such scenarios, introduce the ability to track
and assign unique identifiers to QRTR endpoints. These identifiers
can then be exposed to user space, allowing for userspace clients to
identify which endpoint sent a given message, or to direct a message
to a specific endpoint.

A simple allocation strategy is used based on xa_alloc_cyclic.  Remote
endpoint ids start at 'qrtr_local_nid' + 1.  Since qrtr_local_nid is
currently always set to 1 and never changed, node identifiers start at
'1' for the local endpoint and 2..INT_MAX for remote endpoints.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Andy Gross <agross@kernel.org>
Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/af_qrtr.c | 24 ++++++++++++++++++++++++
 net/qrtr/qrtr.h    |  1 +
 2 files changed, 25 insertions(+)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index a30fa56e6aa31..38b6def7c5272 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -22,6 +22,7 @@
 #define QRTR_MAX_EPH_SOCKET 0x7fff
 #define QRTR_EPH_PORT_RANGE \
 		XA_LIMIT(QRTR_MIN_EPH_SOCKET, QRTR_MAX_EPH_SOCKET)
+#define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, INT_MAX)
 
 #define QRTR_PORT_CTRL_LEGACY 0xffff
 
@@ -109,6 +110,10 @@ static LIST_HEAD(qrtr_all_nodes);
 /* lock for qrtr_all_nodes and node reference */
 static DEFINE_MUTEX(qrtr_node_lock);
 
+/* endpoint id allocation management */
+static DEFINE_XARRAY_ALLOC(qrtr_endpoints);
+static u32 next_endpoint_id;
+
 /* local port allocation management */
 static DEFINE_XARRAY_ALLOC(qrtr_ports);
 
@@ -581,6 +586,8 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
 int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 {
 	struct qrtr_node *node;
+	u32 endpoint_id;
+	int rc;
 
 	if (!ep || !ep->xmit)
 		return -EINVAL;
@@ -589,6 +596,13 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	if (!node)
 		return -ENOMEM;
 
+	rc = xa_alloc_cyclic(&qrtr_endpoints, &endpoint_id, NULL,
+			     QRTR_ENDPOINT_RANGE, &next_endpoint_id,
+			     GFP_KERNEL);
+
+	if (rc < 0)
+		goto free_node;
+
 	kref_init(&node->ref);
 	mutex_init(&node->ep_lock);
 	skb_queue_head_init(&node->rx_queue);
@@ -604,8 +618,12 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	list_add(&node->item, &qrtr_all_nodes);
 	mutex_unlock(&qrtr_node_lock);
 	ep->node = node;
+	ep->id = endpoint_id;
 
 	return 0;
+free_node:
+	kfree(node);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(qrtr_endpoint_register);
 
@@ -625,8 +643,10 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep)
 	unsigned long flags;
 	unsigned long index;
 	void __rcu **slot;
+	u32 endpoint_id;
 
 	mutex_lock(&node->ep_lock);
+	endpoint_id = node->ep->id;
 	node->ep = NULL;
 	mutex_unlock(&node->ep_lock);
 
@@ -651,6 +671,10 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep)
 	mutex_unlock(&node->qrtr_tx_lock);
 
 	qrtr_node_release(node);
+
+	xa_erase(&qrtr_endpoints, endpoint_id);
+
+	ep->id = 0;
 	ep->node = NULL;
 }
 EXPORT_SYMBOL_GPL(qrtr_endpoint_unregister);
diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
index 3f2d28696062a..11b897af05e67 100644
--- a/net/qrtr/qrtr.h
+++ b/net/qrtr/qrtr.h
@@ -21,6 +21,7 @@ struct qrtr_endpoint {
 	int (*xmit)(struct qrtr_endpoint *ep, struct sk_buff *skb);
 	/* private: not for endpoint use */
 	struct qrtr_node *node;
+	u32 id;
 };
 
 int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid);
-- 
2.34.1

