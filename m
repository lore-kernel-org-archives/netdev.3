Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE023D5C07
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699150; cv=none; b=OTWqH0aGBkeKivMlHUezhu+7k4jfIFLZ6dl6veYSvGSzDMVJKtG7fYjMHaUSHeM6wC1bFuW4pClQkddph6aZe1Wav9zA6pUJE/yZwfBMICPp+BC9/Ng4QpcMQC7cuX+BkbLJ8XRumBAresZXqoj7joblavW+4Ary2Zutzqufp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699150; c=relaxed/simple;
	bh=JEiyBPOMQMMl2NLC0YLrjNa2D8JR4Xstw82Y92h7UF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMRGGr16+eB8JHp5MdIVbhrFZI01zuVowDxJR/JvYc35LIVK78Lc2uPA+Hfl/s1WOzFpWR/mviAdLNFnnpg6/myZtgHQjcURyB+MZ9F+9lMF6h4oMLrW26ASwnkhUdFHQpUBHV/z8auYgZ+W53SQdV7J/FnyUJey2KksJr/X548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERt7HMY2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERt7HMY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791699144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCXR6LtWJua5mS8JgVtfD13BSpVyujA2WFC+pOJHKKA=;
	b=ERt7HMY2XKens8Ro2QCNKNnmYJTDjA+lHNTrr+fJoDCtds7mDk0jVhfg1FQvrfk1TAwQXS
	nxrvkfjE7l5EsHerMO4KOO9gvmI0r+yhUUmObQcm0WaLfVk4kPNGr5K/ozeFZkKSey35e3
	hFgYWSp1uEHe0gZraBbwF5gW2b4VBiU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-8ZwGSvLlPpOf3BYWgIhZ5g-1; Sun,
 11 Oct 2026 06:12:19 +0000
X-MC-Unique: 8ZwGSvLlPpOf3BYWgIhZ5g-1
X-Mimecast-MFC-AGG-ID: 8ZwGSvLlPpOf3BYWgIhZ5g_1791699137
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C774619560B3;
	Sun, 11 Oct 2026 06:12:17 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B41E1956095;
	Sun, 11 Oct 2026 06:12:15 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/5] dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
Date: Sun, 11 Oct 2026 08:12:07 +0200
Message-ID: <20261011061211.448373-2-ivecera@redhat.com>
In-Reply-To: <20261011061211.448373-1-ivecera@redhat.com>
References: <20261011061211.448373-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

zl3073x_pin_props_get() always adds the current pin frequency to the
supported list without checking it. A sub-Hz frequency reads back as
0 Hz, so 0 Hz can then be requested and the output frequency set
callback divides by zero. A 0 Hz entry in the firmware node is not
rejected either: it is offered for an input pin, and for an output pin
zl3073x_pin_check_freq() divides by it at probe time.

Do not add a 0 Hz current frequency and reject 0 Hz in
zl3073x_pin_check_freq(). If the list ends up empty, do not publish it
at all, as the DPLL core rejects an empty non-NULL list.

Found by code inspection, not triggered at runtime.

Fixes: 85a9aaac4a38 ("dpll: zl3073x: Include current frequency in supported frequencies list")
Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/prop.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index ac9d41d0f978..768e5424de2d 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -30,7 +30,7 @@ static bool
 zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
 		       u8 id, u64 freq)
 {
-	if (freq > U32_MAX)
+	if (!freq || freq > U32_MAX)
 		goto err_inv_freq;
 
 	if (dir == DPLL_PIN_DIRECTION_INPUT) {
@@ -295,13 +295,20 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 		goto err_alloc_ranges;
 	}
 
-	/* Start with current frequency at index 0 */
-	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);
+	/* Start with current frequency at index 0. A sub-Hz frequency is
+	 * read back as 0 Hz and cannot be set, so it is not offered.
+	 */
+	j = 0;
+	if (curr_freq) {
+		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(curr_freq);
+
+		ranges[j++] = freq;
+	}
 
 	/* Add frequencies from firmware node, skipping current frequency
 	 * and filtering out frequencies not representable by device
 	 */
-	for (i = 0, j = 1; i < num_freqs; i++) {
+	for (i = 0; i < num_freqs; i++) {
 		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(freqs[i]);
 
 		if (freqs[i] == curr_freq)
@@ -312,6 +319,14 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 		}
 	}
 
+	/* The DPLL core rejects a non-NULL list without entries, so do
+	 * not publish the array at all when nothing is settable.
+	 */
+	if (!j) {
+		kfree(ranges);
+		ranges = NULL;
+	}
+
 	/* Save number of freq ranges and pointer to them into pin properties */
 	props->dpll_props.freq_supported = ranges;
 	props->dpll_props.freq_supported_num = j;
-- 
2.56.0

