Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE0346ADC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688912; cv=none; b=s5fXnmjGVJBsSsg+CREG+tw5/gTEtvvvMpLIp31SenhWax1hXnToitLepmoKlao+QJtXlgeThcZb4LBlleTHxeO3F8i/58BLoQp9uFh6C5MUS9xha3gywFllnInAtsx2d7Pejgq5f/kTXTQacpmA6ZPg7o3fja6bs6pEsgbbitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688912; c=relaxed/simple;
	bh=oyWvo3NLZRKTBh8vyVg5GAz9IHqJIMv8WIZ02/5W12U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rody7O+Yj3nZ6coPyMd69VLD6H/9Psp8Akr96AUz5ssYy1UpZouezOGZ0m9aXTDDcOkVvqFQiVVBX0KRP1zbrk0qXA26azyDP+8bZprRJhqYgnU+URF/T7ruBgga1AXg9UTmAiuj6hHgBCOclAtEun/Tee4gXmeCZURQIdYQ+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MUhCFIff; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MUhCFIff"
Message-ID: <8de7e108-3616-4e02-a7be-243e4cb8563c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783688907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyWvo3NLZRKTBh8vyVg5GAz9IHqJIMv8WIZ02/5W12U=;
	b=MUhCFIffrxv4vjKME/x/8iPjOzL8FyZJ5dPjYnWW15zzUvaDjbaqjPmYaUXJ0pSIV1kCJS
	IkxAbhXf5l0G0eQL0SDIYJcckv17nzY5asLuVKwLp08/fRntkXKnBl6nJHqLCxq9zb00IO
	icohEB1kE0jaFBhnoZ3LtgHD+3jLurk=
Date: Fri, 10 Jul 2026 14:08:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/4] dpll: zl3073x: add PTP clock support
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260708170527.916035-1-ivecera@redhat.com>
 <20260708170527.916035-3-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260708170527.916035-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/07/2026 18:05, Ivan Vecera wrote:
> Add PTP clock support for the ZL3073x DPLL driver. A PTP clock device
> is registered for each DPLL channel that is in NCO mode, providing
> gettimex64, settime64, adjtime, adjfine and perout callbacks.

Here we come back to the discussion of NCO mode. Is DPLL channel
actually a pin (virtual or physical)? If it's not, then it means that
channel is exposed as independent DPLL device, that shouldn't affect
other devices, but AFAIU, it can in the current implementation. If it is
a pin, why do you check device's mode rather then pins?

And another question - what happens when channel changes its mode to
non-NCO? Do we have ptp device disappearing from the system?
