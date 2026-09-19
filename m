Received: from mail-lr2-f32.google.com (mail-lr2-f32.google.com [74.125.230.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF133BBFDE
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781163; cv=pass; b=eGSz6mwcUwxcWc+klnL2XqXXsKLeM3P9hnEBGGk29neeIUY/VPrJTO3Iq5+IzY9l/KlwO4/Ka1Bmzbt5BFC8IL7ysMx8CzPOgO3v3VzUhi+Q3nbPPycpRCvdK4PxGlXmse9IyFpsCa/H02nqN8kb30fyOka5EwMfMP9/L8b4RKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781163; c=relaxed/simple;
	bh=XSgdQN2yictpDS59TUHTRXPj7NA5/+Qdu1X4xC4oFhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4Sl2EdxhlWKcZ25OOc15oNpUAcUv5UHLP5smSABZRWqejsDucgd0IR/1LBikcq1lyte10yRDdCwv6t1EQ9FzC1538y80DiRMWh0bqctmXMV0r8WYoJqoiHiMJDm8NMQIcutqyP59tfSn2BerbPzNxdqZoMYxYHuOT8v1TKovMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFlcyJbK; arc=pass smtp.client-ip=74.125.230.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFlcyJbK"
Received: by mail-lr2-f32.google.com with SMTP id 38308e7fff4ca-3a3156692e3so4256861fa.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789781158; cv=none;
        d=google.com; s=arc-20260327;
        b=DK7EmUzQGoCUpF7mU4YPIAmdaGTZrYkaKks/WfaAiMTnPFx3LSECrzJN4zUO2JhKqN
         wYCSdTMPEYmc1ekQhS52xXygwyrPxfcxlAYH4kp2qtHHuIc6cQ7zsItLHbofZx2dJn2n
         JXu+Ypou7X1hsgnsyvmYuWS7tp/wN3p4VmfPCMJmfG39jjaxXRm/vufOAQBeSrQ8ErP9
         2n5ZX44vI8DpEoN13G0FTpOfetNvFWHjCmKJNpuE6UByH7QeSCMjMT0VZCKue6cv/Nb1
         qMzQff986P1eRa51AuvvKZZAj23vZbe/WMgIiYbXHWpKSv+U6Q5xUQCMDZ1fcqPMnsa6
         HkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAjkQmQffedcstioBR/bPz7WWF/kUAkcKil242Qiu6U=;
        fh=1FR7jRFOGYos4hLHrVz9ID7H27ILHvkvVeRS1JmJWIk=;
        b=oRnqvnOJGT/yA6WIgR9RSyZHEMkTOx9qWGO5TfT7uc9LGkOxehlb+k0PcMxflRXxNF
         bTUylhqdE6Hd+9A3qDjQYeJd336p43cgBSo9sXJjWrTqOFLTJkrhGndcVTHJBLZ5UmTa
         bc1Gx7TSdd5N9gBjmzfDLKvyFkEClyTO0BbSOl4h7Ix8RzbH+iNkLqtAfxaUEryNZscG
         OyuJP6qN5mUARMCyk43JZ9G8w4lZyH3BNM4UVMHdyDxzZ4wCjUI/Zw2gp25AmmnrUJ71
         /jP6kHeTexEDzwOLzruY01YCGfy4VwQl1GfHWXbcFCp5nitcEnLOJ7tYjJz5yP1zctwB
         vR3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789781158; x=1790385958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WAjkQmQffedcstioBR/bPz7WWF/kUAkcKil242Qiu6U=;
        b=IFlcyJbKQZ1ErOnOi0LDEaqgvPiYJArojrTtIKp4QVqlRaXW45OnoOWbTiPaHtx1FT
         4IvSzcMkAxYHUhhvR6o3O/CKLNUXTN1waf8AU1UyidwjQT2yLv4ZsDdQQQML8qUJhTVc
         +sUb+5AMYmeaWLt05vdQKMVQs4/cDHRU+h4fUG0ijzIvaFXc33amookTzvGPWs2W6kpl
         5xyGKESlfKwhIK7D+v/DD+4Z00tjiR4yR94O2CW9tbWQ9T/yYPNNtmXYwvIlzhiYCoc6
         s29mix6pd2Rym4fXaXnyNC25wp2SQbhIO+P0mGtzWcF3YlrMfkoAonE9nf+T8krb6KXV
         STUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789781158; x=1790385958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAjkQmQffedcstioBR/bPz7WWF/kUAkcKil242Qiu6U=;
        b=VqTU8brCyAZqnr3QqWRKc4tgNQy0TsUaBi/i+apAxTZ6NQzEOdvtKe9X7Ud34z6LJs
         hQlP9w9ZJ/wd+bPRE3/FJnWvVxnCfJB164gsxhdVZ7sZ/McoUnG0BzZEtvQg7Ev4ZeVC
         x5p222d4LOetKMR5M5HSvSCrDZjZ7MwESDycgbRJPn5w/4+wAAPOKhBZ9WK8NpRDXDG7
         5+7mBnndVbAHPA10vUFaO6QW+nHvX/LFiSSO9Eku28rHFsiGbmtfyKQM6YfLqzipfNXd
         pCZv0tVTack9kRbz4eeX9jE/5mzBEave3HmNL71U6VoerAOFsNnP1xHsMsArA6/zuz+N
         1d7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwe/axzLTziE4L58DpYe6nEuo4UvavsFWI3HFf/J8jSfd5riVP8fZast5T5ewfC5F9tZxIYPqw=@vger.kernel.org
X-Gm-Message-State: AFuF++llaXPs4rlY72amvb5LsWdugtIUGho0qWfr+wPDUtHlbgFxdFUm
	cA++LezrlwyK6N7JqeGJ77Vt95X2CSsxmuL+rWmUxYyhg0OZdrRXhOu5QOkfeL0yinuPa6rsUa/
	bYank2cO84wqFgKrnbra9gj4CIl6IXq9rRvoySB0=
X-Gm-Gg: AYBFou1JNrVHKZw2sxpXBywhyamnTbtH6zxulv/KvuPwGj0yLsd9EnlQj5iue9PAhXf
	/dMDsF47t3r9beL5LmVqP/41BasO4+LfYNEkTMLJ1aDOoSUN/8vqLTi32Eo9tXzaaGANW4e9GCo
	+yC11XvtzB88gPj0NN61bDbGtOcNyAelBB2D9d+zbzcmia+H0QvjHmAP9kuG2owMYW7NX5/dHM8
	GqaPE76C3tHYd2vV6IhjNU7tvRSvq8mWrW8w5L2qBXtnpg8NhtiNgCoRSHbtekvBSKKnd9OSnb+
	F8nqmhmEKbeQZhWnzmqX7M1t12N4Aqa9y5daqYWngkG2ylQ3lGhjqV+D4GuDnEVbRzV4tugCZvX
	yZvQ13Pe/yABoUwkEQR6BXGNI6LSsMNqIL1X9ekfCgVxJ
X-Received: by 2002:a05:651c:2213:b0:3a5:a4bd:bff6 with SMTP id
 38308e7fff4ca-3a5faeb291emr7755411fa.0.1789781157892; Fri, 18 Sep 2026
 18:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914014539.5015-1-sigefriedhyy@gmail.com> <20260916184748.52ae812d@kernel.org>
In-Reply-To: <20260916184748.52ae812d@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 19 Sep 2026 10:25:47 +0900
X-Gm-Features: AcwNN1VKSMsHXXhl9wsuuXYQn2cCHvXHrr3pGmCERUzA0N73AkVzctfHurZKado
Message-ID: <CA+7S2vKmeaPRBqu84FtVWUjo=U8jTm+LGO04BW6M9h2nRzkHkg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/4] rtnetlink: dump link-layer multicast addresses
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:

> You compare the situation to IP but for L2 the UC addresses
> are not exposed via RTM_GETADDR. Are you going to add it?

I'm not sure exposing dev->uc via RTM_GETADDR is useful: I haven't
found a use case, and iproute2 does not dump it today either ("ip
addr" only shows IFLA_ADDRESS). If you think
it is worth having for consistency, I'm happy to do it as a follow-up.

> Is that the only justification? To avoid reading proc?
> Are you planning to extend this interface with new features?

For more background:  we have some hardware offload control logic in
userspace that
needs the L2 and L3 multicast state of devices. L3 already comes
over netlink; dev->mc is the last piece read from procfs, so we have to
maintain two copies of the code, one for netlink and one for procfs,
and parsing procfs has none of the benefits netlink gives (e.g. per
interface filtering).

The same split exists in iproute2, where "ip maddr" parses
/proc/net/dev_mcast for the link-layer entries. I already updated
iproute2 to get rid of the procfs parsing for IPv4/IPv6 multicast; L2
multicast is the final piece, and I have something working locally.
Once this patchset is merged, I plan to send the iproute2 patchset.

Thanks,

Yuyang
