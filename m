Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F628003A
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014497; cv=none; b=cK3gQDYk3nAm+9J3/Z6I8bGRF803jFkuC6KSQql50lBUoSr2ZJ6bPov627+LsM9J70m8haqgammrxo7pexHjm6qQAnylO9pv0hLaZtY+2xLiNlYKF6FjVS5YTou+lC90R8g/LTClZ7y4L4zdrgPaVifc5TXZVl4VbsnR2Gq7YI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014497; c=relaxed/simple;
	bh=Y+OW8BqNNnK+Q/r4MYs96W4Y+zUCtX/kEEnNFoydBrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni3gV7kpkG3nvmN0aJV5R9e4uKrMjuGY2cTVKg4PKsGCsOXBEgXPGtA8TUCmIvdm1N9hLBwYeN28q8hju7rHXps1ail0paNhkC779d7Ih/iPT9DYzCr6+qhuPk6mewt9ZX6LqtJqkRBOir6yP4q0HwfEwxGY/O1ZNoPU3bZR10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPErfDfk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPErfDfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774014494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gO6QpMrOamrnkGecVbcYEcearzCJhtrpfGqA4fBYchI=;
	b=LPErfDfkW80ZAm07IRn0EEhF5tUtRTIKypwDL3AcUKe/U0ItkTqHfEmnYaJOE7YuMq7Hkk
	StR6i3REk+YZSos+141exaLYfBspAuLmDYVAygRr+mlqna2G4UFxv5BcWwrGp510Qf57fu
	F0dQe4hhqktFMrNn1D/EWWke0ocySkE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-eiFmF5t8NHuTtDRH4C7lVA-1; Fri,
 20 Mar 2026 09:48:10 -0400
X-MC-Unique: eiFmF5t8NHuTtDRH4C7lVA-1
X-Mimecast-MFC-AGG-ID: eiFmF5t8NHuTtDRH4C7lVA_1774014489
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1468118005B7;
	Fri, 20 Mar 2026 13:48:06 +0000 (UTC)
Received: from [10.45.226.118] (unknown [10.45.226.118])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F6B9180075B;
	Fri, 20 Mar 2026 13:48:03 +0000 (UTC)
Message-ID: <7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
Date: Fri, 20 Mar 2026 14:48:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
To: Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260320105915.149068-1-ivecera@redhat.com>
 <20260320105915.149068-4-ivecera@redhat.com>
 <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 3/20/26 1:21 PM, Guenter Roeck wrote:
> On 3/20/26 03:59, Ivan Vecera wrote:
>> Expose measured input reference frequencies via the hwmon interface
>> using custom sysfs attributes (freqN_input and freqN_label) since
>> hwmon has no native frequency sensor type. The frequency values are
>> read from the cached measurements updated by the periodic work thread.
>>
>> Cache the device ready state in struct zl3073x_dev so that
>> freq_input_show() can return -ENODATA without an I2C access when
>> the device firmware is not configured.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> "frequency" is not a hardware monitoring attribute. I understand that it is
> convenient to report it as one, and that other drivers implement it as 
> well,
> but that doesn't change that.
> 
> I understand that the code lives outside the hardware monitoring 
> subsystem and is
> thus not in control of its maintainers, so you can essentially do 
> whatever you want,
> even if it is wrong. That doesn't change the fact that it is wrong.
> 
> However, do _not_ try to add it into the official list of hardware 
> monitoring
> attributes. I would NACK that.
> 
> Guenter

Hi Guenter,

Understood. I recognize that frequency falls outside the strict scope of
hardware monitoring and does not belong in the official hwmon ABI.

I'm using it here as a convenient way to expose these specific driver
metrics, but I hear you loud and clear. I will absolutely not propose
adding frequency to the official list of hwmon attributes or
documentation.

Thank you for your time and for reviewing the patch.

Regards,
Ivan

