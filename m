Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A372423E9D
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824593; cv=none; b=roZKAbIyJOdqr1/YVyU5YwZwtI5eNJ1WrU9KH08gXtKaCs2e+ea9a3xxLncnuSPtKMtQPOc83+fl8Lrxj0EDsQRNckKHlpvnxYsTVgAOONfO0P8iqhTKOwsZVn9mTKhuMXqJi95aJgzxJdbl+dCxAN3onCYwsECDjt3cHZqBYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824593; c=relaxed/simple;
	bh=XVwxuwVv9J8klcfz+P0rkEtNX7AV6V6/RcSwg0haeL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPoOK19qAfvcY59Hz3MAbMhW4hjtM3T48omi7aWkXAbjAPsy+x9FEx4dGVfiNcsuh02zh9V/8MbXhDasx/uvwKSXmS7q7kZ9dqabTAjKaNBgSKQurJcb+KDbffXhEFNpElcJPD9mYtdKjnhij4hOcrA2A1BPWPDiA9LvvXzqNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Uz1FxSCi; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Uz1FxSCi"
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C69113FE2C
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787824571;
	bh=twtaGX9keTthWlD8Iz9JDELL7y9v94YhHTzfCCgZVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Uz1FxSCibNfL4jH0ATZjeFge2Q8AfHnXFgIon3LvgJFa9X5r+o9X9DxaIzeeDXvLz
	 iKrZsg4vDPeGlSThaJgSrnQAkNJxgXha8EF7knyLsoM3IbuIB6Qw83YwJxHm2JGLBI
	 PY/z3V9YKWdYOue0M1OrzJiNlVdN28W27MkL3tUGspR9HmA5YjuO6fgCRCPMhKc0Ii
	 vDajfBt9sWseooPPiEJAoWsrOMR8gYGYDKcMa1oLNLKDaByzEGKJpK91A1PLib8eyu
	 yeAcQ6Y/J44bUIKXuerf0gTU75KO7Cvlb48APu0vNZ6qy/fPvgNq6H6OzKiBKHNqT7
	 TapzUZtFknij38LIlzGoi0YYa9qwLfnmyAfqKoBS0ptCJv4MRxbvmNxaoMwY9BKlx4
	 8aUm0WrXH2UsbqQuDsXY5a5jFYrEog2SrPXDl0f+hIyX7LxwMaJzMYKvQxI+hr+3JL
	 zv9DTUan40+RupRwsbrn5Fai7/suDhOFeHS1cuLLwJ2ySb9s6fVrOPvLwbst/Z3muQ
	 fXVUPcnHiRavTFeAe0sPzcq1HZ2Mwz4iAv3q8WU2IkEUq178Ezt+nMlLT7uEyzPcbS
	 lmFEAP+7GZZ7pMCEJSlpiM79Wr/oAdpq9v6VHTHerS+36DCU7lHhyJhiKKrsh1z2hy
	 PNraum6R3qMo0+Scjg5SF/zU=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so11802435e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824571; x=1788429371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twtaGX9keTthWlD8Iz9JDELL7y9v94YhHTzfCCgZVkY=;
        b=gizBr3hPDTjCmcCULFswmnrF9mPK2Dsq/ebYyFWcTv1GKgaWKP+rkjAnK9dPJGzIMn
         gfsZsSyiJ7zn5lBVEdnXqsoabsJZhFdrCLR97BJt52dfvZ164T+bW1Xi2LK0u9dswolc
         k4cFORiUvNc5EE9dsvxVAPEVVZLt8i16Sm6D9mmP/9+ILWcEvv5pbT/hWXxGZ4pvWxbN
         bXbarSsq0dvfog26FRWzAcZYLXLex8lGsyMlRbm7EAflqn4wnWa+kfgYxGTpRf+x4bo3
         1Np2wNo7J8GqsNxxtmdKeheByiQwi/LvdMCZ6aWzDsPA+W1FmKTb9TrXzWGFYuqMmmdR
         LL7A==
X-Forwarded-Encrypted: i=1; AHgh+RrSUb8fnu5fZa7ln/7THNMkZrGzXubLNNFQiVFSpcfr0sGZTYLACZfkVo23vvyT88tY9MZC1K4=@vger.kernel.org
X-Gm-Message-State: AFuF++nlaRXki4EKefZ/e76xLLBJ5qo+EYQinW6YK7EZnAC7hE/B/1wj
	LeDuWv5jOw/m+atBK4dSG/r4rGrjFtRgRrhJZke2ync7/GZhZn7r4N8aQh8o15WvG54YFrA7eG4
	sweoiw+AhpA8ThaxUm+4GvJcq/ajZsqC1surOLPX2h/R6Lmn/OJHvE/vfL0vHfsFkugb20x8a5g
	==
