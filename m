Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D872BE05E
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821097; cv=none; b=b9zAfGHoo6QwOYLx40FO722p8dgIAdjz99m+Qlc1PbuHirK4uPP0rrj5GseoqxOXl2QFxvNVVkd67PUCFFJc8QOvinh9hYVesdvOzmgM9iMXZNahiy+STK7rPMXIJN6T7GICPKM3EcnAVinKiQN/qej6VpNNOqG0S0NZQtHlmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821097; c=relaxed/simple;
	bh=3KB6BPj2pZKILGJ0G7T+UPTzOpI37lurqaGIEDM2598=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoL5QKmjg0Hrqv9q1w/t9E3WiF5IfdNZXhFP3kVT4IXX9Veqvux0T8WanHPyJn94t0y5iHQkFoNkzY9317lAomyQalVFKO/CxhW/3Z//BLxDH50QIz2FTjsbFPzwA08txgguOgj1iSDpQ5EjWSjmGVU2lhZCOWD0EYdTRL7GRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARP95uiB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARP95uiB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777821095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O35DQj2POXduALoNRER0IMDyFb5F6YT44e06L3b7XJU=;
	b=ARP95uiBh80jci/Lj7gCMzkknbn67zQhEUmg4Jbd0Qcq9ZoBo5lqRhufe7OwMi1KTUBSux
	6IYndfaI9FCavXGmia7rcbMRYcHXz5cwblYThQwqWqgt47d2PLzXyZWca1E6NxqgXvD5PX
	7+KgXdyHHgpBb5XVzQ1jwDmDjNc7PHk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-t3GSMh1fMw6wsKQeoD4GVg-1; Sun,
 03 May 2026 11:11:33 -0400
X-MC-Unique: t3GSMh1fMw6wsKQeoD4GVg-1
X-Mimecast-MFC-AGG-ID: t3GSMh1fMw6wsKQeoD4GVg_1777821093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1D721800473;
	Sun,  3 May 2026 15:11:32 +0000 (UTC)
Received: from [10.44.48.53] (unknown [10.44.48.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5EA130001A1;
	Sun,  3 May 2026 15:11:31 +0000 (UTC)
Message-ID: <545853b6-a209-4ed4-aa97-4b63fe123214@redhat.com>
Date: Sun, 3 May 2026 17:11:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] dpll: add frequency monitoring support
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Petr Oros <poros@redhat.com>
References: <20260428152115.2815860-1-ivecera@redhat.com>
 <20260428152115.2815860-3-ivecera@redhat.com>
 <d99ca8ef-c11f-4190-bf08-b94c3ac76462@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <d99ca8ef-c11f-4190-bf08-b94c3ac76462@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi David,

On 5/2/26 8:29 PM, David Ahern wrote:
> On 4/28/26 9:21 AM, Ivan Vecera wrote:
>> diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
>> index 89f17af74923..59ec4208f251 100644
>> --- a/man/man8/dpll.8
>> +++ b/man/man8/dpll.8
>> @@ -111,7 +111,7 @@ Temperature (if supported)
>>   Type (PPS or EEC)
>>   .RE
>>   
>> -.SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ]
>> +.SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ] [ frequency-monitor { enable | disable } ]
> 
> very long line; please fix up.

Will fix in v2.

> 
> Keep Petr reviewed by on patch 1.
> 
> Claude has some comments on the man page in general:
> 
> ● I found three issues. Let me show them clearly:
> 
>    Issue 1 — Typo: "locked-ho-ack" should be "locked-ho-acq" (line 107)
> 
>    The man page description of device show output says locked-ho-ack but
> the code (dpll_lock_status_name) returns locked-ho-acq
>    (ACQuired, not ACKnowledge).
> 
>    Issue 2 — Wrong mode values in output description (lines 104–105)
> 
>    The "Output includes" section says:
> 
>    ▎ Operating mode (manual, automatic, holdover, freerun)
> 
>    But dpll_mode_map and DPLL_MODE_* only define manual and automatic.
> Holdover and freerun are not DPLL modes — they are lock statuses.
>     This should read (manual, automatic).
> 
>    Issue 3 — Undocumented but accepted alternate values for monitors
> (lines 134, 144)
> 
>    The man page documents { enable | disable | true | false | 0 | 1 } for
> phase-offset-monitor and frequency-monitor. The tool's own
>    help text shows only { enable | disable } and the error message says
> "use enable/disable". While str_to_bool technically accepts
>    true/false/0/1, the canonical interface is enable | disable. The extra
> forms in the man page are inconsistent with the help text.

Will send a separate fix for the dpll man page (non-next)...

Thanks,
Ivan

