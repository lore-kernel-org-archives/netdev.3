Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B137CD25
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777826536; cv=none; b=lUvf9hJ1bZWwLj5/rfxnRpz1hUjFh7afDv49nYMqxe2IjNvK37qppONgiDJUYsZAdOSf9oqSwe7WoKDbDtJ5IFv5ersNnURBNQYMCOpJ2c/eJwxRd6s09MHBUlKhauQ0MA99mMbii0c4P33gIvyMycy2DPLYOpUxvCvS1QDl0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777826536; c=relaxed/simple;
	bh=Se9S5vUeFZoS9hDDulyLslLqrZjqxeW2hVsu+xMPWEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnH1Gbu+7+22o4ie9NrEQXgo17nzvZrzJswweK/O6BF6FAnERubDGFXabU+oj6mpI5n/4JPMnU/oNNkDpt2Rk1U8nvf96vFTUBzSxavCm9eLgW5myPZLdZg9MNvgVxr9yy6hKe9lK9LhqvzCjpZaYExoinfjgWWvKxZ0pVqTh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tfn1MwKW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tfn1MwKW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777826525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6OMnXFksPWYgCbDa0fqBN0MsKqolVLOn4UZAcKfFliU=;
	b=Tfn1MwKWdTmLWaWQ2ibmQJyvq4kpfwdPH0DPHBLYEmMrv9GXDgSaUwaG1vu1KdchFoBwra
	rth2o01hp1RY4iYUt0Ur7ppQ/P3iA5O5hRTuch2EjaGNPBTSuQdTIS6rm34UDbFekW3JtG
	VmHCRB6uH4h1N/llnXU1A106z5VKNHc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-340km-k-NsG7GjbczS2N4g-1; Sun,
 03 May 2026 12:42:04 -0400
X-MC-Unique: 340km-k-NsG7GjbczS2N4g-1
X-Mimecast-MFC-AGG-ID: 340km-k-NsG7GjbczS2N4g_1777826523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 593C51800473;
	Sun,  3 May 2026 16:42:03 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EE3C1800480;
	Sun,  3 May 2026 16:42:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] dpll: fix man page correctness issues
Date: Sun,  3 May 2026 18:42:00 +0200
Message-ID: <20260503164200.145679-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix several inaccuracies in dpll.8 man page:
- Remove bogus "holdover" and "freerun" from operating modes list,
  only "manual" and "automatic" modes exist in the DPLL API
- Fix typo "locked-ho-ack" -> "locked-ho-acq" in lock status list
- Add missing device show output fields: lock-status-error,
  clock-quality-level, mode-supported, phase-offset-monitor and
  phase-offset-avg-factor
- Add missing pin show output fields: panel-label, package-label,
  fractional-frequency-offset and esync-pulse
- Remove non-existent exit codes 2 and 255, the tool only returns
  0 (success) or 1 (failure)
- Use canonical enable/disable for phase-offset-monitor to match
  the tool's help text

Fixes: 656cfc3ce05b ("dpll: Add dpll command")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 man/man8/dpll.8 | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index 89f17af74923..3abed86f1d52 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -102,13 +102,23 @@ Module name providing the device
 .IP \[bu]
 Clock ID (unique identifier)
 .IP \[bu]
-Operating mode (manual, automatic, holdover, freerun)
+Operating mode (manual, automatic)
 .IP \[bu]
-Lock status (locked-ho-ack, locked, unlocked, holdover)
+Lock status (unlocked, locked, locked-ho-acq, holdover)
+.IP \[bu]
+Lock status error (if present)
+.IP \[bu]
+Clock quality level (if supported)
 .IP \[bu]
 Temperature (if supported)
 .IP \[bu]
 Type (PPS or EEC)
+.IP \[bu]
+Supported modes
+.IP \[bu]
+Phase offset monitor status (enable/disable)
+.IP \[bu]
+Phase offset averaging factor
 .RE
 
 .SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ]
@@ -131,7 +141,7 @@ mode, the input source must be explicitly configured and the DPLL
 will not automatically switch sources.
 
 .TP
-.BI phase-offset-monitor " { enable | disable | true | false | 0 | 1 }"
+.BI phase-offset-monitor " { enable | disable }"
 Enable or disable phase offset monitoring between the device and its pins.
 When enabled, the kernel continuously measures and reports phase differences.
 
@@ -231,6 +241,10 @@ Clock ID
 .IP \[bu]
 Board label (hardware label from device tree or ACPI)
 .IP \[bu]
+Panel label
+.IP \[bu]
+Package label
+.IP \[bu]
 Pin type (mux, ext, synce-eth-port, int-oscillator, gnss)
 .IP \[bu]
 Frequency and supported frequency ranges
@@ -239,13 +253,15 @@ Capabilities (state-can-change, priority-can-change, direction-can-change)
 .IP \[bu]
 Phase adjustment range, granularity, and current value
 .IP \[bu]
+Fractional frequency offset
+.IP \[bu]
 Parent device relationships (direction, priority, state, phase offset)
 .IP \[bu]
 Parent pin relationships
 .IP \[bu]
 Reference sync information
 .IP \[bu]
-Esync frequency support (if applicable)
+Esync frequency and pulse support (if applicable)
 .RE
 
 .SS dpll pin set id ID [ PARAMETER VALUE ] ...
@@ -495,13 +511,7 @@ changes.
 Success
 .TP
 .B 1
-General failure
-.TP
-.B 2
-Invalid arguments or usage
-.TP
-.B 255
-Netlink communication error
+Failure
 
 .SH NOTES
 .IP \[bu] 2
-- 
2.53.0

