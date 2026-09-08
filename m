Received: from mail-vs2-f9.google.com (mail-vs2-f9.google.com [74.125.227.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF4572685
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882884; cv=pass; b=gLne2oftx6Wgt1+BuusN6LSzGaJKK4yc5PkonJfwx6Vvv/GGzvq7hbFQrqovDUxT7Q2D76JmhFkDKn0OQr0HfI4n+YDQqdqCFDAVJAbXFVWXgdO5I+RTyQEO6WRAVoS2TyJB/IBOhfnGPLRhVvxJe/eKK6EBRPsPbCSOyhdit/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882884; c=relaxed/simple;
	bh=m8naGFUUK15OK7RhREJs9bWygJEJ6IkQJ0hS9/AKPmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgbLvOR7mTtfTYSbaK05fcvEcqblwffPKu5Vt60iqWx7CpdtiwuCX3PC/d6lP+15Wv1LyQkcbK7tph95Ayj3Rxrwp1zscvdgjbDBmu2g6vjXKDDMXTb8zkIqdx1/pQjSGof+u0hluYem96KNaXWkf1xbHRv4fVfwwad83CCulW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peXBH2a2; arc=pass smtp.client-ip=74.125.227.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peXBH2a2"
Received: by mail-vs2-f9.google.com with SMTP id ada2fe7eead31-7860d691997so802337137.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882881; cv=none;
        d=google.com; s=arc-20260327;
        b=A2J3UIjlw/lweT6VQPDZkZBgdcYeZiJUdwFkQ0VOesG0G9PcjZycMxbtsfahOPHrI6
         aBtCSgLRnUXFhC/pjeD1DLLZnx84AlK2yP7fmy+Ek+Yq3aEnk5Bnj1oHKRA9sbi6ayla
         KPs7pzf3xgSGPs1O5Yu6KqRDZvy+44qQYfBjIwVS/ZNSsikEh6/rTKwUI2KkrCLcowjr
         5yCVrsm7V2YilKI5sXnmdiNQFH2aMVXwvyzC0bQGOncaJmd8R/9g2Ol8Uiia2fta9ZfP
         8IrcT2YIeffjBVM+qFyRQycg0Orr4INdjSO5BC7qn80aA4gKzo6aQTdmVe30ij2vM+oU
         TI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m8naGFUUK15OK7RhREJs9bWygJEJ6IkQJ0hS9/AKPmg=;
        fh=gfWd0mJQm5lfyp272QybPbqOGwfK0bNqrKkrvUR9P1s=;
        b=ZtXVVYK98aJlFo60g/dR4dvXfr25+pSWOIpbLvXjRBKn5CztHCFwYvsxzaMv+ar6EH
         PT5axDhQshzaaULqgnuX2tcd21xlq38nSnNDQ4MKj/bsuUHQ7uEkz4Ajihwea191bmqd
         n9h8Y/IKW3TM4vVt6qCr5IRDIXvZrsnTmoOcAhfvvARIEoYQvH8XC0ssUSwdr3Kb6nz7
         OAqfAP4pqQNla/DSqEPHu83hxEFvV//BnY0b8Jd64j9YYNBwUg2t1cDmMS+lHobmPBCf
         lF/hy5uATZM7PZFtX2LJ0gQtTAfd9nqjPg1EoNmue3A0KmlTYQ2AMa03JwiRN5VRZfcq
         Jhaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882881; x=1789487681; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m8naGFUUK15OK7RhREJs9bWygJEJ6IkQJ0hS9/AKPmg=;
        b=peXBH2a23fSed/p+ckB1kajRvnn60mDjJi7RJiS7nFs97gWq/6m66ODfJnFPFrXkvi
         Rsx1Wp0OQFM+zaQ1Z5s8/eNBEhHkQFqEON4+ODNyREVmVvSIHsjdLPjz2CJ41GrsqVBH
         J8qiQj2wDk3flVW36QwyuVSUG7ywKXFAAlY0rDSiJrSZNctOL/Zrjd3HPx6S7QeO7AuF
         MCRfuI0EAlgxbX16R/JnwgTv6g6MY5pfhr8IzpNLjOE/Tpy21viLrqoDeVTPEasD+nbS
         zTGMF6Km3EvbttKwc63XqjnfLv/8+SZhPODhHHc3c9NXeUmuUOQx8NdqxeSZpVv2GhlX
         VcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882881; x=1789487681;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m8naGFUUK15OK7RhREJs9bWygJEJ6IkQJ0hS9/AKPmg=;
        b=E3yl7aliS4EphSmjXD7G2UMym/2HyItPJWdaQoQAnl3ZEkLJU8fyAGXMLr3FEzBVUR
         cNluxHcpqieeq5CoLWO/2UpsvSBORZDassd6t6B4SXQfEVujocf2T/e8yMUfMLvtiTft
         Dv8JQElp0RND1JbgQ3zxmWIJEEAyZpMiKYZL8d4WrC4FwPQesieFG90LW1ZVCFP/lh/l
         K34TQP8rlmxKcm8atmzgY7YfcFLMDNY+Mo9xqdBpC9jqXxvJiXE8n/pp2wbqhDVYY8XM
         8AnHSbRS/akHcVXcNWHdguR0wb8Yhprwb+ohiYZc1dYtzo4zXfLyV0GqJ915d+sMZS8J
         GsqA==
X-Gm-Message-State: AFuF++l8NoLey1aOXEkejqhPAg+upp/fylxFszr7wlHUjtClA5JnenkV
	wF7n/wa39VoyBFzkRILIXSwA8wIqnvxczYEzCtppMzXIzrzVuQ8gfYQf3i3+XI0oZqVMGOTGz3C
	vi0lCi+IcUXO50q8ASzigCdWsKW430F4=
X-Gm-Gg: AYBFou2+PErFHywFfxlOHWIo2bzr5hmyAQli7y/8tXhfNT8FDJRuivZKjwnoh89DuBd
	aRb65HSZ88FyERF8PU1nYqWAPO1ewQ7JSBIQo4uj2cKPgjucGRe18b2qpnEAirG/rBbtkGt+Grt
	e+zxZsi8SOY3hmnQ45rENJiHOP1SV4LndDfZ8cNO1LR7u2blK6Ygl0QYVCssrW75qljJyW556ct
	QHJOtF+XATVa2YM/g4El7SgoIeatGtVb0eh9NEPg6RuuIJ+4OxAW7R06oY8xO4wRlJFU65mmeNq
	xj57sr6mw52nUHtkDN0T+N0t3ydnRbOsB0kQCp8xnMAXIbs=
X-Received: by 2002:a05:6122:338b:b0:5c6:5fff:f2c9 with SMTP id
 71dfb90a1353d-5c7ed41c953mr14439622e0c.4.1788882880956; Tue, 08 Sep 2026
 08:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823142620.126424-1-shlomojune6@gmail.com>
 <CANn89i+5o16tSTk9MpLE24nCAn+SkMeZvHv0W=MqxnXGZDBBiQ@mail.gmail.com> <CANn89iKck9W0KB8Sp7OFDQ+OTFJnBpy=jsmQbZ+VYhrm8yOUgw@mail.gmail.com>
In-Reply-To: <CANn89iKck9W0KB8Sp7OFDQ+OTFJnBpy=jsmQbZ+VYhrm8yOUgw@mail.gmail.com>
From: J4f J4f <shlomojune6@gmail.com>
Date: Tue, 8 Sep 2026 23:54:28 +0800
X-Gm-Features: AcwNN1XPIJ_-7f0UpmEHZhNDAtBZArjkgFp-nC_du6g8-qb2zRaLlPZ5d23i7Vs
Message-ID: <CAE_LbwkoQMYLXzOi_RwMcxuNy=tMo256+Xj2Ac+0W7MbAv2yLg@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: reject invalid pull bounds
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Following up on this, are you planning to send a V2?

Yes, hopefully next week. I have a few other things to take care of
first. Sorry for the delay.

Thanks,
Shihuang
