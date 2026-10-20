Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489022;
	b=SI5YUtRv0YHaTZ8fy+oCYqn2amW1+gk7kKFGwWbVN3WEU86YBPp6BDKf0zc4Q5T2H/1B
	 PIY8tqMtIdLmipNOZR6YfSQqEDPL+DQ7Gx5CPPCbRafb+eqApB+XrlK9O2MOz/V9XVLgo
	 78kDL/Fzolkv9eMLHHfYgfmuo7OWp4W6ODSOkZsullZHWcqPzpw9HPolNYRQ8frzJPym2
	 mlsdrtVQ8xYNiUGvWybBSfAdhuPuPHYtDVOWaYJBM4J8xmWpUnJv6gJEHf0ACZ/kx5DnH
	 E9z2IExS8XCwq5Da/1wKJVdU7j+vUMkuWKwx8/KTA/U/QidtCAUNShYoLRl439No7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489022;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5lpsvBHvAxlpc1hwk1xYx6qm1Ra+T5Mj3gqvkbfy5tc=;
	b=5o03nrc25PeFKgbHwaE1GV+xCEqPSQA3cPe13qkE/mSkr8wDPahCRbEk/ZgizAm30yvP
	 l1zdK78OpFRxfraVcS+h+xv5yuCSGZbZRsfyWqcrXn2gxBjLmPTu0qGdm1OQtM0ZtJJ5V
	 56iCsOIRkItoXuoLDemMQevhYH8lN+wWIiTyLHG30Fzr146Xhj32hhQs0PEAmMsEFqMoW
	 mM+abPYnydWaVuMVsU1Fhs+laP/fBRx6KT4xrkzoCZUMCVAHT2mJPdazzBmn9igpTEhBh
	 zsbBJEkf9pnfKikI4d1RZFWF8nZgfC4QVoK8Aaj7/tmTMVlIEeEfpCRLRBfXN0x4TXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L3LrkfZY;
	arc=none smtp.remote-ip=95.215.58.251
Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7A606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA7A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L3LrkfZY
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YIEvM8sHgjMXvgUVAE5uSY5439/NF7a2ha/iAy9npzU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792489019; v=1; x=1793093819;
 b=L3LrkfZYl0gjR3Vo12WVSvF7RcDabj6ykozs1ep9Cl2E7fudrl/9zjW0ynytHSug1SGDaJ2m
 fKUJkVQ6vdDsT/v6dM4r9ENYhCb9wTM/CtoFw/A1S/rMa5z/RbgHE4C2USf6A7b2orO2VRuqQz8
 YwngvetnNnlVbKg7Le+up8hk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 26a47b0b7a78b92f;
	Tue, 20 Oct 2026 09:36:59 +0000
X-Mizu-Trace-ID: 26a47b0b7a78b92f
X-Migadu-Flow: FLOW_OUT
Message-ID: <c23a3d37-fd61-4f7f-8bb5-64792ac7152a@linux.dev>
Date: Tue, 20 Oct 2026 17:36:52 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pppoe: delete session hash entries by pointer match
To: netdev-bot+sinfo@kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, Simon Horman <horms@kernel.org>,
 Asim Viladi Oglu Manizada <manizada@pm.me>,
 Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261020092118.47416-1-qingfang.deng@linux.dev>
 <179248826539.3290.615848934021449047@kernel.org>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <179248826539.3290.615848934021449047@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/10/20 17:24, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.

This was found by LLM when generating selftests.

>
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.

It was triggered by a duplicate connection attempt in a generated 
selftest, breaking the existing connection.

