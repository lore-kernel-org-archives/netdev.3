Received: from mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952E3B1025
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656715; cv=none; b=IwKxU7vKETIedMxFjudlReERE86N/r5pOUXfJFYh5fl/vrj2q7wkyAFGEOTVxawDkM2WxEJa4qtMgFXsQPbS/n+LHBwUkCzCZY6nV75uztB1k7G29tSTQNTq+JDZWCVf0jPT6F8voKtvo1Isg9ucz4vQc/SSRSbQ2V6brwQ0Bfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656715; c=relaxed/simple;
	bh=6J8sP/C7V6GGg1p+KUp/a1yRHoCcDJDRcT0E3q+spIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVleNZlWfwXAlPjHrcVt5qgCwQmmjkzjXXV4Ndzhb0lSZJY9XZZdODNS3Xa+GT4IRAffPG5KcBzeFguzJkU03qwqpnnUQI6imv5jM0Fe8RkWLf4kXT9Io8ONpeaOfN1whAP7gJoXxylwXMGqO9w0yyl5XUqNuA7ledgvAD3yHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aSCpHs1c; arc=none smtp.client-ip=95.215.58.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aSCpHs1c"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6J8sP/C7V6GGg1p+KUp/a1yRHoCcDJDRcT0E3q+spIs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786656707; v=1; x=1787261507;
 b=aSCpHs1cOBWwJF9DlbcK2KAw07k2L6RHx8ftuPtYpSnFVVHv2f5/40usQhQvkZm5gUWzFYqW
 6fqkYHR7iK8il+ouSLiWgUTNtX/EqerYT7MpyCEZBb9UBy2iMJVMYat2rPOQ65e6eqa7AMfAx9m
 m8POXxOCmte/H68+O49R78YA=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (64.43.42.247)
	by smtp.migadu.com with ESMTPS id 005fb556f5729059;
	Thu, 13 Aug 2026 21:31:46 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <038cb83b-ad8f-493c-b904-05bec353aaf4@linux.dev>
Date: Thu, 13 Aug 2026 22:31:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] dpll: zl3073x: add PTP clock support
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
References: <20260811134700.1211010-1-ivecera@redhat.com>
 <20260811134700.1211010-4-ivecera@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260811134700.1211010-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 14:47, Ivan Vecera wrote:
> Add PTP clock support for the ZL3073x DPLL driver. A PTP clock device
> is registered for each DPLL channel regardless of the initial channel
> state, providing gettimex64, settime64, adjtime, adjfine, adjphase
> and getmaxphase callbacks.
> 
> Callback availability depends on the current channel state:
> - adjfine: when NCO pin is connected (returns -EOPNOTSUPP otherwise)
> - adjphase: available when tracking a reference, uses TIE write
> - adjtime: always available and uses
>    * phase step for sub-second deltas when NCO pin is connected
>    * TIE write when tracking a reference
>    * plain ToD read-modify-write otherwise
> - gettime/settime: always available
> 
> The adjtime callback splits multi-second adjustments into a ToD
> read-modify-write for the seconds part and a sub-second mechanism
> (phase step or TIE write) for the remainder. On partial failure
> where seconds were already committed, success is returned to
> prevent the PTP servo from retrying and applying seconds again.
> 
> All PTP callbacks are serialized by the existing per-DPLL zldpll->lock
> mutex, which is also used by DPLL pin and device callbacks.
> 
> Reviewed-by: Petr Oros <poros@redhat.com>
> Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

It's a bit weird on formatting because of functions reordering.
Anyways, main parts LGTM

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
