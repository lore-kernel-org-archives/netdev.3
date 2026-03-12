Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2B38656F
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305025; cv=none; b=bl1X0GBOahy+oKpqi+NtLYnrvo0Bz1JMBUhNP/zeacL16G4OWXF19tZJ9AMDHftICEG4P1eDduK+BpRkyRQFokZ9pEQYnMPTYS9uvCSCppEBRYBMLrf/AbtHXB+5hWY9e1APvW9EGR+aVOJBb6SUZ1jtrBEOzue4l2ivficLrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305025; c=relaxed/simple;
	bh=gluiqefPJyMporu2NQvn2jJmiuBvJFcIQ/S0YY/bh10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTFUviLBYnO9vDUC9NMLn9kB1cdilCzPbGYO3oTFLNrZYPoPC1KqOxCLxorvLSOSdLQF26cstTm6/gmwwHREuEAi/TZaB2kLK0AZK9jCWRztmgvS3lEhBue68olJ2Att/+2mLAzaStNhelpd4tDvuhhCehcciRx69Pd/B+96Rp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EP7IorNP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EP7IorNP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so6389875e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773305022; x=1773909822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHAsiAoMs+rl29pl1btSfTev7d4G7XkQ7qF+4yVEfes=;
        b=EP7IorNPJ0x8DfP9ZvU5mxZPfnk+u37VOKIvdj3Q4ZsdmTqr2XL28RF/zpnfTJhSJZ
         cp/lj6bgr51HLB3ZfEjSa+cn+plNiXfPDeWXi2ywxYYuUcYtiDe8lsrZaDhbt/uFJCgQ
         g4h8d+1abwJKwu7nwXcaM1/1hs7Li1i3Z8NiLcAuVPgdsMhG7C54DUj7pz/eg+zfxDjY
         h9yJDQOHQELvmRR685JOgfWgeVxlYc0EZiucT69ya0IoYHg8EF3GdcTjdE6N2QV9ejr9
         2kMnfnwxkclrwPAmImNulkIE5f9Rrlbr/QLKGrzhdV7gWGHLY2TOxZNyMoi0ZPEpQucm
         RtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305022; x=1773909822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHAsiAoMs+rl29pl1btSfTev7d4G7XkQ7qF+4yVEfes=;
        b=I9n0oY2gvhurFeC8ybUr3QPuQjWvfBsuHKYSfs+kLXAPLq02okgM9cVZ+JGc+WKe4g
         LGIHJHAyEJzsoHeKfmfNNE18OoKcQYTJBerPZ1VRcvR6UakFZV7+7AB0kMckbcE0Agpu
         2qFoFIZdQ6YK5NLeTQHt1yECGUb03EZ7rTIVbkdKJoz6TLOFfAL7ksrr4uhIgknX6/Z3
         qj0eDsC1RJ2qdcJ2JopRGMY9Bn4Uqq8JHUEKnQthP4UDgu42dvgN63HCiAzADuk2+qBW
         uc/9pJPz0+q1NtpBO3zqxyusqoP0p9mjRfFp9GSFAugz61rZuPBWlD8d3bLgamzcgcQm
         lACg==
X-Forwarded-Encrypted: i=1; AJvYcCX2DLZXEF0ecWeEsSTLpEESOmJYyR42+SAWkvJxxNks6udFN5mGfNKdVBHIDKmEjow+o7qjYcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrL0YkPyWfOusj8KQwPkaDLntZ+96ey6LaHOaHuOP4rXFlxDI
	1uTdnY9IBDIb73TNAyXSRoH2mhiy+jAqNvkDSa2qbGQPgtxiosueQWfY1g/PEd0gCxA=
X-Gm-Gg: ATEYQzzukuOiOAMX4hTcWLmMXC/h/IbWCARQBCVcmAAL0oYaYUUWw81vECTOR3uaDf2
	UjwhBjd7HdqSmsDS8+o+dFsISodDioi0cL2KzOqhiQikiMqTOIwJfU9C/zUhn9xzRkdeX7PGuSX
	Z4LtOJ/b3dsm4lFCa0JWlw6SYNaRR1Lt/lmPb7EOjrIgZWjnda4/GRWPgh0oJ0XORR8yPoQNiri
	Oqlp1zEqB+xN2Som7L168bj5aL09tc645yB1sGiA6edG7Wfkj+wqcUuZuYtRznEolIW2rkzcAOh
	wSTo4bwqktTXAN1zPVeNzcAjkUoK3eRajJhO4WVy3Y+mhzVTBr7SNsBhplTvkFD1OKQbi+iy/BB
	RzWUdr1vRUiwIkAo1bCEzOTjEYIGzQvUrfvYL1DeJ/zv+FfIxE1uvAvkRnnUo20QqyIIpz0i0mq
	EVmrA0PZtMVUd+KwjSQ5yVL1mGc1Qlw0bB26P986klVji8Y1ypuL9kxw9dzWXIMQWe1Ho=
X-Received: by 2002:a05:600c:3114:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-4854b0bb7dbmr89414645e9.11.1773305022375;
        Thu, 12 Mar 2026 01:43:42 -0700 (PDT)
Received: from ?IPV6:2001:a61:13b5:4001:781c:5386:18e2:cda0? ([2001:a61:13b5:4001:781c:5386:18e2:cda0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66ffe2sm108681755e9.13.2026.03.12.01.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 01:43:42 -0700 (PDT)
Message-ID: <1c1bb25e-10e0-4199-900f-c89554e71db6@suse.com>
Date: Thu, 12 Mar 2026 09:43:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 net-next] net: usb: cdc-ether: unify error handling in
 probe
To: Andrew Lunn <andrew@lunn.ch>, Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260311112919.678686-1-oneukum@suse.com>
 <5db41b5a-c53f-4441-bf4e-a12add3e33b4@lunn.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <5db41b5a-c53f-4441-bf4e-a12add3e33b4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11.03.26 20:15, Andrew Lunn wrote:

> It might be better to change the dev_dbg()s to dev_err()s, and drop
> the dev_info() here. You can then add additional dev_err() before the
> goto's you are adding.

Excellent suggestion.

	Regards
		Oliver

