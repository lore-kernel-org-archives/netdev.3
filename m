Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B131AF07
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373263; cv=none; b=IdSuSu7axkDueKIOjVHDIGiV2oqt74e9qxp1uH10wrqB8/azO+yEhfITwnE2kZl5X7itwbg3iwyOIiw2l259pQeotgO/X3Kv8fnxbBD5YJ1WLcd2zd6t4qKiNaHUaF6CtxQX4dud0OiwIarzZlsfQP7FELKIi1vB4O6CpgugPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373263; c=relaxed/simple;
	bh=634b69zP9q6m16JvsoJoMJfISFJo70A/tC3R0wRcuew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DstGSaupExdxB1K0O2uf5dwO5edTo0xhD0xrX49Q6JUo7VEOI49stUfHFE9EK1JTnToR8PPIHGyMm769h9OQLXmEA/xNTg46jn90wd2HnD7Np6DxA5eoP2sd8zzNkSUaKs4T/cbdv+uMocXrc1+RszLGCCWzT/ZQelg0k3Ya68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cnvi5r4s; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cnvi5r4s"
Message-ID: <4e658dad-bd76-4ab0-bd7c-4ff573862700@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779373258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFKCKD0q1nKPFVdAlq7uYenPX3OdTfrfAPCh6YGeCcs=;
	b=cnvi5r4s1G3xIEjsAC90pnGEupJQkMif5tlOkQXh+8BmZvlbBo3RJaPA3Eedrc8w6sQShN
	WlVhPS2fH3eGUZiWMdZ0HPDvaG7CLJUZC+f6NHqpL4J7jWB6Fh1RPzsyNewMrM2ctRERXQ
	isihu01F2aj8c80SfFJytdfviB+IBoc=
Date: Thu, 21 May 2026 22:20:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] selftests: tls: use ASSERT_GE in test_mutliproc
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <0ee9f412b6bd1a260a547d19f979f73b396746ac.1779354585.git.tanggeliang@kylinos.cn>
 <5978f34d-dbcf-4196-8a95-13165a5ba034@linux.dev>
 <20260521070726.3494d2b3@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260521070726.3494d2b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/21/26 10:07 PM, Jakub Kicinski wrote:
> On Thu, 21 May 2026 18:57:32 +0800 Jiayuan Chen wrote:
>>> This results in a massive number of identical failure messages:
>>>
>>>    # tls.c:1686:mutliproc_sendpage_writers:Expected res (-1) >= 0 (0)
>>>    # tls.c:1686:mutliproc_sendpage_writers:Expected res (-1) >= 0 (0)
>>>    ... (hundreds of identical failures)
>> I think it’s worth backporting, so a Fixes tag is necessary.
> Why? Is this bothering someone? Are you guys hitting this in real life?
> I don't recall seeing such failure in netdev CIs.


Upon second thought, if this issue occur during the development of a new 
feature,
then a Fixes tag is not necessary.