X-Gm-Gg: AR+sD11cEKYI5KGD7sDalx3apXv5D9Eh5OlHth1BSU5NhRITvXNDIeEQqlJM1IMUEUn
	Do+H+1JoeKME6AdScUbt9Wa7cUgWwRIpoI5jfWJRG/Y4uk28APdgN25H2TPO0YLo8x1hjfP/fQ0
	0HYpv8DMO4N7qolEYUU1d44JlBu4tMIKpH94UX6+AxvJbb/KCeHSbQU+ewiKU+XjZh8eApmD7aT
	VQdS5wWqqLS+sqlRfsi9D6zAQ6Ov2L5+nyOYtbpnpBupSX7/WfNRm4+rw1nbdve0xhIESsIqFPC
	ul7tp1XBoki3OjzfdH9cX7ly4BUPSj9YN3A8FnkjZhivQQTlsjED/K24GhZngkOzEpG4DBfj8Sb
	7T1zJUEpvyPXwRjyWyqZ5HZ+jS6uhu9046LlYbmpteLMQOSLCMLixgs62JNzREpN12+U=
X-Received: by 2002:a05:600c:3acf:b0:499:db5a:1049 with SMTP id 5b1f17b1804b1-499dc70246bmr162323665e9.8.1787824571167;
        Thu, 27 Aug 2026 02:56:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3acf:b0:499:db5a:1049 with SMTP id 5b1f17b1804b1-499dc70246bmr162323025e9.8.1787824570756;
        Thu, 27 Aug 2026 02:56:10 -0700 (PDT)
Received: from localhost (93-35-56-63.ip53.fastwebnet.it. [93.35.56.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b497fa9c5sm36964705e9.4.2026.08.27.02.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:56:10 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:56:09 +0200
From: Alessio Faina <alessio.faina@canonical.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, hangbin.liu@linux.dev,
	stefano.salsano@uniroma2.it
Subject: Re: [PATCH net] selftest/net: skip srv6_end_d[t/x][4/6]_*_test.sh if
 iproute2 too old
Message-ID: <apAJuZzDOvjkVx60@cicciput>
References: <20260824091537.2305107-1-alessio.faina@canonical.com>
 <20260826000156.bdaa71db68dbdc9c13907205@uniroma2.it>
 <ao7S04LkWVXAQpgq@cicciput>
 <20260827030701.bfaf6eea6dea1aef24c353cf@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827030701.bfaf6eea6dea1aef24c353cf@uniroma2.it>

On Thu, Aug 27, 2026 at 03:07:01AM +0200, Andrea Mayer wrote:
> On Wed, 26 Aug 2026 13:49:39 +0200
> Alessio Faina <alessio.faina@canonical.com> wrote:
> 
> Hi Alessio,
> 
> > I was running kernel 5.15 (5.15.0-139-generic).
> >
> > Removing the sink to /dev/null in check_hs_connectivity
> > I can see the following error:
> >
> > ------------
> > PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
> >
> > --- 10.0.0.2 ping statistics ---
> > 1 packets transmitted, 0 received, 100% packet loss, time 0ms
> >
> >     TEST: Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)       [FAIL]
> >
> > .....
> > ------------
> >
> > The error I can see upon installing the route in the setup is the
> > following:
> >
> > ------------
> > Error: either "to" is duplicate, or "vrftable" is a garbage.
> > ------------
> 
> This error comes from the route parser: the seg6local action was
> parsed, and "vrftable" was not recognised. The End.DT4/DT6/DX4/DX6
> actions have been in iproute2 since v4.14.0, but the vrftable
> attribute only since v5.11.0.
> 
> > I can see that iproute2 doesn't support any End routes
> >
> > ------------
> > ~$ ip route help 2>&1 | grep -qo "End"
> > ~$ echo $?
> > 1
> > ------------
> 
> The help text reports the names of these four actions only since
> v5.14.0.
> 
> > It's similar to the case we added last month(-ish) for
> > srv6_end_dt46_l3vpn_test.sh.
> 
> End.DT46 was different: parsing and help line came in one commit,
> so no upstream release has one without the other.
> 
> The two DX tests do not use vrftable, their seg6local routes only
> need nh4 and nh6, which are as old as the actions. Which error do
> the DX tests give on your setup?
> 
> Thanks,
> 
> Ciao
> Andrea

For the DX tests I was doing a local test but it's not in the original
kernel, sorry, I must have confused 2 tasks with one, so disregard the
DX4 and DX6 tests, they are not relevant to this issue; if we manage to
agree on a solution for the DT4 and DT6 tests, I will discard those
modification in a subsequent patch.

About the DT4 and DT6 tests, I thought to use the same method as the failure
was practically the same as End.DT46.
This is the version I'm currently using 
ip utility, iproute2-ss200127 (should be 5.5.0 if I'm not mistaken)
and I can confirm 
[SEG6_LOCAL_ACTION_END_DT4]		= "End.DT4"
[SEG6_LOCAL_ACTION_END_DT6]		= "End.DT6",
is available.

What do you suggest would be the right way forward to check what is
going on?

Kind regards,

    -Alessio Faina
