Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96398204C3B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778810524; cv=none; b=Vi3iawX0ZfCD/pW7txL1Tkg96SGFGrk4EMGm/Li28xEENioip7QaKHvkUt7PvuZaNGbLzrmysohcSB6TIx2Azv2MS8TQ4LZpW1JLB53FS1yZr6ofluhIJWAbcFdDg1TFGb1yGOvr+K0k8GlvgvSYfnbXZyM9SM3Jdli86OZHHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778810524; c=relaxed/simple;
	bh=RUo9Zm+kUTt1LGVjRvStOWi2h5sS3Kp5xF+lxLh+nAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPYzptVYajsyepNoBurr+dk6b0Wq/5Azt/He54/PKb7Pft7D8UNifhlP8SHH2J7V/aVzfOzvbVvYduqOIyg+cSCWy+sjbchnYME0cLSPuxc4xUxRR1RVO74VWRb9soGcJoAx+BYeVv5ZAc1VRhA8r2HLMCytEo8y5IwKLPnP4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZG1bB9vW; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZG1bB9vW"
Message-ID: <f747602d-8208-4b3a-9e16-78632ec7b919@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778810520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUo9Zm+kUTt1LGVjRvStOWi2h5sS3Kp5xF+lxLh+nAY=;
	b=ZG1bB9vW3JbbWw2abv0cdjKWVGchRM2mxJxYJVOtO3E/MhLDrIXzLtWMiN7VRFB7gTQ0Md
	doMpnNghSNeAXXVK0nSQLAqkDg0aT4Z7BvE0i4JuCAeyAkKHqJe8so0l2mKgkh4f151pO/
	OIkqipzKm8yYmd2nKpiS0lxpl6jCvQA=
Date: Fri, 15 May 2026 10:01:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
To: Hyunwoo Kim <imv4bel@gmail.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
 kuniyu@google.com, mhal@rbox.co, steffen.klassert@secunet.com,
 vakzz@zellic.io, ben@decadent.org.uk, herbert@gondor.apana.org.au,
 dsahern@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
References: <agToIEDI4TaTNLRb@v4bel> <agVpIsaSherjHTYg@sultan-box>
 <agWUdie1xBvBu22I@v4bel>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <agWUdie1xBvBu22I@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/14/26 5:23 PM, Hyunwoo Kim wrote:
> On Wed, May 13, 2026 at 11:18:10PM -0700, Sultan Alsawaf wrote:
>> On Thu, May 14, 2026 at 06:07:44AM +0900, Hyunwoo Kim wrote:
>>> Changes in v2:
>>> - Also propagate SHARED_FRAG in skb_shift()
>>> - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
>> Hi Hyunwoo,
>>
>> I've been working on mitigating this vulnerability as a member of the kernel
>> team at CIQ, a distro vendor. In particular, we wanted to make sure that there
>> weren't any lingering places missing SHARED_FRAG propagation.
>>
>> To that end, I used Claude to discover that skb_gro_receive() remained unpatched
>> (as you pointed out in the v1 thread). And then I generated a PoC exploiting the
>> vulnerable skb_gro_receive() path.
>>
>> The PoC is a modified version of the original fragnesia PoC. It works 100% of
>> the time, just like the original fragnesia PoC.
>>
>> I have attached the PoC and a patch that fixes skb_gro_receive(). Please take a
>> look at them.
>>
>> Thanks,
>> Sultan
> Nice catch. Thank you.
>
> After testing, I plan to merge your patch with v2 into a single patch (not a
> series) and submit it as v3. I would appreciate it if you could then add an
> appropriate credit tag of your own.

When sending v3, remember to rebase net tree first then generate the patch.

https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=f84eca5817390257cef78013d0112481c503b4a3


Thanks

> Also, I would appreciate it if you could use AI to explore additional
> propagation variant paths. From my own analysis, no further ones have been
> identified.
>
>
> Best regards,
> Hyunwoo Kim
>
>


