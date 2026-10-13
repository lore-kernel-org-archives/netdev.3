Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C054DDB38
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888911; cv=none; b=YqohAivEM8IHRohwHD2Zb7CJY1ItA4Av4NK/MRkFcRQp73I5y4wrV3O8Ef87oYGiuwp0bHpiFmgK6W4EW15B3Wg53DLJXxO7lrPVH2lB4GTEWe4bUhz2fSMsshwQvYPxGYVk/+RDeQ3qClk+C8/mqXN49j7dsEe7yk7xulog6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888911; c=relaxed/simple;
	bh=NOawpwlOwWou1DNRZj9zj71q3lEpGztTs66Z9Sfn8Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C81qF+UpgNDISw+SaA44Yl7w46/pdyQA3EllNlKxxGG8b2CfXFVPYbMUhVCnFaGUrEoZoAwU2V5ltVvgG0bSoqx6vfdAh9NtlR7Z2nMSpdOiACjWOML0fMMjT/iiGg7745bRrQKniCsVepP6Iqhgqpb4RXCAHJn0C8x+C5s+YB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnOaRkJI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnOaRkJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791888906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UpxcCnPd005/g5FAqjDp0jedDw+f/p4nfDPhOlNi820=;
	b=XnOaRkJIylWRZcxUmX/cy3UHn0SX736n2lVwXyuEHZ2PmGGuRofWxkXAlonNxE3NTbXDD4
	BJHqX1m2BGna+niIufs7RweuKNYCLN+HdKiL8VXlpQP3xO1CyvIfH5m8r/F5STrfNAEro4
	0jkuTzEuTDRhetK+SFGLjYlwYvtGYgk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-MygAFOm6MMKqsw9bNIyp-w-1; Tue,
 13 Oct 2026 10:55:03 +0000
X-MC-Unique: MygAFOm6MMKqsw9bNIyp-w-1
X-Mimecast-MFC-AGG-ID: MygAFOm6MMKqsw9bNIyp-w_1791888902
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A3DB180AEBD;
	Tue, 13 Oct 2026 10:55:01 +0000 (UTC)
Received: from fedora.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6964541B;
	Tue, 13 Oct 2026 10:54:56 +0000 (UTC)
From: Anirudh Virdi <avirdi@redhat.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	horms@kernel.org,
	ast@fiberby.net,
	linux-kernel@vger.kernel.org,
	Anirudh Virdi <avirdi@redhat.com>
Subject: [PATCH net] net: qede: initialize extack in qede_flow_spec_to_rule()
Date: Tue, 13 Oct 2026 16:24:51 +0530
Message-ID: <20261013105451.201211-1-avirdi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

qede_flow_spec_to_rule() declares a netlink_ext_ack on the stack
without initializing it. qede_parse_flow_attr() and
qede_flow_spec_validate() only set extack._msg on error paths via
NL_SET_ERR_MSG_MOD(), so on a successful parse the err_out block
reads an uninitialized pointer. If that garbage happens to be
non-NULL, DP_NOTICE("%s", extack._msg) dereferences it inside
vsnprintf, causing a page fault and kernel panic.

This manifests when configuring ethtool ntuple flow rules (ethtool -U
flow-type tcp4/udp4) on kernels built with CONFIG_INIT_STACK_NONE=y.
With CONFIG_INIT_STACK_ALL_ZERO=y the bug is masked because the
compiler zero-initializes extack, making _msg NULL.

Reproduced on RHEL 9.8 (kernel-5.14.0-687.47.1.el9_8) and mainline
(v7.3-rc6) with the following reproducer:

  IFACE=ens2f0
  ip link set $IFACE up
  ethtool -K $IFACE ntuple on
  for i in $(seq 1 100); do
    ethtool -U $IFACE flow-type udp4 src-ip 192.168.2.$i action -1
  done

The loop panics reliably after 10-15 iterations with:

  BUG: unable to handle page fault
  RIP: string+0x49/0xd0
  Call Trace:
   vsnprintf
   qede_flow_spec_to_rule+0x2b6/0x4b0 [qede]
   qede_add_cls_rule
   ethtool_set_rxnfc

Zero-initialize extack so _msg is NULL unless explicitly set by an
error path.

Fixes: eb705d734525 ("net: qede: use faked extack in qede_flow_spec_to_rule()")
Signed-off-by: Anirudh Virdi <avirdi@redhat.com>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index ab8b818588e2..e63422c945f9 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1992,7 +1992,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 {
 	struct ethtool_rx_flow_spec_input input = {};
 	struct ethtool_rx_flow_rule *flow;
-	struct netlink_ext_ack extack;
+	struct netlink_ext_ack extack = {};
 	__be16 proto;
 	int err;
 
-- 
2.55.0

