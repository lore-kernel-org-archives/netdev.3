Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788432;
	b=NMJY0905i/ceiIfjRAqkw3nCm/CrKr9afAFQ9aakheAfJI82xJ6ATRTmyuzaLh4jpukj
	 uwQ5XlYkTDhCidODWu17bxSYn5LJhEv6G82VOwXEPB5LpMzSbEljUtRf0dX6E/XEfa2a/
	 J0fnTlawTpGRRxJDdybIY87jte5lg5iXIxHoJhbfR/vY6G5QgQvGFvLNH50ewsGn79a2+
	 PWVe2Uqcm7nRI7HKOA0SKZUBd/LC0fAigPGosJ4K7XPMfVSsjJdD43hmTwdEuD9kS5LbS
	 i/XdC02GskiSl0mcNvhIucYAKzTkKTUjuMYajn0F+jwWjQg4Tm/XZYqVJkVPb501nsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mD3l16ACuVEn6QpphRJ+hfd7U3+vee3g8XcGaYAQ40E=;
	b=LsknQ+R7ggHhh/y+he9WdBe30md+E7a98O0mchniZv18kd2T4ZnpbyMwl+Qbw/PV/lEA
	 tONzZTG04FzmbjwQOu6Xf0DFgA0NvqPN/ZxHKj+gQc+z+Z/84anMwxSXCEKpKJt1BQKVE
	 uz6RaiF+94rbuamLd9vJu6pJMoy6WpEVw9IVKL68iPRpcyXtsIrNN55FKmAiHWRpBbI/r
	 RcQBFVaCe3EQIwE8zdogHPbzvUuUg4EC3csR8EyKsIF0Iob2DTX2OApPS8N726y1CAIJP
	 V0z2XasnE6v8kApQiyj61gCoebf7nYn8LT4t6bLGA1UatPEqJuQf1wUBVrXirqm9IEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oX3K9bdn;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468360A2608
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C468360A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oX3K9bdn
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05bfa6af5so902494b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792788431; x=1793393231; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mD3l16ACuVEn6QpphRJ+hfd7U3+vee3g8XcGaYAQ40E=;
        b=oX3K9bdne9gYuUNa8bY/8vaocj9DltxCaWQlMvlM5nAZxBs5DYwdKZRfLTWc3x+V5+
         P7D9coGVtdW8Nn/+TF+iS1aD8uXwFdM9MfM5v/a6s5OK/EQlnYk57LSkec3n2NRAP0IY
         EFcD0UQwSK1x3RrzydfSOsEt67lZ53EA05V23skWDU2AvH+yaoB6n2RTDMSDZWSsHvTS
         SHwUWYVv1tQEwI2XrcNbzIbefGyINg36zahDBgoWV24h287sDEuF9xPOK/YANEC/LCdZ
         NN3FYzE/J0bwvLUnyZVvZ/NZ/mM30Gko/MKMBDOis+rZj1aRasrg+fyE80eLKmX5CaOF
         NbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788431; x=1793393231;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mD3l16ACuVEn6QpphRJ+hfd7U3+vee3g8XcGaYAQ40E=;
        b=VBFTTLDYKQs/3Me/4vbk7zHS2sQ4YOGXaXZs2CW/NlqL0DDguiyxXr4xX4GhZIky5u
         YdhS912seG3vaaYuPUftmHgxDp4XLsBjGLkpBwq+0mU81H+wMFkq4vn6wcpra0MYfs4H
         smUpjgsXifEgcGMZJr42POtX9Pdghidnu2XFp3xaY1YvtOOzIDhO/gwXEAKkBf6KP/4N
         oTv1J7/3pjUbKa63d3daL2js9PjtnEqAIs9vitoypsrLMATrO198yD1ftRTDVUGUBfLn
         HYcYB0WigykgmqCf/fLXDvByq9eLq8EGccGES3wRXQTWxxTmnnE4dp1MszhbQN5BKqo4
         eCTw==
X-Gm-Message-State: AFq9FYL2xga2SESnkH/LzuwMiNZFJAMQjAPda7UKZXhVLIubQS30svFA
	B81r7UBgIMBtrp1f4CZeZR/TYgFzZEEEhMl7kA/mBtJ6ooo5nIqPJ7kAX4dhYP47qZr+CghQ+mo
	ZDpdmH0BE/IJVw1n8kYfKXj2zNvkuCok2Kiq+t5qlkVaqCxxkgOz/s28G+nNI9EyaJLWaHpuIOY
	CpSocvUVYpd0dURdjvzQjod/W05goJt5k6JD5Ieqe/ywCVt3VYwwLRZ8uNS9aIpsA=
X-Received: from pgbbw33.prod.google.com ([2002:a05:6a02:4a1:b0:cc7:e738:5b0d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cd2:b0:87d:cc3d:fad4 with SMTP id d2e1a72fcca58-8a369b16799mr283179b3a.54.1792788430824;
 Fri, 23 Oct 2026 13:47:10 -0700 (PDT)
Date: Fri, 23 Oct 2026 20:47:05 +0000
In-Reply-To: <20261023204706.3112215-1-hramamurthy@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023204706.3112215-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023204706.3112215-4-hramamurthy@google.com>
Subject: [PATCH net v3 3/4] gve: Block invalid ring sizes when device options
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
2.56.0.257.gf7497c7d27-goog

