Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09E2C1595
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778137392; cv=pass; b=i9AScQ0iFqWwryeKoGd9+JBAiH1xE0BnlHK/BDZlTCJcoYCEvAfXIdBDbizuRqAuRmxasy+GhKeeJZEPzw8XfGPQwqAY0Z4ylFvrY+YcMjp9xR96kwYdf4i+Vq45COLwsQE3tdOhNgK7AlFCAp39Ip95mK+nDuWUYZz8XxD+Er8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778137392; c=relaxed/simple;
	bh=mDhpB/4FHQMxUDn90ROjmmb/bGGMEoDM5rFMKrxCxKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY6qvAmIYRTmp2Ho1JFwCEWnr/rdRkEqNcd+jlQhbziwQacEAqyDU3/GTl8w0lOJLtBAwpiXzG1OVWqeG+nKql+mC6RXh8nCQEoSqOLjB2VQdiKi0hL3OaTTImZyPcYEpyy4cspe7qkepDIQ7E6msWo/a0g8AZQTBxb6IK+L+tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=FJhTFnSZ; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="FJhTFnSZ"
ARC-Seal: i=1; a=rsa-sha256; t=1778137345; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e8FMHnwvwH+ipvZgHxoT2Fn96no8jRShXyd0+P/Au6HEiEa+AontUCQq15qJbBzWZuM254vB+xwsl/ZmY+8/J2ky1diY62baAhxgVnkDOYx5fKEffU4FebwF1KHG+rlWAP3AxVeyITdlMK6TNs6zk/tDBRA+GYEOvShWYBc5434=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778137345; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0AERZpg3tETOo2ZU4BRa+PVnTK6FVJaVPPbdKY10JYM=; 
	b=Ef0+GgewIF3ADqXORnYq7RKYbyqG1pUm7Wa8B6p+W/i56K/SCUbaU0BGM9zL229/TjNwltidxU5C4ZAdPCFBxwdwEr1LHtCYxelobJXroSabZ+voLCq5xC4YCScdWm2Vhnk57OEn4GEtex8oR4UhyNHDWxW/ZfJrn01KP3xeuew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778137345;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0AERZpg3tETOo2ZU4BRa+PVnTK6FVJaVPPbdKY10JYM=;
	b=FJhTFnSZ8PySMhTWUcAqseUqApvPmHrO76XIIpsL6TYC30DuFfEilfpeTg1w2LMv
	Qj8ZUDDDt42aVGpKnNZZDtk7j8PE/O6/HV8ZIo4Bh4mUGhlvVwD7VdLbdvQ86rACyDq
	9YldehJaHsYnU2zCgF4VM7ZxHToMe17bx3F5Zt4wtCtNG57kOJFQr8M7GaQbRJ1TloK
	y1xItdVu2KWQ68zq0bAcYmUaRtpsYK/9+TvEhZoafHtmxp7qNqAP1I2gx0oOX4+XrJW
	PZjXf8gJG9BGznFgtBF2qIPchRRYs2XYO0oHvBEcrxk9ojVQw8skJfLG4xSaTHfL64U
	2xAl5+BR1Q==
Received: by mx.zohomail.com with SMTPS id 1778137343077234.6737738060233;
	Thu, 7 May 2026 00:02:23 -0700 (PDT)
Message-ID: <b61b5b7e-db0a-4a3f-af65-c834c23a410e@machnikowski.net>
Date: Thu, 7 May 2026 09:02:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev,
 horms@kernel.org
References: <20260503074747.1321-1-maciek@machnikowski.net>
 <20260503074747.1321-4-maciek@machnikowski.net>
 <20260504100753.7cc193cc@kernel.org>
 <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
 <20260505172234.3348a81b@kernel.org> <20260505172317.089fb380@kernel.org>
 <7fc0a457-7153-4b22-b3c9-2c6298b75d73@machnikowski.net>
 <20260506150725.14c82e23@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260506150725.14c82e23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 07/05/2026 00:07, Jakub Kicinski wrote:
> On Wed, 6 May 2026 13:18:01 +0200 Maciek Machnikowski wrote:
>> On 06/05/2026 02:23, Jakub Kicinski wrote:
>>> On Tue, 5 May 2026 17:22:34 -0700 Jakub Kicinski wrote:  
>>>> You have to add it to the relevant config.
>>>>
>>>> Please read: github.com/linux-netdev/nipa/wiki/Netdev-CI-system  
>>>
>>> Sorry, wrong link, this:
>>>
>>> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style  
>> I did follow the guid, ran the test on the vng environment and it still
>> passed the test. Is there more debuggability on the CI system? Can you
>> share the .config file it generated while running the test? Or the
>> commands it tries to run so I can verify them locally?
>>
>>
>> The commands I ran were:
>>
>> make mrproper
>> vng --build  --config tools/testing/selftests/drivers/net/netdevsim/config
>> vng -v --run . --user root --cpus 4 -- tools/testing/selftests/net/ptp.py
>>
>> The tests were done on the ARM64 Fedora 44 with the default kernel
>> 6.19.14-300.fc44.aarch64 running inside the Parallels Desktop VM.
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/631241/config

The PTP_1588_CLOCK_MOCK is not set in that one. Seems that options from
tools/testing/selftests/drivers/net/netdevsim/config are not correctly
populated in it (CONFIG_NET_SCH_MQPRIO, CONFIG_NET_SCH_MULTIQ are also
not set, CONFIG_PSAMPLE is set to m, not y)
