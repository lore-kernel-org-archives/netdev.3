Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C529A32D;
	Tue,  7 Apr 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582215; cv=none; b=f9rftv/5iKHPJ1NK9FCA1TzMPMBm+HSCTfpIDzCkSeVs10BXBgQUUmvqBVkZuGXM5j+sorOuv/tOdQLeMBNoepmY5fmm/aYRQ3NLYk9tH7o/td0ohrkYG8/uyh+gTMXGUz6wsvFb05SIQN7uHyqsZUEat2fdBlOP+hSiumKAr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582215; c=relaxed/simple;
	bh=JJVkIYc4QeMaXv0+jeeT3ZERGYORXGA//lejIPzfmHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOzLhaxGIPILv5xm3MA6vKP1gCBjWYGJntB4wq9vM5yzdCbbUWzhN4RvBniVlC9KNdhK3uPacNIDz4otnC13ZGuBUnqN7ECELh1g0WYSbtYNfZkSXxoAxaTa2PZO3PXduyqfSA2S0EgjYiiYLF7mzYa9J4rzAseIyzo9gy/EjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UKCo8w/U; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ETCKHEAG; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UKCo8w/U";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ETCKHEAG"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fqtCm4Zrvz9ygJ;
	Tue,  7 Apr 2026 19:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775582212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgFVaIjlD4A8Cx+RdINvJRUtP4IuJzJROGNudSylLXY=;
	b=UKCo8w/UztBcuC3mzhxmbsdpI+1n+HUx0vHoU+KIGk9m2I+JtJO9qR55UrijrJXJCWcWhT
	D0Er0JsbCAyJkVFE4XAVMNBo5qfKsxOb1JJ/YDNfqH3WD04CRufZtRyZdzri75tL6z30P6
	MWbxmaMdzsQKx1UYPpTDCzARa84f899ZL2I7VJm3H53grRkc7RQx3+pNpTaqHm8rC/jo5q
	Zrg+IC/4wSEs/PmTxZmfnW8nulw1jKHHkVXZGBCVHSO88KA4+uSBknLscPvbEMq1ZYdcEk
	blgudi2uNvGEefDbhUO9HpuT9uio2CWZV9OSDVQmc5RqgANoQbxasqL3Dr7Z/w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ETCKHEAG;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775582211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgFVaIjlD4A8Cx+RdINvJRUtP4IuJzJROGNudSylLXY=;
	b=ETCKHEAGEx1/0K4Si+rx99YtXPh6gyHsGXF2b44aqYG7rMlsD3WcP+DRhvmqr6MRwfBCeO
	lNKUoIZQeTERS5oJtAA7W0gSNOVrm2HynpoLNbk7BYWYhRgGjX8csuDxkD96LMF1Bc9j8i
	r/B8m520w2IInxRNdeIs94bwBUnRdplCYVqUJR/x+oD6+UKmqBnO0DG8DrgxridVYq90KR
	Q3ZM/JmufAqeMhoNYQ6/HLPNAQhpAcH8RpJqtR++h6V9C2Aba5s4LfszE0jELJSYpLv8DR
	IRsoBUcOGk00mmTjDlqCfzq/PiR5ZjWr2VQfbarDusdWGzet5MtJVDfWnNjshQ==
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gregkh@linuxfoundation.org,
	ben@decadent.org.uk,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 3/3] net: rose: fix out-of-bounds read in rose_parse_ccitt()
Date: Wed,  8 Apr 2026 01:16:00 +0800
Message-ID: <20260407171600.102988-4-mashiro.chen@mailbox.org>
In-Reply-To: <20260407171600.102988-1-mashiro.chen@mailbox.org>
References: <20260407171600.102988-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ji1yzs1c3jzcptsf51sujisbnqip7w8b
X-MBO-RS-ID: 73475cd51da76a5cfc5
X-Rspamd-Queue-Id: 4fqtCm4Zrvz9ygJ

rose_parse_ccitt() handles 0xC0-class facilities by reading l = p[1]
and validating 10 <= l <= 20, but never checks whether the remaining
buffer actually contains l + 2 bytes before accessing p + 7 and
p + 12 via memcpy().

An attacker can send a ROSE_CALL_REQUEST frame with a crafted CCITT
facility whose declared length fits the 10-20 range but whose actual
data is truncated. This causes the kernel to read up to l + 2 bytes
beyond the end of the facilities field, leaking adjacent skb data.

By contrast, rose_parse_national() already performs the equivalent
check (if (len < 2 + l) return -1) for all its 0xC0-class cases.

Add the same check to rose_parse_ccitt() before any data access.

Fixes: e0bccd315db0 ("rose: Add length checks to CALL_REQUEST parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 net/rose/rose_subr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rose/rose_subr.c b/net/rose/rose_subr.c
index 4dbc437a9e229..a902ddeddc5bd 100644
--- a/net/rose/rose_subr.c
+++ b/net/rose/rose_subr.c
@@ -370,6 +370,9 @@ static int rose_parse_ccitt(unsigned char *p, struct rose_facilities_struct *fac
 			if (l < 10 || l > 20)
 				return -1;
 
+			if (len < 2 + l)
+				return -1;
+
 			if (*p == FAC_CCITT_DEST_NSAP) {
 				memcpy(&facilities->source_addr, p + 7, ROSE_ADDR_LEN);
 				memcpy(callsign, p + 12,   l - 10);
-- 
2.53.0

