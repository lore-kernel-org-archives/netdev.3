Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257337E5E5
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246841; cv=none; b=tBVeS3p4wmj/5EjOy7Lc6eYTUTlVfOfeVSMiptpRNiJWCBpamg9nlIq48HidSw/gCYu3Wx3ilX+RLkfI/jXiFlCTdnbAixFKoZgIKQ5x5JhridWSQE+ozAIGP5Fcv1f+IWNW/ebBsXjG01bOzl5kR72EZi+tITisRdXBRwTKpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246841; c=relaxed/simple;
	bh=VZ2bOH5Dv+3lyGu2jCfaSAuj8JiwF7+JV0rLaq+BXwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IA8NQ0u188Oc69RNQKch5DHKXMzTGKzvbl9lzLVfh9kPPdxHnvaUmr058M3nQoLCeZPQzLukKZS6TaiKKWaV2HslcBYnLIPZ4rAdBy+Ol1xWijGsCpT0BHuJbC5ztVYvRmWy8frc8dORuLKC0CqbwIv+UhRX3qYlZyZornRd1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrJWoDpk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrJWoDpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787246839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FskKM0lJCxuwH9SienBmFCa7mQjVO4ObAVEUw9VnP/Q=;
	b=IrJWoDpkG6Q6hWRhK/DUvC3fqE5GJ/VwusVFFxZI8rSjT85j2+wUlRFGcfnsCJGj6lif4x
	J+FqeMbLTGQS1hJgjvtzXLJ2GlQTAlBSUsTpv89SqQGVtXOH0n7Mw6sIGVlXfkSG6SXd1n
	fTm/vBLEV3zTQ46v+anwAIDvBCKoHDg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-cgmTqLjwPSWk4iZkh0_TJA-1; Thu,
 20 Aug 2026 13:27:12 -0400
X-MC-Unique: cgmTqLjwPSWk4iZkh0_TJA-1
X-Mimecast-MFC-AGG-ID: cgmTqLjwPSWk4iZkh0_TJA_1787246830
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28E5518001EF;
	Thu, 20 Aug 2026 17:27:10 +0000 (UTC)
Received: from [100.90.87.156] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C10AE18005BB;
	Thu, 20 Aug 2026 17:27:06 +0000 (UTC)
Message-ID: <dcbd4d98-8d22-405f-9ed0-b6e97369098c@redhat.com>
Date: Thu, 20 Aug 2026 19:27:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Ali Rouhi
 <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Cc: "arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cjubran@nvidia.com" <cjubran@nvidia.com>,
 "Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260815221919.64226-1-arouhi@sitime.com>
 <20260815221919.64226-4-arouhi@sitime.com>
 <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 8/19/26 11:16 PM, Vadim Fedorenko wrote:
> On 15/08/2026 23:19, Ali Rouhi wrote:
>> Add a DPLL subsystem driver for the SiTime SiT95316 and SiT95317
>> clock generators. These devices provide low-jitter clock outputs
>> commonly used in telecom, networking, and data center timing
>> applications.
>>
>> The driver exposes all inputs and outputs through the Linux DPLL
>> subsystem, supporting:
>>   - Lock status monitoring via register polling or optional INTRB IRQ
>>   - Input priority management for automatic reference switchover
>>   - Per-output frequency readback from hardware state
>>   - Phase offset measurement via TDC (time-to-digital converter)
>>   - Phase adjustment for fine output alignment
>>   - Embedded sync (esync) pulse control on outputs
>>   - Fractional frequency offset of the selected reference
>>   - Optional reset-gpios for hardware reset
>>
>> The driver reads all configuration from the device's on-chip NVM
>> at probe time -- no firmware loading is required.
>>
>> Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
>> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
>> Assisted-by: Claude:claude-4-opus [chat]
>> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
>> ---
>>   MAINTAINERS                    |    7 +
>>   drivers/dpll/Kconfig           |    1 +
>>   drivers/dpll/Makefile          |    1 +
>>   drivers/dpll/sit9531x/Kconfig  |   17 +
>>   drivers/dpll/sit9531x/Makefile |    4 +
>>   drivers/dpll/sit9531x/core.c   | 3111 ++++++++++++++++++++++++++++++++
>>   drivers/dpll/sit9531x/core.h   |  372 ++++
>>   drivers/dpll/sit9531x/dpll.c   | 1232 +++++++++++++
>>   drivers/dpll/sit9531x/dpll.h   |   69 +
>>   drivers/dpll/sit9531x/prop.c   |  397 ++++
>>   drivers/dpll/sit9531x/prop.h   |   39 +
>>   drivers/dpll/sit9531x/regs.h   |  371 ++++
>>   12 files changed, 5621 insertions(+)
> 
> as the new version is need, could you please think of how it can be
> split. reviewing if 5.6k lines of code in one go is quite tough
+1 ... Reviewing single patch with the whole driver is really annoying.
Next time, please split the driver into logical parts (e.g. low-level
ops, core ops, features one-by one)...

Due to the fact that the source is very similar with zl3073x, please
look at its git history to see how it was submitted in past.

...and please do not forget to include me in the CC list ;-)

Thanks,
Ivan

