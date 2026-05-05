Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA637B014
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012249; cv=none; b=mlPfCTRVRzUMiv3J3UDyNkeuDh7EtGP6jiLbe3SjIY4nvoqb7x6hyvOEZV1rD7SDxef8Sd3T7N3xQc5/JwHkDW9GwTWixHaxEYJNJ8IBIpCRduOFEDoDpnMal7U1kti70BKr8tV9TDIqwV366Ls6vYLcL3gLfzQbDhZPB+UFOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012249; c=relaxed/simple;
	bh=yjegzxdpedvUEVKpeTbiJ04p8hbeZO58WLHVoiSKhHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNMgb/xrxL+NYSqxcQhFVMll8oCmoG98ERFvE6xM4mhU3XKUDk0lAI0wxYJ1NBnydvDpLlD8a7TFtJQJARKY6GJ9Hqq4VQLFwD097BztPa3P5AiWnlP1SN1ZJS1wpYzuwu6qt8/UBuX/ZIODiX4le9u/He0QkGdhU5pW7U6M8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G/rQ2rIG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dOxJRpdg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=thcNl430; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YJITqGmZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G/rQ2rIG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dOxJRpdg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="thcNl430";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YJITqGmZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4E6B5C5CA;
	Tue,  5 May 2026 20:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778012246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PzcBJnou4ZKqLWAhMZYrgVhKM3puTK8etlTa41NC54=;
	b=G/rQ2rIGDdFq5SARG/7mgrG1efFnrquLsHT2hdb8xKPSqLNYbgHCoASGSGWMmnMDV7Bdzh
	1d8FFUK85nD0nfViz+1Jzkd9DXX+PBsSoM3MfJ1IY2DlAdKgqvLECTdg8yeLq5ZuGS7jGz
	OUXWIFAzJfHjdyv0sP/iN3dlftIH5QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778012246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PzcBJnou4ZKqLWAhMZYrgVhKM3puTK8etlTa41NC54=;
	b=dOxJRpdglMpv4quHCNxtaN1Gp0rEBoK0QIfJwOjRf4qZs9RFFFzErfraTdPV79TN2iUrT8
	MItBMOl4cKFyw6Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=thcNl430;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YJITqGmZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778012244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PzcBJnou4ZKqLWAhMZYrgVhKM3puTK8etlTa41NC54=;
	b=thcNl430oRZA61f7k4yd6X7ADMmnpOqzDJ2s63SruOX6n1i4JMN4Hb5xhO9phEuob9hRTn
	yIWCySLvEeiZHcUJN5fQcPTkO19MTLed/oA66WWEpF4J0Uw4RZiaIUTOZ1xsG/MeJQaG/j
	Kn+n5Y1Qqt2aXzsRi2sfWSLrst0sE3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778012244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PzcBJnou4ZKqLWAhMZYrgVhKM3puTK8etlTa41NC54=;
	b=YJITqGmZ2IH71OQf1NcqX0PLaRxNCGvqvTGh2NDSwga4b0vs5HR7jTZylaquaFgINPyOxB
	0iuqVrlD87QcYdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B8BE593A3;
	Tue,  5 May 2026 20:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ROGC1RQ+mnLYwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 05 May 2026 20:17:24 +0000
Message-ID: <8064df33-daa4-430d-ac0c-3cbf2911f98a@suse.de>
Date: Tue, 5 May 2026 22:17:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ipv6: default IPV6_SIT to m
To: Alyssa Ross <hi@alyssa.is>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260503192515.290900-2-hi@alyssa.is>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260503192515.290900-2-hi@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,alyssa.is:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D4E6B5C5CA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/3/26 9:25 PM, Alyssa Ross wrote:
> This basically defaulted to m until recently, since IPV6 defaulted to
> m.  Since IPV6 was changed to a boolean with a default of y, IPV6_SIT
> started defaulting to built-in as well.  This results in a surprise
> sit0 device by default for defconfig (and defconfig-derived config)
> users at boot.  For me, this broke an (admittedly non-robust) script.
> Preserve the behaviour of most configs by avoiding building this
> module, that's probably overall seldom used compared to IPv6 as a
> whole, into the kernel.
> 
> Fixes: 309b905deee59 ("ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

As discussed:

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
