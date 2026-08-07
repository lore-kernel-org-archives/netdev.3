Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7719AD90
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084666; cv=none; b=Rg5gREFOztpYx5pCUQMc2RS4QkP5+i0H7lWMEIqrpOzVb7WSWATn93wpiKjujqeU7KDQCM/nywoa+tT0enPq/bVe4vXo53GZw6olkwmMPPSO60KFWw+hCySdfQf2+o+Ld3UBzBryB2YhjuhJBzzxEUY/iUk2p3Vf71kO0WOVNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084666; c=relaxed/simple;
	bh=rmUPAXESJoVau+kq7/1HNT3Mj/EpolDaXBtlDwuaEsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCpFxiCAwV2wLYOvXYyAVsZ0Bu5KHCL4MBq1VRUA7njmF2jqmQJYBoR+N+3a+exnOQtEYqcnVSpVJaYNx7o0kQMfd8TysdGQgcNqnWKqFbC4jy3mKSEJkSICbt07wrciIDXtExelFNj861dvUzcc0AxdC/353pnV881CzkWCfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EnTTXRPc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EnTTXRPc"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f84023916so2739576f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 23:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786084663; x=1786689463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L86XMQZx1Pr+hc/ioaLvvk/7Hsm6pyPOxYwS82SfiwU=;
        b=EnTTXRPc5xhvkhmEwZ9i1pMQvJweRsTiskMxu3Rc7Oc3NnINDc/5jct8nPBban3947
         KtbLQMx9JFMoWGXvVzfcSqZOgvvUWHYqNjS+BDmNE2TEyljPK5vGorSawMGLqTna1PLW
         BvKHrvker0mm1QBAhL0oR7l1TnjVc3FSZW0bp8RiQJdoMWvxUOAiM32JB6j6dbtGlmQ4
         1EjBwfkuhDSenbDANHZcMYrssNtroi7EugRaoGh9HKLfXw7SC5h40U3bE48ZtXLb6HYu
         +VdcmwgamzO2vpSVWtv0Guf0RVqHTNKnlaY7vquaSjRYGzO0iZaGQUFjQHTlUPWv+XRB
         kSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786084663; x=1786689463;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L86XMQZx1Pr+hc/ioaLvvk/7Hsm6pyPOxYwS82SfiwU=;
        b=Mns5LxlweqElSEKP6QKLAgQszlYEaZAETcVaP8561No8xYJYYzqD9d7cLhvnxa0q4X
         r/i00GFxv6aKvxF0cFoXjJIbYYTt4++WRgr9V5ABAc+Vn7EOblgyirmVfvtM0N3pr8GX
         tvXbGLnTGv1vKHh1U9I7LH+v5eBQDOVY9/e0ygr9egtNZ1ollhmyq96iitmmE3jgAcVi
         2VZSQZfH+DH0tthPKVraRFO2WK/sJXJ8PYkcjGFLZllybipblIo2pjayMYRbOuZDAp6B
         fobPd2GEVi68WcJRjf16FUGtw5uxar6Ea3TqoqTDJO9fypDx3oU1z4PMKttZuSStc1Jx
         MMHA==
X-Forwarded-Encrypted: i=1; AHgh+RraIVaLUETT4j7hI7QG24oJzJNLy49edh1izRn+tA2jA33dE3wmlUtGemjZABmVMOvj2GlT0bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEFoxMYBWzkJTehYXI5fl9/gKKoNd72TAC0hQ3xi+9Mesbg09n
	yHoCflYjT27IV5MHrP8aNzfrWSs4aOTbXqYTufKU95gNCvQU+CbKgNPei4cQRlZPCbGy8jQZog0
	vF8HuXYUZCDD4v7GqiFC86pjLoPtSfE0ro7z8RBMMK4pY2WOBx6M=
X-Gm-Gg: AR+sD12fiy5PmvvYGp0QyOkdxqP7Ylkgij8AboxtPgAppFJ0R/ykuu146x1WaKMPBg0
	9jlj9r6fFkxmirctKXW8lfevD2lCFAHBOk+Qw/5HqFoE69Rr/QB+qCX9BcFU37zdznhvDF9SfAU
	pZNOUj+tpAbOPr4M/Ub8GnIQgffLDxURkYRVKiVipv4idEfKnmYUfUe857CHNY6we7EiDxODlMm
	0t9eaSWRCjX/O7UkUuuOY87uSuQbqPSKT8np+L///t2xr9hsdS5kAEcnmUuERHsraXYRT3Z69SN
	E66HmD6HaZaQh95YYivV+xK8DD/unp5GkUqPnQB8Dxn4e373O45+gAacFFR71iUQlbRr7UqDTYS
	xYFTLC2eBDDtzjNsRf6BUydW6dMytwCuY7Y3p4Xev9DwaIl3/pxlnXUrP3RrUnOU7McM8rX1IzZ
	urkuPX/51QaSv1bS+DRnuFEH+86s5U4FCIzQVDaLMPQpSkU9CEXe+kYY5mMW4nx0o4Uic4JkXfr
	OoDppVwdDYpHuQd8H3Sll2sBoPX1kb479DDqXQ=
X-Received: by 2002:a5d:588c:0:b0:47f:eca7:ad1a with SMTP id ffacd0b85a97d-47feca7ad3fmr32925617f8f.1.1786084662881;
        Thu, 06 Aug 2026 23:37:42 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:5ff3:d0c3:bbb9:1151? ([2001:67c:2fbc:1:5ff3:d0c3:bbb9:1151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8d50sm2630859f8f.24.2026.08.06.23.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 23:37:42 -0700 (PDT)
Message-ID: <937f09b2-cd5f-4352-90dc-dad67ef8ddf2@openvpn.net>
Date: Fri, 7 Aug 2026 08:37:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: pull request: fixes for ovpn 2026-08-07
To: syzbot ci <syzbot+cifb58fcbd8413e765@syzkaller.appspotmail.com>,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, ralf@mandelbit.com,
 sd@queasysnail.net
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <6a756ce9.01d0871a.3a0d52.003b.GAE@google.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <6a756ce9.01d0871a.3a0d52.003b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2026 07:28, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] pull request: fixes for ovpn 2026-08-07
> https://lore.kernel.org/all/20260807002250.1817498-1-antonio@openvpn.net
> * [PATCH net 1/4] ovpn: fix NULL dereference when killing missing key
> * [PATCH net 2/4] ovpn: finish crypto callback cleanup before peer release
> * [PATCH net 3/4] ovpn: run deferred work on a module-owned workqueue
> * [PATCH net 4/4] ovpn: defer key slot crypto freeing to workqueue
> 
> and found the following issue:
> WARNING in __alloc_workqueue
> 
> Full report is available here:
> https://ci.syzbot.org/series/a46f06c7-f8d8-4053-a746-91498a46c290
> 
> ***
> 
> WARNING in __alloc_workqueue

This is indeed triggered by 3/4.

Will get this addressed and respin the series.

Thanks.
Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

