Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7312BE641
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270820; cv=none; b=SCwgaQXccl6ejhibXcYlT9htD5v0KUleuQhzB3E2Cccnxy57/cZboukd700nAQwqjxofAPJx+RPQttDehkUc4LTbqGOsaR3sZk7hu3samhdtMEQqhmamr8ZoqT83/XApmCYlJdxPEHl1XlNVGavoLZusxd62I6TTLUSAkyHsBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270820; c=relaxed/simple;
	bh=ppzff4TWxNiPFsn5haTbJ5o5fazlod2gau2ay/LxeKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kv7IRCOcHzyoAOn33ZVZcdT1CLn+8omQ9a0xv+8R3ePnNGkDtXmevtM/ygPssjmLjv+Opj9d3y8Sx070k3LwPVsBCHx3w+75Vr8adIASVT3h2+eAS/XjtJG2kDcL3NmGx1IZLCaQ5+Sz3M/hiyYZ4QWBDqJ8khPXu6smtEVLccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0wC1EgL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0wC1EgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771270817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gpeWl/n+2Bge4QHSPKs3mx/XBv7pEK0ZsFDWgRBdjYQ=;
	b=O0wC1EgLWrcriCLcS6gXj1CN+oJzr2+8H4knjACP6oOIBww5hN5OCwJqvV+sZtJmvNj6kH
	uXq7j8DJs/vrJhYtxPuwczz9lDWu3KT0D5N/HZUiFrdu0kKEPLr3VIH8cl2hWUY+ZxmpOb
	LpEQEvT6RroqIl6b8HlomQNxzsas7F8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-mlj6fa9HPdWrrAtc_b9DVA-1; Mon,
 16 Feb 2026 14:40:13 -0500
X-MC-Unique: mlj6fa9HPdWrrAtc_b9DVA-1
X-Mimecast-MFC-AGG-ID: mlj6fa9HPdWrrAtc_b9DVA_1771270812
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D969D1800454;
	Mon, 16 Feb 2026 19:40:11 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.55])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C87901955F43;
	Mon, 16 Feb 2026 19:40:08 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: zl3073x: Fix ref frequency setting
Date: Mon, 16 Feb 2026 20:40:07 +0100
Message-ID: <20260216194007.680416-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The frequency for an input reference is computed as:

  frequency = freq_base * freq_mult * freq_ratio_m / freq_ratio_n

Before commit 5bc02b190a3fb ("dpll: zl3073x: Cache all reference
properties in zl3073x_ref"), zl3073x_dpll_input_pin_frequency_set()
explicitly wrote 1 to both the REF_RATIO_M and REF_RATIO_N hardware
registers whenever a new frequency was set. This ensured the FEC ratio
was always reset to 1:1 alongside the new base/multiplier values.

The refactoring in that commit introduced zl3073x_ref_freq_set() to
update the cached ref state, but this helper only sets freq_base and
freq_mult without resetting freq_ratio_m and freq_ratio_n to 1. Because
zl3073x_ref_state_set() uses a compare-and-write strategy, unchanged
ratio fields are never written to the hardware. If the device previously
had non-unity FEC ratio values, they remain in effect after a frequency
change, resulting in an incorrect computed frequency.

Explicitly set freq_ratio_m and freq_ratio_n to 1 in zl3073x_ref_freq_set()
to restore the original behavior.

Fixes: 5bc02b190a3fb ("dpll: zl3073x: Cache all reference properties in zl3073x_ref")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/ref.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
index efc7f59cd9f9..0d8618f5ce8d 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -91,6 +91,8 @@ zl3073x_ref_freq_set(struct zl3073x_ref *ref, u32 freq)
 
 	ref->freq_base = base;
 	ref->freq_mult = mult;
+	ref->freq_ratio_m = 1;
+	ref->freq_ratio_n = 1;
 
 	return 0;
 }
-- 
2.52.0

