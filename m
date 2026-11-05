Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910413;
	b=v2k4f0P1G2DMWXTnIAjFQI7e60wMmjFpipY04E6Y1QR9p4lrd1p6ciLhmcIubg+C0q2z
	 p81RAZAah+4eSO4aaQXrSeKA58QemhPkGTFJk7GGM1Xyo2WP17RqMQGYMJv3sPjsXYcqr
	 CsYL83Q5JG+/iNz+RUztCRP2VpQeCawW0t02Jf/WYFIxtxSHNiRbe99azy3whVmbfv1cZ
	 RdTci1sWZyu3mphBg1aVPLcpNlYrOeY50to8jgcJC6fIjygNRHtjRO/rG2r2l7kThqXdX
	 UpmKBKw03oRUbx/H95OywezO3woRwoGLUbZHviCQfviVoMlk3qJeMVfdVt/emPJiUAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=bWiBz7DURXvu8uqsHcneVE3/VyQZ46GnJTalrUsgw9Y=;
	b=axTgtoxuFSkWJXaVjpOSjLu7NR47Nkvts0xyS4SBJS4EO7wbTrpGgBvKHahsB4DHj92H
	 JybNNXtLJiRK3RNC5jR7xC9l/J6DxkL1npol3L5v3ARQ1CPZ1tJKB2Rx8TvNq9CdZMD5A
	 +bZ5QdkR9KRglFpXXzE2R1hws7Ill6GXTRVZ9bXNHz/qqTZngZppzeLYtwZzf29UDuVJy
	 ZpOIozcNX6xkZArMwxJw9w2JRg8QF3QDRGPbL0NGUmkqcq52PW8ZAKJEv+7IVIrVcLRW/
	 KSV/RDYLk/YEGvmy7qRx/ZUM7JjAg2ZhHiBB7EE996v6+CpJeBddOuOZ58hbCUHdADA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcMmzOIF;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B3606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C6B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcMmzOIF
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1931ff67a29so48460c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910412; x=1794515212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWiBz7DURXvu8uqsHcneVE3/VyQZ46GnJTalrUsgw9Y=;
        b=AcMmzOIFC/emVcPgVyfmvzyc+Y+l/c5+ZYXd9fwf82DR1RhknDSNnG9biCknz+gm/u
         zVYTtyjdslcSfc9oJ6wCcGR5GnDWXWCSufltD3FC66J9cIhoIW7dfoSobQFMT7U6IoF/
         DgE+w68ql/vK1NpX8T7nHBQUMVVhMft/UxI7aY64t7u/8SepGr8/vm9NWxptz5rnHO3r
         /a+UkbnZdKZZkrN00UvGzH/j6aLI9REYTB1VkcCfm4VnW326Za5ORaI/+LcF0JBD/0YW
         MA+6fxMzn/DIli53IZYM3kBi5i3n8+QnkUNLRmNpW3lrp/2ODZI/wKkGM3Qz1suL57UB
         yBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910412; x=1794515212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bWiBz7DURXvu8uqsHcneVE3/VyQZ46GnJTalrUsgw9Y=;
        b=KqbAIpIeNH+boO//E3/bvUr4BQ9QrHmH0Ea9oqoPiA6cGEJT0xI8lC21R8ykqm0S98
         0uofyOONd5xm9PGGiAssX7NksOYhBr4cMD4HRg2mnerVNdRydWPczmuK5wXp7x7eOJs5
         SfIey4C1H9zUvUU98VR57j1+l1/iwyulpJOSlIzGkXOjCtzjFk/4MpARzEjh+fiMD9Id
         vFqbQDD4ytGErVWEcsHomux+baax1vz5kT5dU7pWzzHP2q51q38qLMmmRyWNGF96OKCY
         JzwwAq2Gqalg/YS1YxFMgRQytj53GMTtB9a3QOmSYdRC7hOj/935A8gfX95nwg0MTbd6
         +5RQ==
X-Gm-Message-State: APuU4Z92/kpKy+1r7PK67u4GlK44XWDgaIG/Ppp/7jPD/N5oiKwI29Fc
	0XbL12NUh93Pi2fMvQT1wZcNQ/V9D4d1l+niJ82MyXZMHe7apVtKSfWz
X-Gm-Gg: AYBFou2VvOASBgJfIprdq9qqgstrwPXIreO/mOqpWGoHaWrxYILd7vxRe6SlDACO8gB
	Jtsv4ZxKwuinRXA5+3GhSphBFYtfgzepTZbxWk3hfwpAO0xOkIrlWhfvHsOBu4GukIO2Y5N0pyd
	qVJJ7PXOj1OjueAt30fTe6xpyTfO+7EL0rqT9cMEaRw/nSlKik36BHHpiT+N3q+CsRnDg6xCPxF
	3Z0JFYJu1yFTXuUv+rLWgx3W+2KNq/NkSb2c/jhxZQ3PJ/17bk8BMlEyun2P9gg7vua9ptl/3LD
	oJzHf0VWkULpeKx6h8+fpSGEljwhvzG2up5IaRmajVllZPNoiWmnDTGbGvD+2HBFavgzcP7mbwE
	5dH1LNBaOJuPh5+qmSyr+HUbu2SfV9I0nXUfCQ+YwhXo6YNTq8p1VSYB4ucPANglnVtWpokzNAc
	nXX8J9wRM8o3poge1yorVUA3Q7plDKGYQSPzE38qLTHlQbSFag4quJ0NsjO5y2JFk4Eywb1q1sZ
	e5SxPH3u0Q6B519j3Z3/s7iiWGSaub2Y5yLEJBdBDblCehX/Gj4+GbuOkiGQ+LIhO01a1U8dOb5
	xc/bkoA6b+uRvpTDht1HlOJ9D9sh9n2nzf8RExiy9QM5FxEnEoZl/Ad4chWF5uu8yabxi2U=
X-Received: by 2002:a05:701b:2505:b0:181:ccdd:ed2a with SMTP id a92af1059eb24-1b25d38077bmr111415c88.43.1793910412091;
        Thu, 05 Nov 2026 12:26:52 -0800 (PST)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f733b0905sm564712eec.8.2026.11.05.12.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 12:26:51 -0800 (PST)
Message-ID: <e0cdface-0e8d-44c0-912d-0a96bc4032fd@gmail.com>
Date: Thu, 5 Nov 2026 15:26:48 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] ipv6: fix stale transport header of GSO
 packets with extension headers
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 Justin Iurman <justin.iurman@gmail.com>,
 Alexander Aring <aahringo@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Alexander Duyck <alexander.duyck@gmail.com>
References: <20261105201309.3182307-1-tactii@gmail.com>
 <179390983837.488859.4719265601441033954@kernel.org>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <179390983837.488859.4719265601441033954@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 15:17, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.

This was encountered while working on an ndo_features_check
implementation to fix a bug in e1000e[1]. An LLM found that there
were more affected consumers of transport_header, so I expanded
the scope of a different fix[2].

[1] https://lore.kernel.org/netdev/20261028170239.28606-1-tactii@gmail.com/
[2] https://lore.kernel.org/netdev/20261104175517.2395704-1-tactii@gmail.com/
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

