Received: from 15.mo584.mail-out.ovh.net (15.mo584.mail-out.ovh.net [91.121.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA235C6A7
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.62.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299247; cv=none; b=VSAKeTAg04Goswx03l2Ml2Arza8AAwQLTA6NrfBI9gjNNCFx7nA5kuoVPaZisMWYlyiNp0NgEdZ7JrA3NKIJxe1a2aTxc/W3IfG9GSyMUJhMujTt0e0KIXM41vfUQe/dg5E18scWI0gnMtUxR260txypuluxPikugXyaBm8I1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299247; c=relaxed/simple;
	bh=JIW4Aq3yzUa7B/q8hox57ai3R8PuvdFw6fcH7xtoSFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h99NtX00DjODU1MojrTv3mbXJFK+4GfJqyC2AnYWjtPfud4PC3+GmqTEDJqc2eKptXcX9ityA1eI53kc/xLg1bFABtKF8/na1V4rlSLL6B1t5S3Sd08hPGeKJ9XpJYPVOvNNwQdTJiVNMjAY/9TkOonrq73CBLidRLWMDpDagxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com; spf=pass smtp.mailfrom=armadeus.com; dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b=cE0VNAJw; arc=none smtp.client-ip=91.121.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armadeus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b="cE0VNAJw"
Received: from director2.ghost.mail-out.ovh.net (unknown [10.110.54.143])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4hzfJc5Ftdz8S6Z
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:48:32 +0000 (UTC)
Received: from ghost-submission-c7b579475-hsw8h (unknown [10.110.96.185])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5FCEFC0D61;
	Tue,  6 Oct 2026 14:48:32 +0000 (UTC)
Received: from armadeus.com ([37.59.142.111])
	by ghost-submission-c7b579475-hsw8h with ESMTPSA
	id 6AtTDEAKxWr00CEAfbgmAw
	(envelope-from <sebastien.royen@armadeus.com>); Tue, 06 Oct 2026 14:48:32 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-111S0057d6e6ea9-af38-42ba-8b74-0731f0ba4c98,
                    00DBEBCA2080E92057B1718008C39CF3BF911D1E) smtp.auth=sebastien.royen@armadeus.com
X-OVh-ClientIp:88.175.232.176
Message-ID: <4585ddfd-122f-465d-80b9-c907a530075e@armadeus.com>
Date: Tue, 6 Oct 2026 16:48:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ8765 fiber detection
To: netdev-bot+sinfo@kernel.org
Cc: Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
 <179129640372.2231598.1056441247005614175@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?S=C3=A9bastien_Royen?= <sebastien.royen@armadeus.com>
In-Reply-To: <179129640372.2231598.1056441247005614175@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 738590340421989471
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGxRaL9cxCq5X+8KPeE9IA/Mn6bSHESwwAhqEKKtoMcf5Q8aqr2kijEeMHchoYD2VpX6jQ7N0cLENwfExhmQpItlZCg1H60gf7aCqidEZA4RHDj9FdINK4f4enWJUD+cYqT281aEHtXL8abeeq6mg+Ny9rWaUt8y3p/HQZPxXhnAmWWQhQIV3nkWpiwLmcQCv4Hah4AxN15qH43ZUx3g88fLFhNpjTHWbyORD6TmugZm7Oz6aP4fo6rigi6437sPBretnY2yX6mG7hjMaEdtTXe6HJcyPltU1AOsm2JbXOpqV4qJtMM7z+Syh9LZo2MLFjuWlMZl2NcufH/hsCsJmuJItce5G5269xPHpxQ522MRaDfvh6LIPT7cL4Kp57Gx3XXMcyvm24pOMtS5mdPyL3x5MXAHQM/kj7vdEN+k0bjgzBFbMFQM/7ejKEzGu+sWuNfxlpX7IQuCWGyX1Ya13a9KsbTiRVuvM/VaRkIdAuDi3kMoXbGmyxsdGPF5UEYa0Q0VYPmC6Kbqq6hmNNKm83Eht7IUWj1L7NqY/yJP5N9H6Ec92n8Tch+3BbzxpGD0L8mcsO8HiVVfCFxdjcwMW0rIAiPph+XkOdltTNRd0YpKXOH+Km67vcqw2aT+LV3pKKjZSxhtc+ESHraxg/dh5uWR2czyd+AfHwNEEPz/NQyJg
DKIM-Signature: a=rsa-sha256; bh=6q3vBRr5JRS8QySM4buQHniPenZqTCE3Qhk4I6/MCvE=;
 c=relaxed/relaxed; d=armadeus.com; h=From; s=ovhmo103079-selector1;
 t=1791298112; v=1;
 b=cE0VNAJwftCNAgpw6u7JoZl7Sc3hq7R6gmYJJaOVdK8iVby2L85GtfG3cqq6ZztjDlpTvJeC
 Cp8U2Y7eeV+dsdHgbJ1Lrhg1dQsIZ+vd8VuHt/nDtMieK/i0J1JzIf5EsXsqLpsLj1IYHa4tw6x
 F5+ugcLIcf47FxshphA+IiK9qpJyYI+y79KEl6SXjFvddQpfjxOY25a+bGWW1df+/AX1h8w30Y3
 5s3UCvPE00CtJHaDuD9RfpUN+wbh7WuRqqvM3c07mM9/NEuzGzKH9gmm5l98WNa4gMbMf+yNiPC
 v98geXQIu0qzD4jrCtstkMV6o2Sw1B9ltXPPhHwVp/NMA==

Le 06/10/2026 à 16:20, netdev-bot+sinfo@kernel.org a écrit :
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
>
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

This issue was discovered when upgrading an embedded device from kernel 5.10 to 6.16.

The device was using a KSZ8765 device tree configuration and the
corresponding hardware, but during boot the kernel incorrectly detected
it as a KSZ8795.

The issue was reproduced during testing. The relevant boot messages were:

     ksz-switch spi0.0: found switch: KSZ8795, rev 0
     ksz-switch spi0.0: Device tree specifies chip KSZ8765 but found KSZ8795, please fix it!

The fix was then tested manually.

Thanks,

