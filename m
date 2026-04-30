Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6863FFABE
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544248; cv=none; b=BUQ8vfPgw+ivudgF30WPrpNEAbErQ2YTnBpimr+PUp32JdhH/LBecH6kx7ScsN+NkJH1azFfZUhhcTFNB1M39sy5WzTcD1X9eBpjqxWwUtR0VwyJmi3orh9Pb3pCCvxO2E+GBCHJHyJa4Tm1IlRkUAafvR5ggIG8sOGi6iCgsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544248; c=relaxed/simple;
	bh=G1+6s9MF9ooqWzATdTUyNot/Ewa3v+S48GyaK5wuz0A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=aMaeer8A70bF8wsECxtSkzl1SzQVJ67m/0idlejcAoRDSqsnMBXW32ijiLrksXw2+9aKi08oEAyYN1Xpu1tQdLvYVHIIbB5Ave1L712iuahnr3GbgEDGrYmQxgAu0l2RUlEaxkMsFwkdaSjVJjH6Grp68U8ktK78zaHHBXuaMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TqR8OjqG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9K9XrTRO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TqR8OjqG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9K9XrTRO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TqR8OjqG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9K9XrTRO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TqR8OjqG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9K9XrTRO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A8106A803
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777544240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xyj9hArsBptKSxTtLQFZT17IkKyzL2t3F+w85Fh10lA=;
	b=TqR8OjqGhtuQbAa/BZVgnIwK8wK0agY+tUjCp+p0fSsN5uxkJs65eq50aaIr5PBuao1y3i
	aUztHS52hCWqe6s2Cxi/Pwfzt68pjgSZ91FcUWWXFo9pgIBU06gA+OBF3ZNG4J0N6Ag54d
	vRR59kUMQkiCOSgosLCk1cmWh5PYcUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777544240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xyj9hArsBptKSxTtLQFZT17IkKyzL2t3F+w85Fh10lA=;
	b=9K9XrTROi6YEkRyLo4mVKeCv1FpIql57doBpdqUgYJV5XElpLxL8v+i8pKyDX2zT3EPY9g
	q5llwXrkMBpDJmCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TqR8OjqG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9K9XrTRO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777544240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xyj9hArsBptKSxTtLQFZT17IkKyzL2t3F+w85Fh10lA=;
	b=TqR8OjqGhtuQbAa/BZVgnIwK8wK0agY+tUjCp+p0fSsN5uxkJs65eq50aaIr5PBuao1y3i
	aUztHS52hCWqe6s2Cxi/Pwfzt68pjgSZ91FcUWWXFo9pgIBU06gA+OBF3ZNG4J0N6Ag54d
	vRR59kUMQkiCOSgosLCk1cmWh5PYcUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777544240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xyj9hArsBptKSxTtLQFZT17IkKyzL2t3F+w85Fh10lA=;
	b=9K9XrTROi6YEkRyLo4mVKeCv1FpIql57doBpdqUgYJV5XElpLxL8v+i8pKyDX2zT3EPY9g
	q5llwXrkMBpDJmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F7DC593B0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 066/AjAs82kacwAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>)
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:17:20 +0000
Date: Thu, 30 Apr 2026 12:17:15 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: netdev@vger.kernel.org
Subject: BUG: KASAN: slab-out-of-bounds in ice_start_xmit+0x57cc/0x5ef0
 [ice]
Message-ID: <20260430121715.2d306d73@samweis>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2A8106A803

While working on another ice issue, I've noticed a KASAN splat, when using
xskxceiver test program. This is caused by

        eth =3D (struct ethhdr *)skb_mac_header(skb);
...
	                           eth->h_proto =3D=3D htons(ETH_P_LLDP)) &&

in ice_xmit_frame_ring().

It would be easy to check for the unset mac_header condition in ice
driver (there are other drivers using skb_mac_header() in .ndo_start_xmit).
But since __dev_queue_xmit() is doing a skb_reset_mac_header(), shouldn't
__dev_direct_xmit() do the same ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH__dev_queue_xmit
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich
