Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC801C28E
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406806; cv=none; b=BKszEWuJ6pMoNJMEcTnHiemV96Xwf+YxNLwd6kIM1EBU4rvtMiRcdN/41MT5jT6y5wjQefDvYlpRP+HKJNCyignyOtKbu/fZ/8MEviNrAG8ZHPjJg7aujRXJk732jvJ+08ewcL0aTvty4o9hUuDuD9z0bEp3vdlgS+flBTRAHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406806; c=relaxed/simple;
	bh=qCnIg7pWrLgFXfIbS8KW6LMzuVxltwOhtNw3RrLvinA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHDmY5AgvTY3JEEe/s7OGEo48JsIAtWyQPxOAMS6MFuBwPBp7LtDVR16NP0/aqZaFLGTqNvbpX7xOd0cK1Ww9W2WDhDOKY8J7vzlRvqvyc+RKrofiSTxH+0HrmROV20y1WHYWhYkWIMHl77oGAWoLmh/iZMYDX2r4Ic73hLH7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NPWqLv18; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NPWqLv18"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e53581361so111288285a.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786406804; x=1787011604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWs+wZAYbWBcdx+NBYqjDuyCmeKtPIDQH0q+nRG47u0=;
        b=NPWqLv18eGMzxsyav9Dx04Z9EODmrhR2zr+9HpochiIBLCMdu2pp8SW254kbY0HREd
         sSMSnjnP5Twk9U/tzm5cePgj+TFAh/IIsE+qWYo6b+l2IFpZk91Hsn+hO1jpxFwFy6CO
         JhaMRODRHlh7eqWTv/zugSTJLC2Iu5LhxBxIiFMg1w4lwWW/0E6fBesgBm/9vWqWlIPd
         M7MQespOIXabgd04tO6uF2wSS5QDoLW9zxuq9CxZaDRH5ZsPU1rl5vK0zmsoXfEAu0Kb
         WhiPkxEqDUsWBLSsowML1ahxz8BluZQH1vMIu1RwG8QIX+ooVsFY5Ob4cpD5LGtfiXZL
         nG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786406804; x=1787011604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWs+wZAYbWBcdx+NBYqjDuyCmeKtPIDQH0q+nRG47u0=;
        b=g2Q2a0Xo24ke/9hkdcNcl/XnMSBLYe62UutZQGLAYv2WUOnT1GqV3jpCvsHg/ktILD
         OdyxSyLUJN86UsHST/66MJ68oFT2kv4mwXuoJEikyHxDwSCCSSmdJ9kegh2VXHhyQ+dW
         kLAaG/COQATwYAAdirsetv1KhgMCsPME/jHzY/EVTXt59BnjvdtgyVvGIwniZP0ZLTsu
         Gl7IA+rtaAM2U8LrW1bz4Z/IeNZt6V7Q5IGqgdTliPkfH9+By3MBLwJHmq4jroGtJh1M
         /Nxn0wx7BuPJK/UZEawnLNC3obIdAhgH5AyZmGZvpfBSj1lgArJRdElO1/f0ekWmIVHP
         +9VQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/Hi2nzpT08GZ8vAGJZZJjY861mnNqplzmV3x7ELFZAsH7rfBKQgohydDh/t7COFz5nyYcAak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9rJNcxjRWIJGF76aJCWDRU5v+atO9WtYQj2OOQBd1b0Z3mll
	OBz3nwuaWSzsPw2K0JQZh+wXPGrBbiCrmV4KHDgd3B7R5eYRmxOZKqcT5ax/tVA0SW4=
X-Gm-Gg: AR+sD10ayOrJW3GViMyIEpgYfaTMgWDUwsnUnCJxu49/NTCNrWutzJJHjTLWOKxIxZL
	vKOQ/CsOCvDwgdOzFkxH3PZcu8FMzSKpLfrZXJ8KaFoDu2qU/Eaaj/fzANagL+Q7jz5ZCePs5dE
	PEiA9IvMtmorMqpIb4ey3Z5Sy4wzbwFTPYBt2KS/96UdebHSUHE96j+8iAC2H91i31zXLuIsi2I
	/zVdXTxIqPh81UVmRYKBs8etvBs2cMKaBa6ekiBAqdlKfXQkDjCYxDqxkJ9rwuAdLxY491NR5gN
	QoNcnhLw+wCdg93kpEr3ckMSjZ9cYwLaJILP8Jt+ubXl8VxNyFT9LK/0W172qF2CVmJtXY1sOQY
	RAXXTMeW/1Oj2SPUhOD7Id9YRoD2twsEWMvWNw2dKb2uT9bvMkOdSPyq9vfJ7bJvBe/9UbnaJWE
	IAcu3B0idBUtOMbQVaseV37GjbPxHvBG+WUYVRmS3zukbO2kDX
X-Received: by 2002:a05:620a:2412:20b0:92e:d7c7:7de9 with SMTP id af79cd13be357-9369cfec40dmr552651385a.8.1786406803946;
        Mon, 10 Aug 2026 17:06:43 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e290054sm918322985a.40.2026.08.10.17.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:06:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wta0v-00000002HCN-3XlD;
	Mon, 10 Aug 2026 21:06:41 -0300
Date: Mon, 10 Aug 2026 21:06:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+6dee15fdb0606ef7b6ba@syzkaller.appspotmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	nogikh@google.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] INFO: task hung in add_one_compat_dev (3)
Message-ID: <20260811000641.GA541676@ziepe.ca>
References: <671756af.050a0220.10f4f4.010f.GAE@google.com>
 <6a75e1ad.b50370da.49fe0.001b.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a75e1ad.b50370da.49fe0.001b.GAE@google.com>

On Fri, Aug 07, 2026 at 06:46:21AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-18-4..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13d50fb9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e21dcbdb02d4229
> dashboard link: https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d037b9580000

So this looks like it is just "really slow" beacuse of the vast
amount of work it is triggering in the kernel to manage sysfs files
under locks and the high number of threads running on the same
serializing mutex.

The only way we could do anything about it is to split up the locking
somewhat to be more fine grained, but that seems tricky and
complicated and might trigger a higher level lock anyhow..

I'm not inclined to do that just to silence syzkallers rather
agressive test..

Jason
