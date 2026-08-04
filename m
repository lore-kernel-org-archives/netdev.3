Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AE342146
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838760; cv=none; b=u8RlQqneNlbgq/tJRvwXbTrujzF0e5q6MAKBcoM1Y6zYZRriFfjr8Xe7nGsxkd9Rc7gFN7iycmg8XIQilBKybi7s/KQrBY0az/CLDvuQgX/Yj9grOx4ngosudrEryOcf6MpDCNsfb4kGvtBi3nPjx1ZvstR6tNVqZGMiI5yFLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838760; c=relaxed/simple;
	bh=rO36GVN64WHNqbVyi8xR3ssH+UrxA+spsPSLFO/xXTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeJZ3fwUQElEO97DKh12aE0Qawgy1nktyDr1g5NHTBhKCy/xZj/JFnF894zVD9W/iMl9FKsGGhVPPO4nfBO+kDwdBOdMGp9x9q7Jp4JaJvh0e1bB4vgB/AYkF4xXgFLoMdl6DX0Cmx3svLHwIqCGS3wRWMCqPluw72+wYqyPVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRHnbMCf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nrDk8yI4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRHnbMCf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nrDk8yI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785838757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzb00odwnuqamB0eFtSgtNSpu/QbK+4/YzTl3UzECKk=;
	b=TRHnbMCf93fuugwETmK/ejOvOzuRQXN3jwhapCEl60zGz6hItpKLrf7Saq8zJMKyJyFblR
	Fuaz0O5yslPG7qGMGSekr9/5h7/ay3zYBtb5oQgylgRCD/3Hpp/bFfs2apqpY38DQcLjAo
	Ci4poFeIQLsb19ggk9JHT8oKdNE2BIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-9n4xeC2FPM-45bZz2riToA-1; Tue, 04 Aug 2026 06:19:16 -0400
X-MC-Unique: 9n4xeC2FPM-45bZz2riToA-1
X-Mimecast-MFC-AGG-ID: 9n4xeC2FPM-45bZz2riToA_1785838755
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f90dbaf84so3903532f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785838755; x=1786443555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bzb00odwnuqamB0eFtSgtNSpu/QbK+4/YzTl3UzECKk=;
        b=nrDk8yI4zLAjIAUlhaVZ72EKyu2NE0uOr3+G4aFpJyMUNoMfdCJkwjKMKAX+ImgckG
         2Pt/enen7993Yag/QmMOVkbNWaHzsl/msbS6rlfksD909+aNU7dQviBLfYhI/a/Kf0Ee
         63Z4Evn55o4Wh4ikm+wxzUMxJPZGBEkhrxxxqtuff8tNS5BlIy8PRsMWb/EsrkAbZkem
         GKNAfgfQNQpA8BHpgTW2aAs5vMfMwanMJSHVw4Sgh+34PqqSSaq4KMwFTAmd5fHCyIxd
         FtQ01i9eViaXIGNCjZwQ9vttQRr8vpqZ152aL8rTCyMDXe/ryaIWpNFY1BC323tUicat
         DH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838755; x=1786443555;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzb00odwnuqamB0eFtSgtNSpu/QbK+4/YzTl3UzECKk=;
        b=nfBdEfTC4XtmjjxdFR1A7E+n+/nEAkX0Ey4L7mXj1cSWbOT5Z875f0Bzfkv0Wfshxu
         PGeHqynQB7pM2Nvi1GIq8D3eMGBAfPdryWAnclQJgp0KUlJ50oQ8m5LtutjXc6mwo9wl
         PJzXYUGG5s9vJyua0pioK/ZKRaIE2n6/B4WvP4UF52ZjeEs7EeObkiZH34J0RT71RNcY
         q8XglL5QWP0CkvPydG/M3tVJ6CVLh6Hgery8efGZ4nhpvXhA79p91ehMGXqdJelXucWr
         k2Xk394HuX05zL7KmZry9VaXQ58d5BZAh9d1U34t2eLkEt22JvHgz1yirooFj/pc3VcR
         6fig==
X-Forwarded-Encrypted: i=1; AHgh+RqGQUpmG7o8A2goN/r5kJ1W4ydX/+WpWMkxP6uoZimOzYFnDkrC+XAcZIf46JYJYAcwprcDnhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykebvtjaCeX5fcZ/htVQHL2B2DDpUxwl2T3MaUMCD71aI9luU3
	1Z6z5xr1Uq7+IgyDcYVYbqJB3OllZPmFyXYdk9uTAADyKLg3wLKrYPy048tsrOY5MP0cxl56gbE
	0smOB3ywYIZiWgyNAC2eXjWrP49srqxiswqrPySXNFhwoNJdN8l7T8ql0ng==
X-Gm-Gg: AR+sD12ZVZSXgX2aTUylvhDhmQFe0TlPWRbTAKoGXsIrYZf6Udit/cArF0F5tmNi6ZU
	lSSXdB4yIKVQTnRNMEFthJMvKo21dkFuMhnJXdJl9aagMXQFvD3RTTawoXFc3mMpe3G3/b7Kr2t
	f97Hx9f2wuDNDwDa2lcnhRmhw8m6u+PLHXPMHyzYnjIFrYS5uCFP2LgoFDd58ZYEKIAo2BGDgg/
	cwZAoY3iLlgXYiuy2u4rCsQ+viMefg2QQqxY7Tlg9Lu4BUWalJfOhERCM+xrEfNJm/5DdSk6gb8
	ihmn23PiQQV87wgPD6DROlEhumw+6bjfiDy191GbnRttjYgcT+lPK13WCKX+EXxAWnV3RHM2nhR
	paavxW43HI2YZhMHlzZ7/wDb+4HjzqlFzSbYkiTvW5ody8Gu4kjozG3f2DuHDVjBAYlNKU7Vhps
	8=
X-Received: by 2002:a05:6000:1886:b0:47d:fc20:e7ab with SMTP id ffacd0b85a97d-47fd729e70dmr35637173f8f.4.1785838755216;
        Tue, 04 Aug 2026 03:19:15 -0700 (PDT)
X-Received: by 2002:a05:6000:1886:b0:47d:fc20:e7ab with SMTP id ffacd0b85a97d-47fd729e70dmr35637081f8f.4.1785838754815;
        Tue, 04 Aug 2026 03:19:14 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1a58sm41800360f8f.7.2026.08.04.03.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 03:19:14 -0700 (PDT)
Message-ID: <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
Date: Tue, 4 Aug 2026 12:19:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
To: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20260728133918.643267-1-sw@simonwunderlich.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 3:39 PM, Simon Wunderlich wrote:
> Dear net maintainers,
> 
> here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.

Note that it's preferred to avoid fixes and stable tags for changes
targeting the net-next tree. If the fixes are really minor, both could
possibly safely dropped. If there is some real problem behind, such
changes should instead target the net tree.

Can you easily rebase your tree and adjust the PR vs the above?

Also note that sashiko nipa has something to say, but that could be a
follow-up, AFAICS:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728133918.643267-1-sw%40simonwunderlich.de

/P

