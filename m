Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264214B8DF8
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002715; cv=none; b=duR+K52gfCqJkMhcGtMTWksIqOnOak7yNHuk1S8fNKLCoK/HejjFVdEVbNm69yvAIQvrY5YcuZzp1pEm3blYHxggkya8bWEVXBbwdlqwajAFULhKS2fNP0r9wokvRmrNlarF2JutsHtN0TG6vVWTx4njGpZtNtIcfHwifuMuH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002715; c=relaxed/simple;
	bh=kQvdG1ro/qW7OGfA890KSZ36F9gY+uy5npmcKOKCAPo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q0GCLi+wISCcG9I4UHIq4tx2OtVNu5l5x/xi/0NIxT+rNZckmwDb45b5y+DC+LGH3yENXqiHeUk6UEC4EpLfKTZCjd8IrUgYEJ7GDoFxFMGgOFDmBg4bpxlv8e4Vu7Ymt34w19cRrxM5tOYl/9CINMDvhPmMgjmm5T7yMfEkJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QTM3q55H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QTM3q55H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QTM3q55H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QTM3q55H"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05D9E75DEB;
	Thu,  2 Jul 2026 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783002708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kQvdG1ro/qW7OGfA890KSZ36F9gY+uy5npmcKOKCAPo=;
	b=QTM3q55HZ89qkyX3br16ATmPNJGJjWwhjA+GyD8JsCu/6Xu/RzGXNmD6YEk44uuOW+P/Zv
	kip1yAg77OpqXduqARlrEg5I8WX2Vw8vVz+NNL2iBc6482SrbvWfrYIJg3IpKRp1y2o4x7
	MojqtadMoDjSJTNWAcVOK+ivrrkaEdQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783002708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kQvdG1ro/qW7OGfA890KSZ36F9gY+uy5npmcKOKCAPo=;
	b=QTM3q55HZ89qkyX3br16ATmPNJGJjWwhjA+GyD8JsCu/6Xu/RzGXNmD6YEk44uuOW+P/Zv
	kip1yAg77OpqXduqARlrEg5I8WX2Vw8vVz+NNL2iBc6482SrbvWfrYIJg3IpKRp1y2o4x7
	MojqtadMoDjSJTNWAcVOK+ivrrkaEdQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA2F0779AA;
	Thu,  2 Jul 2026 14:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RVfLFN2Rmr0MwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 02 Jul 2026 14:31:47 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shaoxul@foxmail.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: usb: move exported code to usbnet
Date: Thu,  2 Jul 2026 16:25:29 +0200
Message-ID: <20260702143142.890654-1-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com]
X-Spam-Level: 

Some drivers are reusing common code originating in other drivers.
This means that two drivers need to be loaded for one device.
Also maintainability is reduced if changes in one driver affect
another driver.
Shift common code to usbnet.

