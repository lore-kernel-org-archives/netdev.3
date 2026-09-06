Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307225B095;
	Sun,  6 Sep 2026 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660778; cv=none; b=oGDTWfpD0uMBwluoPht55Fyz1ewi9v9xLx10aDmaIZh4BRPXGvKMnwB5S0j1lw9DipHfJQ6y1P03EcX3OdAOV8AxQVpO2BNFlo/2UpZlT5WI13pDmSUIbudyYy/XBCDTK82DgUqwymixuGH4mQJyzdgWDv9KgbKGtkAybiVByg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660778; c=relaxed/simple;
	bh=HMEMZ+/2Fyu/66jgPOkhprZAPhYEruCrguyK5LTFmNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POFvSj3Y7Evqkl5lfN1aTecICH/8+ZAi+53NihABkepV9/TjtSN0I6yDaoam06xEHaW0MXC7vs4aFGUfoqcCnDtT5xAYTILOSU/Qq92GepFVx4PCkdKVOLR/huemIK7CIG079FiiwpbDjbQ/8zpviFXhWZUCIsGf0Cy51V87GRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1314614|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0195983-0.000558861-0.979843;FP=2410299725729429457|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j6fU0gn_1788660771;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j6fU0gn_1788660771 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 10:12:52 +0800
Message-ID: <eec3e8ca-f24c-4614-b9c1-0f3475dc5b67@motor-comm.com>
Date: Sun, 6 Sep 2026 10:12:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/6] net: dsa: motorcomm: relocate MIB polling
 initialization to dsa_setup()
To: David Yang <mmyangfl@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-3-kyle.switch@motor-comm.com>
 <CAAXyoMNLk4ApuaxxznrPReftf0TNaQEBVF0n4gmuryJxLYdvTw@mail.gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <CAAXyoMNLk4ApuaxxznrPReftf0TNaQEBVF0n4gmuryJxLYdvTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/5/26 01:13, David Yang wrote:
> On Fri, Sep 4, 2026 at 5:54 PM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>> Move MIB polling start from probe() to dsa_setup() so that it can
>> be conditionally enabled based on the actual switch family support,
>> avoiding attempts to enable it on unsupported switch families.
>>
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
>> ---
>>   drivers/net/dsa/motorcomm/chip.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
> I didn't see this patch being used afterwards (and patch 6 seems missing).
>
> I'm not against the patch, but if you don't use it, please post it in
> another series.

Ans: yes, as you can see from x/6, there should be 6 patches in this

series. The 6th patch was not sent successfully due to an email 
configuration

issue. in the future submissions, we will try our best to ensure the 
integrity of

the patches. thanks.

