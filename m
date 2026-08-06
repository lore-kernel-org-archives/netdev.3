Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9F389116;
	Thu,  6 Aug 2026 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015448; cv=none; b=qIJGl22M6Slt9G4RvSsNL2HMxlBmU9y30oWZHJ5HYF984NahK7btfuwnD7T9iKWmYSYWM30N39kYh2itGlcsBF24rQFBEUoDnYV/cRpbUajmel1/A/yAfNAY6j/L0jmda2ijFo20h0xfw69tuy32MnqYoqayKU1WolDG3c1/lmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015448; c=relaxed/simple;
	bh=3vLEOjS8N1lG0hFLniosjT/VLwOstvLmGVxLy9OkcpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kX42nWAtoMQkij3+sLWuYG36xqJVpIHhOiGcDTsGNwXZki7ylCWNBZRVAFLzEVBzSEpiTeOwd8//FvQHe7M8s908RRSxJQpwkOIsxtS33/DkMo8KQZ3n0lnl6Ww6YWX44sM7U4Vwi7TL/5Ja/JpN8oh80QIFbvkMQrbHbR7tCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C93c0M5w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AlSOPzWA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=On80Q5a5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vek3Nv6y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C93c0M5w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AlSOPzWA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="On80Q5a5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vek3Nv6y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C77CE3E26;
	Thu,  6 Aug 2026 11:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786015441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA+g1zExc+Vt9DbKRrbRKHDuL82vbl57gQDAwHJd838=;
	b=C93c0M5wNEJBJ5itNtR7l1+TFbzDTfmitNnht6iZ68F9yBMfpLQAtG8Zk22tLJfVj2j/JO
	qw0TlyHo+dRFs20grjRVwVuPOXF2FXCjNPQR/vvwuvYdlPO+vJuEPseOc3VX59sV307VeT
	CSZ/nzs141x6T5fue+g0cz2ewOTZH+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786015441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA+g1zExc+Vt9DbKRrbRKHDuL82vbl57gQDAwHJd838=;
	b=AlSOPzWA6BS6gqUG1/OnsnQ04rzyKpl3mLK/3UOQ7qCqxt9VXv87YbTbCl/xQdo5uezsrt
	uaXYhypYh7r6HPBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=On80Q5a5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vek3Nv6y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786015436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA+g1zExc+Vt9DbKRrbRKHDuL82vbl57gQDAwHJd838=;
	b=On80Q5a5EwVHxLNLyAvY3gAPC95DYTLDTYFWcJZ+cf8olRq+nA12znhd3sBfzY1qllqlrm
	0F4xGGBCa4+rxMfSbBVZZzFB1WpR9/SW7aOtgRnOFsYPa44ggYxEUm1MBSU53dRzdmzX3k
	9RgO5RN4PpibmW7rdzVjbR1ZMDIjrSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786015436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA+g1zExc+Vt9DbKRrbRKHDuL82vbl57gQDAwHJd838=;
	b=vek3Nv6yUpLsML4koUzIZp4YeJ81jVx+lTyDa+itsbCkdF15RGzdZNghKSQpPzEcf0XVXi
	VWzSiLVt814RtgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CC98779B6;
	Thu,  6 Aug 2026 11:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bSojCMxudGpkHgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 06 Aug 2026 11:23:56 +0000
Message-ID: <fbc724d3-6f78-4ad8-a3a0-005b055cf225@suse.de>
Date: Thu, 6 Aug 2026 13:23:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: fix wrong extack attribute in ARP validate
 netlink error path
To: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Toppins <jon.toppins+linux@gmail.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260806-bond_arp_validate-v1-1-3ae005657ef9@kylinos.cn>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260806-bond_arp_validate-v1-1-3ae005657ef9@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[linux,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: C77CE3E26
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/6/26 5:29 AM, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> The attribute of netlink error message should be IFLA_BOND_ARP_VALIDATE
> when ARP validation setting fails.
> 
> Fixes: 2bff369b2354 ("bonding: netlink error message support for options")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

>   drivers/net/bonding/bond_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 4a11572f663d..7dc31b2551c4 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -372,7 +372,7 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>   		int arp_validate = nla_get_u32(data[IFLA_BOND_ARP_VALIDATE]);
>   
>   		if (arp_validate && miimon) {
> -			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_BOND_ARP_INTERVAL],
> +			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_BOND_ARP_VALIDATE],
>   					    "ARP validating cannot be used with MII monitoring");
>   			return -EINVAL;
>   		}
> 
> ---
> base-commit: 2a33516f9ef59ad11844d4fc152f889449b5daf3
> change-id: 20260806-bond_arp_validate-359289656609
> 
> Best regards,

