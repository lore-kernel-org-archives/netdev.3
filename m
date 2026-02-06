Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985643D9034;
	Fri,  6 Feb 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386773; cv=none; b=SzZAv7xdEXRPPeRXFfy5XB0SNx+fpI1eN/Ew94ZperQi2fLkfQCi/XdtLJucjy04qN1VnVNl5duJ8M9qjwPjhiALV6m1B0lSe6CfqCytQQpgH+i83ayWL9c/D+Ce06/VtU+Tr13mV5bSUtQSO2kTTqhwIKHTn9pyCzoQs7af8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386773; c=relaxed/simple;
	bh=yeVgh5DgW1P7phMpPhwU62TlEbERZo+j+US4u+On67Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGdjgVS/rqlatZ21JCSn3bJ8jZfBTKDV243aFq/l5/TqE6AFC3DAVCIKwV9jjJFUWcjZw28OSu9KSpdatR0oEQ9U6dNTaRL6ksoPvAO+AcXpUR2XDYiceTZ397fS/hZh/X4Idjk97GlRw+d7SSZEQMZm+DCFIi/LSA/bD3LuYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 616E5rM5029633;
	Fri, 6 Feb 2026 23:05:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 616E5reu029630
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 6 Feb 2026 23:05:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7cd9c017-c3bc-4ea2-80a1-90f39cacded6@I-love.SAKURA.ne.jp>
Date: Fri, 6 Feb 2026 23:05:52 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] xfrm: always fail
 xfrm_dev_{state,policy}_flush_secctx_check()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <aYXvliWTCzC9IIVS@stanley.mountain>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aYXvliWTCzC9IIVS@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/02/06 22:41, Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding.  #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> 
> Hello Tetsuo Handa,
> 
> Commit 638361ad7ab2 ("xfrm: always fail
> xfrm_dev_{state,policy}_flush_secctx_check()") from Feb 2, 2026
> (linux-next), leads to the following Smatch static checker warning:
> 
> 	net/xfrm/xfrm_state.c:898 xfrm_dev_state_flush_secctx_check()
> 	warn: was '== (-1)' instead of '='

Thank you, but this change is intended for demonstrating to SELinux people that
making xfrm_dev_{state,policy}_flush() no-op results in hung task bug
( https://lkml.kernel.org/r/f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp ).

That change is already removed, and we are waiting for
https://lkml.kernel.org/r/2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp
to be applied.

