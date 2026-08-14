Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6446A618
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711664; cv=none; b=DAMTlRJmDo4senimcbmoJV57anLsLyNCMtayVuXgWk3B+Gl7lKC4kOzQwPeRGwgz85rcfsZpsJ1rAaSDbT1WBBU19nFFOAkfR5KMNAvNJv3rNXA+a023siHbLebOdCX5FyKJ7AhkxsL1Zb0N5zVtqbbXb0tJ+s5Qha9uE8SIJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711664; c=relaxed/simple;
	bh=xvfx/moOkT2h4GZX1Fs/7NTDvFkIDV+3cyhwuuNPRqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUDr7YFCzwr0heSHscYpXqHcP4rayBCHEkBkbBZkwuugWuthmnPPkonYpTjcnRa2iFxHy0P0aqr5Y2fZ1IkYK/vtmT88RNglpcm5Skk7jcIqL+z96cGGUU8YHzdSvg/o1RP7VMxDlqzQA8EKkZWFAWppLHN40mB4VMJHgwxTITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKuXiLT0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKuXiLT0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso650834b3a.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786711659; x=1787316459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y0Ss5UBO53f0Pcaxk+k2Mmu7Q5/xIRbA3U9GF2OMgG8=;
        b=NKuXiLT00X3Xdmzryth0cWcc84Mvz+fdRWeyd8jVzOUqh4/MhPKObpoD67ZbyUeI3p
         IJMjREvZNgIbLa3PXV8GF2b4YXhMff5Dr7a0PKHhF/d2t2N3ZyndQQHPjkI86pLUZuq3
         ism3ogaJjSWm4HfFQ+4Dq7mKeK5ieNWrjKTnYH9GoHyU9WYTND2eXxMwJbrmTYxskvXj
         3Zhbf3yFC2g73ZupXO97swXSQIZWrnqT4HBqJBsrlCahVXPdul7fSDeYrGYw+JB8UHmr
         8asab0oMkMgjzKsUH59Vnjg9jXIWBYxSYlBO8xMkcQdDwKY9apkp8SyTKZ0uQayNx47c
         5Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711659; x=1787316459;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0Ss5UBO53f0Pcaxk+k2Mmu7Q5/xIRbA3U9GF2OMgG8=;
        b=bINBa96+IATpEgG/46zLK9meovJwppdNPylTio0H4uEXA7wd7+EzUjVSCmWFgBPo/j
         HNBjbLsWm9QtxSBSDiPhDQe0UNSMz7ykkvEefRMnXzRqW1UDGw/yuv5psqJllqynZtB1
         rnQzSXOyaCS9k4tVl2apL/b/PoOWCl856MbJwCeQTvmlgtZ/N4c9wGRIFiWM2l6sEicK
         +Kq/ppzK5fDG+UCpQF1P6jNutwtBbssTalvEcWS9T75UFuCbC5LuEiYojeblqiNBLWct
         uA6EKv8b5TnnlzFh4FhXFke1DBfNq6JWRCtA0NMqKvI6RxD3bp9W/16p53X1uKzTu3Hc
         ZW3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrBkFnK/PpTVx/1m3spL6+Dpn96a8jMcZWa0oWtyz9DD2N+cC4TeOEvhWOXAL9odCFRCqsfd8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuwpt+JrdiILxU1PN48o7Hb/I5cFHssV6I7vGqQeykQZ3/qnxs
	YDeFZAHL+3A6HDWUjJ8R1t+6FQgN4o3Imt/o1M96MhxzsWyNdAD5b3eI
X-Gm-Gg: AR+sD100zaVZuAtf1HSrY2F/xRJSTWzaM6874S93JRmSyj/zRyW+yg4yym1d1Oxq5wE
	FAiJGNjlFb/oYIrFYPjzksocmCdeHdHVED+IAiGakUa6W4ZEr8JDEMLq6JrhpUCYIhjUpKgSLkr
	dX5CgGLQYlCvCRi2X4T9qpCMQdLexfaikg93UP+rS9XnhbgJvSH+BVX1CY+aAwOgtqdbFvOmpVt
	WMRJ+KrkhwYWRdHAMpif0RvFs5laVYoe9uVGIi0XG7mxX8oItD4S6RDtWn+NXFYFcZYN7Qy5MXz
	jSTecm54u3Tja9e8wUBPyk2YxNIxHEP6xbJ3naUW5SToiMQPa1Fy/MaJGpXiYSLZAuatw1Yh8cQ
	hKWMMkoV6aML4E1e2Hn0xPa3Jjnhdvg8SmQtlfwM6RsRP6sWATvsZoPNfVJWgSFhhScnVdEognN
	oOn4faCKqr9DFRandLaYlqDP8alhEr8vn0rLL6tJWy6QX589TiVzG4WFiZuCdNilSaGg==
X-Received: by 2002:a05:6a00:6087:b0:848:67ca:bfd with SMTP id d2e1a72fcca58-84fddfed4a0mr6329559b3a.16.1786711658869;
        Fri, 14 Aug 2026 05:47:38 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d2675b0sm409628b3a.59.2026.08.14.05.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:47:37 -0700 (PDT)
Date: Fri, 14 Aug 2026 20:47:31 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next 2/2] docs: netdev: clarify expected interactions
 with LLMs
Message-ID: <an8OY1XeDr1ajATf@fedora>
References: <cover.1784884817.git.pabeni@redhat.com>
 <83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
 <CGME20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7@eucas1p2.samsung.com>
 <amNS9/owsgr44v7w@AMDC4622.eu.corp.samsungelectronics.net>
 <68b50e02-c238-48c6-b2aa-98eb21077329@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b50e02-c238-48c6-b2aa-98eb21077329@kernel.org>

Hi Paolo,

Excuse me for the late reply, just some thoughts.
On Fri, Jul 24, 2026 at 03:39:15PM +0200, Matthieu Baerts wrote:
> Hi Paolo, Jakub,
> 
> On 24/07/2026 13:56, Jakub Raczynski wrote:
> > On Fri, Jul 24, 2026 at 11:24:05AM +0200, Paolo Abeni wrote:
> >> +both use the Sashiko infrastructure on top of different models. Reviews are
> >> +available after 24h. Patch authors are expected to proactively look into the
> >> +AI-generated reviews and handle such feedback as any other kind of review:
> >> +either debate it or address it. In both cases a reply on the mailing list is
> >> +expected.
> >> +
> > 
> > Would it be reasonable to implement automatic response from Sashiko to
> > mailing list? Some mailing lists (eg. dri-devel as far as I have seen) post
> > all replies from Sashiko to thread, which is imo not bad,
> > although it could be filtered by High/Critical severity.
> > 
> > What do you think about potential for similar solution on netdev,
> > since AI review has become 'basic' check in patchwork?
> I was thinking that too: it would be easier to reply to the comments,
> and help the authors to remember about them. That will not help to
> decrease the traffic on the netdev ML, but it is also possible to
> configure Sashiko to email only the authors:
> 
>   https://github.com/sashiko-dev/sashiko/blob/main/docs/configuration.md#email_policytoml

+1 for reply_to_author first. Copying & pasting and reformatting the AI review
comments takes time. Maybe some maintainers also want to receive the AI review
report. But I feel the netdev list is already very busy, and replying to the
mailing list would flood it with more messages.

I think the ideal way is for the result to be subscribed to. With this, users
who are interested in the review results can receive the replies separately.

Thanks
Hangbin
