Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353F37A4AF
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745024; cv=none; b=CgdZabwXYfflhDJtzQTi5EVtzha3raYydvIzhGVuuN6orcwg6SDzIdMf8SU2KEb+Z3m6ac3Rj4gt0wmv5cV8BA0I/hdhlbM/UjY/YmNXSatwUkAVQCn3uqUOUZBtIQfzKWN62uNql1g7zdwPfQ/raWejT7zUYzbefvtB15dIbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745024; c=relaxed/simple;
	bh=e/QGa9Eh45fnnFoy68c1Ej+HB9bjvmLBR+Z4cqV09S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2vyQQdkVq4/JAcG/ZOPPJdyqIKqf6m+Cyc8jXUcgP/V3/g4OoBiL4z8hPqm2f1hsO6eRzt5+4SoEnV98ICR8huQ0E+5nDnDNk045xboELqGVeMjcdLtowFNFzfNmWkxz3HVkibvUD2wiBWn0dHsr57Z2e40X8OGHMu3Poa3sJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=0KfIKiPa; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="0KfIKiPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787745020;
	bh=jz8M6moQBHMrSK5deRUpEIbk9qeGk0fFFjRjV3wNFHk=;
	h=From:Subject:Date:Message-ID;
	b=0KfIKiPakBKfWeMdpvQSXxC7HTSUQehCL4K1+C6RA/99V7X6HMToKvxWaJkPML+OI
	 SRM2zxcRAg48bcNJbiVl1GCp0PohVOH/UfIHXLdarc8T0hMkzokk1HZHZnomT5Kr4N
	 aNxN7CkHVWhhRr0pzJ4HkHdEuMEEgfQf5wuN695g=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.33) with ESMTP
	id 6A8ED2C900004631; Wed, 26 Aug 2026 19:49:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9345136685203
X-SMAIL-UIID: 51ACF3C282D04DD0B6417EA3C7D28338-20260826-194931-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	boqun@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Date: Wed, 26 Aug 2026 19:49:20 +0800
Message-ID: <20260826114921.1572-1-hdanton@sina.com>
In-Reply-To: <CANn89iKFGKENq+cFHC7p6ekKXpYhpvZQdA1-TAoriFi09tPqrg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 26 Aug 2026 12:49:36 +0200 Eric Dumazet wrote:
> On Wed, Aug 26, 2026 at 12:27 PM Hillf Danton <hdanton@sina.com> wrote:
> > On Wed, 26 Aug 2026 06:05:15 +0200 Eric Dumazet wrote:
> > > How many bugs did you fix last year?
> >
> > More than 150 [13].
> 
> Pure hallucination.
> 
> $ git log --author "Hillf Danton" --oneline --since 1year | wc -l
> 0
> 
Before it is proved that linux can make the earth a better place for
everyone, who cares LPC/Unix for example?

> Lets compare to some real numbers.
> 
> $ git log --author "Eric Dumazet" --oneline --since 1year | wc -l
> 550
> 
HBC in addition to nobrain can also land upstream, no?
How many reverts landed upstream in 2025?

> Harassing a maintainer is probably not a good thing, I wish you luck.

The Harassing word in combination with HBC puts shame on the maintainer's face.
