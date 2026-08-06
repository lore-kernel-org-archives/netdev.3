Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000C3254B3
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022348; cv=none; b=SZBfCN01XBcX/EpmlqNgiql7ECyN1l5QJ1BWujySODbmJWPUB7E6FnIqBui56n2UTEuueykjiUgmYRL70vIAeU0yyRbah8FVaZbkvZEvBnlUqI27wm1R1b1mQI0QDiTL3NXhgWzx1g8FbS6Lw1tSgxOs+S7ttneasnI7RaAzv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022348; c=relaxed/simple;
	bh=ScabkRed9xc17TccwMuJo10g/H6/bHekEyqsdV2aSl0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=u0lO0PCOMrk+sDD3WdnukgkiAPyjfSqPdBYOHsakOzinFEX26oH9PF5JCKpcHDH5j3XSQwAmHbJvjHh0eA8XjW/c0dLqLSgYxuyoJP7rtVzcqhL80RvB2ZTWXFvsy5X4Pf3a6bHdm6FuUjzROb+kUZXvbupOVBvtnIuxMnSFrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 676DIdrk072588;
	Thu, 6 Aug 2026 22:18:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 676DIcEG072585
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 6 Aug 2026 22:18:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2175f74b-00c7-4868-aea5-ed9c171c41ee@I-love.SAKURA.ne.jp>
Date: Thu, 6 Aug 2026 22:18:36 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net: udp_tunnel_nic: reference count leak during
 network namespace migration
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <73ed3aa5-f6e1-47b6-9e5d-428ac1f4cbf3@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <73ed3aa5-f6e1-47b6-9e5d-428ac1f4cbf3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp

Ping?

On 2026/07/18 21:03, Tetsuo Handa wrote:
> Description:
> 
>   syzbot is reporting a reference count leak when a netdevsim device configured with
>   UDP tunnel offloads is moved to another network namespace, and then the target
>   namespace is destroyed.
> 
> Cause of the Leak:
> 
>   The root cause is a structural mismatch between the namespace migration logic in
>   __dev_change_net_namespace() and the unregistration path in udp_tunnel_nic_unregister().
(...snipped...)

