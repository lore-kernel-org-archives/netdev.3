Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363C3806C9
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736472; cv=none; b=E1pw0OUaeTYPR+e/kEd/iLvS7ezNOJbFJV6/1FhgtonlNNXEQjkWTL41wCjB3cFVUgjtfCdTGr7vva8G0Glwe46FXSoy76YhsQVB6f7nftVpWAAVsScmDhDPk05T76BQ3D7Ogd3KWKvUNPcKgI1bFIMMAiVSg7HUmUvkIUocryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736472; c=relaxed/simple;
	bh=SKt0D/iHb8mNXh/sFbtB7gORydYNyQX7Mb4wnR1PujQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DdG7MKkAadoXsRXsPU39cxSYk2zHJ9UITzEWzx+CMGyPOMI4TNWN609/yPSZMRNB5pmXoWjgKTxayoPdNuVTrMjhBUoeBvnoCnPu1/l+TW/AcdunfYhjmYQ9uh4jU6Z5kUPhJKRgb/ADaIH96cTPvuXGMiisswtX9/7D3nrF0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Un0nVMoE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JCw05ylF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Un0nVMoE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JCw05ylF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D2163E6FE;
	Tue, 10 Feb 2026 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wObBfLBo/cd37oIHRnwKKvlHbiEGRUCdZwnGZQO+6d8=;
	b=Un0nVMoEfW0zka2wN89D4uXuLAk7FOV7v/gI2XhqHZFqd4rrS0GDKDFoBvR0yH3sxL0i3c
	xS9LUB3mrUyOXfQjN/vmjysGR889P+AFCtEtXr6XGRCfiG+14P/uWTiCd6+IUqDjT2adAH
	RukTySUIFpQ5b37rps6+877IVw2gTqE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JCw05ylF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wObBfLBo/cd37oIHRnwKKvlHbiEGRUCdZwnGZQO+6d8=;
	b=JCw05ylFks5pOq/YuDSNDoaSyzHQB8asBEKcvfubRDCGRlylwu6BbisLRx7kafKsGfVZeA
	EOdJjKF/q/jxWGz5DwG9CdwAIfV94beIRCKavtfTyIwR9JmoeL/1pWzSPBREpKjE3MUadk
	quDBpl0MHXEePfhnX9dBkXRCYYKjXhs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29EAD3EA62;
	Tue, 10 Feb 2026 15:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mTe2CE1Li2lmVgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 10 Feb 2026 15:14:21 +0000
From: Oliver Neukum <oneukum@suse.com>
To: netdev@vger.kernel.org,
	hayeswang@realtek.com,
	bjorn@mork.no,
	o.rempel@pengutronix.de
Subject: [RFC net-next 0/3] cleanup of usbnet descriptor allocation
Date: Tue, 10 Feb 2026 16:11:11 +0100
Message-ID: <20260210151416.42254-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 6D2163E6FE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Currently the driver has an array of long[5]. That may or may not be
enough, so a secondary pointer was added.

That is quite complex. This series adds a field to driver_info, by
which mini drivers tell usbnet how much space they need. This allows
basically unlimited allocations.

This is the first draft. 

