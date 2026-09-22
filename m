Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210240BCB8;
	Tue, 22 Sep 2026 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112000; cv=none; b=O2r/dmpnH74M+eFb8wT1VA83Xm7pG9mi5ZulKOxJIkcb7AY6gwHKLsODhnDLMxz8fcSIDjpDk70U5sI2s/5WVofQyiGXCvH3VWTblfyZIhBUdwM/7Z968HLJCRadfXhO6FwnmDbYdMTgHxA94pMaAoULqBqNQkIyyObcwd78e30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112000; c=relaxed/simple;
	bh=wkj63igz2n0L80foLfuBrvS7vAHmjCxtgkFjyJo5Mw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBlmh7fqpsuKa86D3v7QLrMo4tvqqLU1PD1+3FFfGomZoPhXlOMtW9PWLz57GK9pSr754XJ+6crSR3KZvSIzMJCAH6CytAbHYKQ15BIMCqpdaEyvO4gV90b2DWSVSntm/BoQJ0jumwkp60fS4pfYJQRTvMzlFQow0niZw3dP+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c36laCDy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c36laCDy"
Received: from localhost.localdomain (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A8F420B7167;
	Tue, 22 Sep 2026 14:18:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A8F420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790111939;
	bh=wkj63igz2n0L80foLfuBrvS7vAHmjCxtgkFjyJo5Mw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c36laCDyc2pn6ERE5d0NgbLXHp7R7eSDPzXS/BgH30wxGyY5YiPEyBkyR9uvzYjK9
	 zZGUqlAqI1P99dJuC9U959csJYBTEqLLprxjnLnmmt/LhIdCqPqn4iHLHYFVJ5E+W1
	 sxtS9uqihcjc/jiPzXzycG3sBnz2C2K3TMRVujxc=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: ap420073@gmail.com
Cc: AutonomousCodeSecurity@microsoft.com,
	andrew+netdev@lunn.ch,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net] amt: do not store tunnel pointer in skb control block
Date: Tue, 22 Sep 2026 17:19:27 -0400
Message-ID: <20260922211927.9198-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAMArcTV=zbS=XAPsBAEP7j9yzHiAjri44XmDK-a78JrOX1yv=A@mail.gmail.com>
References: <CAMArcTV=zbS=XAPsBAEP7j9yzHiAjri44XmDK-a78JrOX1yv=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 26, 2026 at 09:56:35PM +0900, Taehee Yoo wrote:
> How about protecting amt_tunnel_list with a refcount?
> Currently amt_tunnel_expire() frees the tunnel immediately, but with a
> refcount we could just drop the reference there and let the memory be
> freed once it reaches 0.
>
> What do you think?

Sorry for the late reply, I was busy with something else and am back
on this now.

I checked this for a while and I believe we cannot keep a refcount
balanced from skb->cb: once the skb enters the qdisc/tc layer it can
be dropped, cloned or orphaned before it reaches amt_dev_xmit(),
depending on the user's qdisc/tc commands. So a put inside
amt_dev_xmit() cannot be balanced against the get taken before
queueing, and the tunnel would either leak or be freed early.

I will send a v2 with the comment removed, from my corporate address
cenzhang@linux.microsoft.com.

Thanks,
Cen
