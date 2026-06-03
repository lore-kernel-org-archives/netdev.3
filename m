Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E144103A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480646; cv=pass; b=ICkdBtN2dp5oDXndWfqgt4ng3Njpr2A/K7kotnUlwUYSt9OnpurSFa4ETwAecX7/VqDJzoVHZK+7nSaUxPC7CN+jB6OUStnPf6+mhdsP6qE6O3TeYC6XnTtYFijy2dD0zU06aMZieZT+WwMe22gr9mk84e+4+V6MVksrGphXgWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480646; c=relaxed/simple;
	bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2aoGHBYX+ZT3U+MNA+y9fgXCQEPYB+OZLUpHwlFynueRRJPfEeVLLsRAtZXBExmrCnell9F1RDLm2yvycmzkWqhhCaeWUlC241EqBr/sYFtwjaXy7VqVJz5qDP5jooG3dZ7qr0ehrxXNYHhSZXy0UGYV1gkt+hp92H8qxSmc68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HkDLARZC; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HkDLARZC"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9154ca1aa1dso71503885a.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 02:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780480643; cv=none;
        d=google.com; s=arc-20240605;
        b=janvsPMQWDt3TcKikPcnwCXjmbq8xRjVRheNRTTv7nhRZd5YaGa+b/LvSZG48IWJsP
         wYaGlQ3WIHvKbvehYeZ4I5LKpyQykkvBvRrNX4JmcNgBaRXzrgO8SbfJHWpDdyxApngu
         ZChNVlb+dGBAFJgB4q4yp+xO1rTFfrNMfZV4lqjVOzZ0Om8/1w8VzOZvBRw6+vq4ccbo
         7FclIjoQxVs6hOKpEtnpN5yx6hqqtosVJsVGMIrWcEieMD8hd4HPXPowdfxfVCSmXxXy
         wnfbI9g2OYVxmxeE3oC8BFejDowSFWGisOuZlii/B+j5pzcX8NJGOxSXkceC52SjNNRE
         dZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        fh=tqBvuKyAUDoP3HrWhoNBaQuDdRb2mbrDqJKX3QIzLwc=;
        b=ZLyRq3rNNDkOZldgGVcSttdPA9+f6LFm2mWVxXqS3UNu4eYJW2E6SPCnxUyGL/cU+F
         ud4ZV74U9W5ELlWjp3zVBDFMYasHDGdSSEDQqGUrQWR+jbplDQBT5urVHequyJBs5QoN
         wWBzyzNq/hXYNhw5/AHX+b/0ehIrrGL07qMpEj8jIYdD9GH2wx420gmHVGtslTO3gBop
         bzWKcRP7uWCE/9FyVpt9fNIdcca1cECR2kThi7Xya4ilUbC1aKxzRRP1DO9vIoqdKHyb
         ITzReioo5nhXTzZNyc8obIwRuZXLlnBFvOryHbunWGS4jKjOa99TPhaa6guQvkhW5MeU
         pjUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780480643; x=1781085443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        b=HkDLARZC/XPgnAkeNQ5n3MAM79d1kM1OOAeIKHRtNGpfkDXUv245i2yp+mD6JQPeUA
         64NZTw9EGfWhoENMoiIPb3oOJkXL+vE4E73fmxTFzb0nVraMC0mwLrTACZFwydQIAExR
         aNhk9bnGc++zz0NIEM1FWBwrjxTfiTh4xXjBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480643; x=1781085443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        b=Zg+5bxY0qIJjjlivqNu0QCPrReXiMoSmczBSwQSeFlsW78RD+euDH09P+o8NR37QTk
         5PGWaHYjkpwUCPnvhB49O47A0FsQwYoVIl3g54Wxcf8Wqq0RpEPCuEDSLBLaYcD5UyFj
         M1fbil/cPDovb4CVkHQkU77s+rGariQwtN1VmqHdEoH4/doB6MFCyD6Xx7MgG84tOfUk
         mNnQAqesWgM5+ZeswgfbDd1NcQaOl1bZbmcxqSYqIRZars3aojApcpYqrOT9o3HXCFFk
         0zN//NDCk7MoMtbgZ7lo05Bq27MIEDOtM1Ziv3III52HfM7ZSILHwnEHnuLSC7gJpkgw
         ilXA==
X-Forwarded-Encrypted: i=1; AFNElJ+YDYI9thJaN2NzVbsrzegGELreY9dqMaBetl+uqeTykeiMJsVxaNLFVOlyjZTJGY9DhqaBkIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaoWQwwZf3h8BBnFFUL/tFnjCFfJnePEyV38/x1tZoKUHM7Agw
	/y6p2qu1kCiCxiyYTquY3GZ3QLH8VjS6/Fk3hbQBISFRDkS1w+I49LyjaQQzXOweKzyAx62G2+1
	l+sT6lq9JAsBwbPgF5knNQmESxvfYGN7S+T26mKZ1Lg==
X-Gm-Gg: Acq92OHyGN6hOm/Fwrrf9RoIriLXA2+z69FwYdjVnZpAzsrEg6EHu15ic30W4xiHvG7
	KOUX9MQhqj68nFdzegTaNfMvXKHQCluLItAfBHnTfTRlYHcchdG7zdDN0DDSZWUUoXK91aFqb1e
	k+xc/l3fOh8JSuT5FqO0ZpkDh/9TD52qX59A+MaPSTNpIRe48YYRQ8ay4LJCRCfe3900aZe9yzM
	TiYvPPRPhijxGmC9notmgihteuEGwruh/ZgRTDcTuXzZYCuTkmH96LleM6TwMXdD18YrSNhOItz
	LzeSD3Qf+ln0xRurSwIVYbAIcdnP79uNOIv09p6qRC0d0C/n98cK/8sdxg==
X-Received: by 2002:a05:620a:31a8:b0:915:422c:a0 with SMTP id
 af79cd13be357-9158b6e2074mr292177985a.22.1780480643420; Wed, 03 Jun 2026
 02:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com> <20260601173325.GH2636677@ZenIV>
In-Reply-To: <20260601173325.GH2636677@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Jun 2026 11:57:11 +0200
X-Gm-Features: AVHnY4IqQCqMS4qklUMIqRUT1Fpv-SuCQDkhxYBkM9m1uTwHwBhUln17rZFWNU4
Message-ID: <CAJfpegtH-E79D-3UL=pPv-QqJk6C4ODXLLZSAjzQJwSSeqqS-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Joanne Koong <joannelkoong@gmail.com>, fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 19:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
>
> > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> > a big simplification.
>
> FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> Communications between the kernel and fuse server at least used to
> seriously want that, so that would be one place to look for unhappy
> userland...
>
> splice-related logics in fs/fuse/dev.c is interesting; another place
> like this is kernel/trace/, but I'm less familiar with that one.

[Cc: Joanne, fuse-devel]

I'd favor simplification, but care is needed to not regress performance.

Joanne might be in a better position to say something about relative
performance of various transport modes in fuse.

Thanks,
Miklos
