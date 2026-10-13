Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8F14718FF
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884642; cv=none; b=gpBj/t70bSSP4jDwD3E5eaHzl4uP0NEkCiDD/NV6orosle3w1Jgd9jLZfPnz98W4YFaXnaCBq/MAULPYqw6mXEVRNyS/JUHReStoM+KtAHLFEgkTLteOD1FFSBSNIho2ETU7J8yOoEaWUPXeoi7BcVe4X5LpgZfyYEI5RN49CnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884642; c=relaxed/simple;
	bh=megV711P3ZBKFFEbDOD59/fypEHRtoKAwJFtOspSGBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8yYfg0Du//wH0oR8JtmEfNUCw+m70+VNHf0YYr3IPNdI5Q+ghc8NcgM6UeX7cpMKkqpenL/3M0TD/9HaoPAYdiRDL0MQxr5B5WNAvxO0Nk/KzEXaQ1zvL7UwQZMeZWF8qrn+VvhPElCSkj9R1tI/VtfL4905Titb0ju3s0bsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USWE/7S1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USWE/7S1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791884638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTfhRUiKt73k975RZbk3Fp/cv7PEgh/2KD1HG5cwm9o=;
	b=USWE/7S1Z6FvfuZeNDrN0sH0vD+kEtTApX6IqdK9SRIWDTNzzYnvZIEEJit3noe8GaoXLb
	F6VCRSJj6la0GHWrUEFKk0d1dLCNGw60SAY0ZD+9PhlulbPUyPWvextWq6WfwzNGeUaXFb
	Prz0BkUXiaUoz/HCrqnH+duHP0U8lcY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-9eTuBplINxmVl3SDUR16LQ-1; Tue,
 13 Oct 2026 09:43:57 +0000
X-MC-Unique: 9eTuBplINxmVl3SDUR16LQ-1
X-Mimecast-MFC-AGG-ID: 9eTuBplINxmVl3SDUR16LQ_1791884635
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 604BC1955DAB;
	Tue, 13 Oct 2026 09:43:55 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D8B9195608B;
	Tue, 13 Oct 2026 09:43:52 +0000 (UTC)
Message-ID: <14809cb9-8147-415a-8b7c-ec6ab3b488d2@redhat.com>
Date: Tue, 13 Oct 2026 11:43:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/12] dpll: sit9531x: add support to get and
 set priority on input pins
To: Ali Rouhi <arouhi@sitime.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-8-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-8-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> When the device has to choose a reference, it takes the first slot of
> its priority table that has signal.  The driver keeps a
> priority per input and PLL and builds the table from it (previous
> patch), so getting a priority reads that value without touching a
> register, and setting one records it and, for an input the PLL lists,
> rewrites the table in the new order.  When the new order puts a
> different input with signal first, the PLL moves to it; a change further
> down the table leaves the PLL where it is.
> 
> Priority and state are separate attributes, and neither moves the other.
> A priority can be set on a disconnected input and takes effect when it is
> connected; disconnecting an input and connecting it again brings back the
> priority it had.  Setting one input's priority leaves every other input's
> as it was, so the named pin is the only one whose priority changes and
> the core's own notification covers that; when the new order moves the
> active selection, the siblings' operational state follows on the next
> poll.  A priority the table write refused is not kept: the configured
> value goes back to what it was, so nothing reports a priority the
> device never took.  The range is 0 to 255 against a table of eleven slots:
> inputs of equal priority keep the order the table already has them in,
> so distinct values are what fix an order.  An input the PLL has never
> listed reports the lowest slot, the priority it would be connected at.
> 
> A table rewritten behind the driver -- a profile reload, a direct I2C
> tool -- is taken as the new configuration and the priorities are
> re-seeded from it, so the poll now watches priority and operational state
> as well as state, and notifies a pin when any of them moves.  The
> notifications go out after the walk over the pins, outside multiop_lock,
> since the helper takes locks the callbacks run under.
> 
> A pin's baseline for that watch -- state, operational state and priority
> -- is taken when the pin is registered, under the device lock, rather
> than by the first tick, so a change between the probe-time fetch and
> that tick is reported instead of absorbed into the baseline.  The device
> lock status is seeded the same way, so the first tick announces only
> what moved since registration.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
Reviewed-by: Ivan Vecera <ivecera@redhat.com>

