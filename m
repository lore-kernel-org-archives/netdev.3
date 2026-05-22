Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC93546EB;
	Fri, 22 May 2026 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473692; cv=none; b=kXaKt29lmZx4yt4ASGM5O67Ysr8Mw1tosrsVb67qX1jaAbG2D3+412gc14WrFbC03RVR02BbRUwFTY2bRUBIuOlj7q5RUqqf6h68xFnV+DiKaDzD5uley5LuGLqE6Plx06mjFMZNuDjDhW8/qabzuGYqFBvKu/aHOl/e90BOkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473692; c=relaxed/simple;
	bh=qoofI/dStx46pKaqMzCxH4/WzaQRdeRDMOpe+ra8MXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGhf/Rf4mTeB9W2+EyLPvLf3WhaiAPmN4CO3CfZk2g+0c3hG+LNMJferqrC0BGlLdCdOAmHsWpKAZcliC4amg1dEjseC2S8zDnbEktrZXsfOx2gWF8jeQYGz3zGMXkYoeex7IDObUxyPF9OU0VQ82LCbvT1J5GcX9+kspNfjn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzQi4OFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzQi4OFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AF11F00A3D;
	Fri, 22 May 2026 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779473691;
	bh=M4+S5g2AXLbLsViN5enySqmDN9yLzXhOiaa1aYuadMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GzQi4OFcmYvuLdZIFtnw/LN3oSY0O0juhTB5ob+6dPzuGTx6QhQaLxf0/91tNsbqI
	 ldgYO44IKqmLyCiP5a0NXRkOLXrbuZtQNK9rQiRYStyjd1MVwri1tmtai/dhLh4++y
	 o6FxUANT94MfyKdADVdH/MPDhWb0QI2jiHuXklUkvgOYSMpz+PI8J2PY/rJAd3dhgA
	 c2JGSb2tEtKwDxZOeSSJtpMoq8k64hLOyJ/yvHfJ6bCb4sPiC9icJvMPDqP3q4sixR
	 CooG+nHsX8CDqxA9Z+oSbPf4QnCw2kfRvU24Y/oZogwiguk48rj60oCzkXDRGIK/zC
	 0uiruuM4dt9zg==
Date: Fri, 22 May 2026 11:14:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: James Chapman <jchapman@katalix.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] l2tp: pppol2tp: hold reference to session in
 pppol2tp_ioctl()
Message-ID: <20260522111450.19472919@kernel.org>
In-Reply-To: <20260520134837.2780050-1-lee@kernel.org>
References: <20260520134837.2780050-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:48:36 +0100 Lee Jones wrote:
> pppol2tp_ioctl() read sock->sk->sk_user_data directly without any locks
> or reference counting.  If a controllable sleep was induced during
> copy_from_user() (e.g. via a userfaultfd page fault sleep), a concurrent
> socket close could trigger pppol2tp_session_close() asynchronously.  This
> frees the l2tp_session structure via the l2tp_session_del_work workqueue.
> Upon resuming, the ioctl thread dereferences the stale session pointer,
> resulting in a Use-After-Free (UAF).
> 
> Fix this by securely fetching the session reference using the RCU-safe,
> refcounted helper pppol2tp_sock_to_session(sk) on entry.  This locks the
> session's refcount across the sleep.  We structured the function to exit
> via standard err breaks, guaranteeing that l2tp_session_put() is cleanly
> called on all return paths to drop the reference.

Since this is a fix we will need this reposted with a Fixes tag, please.
-- 
pw-bot: cr
