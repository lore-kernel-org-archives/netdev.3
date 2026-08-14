Received: from mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E43B6364
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696661; cv=none; b=GzVgyvu1Jx0LG3Ww+HxJxYaJLneRiplRP+mCDaBIaXBW8LxYEPMFhdYLjdqTfNGAdkOfG1nDWDD+lUfdlBgRf6Ovfc4cBQTDrmKmtLq0Nb2bChd3oJMOlkQgccc3G4RGLpSqXm34sUmhqb5EWdtb7wrzD+F3W6r23gi1Lj1wYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696661; c=relaxed/simple;
	bh=GFg67AyRALXhuMHrH0MaKzNme3j9wl8cDn78igbpTQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRJzY4HhHJswCHmqpm14PQQbsbCO1vuB2f2HTaUjylneN3xkoSP+yY1dLjiU/QEYLvcJprlriAd0B1eVmkJAdQbm139weDDEc1txfBdykyWYQlMBs9YlD0wOZoH3AejPuv8eOjsQ3yi0+hV0qDto9ssFZMuLE6NRr0KOBODjTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SUcd8aOS; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SUcd8aOS"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GFg67AyRALXhuMHrH0MaKzNme3j9wl8cDn78igbpTQY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786696651; v=1; x=1787301451;
 b=SUcd8aOSXlJfeiGfrgspCB2YCObp6S52nlp00vtYWPro61NJUqGBeV0QETdrHq7J1vFEWWTk
 qHll0rbLslSXddqvfTTRdfE1ivBMLTGBkGegaKk8M3FnjE3blmvn4ec/riUR8MxZh+9rAntdzYe
 qE4bnvn/cYY2plTqz0bXBiZ8=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 60e1062f0f620b97;
	Fri, 14 Aug 2026 08:37:20 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <b43dc1ef-3b44-463f-b99f-148a9da2d578@linux.dev>
Date: Fri, 14 Aug 2026 16:37:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/2] net: ravb: fix PTP clock lifetime
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 kuba@kernel.org, vadim.fedorenko@linux.dev, paul@pbarker.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, masaru.nagai.vx@renesas.com,
 luoxuanqiang@kylinos.cn
References: <20260811103733.62599-1-xuanqiang.luo@linux.dev>
 <20260813104114.GG2757863@ragnatech.se>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260813104114.GG2757863@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Niklas,

在 2026/8/13 18:41, Niklas Söderlund 写道:

> Hi Xuanqiang,
>
> Thanks for your work.
>
> On 2026-08-11 18:37:31 +0800, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> This series fixes RAVB PTP clock lifetime handling. It reports a cached PHC
>> index without accessing the clock pointer and drains PTP interrupts before
>> unregistering the clock.
>>
>> Patch 1 caches the PHC index and handles registration failures.
>>
>> Patch 2 detaches the clock with xchg() and drains the PTP IRQs before
>> unregistering it.
> These patches are rather big change adding READ_ONCE() and WRITE_ONCE()
> to avoid a LLM warning? Or have you hit a real issue? How have you
> tested this work?

The READ_ONCE()/WRITE_ONCE() use is as follows.

PATCH 1 follows Vadim's suggestion to cache the PHC index.
ravb_get_ts_info() can race with ravb_ptp_init(), so the accessors
are there for that update.

PATCH 2 only addresses the race reported by Sashiko. The teardown
follows Vadim's suggestion as well, and READ_ONCE()/WRITE_ONCE()
looked appropriate there too.

I do not have RAVB hardware, so I have not reproduced the PATCH 2
issue.

> If you have a test-case could you share it? I have a pending series [1]
> that cleans up the whole RAVB driver ptp management which have grown
> rather organically. It have a small fix for the missing check of
> registering the clock. Would it be possible for you to test your work
> with that series too?
>
> 1.  https://lore.kernel.org/all/20260811160200.2049987-1-niklas.soderlund%2Brenesas@ragnatech.se/

I looked at [1]. It is for net-next. But my goal is still a small fixfor 
net.I would prefer to keep this on net rather than rebase onto [1] for 
net-next. Does that work for you?Patch 8 of [1] moves the PHC index 
lookup into a callback, but that
callback still does not check for a NULL clock. Userspace can run
"ethtool -T" before the interface is opened, so the original hole
is still there.

To keep the conflict small, may I drop PATCH 2 for now and send
only PATCH 1 to net? PATCH 2 is a larger change, and I have no
reproducer, even though it does address Sashiko's report. The race
can wait until it is actually hit. I am not sure this is theright 
approach; this is the first time I have been in thissituation.

Thanks,
Xuanqiang

