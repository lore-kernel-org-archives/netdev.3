Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1F2FE071;
	Thu, 23 Apr 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946402; cv=none; b=KvFsq093S7pD3nMPmzCUobMUTpZw2WeFQOn1RmcvqHcRQkx4vSRB57X0sZ2GgL67gJe0A8GPRRBHrInsn8YW9nYa4blgCxH8Ny/Dr61gNiaP3nmTR4SqJ1BVEzUPjXKfTh+8qNUmF5oviB42Qr8Ah0ngQBKKp1HUNyHRWd+nvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946402; c=relaxed/simple;
	bh=f/om5ADRMKsy+r05vHr/1yUfOvzUiOshox5HxAehQWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8HjoDGCKOi5fo5dazkINVXraJIfR35R9uRTVoVdBfcS+Kz3zwlpVCBTRpSDbP16jVfh1Gko4kfFIqX+/DEd0iFkNtiAZ+O5eh9pF2FpxgsBB8Ui8ih7oTzCJwqoUfER0I8SkoWOE3rQ4e9GjCFX0IqCoutfElIy9eRfppXlgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWkZ/Q6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWkZ/Q6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CF5C2BCAF;
	Thu, 23 Apr 2026 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776946402;
	bh=f/om5ADRMKsy+r05vHr/1yUfOvzUiOshox5HxAehQWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWkZ/Q6oCvZmNx3P8Mc2McHSHF134OiT6NCkkuVcULYym4NNklwnEm1/gZut3d4Vo
	 6SFkZzdsCUcpU9Ga4g/7DZsFfRPPP8ejLRM0AP5aQiQf92Qcoj3BsieJyWnhMtwSv3
	 IXlVei2fGesjiH3BTs2jfiqZB2S6QTdyofaEasxQ=
Date: Thu, 23 Apr 2026 14:13:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jay Wang <wanjay@amazon.com>
Cc: stable@vger.kernel.org, dhowells@redhat.com, marc.dionne@auristor.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-afs@lists.infradead.org, jay.wang.upstream@gmail.com,
	Faith <faith@zellic.io>, Pumpkin Chang <pumpkin@devco.re>
Subject: Re: [PATCH 5.10.y] rxrpc: Fix recvmsg() unconditional requeue
Message-ID: <2026042307-joyous-deliverer-c4bb@gregkh>
References: <20260422222432.7236-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422222432.7236-1-wanjay@amazon.com>

On Wed, Apr 22, 2026 at 10:24:32PM +0000, Jay Wang wrote:
> From: David Howells <dhowells@redhat.com>
> 
> [ Upstream commit 2c28769a51deb6022d7fbd499987e237a01dd63a ]
> 
> If rxrpc_recvmsg() fails because MSG_DONTWAIT was specified but the call
> at the front of the recvmsg queue already has its mutex locked, it
> requeues the call - whether or not the call is already queued.  The call
> may be on the queue because MSG_PEEK was also passed and so the call was
> not dequeued or because the I/O thread requeued it.

Why did you reformat the changelog text?  Please do not.

thanks,

greg k-h
