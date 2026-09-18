Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE651A73C;
	Fri, 18 Sep 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750594; cv=none; b=GeFkE5IdhiRXS8K9xQaykqz5jGgL1jwlh49tju9plZX0LANnY+6iKaFkgCnaoSJp3am/KUVCBUcSmIlldGAZBAYiVyM4K0xdjNA78P0bb6ozOdbzfOlAhZ1ZKh/rUf9wQmSkPI3a8T4WlCQlMTRYcD+xHXZKx8AFTAGX7Hq99Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750594; c=relaxed/simple;
	bh=XojK1aH6MJS/F4EwychKrgpBrWRhiK+a+PkzJpETGJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAqAz0RQ/PUnTAcxrK9m2fJokEC/GDpmtGeifdQT053896hqNHIa+WsRpnev37RWsn3SJtH+Dl4KhbuGpK6AWHYuVuJHcWoGpxup17IYwaMb5c2IGUuBCgh0ZlQZtDBaXf9u+jJ9ti4PPD1qI2mdizJvx4MeCekstEfLO8ESvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JHtwdE0R; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JHtwdE0R"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hmf0X0NG9z6LmM;
	Fri, 18 Sep 2026 18:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789750588;
	bh=XojK1aH6MJS/F4EwychKrgpBrWRhiK+a+PkzJpETGJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JHtwdE0Ro0nfZfESGhetZliNaMXZJlll83bNUMjUk4Uw4qgzTCRrDobrFfkNphgdU
	 ORz9sK3Zfphhcu5iCUeCSCvf1zYJYB6yL40lHI5/WiYa83NoTOFeigJhJcCN8w7qfW
	 hSWJSDbl6vbZfVondy0HpnOcnPH3Tx9wt+xKnrWfQsQO/5ZqhDJPtBJ5LwY6x86X/i
	 t+LIdy6668sHd4ghJjC1X0PFXM9GNJ1f0ZwH9t60rnn7L/wZ4zuKOLs0JVYdpws79m
	 Y4SEtHkNLdJX29PQ4dWUBcsudlK9Na5eu74aqiG0QaNTq78lap/ezdpeuNRd1hWkR1
	 nOKOvtkTcocvA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hmf0W6ksVz4y71;
	Fri, 18 Sep 2026 18:56:27 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hmf0V3cJ5z8svY;
	Fri, 18 Sep 2026 18:56:26 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E7D6A5FA75;
	Fri, 18 Sep 2026 18:56:20 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <85c50e6f-a270-4755-8576-c4ba2b961e26@leemhuis.info>
Date: Fri, 18 Sep 2026 18:56:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "net: qrtr: Send HELLO message on endpoint
 register"
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Chris Lew <christopher.lew@oss.qualcomm.com>,
 Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
 Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>,
 Daniel J Blueman <daniel@quora.org>, Takashi Iwai <tiwai@suse.de>,
 Vlastimil Babka <vbabka@suse.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20260918101621.2848322-1-linux@leemhuis.info>
 <lgyho3avi65edtr4xggbsrja47cjhqbamrnmchnfh4blmyygd6@bhotovqqqubj>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <lgyho3avi65edtr4xggbsrja47cjhqbamrnmchnfh4blmyygd6@bhotovqqqubj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178975058160.2895271.1887392753712195921@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: E7D6A5FA75
X-NC-CID: JT6oaaAe5xXcb6MDvAu5WoBsYUw6B6puDrFY4xUydwv4Kb1OK3k=

On 9/18/26 18:37, Manivannan Sadhasivam wrote:
> On Fri, Sep 18, 2026 at 12:16:21PM +0200, Thorsten Leemhuis wrote:
>> This reverts commit 544d85de4dc22c01badfd8cefa59829ce35c4858.
>>
>> It causes suspend and resume problems for numerous people, including
>> maintainers and developers of ath wifi drivers. A fix was proposed[1],
>> but did not get any traction, so go for a revert instead.
>>
>> Cc: Chris Lew <christopher.lew@oss.qualcomm.com>
>> Cc: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Cc: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
>> Reported-by: Daniel J Blueman <daniel@quora.org>
>> Link: https://lore.kernel.org/all/20260909055846.16539-1-daniel@quora.org/ [1]
>> Reported-by: Takashi Iwai <tiwai@suse.de>
>> Link: https://lore.kernel.org/all/87a4plsg4w.wl-tiwai@suse.de/
>> Reported-by: Vlastimil Babka <vbabka@suse.com>
>> Link: https://lore.kernel.org/all/ab1491bb-cca5-4145-ac7d-31c966abf7b4@suse.com/
>> Reported-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>> Link: https://lore.kernel.org/all/6257c447-788d-4362-851e-0d552bcf7c56@oss.qualcomm.com/
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> ---
>>
>> I'm not affected by this, but due to all those reporters mentioned above
>> it seems it would be good to get this fixed for 7.3-rc4, as Linus' rule
>> of thumb wrt to fixing regressions is "generally be 'within a week',
>> preferably before the next rc". Which is why I currently plan to ask
>> Linus to pull this directly. If this is a bad idea, just tell me.
>>
>> The patch from Daniel linked above[1] could have fixed the problem, but
>> none of the developers of the culprit or the maintainers for this area
>> commented on it within a week
> 
> Really?
> https://lore.kernel.org/all/hcr4woicsnz3pbhzlguuwjlego7yli3znhjmsx4cdz66xa74zd@wjtle2yslc4b/

Apologies, I had forgotten about that one.
> FWIW, I don't mind a revert too, but the comment was misleading.
Just tell me what you would prefer, you are likely the best one to judge
here. I just think it would be great to get this resolved for -rc4 and
your option would really help there. Sounds like you would prefer that
fix, is that right?

Ciao, Thorsten
