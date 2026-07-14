Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66023A3E87
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029497; cv=none; b=I7cPZiDWws2+i1xTIwkcquOA1MIIbbO2z3n+R4OlNv3VAE2TYRjudVW7u3Uf2oIlFC1O6N6vibwGy+pWLbjh+jjR4DJrMY4G4X6oWovUpjUaG1inpCnnSary82HJAzZzhXF33/NzhSjvbMtqg/inGvTNBg6s8xXrVJ3CtZA03m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029497; c=relaxed/simple;
	bh=2FtproTtAMCk7FLeRakcPncvPMXzomNH62w+lywarWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se82oIKMMy/RwJrSU+W4CjSWdSa4YCt5PLImA9N5rphuwS9AofFDz1ZWbmRd/Pgd6ny6JSFJGUYMK/kYpO7gJK3qiBsZV09q5FSmNa0kKL2I/mgjbfJ4KY7OxX33BmYxe57YE3W45J3ylnV2OsF/WPpNwoBp3GMkdW+3zG3MjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FiO/xU4z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FiO/xU4z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FiO/xU4z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FiO/xU4z"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 090153E2A;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YX+mTlt1U2ALz4CQqRTDtmC4lDOD9OO2v4ERzF5/6OE=;
	b=FiO/xU4z7l9WJBWxoMKS9IUysNsmAGOAxpMP+Ew+o4UTN6tkG5sKeI6zKndZudVtgd89zz
	HIgU8GFuSEXEDAXZ3vBbtMYPXdltsGjkBtJd3eahBy2edvtSBNjIP8HMrN7btiULx0xK3M
	+dGDq+X6QyEz73BQ3b81EcBf/uAzLBU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YX+mTlt1U2ALz4CQqRTDtmC4lDOD9OO2v4ERzF5/6OE=;
	b=FiO/xU4z7l9WJBWxoMKS9IUysNsmAGOAxpMP+Ew+o4UTN6tkG5sKeI6zKndZudVtgd89zz
	HIgU8GFuSEXEDAXZ3vBbtMYPXdltsGjkBtJd3eahBy2edvtSBNjIP8HMrN7btiULx0xK3M
	+dGDq+X6QyEz73BQ3b81EcBf/uAzLBU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCABC779AE;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EGEMLSAhVmp+cwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 14 Jul 2026 11:44:32 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	manuelebner@mailbox.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv3 net-next 5/9] net: usb: int51x1: drop dependency on cdc_ether
Date: Tue, 14 Jul 2026 13:44:25 +0200
Message-ID: <20260714114429.1073434-5-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714114429.1073434-1-oneukum@suse.com>
References: <20260714114429.1073434-1-oneukum@suse.com>
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
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLp6hgsbiwipf7smy58x9iwpej)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

The driver depended on cdc_ether only for usbnet_cdc_update_filter().
This has been shifted to usbnet. Drop the dependency.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v2:
- added as missed opportunity

 drivers/net/usb/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 52a5c0922c79..da0f6a138f4f 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -563,7 +563,6 @@ config USB_HSO
 config USB_NET_INT51X1
 	tristate "Intellon PLC based usb adapter"
 	depends on USB_USBNET
-	select USB_NET_CDCETHER
 	help
 	  Choose this option if you're using a 14Mb USB-based PLC
 	  (Powerline Communications) solution with an Intellon
-- 
2.54.0

