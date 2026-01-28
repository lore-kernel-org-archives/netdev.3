Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48929B78F
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597046; cv=none; b=asgHi6+5rKf75suq3Y/Aq9ppmoNQRFTAgJQD8jyOLmL/U01IdgGO0Mfl86hUBXfT9Ixg1RnbEKqaZmNWp/zkjCPAMrNyOglTMi0qDkWnNH7xt7tAObrjvvHOSmf0vNIqoG/2WnHhmnUx3LAXMKhjLEnxQZeK3aX2L0RJFVcNido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597046; c=relaxed/simple;
	bh=FNRCAWh+CuHM+pPc1M86BGYXZ7Bpa3pTdXUTnKlPNzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YARk+21RQoKRLuEnUX7HMWcQKQYaKfZYCqlsyCVYtTzHARZMQrvZVlxz2zAs5UbPa9zKZOSop9xoTmf+oRDGZnIHcJOxcaF1G49QkWzGINGBtG3jXn6TwNziykHMAoKO2i9/dZrgcwrJkaD7OvobA9mgUXW3T8YVQeT34ihf0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60SAi4TK010117;
	Wed, 28 Jan 2026 19:44:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60SAi49M010113
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 19:44:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
Date: Wed, 28 Jan 2026 19:44:02 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ilan Tayari <ilant@mellanox.com>, Guy Shapiro <guysh@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260128102404.GC12149@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/01/28 19:24, Leon Romanovsky wrote:
> I think this can work, but IMHO the more robust approach is to ensure that all
> states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.

The transaction will become complicated, for dev->features manipulation
function can fail.

> 
> Would it be possible to handle this in NETDEV_FEAT_CHANGE?
> 

Is there a guarantee that xfrm_dev_event(NETDEV_FEAT_CHANGE) is called
regardless of other callback functions, for it can return NOTIFY_BAD ?

