Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394527;
	b=pugrMe4YNfFG1/NXmWqtohBnqv9o4dZ+J5DOu9D1eOtL/WhY6uydqDW/joehYRRYU5wX
	 Za2ALKVIkUyq8hLbADTNUQGGW+MlOq5g8bad4I759lQkzXMxP0DPenr2yOXeSHWexztJI
	 2Z49Kj1NLe+ealgQSqvY+PFGjnelqth8LJNNO6UOQqaBXOxuswKojyGUGQKkQCGVHV4wy
	 lwW00E/rB3hwObwjBRlpkGVRs0EQEtaz1CkxcnFsb4gxvds9HiWw9yjfzu/7v7vhyuAjE
	 x/I88ojkl/OBTkZvmpZVVai3Qs9P+Fq1GaJ9e8MGeVJgi6uNEqhNMws4fgaI+ddJpng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394527;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=SF2NQhuQxu5m0bI5v5rpx1rhcNXkOJ4L4wUCi27ileQ=;
	b=aOvWa7fxKTyMLLvpVWGzK1m/5iqwlrZHpeuwKV1WZo5+riAZ9FsGCkrH8+gFFRr9W7Po
	 zZT4ddaV2tmzj6ym96Eom+Le7DcSztl+HDB5XIsJG09mez5KGjasBsFhV1VyQoDd5EiAT
	 miENugyTJZFAk9Ge2pMQlRpYQjYhiu1gDMRtA1tXIJSMYgdM1ZzrJ9gmnu2Yp4/WPzKgA
	 poaMqgnMxjWGTkOgk+LsPPpJY+KcJpMXc+ovVYNefXnZdax/hv+bKUoDM3qLk58WV33gJ
	 tpuLhVDLHEbH0+GBfYViJuCAsVFxS+gG+2nn0Gxo+IgAKTwg+H6RwfbbUkZuV7zD/Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7c28ZRA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F1606A334
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B08F1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7c28ZRA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794394525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF2NQhuQxu5m0bI5v5rpx1rhcNXkOJ4L4wUCi27ileQ=;
	b=e7c28ZRAT8ymtGjwBPQPIQt0wJ9p57/GNR7jsfIGv+g7BNDBhXrN7juVuvt3uxGVR378O/
	Erb7FwKw+x7cYjIyWAPuODTXH32YHy/ovX4vyfvqptwzjk33zDRkZdXnJNY7A6wfJibrth
	rIc0AUP50DW5kUVqM2NcuxtQEtq57eQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-Oqo0X7NTPyKcaINytLDz9g-1; Wed,
 11 Nov 2026 05:55:20 -0500
X-MC-Unique: Oqo0X7NTPyKcaINytLDz9g-1
X-Mimecast-MFC-AGG-ID: Oqo0X7NTPyKcaINytLDz9g_1794394517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EAC619775DB;
	Wed, 11 Nov 2026 10:55:17 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 523A518004FF;
	Wed, 11 Nov 2026 10:55:10 +0000 (UTC)
Message-ID: <fe93c3de-e478-4bdf-877a-d3c5d345dd04@redhat.com>
Date: Wed, 11 Nov 2026 11:55:09 +0100
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
Subject: Re: [PATCH net-next 01/10] ice: dpll: notify TSPLL lock status from
 the periodic work only
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
References: <20261106121005.1327603-2-ivecera@redhat.com>
 <179433319925.994134.5092477928749468374@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433319925.994134.5092477928749468374@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] This patch leaves the comments in
>    ice_dpll_tspll_state_on_dpll_set()…
> 
> --
> 
> ice: dpll: notify TSPLL lock status from the periodic work only
> 
> This patch stops ice_dpll_tspll_state_on_dpll_set() from sending a TSPLL
> device change notification from the TIME_REF pin callback. The callback
> now only updates dpll_state. ice_dpll_periodic_work_e825() refreshes
> dpll_state on every run and sends the notification when the state differs
> from prev_dpll_state.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
>> index ade1fb3dd0674..bdbcf7af296eb 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> 
> [ ... ]
> 
>> @@ -2947,15 +2946,12 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>>   		WRITE_ONCE(pf->ptp.tspll_locked,
>>   			   new_state == DPLL_LOCK_STATUS_LOCKED);
>>   
>> -		if (tp->prev_dpll_state != new_state) {
>> -			tp->dpll_state = new_state;
>> -			tp->prev_dpll_state = new_state;
>> -			changed = true;
>> -		}
>> +		/* ice_dpll_periodic_work_e825() compares the state with
>> +		 * prev_dpll_state and sends the notification.
>> +		 */
>> +		tp->dpll_state = new_state;
> 
> [Severity: Low]
> This isn't a bug, but do the comments in ice_dpll_tspll_state_on_dpll_set()
> still match how the notification path works after this change?

[...]

> Could both comments say that the periodic work picks up the new state
> through pf->ptp.tspll_locked? Then a later change is less likely to drop
> the WRITE_ONCE() as just a way to avoid spurious notifications.
Right, the first comment still gives the reason from before this patch.
Now the write of pf->ptp.tspll_locked is what brings the new state to
ice_dpll_periodic_work_e825(). v2 will merge both comments into one that
says so.

Thanks,
Ivan

