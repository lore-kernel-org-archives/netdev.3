Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049425;
	b=veq75/ZqdVeqFlkbDx04zjQoIsVjZkB5Q24icWTJin/wepufcoNKbFajr7hRxY6XqrQL
	 qkjvCoSdP82eIVD/5/o9M32fP5gw78V3RzQ4YZNmOdBPUEfEVnq3Vu5LYP2irSw81pSIx
	 n46t/miJ1Shav2/dQcbkFMkB+ynk2xXzxxruEWupE+XR/wUn32ipdu9MekjB5KI4xuhbu
	 M0yJVomjb64pvkONPOjMeNBMUeinGOPhPHe7tdBrC2XDMOLkuE6RAd6HGgFxZQYbEVICW
	 Ot1zv/DCVqdWp/lqHas1ouZZWhrffjDgHlBfD/1nMvzRnOvrsBiZ2WuXAMekQb87QiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049425;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=VeJcoTTbgV/oFNXlCmbP8+LsE7uq4bshAQ3899aoeTQ=;
	b=2vO0Bm2ddPvYwrgzXV43D96D6Ocfz+wXRQ2cXXLJb1jI70yPKhtLawxyEh+tVsDBZNsa
	 h7n2YLWavF2ye3+QER3Rwx9Z8cUeOkP5qb67+F93ARCJcI0ymCjHGa2Vx0UvuEHKLP/an
	 tgb7zT6BjyCTr8lGBrYjQWmUVCGU5OPWHYs7K8CtH2iE/DOFvyXcNoVfRBZXU2fONZQ5k
	 VBe0dnPd9JDnvUJSom5qtwWi49CcdLVMHK+u5bz0+qSCI3YwUpdbJaLL2aC99lAPUqPlO
	 HGXl61QfXUQpCXSmyEepBWiwMNzd0mjONXpO50LDpN1L2nQv/2TD914tySzV6BCNlnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nRUxJNiM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="Gex/1IpR";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d8ERr5ip;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dss5hRZl;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A1606A31A;
	Mon, 26 Oct 2026 21:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE3A1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nRUxJNiM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gex/1IpR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d8ERr5ip;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dss5hRZl
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C78271F387;
	Mon, 26 Oct 2026 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793049423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeJcoTTbgV/oFNXlCmbP8+LsE7uq4bshAQ3899aoeTQ=;
	b=nRUxJNiMGDVeGZvPUJ2vApnvjMioKgl9w5OHF9RPMB6WzlkbS5pfku+ISk++3qs54laZzl
	b0oK0EQf/8J5LCn2yRHGy1MYxYbGKSbbegSNJmec1BQF8XuVCxBuI1uIiHyf9WDuPZwxWS
	/W5gpIK7vxIf/sTD4ExeI5GP2eyw2jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793049423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeJcoTTbgV/oFNXlCmbP8+LsE7uq4bshAQ3899aoeTQ=;
	b=Gex/1IpR0cBP4uP1bq0bYU6dk/e8HQlTS31kbnkAXym/Fj2ktrB1qhffI0UEBj0ViKIJIP
	Hs2aBzWKFnve4cDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d8ERr5ip;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dss5hRZl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793049422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeJcoTTbgV/oFNXlCmbP8+LsE7uq4bshAQ3899aoeTQ=;
	b=d8ERr5iprYfZ/2kzjCB1sig2P/i9e85gNKK7oGo2TUAc0zq7dPrc9ITBLLfIWnA71RT7WY
	Jwv7IZoVPUhS6ZLeQD8IAr9plpdt0RW6Lb3bZs+SKmDZ1kCDCxnDaYxl8JW47rwKxOM6eJ
	Yfp52IqyHeBJGtBa7h+/pK/VDlil9jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793049422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeJcoTTbgV/oFNXlCmbP8+LsE7uq4bshAQ3899aoeTQ=;
	b=dss5hRZlRlV2z3Y69FbqdbUOUY0mthhfeVYCHOj5A7wiJrJBxJ/PUa8a+p/sEES1MztXuI
	uxT6QkPeu0a2SgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67C4213408;
	Mon, 26 Oct 2026 21:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3qiRDk7D32pBYgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 26 Oct 2026 21:17:02 +0000
Message-ID: <90774e9b-810a-4be1-bf9a-6326c74f88df@suse.de>
Date: Mon, 26 Oct 2026 22:15:56 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: null-ptr-deref Read in
 netlink_has_listeners
To: syzbot <syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6adf9f64.6200f071.51519.0ed1.GAE@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <6adf9f64.6200f071.51519.0ed1.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C78271F387
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4ccb65e03706547e];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[1269fe6cc2016008124e];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -12.50

On 10/26/26 7:43 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c03c1a14507d Linux 7.3
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a01ae1580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ccb65e03706547e
> dashboard link: https://syzkaller.appspot.com/bug?extid=1269fe6cc2016008124e
> compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11515031580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com

This has been fixed by:

6b3e73774815 ("devlink: fix reload error on netns teardown")

I have verified it with the reproducer provided.

Thanks,
Fernando.
