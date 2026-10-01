Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A93DD849
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848303; cv=none; b=VQJnRA1MrbczN62pEnF0orPa+kPF/KYE7fQCZKaqVOCkw0SqosVxEPlWYaz9ucrXBWZujvMmelwHBERwwiCu0AGd4hJwQYqX01NDbRmxVDPuhfGsLO266JLwe9KOEUGtGLfB7aqwSJgT5dxPC1oqhS1ORBfysyWwByhg80xbTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848303; c=relaxed/simple;
	bh=DyUYWSjK6MgaZMK9avSGahtmwYoV6gO2kWhzvEpqvRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDXDVDdZIMRUwM+6Lw8zffrI0ijd8dteuhrNlL9igRRDHFnlWH5BX074k0zyQzBkvOtnqUHeuC1ycnrm3wsZB9i9Tqs6+ujJcU1UlPMCifzlUL4QOJygra/NU1kP93dQC51tRxcqJJgOqIf1ehn0+QMZfj834OBXENJLV3SyMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnCNNUvu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqV9/Jdd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnCNNUvu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqV9/Jdd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790848301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D79IWv8J/zs86YO1ZW2Rg/OcaP0p4GDv0Nt43J7OBSY=;
	b=VnCNNUvuj3Z/t76M7lzXszacJe1leYdIfvktuh/CaqUdtHaImZa36bJEoIbU4eRhq8k35w
	tE9uUvX09owPrFoP28XzubzmlR7T9LEmWiyOKxdbdMgeT0czV7/AcnyU1Lln7d4t+SRy3Q
	tn3lLmnmiOjUNAEhlwrXxYQwLZLdg3M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Hy4XE1VIMNuZHzbWhA7VaQ-1; Thu, 01 Oct 2026 05:51:39 -0400
X-MC-Unique: Hy4XE1VIMNuZHzbWhA7VaQ-1
X-Mimecast-MFC-AGG-ID: Hy4XE1VIMNuZHzbWhA7VaQ_1790848299
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01d1fb07bso10080835e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790848298; x=1791453098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D79IWv8J/zs86YO1ZW2Rg/OcaP0p4GDv0Nt43J7OBSY=;
        b=iqV9/JddEBNrtZoRy7h0SrijJuj1HMRK9tHsuZMWV0YGQXc8fdNG1bVCvLMcBhqkDn
         Op85+L+FB4d0L5uV1rxA8Wn70xNTunSZYKki03q/Gz5xde8WQFGfNXp2nmOld8lf5+N5
         raGX4OrLY3uj1TACG/E4BEZKNYPQ5/ghRqHVZiIlU54wvp0+HL7YwitiJMnahvYWQwAy
         6KoR6PLzbGqcOUqI3ggzN1opAorc7WjZG+yfw66hLv66/ia6VS/vOZpegGb63x78kdab
         3J6eo8LyITfHjm/SLla10bheKh3/fmIRAJkArP9q4T7oWoaokVhdDvXZCfL/DY8tQjfi
         kU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848298; x=1791453098;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D79IWv8J/zs86YO1ZW2Rg/OcaP0p4GDv0Nt43J7OBSY=;
        b=DSQ5XW5iDTH3PdqJdj3mVR7O2u0Dkj1fjsMH/ZDYyTFqTsOxTO9f7PZSZ1N916exCq
         bDdPPsFNPAHNxea0LLvON076d5zSF8BLuaol+pUKC1vwif8ZZFOLPAxLBVZ5YIHQ9HMo
         kLpkXpcOU3tPHC2e2/sHdsl1rPaSlRm3nAm0wewRrb/V897HNDLg9chitXSWHXkKhHXM
         xxWVWKIiZweQW9O758hpEzUK3ypMNuEhfx8GwCStIF637d1+Pt88TVCVptWzyjuchLL8
         oIyRzESYqvBI7aW8q7tDTuzcSiCSOQh+PShRYxC0OKepFCWVOXCkRdXgZ9aPV/eGOKxC
         q5Ow==
