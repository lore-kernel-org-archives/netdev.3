Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F2355F5F;
	Thu, 10 Sep 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031441; cv=none; b=m2XIERgtEtohAAuU3LWV13C6A3ILYQOYL4hRmV8FqOLSkGCWdHJDktyWqMhSAZ497NAl7cWgcVsQfeACqY3PcJxO9Arh/V0NXDhiJNuXCXkL4eoT9S8RH93EKBSU4gqNIFGkanOYwaihF4V1+3fjmodwWgZU+RTEIMzPwnWvO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031441; c=relaxed/simple;
	bh=wa8+AB71aWAAABk7jurpjv26ahxiui1HCF9JZAeOVYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUK5DTARrp8zzCyh5uN/dJ2LVG6OS3SyzK7eLccBvZkbJvBJEpatcu0/5YdUUe3+wGo0oqOWzz4lmTyA7yNqQlONOJ3EBgPfIo3Zo23Oanygad2r93r44WWeoV9tBbSIIK3fRu2x5Dv/ko0TjrkzPAdq7NshvTVJFW0VfbLR2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P/Y0fYIF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sHfk8gXf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mp62uj+j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2AmFRRB+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P/Y0fYIF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sHfk8gXf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mp62uj+j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2AmFRRB+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C2941FDB7;
	Thu, 10 Sep 2026 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789031429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9nYzq2znk7osZTamSzy01Swvtojf1hO+2D9mmw5CNU=;
	b=P/Y0fYIFHrc/h1GPP5D/fHo2sTUwzOSc4rC07N0meWX97ZtIdZu21HqL4sZjSdsNIvsQVd
	tC7wba2rk4WQzUpclbakSrpeebgYkNCxTjGCFt16jyQo+sZcOCJj9wCyJz+yfjA7AIxB3T
	AxTNxbhjUB3TDCTmzPG0+zx+zgGUoh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789031429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9nYzq2znk7osZTamSzy01Swvtojf1hO+2D9mmw5CNU=;
	b=sHfk8gXfjccHcp27eVbITSKXqy15+2GfK5byVAMK1gbKoWG66vAE3gEvCvlbMMLMkCNP16
	NZccDP2ApvnT/oBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Mp62uj+j;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2AmFRRB+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789031425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9nYzq2znk7osZTamSzy01Swvtojf1hO+2D9mmw5CNU=;
	b=Mp62uj+jMMWLmvATNok5E9z6uvqdO1Uz61bR7MYBokF3it8PHV2BbqHSNNv69+CCe9qufb
	TeFJJzl9QcO1jG6lZaVTGWdnpgcAXFc3W4Gdw/+K5A6R/+mw6giWt5qzG/o9WVaajBEGYy
	9xxFweoQArTQRdW6RmPjceAhUPeLmHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789031425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9nYzq2znk7osZTamSzy01Swvtojf1hO+2D9mmw5CNU=;
	b=2AmFRRB+KVGBB1eoBpOXACNx+8dg7UxATPM4FguLC0qmlzsuIWD00H5bquYC5uz7VHrl2g
	OvmmGAiqMd7NbKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86EF7137FD;
	Thu, 10 Sep 2026 09:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b0IiHgB0omokfwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 09:10:24 +0000
Message-ID: <e84cd7a1-8708-43bb-bbdc-25c10611f3ad@suse.de>
Date: Thu, 10 Sep 2026 11:09:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hsr: enable promiscuous mode on interlink port
 with fwd offload
To: MD Danish Anwar <danishanwar@ti.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Kees Cook <kees@kernel.org>,
 Xiaoliang Yang <xiaoliang.yang_1@nxp.com>, Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260908090856.2876114-1-danishanwar@ti.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260908090856.2876114-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 5C2941FDB7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[ti.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nxp.com,denx.de];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ti.com:email,suse.de:dkim,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Flag: NO

On 9/8/26 11:08 AM, MD Danish Anwar wrote:
> hsr_portdev_setup() skips promiscuous mode on non-master ports when
> hsr->fwd_offloaded is set. fwd_offloaded is derived only from the ring
> slaves' NETIF_F_HW_HSR_FWD bit, so this also skips it for the interlink
> port, which never gets forwarding offload. Without promiscuous mode,
> the interlink NIC drops unicast frames addressed to hsr_dev's MAC
> (e.g. SAN traffic to the RedBox), breaking RedBox whenever the ring is
> HW-offloaded.
> 
> Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

> ---
>   net/hsr/hsr_slave.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 01c73b4b50ddd..a546f70f9cc8b 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -149,9 +149,12 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
>   	int res;
>   
>   	/* Don't use promiscuous mode for offload since L2 frame forward
> -	 * happens at the offloaded hardware.
> +	 * happens at the offloaded hardware. The interlink port never
> +	 * gets forwarding offload (RedBox forwarding to/from it is done
> +	 * by this driver), so it still needs promiscuous mode to receive
> +	 * frames addressed to hsr_dev's MAC rather than its own.
>   	 */
> -	if (!port->hsr->fwd_offloaded) {
> +	if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK) {
>   		res = dev_set_promiscuity(dev, 1);
>   		if (res)
>   			return res;
> @@ -176,7 +179,7 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
>   fail_rx_handler:
>   	netdev_upper_dev_unlink(dev, hsr_dev);
>   fail_upper_dev_link:
> -	if (!port->hsr->fwd_offloaded)
> +	if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
>   		dev_set_promiscuity(dev, -1);
>   
>   	return res;
> @@ -240,7 +243,7 @@ void hsr_del_port(struct hsr_port *port)
>   		netdev_update_features(master->dev);
>   		dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
>   		netdev_rx_handler_unregister(port->dev);
> -		if (!port->hsr->fwd_offloaded)
> +		if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
>   			dev_set_promiscuity(port->dev, -1);
>   		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
>   			vlan_vids_del_by_dev(port->dev, master->dev);
> 
> base-commit: 8d6cd188508513503805c156165de38e4e4a8615

