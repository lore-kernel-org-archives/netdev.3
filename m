Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B23EC82C;
	Mon, 24 Aug 2026 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561134; cv=none; b=tm+dJuwjG9BYmvC0DH9cb9Rjv0Xvio2Vb1i9vPfSlJex+okhj8USiH3YIIDA4VVijWJUrEwZjOieLB/9tM1R+ap+lEnaEsgRf30vxQTaAopIQvwrodMStLYRGHswg9bRLnVsyPyxJvKP7WJ6jYZw2bGu4GMPgw27XaXzezozl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561134; c=relaxed/simple;
	bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGpobNTeGsWzjdcnGeq2mc57y5Jw91BD6VY92UTb4QyojEgTlalSK9R0YRkitvEZYpgpXeVcBITjLK5REXj/GmjEqpMQkhs5vBM70Tr5zTbVqat0pD2YQsb4VHNBDpuU1/Oj9l/gTZJIXFc2ZVK6p05lynabnbDnIZLgM9pKxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xE5ndECR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5NiaIj+w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1KBVPjwf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1GbpM6NZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xE5ndECR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5NiaIj+w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1KBVPjwf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1GbpM6NZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07E0A867B0;
	Mon, 24 Aug 2026 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787561125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
	b=xE5ndECRYzc8WVHdhqhBXpPPRcy7jYoyBdZJsKRSnxvjmJ/AVCBWHp0x0cHH1wL5tFJqYO
	6U0XwuFmUrGWjQwJzQKkgEJVvjNvjssqybcP348INkA7s5ngCDCOzFcQXAWXs7S2rMMdhe
	JT45Y5RTHN8sRB7W1EJJHv3nTlV/2Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787561125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
	b=5NiaIj+wQPTd+TzN9Vt1X/AnhCYQYrzh2sV65lBS3+N/WVrl382ivw4u8FvTlsKvHl5zQC
	AjCqMto/rpVFZ9BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1KBVPjwf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1GbpM6NZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787561121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
	b=1KBVPjwf230umHTxY8Mzq2uq1UytXQOFvmb7V0rHzhUWouBDf+IPksW9KVcm5Qn0tCU0kj
	0+F/t4GpTBhhGYgYNImyEl0hUSNKQrtS6i2iQmlUEipRRx9gi35+SrYL2MTKEDUoiHfUUD
	X+54hVfCFB1TO7f8NvI3qW0Q+rnRnNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787561121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
	b=1GbpM6NZhkdd+dL7tZs40BuJFHkV1hA65lTkIYmpAae0CWriE0KPYgGZBxfsT1CLmACCtO
	9hV52Ns2uLDOVCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE36113331;
	Mon, 24 Aug 2026 08:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XdIpKaAEjGobPQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Mon, 24 Aug 2026 08:45:20 +0000
Date: Mon, 24 Aug 2026 10:45:11 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ertman, David M"
 <david.m.ertman@intel.com>
Subject: Re: [PATCH net-next] ice: rephrase LLDP filter fallback message
Message-ID: <20260824104511.7a46a136@samweis>
In-Reply-To: <477734d9-ed8e-4696-8160-382b29e7491c@intel.com>
References: <20260717084453.9521-1-tbogendoerfer@suse.de>
	<477734d9-ed8e-4696-8160-382b29e7491c@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 07E0A867B0
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Fri, 21 Aug 2026 13:59:26 -0700
Tony Nguyen <anthony.l.nguyen@intel.com> wrote:

> On 7/17/2026 1:44 AM, Thomas Bogendoerfer wrote:
> > Seeing an error message in a logfile triggers scripts/admins thinking of
> > problems. The LLDP fallback message itself is not an error, it just
> > indicates it's using a different filter mechanism. So rephrase to a
> > less "scary" message. =20
>=20
> Hi Thomas,
>=20
> I believe this patch [1] will remove the need for this change. Could=20
> test it and confirm that it will work for you?
>=20
> Thanks,
> Tony
>=20
> [1]=20
> https://lore.kernel.org/intel-wired-lan/20260811181127.1142095-1-david.m.=
ertman@intel.com/=20

that solves issue, too.

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abhinav Puri
