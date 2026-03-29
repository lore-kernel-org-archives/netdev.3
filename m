Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CF37D107
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804982; cv=none; b=Iib2tmNvw6w8uXy2gM+vagGlR8UIdvS8BHJpV5wg7DjYF1oa4ezCzrj01RI6e9x/KQPJxTndWG3F2NtmCZdzrhaseDWc+nm613ocdqC9SepTPbKsYyCaomjBXshrt1r9GphvzPVyv0lBSp/VKlKRferwJPVxrYg27PzyZXC8PnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804982; c=relaxed/simple;
	bh=V7ZX2/8Mq+MlZ9CffB1z6/GN5PipnMSqqN18kHvQ73c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJtzZvyyE9rq/MYQZYZJ358ry6T2VS8nYjhxkLFp3Uk7SctwaoiLv9NJi4qWSBlsu1dBpIYkhARH/btdWDXDwwDPG3r9WeH2ZExFHJbYcWkL3cWZz2JltzdP1ocFRuICKss41qd1dql+/R2iJQR//YM40zuhP2mavWa/u4+pGgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Smw3AxCz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QiX2Xvn9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Smw3AxCz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QiX2Xvn9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Smw3AxCz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QiX2Xvn9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Smw3AxCz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QiX2Xvn9"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3D864D42C;
	Sun, 29 Mar 2026 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774804973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HgKOV+nTPb+Iul0ictQu29k4qvgUqfsdLf86i97Lsw=;
	b=Smw3AxCzvXx0nnqdqN5ilSGC0d7bBRTPHA2OrA+wI9V4jfRAYJNoZDKGnP/War89WHDaUp
	BMakXE2TTErI/pkerEjoWb5/siG7dPBpArueplmLZu+94NOqzAX7vetmZsgzRDyVLGniAs
	3bQqHZ039oRdEweXanaFOUCF3wZ7kHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774804973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HgKOV+nTPb+Iul0ictQu29k4qvgUqfsdLf86i97Lsw=;
	b=QiX2Xvn9imMKKUXk8YsQlMKUlXdJmKMU9r7MQfScU6mVlB/pXNwu0TgZQU6riR9BMC1G1b
	QUJaY0IpBkh5V8Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774804973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HgKOV+nTPb+Iul0ictQu29k4qvgUqfsdLf86i97Lsw=;
	b=Smw3AxCzvXx0nnqdqN5ilSGC0d7bBRTPHA2OrA+wI9V4jfRAYJNoZDKGnP/War89WHDaUp
	BMakXE2TTErI/pkerEjoWb5/siG7dPBpArueplmLZu+94NOqzAX7vetmZsgzRDyVLGniAs
	3bQqHZ039oRdEweXanaFOUCF3wZ7kHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774804973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HgKOV+nTPb+Iul0ictQu29k4qvgUqfsdLf86i97Lsw=;
	b=QiX2Xvn9imMKKUXk8YsQlMKUlXdJmKMU9r7MQfScU6mVlB/pXNwu0TgZQU6riR9BMC1G1b
	QUJaY0IpBkh5V8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22E504A0A2;
	Sun, 29 Mar 2026 17:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zqquBO1fyWkrbAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 29 Mar 2026 17:22:53 +0000
Message-ID: <d3935fd1-b990-405b-8428-219730d68a89@suse.de>
Date: Sun, 29 Mar 2026 19:22:48 +0200
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
 <856eb43a-d4d0-4e1e-895f-75fca4eec51d@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <856eb43a-d4d0-4e1e-895f-75fca4eec51d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,riseup.net:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 3/29/26 6:58 PM, Fernando Fernandez Mancera wrote:
