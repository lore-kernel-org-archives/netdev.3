Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8C397E81
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.60.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409099; cv=none; b=LnYbGSwIXrp4Mi1CPc7RAGtg1LdeHOGzh6oY7I+7TPD5boYvfF6tA5zC9oprnB2EuSpKpEw8M1g42hpfL2aTF5rtYs671u5JNg0X9FELEVV2CMxTJX84OFWkwQKSpfaQ2ml1hFZHJc4oOTPkjylM8nL+bD1+pUCL7Ks6mngowmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409099; c=relaxed/simple;
	bh=DVTVYUrSsWapH6afusCmgT1CHbOeISHa+6ydMnMMaKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUrAqgc0LSjPBgkIbs1OgMI/3L1ADUF211SNIxZAJnbtlqGJPJGBBW0Q3d2Ey2X/UckqX4CRqWBWYjzTb3NP+7M/5aMTDMzfdQgzJKhdX2h6oJXGZfrebzT5iEyBNfsWn8OsNyG9N762niKTCTT/3efXv9aNRMcxUxIqFCbJ14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr; spf=pass smtp.mailfrom=corp.free.fr; dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b=M8qxTSGx; arc=none smtp.client-ip=212.27.60.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b="M8qxTSGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1792409094; bh=DVTVYUrSsWapH6afusCmgT1CHbOeISHa+6ydMnMMaKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M8qxTSGxJFgbxzIn/9upl7vyqP+ZjfeIXhnTLRImozfFxxJAeTsNsXFcLyOv+v3ff
	 5GtfMOCRgLJ3berOyJZuoqMl6PsAONog6uJgPrphuPD6DMrg2fy8d431qhLiPmsT/n
	 fErZ7vq1Ssh1Z/DzsfAVBozOSrfLeEqGObO24E3kaHLkQD3b+Pew4RmxjbXvlDoYK4
	 0WLGvDkhyOJHBQ1cvxJUOe0O5z8HAzLFzT7uqxEzFLMIAnxcX2Brw2wTcO7oBOzDmr
	 E5GoynrDF8ZuDdohh3u9hOt02P2YF3Yq7Q+JEvR3gIYaAFxGQiQb/EnEe1JjWLsisa
	 tDr2Q0NsExSBQ==
Received: from [0.0.0.0] (unknown [213.228.1.188])
	by rcs.proxad.net (Postfix) with ESMTPSA id 82A4944C05A6;
	Mon, 19 Oct 2026 13:24:53 +0200 (CEST)
Message-ID: <21fa9123-43b5-4286-ac00-279230ed47b4@corp.free.fr>
Date: Mon, 19 Oct 2026 13:24:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/sched: act_tunnel_key: skip dst cache
 for skip_sw actions
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
References: <20261009051930.3619697-3-acassen@corp.free.fr>
 <179161061150.434549.17402573349623469379@kernel.org>
 <20261016173025.2a25da8e@kernel.org>
Content-Language: en-US
From: Alexandre Cassen <acassen@corp.free.fr>
In-Reply-To: <20261016173025.2a25da8e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/17/26 02:30, Jakub Kicinski wrote:
> On Sat, 10 Oct 2026 05:36:51 +0000 netdev-bot+sashiko@kernel.org wrote:
>> Could the filter's skip_sw reach ->init()? One way would be to OR
>> TCA_ACT_FLAGS_SKIP_SW into the flags given to tcf_action_init_1() when
>> tc_skip_sw(fl_flags) is set. Otherwise, could the commit message mention
>> this limit?
>>
>> The commit message also doesn't say why the change is wanted (presumably
>> to save per-CPU memory). Could that be added?
> 
> Both asks seem reasonable, and I think you fixed the issue from patch 1
> already so a repost will also clear it up.

Will investigate Sashiko's claim, but sound legit on the init() since 
skip_sw filter gives its skip_sw flag to its actions only atfer their 
init() returns... init() cant know that the action never runs in sw 
unless the user also sets skip-sw on the act.

need to bound actions inherit...

will repost a v2.

-- Alexandre
