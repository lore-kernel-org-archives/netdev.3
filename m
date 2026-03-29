Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAE298CA5
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803547; cv=none; b=r9zsimTBox2UkfkuaXhTvZc1KHpHcYeOWUlS5yX0mFxrOIrE8CXSLAgf4+z0tgbnyhlQGkcCM5iZXYAAuNv1nL+UNL5ryK8VNbPy7nk/HSr7NcSY4Demc0lw1V7vU07ZryoagfKfZwmSvAPA2tn5ceaxYAyRN4FzuB+5gbohT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803547; c=relaxed/simple;
	bh=paYO3nmNOR9iOQfjKNwxydawdzqv+umKpN42dke+3HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJQHaw+oD/6ZxoEpuO2hyS7uA2W1nkldvQkHGZPDzp4VThtnSLud+YzDA6h33H1Aio1BB202yX3XrsXzymfGZVtxWEldP10g8ApLcnV5Odi7Hv6s15k4vTU2Ro9VUiLmZJWtSvNtu1cCVXBiO4pkdjdTtiWq65H0Z7BmQ5448Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SPRucOqE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dInq7nPx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jBpN+qKB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GXmGDVaX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SPRucOqE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dInq7nPx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jBpN+qKB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GXmGDVaX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC1195BD28;
	Sun, 29 Mar 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774803544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpyo3F6OD3iMxEqmTNjztlzry2HI0hRL6vVjaYhEez0=;
	b=SPRucOqEhBTQTB03AfxSopVSmVipQH/Z6IpLOqsjO6RoBikTK0KCfk8QJFX//4IjIZKYmu
	K+Q90aYsUUMVuJ1RU1vSl7v2wFKFm9jqO+70oSsD+LnINevC+wMs3MP58dBfYJepicOzSU
	bO7U42jizAkJnAx7eF43VlnmfhSjDCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774803544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpyo3F6OD3iMxEqmTNjztlzry2HI0hRL6vVjaYhEez0=;
	b=dInq7nPx7uKmn9LhKRfbwuo+5o/XyyKX/buP+YyxnxBHEjUlbx5S1vF1qAUIBvMK6M2zCt
	UCULeyCzYHJPeVBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jBpN+qKB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GXmGDVaX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774803542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpyo3F6OD3iMxEqmTNjztlzry2HI0hRL6vVjaYhEez0=;
	b=jBpN+qKBkCLKEmc4tcORFXjuxXFG1M5455NSz2TsLRgnc/knARTS9Sxci4VaM1dzcaLqyX
	SWbWw+AiiNEgYNsquEvOd/lof0mBosy6AaDFLWAw2cORaBqTE2R/eLR8q/q9bf9AfssRJo
	Hs7RHf7rY0Dp8AtLF6gpJgHVsrOzBms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774803542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpyo3F6OD3iMxEqmTNjztlzry2HI0hRL6vVjaYhEez0=;
	b=GXmGDVaXPOQShOxu7EXQE9NEE0gyBGaT+kc5D7RJocqSF9/Dbux2PwFcpF8me2hsmhoQOb
	nTiNWl/atVodNVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AFE64A0A2;
	Sun, 29 Mar 2026 16:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6lAwB1ZayWkkVQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 29 Mar 2026 16:59:02 +0000
Message-ID: <856eb43a-d4d0-4e1e-895f-75fca4eec51d@suse.de>
Date: Sun, 29 Mar 2026 18:58:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net: hsr: sync hw addr of slave2 according to
 slave1 hw addr on PRP
To: Luka Gejak <luka.gejak@linux.dev>,
 Fernando Fernandez Mancera <ffmancera@riseup.net>, netdev@vger.kernel.org
Cc: edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com,
 horms@kernel.org, lukma@denx.de, kuba@kernel.org
References: <20250409101911.3120-1-ffmancera@riseup.net>
 <DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,riseup.net:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC1195BD28

