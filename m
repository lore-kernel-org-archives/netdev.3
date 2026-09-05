Received: from mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFA44237B
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607198; cv=none; b=WerIBmOHk4cIjRn54nK8HaaiW8fHAgMBmmVIWlxjGpkgxXkLKXqnJVeD0hRG5iuFkKRO+AQbOK6iReweaZBbbradJzsZJ7y0JEYZu7zlF0YbdxzSWUHG0Xna/1Vz4zxQNb6CgP35h1faWjGHCR5L/Y1xlhN0SOQiNpa42LboxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607198; c=relaxed/simple;
	bh=u9aIATvc41JAZqcBgTS/JO4h9M38OXTin6eDJyVLE8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggpMNFvNUGbk/f6aPm4FGukHZEzoT9BsuZFrqtUFkto6oSAcjtFpMJhC2c0L9MSfUdBFItaq6rQushkctWKx6DJPHkGvCGKZE7dkRs7zt08ZDSwoMs54NxqHK2pkSdzOCVU98/PMY+04IdNF0LlFLYtxR7EqF7MNwFr2zwxUPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HiuBfwoD; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HiuBfwoD"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u9aIATvc41JAZqcBgTS/JO4h9M38OXTin6eDJyVLE8Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788607190; v=1; x=1789211990;
 b=HiuBfwoD7NLNrHjyJoGxNTEkg6mwzCroXXM++WOhDQcOopTiDHrmVbrEpgI2a+ilGbErxPjB
 WyDY0sMDcJJtK9jyL84b72QKJFJNEhyr9eAmt4y3p9zQI32+lOLTnJEJKmxzYtxFzIQTFtJntIo
 Fu2B97EWAnYel4lAO/74V5NI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a75017eff48b416;
	Sat, 05 Sep 2026 11:19:40 +0000
X-Mizu-Trace-ID: 0a75017eff48b416
X-Migadu-Flow: FLOW_OUT
Message-ID: <65027d83-47e0-4ed6-828d-24c4ede4e7ab@linux.dev>
Date: Sat, 5 Sep 2026 12:19:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] netlink: specs: dpll: add
 clock-quality-level to the device-get reply
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, arkadiusz.kubalewski@intel.com,
 ivecera@redhat.com, jiri@resnulli.us, donald.hunter@gmail.com
References: <20260904191023.3869690-1-kuba@kernel.org>
 <20260904191023.3869690-2-kuba@kernel.org>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260904191023.3869690-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2026 20:10, Jakub Kicinski wrote:
> dpll_device_get_one() calls dpll_msg_add_clock_quality_level(), which
> puts DPLL_A_CLOCK_QUALITY_LEVEL into every device-get reply, dump entry
> and device-*-ntf of a device whose driver implements
> clock_quality_level_get() - mlx5 does. The &dev-attrs anchor lists 12
> attributes and not this one, so struct dpll_device_get_rsp has no field
> for it, dpll_device_get_rsp_parse() drops it and dpll.rst does not
> document it.
> 
> The attribute itself is correctly declared in the dpll attribute set,
> only the reply list was missing an entry. Missing since commit
> a1afb959add1 ("dpll: add clock quality level attribute and op").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   Documentation/netlink/specs/dpll.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index cdc8c7b456df..64a45088c027 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -632,6 +632,7 @@ doc: DPLL subsystem.
>               - mode-supported
>               - lock-status
>               - lock-status-error
> +            - clock-quality-level
>               - temp
>               - clock-id
>               - type

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