X-Gm-Message-State: AFuF++klwfS2i0sg7C90KQ9BccCOXchn+c2qHZMQLN1sEusdCY/YLsjR
	9jmzfb7Y1D0fd+40oLhPi7esBMPcXXXFZ8XHFgAgl7tbjxmu7CId+f4c9ZjRBkSKQyLsjj7ysEb
	dQ6b9K7dKau/+cSQTwLMfFV5JOL8P/rxh5InyWY61J4IZefE+S/zKOwqllw==
X-Gm-Gg: AYBFou1ano2Sd8J9jnCuP039Qs39lTskMl2JNtw4RFerBB5OhryPAkzMJdCc+HsiZOT
	DcT3Su3FQScaOmFfpq4lk92mhwXasB3eufao6l0MRPwKXXOg2Ww20h6tNNjuaxBTO1g5WX4sz2x
	RbQp7HNkCugvYZpvNmeSBnHjnhwIZ1TjLddtOyRygyLVu6mz1bHvNWWScbfbGJyyLYA9015jSed
	g++sxQwEYngaPeffmiSrGOgV1EXaWhcZNL0tm2z7dmAd/KP2vZ1pnFnrp+7fZCOR3MFf+tQUJ+q
	oBHlzsOo0VOpEUauUSLRYFvWojOUrMhomNfsM1xBIZrKFAv5x/4uwtnftExmTeGJ/l3JVtPF+U3
	QJx0jqrLZlp+WiwxwNMHiyDrRmb2BJkuTRgIQ1eOroNm2+OGoM50RH+BhVDz9Br6RvSxgtPtMCg
	==
X-Received: by 2002:a05:600c:45d3:b0:4a0:4f6:3dc5 with SMTP id 5b1f17b1804b1-4a01affe4camr60814805e9.7.1790848298496;
        Thu, 01 Oct 2026 02:51:38 -0700 (PDT)
X-Received: by 2002:a05:600c:45d3:b0:4a0:4f6:3dc5 with SMTP id 5b1f17b1804b1-4a01affe4camr60814485e9.7.1790848298093;
        Thu, 01 Oct 2026 02:51:38 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f923320sm60112265e9.7.2026.10.01.02.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 02:51:37 -0700 (PDT)
Message-ID: <e11c709a-5d4f-442a-a30b-f244b75715cc@redhat.com>
Date: Thu, 1 Oct 2026 11:51:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/11] net: ethernet: cortina: Fix Gemini RX
 buffer management
To: Linus Walleij <linusw@kernel.org>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>, Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 10:50, Linus Walleij wrote:
> The Gemini ethernet uses a custom software free queue shared by both
> ports. Its page metadata, DMA mappings and fragment references are not
> managed consistently as pages move through the free queue and RX queues.
> 
> Correct the DMA address bookkeeping and synchronization.
> 
> Track exact fragment mappings with an XArray and keep
> in-flight page metadata in bitmap-allocated slots until all hardware
> references have been claimed.
> 
> Serialize queue resize against the refill interrupt, harden fragment
> validation and teardown, then scale the default queue sizes for systems
> with 32 or 64 MiB of RAM.
> 
> This series wasn't so complex to begin with but Sashiko and the other
> LLMs just find more and more corner cases. It's for the better I
> guess.
> 
> Before these patches the network driver would crash under strong load
> but it does not happen any more after. Tested on the D-Link DIR-685
> playing back media and transfering new media using ksmbd while
> issuing ping storms.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
The vast majority of clashiko findings are actually fixes in this
very patch series or pre-existing issues, but I think it has a valid
point on patch 5 (WRT rebuilding ring with odd number of entries
consumed).

Also it looks like patch 11 is mostly against the current netdev
guidance for guard() usage:

https://elixir.bootlin.com/linux/v7.2.8/source/Documentation/process/maintainer-netdev.rst#L407

Thanks,

Paolo

