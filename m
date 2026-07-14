Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2A42BC3C
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061940; cv=none; b=E2RevvBy/pZglsLf0OfOy03n+FdLxMQ/WDcIkTxGGk3z/lK45P25OscUJ7lJmUVPHyYpMF3S4JQWyd3FDmDCj3fyr5BzNLnJtoo7vRM8AK7aK418n5VDuc9fuabI17eTyv6/g+Oypi2CeFN8L1Zjfyz+XqZCx//SHXSdJa+aN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061940; c=relaxed/simple;
	bh=ZD+19HbK61+QOXMgBznDG3eQijBbw4aQnzdOCwkvAQo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HK2gjjlfZs8oE8S3V/5/cqkE9MWDEU2A/Gio98xbM0qH3JIuNsDbv2zkymli4kl4vH5sb6PGFMElWvNtJP9fjmMh4Wxd3IBq8bkTcjgCcOIii3bVnqxyQS/L5q67Nx+rplIUQMyTqI8eb1uwsu7hiJrpZyoaBbSh2uuk/0saVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e78x0QuC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QrXwODE2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e78x0QuC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QrXwODE2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e78x0QuC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QrXwODE2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e78x0QuC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QrXwODE2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D01B7800A;
	Tue, 14 Jul 2026 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784061937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tk/2bzhcDzkQsl+fiQmOpCenBcb0I8lf7nQVEVRHbWk=;
	b=e78x0QuCGVzRHV0RuJv7RV178mmZZr1yds++rBS7K8c1B6j9GwPFGicrMJrZnX6bYUUVNN
	3VA1RcRzOWNDDGimlohoAF6PHXYFiOBY5mVYzTcjjxOqKALfaJ72ckCNh6GVlPm4Zgrp7G
	43aZOgzjlpKv1kBMZIicFHSS/iZEM8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784061937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tk/2bzhcDzkQsl+fiQmOpCenBcb0I8lf7nQVEVRHbWk=;
	b=QrXwODE2a78XV1CGwxOrdII0e6VY5sMxdhS3+HekMmxOp7msaI9Sku6t4llMi0zllBfOi0
	cpW/cUiFhsWydHDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784061937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tk/2bzhcDzkQsl+fiQmOpCenBcb0I8lf7nQVEVRHbWk=;
	b=e78x0QuCGVzRHV0RuJv7RV178mmZZr1yds++rBS7K8c1B6j9GwPFGicrMJrZnX6bYUUVNN
	3VA1RcRzOWNDDGimlohoAF6PHXYFiOBY5mVYzTcjjxOqKALfaJ72ckCNh6GVlPm4Zgrp7G
	43aZOgzjlpKv1kBMZIicFHSS/iZEM8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784061937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tk/2bzhcDzkQsl+fiQmOpCenBcb0I8lf7nQVEVRHbWk=;
	b=QrXwODE2a78XV1CGwxOrdII0e6VY5sMxdhS3+HekMmxOp7msaI9Sku6t4llMi0zllBfOi0
	cpW/cUiFhsWydHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 159F7779AE;
	Tue, 14 Jul 2026 20:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 32SNAvGfVmoeDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 14 Jul 2026 20:45:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net] net: hsr: fix memory leak on slave unregistration
 by removing synced VLANs
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org, eric.dumazet@gmail.com, 
 syzbot+456957213f32970c0762@syzkaller.appspotmail.com
In-Reply-To: <20260707082327.3238690-1-edumazet@google.com>
References: <20260707082327.3238690-1-edumazet@google.com>
Date: Tue, 14 Jul 2026 22:45:24 +0200
Message-Id: <178406192459.16306.5204629050926533917.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[netdev,456957213f32970c0762];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

> When an HSR master device is brought UP, it auto-adds VLAN 0 via
> vlan_vid0_add(), which propagates VID 0 to its slave devices.
> 
> If a slave device is later unregistered while HSR is active (e.g., during
> netns cleanup or interface destruction), hsr_del_port() is called to
> detach the slave port from the HSR master. However, hsr_del_port() currently
> does not delete the VLAN IDs that were synced to the slave device by HSR.
> 
> As a result, the slave device retains a refcount on VID 0 (and any other
> synced VLANs). When the slave device is destroyed, its vlan_info /
> vlan_vid_info structure remains allocated, leading to a memory leak.
> 
> Fix this by calling vlan_vids_del_by_dev(port->dev, master->dev) in
> hsr_del_port() before unlinking the slave device, matching the cleanup
> behavior in bonding and team drivers.
> 
> Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
> Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
