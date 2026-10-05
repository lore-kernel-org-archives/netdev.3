Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D394AAC73
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213353; cv=none; b=neQHLYo/WSbMdpj238dB/ty6YsVQYr6NmBZoPOA36PFFBjVq/HN4Ez2GK+8cIX0QT1rTtvedtVxtau3f/+iTLmEHPuwVOE4eLrYs578OJy7HAUg87fHP7wl1o4wK9kwbiT0uSWz2yfJtIXZh9WfwjOZWUZJ0b4qBplB1gqtTT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213353; c=relaxed/simple;
	bh=BeK6bxVF41CzoGVBX6R9nsg5eTZr7OweveCWsKXQygs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPi30vAos3Hpsa7zh9N/FlVJ1ZBVfrlxX2qfIeuzKEnh5Ict6rCvGbWMc33xwLzhUQprd13rnpMcKiYjoukaQ5dloxZ6OEySRy/QItX8Rd6iD20Sq0TC/h58KdBgb/leb17FAW7bCVtsfNNNp24nnflBU2sTqc0Zk9jRdfUOvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q3tbxfjJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0I2DJuUw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tgtfGuAE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D6gt/xHz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q3tbxfjJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0I2DJuUw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tgtfGuAE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D6gt/xHz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 646181F78E;
	Mon,  5 Oct 2026 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791213345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/IP/kxgU1XsGAePfLU1Az8Xacgvq4sz3cdzuOBhKtc=;
	b=q3tbxfjJ8tZ0FYooHg8G0asn460FwXi1azYYmoku/tSApX6TMb6mjWB5ocBJPtfX9+Ta8H
	H26S+lxoMq9PUfAiCvTiWR70giE+CFeAC2cPYcR1fPEnH1jD/F5f42UEVfAokmz86KRNDf
	jrDIRi4EnnKKbADZE2EiHCactEooZkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791213345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/IP/kxgU1XsGAePfLU1Az8Xacgvq4sz3cdzuOBhKtc=;
	b=0I2DJuUw8xDMYTzj3POvA9+jza23/+ZI5tAia7h7SzqoxWW0bxMcn/QDyhq7/QWO2E3rbD
	lQriCn9UcEg7U2Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791213341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/IP/kxgU1XsGAePfLU1Az8Xacgvq4sz3cdzuOBhKtc=;
	b=tgtfGuAEGOlxcqYw/WjWDX7RhmdNSKPlXDtJrPAaNUdQv9wyVZvqMGM/ymwKK5z061cykn
	uIW5Xwgtcp9dmbjCUnQhx8lmiLBG87RNfkgu00xYNhThMFpl1O51B6AQBIAgIrePPdPRlo
	ZjeDpRejCAEqkC1i/mCdO9YGNd0yqaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791213341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/IP/kxgU1XsGAePfLU1Az8Xacgvq4sz3cdzuOBhKtc=;
	b=D6gt/xHzG1STgaCNc7KaK7tS7gFXnyjUnhbBRvZkG7OwaUTYIk7zai1WwGel8TmaeXNaqE
	fHW62yVORqdpahCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 798BB13688;
	Mon,  5 Oct 2026 15:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0RJ5ERy/w2oDZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 05 Oct 2026 15:15:40 +0000
Message-ID: <893302a7-ce9c-4765-8788-08f7eb4b1f37@suse.de>
Date: Mon, 5 Oct 2026 17:14:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: openvswitch: do not set transport header
 on later IPv4 fragments
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, blp@nicira.com,
 joe@wand.net.nz, jesse@nicira.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 i.maximets@ovn.org, echaudro@redhat.com, aconole@redhat.com
References: <20261005150831.4831-1-fmancera@suse.de>
 <179121321982.1402591.7112090306604732381@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <179121321982.1402591.7112090306604732381@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[sinfo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 10/5/26 5:13 PM, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

It is a fix that was spotted by sashiko as noted on the patch note under 
the commit message. Anyway, I believe this should go to net-next, no 
user ever spotted this issue.

