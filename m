Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908C3A873C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667853; cv=none; b=d4gKNHdFr7Ea8tnS7VFJp+rLhiEB3aSxETRG/AP8KLD3Nh+kHyWlPOVhFNQaTxhX8VuYkx56QcQbUQlmnwAboz2H7rke6xwy/8UGSkqOfbi7qwUTLawm6BI4dw7Zu8XsgJlcwwgx39AakwEiXG3F76oSn/007rYDad5m3d2E9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667853; c=relaxed/simple;
	bh=Z4HLh6x3TXcq+IGnxeku780VsScevwodu7+asM0q/T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOrBJI02OX6jSe8hOjin85UpSIiOJr5/qRkOzYoVaK+/Ce8OyLc/GFHIveb0kNs/uNVTk3nbw4HgcagzD+gy0/ULfMz8LyV3mHGTPsgiMqnR09n1Sho5mvLJMPLfi/GAvaMdyIFsRhlyotGHcpzXjYj/wy/Nla2478QxkJm57WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Kgrprt3x; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Kgrprt3x"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so21721365e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790667848; x=1791272648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1gEgNNUIuRxKLIUuOnRgjSxzo/gFqBNwHA7M+ft3uk=;
        b=Kgrprt3xIEi88LSlwEl4bEeWiWqwhQcSDkO9yh/4czZ1Niy/r3CRXfku8tnjRYAybl
         rxr2WMakOwvAymGqfJhnnLXdU2q1owhpyRi/wS1JKPMcuhPgSLSavmtsU47RGmEo2+O1
         YYiVpWYaITkuytw45eqHt0f4+CHShiFHg8Av/uyCBzWzOrpUW8/50g/tbqLZNvEkybz9
         8i475JTV2csBUs+DtHnEDbep6b+XFTeo6vHnx9aI87oUoAVIPd0HpzPyfSHCRtEkyebM
         IOHJZkQbBV9UAagjq+IGaulX4uBgSdral00s+dlfNSDi3U1Itdd5JtaVevFQTbwPCPWK
         eiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667848; x=1791272648;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1gEgNNUIuRxKLIUuOnRgjSxzo/gFqBNwHA7M+ft3uk=;
        b=oGOKqUf0lh/irmG/O4J9nsGu8SxJ3KLLphKNZ5Sz6LOq2pl5Gu66y4OMwBnCsmIf6j
         vvyCQIHWP5U2LenzYbid6g5SzZDULl65aDmWr8dVVzTQFGUAqey8wzJnap4WaWcIEaTw
         aj1D5PhtZrhqoLJqJF4Iu8bYRd1fvdCszTPprLf9Sc4WHLj1ka6eO1hUvLGVuYxVw0Cb
         41sOvGRZgK557ey8Z913Dc28ONbIkOQwkaDgOYpl/HUHgPoOx8dQWhwwTQnbeAlA7hVf
         OEArGovJ6jru62sG3d8jdgj5pDHCqbOFWHsMO/7afSFC8xrW0Ko5pFroP5QGp2dcr+IC
         0vhQ==
X-Forwarded-Encrypted: i=1; AKwUvBy48R3ZuFk7WiY6ehZgHgaWnJt1Fxqu1Ba9ipjQy0mtfxQDs5BK18BrxmbYnkc62aI7XlDUd04=@vger.kernel.org
X-Gm-Message-State: AFuF++nfpn3PNlDSM6BTp2yqE/SE1Mncsxu+4yKMbCdoVeJ9sjt/w+Kr
	AB8038/1LsL9cnI40o+mksgfPrJiuP6A4RQoRXEfT1QnXGelt/eJCJQgUn5bPmf9Z1A=
