Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E3217F27
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359248; cv=none; b=gFUmdLMrAGlnWMp14wUTcH5oh/eXeMKKH5Z1tMzrY1sDcseY/94DSSs1dwDuRRvyJU5A/1wq4eqe9pe6COLie6eC/0+Cdts8ryWh5c5Go1yVjWjbUlvjzia/o2t+sqYcz4en/cxno5d6ZiQR32rdfjq6erJVM0fjspXfuAa11is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359248; c=relaxed/simple;
	bh=5Xw4JpG1wykNI1fyQTY60QszeGiP5MJS+/SC04VtmOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/l9HzAI7xkP2njuPBo0hG/y69Gbc8MhEfb4DyOZVMmb7Oxk3V9MDBOvRxwvFmt40uX9dC8/4mqt9osAx7JksOoTkPxhD0tLpKG7yzCGIaZPd0b89bpEci/Lt5vokiBqmYEF85Lls4gQCRLkWoKlwmvXfBpxoc2JvgUw6lYr0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzFlirOP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzFlirOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790359244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbH1oqm2JYfGo4vHv2a7EHlBz4Y88JmO+sGf3J2DVP4=;
	b=RzFlirOPowRrhGIPDxzpKg+OgvO9QzQ/vrYAqK2t9fktWmSWn7iIF8pF9uuw7nh2D12uKW
	y8MzL0WEk9hy41a2vhrHhkWVfAaaylqSZwFzh0qthm7VRwZEgcxMTkRkObNmIyeeVAtGKV
	wujvD1DSDD5YLAQhpWqEM7G7+q0Na44=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-Cdn0JRo-PJW-WCuyo7QdEQ-1; Fri,
 25 Sep 2026 14:00:40 -0400
X-MC-Unique: Cdn0JRo-PJW-WCuyo7QdEQ-1
X-Mimecast-MFC-AGG-ID: Cdn0JRo-PJW-WCuyo7QdEQ_1790359238
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CC3B1834594;
	Fri, 25 Sep 2026 18:00:38 +0000 (UTC)
Received: from [100.90.87.156] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30460426;
	Fri, 25 Sep 2026 18:00:34 +0000 (UTC)
Message-ID: <c8628f3c-03d6-47df-8f37-3dda11123460@redhat.com>
Date: Fri, 25 Sep 2026 20:00:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] netlink: specs: dpll: drop the reference to
 DPLL_MODE_DETACHED
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, donald.hunter@gmail.com
References: <20260924231211.568213-1-kuba@kernel.org>
 <20260924231211.568213-4-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260924231211.568213-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 9/25/26 1:12 AM, Jakub Kicinski wrote:
> The lock-status doc tells userspace that DPLL_LOCK_STATUS_UNLOCKED
> can be forced by setting DPLL_A_MODE to DPLL_MODE_DETACHED.
> But no such value has been defined so far. enum dpll_mode has only
> MANUAL and AUTOMATIC. Let's make sure the doc reflects current
> reality.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   Documentation/netlink/specs/dpll.yaml | 3 +--
>   include/uapi/linux/dpll.h             | 3 +--
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index 7009a64473b1..8fa789a50273 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -31,8 +31,7 @@ doc: DPLL subsystem.
>         -
>           name: unlocked
>           doc: |
> -          dpll was not yet locked to any valid input (or forced by setting
> -          DPLL_A_MODE to DPLL_MODE_DETACHED)
> +          dpll was not yet locked to any valid input
>           value: 1
>         -
>           name: locked
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index 85b898b1db5e..8c71fc3f9863 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -29,8 +29,7 @@ enum dpll_mode {
>   /**
>    * enum dpll_lock_status - provides information of dpll device lock status,
>    *   valid values for DPLL_A_LOCK_STATUS attribute
> - * @DPLL_LOCK_STATUS_UNLOCKED: dpll was not yet locked to any valid input (or
> - *   forced by setting DPLL_A_MODE to DPLL_MODE_DETACHED)
> + * @DPLL_LOCK_STATUS_UNLOCKED: dpll was not yet locked to any valid input
>    * @DPLL_LOCK_STATUS_LOCKED: dpll is locked to a valid signal, but no holdover
>    *   available
>    * @DPLL_LOCK_STATUS_LOCKED_HO_ACQ: dpll is locked and holdover acquired

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

