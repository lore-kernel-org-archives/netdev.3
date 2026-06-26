Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5093AEF20
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497054; cv=none; b=Y4QM6aVM7twh6/V1yVJo4C8h+AbscWcg9EgJMTZKCBXR7uWLO9RgqzaXn2v6hZBDD1Y+OZ8cS4aJaoGpG5sYjo48KkqRkADLfCave0NAHzet7mNqe/Tm/RD7406SeckteHMDc0q9A/4r2SEkxbLrSOsPgTDPuPPl9t6SGpdDb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497054; c=relaxed/simple;
	bh=mSXpnpbCzVl6XZJaduBfowqNhfr64cCjJ28/dcbXAyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0ZchtbwOioqi+pAgwVp9YNRq6okriiqWFwm9Vw03SBEVAibq8ZE2TKRbQKhRlQF5or3+yqqAlXbaSxniuJsQoaZZePhpUkjY1G+vlv3AYZ6MZn7i7rahm0pUakOCQ9u4H11xLNTEzOBigNV5UEolOPxDyIC7c8iVvtxvRedYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt+kwU4b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt+kwU4b"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c7ed771dbfso10246595ad.3
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782497052; x=1783101852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSXpnpbCzVl6XZJaduBfowqNhfr64cCjJ28/dcbXAyo=;
        b=Jt+kwU4bhcNI2CnUpqvwE/EX7y0m9FCoUfSne/9WObZRLH2zzRhZCG2teYAaBTVGb6
         QRrAl2gGTC3vLgkoyJ1vQTZc10xj774T1h0r1R2Mkd26OLB7VMmugkd+WzIR1F9eNesR
         uu7Um003W4y2UwvG8goZZItI3jnfXfqSKRddP/BiHZN1vdkoGYggpae/K3gowgonLY8T
         Q9JaZLJr9yp4rwj6u/Q4y2BfUmO44urvMJaZR3LhBb5a6tITVlhBNaEUwj+UZ1woQjhY
         1/dN0pmlxcp/ixVi2sw7jC6o9XKtQxjI7wdN8u7eVFI10BqZ3xbXAxnn/B2OqvswpyDZ
         J0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782497052; x=1783101852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSXpnpbCzVl6XZJaduBfowqNhfr64cCjJ28/dcbXAyo=;
        b=SR5CIvZF68uu/LoYkSgdWwUPWMSTaTLzZQR/AY/Iv6z+6/oUv4WC8y7ifPDuMgx6XK
         2GN6itHCSwVswiw+pCoHXu0UvHc3XnWtRZCK5b4m1Khgjyhw9nVf5kHWPcPTd7GD9TcY
         sP2OFqGUgAKWuRPDFS2DxhP+OQ5ffC4S5oJg12A8VTtowxiP84KIA9wL2qclwgF+u9pb
         O8Aydjy0908pP1n/bEWeNc4cd4HwE1eBEhAN6RrtaP1yo7nlGvs6uZG9umIb0JSUSo/c
         0z/XKTxuqXXYLKAgD3eXrrsTZfgTcZKuufibbePBVrF5nD23hTW9RMTK8y5+Ly8mlCVa
         WMQg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7ihGqr8vRTr4B7BWUt4lPj83PO4O20vITrByW8D7kxXYWI6fRFObbBIxKMGhYOrfc3pbo0hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtbeaZUaRUX7NTljj62kQDFqDnOpHN5rekgj/A3DmQZHjLC4zm
	phAEKUkeUO/DSFHZm/fIfCOY6eEcCdfvdZehT9gYtOZBnG9UlIRTWQ4I
X-Gm-Gg: AfdE7ckKGudmdqdTDWOt+o/oIGjCusbLVo9CyW8LnwSVf1rgci0cu4lqjIzpogVAlnh
	HLioZxZRMlPbjZO5XggqXLLmOjRpRvurzbJLxAovw+4ZNpMJBnKRA4f4XJl4US1nHmmohRhMESA
	CoJKnvRk1B6XWFe9W58ii2mLcDzymfqPk9NUuC06kWilAWVIbSU8tpImT1XzrFgSerGlX0/CvDp
	WKGfGAFWqlLPXsKKYik/w7kvtwhSuj7DnHwU8cg2kcCvS+BDypOQWJDiXByNEWeqLbia+PXmI0N
	KeJB1omApen6fjVlaCIeZWZjKTV0Qk2s9FfhOqsjJL6wFkkJ6zyHGhzf37CnI4D0gairTa8xPxG
	oV+mvIPUy6BLcBPpRLeWgzr1ev/54LcQzKKUJOy5EsD5Ct/MNirC9qLI/dLj5Lag8xl3uQRelgy
	v3R9aLj32BQBc=
X-Received: by 2002:a17:902:f612:b0:2c7:f2c6:89e0 with SMTP id d9443c01a7336-2c98549d2a7mr11230015ad.4.1782497051981;
        Fri, 26 Jun 2026 11:04:11 -0700 (PDT)
Received: from john-p8 ([98.97.43.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afcb18sm44277795ad.31.2026.06.26.11.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:04:11 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:04:09 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
Message-ID: <aj6-Ga_sIrMixgKN@john-p8>
References: <87v7b9ysep.fsf@cloudflare.com>
 <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
 <87mrwlyqg4.fsf@cloudflare.com>
 <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
 <878q85yoy5.fsf@cloudflare.com>
 <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
 <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
 <DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com>
 <87cxxey09d.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87cxxey09d.fsf@cloudflare.com>

On Thu, Jun 25, 2026 at 07:53:50PM +0200, Jakub Sitnicki wrote:
>On Wed, Jun 24, 2026 at 01:57 PM -07, Alexei Starovoitov wrote:
>> On Tue Jun 23, 2026 at 6:32 PM PDT, Jiayuan Chen wrote:
>>>
>>> Hi Alexei and Jakub,
>>>
>>> skmsg is actually still pretty useful for gateways.
>>> I started with bpf by integrating skmsg into nginx as a module and envoy
>>> has something similar.
>>> The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for
>>> L7, redirecting
>>> between local apps by looking at the payload. So there are real users.

Interesting.

>>
>> ...
>>
>>> Agree, just like we remove skmsg from KTLS which is rarely used.
>>
>> ...
>>
>>> Hope not have skmsg disabled by default.
>>
>> I wasn't suggesting to delete the whole skmsg,
>> but to disable combinations that are causing issues.
>> Like what was done for skmsg and ktls.
>> I'd allow plain tcp and udp sockets only.
>> Allowing unix sockets was fishy. I think we should reject it too.
>
>For unix & vsock we know Bytedance built a proxy using it.
>We've been showcasing it as one of sockmap use cases [1].
>That said, I don't know if it's still being used or not.
>
>If we don't want to go through the config-knob-then-deprecate process,
>then I guess the only option is to kill it and see if anyone complains.
>
>[1] Slide 117, https://github.com/sockmap-project/sockmap-project/blob/810d259af6e7a5793922af3991c9dc7ff502fe19/talks/2024-09%20-%20NDC%20TechTown%20-%20Splicing%20Sockets%20with%20SOCKMAP.pdf

Most the bugs I'm seeing are combinations of push/pop/pull/tail/head
calls over sk_msg scatter gather list no one ever considered. Or at
least I never considered. Add in additional socket combinations that
came later and we get bugs.

Do the nginx/envoy offloads manipulate the scatter gather list as
well?

Do we need all these helpers? At some point I thought I was going to
build a real kernel proxy with this, but never did it. Another option
would be better test framework.

.John
