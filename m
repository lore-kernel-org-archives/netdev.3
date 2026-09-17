Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42174B8277
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638160; cv=none; b=bYJRS5JAbHGwLuOzVx9hQZB8+no4y5XGt0Mfdr5qk95vh9YinwuktKM/7U5yFaszGbHJmV7dkhJxz4cpriqVofTMLXO3WHVHKV33Gr+ud3ct7xm6gMLwgxgfSRgND84Mf6H4r0ge9t32NjCY+/3RaywDgMieS9k4bRI3YLWiz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638160; c=relaxed/simple;
	bh=j5NDkE8H5QhohnuQG9ZL2eFqc/5c+L62c3fdFiXdfcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRZSU5glDZiYV2+A3hfTgIxrUDHHMgLFiqkPuy9BjpRFUsE0k/gq9aQ70Ridwb2sm3YmYdt1cY2pNK1gbLI5xTvBvhaSfmpus3aYBLoRUfQF/BRlebRljKnx3xiEXrEK1syY0Ee2eXSaiarUCvPSVj9HIgwNk+KNSwpJvwPWlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ik7XRp1I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik7XRp1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789638141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g0ZCGxDRRYlZhr9Tvt33jde/X2SUHy/4zlgcs+jS0w=;
	b=Ik7XRp1IBkHEwC6z9cbUOsMbjN2ql7wO51oWOksJaEcklGMibqCNOac10qG6BXyvkHGB0W
	995GOtcANAGuaFSIm6RbQuoeDNAXNvDURhfvFuqnPnaK7V++NwSzkQJgBJVJQb0pQe5uMv
	0un6iM4MFId6XdI2/E/7rOu0izlzNS0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-WcsIYYDkP9OlvubnoJsHOQ-1; Thu,
 17 Sep 2026 05:42:15 -0400
X-MC-Unique: WcsIYYDkP9OlvubnoJsHOQ-1
X-Mimecast-MFC-AGG-ID: WcsIYYDkP9OlvubnoJsHOQ_1789638134
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 590C41802565;
	Thu, 17 Sep 2026 09:42:13 +0000 (UTC)
Received: from [100.90.87.156] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D88B5754;
	Thu, 17 Sep 2026 09:42:09 +0000 (UTC)
Message-ID: <5757ed06-a14c-4dc5-ada8-3a76129e2d5c@redhat.com>
Date: Thu, 17 Sep 2026 11:42:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 04/15] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
To: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Cc: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cjubran@nvidia.com" <cjubran@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260915000015.80480-1-arouhi@sitime.com>
 <20260915000015.80480-5-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260915000015.80480-5-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95



On 9/15/26 2:00 AM, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> The DPLL core wants a type per device and a property set per pin: a
> label, the direction, the capabilities, and the frequencies the pin
> supports.  None of that can be read from the chip -- which frequencies a
> board actually presents on a given input, and whether an output's
> embedded sync is wired to be controllable, are board facts -- so they
> come from the firmware node, with defaults for a node that does not
> describe them.
> 
> Input pins are interleaved P and N lanes of four differential pairs, so a
> logical index maps to a pair and a lane, and a pair configured
> single-ended presents two independent inputs where a differential one
> presents one.  The labels follow from that, and the two extra input
> positions -- the crystal and the inter-PLL sync net -- are named
> separately.
> 
> Kept in its own file, and introduced before anything is registered, so
> the registration code that follows has nothing to say about firmware.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: Claude:claude-4-opus [chat]
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   drivers/dpll/sit9531x/Makefile |   2 +-
>   drivers/dpll/sit9531x/core.h   |  72 ++++++
>   drivers/dpll/sit9531x/prop.c   | 437 +++++++++++++++++++++++++++++++++
>   drivers/dpll/sit9531x/prop.h   |  39 +++
>   4 files changed, 549 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/dpll/sit9531x/prop.c
>   create mode 100644 drivers/dpll/sit9531x/prop.h
> 
> ...
> +
> +               /*
> +                * Allow phase-adjust over a +/-1 ms window.  The subsystem
> +                * rejects pin_set(phase-adjust, X) when X falls outside
> +                * [min, max], so leaving these at 0 silently blocks every
> +                * netlink call.  1 ms is well beyond the DCO dynamic range
> +                * but costs nothing.  Only outputs get a range: input pins
> +                * have no .phase_adjust_set, and advertising one there would
> +                * promise userspace something every set would refuse.
> +                */
> +               props->dpll_props.phase_range.min = -1000000000; /* -1 ms in ps */
> +               props->dpll_props.phase_range.max =  1000000000; /* +1 ms in ps */
> +               /*
> +                * The fine step is 30 ps, but requests are accepted at 1 ps
> +                * resolution and rounded to the nearest achievable delay, so
> +                * advertise the request granularity, not the hardware step.
> +                */
> +               props->dpll_props.phase_gran = 1;

What is the real HW granularity? If 30ps then you should announce 30 to
inform the userspace that this is the step supported by the HW.

Thanks,
Ivan

