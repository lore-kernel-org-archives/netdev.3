Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76760309F00
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682735; cv=none; b=Vy1b9eulYuqos90YHNLwZwOdTVrMvX0xY9MrLS4u7xTYx2hwb2Qs26tW9jtODJdZmsgF2qZUg4SpF0EGw00QHQro2swmjkI7BaL2yZZ/cDik+KYmoLw+E7au09LyDwXv83HqyD7mPsfbdXqrCPXScGCt+Az6P1KWyZZlea4wVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682735; c=relaxed/simple;
	bh=W1ojbXgJ753hCJvLC+W++ND0BA+UQYzvIU/Af38fFMo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qEOCYg3cGzIv8OyQsZdcCrOeSshQVxBskxbxUJVkeaeNQDE8QIh5BHcbZDz0kIWYDjuZL9ogFI33E3fMAe17XAwVKWltK+bP12mPGXBpBVIV7Tcxj3ndWXpsH6912Qphl4dz28loWIoUR8mFDOxjywa6zXcQJSSy28rRJ8/wk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60TAWCOV031477;
	Thu, 29 Jan 2026 19:32:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60TAWBrk031474
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 29 Jan 2026 19:32:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f32237d0-69d4-4e09-ae25-11fa12d34ef2@I-love.SAKURA.ne.jp>
Date: Thu, 29 Jan 2026 19:32:11 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ilan Tayari <ilant@mellanox.com>, Guy Shapiro <guysh@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
 <20260128123546.GC40916@unreal>
 <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
 <20260129090959.GD10992@unreal>
 <d0aa3c51-291b-40fd-82b4-15024dc4404b@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <d0aa3c51-291b-40fd-82b4-15024dc4404b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/01/29 19:16, Tetsuo Handa wrote:
>> Do we have such in-tree devices? If the answer is no, you shouldn't be
>> worried about that case.
> 
> The "user" here is not "in-tree devices" but "Linux administrator" (such as Alice
> and Bob).
> 
> We can't guess whether Alice is using $dev which supports only "IPsec without offload"
> and is calling xfrm_dev_state_add(). If Alice is doing so, Alice might be expecting that
> "struct xfrm_state" with a reference to "struct net_device" held is not released upon
> NETDEV_DOWN event.

we can't guess whether Bob is using $dev which supports only "IPsec without offload".
Bob might be expecting that "struct xfrm_state" without a reference to "struct net_device"
held is not released upon NETDEV_DOWN event.

Therefore, if "[PATCH net] xfrm: always flush state and policy upon
NETDEV_DOWN/NETDEV_UNREGISTER events" is applied, Bob might be surprised...

That's why I consider re-introducing xfrm_dev_unregister() might be the better fix.

