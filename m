Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128728E0F
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421004; cv=none; b=KkodFnpDCDXH8xYRtG/8+Jr1ii6RITGZVJidJtpZ3hU2VGIUdCi4hKDTVUFQ8lMVg9BBF4WQ4hrvnOX/LpdIluoVVwBdWRFVoHiLuMRSSzk7cV6dum/ih4XVRtcfyGZOwSFNrMNCeuCLmd/RJi7fR7rfaF3LgXvDAjmKpxloE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421004; c=relaxed/simple;
	bh=DVGlQcfpGLVLCRielDG4h54LSZUipWSC5fLf2f757PE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRw3SCftPxsLmZUWWrAFJwId35VhjCnFRpsOQ2ARls/RVcfJqSZxS7ADjcvZHqLZ7Yc6tWA9Qe6haKEK/fiVheU6fEf2McxeKQF5E3NQ2N6x/+p13XmfJSfsvQ4i5E1jKXBHhlu2QvdjlJ23BEFfWaD+kiB5Kjak+nArWoolC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RikltY6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RikltY6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F10E1F000FF;
	Thu,  8 Oct 2026 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791421002;
	bh=sG1bolkgfI4KyjVMVO5Myt3WwHaJ6IV3lHtcR3qKqSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RikltY6aBhbaKkoqUseYZeiYzhjX4fMhQsX6dlPFl7VfytTEnqj67IGLUAiRiDvO9
	 ml0FfcuARw9w+rRWTGKXjeORF8mX822tE68ZQG/G+Ytm74Sqlg3cu6TD7uYe+xRgIT
	 0titOozVqypzIzz8MY5gSrAtZdOvMZluDNtMTE2BBcrjNBmmyaoyWQD9UaEuUdJ8G3
	 mvsCN0+XT6UVkrTGQP6zazDZyBAzCIdveHkrsifN6e+nqa3EnAy9UD60x1M7Rxpp8/
	 MPcOlz1Nc/Bh5VhVSrTx3tY6Q/Rxss5H6NOLAG/daIOY8NtDp4pXWEzAuyhvg/UVHe
	 tLqLmaLaNs2wQ==
Date: Wed, 7 Oct 2026 17:56:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] flow_dissector: avoid u16 truncation of hlen in
 bpf_flow_dissect()
Message-ID: <20261007175641.2fb7c38b@kernel.org>
In-Reply-To: <9f688c24-488a-4862-b8fa-7a34750285c5@kernel.org>
References: <20261007045616.445596-1-edumazet@kernel.org>
	<179134921160.2527009.6970913813334453403@kernel.org>
	<9f688c24-488a-4862-b8fa-7a34750285c5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 07:03:16 +0200 Eric Dumazet wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> > 
> >   - Whether the issue was actually triggered, or is only theoretical
> >     (e.g. found by code inspection). If it was triggered please include
> >     the symptoms, like the stack trace or error messages.  
> 
> Changelog stated: Found by sashiko while reviewing the commit above.

FWIW the AI is asking if PoC was constructed to validate that the issue
can be triggered. I spent some time polishing this message but it's far
from perfect. Not sure how to make it clear & concise :(
