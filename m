Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5BD3C3BF5
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725436; cv=none; b=NM7sQQXxkg+7pDvpYm+3KXzNwIZM2R3RVbKQ3XFmW6To5qOo/UYAt+VRsRHE39l5O53MYy1RQe/hGwEAYC6qiB8vl3V95CIaTSBDqob5+ArKPx9Q6zM7VSNljTaM1vna1dSj9BCRkKv/fF2QX1lOig7sycmOZQqv3VdFAxugqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725436; c=relaxed/simple;
	bh=mJHXW5OMt1s6DgVAsYKbJh6m5x0U0RhcE1Vtiy41emU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQhDveMK6lqtNbeF3gVRP5l0UNylbqv+aQAaoMYmq03gU2kc5MzcFZIUiVVow/pUPCS+1bFaszHdQ/T3Qdv3mEPLSURPRT+pXQlf3kACXutEAzUXTYjFhZWimNJcGd65YNI1h96RTvIfHymgfjKlCOGspU2OkRf1QZGQQEZ4ZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAVN9DLV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAVN9DLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772725434; x=1804261434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mJHXW5OMt1s6DgVAsYKbJh6m5x0U0RhcE1Vtiy41emU=;
  b=MAVN9DLVwv3jJy44KxI0da7QESOR3o8D0SZJgPL4WhsiZV2QSquuHwH4
   H2gkhtSfFeStGa4/vpk95KMrqdPLSh0uhxUJbiZs3q5XlXf9lWD+HCCIJ
   VFVqvDCvWe1qVY1C7JYwwVH3Uz3Kzet0BLlO1fum6um0EHW3UIpIzrPKi
   NsGmr8t986g84tsGj/MQuN4jMGxnM/J3rMaxzt9RIqMlWBR+tYramuhwW
   TiS70SX9osDcEoC739XsDABak8exRzjL/byTdZOPwqM/miOjickDEbxT/
   E2VX3Wp8E0GdNNg+JnYUWb+D2PRig4O1OZRI+S6ZyEPqIA3U7yZi/nLkZ
   w==;
X-CSE-ConnectionGUID: zfsDEqP5TESQGxUVAIZt9A==
X-CSE-MsgGUID: NHVmdgE9RfiqNir0Gki/gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85289899"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="85289899"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 07:43:54 -0800
X-CSE-ConnectionGUID: wmSM/6+4Q/mgh0E+TBhVbg==
X-CSE-MsgGUID: rAAgmY0XQL+PnQqCdIedew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="249179382"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.183]) ([172.28.180.183])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 07:43:53 -0800
Message-ID: <6e42658c-66cb-461f-bf41-7a1e1ceb7e3a@linux.intel.com>
Date: Thu, 5 Mar 2026 16:43:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: review scoring
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
References: <20260303180122.0929a864@kernel.org>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260303180122.0929a864@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-04 3:01 AM, Jakub Kicinski wrote:
> Hi!
> 
> Alexei just sent an announcement to the BPF list describing
> a new system of requiring review participation:
> https://lore.kernel.org/all/CAADnVQ+TKKptnNB25V3=bcdybh5G6c2DyW2sYtXvyRaVnPN8MA@mail.gmail.com/
> I'm very curious to see how this goes, it definitely feels like
> a logical step.
> 
> On the netdev side I've been using a patch review queue which
> takes into account
>   - the reviewer score of the author
>   - the reviewer socre of their employer (using the same logic
>     I use for the periodic "developer statistics" email),
>   - quality metrics like "is checkpatch clean"
>   - whether someone already reviewed the patches on the list
>     (reviews from the same company do not count)
> 
> I've been meaning to send an email to let folks know that I'm doing
> this. Most large companies are getting a 2 day delay from this scoring
> system. To be clear, I'm not intentionally waiting 2 days before
> looking at code (at the cost of my sanity). It's just that with our
> patch volume if something gets a 2 day delay there's plenty of patches
...
> that will jump earlier in the queue. And so far advancements in AI
> failed to make the days any longer..

Hey Kuba,

I don't think that's possible, but it hopefully AI could make our 
working days shorter by offloading some of our work or making it more 
efficient ;) I just hope we will circumvent / prevent AI slop from 
taking over.

> the queue: https://netdev.bots.linux.dev/suie.html?delegate=netdev

In all seriousness, thanks for sharing this and maybe this will help get 
some execs and other higher-ups across the broad corporate Linux kernel 
world to give more time to engineers to perform reviews for other 
company / community patches as well.

Best regards,
Dawid
