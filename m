Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081232D0F5
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778813750; cv=none; b=ZeBIhLnYju0RVBJyMNEfIIHUEUwRa4VRudrSDw3hgeAhqCG8QGFO5LpQTwd3yjwuAeKjmbJ/PIxmfQPYC2gEvE6zbxxFBvZREkE89/YL0ldYNrquMf+m0BhqScOnpRKtg9uwvM48WpDfmjJOi5hSEN0yXiBl/i6KdF55VKFDOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778813750; c=relaxed/simple;
	bh=XmaykSChX/XVGGcxEiutOibJmkv335QMyhf/nK1JzFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2hNLeaRwqUr9djjYsV5pqW8wyKzO9CQrm4BQDwFUHdVVEgauI0MQVpVaa+YCnjX8niOZs5DeFAa7fw+ajM40hgi/ZVe03W1gLUs2F0R2+2RLwq2ATzAfKkyiiBU+eZDUAZESQFAItwUbJrqDe3jxnkwv+CGXsNJjZUh7vz3SE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jZGNwctj; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jZGNwctj"
Message-ID: <7e116785-46b4-4057-848a-090d5bc6779b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778813731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l961iiLn5/rCGWctYhoQybW6bleT2ATWMNCdAOuze+4=;
	b=jZGNwctjsfqf5vXA4nsZQCQdUB4tgs+1mW+mJEiL/ztZS3gCGk7MAzmfpExFTKEpSPeEXx
	AC9AeYtRCp6+Bh+rTLZWndAtY+KugvEgKlQhg2t882H1uPvvj1BhVKcEnPfgry+VcN0AxZ
	gxbFi5NFLmQbivIDcHkHeNgmntEV9gA=
Date: Fri, 15 May 2026 10:55:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: neigh: Rename
 NEIGH_VAR_INTERVAL_PROBE_TIME_MS to NEIGH_VAR_INTERVAL_PROBE_TIME
To: qiu.yutan@zte.com.cn, davem@davemloft.net, kuba@kernel.org
Cc: dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yang.chuan1@zte.com.cn, huang.jian@zte.com.cn, zhou.shizhen@zte.com.cn,
 zhang.dongyu1@zte.com.cn, ye.guojin@zte.com.cn, yang.wei20@zte.com.cn,
 zhang.lin16@zte.com.cn, li.hao40@zte.com.cn
References: <20260515101408635T6_cWDYOWVYQleZjRtUS1@zte.com.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260515101408635T6_cWDYOWVYQleZjRtUS1@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/15/26 10:14 AM, qiu.yutan@zte.com.cn wrote:
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
>
> During the initialization of arp_tbl, the enumeration constant name
> NEIGH_VAR_INTERVAL_PROBE_TIME_MS in the statement
> arp_tbl.parms.data[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5*HZ does not
> align with its actual meaning (jiffies).
I think the macro name NEIGH_VAR_INTERVAL_PROBE_TIME is just meant to 
correspond

to the configuration item neigh/default/interval_probe_time_ms.


>
> Using NEIGH_VAR_INTERVAL_PROBE_TIME is a better naming choice.
>
> Fixes: bf48c3fae6d7 ("Merge branch 'net-neigh-introduce-interval_probe_time-for-periodic-probe'")

Do not carry Fixes tag since it's not a fix. On the other hand, it is a 
merge commit not a regular commit...


