Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308600;
	b=LjhZELRJdQlUi/xiKAu6EljElNQFfSPQrRDm7zGmw4zdTY7EkhlVMMbYRuaKlpjpG4X3
	 8Kd/Xg7SRxYNHGdFw76YKEbbH0oMIOLUw14FvH4w9B5R/p7mMn8CKni7ArITiG8etnOLc
	 nya/oh7jbHEyRGtBiFnzc25E7nnXPvd6hRag6vyb8b0Fl9nMPFBWn/qG1wNHFwc/uy6lc
	 k6zVROIcAu198FPDuvDIY5WE/o3GUnO8nSrG1qrARWOKYEqtgluvgLKv7A8M/zTQQHkZc
	 OlZlaNmkKbt0hJOPFp2kcGHWiG30zJnja1QGC0hIGbTqBZpJDQP0zBTKTc64TlWL1cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kj+EtbVH78ECXqmNIitGQzkU9uA9+mq5+q5O6E7IA5c=;
	b=LMBhSgBiEzvINBsBT6Xqf9sYIp/doDrpLc3H3D8CMDJNOo+Ucqa40cpfla77dBJypElv
	 YLn1zSUmMUhpSTBFR5tKBAEp4N5gxesaJ8C8ClX1M+b4XcwblSzWh3d+R0sFFGlpECTiu
	 mrnkk4us6uD7lVeQKOcjZyoUsIhVKqOsYHuWS53oomV7sEFgUij7pSw0kSNdqvvHqQw4V
	 lldSQ8SyaHN0Fs9HGMKXH4O4UC7FHM1sEyfm4mxteAEwNMttMNSZrszO+KlLaGHZTwNKc
	 g49sfBzkLq4RmCrN2eVu6DqBNS+BrgRwitkf2xSIf3QjdNkRbUdw+RdnLq2wBFcbg9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cEPnZrJL;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D331606A339
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D331606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cEPnZrJL
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb2437d752so1278875ad.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793308600; x=1793913400; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kj+EtbVH78ECXqmNIitGQzkU9uA9+mq5+q5O6E7IA5c=;
        b=cEPnZrJLnyTi+I3mobvGhPPt7c0eB1gGN8/dgQgL8wCDpuI735uhjOZRFvDcpBh5tS
         ZA41nTPpdSQtneboIz9jyMnsLqbrH15TTk4QTfSrMLn6u6Vlyv0jz9Iy7VD0hfgS7acw
         /PAwyNLwFczsDpEyNBMABLUyhHpLh1TeLcY1JKw8UYbTK4NLFUyqszRTmSBfcMmyFLs1
         1sq1rqvvahVxVyp6I9p8EjYdPHenZm7S2Z+1sltvPagz1IUv06j/vpsiyauZ58U4wOn2
         td0y14YTxxn4qdwC/ZFSwv7RF6ntVdTyzynPSNXaJVX1XPVGxzgfmPxCrIc4xWLr4LGQ
         o/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308600; x=1793913400;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kj+EtbVH78ECXqmNIitGQzkU9uA9+mq5+q5O6E7IA5c=;
        b=HqYW9YhqPpCNjVZePKVnFQr3MtZ1OIpVphcrb8t8pSyn7vnwmzJ316M3HXfi0Z31G2
         NK9KSma3muytnx4zwsg3esj474vX6HMog5mAY2A5STb3aLp4hgRe4xnnfmdqcCkFrkuH
         sRD9fiLYp50y1/Op4ZBgvcg2FPr3iL1PVbx+gYX26r8w4zokupH8VGyiq0kEwRui0qRL
         DKSUS4+CtJyGSUX4CPuUm3iqvMslOaEvnKBdmiXe7fgmyxuo5oghcfEIdWEAl9Tmtjm6
         bhodq9gEvdKL/OdsTwRrumfUGeI+ILRImuS/Abdp11GFs0KfjwjC2hHb36DrnBGJsWLq
         eoiA==
X-Gm-Message-State: AFq9FYL+J89I09PgOeRBmGDUcrqJvJe50vLf+zPf0QlqeZw06CGGVHfR
	1erT0PcH5aw9sszqORq1czqEIk97F2n7YkoYxoU518pSQnEY9hEAmiw2hc5/b1tljtNNUo7NV/3
	UlRtUzdvN2n2BqhmKIVyLb0rowoz0xWG5HRN0U5aCnOscE+rjLqP8ROsQ0Zz2ud0Y0LyZqWEgU7
	BUVp54+R0agZ9MTCBdtJaRvvLvb+LtySiYInyxgFECEoGIWzv5bN0/wH0/M84tWtE=
X-Received: from pjbgo10.prod.google.com ([2002:a17:90b:3ca:b0:3ab:c012:2f80])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2252:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3ae8987d10amr159004a91.63.1793308599354;
 Thu, 29 Oct 2026 14:16:39 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:16:33 +0000
In-Reply-To: <20261029211634.2232784-1-hramamurthy@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029211634.2232784-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029211634.2232784-4-hramamurthy@google.com>
Subject: [PATCH net v4 3/4] gve: Block invalid ring sizes when device options
 are 0
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

On older device versions, minimum ring sizes in the device option are
reported as 0. The driver imports these 0 values, allowing userspace
(`ethtool -G`) to request invalidly small ring sizes.

This issue was discovered and actually triggered by the
drivers/net/ring_reconfig.py selftest (ringparam test case). Halving the
ring size down to 1 triggered a kernel NULL pointer dereference in
gve_tx_alloc_rings_dqo():

  BUG: kernel NULL pointer dereference, address: 0000000000000002
  RIP: 0010:gve_tx_alloc_rings_dqo+0x1c4/0x510 [gve]
  Call Trace:
   <TASK>
   gve_queues_mem_alloc+0x29/0xa0 [gve]
   gve_adjust_config+0x1b/0x140 [gve]
   gve_set_ringparam+0x1f4/0x250 [gve]
   ethnl_set_rings+0x260/0x440
   ...

Fix this by falling back to the driver's default minimum ring sizes
(GVE_DEFAULT_MIN_RX_RING_SIZE and GVE_DEFAULT_MIN_TX_RING_SIZE) whenever
the device option reports minimum ring sizes as 0.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the device")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v4:
- No changes

Changes in v3:
- Retitled and refined the commit message

 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 8b215fca9c1b..2c848f0c23dc 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -191,7 +191,9 @@ void gve_parse_device_option(struct gve_priv *priv,
 		*dev_op_modify_ring = (void *)(option + 1);
 
 		/* device has not provided min ring size */
-		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
 			priv->device_info.default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:
-- 
2.56.0.313.g2479322e68-goog

