Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EEA3ACA46
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789769222; cv=none; b=jQ9ACXp40ufR71WbCzEIbyM6orb1BmivrrFcFsYyq9oBI9bmJema+sf78B/Qbi20GCcToe2pxyEm+d4fFpCWMwJaUSapLxPg7yil0nTJv/2lLXRBsAN7vjgYs79t67sf10ZGZuFIA8BqgcqFCh7rR5MucDVwi3q7e1RJJSagGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789769222; c=relaxed/simple;
	bh=zM5Y2NSnQJgXkYJgfw/V2o2/jB8P741YWkZhLF7S/ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEI285KJs9wH3GCQFccL4gOaZ9JOUOeqjsOcqR62dg6SDecDwCQ931z/TN0C8jqwG8QThblK+j3yTiDZvU5BmNkoKwFHa1ZLe2C16UbpNG0oNV8hgaJ8R/IV1GCRQzVAD+BobasULvGjGjaq0cyoJgID8lR/4Fjfn57+BI7loP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aomASs4c; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aomASs4c"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48436686a40so149334f8f.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789769218; x=1790374018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TM4goNfGGn37pgGZYvDbHfViCjUw8jP8fyZOxNwc+fY=;
        b=aomASs4cNrjsfMFvXw902Fodm0nLrcQ8Q/4LBoJCJt/BS0l2Adv21UMCFuiVHBND4Y
         Wwuw+RMnYgkwNe3mZVap0oz4twLpODxb964zFxU4kwb6IAE0tUUKZzmGLXskhPVkJj4h
         EmKZd3UvSkd6dHRrLMy85Fn0X9nINMjbC0MfqnpfbQJPMVCYVMNMHsXFK5AWJ9cGKaw9
         cWaJ/vYt16hJQTP8c71fidKuVk8CzqWiiVafRGUcXq7GePGpVJQyUX5LbzpIqzfuMkir
         R26zCXeTbkydykGYYhXJl9oRkTD4FgctSZdrtHeefvvFnt5VmOTvJ1eXTdNp7h8yhmW+
         imwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789769218; x=1790374018;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TM4goNfGGn37pgGZYvDbHfViCjUw8jP8fyZOxNwc+fY=;
        b=hQYAm8x/q/rwopHGNlHbj5tXxSQW+vdm0j1cuWuG+nriLuJ41Il1F1mE5xbVYcw/j9
         C7OhGc1RcuTzKgmA2oSHUWzAbtOgFjDsuV1PfIdJkRlGX66nfoNTG9gDPbXng5ISQo+o
         hwz4dLJnQJVdXhtCjvtRt4oQKojfcGCBJ1oxoTOxWkUPTIrWhPyPOS/TbLT06/STVOF0
         +UIE0khlXrWCeNQKQQL6De6+/XpfKntl7ft19xivOS4S6CxNnvvoaHplH7rkVhQ87i1B
         wQDcCMgwMFFclrkFY8rqBgxXqI3EgAq4Q88N8AIs26nlc8y2w+lD1r1JfBMlJt9NZu9K
         VCSg==
X-Forwarded-Encrypted: i=1; AKwUvBxgNsJ7LzZDLbB0lNIY/xy+Vh0NsfEwHpWBuqo3r0XT/8FHb3nkn8g6Y+DCU5mkCvItT9OntuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kn0D7siirax6dv70gxf5mz/5sumVbiFzaIGAnRBeg2T/0T9clq
	8K4UQfYdAcKzEKYeFJRPCtploBpkSN+JKIFswROy74w0VBZLMLG1XQZU
X-Gm-Gg: AYBFou0uX0JYtmSLLjSEMzUztjfYmogYM1SfuGl5g6ZpJ8kDzrCEHy+ypvxhHTfz4w4
	rYAyAGvuSpwPLRqX1ZpdDjH3whj9BpCt9mCNBOFwMoEpbCrR8q5ZFeVAnlaGLprijAQT/3NfYDc
	MCxm5HABSnue2LY9vEyrEL8gz3ZG8cSho4H0hGua94Gl2uZeHR8LHxjSVLHgH20t0pPJEKGXQJR
	w0PgWxveuxbRVh/++krJ5/ZDROqP3BZT85Ec7X60bdqvaVUMhgCjXaDGlHhJONtZ+ZyRLtuZvmI
	fvIkm3h7S6q4bMQotRKMTCjgoHdR3uKTwnfTZug9bCpY1U0xfG+h6SPtUwWy7S9Dv+ffYXmipbS
	gmFO+kRgjVwHq4rYTs1+b0ZOmM/NoRvlMyxSNmpYqid1xXpYvj+lRCICUkHpqkb11R1MfccJJ9u
	UNqiLkesZ/z+3qRd48JadEZVWcVd5VP3GnR8mQVmIrGyiEbC56VPG/LfhNbCK3k1QAdcQlaz4mA
	KKN3cfr6gIlyZLdb4MKJK2SG9992YUdfBeDuqNsDxdS7D8/KC+loL2iNJ4bjeDQnBsfAwABRU1/
	UZ/iBJe7K4VPCu8GKSdzc63Bbcj7GI2lmhjJkqM3ZMFpk+zUBQ5fUxaa5zglExp5XlAG/CNxJHQ
	tNDTUm8GSxEKMbRTNbQ==
X-Received: by 2002:a05:6000:26c1:b0:487:10cb:ac16 with SMTP id ffacd0b85a97d-4871fa7567fmr4378753f8f.4.1789769218317;
        Fri, 18 Sep 2026 15:06:58 -0700 (PDT)
Received: from ?IPV6:2a02:3100:59ae:19fc:400:b6b0:efdd:810c? (dynamic-2a02-3100-59ae-19fc-0400-b6b0-efdd-810c.310.pool.telefonica.de. [2a02:3100:59ae:19fc:400:b6b0:efdd:810c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487245a869asm1644516f8f.37.2026.09.18.15.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 15:06:57 -0700 (PDT)
Message-ID: <460cf85c-365d-49d2-9ebb-5269dceb2002@gmail.com>
Date: Sat, 19 Sep 2026 00:06:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] selftests: net: hsr: add shared-mutation
 regression test
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, shuah@kernel.org, lukma@denx.de, m-karicheri2@ti.com,
 fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
 ali@iusegentoo.com, qingfang.deng@linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260808004525.1551-4-xiexinet@gmail.com>
 <20260814012740.2806069-1-kuba@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260814012740.2806069-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2026 03:27, Jakub Kicinski wrote:
> A few questions on the new script below.
> ...
I'll revise the selftest for v4. Unexpected subprocess exit statuses must
be converted to FAIL before merging; my earlier no-respin conclusion was
too broad. I'll also add CONFIG_PACKET to the test's config fragment and
distinguish missing captures from incorrect MAC addresses.

To correct my earlier reply: the RedBox case can execute the HSR-tagged
forwarding branch, but it does not check the path ID. I'll revisit that
coverage for v4. A veth test still cannot validate hardware tag insertion.

-- 
Xin
