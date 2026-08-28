Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5138F947
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887317; cv=none; b=GhDHBd8sCuOJateJDtM8TRf1alvbIEsucyoz7eyJFYOivkS322xWJI1VH13FC1P2Fimx9TZjs9L6HbKj+04gppF6/uvn2cVrYNXKDdXBdZiGf1zDomO1d11E/qpWzuvao9LObrz/xKbHgPmtHM/jkCA9k45QX+WGv0tLOKzX640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887317; c=relaxed/simple;
	bh=Y7MwWHl6NJBPv/ecTi1oEv8BmOJQcKwIr5Mi4FgkMhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnU/iuApIiIns6y120MaPJT7Nz+9EtPi8SwqqWBC0RFMLbVjpGhM8bMUr+R/la3+Eyzeq8k+htjgYp0JmpEzVnUNb8+bwKfZvwb0KyAKwVRKRfuJ8c494dofskpDGfJQh0ocNhRDY3tKMp2Ba5vFcdYMpVJZc/et+T3tL1kynb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l9KfWluK; arc=none smtp.client-ip=95.215.58.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l9KfWluK"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y7MwWHl6NJBPv/ecTi1oEv8BmOJQcKwIr5Mi4FgkMhI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787887312; v=1; x=1788492112;
 b=l9KfWluKjh46RDYoF9w25R481wFkvkeZ9FMec2cK3WyfFu0z6FhqjUtD4AcKOYhu+58PsLvc
 R2hKnpcFlMPJuCcyxr20ISSirfObbqp2buv237ghMeJgyeHDTnOEvD1nOvqZ8VMGoYY/JGU9SGH
 icg2hUYaCQyrACcE8n6KFcR0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 83a847a7e7c0d7ab;
	Fri, 28 Aug 2026 03:21:52 +0000
X-Mizu-Trace-ID: 83a847a7e7c0d7ab
X-Migadu-Flow: FLOW_OUT
Message-ID: <eb9b2a50-70f0-4410-b3fc-3fda6a4ddce6@linux.dev>
Date: Fri, 28 Aug 2026 11:21:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: Prevent queue stop with deferred completions
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Cc: horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260827230233.94878-1-joe@dama.to>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260827230233.94878-1-joe@dama.to>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> +	if (txr->kick_pending) {
> +		u16 kick_prod = txr->kick_prod;
> +		struct tx_bd *txbd0;
> +

Please follow netdev’s reverse-xmas-tree convention:

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

Thanks,
Xuanqiang

