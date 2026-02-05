Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2F3090F5
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315067; cv=none; b=XJYkRvr7Yle583cQ8ZvZySCCZlX+7bdwkcTiwKcOYLPbxTF082rfpgAsvy+5i6SCsAY8Bm/LY/scfVxRk47safc4EcRGH+NH7daAifXIBPQWXRQzyR8QGZI4Ahz5vkhelVqrGkPHswv5098te9iTIgFbQ5hLOCPA8Ij7N1/aSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315067; c=relaxed/simple;
	bh=S1WMUh1ftJRH8goI5JAUop5HJqEzoKxHv2x/mAgK7J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=igca6iLVqOlh+0jx8DDV1jkeBSRWgZAPu0wCprBkzrROg3+s/36qoEStQndPO1DJaJW8U7DxarMDBQCQw17ZwYG7X1uWuMSu9adhouzUpJ3uULAs7B6RBBNkp/gHXDX/PKR/4yHfjsFYzIsNOcaCHl45LLf8YSjlVoQq4G6Z9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3hrLolZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3hrLolZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770315066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jfGp+S8Ob2SUrDk5StlUWP7eDPVnstXzj+VNja87mH0=;
	b=O3hrLolZA4ixx3RGo1SrWxzv8yj/ScKkB7lFR/8Su6ZmwtCwPxW+sNEzuaibbQFjRkx/DY
	8Uxr1f3VJP1zWu4KePNRrHw+eo1SJ4mrshC2HejN86bjByas2vxtKxahkAFMXgDK4AV2AJ
	6wqTdWAjJ2aHvoNRZ8GoWQ/THfX6IOA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-Na-4qU38MA6x3O_7wmGtMQ-1; Thu,
 05 Feb 2026 13:11:01 -0500
X-MC-Unique: Na-4qU38MA6x3O_7wmGtMQ-1
X-Mimecast-MFC-AGG-ID: Na-4qU38MA6x3O_7wmGtMQ_1770315060
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09FE6195609F;
	Thu,  5 Feb 2026 18:11:00 +0000 (UTC)
Received: from cnb-01.lab.eng.brq2.redhat.com (cnb-01.lab.eng.brq2.redhat.com [10.37.129.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1A8A1800465;
	Thu,  5 Feb 2026 18:10:57 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] dpll: zl3073x: Fix output pin phase adjustment sign
Date: Thu,  5 Feb 2026 19:10:55 +0100
Message-ID: <20260205181055.129768-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The output pin phase adjustment functions incorrectly negate the phase
compensation value.

Per the ZL3073x datasheet, the output phase compensation register is
simply a signed two's complement integer where:
 - Positive values move the phase later in time
 - Negative values move the phase earlier in time

No negation is required. The erroneous negation caused phase adjustments
to be applied in the wrong direction.

Note that input pin phase adjustment correctly uses negation because the
hardware has an inverted convention for input references (positive moves
phase earlier, negative moves phase later).

Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 9879d85d29af..a8001c976038 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1039,10 +1039,8 @@ zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = zl3073x_out_state_get(zldev, out_id);
 
-	/* Convert value to ps and reverse two's complement negation applied
-	 * during 'set'
-	 */
-	*phase_adjust = -out->phase_comp * pin->phase_gran;
+	/* The value in the register is expressed in half synth clock cycles. */
+	*phase_adjust = out->phase_comp * pin->phase_gran;
 
 	return 0;
 }
@@ -1064,10 +1062,8 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
 
-	/* The value in the register is stored as two's complement negation
-	 * of requested value and expressed in half synth clock cycles.
-	 */
-	out.phase_comp = -phase_adjust / pin->phase_gran;
+	/* The value in the register is expressed in half synth clock cycles. */
+	out.phase_comp = phase_adjust / pin->phase_gran;
 
 	/* Update output configuration from mailbox */
 	return zl3073x_out_state_set(zldev, out_id, &out);
-- 
2.52.0

