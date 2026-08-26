Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F31D9663
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787713610; cv=none; b=Y+loqwiw+2tNzaQrb4WDg7D3gxRdzZh/rcTjU+yJbjwRfEA+EPDuG0TvrVD0iGvpiPp9a1TlgoD1QizyI6s/jakkMjVpZ6xYUO5P32lDUmXKGH0UoY0Ofk9bTMoVVAxUH7usAdeV/efzYLD5YUQRp+X4m8aWKmy69SFv7kZjIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787713610; c=relaxed/simple;
	bh=9C0JJHnhMl8wq9jIQMg767C/RWM5PoKtkQ6M2MW9bQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St5KdTkGHaC67F4LQtfHbmpR3tBZrY9ypiCJvs14ZrXavLyidQ44KJVxK7aK7BygzuIEjZPOYCrl0Xz3z7I/3mvnujroyd3ovLILN8ZB9olhIOgPXhEkHnuBo9dfIZNXCvRq7xcaVEsOdG4CMNeXfp2qJe4QszHVKMCn1D1OkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=o1CaQh/o; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="o1CaQh/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787713603;
	bh=nbcLAfdK5MFSNjlAPEInJBjn9XrHm5bjrSWsgRuc7mY=;
	h=From:Subject:Date:Message-ID;
	b=o1CaQh/os5Ypt0dj9zfavR1WAEAmbOFxDmU+XVQzwB0q7S3JeYNHzc+TCX3p8VJNJ
	 NHOmIm3inVIRpwxBUY+j7oQ9ccIu/N4+lV6h3TOG9Ra/fEtrK3DamDG0g3dC5G/cpa
	 YmkVccTIABtp8U6iei+/Q7J6R8ey/QDYJUk1dR5s=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.32) with ESMTP
	id 6A8E58330000017B; Wed, 26 Aug 2026 11:06:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2542204457848
X-SMAIL-UIID: F5F66C51243C4AA0A0D33808E41F9E16-20260826-110633-1
From: Hillf Danton <hdanton@sina.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	boqun@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Date: Wed, 26 Aug 2026 11:06:18 +0800
Message-ID: <20260826030619.1519-1-hdanton@sina.com>
In-Reply-To: <ao2WptQpM2zSQHDt@shinhome>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 22:26:25 +0900 Shin'ichiro Kawasaki wrote:
>On Aug 25, 2026 / 14:45, Hillf Danton wrote:
>> On Tue, 25 Aug 2026 14:44:35 +0900 Shin'ichiro Kawasaki wrote:
>> > On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
>> > >
>> > > I think 19bdb70c77d3 should be reverted.
>> >
>> > Just reverting the commit will reintroduce the other lockdep WARN that the
>> > commit addressed. I hope to have another fix to avoid the WARN.
>> >
>> I do not think you know the root cause of that lockdep warn, so reverting
>> 19bdb70c77d3 is the right thing to do because of [11, 12].
>> 
>> [11] ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")
>> [12] Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
>> https://lore.kernel.org/lkml/20260816014906.1149-1-hdanton@sina.com/
>
> I took a look in the commit [11] and the discussion [12], but couldn't follow
> why the commit 19bdb70c77d3 should be reverted. Could you elaborate a bit more
> about the reason you suggest the revert?
>
The Fixes tag in d532cddb6c60 proves Eric delivered a HBC, half baked croissant,
to lore. And the nvme-tcp tucked in the HBC hints Eric copied something from
somewhere. Finally the absence of ffa1e7ada456 in 19bdb70c77d3 proves it is
worse than a HBC. Clear dude? Or go to read [12] again?
