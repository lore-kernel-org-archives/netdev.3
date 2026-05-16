Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573443161AB
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778910289; cv=none; b=rcdEYLtXGSb1873lfaFu0f5S8UwKqc+6A8+J2gIvX4FqHPjGsIrRi2f3JBZnUp9flJmjq+l1HBYTEq2l+p/ii+6ByFwnZl9ZrAn7hyKvX+BdSx7SaOErqosc1hg/h3dh+puxtSlcliZLEnPwQ7JrTbg9plNLHUhqmisPAvsiZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778910289; c=relaxed/simple;
	bh=RZmU1Jyhfdw1NcV7uReRM2eze91pMMA/MXL/i3uLkfk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GWyhdIx+Mu/xBbCQYBqljuwIFPAsFd74MJ1i+NtSNgoZS6TyVMfp12B768kXMV5GGe9Dmpo6nPZvMJgn1DYfeMZA9UHr1YWuqatHVV0o4a+UW0g/A/NFcp78FsxtHjA6/SGvNDOBnhzV+g5rqFuF931GQk5HwtuWMVr+xjRYwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=srMP9lw8; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="srMP9lw8"
Message-ID: <529b2910-24cd-45e0-9e98-0eb3085a6bc1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778910284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAn21pk8QB3pm3LQMI4aJQftIqPiMxwAx6/+gGLWT34=;
	b=srMP9lw8Wx3UL63HPox+b+0p+E3+p1KjGAHvE5V0ubtSkZe0ZYPZ0CxxTTWNxg7B8Frnq7
	b/LKo90yuq3e1U2u2O5yoItV2up2dr/syXRn3OYsZBzOe2fOvtpyxNvrll4nx3pkkIp38s
	QZRhX3ZqpOZzSSRHGHOfqvUlz2hJsj8=
Date: Fri, 15 May 2026 22:44:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown
 (4)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <69fc0c7c.a00a0220.387fc1.0006.GAE@google.com>
 <871ea091-9328-48f2-a33b-fbf3d23f6742@linux.dev>
In-Reply-To: <871ea091-9328-48f2-a33b-fbf3d23f6742@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

#syz test: https://github.com/zhuyj/linux 
null-ptr-deref_kernel_sock_shutdown
