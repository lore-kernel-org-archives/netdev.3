Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A8388E7A
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683890; cv=none; b=CxHpYqogX9S9z8lNhhRY6NhVUjgGhqUVKhTmTbkzZaGe3x+zZyC7K2mu32gcJY492vNSFOjNCwIFS3dUjDKO/eSdT8Oq7GdywYHQnF+DEZK9NkhQV/FqdLlbBXhy4XxmdDSpNsguucQZnjnP7tk+DNwqxLq22/ACHEt+UaCVb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683890; c=relaxed/simple;
	bh=PDdIo4FM+1YkTMIJmTCktpfmMDJ9s6WGriSJGuyKhDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afTatf0E+kRBdDxmA31QL1I8TAlP1L7cPak7urfYYjUBPg7v20yD40IWKRf4I/x4IED6FvjWafKt+nIqiiAoecnQqa0Hrd9yYlQxchsARgL19JBo/OBBBVfQRQRFbte5Am5f/ZMBf58Vc8sVWAtYntHdb1Nv0MGcImtnuLjMXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQWT/CFv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQWT/CFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778683888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbMJTOsMLc56OxiGju5UTVpsq2wykRNl0G0HDs0qoXE=;
	b=NQWT/CFvfLCDFpr2tPcVhBZn504IIQb54R+dfXspowIbSglctaionrF1Jd5jL/HHi0GISZ
	JGQmJEZHTet73I8qzOnmx5wZu/VLhUssjiphDk4IBk1sJFVD/d2D7sBYQ5oRE+6hy4ROA3
	fE/8uDDHKH1OMizycL9U5rHJbtjeOrU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-6wmFOvT-M-W3r6ygoqbWoA-1; Wed,
 13 May 2026 10:51:24 -0400
X-MC-Unique: 6wmFOvT-M-W3r6ygoqbWoA-1
X-Mimecast-MFC-AGG-ID: 6wmFOvT-M-W3r6ygoqbWoA_1778683883
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CC0719560AA;
	Wed, 13 May 2026 14:51:23 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AD3119560A2;
	Wed, 13 May 2026 14:51:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 2/2] dpll: add fractional-frequency-offset to parent-device
Date: Wed, 13 May 2026 16:51:15 +0200
Message-ID: <20260513145115.174597-3-ivecera@redhat.com>
In-Reply-To: <20260513145115.174597-1-ivecera@redhat.com>
References: <20260513145115.174597-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Kernel commit 9c11fcb2e9a54 ("dpll: add fractional frequency offset
to pin-parent-device") added fractional-frequency-offset (PPM) and
fractional-frequency-offset-ppt (PPT) attributes to the
pin-parent-device nested attribute set, alongside the existing
top-level pin attributes. Add their display into
dpll_pin_print_parent_devices() and add ppm and ppt units to the
respective outputs.

Extract dpll_pr_ffo() helper to consolidate the duplicated PPM/PPT
fallback logic used in both top-level and parent-device contexts.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 dpll/dpll.c     | 27 ++++++++++++++++++++++-----
 man/man8/dpll.8 |  4 +++-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index bd9ab3c6033f..1077fc259725 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -514,6 +514,26 @@ static void dpll_pr_phase_offset(struct nlattr *attr)
 	print_s64(PRINT_FP, NULL, "%03lld ps", d.rem);
 }
 
+static void dpll_pr_ffo(struct nlattr **tb, bool top_level)
+{
+	const char *fmt;
+
+	if (json || !tb[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT]) {
+		if (top_level)
+			fmt = "  fractional-frequency-offset: %" PRId64 " ppm\n";
+		else
+			fmt = " fractional-frequency-offset %" PRId64 " ppm";
+		DPLL_PR_SINT_FMT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
+				 "fractional-frequency-offset", fmt);
+	}
+	if (top_level)
+		fmt = "  fractional-frequency-offset: %" PRId64 " ppt\n";
+	else
+		fmt = " fractional-frequency-offset %" PRId64 " ppt";
+	DPLL_PR_SINT_FMT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
+			 "fractional-frequency-offset-ppt", fmt);
+}
+
 /* Measured frequency - JSON prints raw mHz value, FP prints fractional Hz */
 static void dpll_pr_measured_frequency(struct nlattr *attr)
 {
@@ -1602,6 +1622,7 @@ static void dpll_pin_print_parent_devices(struct nlattr *attr)
 				     "operstate", " operstate %s",
 				     dpll_pin_operstate_name);
 		dpll_pr_phase_offset(tb_parent[DPLL_A_PIN_PHASE_OFFSET]);
+		dpll_pr_ffo(tb_parent, false);
 
 		print_nl();
 		close_json_object();
@@ -1694,11 +1715,7 @@ static void dpll_pin_print_attrs(struct nlattr **tb)
 	DPLL_PR_INT_FMT(tb, DPLL_A_PIN_PHASE_ADJUST, "phase-adjust",
 			"  phase-adjust: %d ps\n");
 
-	if (json || !tb[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT])
-		DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
-			     "fractional-frequency-offset");
-	DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
-		     "fractional-frequency-offset-ppt");
+	dpll_pr_ffo(tb, true);
 
 	DPLL_PR_U64_FMT(tb, DPLL_A_PIN_ESYNC_FREQUENCY, "esync-frequency",
 			"  esync-frequency: %" PRIu64 " Hz\n");
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index f4cbcfc005c1..f409ba6bb9c5 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -263,7 +263,9 @@ Capabilities (state-can-change, priority-can-change, direction-can-change)
 .IP \[bu]
 Phase adjustment range, granularity, and current value
 .IP \[bu]
-Parent device relationships (direction, priority, state, operstate, phase offset)
+Fractional frequency offset in ppm (RX vs TX symbol rate on media)
+.IP \[bu]
+Parent device relationships (direction, priority, state, operstate, phase offset, fractional frequency offset in ppt)
 .IP \[bu]
 Parent pin relationships
 .IP \[bu]
-- 
2.53.0

