Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26324334A6
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381468; cv=none; b=oTW02/gvYzVQeBa2UC0rA/E3pqkyCkpstJGE7amMVuJdIWa6zGm7iQTvUINffVA8LI+g3uHUwY+6jd0ZK7G8ThZvMdhOr2ffPnEY/uzz/nphFxudU1lqZrNNkj3O4E3jBHtUl4/sb0OU0f//tDnFZPOolcZY49RdgQLj0414PSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381468; c=relaxed/simple;
	bh=pPqJgzbybXpz2GWg3mrNY2EcK3+FzYMPGnjbLys9//A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=dNbvucUDfbxPGmj5/O+vRScQ/2xrlmNd55yBs2Nr3TrgiBixRqqTCof8IHeYM/XgI74clZwbzoW51cvTvdCMwUDUbVLoC5i0zugLv8zaaHtxoabx+ZwvkW+oNtIDf5GlhPKzDoh1BYvWpsQfaha+aiNTPI90BzeEjPejjgvElVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68EAO02p033951;
	Mon, 14 Sep 2026 19:24:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68EAO0a6033942
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 14 Sep 2026 19:24:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d0d5bb33-c9fb-4442-9015-7999f91b4e29@I-love.SAKURA.ne.jp>
Date: Mon, 14 Sep 2026 19:23:58 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH v3] net: track raw dev_put()/dev_hold() usage under
 CONFIG_NET_DEV_REFCNT_TRACKER=y
To: Network Development <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd@I-love.SAKURA.ne.jp>
 <39ed6ba0-bef0-4710-9790-ab13092521b1@I-love.SAKURA.ne.jp>
 <591e7555-a399-4753-becb-b00df2df660d@I-love.SAKURA.ne.jp>
 <56c707e7-1fb0-43ec-b8fb-cf6f451e513e@I-love.SAKURA.ne.jp>
 <271af679-34c1-4f7e-875c-4761c22595eb@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <271af679-34c1-4f7e-875c-4761c22595eb@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav215.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/08/29 23:58, Tetsuo Handa wrote:> syzbot is still reporting
> 
>   unregister_netdevice: waiting for DEV to become free
> 
> problems. There is netdevice_tracker which helps identifying culprit
(...snipped...)
> ---
> To: Eric
>   Please see off-list mail <e2f7c53b-fe15-4047-8149-145c91de297f@I-love.SAKURA.ne.jp> .
> 
> Changes in v3:
>   - Repost as v3, as sashiko's review comments at
>     https://sashiko.dev/#/patchset/56c707e7-1fb0-43ec-b8fb-cf6f451e513e@I-love.SAKURA.ne.jp
>     was addressed. I assume that no more technical problem remains, and only how to split
>     this patch into several patches for getting approval from relevant subsystems remains.
> 

Sashiko did not find problems with this version
( https://sashiko.dev/#/patchset/271af679-34c1-4f7e-875c-4761c22595eb@I-love.SAKURA.ne.jp ) .
Any questions?