On 3/29/26 5:07 PM, Luka Gejak wrote:
> On Wed Apr 9, 2025 at 12:19 PM CEST, Fernando Fernandez Mancera wrote:
>> In order to work properly PRP requires slave1 and slave2 to share the
>> same MAC address. To ease the configuration process on userspace tools,
>> sync the slave2 MAC address with slave1. In addition, when deleting the
>> port from the list, restore the original MAC address.
>>
>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>> ---
>> v3: restore the original MAC address on slave removal.
>> ---
>>   net/hsr/hsr_device.c | 5 +++++
>>   net/hsr/hsr_main.c   | 9 +++++++++
>>   net/hsr/hsr_main.h   | 1 +
>>   net/hsr/hsr_slave.c  | 2 ++
>>   4 files changed, 17 insertions(+)
>>
>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>> index 439cfb7ad5d1..e8922e8d9398 100644
>> --- a/net/hsr/hsr_device.c
>> +++ b/net/hsr/hsr_device.c
>> @@ -761,6 +761,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>>   	if (res)
>>   		goto err_unregister;
>>   
>> +	if (protocol_version == PRP_V1) {
>> +		eth_hw_addr_set(slave[1], slave[0]->dev_addr);
>> +		call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
>> +	}
>> +
>>   	if (interlink) {
>>   		res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
>>   		if (res)
>> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
>> index d7ae32473c41..192893c3f2ec 100644
>> --- a/net/hsr/hsr_main.c
>> +++ b/net/hsr/hsr_main.c
>> @@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
>>   			eth_hw_addr_set(master->dev, dev->dev_addr);
>>   			call_netdevice_notifiers(NETDEV_CHANGEADDR,
>>   						 master->dev);
>> +
>> +			if (hsr->prot_version == PRP_V1) {
>> +				port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
>> +				if (port) {
>> +					eth_hw_addr_set(port->dev, dev->dev_addr);
>> +					call_netdevice_notifiers(NETDEV_CHANGEADDR,
>> +								 port->dev);
>> +				}
>> +			}
>>   		}
>>   
>>   		/* Make sure we recognize frames from ourselves in hsr_rcv() */
>> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
>> index 1bc47b17a296..135ec5fce019 100644
>> --- a/net/hsr/hsr_main.h
>> +++ b/net/hsr/hsr_main.h
>> @@ -155,6 +155,7 @@ struct hsr_port {
>>   	struct hsr_priv		*hsr;
>>   	enum hsr_port_type	type;
>>   	struct rcu_head		rcu;
>> +	unsigned char		original_macaddress[ETH_ALEN];
>>   };
>>   
>>   struct hsr_frame_info;
>> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
>> index 2a802a5de2ac..b87b6a6fe070 100644
>> --- a/net/hsr/hsr_slave.c
>> +++ b/net/hsr/hsr_slave.c
>> @@ -196,6 +196,7 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
>>   	port->hsr = hsr;
>>   	port->dev = dev;
>>   	port->type = type;
>> +	ether_addr_copy(port->original_macaddress, dev->dev_addr);
>>   
>>   	if (type != HSR_PT_MASTER) {
>>   		res = hsr_portdev_setup(hsr, dev, port, extack);
>> @@ -232,6 +233,7 @@ void hsr_del_port(struct hsr_port *port)
>>   		if (!port->hsr->fwd_offloaded)
>>   			dev_set_promiscuity(port->dev, -1);
>>   		netdev_upper_dev_unlink(port->dev, master->dev);
>> +		eth_hw_addr_set(port->dev, port->original_macaddress);
>>   	}
>>   
>>   	kfree_rcu(port, rcu);
> 
> Hi Fernando,
> 
> Thanks for the patch. The logic to sync the slave2 MAC address with
> slave1 for PRP is sound, but there are a few implementation issues here
> that will cause hardware filtering problems and style violations.
> 
> 1. Hardware MAC Filtering
> In your current implementation:
> 
>    if (protocol_version == PRP_V1) {
> 
>        eth_hw_addr_set(slave[1], slave[0]->dev_addr);
> 
>        call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
> 
>    }
> 
> eth_hw_addr_set() is appropriate for virtual devices (like the hsr_dev
> itself), but slave[1] is a physical net_device. By using this helper,
> you are bypassing dev->netdev_ops->ndo_set_mac_address. This means the
> physical NIC's hardware MAC filter will not be programmed, and it will
> silently drop unicast traffic destined for the new PRP MAC address
> unless the interface happens to be in promiscuous mode. You should use
> dev_set_mac_address() here instead. Note that unlike eth_hw_addr_set(),
> dev_set_mac_address() can fail and returns an error code, so you will
> need to check its return value and handle the error path accordingly.
> 
> 2. Teardown Notifiers
> In hsr_del_port():
> 
>    netdev_upper_dev_unlink(port->dev, master->dev);
>    eth_hw_addr_set(port->dev, port->original_macaddress);
> 
> You have the same issue with eth_hw_addr_set() here. Additionally,
> unlike the setup paths, this version omits call_netdevice_notifiers
> (NETDEV_CHANGEADDR, port->dev). Switching to dev_set_mac_address() for
> the restoration will handle both the hardware programming and the
> notifier chain automatically.
> 

These points makes sense. I guess I didn't notice the that 
eth_hw_addr_set() due to my interface being set to promiscuous mode at 
hsr_slave.c.

Let me research a bit more about the impact here and will get back to 
you either with a new patch or an reply here.

> 3. Coding Style
> In hsr_main.h:
> 
>    unsigned char original_macaddress[ETH_ALEN];
> 
> Please use u8 instead of unsigned char for byte arrays to align with
> standard netdev coding styles.
> 

I used `unsigned char` because it was already used around HSR code 
already, so I chose consistency. If there is a preference for u8 over 
unsigned char I could change it.

> Please address these points and submit a v4.
> 

Well, this is almost a year old so I am sending a fix instead. Is this 
some kind of automated bot going through all the patches in netdev 
mailing list? I am a bit confused about receiving a patch review a year 
later.

> Best regards,
> Luka Gejak
> 

