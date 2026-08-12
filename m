Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E360416842;
	Wed, 12 Aug 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528567; cv=none; b=cx1aj6WvB4cEHThywcGm5vBGU+NiDBLXFAGLFmbY/cxdYzEUSq2m100gadSxt9MrxWZtwBeMGZFxbY4cPKrjtjnDwbLCRJNPUN1MjHAp5eli8EXTU/gfCTh6m273K2j4OY4lCDEtnHkLg4dwF8/Fs6vt+42kKZbwdPs26OpXQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528567; c=relaxed/simple;
	bh=IdH4h6ZJyDXfwbtkr3lb8t7KoU/25hcMEqZryxqOdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9wgVzWpeE3pGz3CZqBeAEUjtCWCUDefSyH1OErMMQqq9iXucqjf6r+4znd32OXqj4SHPoEfQ5kyPqadVTL/2SLke4XAsu8zO/xSCS4ayXmPD6Q9yU6RQVv7jrJROS4kh4LOWS3PedoWvU+GCBdJMNlTii6JW241jj+545txC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gsCyIqlJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bxt3YXtt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V106pu2e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/xrDPa0D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gsCyIqlJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bxt3YXtt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V106pu2e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/xrDPa0D"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 786B33E5A;
	Wed, 12 Aug 2026 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786528560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KACcCGO77vy6XerdQiPsvSxEwYveovRBZraJemIo0Bk=;
	b=gsCyIqlJLcTXuly/NS7Dj/kMcjkh+qL9HrqINH/3xdM+ffzF6Sgoe6OX7bxEe5AooE58Ou
	wHpuMlST1SWe82qdbKjrGn0Ppc0knuRgnchwJxm00P86fuvaaWV1RDtw7xxl34gmYZVlvm
	QQp2BIrlPN5Bt9n5w6IjVSdTaDAIYhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786528560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KACcCGO77vy6XerdQiPsvSxEwYveovRBZraJemIo0Bk=;
	b=Bxt3YXttXkFl2/LGA0jDSoUP1JejzZf++kQViVSTsBxLgmW2B6xlb1mYJ+/zW2D4bSTVIW
	8UW1ZHE6VpFmbeCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786528556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KACcCGO77vy6XerdQiPsvSxEwYveovRBZraJemIo0Bk=;
	b=V106pu2eeQ+ayGQ9YLZK8d4VWesSe316OzdKniGxQ4miwaDFIqvCXBq9ouPDc3Z2uQiq/W
	CKg1D8EogrR00zfk1k4m0jQGhC14PPBDIAGRHUNvWIl70aFmGR2ZJvPocsg2Mz21qPp6UE
	mf1+nC+k/mVHJyy6j0fA/rBE+PxeA3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786528556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KACcCGO77vy6XerdQiPsvSxEwYveovRBZraJemIo0Bk=;
	b=/xrDPa0Dx/dMSx6k8bTvZz1lRGV29X+B+7uT07p+Ne+TtSPtR/DK0W7X/8HBWToQg08ypd
	g0bzqhAjbZQe5zBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 635CB779B1;
	Wed, 12 Aug 2026 09:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gUURFyxDfGo7FgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 12 Aug 2026 09:55:56 +0000
Date: Wed, 12 Aug 2026 11:55:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <yi1.lai@intel.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, lkp@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	oe-lkp@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	ltp@lists.linux.it
Subject: Re: [LTP] [linus:master] [net]  8e63c9e617: ltp.uevent02.fail
Message-ID: <anxDKg9rIbSzRS2e@yuki.lan>
References: <202608120846.30e0fb5b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202608120846.30e0fb5b-lkp@intel.com>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,yuki.lan:mid]
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 

Hi!
The test was asserting, among other things, the exact order of the
events and it expects:

Add ...net/ltp-tun
Add ...ltp-tun/queues/rx-0
Add ...ltp-tun/queues/tx-0

But after this patch the order changed to:

Add ...ltp-tun/queues/rx-0
Add ...ltp-tun/queues/tx-0
Add ...net/ltp-tun

Is the order of these messages guaranteed or do we need to adjust the
test?

-- 
Cyril Hrubis
chrubis@suse.cz
