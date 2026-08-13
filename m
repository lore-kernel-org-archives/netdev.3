Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AF469857
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619830; cv=none; b=kl2KdhBq9271Mybk3mlAPhHw5/FdzaDk1UxVxm2XCcnkmUV+VRJ9XfhWaH9BNTPFbUo8mCyUjIPmEBQwycMEK7YxzxTmAwxK1USClH4pAl4hAPhfapqthG/5ZavUxaGgJk7kPwvJ8Wi1Gx96zPG6Ps14tGTe8DeO1E/HyAIVOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619830; c=relaxed/simple;
	bh=u797+pMmdUz57yJc4xnPqSsDEK6oX0EkjV3IS2C03L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2XQ6ryPrf9SjulM7Li/daYJF91ERNdioYWBeCgUZ0X39b2wi+FcaLWNyH5E3LXW0vhHqzzfS2w+d75OrMUk0lu6HsmSBXA+Hy2O6TQaAZqCXyDIX3E+gAbHMr58ym9qM/Jyd8WlL7o8cHhM/HqRBBK8jYOS2gmUryQzJ3gWy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGXfXl2P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V73e9pr2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGXfXl2P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V73e9pr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786619824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xMY/+66wnfUBfCQC7i9RuCgiWr7NlzzVZ+EQNegKcjA=;
	b=EGXfXl2PtIlZ6QSEDjI0rnabK11OHH5iO+hmZdHxAYRWaqkPCa1Q3Fmw/4spfEn3nei0SR
	nM+OnVJ5EUVR4y3FfegJwq0BsUVUtAr/cXfWddXVpc0oGd125VasEQmvS7YRKo7UM7ku2p
	WtaSFNaSD4Xq2zmf48eqUJ1BZ5IPGV0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-6RJmNnoMMbSUpbPla--ARg-1; Thu, 13 Aug 2026 07:16:53 -0400
X-MC-Unique: 6RJmNnoMMbSUpbPla--ARg-1
X-Mimecast-MFC-AGG-ID: 6RJmNnoMMbSUpbPla--ARg_1786619813
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93494527488so349047585a.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786619813; x=1787224613; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xMY/+66wnfUBfCQC7i9RuCgiWr7NlzzVZ+EQNegKcjA=;
        b=V73e9pr235hurvhKqGh9qzniJSk1YOKKTFU1DEevaQwwgFu9IImC7OfPDVTKoXd+xq
         yHRb1wBGzWuRbDuEyf4x/C1LYTAFr+aGhhbRTZIifEkrKbzhmwVSYITMC93kfsId/n99
         A+sfOKaocSVQYsj4u/tnFn/XDWmo8XRif63gAR5fM+w9kBqAuTRQ3fP+9729CV05NJyX
         5WKxFjwkKAvUKbwXFaXa5W9h6xVzkraYg2xO6UjLhBOuK9+mcIkOLTYj4A4uE5BODZlt
         l1ysQAOyOLpBzdcoHGNua7naSJYUNTFq2EKz+htzHlPJiqkr5Gr7zjss8DrMw2zLFemz
         iGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619813; x=1787224613;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xMY/+66wnfUBfCQC7i9RuCgiWr7NlzzVZ+EQNegKcjA=;
        b=VhXyVAOC67OkWOVZPiRlVO5IPPbZhEtfUs7L3CIjP/WY/i/LIKbNC2c/dqTW6Hpf9Z
         ELycKhNcj8wPCOpw3CvdNXc9AbSsprPhaNNHG1o0cdY8YNdIlDqQF0u675T7GT0LWjH2
         wSGGqh/IoCf5KuZb5icW2ID5HMIHnfoKOw+4/+XNQa/LpUSrY6/KkHqevvfzQb+NQ9kF
         AC+tBoWJ3e+jzIGzONrvwWY6DMhKZfWyHZc9VuqLGdbgU79z2GviwxZWGwfDXgJFq9fN
         Q6aKu8opl9QMXJsTOWzWnicSBxgIS6d4+xHOjCBnxlmJ9ZBFFWoE6jdd8HMCk5qwJFvo
         4KaA==
X-Gm-Message-State: AOJu0YygBZvhGIzkbJfFQ/X+lugYwL2qm3qKJfOcnm+AhNonXOABmEyN
	O3aRgXvQRVCG9JinVigb0xNtLqTLe8EiF5c+KK19fFbFRUQLAuDvUir4HbPdkrTXMZGmGbrfFGI
	ziW3CkNduK0cgpZlN4WEfSr4/G7oanQgPfL/1oyGxWWU0buQm1WR0MXdfhA==
X-Gm-Gg: AR+sD13+Z75Jku9UbGKhe36Me2JXmjkYjdw5TrR6EdjrI78eUF9YTHNwaMCE6j5sbj6
	IjcqD0QXIs8DPwqkZ35D1h/kozqn8ggPeK1XaMDPLiUKHV89a3tjSO12IfvvktuUlp6lbGJr1x/
	hQtAwhqzU4a+jZ/NBXkgQ1w9rl7pxMzwXNJ8hFEYIJ67+FHVOSQ+acPR8f/CW2wwYP88K8yLgpn
	T9woGhJkWc1uCigMV24qPC8GcdiCQPlThoH2UyuH1dlsSjF/zDV1o8Dp0EAQWnwVYFExZXCRfqu
	NzCfBsVdys1G5CjVRuz455lS96fQV3gPctLmIRJZpjOMuD3aCv4p4+llOQO1guNJv9yuFSsCfU+
	AmxsHUqSH6hsv3SlObEZTxros6Y/u
X-Received: by 2002:a05:620a:2a0f:b0:92e:dddc:6588 with SMTP id af79cd13be357-936bfaeaf38mr444824685a.42.1786619812874;
        Thu, 13 Aug 2026 04:16:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0f:b0:92e:dddc:6588 with SMTP id af79cd13be357-936bfaeaf38mr444819185a.42.1786619812432;
        Thu, 13 Aug 2026 04:16:52 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c191baafsm125635485a.5.2026.08.13.04.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:16:52 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: openvswitch: unexport ovs_vport_alloc/free
In-Reply-To: <20260812122007.457136-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Wed, 12 Aug 2026 14:20:06 +0200")
References: <20260812122007.457136-1-i.maximets@ovn.org>
Date: Thu, 13 Aug 2026 07:16:51 -0400
Message-ID: <f7twltue0d8.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> Since removal of the legacy tunnel port types, there are no more
> users for these functions outside the main openvswitch module.
> Functions to register vport_ops are also not exported.  Allocating
> vports without operations doesn't make a lot of sense.
>
> Highlighted by Sashiko as a follow up to the removal of the module
> infrastructure.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/vport.c | 2 --
>  1 file changed, 2 deletions(-)
>

Reviewed-by: Aaron Conole <aconole@redhat.com>

