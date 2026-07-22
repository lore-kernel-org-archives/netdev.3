Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B1356767
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731565; cv=none; b=l2qlzRvmOlEFC1DiSx0ITh11xca1m8PRi0JS5RDflXshrBRueAu7bl6ONsZ4vH8TlRwKcyU1QQlr5b5PjTUrFB3sIajQnM1OI7Cs3gyQxxqh/P4f656UhTser4IBSpCnBxtqBHeD80r3nf9ZWgRBm59JJniouP/uor5hp7BLRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731565; c=relaxed/simple;
	bh=T453eWVw3xXH5G6mT7t/ZqkyZAfTeiGIOlfGLscQLkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBRi9pN8GPu8mwqJy/dLprZb7sTaCN33nRxvuM6KlPCB2suo83R/5tVzwpLVT665AHKcHGrOqd4HVSSlVQ/2zeIHpv2zBT278w+e5MmJgGWh4whjbKSl5a+Qed2P3qIf9qe+AyWibKpwMiRTn+j+R4+jZ9fA4Qq90IDcUfFS53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlwrxvOI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlwrxvOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216C91F000E9;
	Wed, 22 Jul 2026 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731564;
	bh=T453eWVw3xXH5G6mT7t/ZqkyZAfTeiGIOlfGLscQLkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AlwrxvOIIT6RKZx695m3Std999ItYA9k3FJG0UUyKWr/bVXKP17nphcMmcOu8VyFr
	 qo26Oa8NAEwE1BAbPdPh/VUQ+YMQmUrwsripQHGQJBs3DUJnnot55eeu+3nDqziP4f
	 L+IYUnwOCVkUAjIs/6l6XqOX6LFbAlb0vfPd0KSgp2neOxCzuZyYnL/syhIU3fnlJz
	 iBp3NzuDlErrYjvt+Udlqi+dF053FTx+4A4O200egLEAxMdBxYY++v8Joe9m7AoJre
	 qMq2IWG89Kxqc91+Fp0UVD1ZGopOgo2/TfFD/PUKJVZZPJ+A+cfBja1v7W4P3orWTn
	 p3X/pYRoX+E5A==
Date: Wed, 22 Jul 2026 07:46:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, roxy520tt@gmail.com
Subject: Re: [PATCH net v4 1/1] tcp: bound SYN-ACK timers to reqsk timeout
 range
Message-ID: <20260722074603.1cf1c841@kernel.org>
In-Reply-To: <b7d9784bea6e89d3366d4953e2b72cdbff5a4b20.1783671356.git.roxy520tt@gmail.com>
References: <b7d9784bea6e89d3366d4953e2b72cdbff5a4b20.1783671356.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 15:27:48 +0800 Ren Wei wrote:
> tcp_synack_retries supplies the SYN-ACK retry limit used by request
> socket timers. The same effective limit can also come from TCP_SYNCNT
> through icsk_syn_retries, while TCP_DEFER_ACCEPT can keep an ACKed
> request alive until rskq_defer_accept is reached.

Looks like this got no replies in almost 2 weeks.
Please repost if it's still relevant.
