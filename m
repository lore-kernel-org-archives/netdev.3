Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622D29827E
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493056; cv=none; b=I7JHaSCn/PdMAWwtGpBA9JBClvEvce0kCL8UXX1kDm5wBfcPT4z1sEiIHaoPDZ3f/SnnxQSPmVu9p9G7yDViHCve1BOYd7D+gZA3LWPKmPS+zYyStYbXlmzsvJ7Di2yzOZgib1exoaz2LdTMcFBE1/T9vTA/zmiDeyYr4w0JxQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493056; c=relaxed/simple;
	bh=Vhv5QGNkXgiamukhUdGb2Fjg1rh04/T37GXnC3fV3xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbaurVXDzdqG8jDo6ZJ+bPfxfkdGZgFfNe/qX5vaGd5AH3rB7+hbZ/7J+B/LMOYjOXYhGhxkL7OlI7W8HidZvV+Xlr9QtdhCtZ+HoyM8PSxVUwDddiLCz17wtkDy9n+JQh8VVpznnnhfLJENQIUKiRRl3svMu15jegmzB7UTKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TgKuKqAs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6QBaXIfk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ykgk1ku/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GKi89Y20; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TgKuKqAs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6QBaXIfk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ykgk1ku/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GKi89Y20"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDD636A82D;
	Wed,  3 Jun 2026 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780493053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsWdvrnaQyN9Au0fWCSFhfdUqnTuFJQb9ajC6GtziR0=;
	b=TgKuKqAspmue7CRZI80QYTp8YMNboei6VW+KHtjL3+RqVY5VgdFUFR+q+Z/5g/O5xf7PDM
	+tkt4SbsZLi4JLfd+9irUvIDspCMCTWX0k4MhsAXXHFhbdg6oHcHjAtHoW14TZGFsfPxDA
	ehDS/VAmwraKuZekzHc/bCx7xQN+N4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780493053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsWdvrnaQyN9Au0fWCSFhfdUqnTuFJQb9ajC6GtziR0=;
	b=6QBaXIfkKw4E9MVjQrhNcZAjmS/VPqk4ne02e91xZp9pIhU/mwgIBLZ593btFIREMFSoP3
	IMa4OW/EwGcupRAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780493052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsWdvrnaQyN9Au0fWCSFhfdUqnTuFJQb9ajC6GtziR0=;
	b=Ykgk1ku/6CEpqkMrRswAa0NTcn9DunA+DGrgrTgATWP3pX3fl+kBPNbNYhN+hZpGc7lIDy
	BNR47TSKkMYF+7oGqAvFlmx3uQ5Qgl63/FBZKF60fmw1p7QDY1oej2qxt/xHOolBcm2Mcz
	NBaOtkcL41xQcPZP/+jYlIOpD1EaD24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780493052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsWdvrnaQyN9Au0fWCSFhfdUqnTuFJQb9ajC6GtziR0=;
	b=GKi89Y20mDrqEmbLnMkyiuIMBAfTCGbSgKLQZd6fHqnOWzzg++rKMrucbEK5fYY+TV/JEB
	BQEQ2d/qWcmIVoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B2BE779A7;
	Wed,  3 Jun 2026 13:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p9IRD/wqIGqWPgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 03 Jun 2026 13:24:12 +0000
Message-ID: <491689b6-95f9-4e32-ae70-fdae464af353@suse.de>
Date: Wed, 3 Jun 2026 15:24:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
To: nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
References: <20260601143242.6729-1-fmancera@suse.de>
 <6365ef1e-d62d-4b2d-8e41-526881bbbe37@6wind.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <6365ef1e-d62d-4b2d-8e41-526881bbbe37@6wind.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,6wind.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 6/3/26 2:50 PM, Nicolas Dichtel wrote:
> Le 01/06/2026 à 16:32, Fernando Fernandez Mancera a écrit :
>> Currently, modifying IPv4 interface configuration parameters requires
>> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
>> ip-netconf exists for monitoring these values, there has been no native
>> way to set them directly through iproute2.
>>
>> This patch introduces the support for that via 'inet' at the 'ip link
>> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
>>
>> Example to enable forwarding on an interface:
>>
>> ip link set dev enp8s0 inet forwarding on
>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> 
> Do you plan to add the ipv6 part also?

Yes, it is cooking but I want to get merged IPv4 first.

Thanks!

