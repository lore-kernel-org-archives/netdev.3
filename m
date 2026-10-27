Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793072637;
	b=PtBX0e7vSNgH60XPc+rgDJMBfDdBsGNA4jwbGvvDDyLL15ijUhmgkHAkOmKVO1UnYAQ1
	 xkCSOfQzLKYZtYuZ1KHH6EEwfucOEz14B+tvvnbaiIurOXSn+MOjVatgxhYMzBJXpEN/q
	 uRcXf8eV/Vvc62bAhkvAgBXDLC6X76yhCRUfLR8YRMGY0JPLCAIq8wghYwfM+NQsgN0K1
	 yaDKkWtNH8pjZutU/clPZ5f80XDy4bAWjEEOsXGxOysdsst3qfrgv58IV6cDMd4V/kPan
	 V6ZBJ7QqDR0oKGuUe7YSlbUX7L9wNP98hBOCQh6Xp1t3qzMXdOSicApe6FCZmidg1Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5qKxJCbfRdRrH3hTlJ0h5gJEmaH0ng7PGOWlvDUhXUA=;
	b=ANdw0qaBt1VL7loXomiXrjHOCzQN4quVQpsiQO4rEqf3RCf1XZEvaFFzqBkcQTZhD9Hc
	 hGrT0qA32sajzLcVba3TkwkiDgg/Nu+2tFF/qTq+a9SBb80LKsAwAyuGvyv/loxtyUFzf
	 o1p6Ql4itpqmHLBcaMAmjUK60ExeHIPRkTdv+TSWTHlMCqJKcqlhWsl3930ZJpMdimjBt
	 48psM8/lbVvyOj2EimMF3SFd8waBJxJQRE7LhTJg4Fybtjd8o+ev4iUq8ePlKmMS6fsoM
	 0yvaVTzdzqFF+93deyoM16fPesi2Yneg33PRkKCReP/XCJuwj4K/zVMkvOjFSzbV2DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=Jk9klGgU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D7606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591D7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=Jk9klGgU
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so4483532a12.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 20:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793072635; cv=none;
        d=google.com; s=arc-20260327;
        b=cqRg1c0OtJfWfQCVpeGgSQ9E51Wd8kLeioZ6llUsFTsHt+bddYEpRrRibPDWkdWZks
         PhuztUpwyZR1j2Llnqq3MKv1DaspdXrfAg1biIeoFYhr8t+pXLy3wFV0bXYz7F5+IGV/
         i74nS0CLvtCUmlsbYnEwcBvQy7CiPK99mgYrinm72VtuJVbU3A0PlNG63HlpY3QsHOPe
         ChQCPGSJc7LVCWTDsxMzooh3Z5r0hgtbW38+i0zlOtqU6ezwXKkwL+MFI35pOB2DaYxl
         cqeWJva4pFAsfCLxSY2c6eZXxbxJqrPfafw3EIHNZlyJmLia9J5rQuWxKwBefTe6HopE
         9/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qKxJCbfRdRrH3hTlJ0h5gJEmaH0ng7PGOWlvDUhXUA=;
        fh=CqRm+ortl9xrqPI211HIYqqY9fKSrB5XZI4Erorats8=;
        b=gtmLrX77YvanGbSVIHtPBOWwOR+Eg8wQoNfZ3+C+An3F01n1sOazMIp9j6ASuQYlVy
         T1IY6cGpy6cPviBR9EZlTY1wxzkY79we/FpfkOb+cxxay5m+fCLpoC8Xwn4OVxVNT4TX
         yT5b3Ndohv85J/kkEN6LwThUK/hdTL+tbAyLYXf7D3SYtH55Dsl+e+/y/w9Hne8tQYS3
         rKy4mI2W5Me684f8sM2iP/PB3td3bMuHIFdZ8XVPGQPwqslNE5HERGoEGGn32zL/p11x
         onXrUo0mNB/OiZTjxLrcdB6/4b/bujK6Xhx9wmx/hJaDV3lTTxlyI1S6kHqbcuG9lESZ
         uiBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793072635; x=1793677435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qKxJCbfRdRrH3hTlJ0h5gJEmaH0ng7PGOWlvDUhXUA=;
        b=Jk9klGgU8GCrKZmkFhs0ofHkPl3C52FsJVCvOYWx7PjTj+kkHRZn7BK3ECb9H4p988
         csjhO5vqCOnHyVq16sNPNfgZl8cVYqnLVh4+/AHV9f3DE9YZvzU9C2PAdvtWZLzVOY/A
         bjIMnQcvaPVD1Qts2AKCN8ddA2CkscjuAuKsphVYQGjG1qBF+4x4CVQzzI3Job19LEek
         z53oj2K5xfKsoaROJGrQx6CkAoA+fDmIuqWeUEPVFPYyr4U4NFnyuVYmRZ+i146NycjI
         BdJpjrCCZt+2KcxGL81Wg1AiMeSmTJYKbQaHv+5d9SMe5vII742HyniZsixYbPk6IsCs
         M1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072635; x=1793677435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qKxJCbfRdRrH3hTlJ0h5gJEmaH0ng7PGOWlvDUhXUA=;
        b=0rGb4/uoDUjkhqQrniDlhVsiVoM9fWcK4DvcPRPDC5UMGiHpPGQuISEj1up3HFgPtY
         oHCGFBlCgLbi8gaL+h/hyIUAtKXxd3WViJApCmDhiG+zvM+6vwARsdb4pX9DJOtlPUWG
         o6gxF/H8vVW8hoR4TX79ntgGMNu+MCtnfhY0jGXP1JU4PMojvV65VFZW7DScZHh05R17
         hLzBnSYGu0FHffWZxfrOmFiumEXUbDvWftijOXXXB43JDlqNnubbHoJQL1CqjSj4s299
         CZehChCWrgC1NaFEd2TAWHvQIzsuXC3yx4yGajxktbNOYWXpD2vjdePqUsJth7o7MjTg
         Cf+Q==
