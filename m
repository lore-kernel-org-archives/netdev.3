Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD284CCDF8
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245926; cv=none; b=Vsd6udK6HvSON7gQaFG9SOnvGqi/K0lfmU70ixjXJOTt80D7rFGy3+PD1iak8Lh/bPPklonavCTprSSLz7rlt3VagwPOCK2W77mqG21I/BR7fZU7tmg6r+wZuh8jUNRDlaglFiXb0fXlaxO2SFc2HB59d4Okji6BJrggErgbYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245926; c=relaxed/simple;
	bh=RwQL1RY8OzO4Rw4CQJuZRJSu+19F0vPtxW2bQZc7o8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLwVN/ZSvCmUj9aPGCpFxGklpWXIpkzBtR+2jMZCsXTSwUt6u0arUoFfD6NukhffJXv/5NnWQ7/GNPCl9FmHyfsivmIQ98GeposLor31gVBkwpgI23HYaCuhRxyOlXtpQkHF+txwudu1YqcM7ZoAXshxBTiHSWcp4ux6PGRqD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YJBhIf/R; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="YJBhIf/R"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-484362f5c4aso2049051f8f.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788245923; x=1788850723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Lai16rot35+iDcHmG6b6sZUHR4jeRUqeLrUyQfUb4U=;
        b=YJBhIf/R31nGUfC3J4vsAz4vegQnDRgpGeWPt/lx9cXViRZUNCzFL0TegkAFRkHrkp
         BHnzbOwiIWZAl7G+F3VX6z4EoNHnnpWod7AMaa3E3wLxv9Lnddkm88vyRrmFVQcpdLBZ
         meABB5SoPgJSzk+80woOIHgPJww70SxLyo60FOnjywwwn0AtJLSMEpHeqiZLkY2YtDuj
         EuB3sn3Ybv0q65AVHgEZ2aFRkeS2uI6leIdKb4w+W080j/LjmrKeS9wJ5ajFCU5B3oMe
         RzL5hj8TWSLz5I3fSWX2PKAfJzuGYpst2QhBBf1yZ1ZxfsVKwfdt4Q7mR+eL0nIrGYi5
         ieIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245923; x=1788850723;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Lai16rot35+iDcHmG6b6sZUHR4jeRUqeLrUyQfUb4U=;
        b=rlSAQqnXwgNHsJGJbnzwz7nYa6AlmaR1bWkaYDYeIrDevMWu2rlI4tzk9roEeU4MRi
         WnPRAAwCPc7UBD01+uXkTVZLJ7zxQaMbFKj/JmOQvGVCjvVQPK0nxwEzmpjj6BmToQOy
         aVUJSPu6xq5NAKK8tvbOQMrWPqiVQa5x1y+gumvvH1YKSTe+0ZqLxkkZPgeycIzgupKQ
         ij0vqJP3XChTcQLpWf06+0Pl552QN/Q7YrmteJjBLwr71Vg7l81DHHgKjYs1IJyJ0YqV
         +pXuRue6TyCQhPYYFssnSUSytRENQqogZCXp44uWhPHseL+SoPeGc5lmwlulBwHotlwM
         xNYg==
X-Gm-Message-State: AFuF++ko6eBBtMyc410/MZcWJ5ALwsdHBqe8GUSnVxneHFO8u0MJioP4
	Gw8ULPcws10SUS+zQU6tCHIfFgQ1QffderjH5iIULuRT1B+ri8zA47kFen0k6azU8Uw=
X-Gm-Gg: AR+sD11hZX0pNWoyyh+LjO3Y8X9IcKBZExZRlMFSS+tEy1UxuAA5VZaCHoYi4nh14PP
	t1ew7GK9StD+kT8ak6WwMSY+5X8Zplfyt9NVXCeqUCQQ3amMNdKcv1FDNdXY6c5yYSpirn+2Lyl
	6auyayOLANg3MSSCrucw3px0Mh2/P9oxj4ojqIa0eS4izmyQLEdYrlXqZ05Nxn9FT/t6HH84aWr
	2hea6j61y48gDU2JhqEgadwDk608C92hTo3+HQTnZ0deck88PUd/mC//69UMFkZzVVRI8kIq2i3
	eJSNguua3X1qaNYp9Nxu2mg18yGslTi+sn1IrKMP1RnnJE9tdkqqquIeudUKi0kXoUhH5wJRRE5
	BGEXSsM1FKK/0P8kTruDpyc0Lmnx1vXITnAtFgYYeKVnWWYc/zTZ5vRh7Z3ToJfAcfer5lJngwZ
	RjOiFMGQkA5g9fmBLsYmI47cLvLAbRP2fT1guIjM/3u+juCoz0CYVuLqcICi7yg3CnV1SX554Jz
	3Hhf/T5a3Dxp4G8xi4=
X-Received: by 2002:a05:600c:4747:b0:499:dbba:9859 with SMTP id 5b1f17b1804b1-49cdc57bf3emr89294125e9.5.1788245922522;
        Mon, 31 Aug 2026 23:58:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d3c4absm2917665f8f.10.2026.08.31.23.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 23:58:42 -0700 (PDT)
Message-ID: <e5a118ea-abf8-43e8-abb9-d1ec4ee11c09@blackwall.org>
Date: Tue, 1 Sep 2026 09:58:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] netdev: avoid skipping objects on race
 with device disappearance
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net,
 bobbyeshleman@meta.com, sdf@fomichev.me
References: <20260831164159.1124679-1-kuba@kernel.org>
 <20260831164159.1124679-3-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831164159.1124679-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 19:41, Jakub Kicinski wrote:
> If the currently dumped device disappears while we were mid-dump
> we will get the next device without resetting the sub-object ID.
> This is quite unlikely, it was reported by an AI tool not a real
> user. Let's fix it for better dump consistency.
> 
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/core/netdev-genl.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

