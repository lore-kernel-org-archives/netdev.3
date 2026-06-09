Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEF383C6E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017144; cv=none; b=uDIUhAPPtazySqnrqHzzF+GR+ykYwVySQFhsUloAy9KgDu1tzTvvGeNcxau+2uyCrgy96DoclcOwe4ZmyU/uxwV7EakAyXy5xw8jEWxe0p6WE5rMgYB4OLhC0frewymMSoXJpqF3Q0MNO6dovfqNgYXvp7ec4kjBcffXy2va024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017144; c=relaxed/simple;
	bh=cMT9LC19vPuV86F4Qp2FvF88/ufZ9va/QADtdSw8aYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFZJeqRoFSGUd+4OVUAIuy8pazcDofqd6FKPCt5clyaIHV1uwG2CNkx9hAayB0xGQpNEbKov1u/ETyM8sJFGSZXhPjhFO8kp51cQhYPpLH4N14OrReTmxuGxiT9bg02iXe68UZHpm6Qh6mLOpz62WKWSyEi1Rat3Agss9i5kfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+yBEgVg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+yBEgVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781017140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OAvp4c0/m2NArQ5FisMbwXTexlBy9jZdB2Hd9gIJik=;
	b=b+yBEgVgtuoLRrPpFYkANKIXKrx8aEFIX8rf1Fck0bfneUs+aglKw8J4g8J3Ugj3Q1+h6F
	yIauAVKr8dzQnOiXoNCFmtohUR0o1ZgO4A1+5ND1aRQPnPptioVCIXSjLLlu2Oxpqwq8B1
	jixOGlSKdAQCUXnkiDzNQ88Vwn+cmRk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-eegLj0yoPROChFpBu06HYA-1; Tue,
 09 Jun 2026 10:58:55 -0400
X-MC-Unique: eegLj0yoPROChFpBu06HYA-1
X-Mimecast-MFC-AGG-ID: eegLj0yoPROChFpBu06HYA_1781017133
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AA7B1806D38;
	Tue,  9 Jun 2026 14:58:53 +0000 (UTC)
Received: from [10.44.34.233] (unknown [10.44.34.233])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC7931800583;
	Tue,  9 Jun 2026 14:58:48 +0000 (UTC)
Message-ID: <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
Date: Tue, 9 Jun 2026 16:58:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Schmidt, Michal" <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, "Vaananen, Pasi" <pvaanane@redhat.com>,
 "Oros, Petr" <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
 <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <aifTFMZtWBgLzhCS@FV6GYCPJ69>
 <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 6/9/26 4:00 PM, Kubalewski, Arkadiusz wrote:
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, June 9, 2026 10:51 AM
>>
>> Mon, Jun 08, 2026 at 07:03:46PM +0200, arkadiusz.kubalewski@intel.com
>> wrote:
>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>> Sent: Monday, June 8, 2026 5:48 PM
>>>>
>>>> On 6/8/26 4:43 PM, Kubalewski, Arkadiusz wrote:
>>>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>>>> Sent: Sunday, May 31, 2026 9:44 PM
>>>>>> ...
>>>>>>         -
>>>>>>           name: gnss
>>>>>>           doc: GNSS recovered clock
>>>>>> +      -
>>>>>> +        name: int-nco
>>>>>> +        doc: |
>>>>>> +          Device internal numerically controlled oscillator.
>>>>>> +          When connected as a DPLL input, the DPLL enters NCO mode
>>>>>> +          where the output frequency is adjusted by the host via
>>>>>> +          the PTP clock interface.
>>>>>
>>>>> Hi Ivan!
>>>>>
>>>>> How would you control this in case of automatic mode dpll?
>>>>> Automatic mode DPLL shall be controlled on HW level, such pin brakes
>>>>> that rule and requires some driver magic to show it is higher
>>>>> priority then the rest of the pins?
>>>>
>>>> The NCO pin can be connected only in manual mode. In other words a DPLL
>>>> in automatic mode cannot select NCO pin (switch to NCO mode) by its own.
>>>>
>>>
>>> Being picky on DPLL_MODE for enabling feature is not something we can
>>> allow if it is not related to HW limitation, is it?
>>> Could you please elaborate why it is not possible for AUTOMATIC mode?
>>
>> In automatic mode, the pin selection logic is defined upon prio. I can
>> imagine that if NCO pin has the highest prio of the available ones,
>> it gets picked. I would be aligned 100% with automatic mode behaviour.
>> Is there a real usecase for it?
>>
>> [..]
> 
> This is not true. AUTOMATIC mode is HW solution, SW driver ONLY
> configures priorities on the inputs, not manages the active inputs.
> This brakes that behavior, the SW driver would have to manually
> override the AUTMATIC mode to be fed from such NCO pin as it doesn't
> exists on it's priority list, HW cannot pick or use it.

Correct, AUTO mode is hardware feature and it should not be emulated
by a driver. If the hardware does not support it then the switching
between input references should be done by userspace (by monitoring
ffo, phase_offset, operstate).

> The real use case is that any DPLL can switch the mode to this one
> instead of implementing MANUAL mode just to use the feature with a
> 'virtual' pin.

I don't expect this... but it is up to a driver. I don't plan such
functionality in zl3073x as the NCO pin does not expose prio_get() and
prio_set() callbacks - so it is clear that this pin cannot be part of
the automatic selection.

Ivan

