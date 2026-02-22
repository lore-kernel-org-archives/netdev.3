Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5B4414
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771744612; cv=none; b=gZL/WkLy1UAawmPKVdL85Fz3kRUHCCjzt4gbDXsyzJnk7iGSjm5B8AACik2/LG14ITku7Quq4tpamQSxYNcfWavKj62p1Lv2pg/ncVVjorjv61fc4T1azAZoKG8vdgzOjyMX/zppJUdAKvI4Yrddy5ZjPjER9WJsUFjKad8Ijzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771744612; c=relaxed/simple;
	bh=lPLuJKp5nsL3nlb4YapG/s3ZZiFeV/WY0yUDorV1ewM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uM/fes2ft+2fqAred6E55wg7v/LRF/0WeNx8qE8gJZtEP/YI8C8IyiZYIlAlW9/akzkt9/3OmeNAHWS4et0yzRI5tKt5tMZRL+kgy5KiFiCDyflK2kHvkMoHCEig4EJWkskydp8+70ayrsu0fvLARkoucA4K/AjuUJqehNFYUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61M7GgCs023969;
	Sun, 22 Feb 2026 16:16:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61M7GgGi023965
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 22 Feb 2026 16:16:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <14ed1845-370f-4b28-83e2-d8424db3ab36@I-love.SAKURA.ne.jp>
Date: Sun, 22 Feb 2026 16:16:43 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] team: avoid NETDEV_CHANGEMTU event when
 unregistering slave
To: Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Network Development
 <netdev@vger.kernel.org>,
        Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp>
 <aXl_MwhS9AJXTYi4@mini-arch> <20260129191243.767e3005@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260129191243.767e3005@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2026/01/30 12:12, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 19:14:59 -0800 Stanislav Fomichev wrote:
>>> problem. Ido Schimmel found steps to reproduce
>>>
>>>   ip link add name team1 type team
>>>   ip link add name dummy1 mtu 1499 master team1 type dummy
>>>   ip netns add ns1
>>>   ip link set dev dummy1 netns ns1
>>>   ip -n ns1 link del dev dummy1  
>>
>> Can we add the above as a selftest to
>> tools/testing/selftests/net/rtnetlink.sh? I was adding the quirky ones
>> (like kci_test_macsec_vlan) over there.. Or maybe something under
>> selftests/drivers/net/team/ ?
> 
> Under selftests/drivers/net/team/ please, rtnetlink.sh is too much 
> of a catch-all.

This patch seems stalling. Who is supposed to create a selftest?

