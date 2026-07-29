Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798D4DD6DA
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349725; cv=none; b=IB0DZQ8NW8Z0ZPmxmIypAJ9u0HoE+Zc+3+jv1GbBcJJCoSnXm2FlPbJtsXI9AI45gIDOndcS+pSk49zXOPn8axHOKk6w2eJJhcUj8ZKOojC335PDbiU7cbWXV5IjbXA0wtGZf36CAgmWAv3KNFOBAfQ4u3gazW5dIYP4hOdbP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349725; c=relaxed/simple;
	bh=foBo+YJh3MhGPWL9vxVo6MkwqztESUwP3GlfOzoAyDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZqakVTbbPRZAM+yIL0QuYWT9EBvX0/Xp/s9dSVHNGVtkTswt/aeLCYIAie9gjopEqtEPGKQMwzQSUrjiQ/4y4vbHfw0L1kWQE5IyJNhDR+J1m495B0VySBwP8v0qmE+6xngG5SZKeRfF5H5cw7l4/moGSyQ/P3Dt0KDi/SVlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLBQrv7W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLBQrv7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785349718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1Vp5QwB/QrkRrqsVLV+UITq326wO62uySa6jTTOzmE=;
	b=cLBQrv7WU2m3V6RG+dvKX3JCUBIHTq/5d+2KPDHvJwUp9eTtDETjKe7MK+My3Nyq+kh9DD
	0jCrFcpBqIc3CyDGegLtm2P5KyGQurqTSL+w7FoXqXSnClWXRA2lsYUg5/jhOTf+bBUqrr
	5KkoKxmnc+3DPY8WEpE5Ag389jRfLag=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-zGWPBVhnPSO0p0v0LE--xA-1; Wed,
 29 Jul 2026 14:28:35 -0400
X-MC-Unique: zGWPBVhnPSO0p0v0LE--xA-1
X-Mimecast-MFC-AGG-ID: zGWPBVhnPSO0p0v0LE--xA_1785349713
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0A2919560A6;
	Wed, 29 Jul 2026 18:28:32 +0000 (UTC)
Received: from [10.44.48.170] (unknown [10.44.48.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4D66180044F;
	Wed, 29 Jul 2026 18:28:28 +0000 (UTC)
Message-ID: <25735b90-cd3c-4eea-a399-eb8fd591475d@redhat.com>
Date: Wed, 29 Jul 2026 20:28:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] dpll: zl3073x: add PTP clock support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260713103739.1553284-1-ivecera@redhat.com>
 <20260713103739.1553284-3-ivecera@redhat.com>
 <20260722135848.2d401ada@kernel.org>
 <B047A851-87E8-4156-97CB-117A71CDBCD8@redhat.com>
 <20260727125921.2e16bed9@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260727125921.2e16bed9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 7/27/26 9:59 PM, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 10:33:35 +0200 Ivan Vecera wrote:
>>> Real dependency is probably better here?
>>> The Optional is meant for NICs for which PTP truly is a side-feature.
>>
>> There are some chip variants that don't support PTP. Should we depend non-optionally?
> 
> That's what I would do.

OK, will use PTP_1588_CLOCK in v3. The non-PTP variants will simply not 
register a PTP clock.

Ivan

