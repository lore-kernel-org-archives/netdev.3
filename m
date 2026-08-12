Received: from mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFF41D10D
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529064; cv=none; b=M0qIuKgyw6WvTnb7iX/6y1J6smeI0QZ9RmjxTsYOpheFkr6qrMETrXJ87s4eT3lp7VPMYYN2kpDP7Xt1w4oAZPLZ/DWMQHPw5O7G9k9EwaZpLtjNbzcLSyzU2gk2vouSIBGbH0zY+3ElUbkaqYCIvPGs8Q6XYlYMTjecoRDe71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529064; c=relaxed/simple;
	bh=1uPkb9BAWjw3GcHKKPo0ZxsIwBPbkv3UbAzIQQ4pApo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTZWj1idSxPdOYnJca6YpSe4SjczSAI1E1kdSTze3A7QQ5yOlD4GYUT6/auLaCHL5v1ebuCXa7a/ELMck3Iy1EWfW1ljDWgjwQnNqhtpi73fViEPRCYHvse8UGLA2vXqWp/tdk5RWQMXgf5+9ws2fTMo1a2NzAZr+PvhnxVoe5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GWH6T0j7; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GWH6T0j7"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1uPkb9BAWjw3GcHKKPo0ZxsIwBPbkv3UbAzIQQ4pApo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786529058; v=1; x=1787133858;
 b=GWH6T0j7mAnVO2g4sz+M5Mp8CPMk5/qHrMWWL+veR/dnpBijgcKyVUmnh4+1zho5m9MJdWPh
 QIKBxPOpExFo2Ej8OF+E3VJ9cUFSl4pGhAgABiIEretxd29j+dc/+iqJ9Y2QrSdxsxaiOg/4bPD
 7rik1xkCWYF0Xho8SyGFChV4=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::5:4188)
	by smtp.migadu.com with ESMTPS id 33ab4a3eb3807f0d;
	Wed, 12 Aug 2026 10:04:18 +0000
X-Migadu-Scanner: mta11.migadu.com
Authentication-Results: mta11.migadu.com;
	none
Message-ID: <add0f48e-90a2-42c4-8445-754d85072e6e@linux.dev>
Date: Wed, 12 Aug 2026 11:04:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
References: <20260811134700.1211010-1-ivecera@redhat.com>
 <20260811134700.1211010-3-ivecera@redhat.com>
 <452e52d5-c80a-498b-b12a-ab539ed9a2db@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <452e52d5-c80a-498b-b12a-ab539ed9a2db@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 07:57, Ivan Vecera wrote:
> Sashiko findings. Replies inline.
> 
>  > Could a transient hardware error bring down the system here?
>  >
>  > If an I2C/SPI bus glitch causes the device to return 0xFF, the SEM
>  > bit will be set and the CMD field will hit this default case. On
>  > systems with panic_on_warn, using WARN_ON for validating external
>  > hardware states turns recoverable bus errors into fatal kernel panics.
> 
> The SEM-first check already handles the most common bus glitch (0x00
> return). For 0xFF: the CMD field is only written by the driver, never
> by firmware, so an unknown CMD with SEM set indicates either a bus
> error or firmware misbehavior that warrants attention. The switch
> structure with WARN_ON in the default case was requested by Vadim
> in his v4 review. Systems that enable panic_on_warn accept this
> trade-off.
> 
>  > Will this sleep-based polling loop destroy the timestamp's precision?
>  >
>  > Should the postts be captured immediately after the trigger command
>  > in zl3073x_chan_tod_ctrl() instead?
> 
> The hardware latches the ToD value when it processes the command,
> which completes when the semaphore clears. The post-timestamp must
> be taken after the semaphore clears to guarantee the window contains
> the actual latch event. Moving it before the wait would risk the
> timestamp window not containing the latch moment.
> 
>  > Could this loop exhaust its retries and return -EBUSY prematurely?
>  >
>  > The loop spins without an explicit wait [...] On fast SPI/I2C buses,
>  > it will execute all 20 reads in a few milliseconds
> 
> Testing on I2C at both 100 kHz and 400 kHz bus speeds shows that a
> single iteration of the loop body (two ToD reads, each involving a
> ready-wait, command write, second ready-wait and data reads) takes
> approximately 17-19 ms regardless of bus speed. The iteration time
> is dominated by the device's internal processing, not bus transfer
> time. With 20 retries the budget is 340-380 ms, well beyond the
> 20 ms margin window.
> 
>  > Is it safe to use WARN_ON to validate user-controlled input?
>  >
>  > Since delta_ns originates from the clock_adjtime syscall's tx.offset
>  > (via the adjphase PTP callback) [...]
> 
> The PTP core already validates the input via getmaxphase, which
> returns NSEC_PER_SEC - 1, rejecting values with magnitude >=
> NSEC_PER_SEC before the driver callback is invoked. The WARN_ON is
> a defensive check for a condition that should never be reached
> through normal code paths, not user input validation.

AFAIR, the general rule is not to write defensive code in kernel if you 
know that the core has already validated inputs.

> 
> Thanks,
> Ivan
> 

