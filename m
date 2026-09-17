Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C23A6F1A
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633785; cv=none; b=TeE589x2Jn8uUQP0N7Tdnvv6/XvZqitQBENbKN59prgw4DHRIAjWZfb6lZzX0T9xrvSx8gA69y6xzm37ctRTKHLzsN3nw5K0oSMQx7EWN6AgmGR/7UBee0CtQqTEJElzRJ9jWKcR71GdkxV3Sn77RzCm+tHRDVGRmjLpv1Nc6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633785; c=relaxed/simple;
	bh=WWyYZw8tBywiBXwYte7KMgI+DaSqsyddNxnCJcZg7zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUNVIPAS7Z+N/J/Yo7X3rlB9RpgHrUBEPdEbXjm6FSISeHqwBqAXmuuMfTmIsFg6L5/KYJ93gK7Cqs9MCyq7tjJDUG2lZOujIqX/0kqSdg77uhVEiudwfXsQdStnyhOiYmWvWdrsUBfpkhJV8+nwhHZZfMh+kOm+OhFgLHuMNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWmJU3vt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWmJU3vt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789633772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hz4NjmNPVB7tW6852/se/FDTpEK9t+GLc4SzvAzUiv4=;
	b=YWmJU3vtcs2UCR9xde6qOVc4I0OTKK/fhdtjzXHI25FgSzybjzKRUZ2yolXz7rAhSq0qWY
	Srw9daKj64Em/Pivy+mK+lJSU0q4ZoG2s9tc9kZkC26YXFYe6+hllzy1/pd9OLZBaPGG2V
	DLbKVEa9Nf4FEn0Ugd8Rb+KoNOcsAto=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-4SqpmexYOYuOltyYrQyK9g-1; Thu,
 17 Sep 2026 04:29:27 -0400
X-MC-Unique: 4SqpmexYOYuOltyYrQyK9g-1
X-Mimecast-MFC-AGG-ID: 4SqpmexYOYuOltyYrQyK9g_1789633765
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21F65195E936;
	Thu, 17 Sep 2026 08:29:25 +0000 (UTC)
Received: from [100.90.87.156] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55B2830002C7;
	Thu, 17 Sep 2026 08:29:20 +0000 (UTC)
Message-ID: <c3cffd82-c57c-4cbf-b287-a73a3d078676@redhat.com>
Date: Thu, 17 Sep 2026 10:29:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: reject a reference sync pin which is not on the
 pin's dpll
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, milena.olech@intel.com,
 przemyslaw.kitszel@intel.com
References: <20260915213047.1352286-1-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260915213047.1352286-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 9/15/26 11:30 PM, Jakub Kicinski wrote:
> dpll_pin_ref_sync_state_set() resolves the partner's driver private data
> with dpll_pin_on_dpll_priv() and passes the result to ref_sync_get() and
> ref_sync_set() without looking at it. The helper returns NULL when the
> partner holds no ref on that dpll. Of the two drivers implementing the
> feature only zl3073x dereferences the pointer (sync_pin->id); ice ignores
> it, so ice cannot fault here.
> 
> The NULL is a teardown race, not a steady state - zl3073x registers every
> input pin with every channel, so the partner is normally present on the
> dpll the base pin resolves to. zl3073x_dev_stop() unregisters pins one at
> a time, taking and dropping dpll_lock for each, and between the partner's
> turn and the base pin's the partner is out of that dpll's pin_refs while
> still registered with the channels not yet torn down, so
> dpll_pin_available() keeps passing. That path is not only driver removal:
> devlink reload and devlink dev flash both run zl3073x_dev_stop().
> 
> Reproduced by holding that state open with a mock dpll device, which is
> where the frame name comes from:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   RIP: 0010:mock_ref_sync_get+0x5/0x30
>   Call Trace:
>    <TASK>
>    dpll_pin_ref_sync_set+0x19f/0x4a0
>    dpll_nl_pin_set_doit+0x17d/0x840
>    genl_family_rcv_msg_doit+0xd6/0x130
>    genl_rcv_msg+0x181/0x2b0
>    netlink_rcv_skb+0x55/0x100
>    genl_rcv+0x23/0x30
>    netlink_unicast+0x24d/0x370
>    netlink_sendmsg+0x1e2/0x420
>    __sys_sendto+0x1db/0x1f0
>    __x64_sys_sendto+0x1f/0x30
>    do_syscall_64+0xe1/0x490
> 
> Commit d2e914a4a0d0 ("dpll: fix NULL pointer dereference in
> dpll_msg_add_pin_ref_sync()") added the same guard to the read side, which
> the kernel walks into by itself because the delete notification is emitted
> from inside the unregister; the write side needs a pin-set to land in the
> window and was left alone. Test the priv rather than look up pin_refs
> directly, so that the two halves key off the same condition.
> 
> Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: vadim.fedorenko@linux.dev
> CC: arkadiusz.kubalewski@intel.com
> CC: jiri@resnulli.us
> CC: ivecera@redhat.com
> CC: milena.olech@intel.com
> CC: przemyslaw.kitszel@intel.com

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

