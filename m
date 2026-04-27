Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DA352F85
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306749; cv=none; b=fojrMKdCmBgW7togG49Sx7sWL1g6DcZbE53SGyL8yihGZGsy5TVwb8ssyNassLWjYitCWTAaLaHh3N28EW9RcSKBDbdBpExQplw8ifCiqGfzP1XCcVqAdDKj82FcNPhzSYUs/SIblAsbaeLIGQHBLImWWpMd/244q3LfpwdsJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306749; c=relaxed/simple;
	bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAdb00CZVnVcZd9NqwVMOo32mQSTVXq7zQxZEmLUugqR2n18fqyUy2q2zExxIZFUJ+NIu5Y7CfIkiB4ds5Dhdh+yHhe08q79rwLYZGiYpXG6DNcEARM5GBPshLtTaa6L+s1t3hQpQj/ORQ2H+9w3cxY93/9bSp/2JFGbzBPYLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Teq2YLct; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXBM4sKF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Teq2YLct";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXBM4sKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777306743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
	b=Teq2YLctSPvuEHEL30ffcFUloFl8t3kj6MDMYIGXIIwcsdrOaNFLTnJTqcEhhP1+vBQh/H
	mdI4KzMqH0mtXWRYEjZJYkVDOK82UZcTnD1Y0WJSQlXmuPuEgUGVIR2//VZcFCy3l6bvSl
	6q3n3dySKDxTT/nkfgkM68D+f337K1o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-2kHisw6bNWyDqtLJwJLVgw-1; Mon, 27 Apr 2026 12:19:02 -0400
X-MC-Unique: 2kHisw6bNWyDqtLJwJLVgw-1
X-Mimecast-MFC-AGG-ID: 2kHisw6bNWyDqtLJwJLVgw_1777306741
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5c837c44so40921145e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777306741; x=1777911541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
        b=BXBM4sKFuUbQH9zGGjVnbAobFKoxlg/3kta653I97b55qMZH3d4UTTXU7KZ80b6tF8
         z9mppKywzO54P7m76RI/ArfNrU0GrjHGQFP0F7XC4aztNLgiAtdfzA/Q8MtI50Y34WEl
         pitFropHWoORTEJ3piUM1+g3orMrk7UX0jC6nubvMkmII3VFw3BIzf0HbU5AeHfJE2bi
         0VNWlrU66do/D5b0DOi6QaaIDQjpTjJbDdTMFPkX4h0ir0FoaArxEYd0zdIQlZQ7ri3n
         hrqbdWnjDLQzfIj8sWnNlafJ6jZhV+PiCPUNUI8BzDZbhRjOhhwfpOXrEOH11lRPtgGt
         Evqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306741; x=1777911541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
        b=nLDGXyPBhcT5bCCNe1CRuGJDS3jXSlNZsrEJkJBR0NjvLuouym0Jj4Hbyw9fOa7qKN
         TVeSiy20Y+rwQWZYQ0mMBPSJziLXbIw49oYyaU+A4ySH0w1fqe5Ytdh8OL1lyLvGEpXc
         4oV4ca2d4INnUJ9OkZdjhtSobyBHE9W2upVkkPVO2pgwl1yqt3JRY4tz1tL5v7CA/rnZ
         N7KSpRVwZMmya2diBinwGpI27pjmAA6B7vBewNaMP8W2ByZNO/pv/SBOaEzfV2g76+a+
         jAj7SLnO7uKY58p3AciU2ZXzMVjm2nBINyd5KCg66NO6nuizbHfoJu2r/iyOqnRstsS4
         j9lQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XuM62F8HPjCae17/NcC9JFNmU9bH7+o5aFXBZoQ0GbJiop+XKeDuUPVRrSemYeKrSCzwwSDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJPwgVCwdZWSx0Exgz0k0agDcFuEKUianRlCbe3lTPQGyyXdU
	ruOHHWQmm005sOGG+mVCDserVHPM+qdmy95j5uZQ5/X+Dp47hiZf9WBRrMfHyBk7rk7szNj5icq
	7K/MXfhNSRbkZ54bbmjtl3c6aaYWiAs7hRygTOqV6ZG7WpWxlqY67it/I5g==
X-Gm-Gg: AeBDiesXFCl//E5UnJGmgg+UOaZlY7RNrk/UqRAU+RX1eCLwQVFe4eEPe3kDNUL6obx
	jnMioHV1FMxX7AAPiazQXO3+q1XAKD7fLwmpcykAtAkPe+8kj7VTCDABDpR/iJljvI5nn/FV8Dt
	RSufRWdnS4gPphYeMzYKjFd+sstI3c1jxpiYbj11uL+wwZW35M4Pq1YPIDT+3nl41H1JuztHquh
	UaQHKmlk9bZhQrwgFjBY3Vv60I91b6fTGWIG9Cm7F84LM3eTn4p6bolkCZCuKVbCL/qM39CDgjX
	KLN1Lr4o673haRpuLiIV4p387QZzKUk9cddaWl4vH/HgTW2EPs4iFFvBdBBJnKJR/yrJ/9FTyXs
	2RBH8Z1LbcTp6HAtcik3xkB3yzRBWA8eHZUUUeAn5W6R0gyVTQXcn5KgcDUy/VK18GN0/zUaIXq
	yW+g/6+Q==
X-Received: by 2002:a05:600c:4714:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-48a76f91ac6mr136635e9.28.1777306740902;
        Mon, 27 Apr 2026 09:19:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4714:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-48a76f91ac6mr136125e9.28.1777306740387;
        Mon, 27 Apr 2026 09:19:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm969836865e9.6.2026.04.27.09.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:18:59 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:18:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] memory leak in __vsock_create (2)
Message-ID: <ae-MTiL0vf-y7Ygz@sgarzare-redhat>
References: <69eacf39.a00a0220.17a17.004d.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <69eacf39.a00a0220.17a17.004d.GAE@google.com>

#syz test: https://github.com/stefano-garzarella/linux.git fix-syzbot-memleak-vsock-create