> On 3/29/26 5:07 PM, Luka Gejak wrote:
>> On Wed Apr 9, 2025 at 12:19 PM CEST, Fernando Fernandez Mancera wrote:
>>> In order to work properly PRP requires slave1 and slave2 to share the
>>> same MAC address. To ease the configuration process on userspace tools,
>>> sync the slave2 MAC address with slave1. In addition, when deleting the
>>> port from the list, restore the original MAC address.
>>>
>>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>>> ---
>>> v3: restore the original MAC address on slave removal.
>>> ---
>>>   net/hsr/hsr_device.c | 5 +++++
>>>   net/hsr/hsr_main.c   | 9 +++++++++
>>>   net/hsr/hsr_main.h   | 1 +
>>>   net/hsr/hsr_slave.c  | 2 ++
>>>   4 files changed, 17 insertions(+)
>>>
>>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>>> index 439cfb7ad5d1..e8922e8d9398 100644
>>> --- a/net/hsr/hsr_device.c
>>> +++ b/net/hsr/hsr_device.c
>>> @@ -761,6 +761,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, 
>>> struct net_device *slave[2],
>>>       if (res)
>>>           goto err_unregister;
>>> +    if (protocol_version == PRP_V1) {
>>> +        eth_hw_addr_set(slave[1], slave[0]->dev_addr);
>>> +        call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
>>> +    }
>>> +
>>>       if (interlink) {
>>>           res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
>>>           if (res)
>>> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
>>> index d7ae32473c41..192893c3f2ec 100644
>>> --- a/net/hsr/hsr_main.c
>>> +++ b/net/hsr/hsr_main.c
>>> @@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block 
>>> *nb, unsigned long event,
>>>               eth_hw_addr_set(master->dev, dev->dev_addr);
>>>               call_netdevice_notifiers(NETDEV_CHANGEADDR,
>>>                            master->dev);
>>> +
>>> +            if (hsr->prot_version == PRP_V1) {
>>> +                port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
>>> +                if (port) {
>>> +                    eth_hw_addr_set(port->dev, dev->dev_addr);
>>> +                    call_netdevice_notifiers(NETDEV_CHANGEADDR,
>>> +                                 port->dev);
>>> +                }
>>> +            }
>>>           }
>>>           /* Make sure we recognize frames from ourselves in 
>>> hsr_rcv() */
>>> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
>>> index 1bc47b17a296..135ec5fce019 100644
>>> --- a/net/hsr/hsr_main.h
>>> +++ b/net/hsr/hsr_main.h
>>> @@ -155,6 +155,7 @@ struct hsr_port {
>>>       struct hsr_priv        *hsr;
>>>       enum hsr_port_type    type;
>>>       struct rcu_head        rcu;
>>> +    unsigned char        original_macaddress[ETH_ALEN];
>>>   };
>>>   struct hsr_frame_info;
>>> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
>>> index 2a802a5de2ac..b87b6a6fe070 100644
>>> --- a/net/hsr/hsr_slave.c
>>> +++ b/net/hsr/hsr_slave.c
>>> @@ -196,6 +196,7 @@ int hsr_add_port(struct hsr_priv *hsr, struct 
>>> net_device *dev,
>>>       port->hsr = hsr;
>>>       port->dev = dev;
>>>       port->type = type;
>>> +    ether_addr_copy(port->original_macaddress, dev->dev_addr);
>>>       if (type != HSR_PT_MASTER) {
>>>           res = hsr_portdev_setup(hsr, dev, port, extack);
>>> @@ -232,6 +233,7 @@ void hsr_del_port(struct hsr_port *port)
>>>           if (!port->hsr->fwd_offloaded)
>>>               dev_set_promiscuity(port->dev, -1);
>>>           netdev_upper_dev_unlink(port->dev, master->dev);
>>> +        eth_hw_addr_set(port->dev, port->original_macaddress);
>>>       }
>>>       kfree_rcu(port, rcu);
>>
>> Hi Fernando,
>>
>> Thanks for the patch. The logic to sync the slave2 MAC address with
>> slave1 for PRP is sound, but there are a few implementation issues here
>> that will cause hardware filtering problems and style violations.
>>
>> 1. Hardware MAC Filtering
>> In your current implementation:
>>
>>    if (protocol_version == PRP_V1) {
>>
>>        eth_hw_addr_set(slave[1], slave[0]->dev_addr);
>>
>>        call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
>>
>>    }
>>
>> eth_hw_addr_set() is appropriate for virtual devices (like the hsr_dev
>> itself), but slave[1] is a physical net_device. By using this helper,
>> you are bypassing dev->netdev_ops->ndo_set_mac_address. This means the
>> physical NIC's hardware MAC filter will not be programmed, and it will
>> silently drop unicast traffic destined for the new PRP MAC address
>> unless the interface happens to be in promiscuous mode. You should use
>> dev_set_mac_address() here instead. Note that unlike eth_hw_addr_set(),
>> dev_set_mac_address() can fail and returns an error code, so you will
>> need to check its return value and handle the error path accordingly.
>>
>> 2. Teardown Notifiers
>> In hsr_del_port():
>>
>>    netdev_upper_dev_unlink(port->dev, master->dev);
>>    eth_hw_addr_set(port->dev, port->original_macaddress);
>>
>> You have the same issue with eth_hw_addr_set() here. Additionally,
>> unlike the setup paths, this version omits call_netdevice_notifiers
>> (NETDEV_CHANGEADDR, port->dev). Switching to dev_set_mac_address() for
>> the restoration will handle both the hardware programming and the
>> notifier chain automatically.
>>
> 
> These points makes sense. I guess I didn't notice the that 
> eth_hw_addr_set() due to my interface being set to promiscuous mode at 
> hsr_slave.c.
> 
> Let me research a bit more about the impact here and will get back to 
> you either with a new patch or an reply here.
> 

Does this actually makes sense? I am not an expert on how hardware is 
handling offloading here. But if I am not wrong, as the interface is set 
on promiscuous or offload enabled. For promiscuous this does not matter 
and for the offloaded scenario shouldn't the decision be handled by 
hardware and not depend on ndo_set_mac_address()?

Let me know if I am missing something here.


Anyway, the missing notification makes sense and should be fixed for 
SLAVE_B.

Thanks,
Fernando.
