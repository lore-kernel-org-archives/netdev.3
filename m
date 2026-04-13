Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B013E314C
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103356; cv=none; b=rHWIWWADvMcsz6BaTEfuEDf+toYbYY+mReg9iU29vPsy5z1qhy00aTfMnbfTmRnqEG1VZc74fJgzm0pzSuQE4fngp4/5tOGGFUmEOx+WA7/2FO685NnYumi6Wicyq4EXmrsOSzXNaCc9pR9P7Ozaexoy1Z6jDH9ZC9UcxraTm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103356; c=relaxed/simple;
	bh=y/odhzOyY4u9jxQVl+cLzSh5Fv0Ivs0VjeFmOgiUJ4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTO3Bz3logX2lgRWdk5qrWD5PxLuFHfzaSLlTibEXbJMEUsOQukLHmw71qC3nzN4FEiso2LY/aKXTA9oKs4k0zHGaBklnl2anbOMHrDPRFDRAP2X8KdrqhMEolMpxCAKntAiKf5BhumipGx4kicb/4eSWgcEZgY/rH4NVFZ/lqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVfocMwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVfocMwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3380CC2BCAF;
	Mon, 13 Apr 2026 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776103356;
	bh=y/odhzOyY4u9jxQVl+cLzSh5Fv0Ivs0VjeFmOgiUJ4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cVfocMwdyXN75O40vh2aviLbRfsNcR6ghCnkwG6CFs9QxrxJif/5SPdtBcZZAInBn
	 TxDBIXbwbS7XQal0SyoEvp9bRshJ6baJ1ncPzczMFOhu9uise4O2TY/+QRWRR9p8Ub
	 4Bik94Gs8qbQyAg8ZuLzxDVPhXhynaK+VEpki3gvibw39LxAtisn1/qioS6VQa7vfZ
	 UwJUxvzTd0yidOavhs888yS6qoKORpt3/HQ1zJmGxFRbyZuH1IeoRsdkiGbdVQi6kp
	 I3158vi3cu86S5Wqz+e99wen4X1/900UQnVYl9utxWxYg3pe8gAHBVHg7YnSlfo3rK
	 i9zTEiAQnQlUQ==
Date: Mon, 13 Apr 2026 11:02:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>, Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <20260413110222.49fc3759@kernel.org>
In-Reply-To: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 14:07:51 +0100 Russell King (Oracle) wrote:
> Since we are seeing receive buffer exhaustion on several platforms,
> let's enable the interrupts so the statistics we publish via ethtool -S
> actually work to aid diagnosis. I've been in two minds about whether
> to send this patch, but given the problems with stmmac at the moment,
> I think it should be merged.

Sorry for a under-research response but wasn't there are person trying
to fix the OOM starvation issue? Who was supposed to add a timer?
Is your problem also OOM related or do you suspect something else?

Firing interrupts when Rx fill ring runs dry (which IIUC this patches
dies?) is not a good idea.
