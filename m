Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07873C0A0B
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573976; cv=none; b=exn8KUKhdo9h00Wk3/y02RY5/XhFCdASSIdn63kvYoKisEhmGQ9pxJyz6izyTIavyR4JUJOvbq3yELa/gaXdkttkYpadESKm/V8tO8CFWHVSDd2NY0zMJ7miQuKIC5B5zipYqekg4TQRAlh43i3QjYP9ee9fsr2v+KiH4R2rvBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573976; c=relaxed/simple;
	bh=18nEhUa7wNpt9XMYxg+YFUA3Fm9UNmu3++mv4tMMwmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKkNwLO8KjIoKgF3WEy7KXNftJ1G350ST7Xwg0idstkRg7FQk7vjNmke+T7k4uHeD/+BYXr4y99YltRqIWqQ+D1fOLIOQCy0MblLICYa27PoDsYxkBejhlvgSXGjqNKv3Meyt0V/FDine2pR1eO6WXXY5CeyGUqJKZdx0arcgmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtAKHGxS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtAKHGxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791573971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olLFB6rWx9r8p1ulYEfdws9QRKyXXiWH3UFmtB9o+fk=;
	b=PtAKHGxSTfW6Hb5Umi8FhZ5DXj7jINbW5wSGGHb45ek7sudTJtVfracy7vzKEbEAQN7wxf
	7sBQRvVOre8g61UaCytZt5LpeLMzDPE4js58e3o1W3dHzvO+MhKnfSDY86cmDTmQ1YqUPv
	FhMsCr1gePbimhpgOP5W2Oxv3FpWQRs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91--YIBWm1wMpSgtTJO4R88nA-1; Fri,
 9 Oct 2026 19:26:06 +0000
X-MC-Unique: -YIBWm1wMpSgtTJO4R88nA-1
X-Mimecast-MFC-AGG-ID: -YIBWm1wMpSgtTJO4R88nA_1791573964
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A07C18089A2;
	Fri,  9 Oct 2026 19:26:04 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C06018004D2;
	Fri,  9 Oct 2026 19:26:00 +0000 (UTC)
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
Subject: [PATCH net v4 1/5] dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
Date: Fri,  9 Oct 2026 21:25:52 +0200
Message-ID: <20261009192556.272263-2-ivecera@redhat.com>
In-Reply-To: <20261009192556.272263-1-ivecera@redhat.com>
References: <20261009192556.272263-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

zl3073x_pin_props_get() always adds the current pin frequency to the
supported list without checking it. A sub-Hz frequency reads back as
0 Hz, so 0 Hz can then be requested and the output frequency set
callback divides by zero.

Do not add a 0 Hz current frequency. If the list ends up empty, do not
publish it at all, as the DPLL core rejects an empty non-NULL list.

Fixes: 85a9aaac4a38 ("dpll: zl3073x: Include current frequency in supported frequencies list")
Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/prop.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index ac9d41d0f978..18a1bf310332 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
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

