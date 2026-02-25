Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093836AB6E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014131; cv=pass; b=iJnlLrkL773grSCu1t/Rlf0icsNosSUEYzTGEd43EvIgFAJUUIFSkIFlRAyYp3wySLtySFWT9LwUSRyOKnphjv1YlPlRHNNdQlkmpOrZ/l6cEhe30vw6yOPMK7NkS+j0EBjziLSK+3dJfShKZJjhBw6MbqgRAp9EsL9KXTyrU+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014131; c=relaxed/simple;
	bh=5Llf5RGVS2PiWoAHFoZm534nyJ1n16ycopcrG1faZG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aoff1rQEJtkLsXh6hzEIidGW0lhcglz+K/u61eOj0QeZPILC8HEDDPE0yu+exDRwvzor0JCQTnPWAACA6uEHZvhAQDfAViMjz+IyyBtlgRTwvsGGceVCkI36Z4ftN6rG7G2x9lPnyA3malGavvuCukStOObLff0H3LgVeAbaPzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=P16e9arX; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="P16e9arX"
ARC-Seal: i=1; a=rsa-sha256; t=1772014117; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kmbKwntLDyFMMeW508Xh3TWkv3u/RIylZdNADPPzFHAHr6xO8I5tBQ1tLsc2IIOamVT9pS5zTNzmZ39W6mx69RS+AT7DR83iE99nlpD9bbQ8HwD8xACJzOnffkV5ao5IDoWFU4WjOv94/qv/Og2A2MyDbegoqs3Ur7QVopQzYdo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772014117; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CIIwU/d6neXz6Y/1lzLpEUmJXgdo+J8pyN5mwzubunI=; 
	b=hJMm1+GbY5NaYpYoNuAVi3fQrYzr2jG62hwdjoQmyR/7jERyDz8lN79tREusRxSpSYEXCBBBHVfajMaiIybCi8NgUF/AoR+8avrhBk0CJOSzA9xzWT7HgZ85S+U2vXbl7nb4C4bYihgOgX0JOgM+GkHjZI36ehgofTbm8f7cFYc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772014117;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CIIwU/d6neXz6Y/1lzLpEUmJXgdo+J8pyN5mwzubunI=;
	b=P16e9arX4NrBc8h9kX372dD9MqiJjKwXLMXjscYcHO2KwosU3BNFncu+NRU+znur
	F2cn0tYl/9N/TugzratK8lVx2LanBlDKDcLMFQYxIGj/ARAXDEekXK/6eZ28CpSWl3p
	KrmKHtUpg35Nz/kdA/9A9x3tf/4sBC9fKesWRjFUx7b2S0qRadFf07j+TZ0MISlFn+d
	r7xFMpaErS6Q4ERodsZilrYa5yUpr2oSNjxqrLcrSauaVkhkTVB+9mUKUXWXoOGPcUB
	JUhZpNX4f+++ttuKgds7MYnB3TB3lrUWROCcU4hMGBO6WV5nn0x2a1MOSA9xTsH13F1
	A9JKSi0RTA==
Received: by mx.zohomail.com with SMTPS id 1772014114658259.36757652459517;
	Wed, 25 Feb 2026 02:08:34 -0800 (PST)
Message-ID: <4358a42d-e382-40e4-8bab-34c9f0faf1b0@machnikowski.net>
Date: Wed, 25 Feb 2026 11:08:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev
References: <20260222094110.127927-1-maciek@machnikowski.net>
 <20260222094110.127927-4-maciek@machnikowski.net>
 <aZ2DYSitNqQwkqCu@horms.kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <aZ2DYSitNqQwkqCu@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 24/02/2026 11:54, Simon Horman wrote:
> On Sun, Feb 22, 2026 at 10:41:10AM +0100, Maciek Machnikowski wrote:
>> Add PTP synchronization test using ptp4l and netdevsim.
>>
>> The test creates two netdevsim adapters, links them together
>> and runs the ptp4l leader and ptp4l follower on two ends
>> of the netdevsim link and waits for the follower to report the
>> synchronized state (s2) in its output log.
>>
>> This implementation runs the test runs over IPv4 link.
>>
>> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
>> ---
>>  tools/testing/selftests/net/ptp.sh | 93 ++++++++++++++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/ptp.sh
> 
> Hi Maciek,
> 
> I'm wondering if you could consider running running shellcheck over this
> and cleaning  things up a little.
> 
> I see SC2086 which I think can be trivially addressed.
> And SC2329, which I think would be best ignored using #shellcheck disable=SC2329
> 
> Also, I think you need to add ptp.sh to tools/testing/selftests/net/Makefile
> 
> Thanks

Thanks for checking - will fix in the next revision
