Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8939379C36;
	Tue, 21 Jul 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642883; cv=none; b=sTT+oViaQD12nzcym3QoKjgzr3FNuAftQ7F+ZDODskwbXdpCQIGp97+K3tj/PRI+7NF2GrkGyA3AHA1xH2paPSTvEq2yPAaNYz09qyiSVroL8G3tPgHiQBUs5bcLxo22vc6QYGPrUnZ3aRF0F1tRGnG1+IvW8qx6N/Vf+TofWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642883; c=relaxed/simple;
	bh=N1LKOqLFTOBSOUTDuX/e0IyhD0wJrThFp1keQVautug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h2ZGVFSFkgsuD3Na1wa1Wao2RYyQL91J/sNXHFLa5+jMOCA5tt7mavrzm7mno55YJBFuuxqjpjWr8y2J+98c1X73xBVQN1ZUeLiJAWo77R6SN3MmN2p7iFIa8s2xr5+x7D3UgkkBNJ+qnmWZTsnrAUXOFClzfSGUUdaznvz/zmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.204] ([129.217.186.204])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66LE4XV1002729
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 16:04:33 +0200 (CEST)
Message-ID: <5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
Date: Tue, 21 Jul 2026 16:04:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
 <20260714092506-mutt-send-email-mst@kernel.org>
 <5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
Content-Language: en-US
In-Reply-To: <5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 18:50, Simon Schippers wrote:
> On 7/14/26 15:40, Michael S. Tsirkin wrote:
>> On Thu, Jul 09, 2026 at 11:55:11AM +0200, Simon Schippers wrote:
>>> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
>>> when a qdisc is present") did not show a relevant performance regression
>>> in my testing but on Brett Sheffield's librecast testbed it shows a
>>> significant performance drop in a IPv6 multicast testcase. The regression
>>> can be pinpointed when multiple iperf3 TCP threads are sending. For 8
>>> threads the performance dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is
>>> the reason why this patch makes the qdisc backpressure behavior opt-in.
>>>
>>> One option to accomplish the opt-in would be to set the default qdisc to
>>> noqueue at init. However this may also break userspace as users might
>>> have chosen a custom qdisc even though most of the qdiscs did nothing
>>> for tun/tap in the past due to missing backpressure...
>>>
>>> This is the reason why in this patch, the flag IFF_BACKPRESSURE is
>>> introduced instead which is required to enable the backpressure logic.
>>> This means the stopping logic in tun_net_xmit() and the waking logic in
>>> __tun_wake_queue() are skipped if the flag is disabled. Setting
>>> IFF_BACKPRESSURE makes an attached qdisc effective by stopping the queue
>>> instead of tail-dropping when the internal ring is full.
>>>
>>> To avoid a possible stall due to disabling IFF_BACKPRESSURE, the new
>>> helper tun_force_wake_queue() is implemented. The helper safely wakes the
>>> respective netdev queue and resets cons_cnt while the consumer_lock and
>>> the producer_lock of the ring are held. The helper is run in tun_attach()
>>> when a queue (re)attaches, in tun_set_iff() for attached tfiles, and
>>> in tun_queue_resize().
>>>
>>> The documentation in tuntap.rst is updated accordingly.
>>>
>>> Fixes: 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present")
>>> Reported-by: Brett Sheffield <brett@librecast.net>
>>> Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/T/#u
>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>
>>
>> The patch itself is fine:
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> What bothers me is the timing: we
>> are past freeze and this new interface hasn't been tested
>> much.
>>
>> We can either apply this, or revert the original patch for now
>> and reapply with this for next.
> 
> I prefer applying it, but you maintainers must decide that.
> 

Hi,
just a gentle ping.
Has there been any decision on this patch?

Thanks!

