Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622A3B2FED
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780784; cv=none; b=VaIcrYWxWYlNmGh7FyfczdPgl6JQe+LrNo6m0QcstRa12m6EVtnjM3tXTAKp0BLV8kkpT1bbXGpCycHBBnW+14MLNrFvuTjtWBAmWh2T4seBN9Z1is7BPvtXSDdnyaMaoO/RvIL49NAJcHIa5ySjhfjGmcQjHQcQFXSpZsTmWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780784; c=relaxed/simple;
	bh=FNeYfy1SwZzgug/EO0lY6WxpmJZk7+D32D2cjfIbjmk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gjiYCxfs4cE1Jll9lCeFXEnSsh1hR1bAShPAoCPCh8POd8VCMdJ3ejvSvGdhe0WISqAl1axHOaPOMFW5V78dZ2E0EmWMfXnbcHmq0wzlCVtM6d45thdW4CkZgymeSo1ZJTIdUX5oTj7EQmJ9ZI6EgHLEOCG47RBom2QhWi+eMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ead9Ts7Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ead9Ts7Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ead9Ts7Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ead9Ts7Y"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49EC26C34C;
	Thu, 18 Jun 2026 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1781780776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZKHyBef4sxWkE+7l0tdtcOPsu+LbeJVuTP+qVBmXQ8s=;
	b=ead9Ts7YxghhKEwC0SCpZ+OLYpDXhmFpnK+TRm/jfocEwEBkN9ZDhfAW2CV2BaTZMR+XK6
	1gbQR60oDB/D5x03THyZLoJbWA6KfVysQ2O7dDwQfJYyhYqUveK3s8q0h4s4hzN9j3h3vA
	OWgS2IJERnhkI+cyeMbD3PT2SqlHzFI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1781780776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZKHyBef4sxWkE+7l0tdtcOPsu+LbeJVuTP+qVBmXQ8s=;
	b=ead9Ts7YxghhKEwC0SCpZ+OLYpDXhmFpnK+TRm/jfocEwEBkN9ZDhfAW2CV2BaTZMR+XK6
	1gbQR60oDB/D5x03THyZLoJbWA6KfVysQ2O7dDwQfJYyhYqUveK3s8q0h4s4hzN9j3h3vA
	OWgS2IJERnhkI+cyeMbD3PT2SqlHzFI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24012779A8;
	Thu, 18 Jun 2026 11:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YyBDByjRM2q7TgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 18 Jun 2026 11:06:16 +0000
From: Oliver Neukum <oneukum@suse.com>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: 
Date: Thu, 18 Jun 2026 13:04:14 +0200
Message-ID: <20260618110612.439021-1-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.32
X-Spamd-Result: default: False [-1.32 / 50.00];
	BAYES_HAM(-2.52)[97.86%];
	EMPTY_SUBJECT(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Level: 


Hi, unfortunately my old phne broke, so I am out of options for
testing patches for WDM. I need testers.

This patch is a major modernization of the driver in that it
switches it to using a kfifo.

	Regards
		Oliver

