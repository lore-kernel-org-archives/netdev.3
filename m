Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF53A6EE6;
	Tue, 18 Aug 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046902; cv=none; b=m40oj96/maSG+iCNtEmbtfggs2XME4gaTc6KV7MmieQOGnxD3pSHvA2ijolXyrzfdvQgBeVi2SQgpzgffyg9LL6v83UP5QmxA2r0TXh76rZiefxsXvk2pCalKUEFqZEzms3fYiVnUsreaxQM5XQsZulCHyqiFs3rxjB1stlJGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046902; c=relaxed/simple;
	bh=O3ojNmboEksQ5jFCtvXz89HcLSuBHn2N9BJ+FSRvfbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFfy/cSj4oa20r6ddyEA6j4QMIXgRXAZFkyZgu3dKjG9TaGYqRxYKG27fFJTYbHgt3cIYpJX0FhCvr5mRUAisRRqIqqGlHQLu4kTIEuHoMXxbP6IEe7vAkrrKLtNuFzjKIsW7JNB5GtoolSIOaRUBiqaAIMNcesh1auHpCBJBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXHEYtbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXHEYtbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BF31F000E9;
	Tue, 18 Aug 2026 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787046900;
	bh=5cjUwPnmUYKmrlNavEPWsasEccaaFexUvE/jafK1DYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GXHEYtbqURw1Lnuk4m6H47akCb750nc4FYuMFQbeN91F+rNCyKeDkIq1wojb/qrFR
	 JKl9+gNs2uY/MIZSXKt9cYxHO2+1YUowYBARdPJSfhcW34LIaOpSDWrTS3j4q4cRFp
	 UTISqiK7o94sjCaRt76DCUDrBO16VHCotha5KvjEfR3nEeyNunS4lTT7LLgo1UIEld
	 KzKRGmWSXNmP6+e3MG1R+wG2ngjteuYUJHXbqDBncH8fWjYjOa9b2n6BbvvfOdYqhg
	 r1WeS3uwPmL/QLTK2xOuPOioev/Q1coKSrvWom5bzRhS8LUcVttTyGS8+iT4nUh2cR
	 9r56re18BhJXg==
Date: Tue, 18 Aug 2026 11:54:53 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Lew <christopher.lew@oss.qualcomm.com>, Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH v2] net: qrtr: Send HELLO message on endpoint register
Message-ID: <6smj6xbr4gumprpplrrw46lhe6wj63wbmcfe3nadcyp6om5cbb@tk6xtwtfz55r>
References: <20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com>

On Fri, Aug 07, 2026 at 07:23:04PM +0530, Pranav Mahesh Phansalkar wrote:
> From: Chris Lew <christopher.lew@oss.qualcomm.com>
> 
> HELLO is currently handled entirely by the name server (NS): it is
> sent once as a broadcast when the NS initializes, and again as a
> reply whenever the NS receives an inbound HELLO from a remote.
> 
> In a slave model, neither endpoint initiates a HELLO on its own;

What is a 'slave model'? Explain please.

> each side only replies to one it receives. Since both sides are waiting
> on the other to speak first, no HELLO is ever sent, stalling further
> communication.
> 

What about the 'say_hello()' called during qrtr_ns_init()?

> To fix this:
> - Transfer HELLO handshake ownership to the core layer.
> - Schedule a work item on endpoint registration to send a HELLO once
>   the name server is bound, retrying on failure.
> - Enforce HELLO-first ordering by dropping non-HELLO packets until
>   the HELLO is confirmed sent, using bool hello_sent guarded by
>   ep_lock to make the gate check atomic with xmit().
> - Skip nodes with nid == QRTR_EP_NID_AUTO in bcast_enqueue().
> - Remove say_hello() from the name server's ctrl_cmd_hello() handler;
>   the core layer is now the sole sender of the outbound HELLO.
> 

From the internal QMUX documentation, I can see that a node acting as a slave
should only send HELLO packet only as a response to a HELLO packet, which
contradicts with that this patch is doing.

Since the driver cannot differentiate between master/slave mode, it currently
broadcasts HELLO during initialization and sends HELLO as a response to the
HELLO packet received.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
