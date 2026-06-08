Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AE3B7B84
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932662; cv=none; b=SEWCO8QAJybMyr28JwNuz+yGEnPIb8fXhvhed6LLC/09Gb8cVB/v9Z8//kicDmWDYbAKBc5HCHoAAXknZMNC11SjPPLIs1kyLoRkI36MiA2qZ/Vtg/8keaHDSPRhDv4S2ZCZcmehrr/MAFTybhkuZQyb0eD5BNGVQZOI9IdCUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932662; c=relaxed/simple;
	bh=Fok3oS58S3q2S2O6xTGCuSohF3vJ409DDVu2ALxXNV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8OPz6IbMEpm4jOL4KBzrrZEBFy1UMDKLrxY4MhVcyrArGOwnWH2ZL9rvy1eZEEsIZsVOxwcxBevNRXUIbH3j3DCztzKBfnI1e+tRTf0HHZbXJ6AGGHeOo0KpFsoUp5JDU9mAE4ASS7BAoB6xAzE+ZE7PydJk8x78JMwSz+/FiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gu7o+7rv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gu7o+7rv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780932660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcodL7KSoGxjM/ujgFAL6enmH7TYnMsYVwkzK3fM2W8=;
	b=Gu7o+7rvyaYgmahwu5Rb9cJCrSDEmgBdziHNK+NdzbBtF6Fi4xWSgifC66bDS2qajYJoF+
	X9n1XRbgxaaYb90mdn1x9UKLhmjTMTX98Ta++9klbsbOL7+Ol5n2MPuo6zy2pEywfSaAex
	bdKWB895qKG7rFbV9hRbM6HmJx7BRr0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-FgP9TVr1PgCaByYlTle2PA-1; Mon,
 08 Jun 2026 11:30:49 -0400
X-MC-Unique: FgP9TVr1PgCaByYlTle2PA-1
X-Mimecast-MFC-AGG-ID: FgP9TVr1PgCaByYlTle2PA_1780932646
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31889180266C;
	Mon,  8 Jun 2026 15:30:44 +0000 (UTC)
Received: from [10.44.32.246] (unknown [10.44.32.246])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D21E418005B3;
	Mon,  8 Jun 2026 15:30:39 +0000 (UTC)
Message-ID: <9b493ce2-6213-4a29-aeee-b473b6b16fa1@redhat.com>
Date: Mon, 8 Jun 2026 17:30:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <20260603185037.05f8c6a0@kernel.org>
 <be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
 <20260604081649.1ae5302d@kernel.org>
 <3c5e01f5-8563-41a3-964f-13fcb80383b7@redhat.com>
 <d6b69d21-4542-498d-8253-7009a56634cc@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <d6b69d21-4542-498d-8253-7009a56634cc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 6/8/26 1:33 PM, Vadim Fedorenko wrote:
> On 04/06/2026 17:42, Ivan Vecera wrote:
>> On 6/4/26 5:16 PM, Jakub Kicinski wrote:
>>> On Thu, 4 Jun 2026 17:01:36 +0200 Ivan Vecera wrote:
>>>>> Purely going on intuition here but feels like NCO should be a mode
>>>>> (enum dpll_mode) rather than one of the input pins?
>>>>>
>>>>> More acks here would be great, Vadim, Arkadiusz, Grzegorz... ?
>>>>
>>>> I had a long discussion with Jiri about this and we agreed finally
>>>> that dpll_mode represents a reference (input pin) selection strategy
>>>> mode and not a DPLL device running mode.
>>>
>>> Long discussion? I see 2 emails ;) Let's hear from others.
>>> (thanks for the link BTW, _if_ there's a v6 please put it in the cover
>>> letter)
>>
>> I called him... he explained me 'why?' in detail.
>> I also appreciate others' opinion.
> 
> Well, NCO mode means manual operation of frequency tuning. Does it mean
> that different tunings may be applied to different out pins of DPLL
> device? My assumption that it's not possible, and in this case NCO is
> property/mode of DPLL device rather than single pin.

The NCO pin is only one per device... When it is connected, then the
device the pin is connected to is switched to NCO mode. In this mode
the device is not locked to any input reference and the driver allows
tuning of the DPLL frequency manually via PTP interface.

Such tuning is applied only to output pins associated with this device
but not on others.

Examples:
DPLL0 is driving output 0-3 and DPLL1 is driving output 4-7.
Then if you switch the DPLL0 to NCO mode (makes NCO pin connected to it)
then frequency tuning (via PTP) has only influence on output 0-3 (the
same tuning is applied). Outputs 4-7 are not touched as they are driven
by DPLL1 (that can be locked to some input reference).

If you switch both DPLLs to NCO, then frequency tuning for DPLL0 affects
output 0-3 and tuning for DPLL1 output 4-7.

Thanks,
Ivan

