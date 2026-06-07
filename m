Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E02D3A93
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815450; cv=none; b=XhPVFxbGpGvfj+z4rrhVZCeObq3ROFQB3qA8PZ1q+xiGtxAdFghBGa2/TV901mT6z4VmG7UMtWiXuxTTQkegV9QEKyWc8cfBUZZIPRJD30RzLBxzFSl78dIW/2al9vfMSh+I8pJxkQ4ir0raKi7wJQdgSfv/DQeCEEVnsAJep1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815450; c=relaxed/simple;
	bh=BRM/FP5r4lN3K+WZRxceRdKmpHpdadx3ClUl7W30KJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBtzha+97UzNs2av9Ihi8KwMA7VVgjriHB64FKFmeXn6edPpqXtK1P7Ajiyg0L3/Xww2hVClOf/t8m7Xdk4hv62CfLAJF+VifGGy/bSoX+7B/dBuxg+AyNEWdwMBMY2mErWFwFPfKTs1PyFDmPhn6DZTvbMxSqVr/5Iqwro/8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nW0eDaxj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eZGTAcnj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nW0eDaxj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eZGTAcnj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nW0eDaxj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eZGTAcnj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nW0eDaxj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eZGTAcnj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CD5C75D84;
	Sun,  7 Jun 2026 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780815447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F9G0HQTLUL8qDLBEUkKtuBRS0Z3pEjOhqk3F1/1sbsU=;
	b=nW0eDaxjLK1aoYgzGsRgfrLFbMoRTc3MRLlGVi+kNakPGZCFVX9UymFCb8s3cOEHVWIaTR
	8BZ2q5B8bOTeo5+dC4p0CfktSEHWvbM5RvuKxcwh6KoTKEbMk/zeenWlNgQtYcyAatBByz
	61ehyRDkQwjfy95azT72KVaHEUVmgw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780815447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F9G0HQTLUL8qDLBEUkKtuBRS0Z3pEjOhqk3F1/1sbsU=;
	b=eZGTAcnjPLNwuwtZO4xCl9Jf99VIYN+4RVH8mUAXJD4hdbd1ZQx2+cjdsbUAQwEPs0sHgc
	cJq+Skazz2ThQBDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780815447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F9G0HQTLUL8qDLBEUkKtuBRS0Z3pEjOhqk3F1/1sbsU=;
	b=nW0eDaxjLK1aoYgzGsRgfrLFbMoRTc3MRLlGVi+kNakPGZCFVX9UymFCb8s3cOEHVWIaTR
	8BZ2q5B8bOTeo5+dC4p0CfktSEHWvbM5RvuKxcwh6KoTKEbMk/zeenWlNgQtYcyAatBByz
	61ehyRDkQwjfy95azT72KVaHEUVmgw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780815447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F9G0HQTLUL8qDLBEUkKtuBRS0Z3pEjOhqk3F1/1sbsU=;
	b=eZGTAcnjPLNwuwtZO4xCl9Jf99VIYN+4RVH8mUAXJD4hdbd1ZQx2+cjdsbUAQwEPs0sHgc
	cJq+Skazz2ThQBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1C38779A7;
	Sun,  7 Jun 2026 06:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oEbsI1YWJWoLIgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 07 Jun 2026 06:57:26 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 iproute2-next] man: iplink: fix indentation level after inet parameter
Date: Sun,  7 Jun 2026 08:57:14 +0200
Message-ID: <20260607065715.4573-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -2.80

The indentation for inet block opens with +8 but closes with -10. Fix
the imbalance.

Fixes: fdb064bf64e5 ("iplink: add support for setting IPv4 devconf parameters")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 man/man8/ip-link.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e7ef64dd..d4f9f062 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -214,7 +214,7 @@ ip-link \- network device configuration
 .br
 .RB "[ " igmpv3_unsolicited_report_interval " " INTERVAL " ] ]"
 .br
-.in -10
+.in -8
 .br
 .RB "[ " macaddr
 .RI "[ " MACADDR " ]"
-- 
2.54.0

