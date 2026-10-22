Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697280;
	b=Zukd1KkPstDfe07TtVZ9gJKpgAi1FkcI78yJ8k+w132ViHH+8c9M6fEy8PeWajsxyj39
	 08T5kgePL17Y5jNsjUZ55UIOzcis5DIrikYltDthVBP76yS1Q2hu1iRVJTB1xMFQ5GDQz
	 MZQjbU7NMMlFgRYI6aYAnX3l8vr30CXw3CYxFWNlm1T3mnvI/AkoT2OEG+JJotiWkgeJY
	 qyUor8VIvJGtbwGXPF496VxrWIFWttXndpS11iHIAHkT2oOSL+HixenXnUQO0K6xrOqbA
	 ALUji4OZFKGT33Fg86I1oisjtANYioj65yB6Z9GKQThZFUSNnf/iSjl+0uZCE11wSvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7i5zp/nMBoh4FpTzc2q5LQUaQs09zWC1CfEISFvjXJc=;
	b=qLXm3qafsmtaIry1CI3jb1SVoxjOESrKUurkBlKzijkyiofA2jo3JY0a8jx4Uej5trvD
	 tvRjreCwbe7ityRZLYxLWL2+4mclzFoADG9NMwucvv5XvY8VVc07AyadEDPYa2x/554BW
	 yzZJLq2/2tQT9ZDCYNnLtzaylk2W1XxCjEXJyJiL+Wt6p1Bt1NlAdGNjWY/Ferd0OXFgs
	 BamoUWqITGYiEvetl8osLOtRc4qZLcJ1N5ZUO4Ps3l0fLUeFiOmf/Rfp5QIVdkeFfqEyj
	 /Rm0KCHu9rs1wLBB8cVEf9yurOOhMj+Tjs60LcVLClEDzRDnEvRIENBjLf2LTK3m6jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jcVNGsST;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB5606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CEB5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jcVNGsST
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9196d8543cbso2413656d6.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792697279; x=1793302079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7i5zp/nMBoh4FpTzc2q5LQUaQs09zWC1CfEISFvjXJc=;
        b=jcVNGsSTUgOJZcsD4vjQuyUcr+VHbKW452Ay+18BZmBjCtAmtShccx2Mm2NqZJqVrL
         iA0pkDn622MxPFIfy2TOVL8bEutW1ghtxtQRpbTilXonVWn6Pi3WZ6M6NXcjDjui0fUq
         GDfocVuIHpVgJtVD3OvAuGo9GBEyOM4Bugcy52PrhM6KS76zbcrDXkPzVwmazuFERIMp
         QTGwZUp/pwg/X3m9uyy8q2qjO3p7oKuT9+YpuaTKAu+eQ57cg+/vbTsw42DJtwVYX6oX
         2ByBAGegWuUra3lxMOOJtliqlhHHFSy/Peg0tKviIpbbNYFkYe/yCoJrvA+TtvB9lwd3
         Lnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697279; x=1793302079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7i5zp/nMBoh4FpTzc2q5LQUaQs09zWC1CfEISFvjXJc=;
        b=bDgNW8ogBp9RojpqJ2W1GTsAZ5lxzzdd7X5JOP0kIKTPMWIc6SxljzzgRSdz8pEnEI
         P3hSXpaj1FCDCgf5hQtuqPUo2wr6NrGx0CM1PTnXeuLq1Vt6mlz4voKEub7pKCL/aXMs
         WFVZG+B8/r5q1sJEIsOBucxH/YVuQXo9vt5YBym5XHCBrPvDwqN9og2CmssQpWkFJGJx
         C0Cc6M+wK51Xc/StSwMt8v3+9A5mgJ0Ilon4GqD9GQuyGJjeF2RVRmZYEM6//LhEyZ5U
         HJVFmVlZhvHVtZMdQdO9N7P2Xt4QbqT60J8jy6jS7I/xgbfrO/wNn4oXR4Ofu/G/xnv+
         ajrg==
