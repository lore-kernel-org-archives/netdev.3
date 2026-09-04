Received: from mail-ed2-f6.google.com (mail-ed2-f6.google.com [74.125.228.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA94EC664
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535557; cv=none; b=c5brQbmCEDuXSU0MH/rEFMRocucHzXRbwNl4Xq+/rAfh4JJvtJVWAKDzD25DyLYJJYsLJxvXkqoRGL0/Fvl+e+35IR+eeBHtxyDhPmLXSzs0woNYbh2XrhUhY13SxXLRD578NGSrn2Jj+go8ldHd/YU8chG2pbvfP8xJGrAYABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535557; c=relaxed/simple;
	bh=uwA11xGpldNusUPPXSDmqCIE/3tFru/y68UNGN49CRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaFDqN8kQU/flIkdlwcWMOl0FeU/at2WyN1RrqEi4NUwOqI0EvcFgD+42QKYPMX62hGQ8ccuLfrd+clFoIpvhH9E1S8V7r+AlvW1KlAP3tHgY4+Mvn7Xy7eDo/zPqQCQJs7ETlJlS25YgNNgUc6luKr4ur1AMhcgb/rm6iTWuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f6.google.com with SMTP id 4fb4d7f45d1cf-6a5d790cce1so503011a12.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 08:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535554; x=1789140354;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2c5e+nHtuzbJnqE2KltBTaxJCtAo72eyGqyuIvcV1QE=;
        b=aaPOX/cJUIX4efO4/lGnouqm/0hQZAeIXsd0Gle9CfAYDZEKC9VA03ynevgL2StyKm
         v4nXYona/DhELNPxkRiMjmfmMPtXP4SKFICZJqbzWLBv7X99KG+qlYh2GXBHW9TqPfyU
         HAwTZHXtIY6G2v/p1gtgzv3D7tZCY96l3EW4NYwN2NPDVL52Jf0UveSCDxU5i4u7vhlb
         JRqZalesy33NyrI+uK+/yxPeReziDsxHPGWyQPxIffNkRdr4qig9iZuwfdrHQIDduBED
         W+XBpZy62jt17Fwwn5oCKIWZt+I76xu1NW58z744Lq39vGGJCj+dIfJo3Dkl2YXp1Zp3
         TtEA==
X-Gm-Message-State: AFuF++muuW/vEapedRAOHdSV634p3ivBIVqlbP7NUPnMzzOMu8CJ3LsC
	fiVklTokWJC5HaRDkWjFwrCd4yOXQgDTyEann+clW70aFJfXRUhJZZIy
X-Gm-Gg: AYBFou03HXiagfPPttze/NUb271jDok7jkcRUQHNin8Jedyc6a4kQZuyua4k5MzFCP6
	wZ5c0n/JfoLRtNdRa6HnYNbNa5naVDVVgIK3bpnwp92H6VQPRQrA3PAb+782g3d82aMc7VMKs4/
	8UdJ+qMuPw3yy/KsZSf7wfOURujtX6njeQU0rCtpowU3mcbCtzAp5phY1ItCALYUDa7fgQiolrG
	z+zzS1Qm1rHPGax6/hdnPGeYVzdtePyG8ulGrkPOavkytuYRpN5w2vdZ4nBv6sXingbc+NjPvhp
	XCoiT1pegUrhE5a2NUJbo+Xvtk79z8uaHGUngQC61WRlFMeh89Ne2Ox2G3/StheYM+fue3Jrtt+
	4Lkal0ZsJVQkI3VSQF7lghCFEO6Eu5aDE9/Avp3IXUdBp+CyAXK/xlVEFIgyTD7k+GoF5jObxDm
	w3diKBnzb7ULyoHjwUxYO3kiTUGnvruba99adUqnZTxP+C3udxSBvvIiFX2b9RjYVOlakxk5Tqi
	wgMOH+2w0xG5Q==
X-Received: by 2002:a05:6402:234d:b0:6a5:d8f0:dc10 with SMTP id 4fb4d7f45d1cf-6a7e8d947b4mr2462017a12.13.1788535553604;
        Fri, 04 Sep 2026 08:25:53 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9a56sm5900483f8f.15.2026.09.04.08.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:25:52 -0700 (PDT)
Message-ID: <275ba183-49fd-45b1-881d-0f362b4c74c0@ovn.org>
Date: Fri, 4 Sep 2026 17:25:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] Containers to run Netdev CI tests locally
To: Matthieu Baerts <matttbe@kernel.org>, Ilya Maximets <i.maximets@ovn.org>
Cc: Netdev <netdev@vger.kernel.org>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
 <dc460046-82bc-4c20-870e-716dee54a6cb@ovn.org>
 <e6d815d3-ed9b-4904-8cbe-8e5ee226661b@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <e6d815d3-ed9b-4904-8cbe-8e5ee226661b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 4:54 PM, Matthieu Baerts wrote:
> Hi Ilya,
> 
> Thank you for your reply!
> 
> On 04/09/2026 16:01, Ilya Maximets wrote:
>> On 9/3/26 6:19 PM, Matthieu Baerts wrote:
>>>
>>> A wiki page has been added to cover this and explain how to validate the
>>> different tests:
>>>
>>>   https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally
>>>
>>> To help developers, containers are now built, packing all the required
>>> dependencies to run these tests in order to run the tests in an
>>> environment that would be as close as possible to the CI one. The goal
>>> is to have an environment that is easy to maintain -- no heavy
>>> optimisations to reduce the images size -- but also easy to use. In
>>> short, people (and non-humans) can continue to use the different tools
>>> as before, but add a prefix to the different commands to execute them
>>> from a container, e.g.
>>>
>>>   alias run="${nipa}/docker/selftests/run.sh"
>>>   run vng --build
>>>   run make headers
>>>   (...)
>> The headers are not used unless the USERCFLAGS="-I$(pwd)/usr/include" is
>> passed into the actual make command for the selftests.  So, uAPI changes
>> will not be picked up.  Would be good to fix that in the wiki.
> 
> I think setting USERCFLAGS is not supposed to be required for this
> purpose: KHDR_INCLUDES is there for that. According to the doc [1], each
> target building binaries should have "CFLAGS = $(KHDR_INCLUDES)" in
> their Makefile. If KHDR_INCLUDES is not set by the user, then lib.mk
> will set it to "-I$(top_srcdir)/usr/include", so the default directory
> when "make headers" is used. It needs to be adapted with building in a
> different directory.
> 
> At least, when validating all net and drv-net selftests on my side, I
> didn't need to specify extra CFLAGS. (I think the netfilter target is
> missing KHDR_INCLUDES, I will fix that.)
> 
> Or did you have to do that for a specific target?

I was actually having trouble with the netfilter target specifically
as I'm working on a patch that changes uAPI and the selftest build
can't pick it up without the USERCFLAGS.  But if it's actually a bug
in the makefile for that target, then it's better to fix this target,
of course, instead of changing the docs. :)

Thanks for taking a look!

> 
> 
> Just in case, here are the recommended commands to execute to run the
> selftests per target:
> 
>     alias run="${nipa}/docker/selftests/run.sh"
> 
>     rm -f .config
>     config="tools/testing/selftests/${target}/config"
>     run vng --build -v --force --config "${config}"  ## + debug
> 
>     run make headers
>     run make -C tools/testing/selftests TARGETS="${target}"
> 
>     run sudo vng -v --run . --user root -a mitigations=off --cpus 4 \
>         --rw  --network loop -- \
>         make -C tools/testing/selftests TARGETS="${target}" run_tests
> 
> 
>> The $(pwd) part is a little tricky since it will be resolved outside of
>> the container.  I didn't try if that works.
> 
> Note that in the container, the current directory is mounted at the same
> place. So $(pwd) can be used.
> 
> [1]
> https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details
> 
> Cheers,
> Matt