X-Gm-Gg: AYBFou2q3WbaC4lXR68OWusP6y3oJAPeDvxvPi1GGFKXDo3CvxtSviPwvMQkzqqABfI
	mBFfO79Ya6fcOiRf+zqunC5ZhbTI33/cA/3AF+PoEly/6iwUOQYGHtyDSE6/z47RzsINehqihT1
	tw//W/7eA6LTYWxONNuNvApAyQw353o1dLYjUficzHcY3nhmaf5oB8mWVuJ/m/mTRJmYuS7MoST
	LcpRkAMC4L5aqtmurPo+phh0Z0KL2kGx3+pMvBhfy4DtN74QzeIaQnYzD3R26UPgr+jKIlyatAX
	QxCfUcXOVxVECLu53J9uF2OXVTRKaMgPS1v/b7ChZYV5HFjxsGjI3uSa5Y2pXxKartM4FNTNSlW
	OtXYby89HD82Z+Z+qPmJmHFgPCIU1MqrG+Z6aXckoktJOCmkiUUBxt3hfSD0msFArfHIjEhEYbA
	N5k+y7/LIRkRgpETKrQ9KLb66rqsDjYSK4QgfAHXr19prPNiJmDq3rWYPcil39DYirygvVDHBMR
	4HqQPkj+MSNtmGmbNCh0Z1TOpB/
X-Received: by 2002:a05:600c:870c:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49fe66d76camr258621725e9.15.1790667847789;
        Tue, 29 Sep 2026 00:44:07 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d45ce1csm37147125e9.3.2026.09.29.00.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:44:06 -0700 (PDT)
Message-ID: <b8ad269f-186a-4279-887d-60ef9968025f@blackwall.org>
Date: Tue, 29 Sep 2026 10:44:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/1] net: bridge: avoid recursive multicast cleanup
Content-Language: en-US, bg
To: Zixuan Chai <petalzu987@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Ren Wei <weir@nebusec.ai>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vega@nebusec.ai
References: <cover.1790323012.git.petalzu987@gmail.com>
 <156c41b1-fc86-4ecf-8181-461944734be9@lunn.ch>
 <CADTzadLbmd5E73RG16kQ1rFmwYESNuQqgc-JCX2RVhY0FRh8nw@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CADTzadLbmd5E73RG16kQ1rFmwYESNuQqgc-JCX2RVhY0FRh8nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2026 22:35, Zixuan Chai wrote:
> On Mon, 28 Sept 2026 at 00:31, Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> On Sun, Sep 27, 2026 at 01:04:38AM +0800, Ren Wei wrote:
>>> From: Zixuan Chai <petalzu987@gmail.com>
>>>
>>> Hi Linux kernel maintainers,
>>>
>>> We found and validated an issue in net/bridge/br_multicast.c. The bug is
>>> reachable by a non-root user via user and network namespaces. We've tested
>>> it, and it should not affect any other bridge multicast functionality.
>>>
>>> This bug is tracked at: https://bugtracker.nebusec.ai/f/4342
>>>
>>> We will provide detailed information about the bug in this email, along
>>> with a PoC to trigger it.
>>>
>>> ---- details below ----
>>>
>>> Bug details:
>>>
>>> When an EXCLUDE (*,G) port is deleted, br_multicast_star_g_handle_mode()
>>> removes its corresponding temporary STAR_EXCL (S,G) port. For an (S,G)
>>> entry, br_multicast_del_pg() then calls
>>> br_multicast_sg_del_exclude_ports() to remove the remaining automatically
>>> added ports. That helper also calls br_multicast_del_pg() for each port,
>>> which re-enters the same cleanup and adds another stack frame per port.
>>> With enough ports, the task hits the kernel stack guard page.
>>
>> What is the value of "enough"?
> 
> Thanks for your review.
> By "enough", we mean 151 temporary EXCLUDE ports in our tested setup.
> This is the smallest number of ports we have tested that triggers the
> issue.
> 
>> We get lots of bug reports for theoretical issues which in practice
>> will never happen. And we get some reports for real issues which can
>> happen. You are more likely to get your reported looked at if you make
>> it clear the issues really can happen, give todays systems.
>>
>>> The PoC uses unshare -Urn, creates 256 temporary EXCLUDE ports and a
>>> permanent INCLUDE source entry with IGMPv3 enabled, then deletes one
>>> EXCLUDE port.
>>
>> So a hardware switch with 256 ports is on the high side, but this
>> could happen in an SDN setup.
> 
> We also believe this is realistic in SDN and container setups, where a
> single bridge can have hundreds of virtual ports.
> 
> Thanks,
> Zixuan Chai

Noone will setup an mdb with 150 ports, sorry but it is not realistic at all,
not even by a long shot. I'd send this for net-next.

Either way the fix is small and looks correct.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