X-Forwarded-Encrypted: i=1; AKwUvBzjkAPhnWSs1YEAC0bZ+VjYvipFU/jtdsdftkq+LIFvPRTO7c1s6WmAjWuQXJIHv1fXUBInedY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIolVc9QiZxUX2K6GhY+OimZC1LiNW3X5GPx1C4h0xU387BwJB
	u3/vCMMXCmIi9DE0lS6z9udNbYE/gPLj7Hk1qGtmMUq6aTRkyd6UEFr9
X-Gm-Gg: AYBFou3BKuG4LC48nHiwIyzGdJWBdRbavTwvp2ZBg8fQ8EBvjUGNlQdPd5U2ZfAgKhg
	bT7n/JZZCjT/V0mYNBp2cRa9tu8jOL97cjXUbVKIx6s2X8zXLHoVeUzexaPKzh2EiZUZFl7YJiy
	+mwJT1ObykgdwHyrGMpnZg+sagUJb3+XIX4nFL6XFTzrFIoMSwxp1nBRl9pBj33ScYNgRpgMSuY
	+eIksFS9uyPIgZqhx5ZHaPEycaO3xs5da5jYGQna3NxNnZ4PGY2nA2/FARxg+OCVRSBGEiO0An6
	M+lRI7RiKaNoYDIKFqPkSOZ1yqq1o25YgUPZsKRIsCzX/p32458MS7VLBXsdtpYl0LdFaXlicnT
	H+8VY7BcoCqDHZHP0jcSDpN2RfqzI65JQSKtZy+IDd5sS/a81MAMJS14Sh1sZE0Ro8NXcTzHSGJ
	4PGc5aqldWt0xU88p9DnSovqsjQMJqFlmDDDny22LAMh1vdMFeAR2noFHZx6s3U+LpbdFBinpvQ
	o1e4fX1UrFcgAOVibH4hWnMs2jWSgMO3ND2HRrBUdyyS6HTAsNw2kBOoPr8+AiIbw8DXMonP0Xo
	EyQ=
X-Received: by 2002:a05:6214:509d:b0:919:5a24:d20d with SMTP id 6a1803df08f44-91c12eb53a6mr104325966d6.11.1792697279221;
        Thu, 22 Oct 2026 12:27:59 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396afa91sm370296d6.11.2026.10.22.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:27:58 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH iwl-net v1] iavf: reset the VF instead of freeing rings when queue disable fails
Date: Thu, 22 Oct 2026 15:27:46 -0400
Message-ID: <20261022192753.69765-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iavf_close() leaves the Tx/Rx rings in place because the hardware can
still DMA into them, and iavf_virtchnl_completion() frees them once the
PF has answered VIRTCHNL_OP_DISABLE_QUEUES. It does so whatever the PF
answered: for a non-zero v_retval the error is only logged and the
DISABLE_QUEUES case runs anyway.

The PF can fail the request while queues are still running. ice and
i40e give up before the Rx queues when a Tx queue cannot be stopped,
and ice also fails when an Rx queue does not stop in time. The rings
and Rx buffers are then freed while the queues still point at them, and
received packets and descriptor write-backs land in freed memory.

Keep the rings when the PF reports an error and request a VF reset
instead. The reset makes the PF stop all queues of the VF, and
iavf_reset_step() frees the rings once it has completed. Until then
iavf_close() may warn that the resources are not yet released, and
iavf_open() returns -EBUSY. During removal no reset is scheduled, but
iavf_remove() resets the VF itself before it frees the rings.

Fixes: e284fc88dfb6 ("i40evf: delay releasing rings")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found by code inspection as part of ongoing, not yet
published research. It has not been reproduced, as that needs a PF
that fails VIRTCHNL_OP_DISABLE_QUEUES.
Compile-tested only (x86_64 defconfig with IAVF, I40E and ICE, W=1).

 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e6b7e8f82c7c..178bba609677 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2718,6 +2718,15 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
+		/* If the PF could not stop the queues, the hardware may still
+		 * access the rings and Rx buffers. Keep them and request a VF
+		 * reset; the reset path releases them after the PF has reset
+		 * the VF.
+		 */
+		if (v_retval) {
+			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+			break;
+		}
 		iavf_free_all_tx_resources(adapter);
 		iavf_free_all_rx_resources(adapter);
 		if (adapter->state == __IAVF_DOWN_PENDING) {

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

