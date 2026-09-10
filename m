Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB73E1701
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033420; cv=none; b=HpvREBGFSZBIGPQWctVE+RmdPILyvk96/vipiXwBErKIBpKraihxB+0dN5McQJEPaXbh++bh91ceHef5PGeOROL2GwcxMGcwcJI7kEmDLVvURVp4dM4FcoVTFE8Ig/loVkPRIIC7vxc5EFeAOWt7TdMGMG1eppbU9VK+5wa7BPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033420; c=relaxed/simple;
	bh=KnS4FREeAKzpHL8fFTZa5rjNeAMn6U9PigOahw3tm9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCTagFegQeHq0hPw7q/DFZS0Poy+pgM6C70YBTXp5nOTImOQj6k0ig5v7J6oLAUtkGW16GiPSptx9Hrg2DXCVyEv9ISRkmPmRL7syOaVOraYxcKc0dV/mxTkXme9XZEjhfHSTOCKbb/zXnwwFqDvwvwXgYEwf5qFKNg5ZHOY58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SI6PwCXk; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SI6PwCXk"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KnS4FREeAKzpHL8fFTZa5rjNeAMn6U9PigOahw3tm9s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789033407; v=1; x=1789638207;
 b=SI6PwCXkC1akEW66K7nj/nSDItlzqc/zNXEBhaycSP6a5qG1RSmqteUxDI4BzptTdAj310Zl
 gLU7iseREFdm69afWBD432Qv1s4FxbZWMzIN+OwYUw7pGiYXAoWyl1W5rTRx47K7kwGoTNLcM6b
 eS28VOij3fD9lBCqdHtM8Wmc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f283204ef0f696d7;
	Thu, 10 Sep 2026 09:43:27 +0000
X-Mizu-Trace-ID: f283204ef0f696d7
X-Migadu-Flow: FLOW_OUT
Message-ID: <95330c25-d5ed-4e5d-8f62-528df543f8f3@linux.dev>
Date: Thu, 10 Sep 2026 17:43:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf] net/sched: act_ct: set net pointer before publishing
 flowtable
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: netfilter-devel@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Oz Shlomo <ozsh@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260909075606.1508155-1-qingfang.deng@linux.dev>
 <fa0181b9-d715-41c6-8086-af410ee4131b@linux.dev>
 <94103430-c2e8-491d-880c-c4690c5e3f98@linux.dev>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <94103430-c2e8-491d-880c-c4690c5e3f98@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/10/26 5:03 PM, Qingfang Deng wrote:
> Hi,
>
> On 2026/9/10 14:09, Xuanqiang Luo wrote:
>>> nf_flow_table_init() adds the flowtable to the global flowtables list.
>>> However, tcf_ct_flow_table_get() sets the table's network namespace 
>>> only
>>> after that call, leaving a window where the published table has a NULL
>>> namespace pointer.
>>
>> The window does exist, but can any existing code path actually read
>> flowtable->net during this window? Could you also describe that path
>> in the commit message? 
>
> There's none. The patch is a preparation for:
> https://lore.kernel.org/netfilter-devel/20260909081705.1512600-1-qingfang.deng@linux.dev/ 
>
>
Thanks for clarifying.

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang
