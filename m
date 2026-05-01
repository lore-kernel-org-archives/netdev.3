Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE9717A2E8;
	Fri,  1 May 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678600; cv=none; b=qxKE6Do5wH2fc82vV6PC9AXH729v3T+39Oi7hpEVNjgWMKxLSwzM5lfqnkP6/k8ieH0/JXSWcY2kzDcZ5ZUaLIHTi/KTJWf9nlkVXVm/j22iHA90XY3eKiUr4VNNat5YbWzTWP8+29NJbm78OMPY2FTJt2AfmrsIz1DdOk6tfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678600; c=relaxed/simple;
	bh=sfKTAy45KGdcbQ+fpQmYBbtD9oTakEV5Ut6Tkg527Pk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T5p7pSPwmqsKsSFHt9/rQ75B3YugJXSM3GFIzgac/rbCNKipsHlMIrdO/nG/BVwf3T/OENnRAshIwJt2PeyJsrFEe7Yau3jNkLzBG4eu+KxH/XDwSRRbAq4vUG1dY7TEujRHrMoPVJXnZEajqp8WP6tPB+UHLrUFFxt5u7a9mco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=V89Mq3ov; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=HMWjUS8L; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="V89Mq3ov";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="HMWjUS8L"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 641NZvHp029829;
	Sat, 2 May 2026 01:36:03 +0200
Received: from lubuntu-18.04 (host-95-234-63-151.retail.telecomitalia.it [95.234.63.151])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id E2028121E1D;
	Sat,  2 May 2026 01:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1777678553; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6eaKQF7NSay9kmw+yOGYSulQfPUz+ozbe5ZJlAcqvPQ=;
	b=V89Mq3ovUMff3xdO9khgewd6iaBYMUZ3OarW5YQbBAY1v8KN4xQgcmHge+Nl9b9FYDNNZx
	TC54k/KJie4eiiAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1777678553; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6eaKQF7NSay9kmw+yOGYSulQfPUz+ozbe5ZJlAcqvPQ=;
	b=HMWjUS8Lc/q/gdfujHDSeJPvOZ6WxpRqlWfMeNApz3hzsmb/A8HRMmVKi2FLGs1nD5oISF
	OFWEXv9DDquEFGTOtpASrNkOpdwqWjmTbRbF1nHhfmElfVFpjCXwVypiV7wln7Z/K37Cyl
	cDzJRGxyFWVDn53UnUttNRDZHk60u6OZiIxqVQvRdu/CyjO10H/9XbaiBh1qAR6YJc0+mQ
	VZxRkFoPfsE9Nm+V11dbZqW+BNOgdlhgzIwaZAmsxX791diCX6srNMrKl4vnhkkluZKZtk
	SzHqQ9DIayhW5CXxJ8dj2pDJ+RHoGaT/39m4xsRC/HJlFz+HO2pyRR8hhdHJ9Q==
Date: Sat, 2 May 2026 01:35:52 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Alexander Aring
 <alex.aring@gmail.com>,
        Justin Iurman <justin.iurman@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stefano.salsano@uniroma2.it, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] ipv6: rpl: add NULL check for idev in
 ipv6_rpl_srh_rcv()
Message-Id: <20260502013552.3efdef15b7a6d2d84e1610ad@uniroma2.it>
In-Reply-To: <CANn89i+dSEkqgbvsonrC5V=e-vnMPVNdVnD+0KdkkAxM_kxEQw@mail.gmail.com>
References: <20260428224816.11223-1-andrea.mayer@uniroma2.it>
	<CANn89i+dSEkqgbvsonrC5V=e-vnMPVNdVnD+0KdkkAxM_kxEQw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 28 Apr 2026 17:24:05 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Tue, Apr 28, 2026 at 3:48 PM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
> > [snip]
> > diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> > index 03cbce842c1a..e398a8851031 100644
> > --- a/net/ipv6/exthdrs.c
> > +++ b/net/ipv6/exthdrs.c
> > @@ -499,6 +499,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> >         u32 r;
> >
> >         idev = __in6_dev_get(skb->dev);
> > +       if (!idev) {
> > +               kfree_skb(skb);
> 
> I suggest:
> 
> kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED)

Hi Eric,

Thanks for the suggestion. I will include it in v2.

Andrea