X-Gm-Message-State: AFq9FYJ79XbP4nDzC+KZcfEH4jizP7wm5pdYAZxHQ6ey5FKGGGxsZvKz
	rkCYmK8yR3ca+T4clPi8lYzEadXJQuDQDBLEL4S41Q3rYnRCMmT0tZaxFsT6LTjSJKvacsOFjdQ
	h4zzeqq8DOfu8vA+IKto9c/un/HaB8Q5SNy9NXzMc
X-Gm-Gg: AYBFou2roySmozwn2vDJ0wISNl6ziAvUfHLxNlAvVSlqwP4lvkGcfhMSD2EAHsv3Oos
	bBOrU3L/IZu+xEE+SSxys1rTRFOIWeooHq/ExlLdpfyoIqKWcOnDf6TeDNRZ7WGbR0hlkc8tLVI
	PMriAWIt4chrXqgotU0nK7/oADneC16ISYdk2tI2UN5zg6ocr4/CAxEk94juN7g26Ktosu4tssq
	loTZM6CUQ/3BdvwPZy1Q3Kw0GGz/2lIS6Tnxfxds3elnASEbm5qQI7/0r2N6ZWkAa9UlL72db6n
	eqAspfTmHUllkZROp32lYKCSoqXJspcNNiw0H+kMZZki2huZN8GCfmMWQigDduydYAIP/QYqo9g
	O399Syq8+XvMmGoTQPEHJhm0Ir7kCCxrnsLgghaJviD0LL1pWJ74ebNbuXW3qArGf0PhBiQ==
X-Received: by 2002:a17:906:794b:b0:c42:4750:8d49 with SMTP id
 a640c23a62f3a-c46bde3aeeemr1002596266b.25.1793072634757; Mon, 26 Oct 2026
 20:43:54 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027024635.366900-1-prasad@arista.com> <179306948792.3327.2977782192715102568@kernel.org>
 <CAKh1g56_WiP3gTMbcWkukb_tK9Fnun6NqLAQKWdU5o2ECL0veQ@mail.gmail.com>
In-Reply-To: <CAKh1g56_WiP3gTMbcWkukb_tK9Fnun6NqLAQKWdU5o2ECL0veQ@mail.gmail.com>
From: Prasad Koya <prasad@arista.com>
Date: Mon, 26 Oct 2026 20:43:42 -0700
X-Gm-Features: AclHuK-1EqxydWR_WSLPmaEW4heYYjA6apJgh5zMMaiBELQB98cyhu7hOmmOXQg
Message-ID: <CAKh1g54bKZYQwyAS_t6FSOfZvt0Gn3gUWqnwg+6Nv4qTT3C6NQ@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: fix allmulti reference counting in passthru mode
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue was observed during development testing with 5.10 and 6.12
kernels. It was reproduced on Linux 6.12.68 by enabling allmulticast
on a down passthru macvlan, bringing it up, and toggling allmulticast
off and on. This triggered the =E2=80=9Callmulti touches roof=E2=80=9D warn=
ing.

> On Mon, Oct 26, 2026 at 7:51=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wro=
te:
>>
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>  - How the issue was discovered, e.g. hit in production, hit during
>>    development, syzbot report, manual code inspection, LLM or static
>>    analysis tool scan.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
>>
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
