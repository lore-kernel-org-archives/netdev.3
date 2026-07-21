Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC737C906
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633055; cv=none; b=RCEYXMbnQ+zavLZzCWGCUF9dV1Lo6lUHZyVq1Ta4/r4oKBAIr0jX3SHPEJm6lW3rocFJmJELxUPLADvEdfpl1LR5fBgl6GnFIE5HjQWb9JtKnGxByuLWaILFan3tE6KOchOc9zqmEanPafz4/UHJiles7/41NBxhM3OCtCrQBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633055; c=relaxed/simple;
	bh=vgYpR9II/x6F/rz8NWDIOzelFwbqtcGrOcKmNIPfS+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgGy3u5SyUp7JLYLBZl8T3y6/omZ5U0gkHabXseW7KySMtxCR50Afi4vFyUiQInt0I157wvzuNGPSVzKSvdzqyu9T8fgLUzb7Ygm34cuFJ9QQkfz59Tz/NAbMl7xbpaY5HWHm0gwfFpafvx3yfzX0B2zGzi1sW+oJx/qo/EIkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kxrShw+9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MH9P6MlP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kxrShw+9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MH9P6MlP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kxrShw+9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MH9P6MlP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kxrShw+9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MH9P6MlP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F36523E09;
	Tue, 21 Jul 2026 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784633052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyq5BOhPtqjIUrCpn+E5t12sTZJfRNLk8Spt2PZHq9w=;
	b=kxrShw+9ed9VMyDXXGddNlOek1eyFwJ4tRsIx0VTiYj0Z2TV+JFUABgRxSh7YD6uMjrWOE
	/qee5hT/LIYH2BH5JIr3VZVITdkTtzLn5Ik9Znn2u7DHOfTn2ISD8jfdwKAIlnZ0TA5EC5
	tIc6eA8xle2wQnZEmC4v9Re1twI82ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784633052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyq5BOhPtqjIUrCpn+E5t12sTZJfRNLk8Spt2PZHq9w=;
	b=MH9P6MlPReWLuAbe5r88PbPi+qCiEy34M4ZV05wLL1q5S67nLP2y80fpjF0Nkhlg8qSNcH
	uLJ8Ez90WpEuTrCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kxrShw+9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MH9P6MlP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784633052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyq5BOhPtqjIUrCpn+E5t12sTZJfRNLk8Spt2PZHq9w=;
	b=kxrShw+9ed9VMyDXXGddNlOek1eyFwJ4tRsIx0VTiYj0Z2TV+JFUABgRxSh7YD6uMjrWOE
	/qee5hT/LIYH2BH5JIr3VZVITdkTtzLn5Ik9Znn2u7DHOfTn2ISD8jfdwKAIlnZ0TA5EC5
	tIc6eA8xle2wQnZEmC4v9Re1twI82ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784633052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyq5BOhPtqjIUrCpn+E5t12sTZJfRNLk8Spt2PZHq9w=;
	b=MH9P6MlPReWLuAbe5r88PbPi+qCiEy34M4ZV05wLL1q5S67nLP2y80fpjF0Nkhlg8qSNcH
	uLJ8Ez90WpEuTrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B8A6779AA;
	Tue, 21 Jul 2026 11:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DEdZG9tWX2qADQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Jul 2026 11:24:11 +0000
Message-ID: <1af37032-776b-4e1f-84d2-f69bef3ed75e@suse.de>
Date: Tue, 21 Jul 2026 13:24:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: hsr: fix memory leak on slave unregistration
 by removing synced VLANs
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+456957213f32970c0762@syzkaller.appspotmail.com,
 Felix Maurer <fmaurer@redhat.com>
References: <20260721101240.995597-1-edumazet@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260721101240.995597-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F36523E09
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,redhat.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[456957213f32970c0762];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 7/21/26 12:12 PM, Eric Dumazet wrote:
> When an HSR master device is brought UP, it auto-adds VLAN 0 via
> vlan_vid0_add(), which propagates VID 0 to its slave devices (slave A and B).
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
> hsr_del_port() before unlinking slave A or slave B ports, matching the
> propagation logic in hsr_ndo_vlan_rx_add_vid() / hsr_ndo_vlan_rx_kill_vid()
> and the cleanup behavior in bonding and team drivers.
> 
> Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
> Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Felix Maurer <fmaurer@redhat.com>
> Cc: Fernando Fernandez Mancera <fmancera@suse.de>

Nice catch on Sashiko's feedback, thanks.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
