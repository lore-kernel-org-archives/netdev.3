Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB243D4FD;
	Tue, 29 Sep 2026 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725187; cv=none; b=XLWSSPZhnIfv9ZrfmYFHegzLEg5ppPDzsRe0IlSYvfOhhpg2anzxrwTj3gwGm5PvsizqsSBBDlnsTkTQy4JVwNXxPcfr9FxSW/CI3wCcB1j9vp7xilAO5Jm/5ehc1LRdwvjsZeC88Ss+wB4bhSBrdpCdo4R9bY87O+QqKIFOupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725187; c=relaxed/simple;
	bh=/ZO0HV1CHAVxHhcwpZu2/IgbMnvUsZ6FcDt33Df3jBk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kMtfodLi0IcnYacXtKGR0cMQm8BVYrrwiA40MKyOtaErbM3TfE/jrVv6Kk9Mal/h10+tPtS7x5LmKDPsbqb39LMzHlowcDKYYjan1wuPzojwb8t7JHGrp2Kw5hRl2Pve0qT8yCPURW2wZgyWKoggShIE1I3MsPVIigyiP2QSr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Td1Ui6ET; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=ZpS1/gLD; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Td1Ui6ET";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="ZpS1/gLD"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68TNdGTX030368;
	Wed, 30 Sep 2026 01:39:21 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 4E31A1228D0;
	Wed, 30 Sep 2026 01:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790725151; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYnov7C+eQCVb8E/UF6F7bZulO2iyu3Dr9Y6cOu87z4=;
	b=Td1Ui6ETiJp5CwrMi6glMBfX2TgBEYxVc0h7nA0A7ZOGgoiWv15vp6eIAYv6Wioe7OXrIH
	iIixEgCLmhM0olBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790725151; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYnov7C+eQCVb8E/UF6F7bZulO2iyu3Dr9Y6cOu87z4=;
	b=ZpS1/gLDKqAwsUIz0j9h7VRuhzzIqsTn14VHGe1utBlCGPFV23RqYOHMwovx2PySmzjn3/
	UY3p4Nu2OgOl6xszd0cbAR/YJTngfMJr+/DuDE1s8fpHBsti9ZFzy4IFtAMPLXdlyYtaUj
	zIV/+R1VX80y7rODWAK+RQFl90j///ZWfKmHhKiqf9i1TRROQoPIgUWgwj/yyegClreYoN
	bYSCG9wXhCeqF3Yy6+uyBVTcskcd3NaMZK8oxwAN0NnkFHYNS1TFi3hvMAfz3Ft9wPjZ6y
	wQ9Db+Jhcc6Z9tfzZs3CCYqg8M2JHD3qGIrmw/Su8dRWsWJ27TwyuRJAOGs/2g==
Date: Wed, 30 Sep 2026 01:39:10 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Lebrun <david.lebrun@uclouvain.be>,
        Stefano Salsano
 <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: ensure packet data is writable before
 modifying SRH and IPv6 DA
Message-Id: <20260930013910.ef20606a1141e83edeee0771@uniroma2.it>
In-Reply-To: <arsqomcYCLJqtWSC@fedora>
References: <20260925133807.32-1-andrea.mayer@uniroma2.it>
	<arsqomcYCLJqtWSC@fedora>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 29 Sep 2026 11:05:02 +0800
Hangbin Liu <hangbin.liu@linux.dev> wrote:

> [snip]
>
> >  static int input_action_end_core(struct sk_buff *skb,
> >  				 struct seg6_local_lwt *slwt)
> >  {
> > +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
> >  	struct ipv6_sr_hdr *srh;
> > +	int err = -EINVAL;
> >  
> >  	srh = get_and_validate_srh(skb);
> >  	if (!srh)
> >  		goto drop;
> >  
> > -	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
> > +	srh = advance_nextseg(skb, srh, &reason);
> > +	if (!srh) {
> > +		err = -ENOMEM;
> > +		goto drop;
> > +	}
>
> The srh is not used in the later function, maybe just
>
> 	if (!advance_nextseg(skb, srh, &reason)) {
> 		err = -ENOMEM;
> 		goto drop;
> 	}
>
> [snip]

Hi Hangbin,

Right. Since the patch changed advance_nextseg() to return the SRH,
I updated srh at every call site. Your form works as well where srh
is not used afterwards.

Thanks,
Andrea
