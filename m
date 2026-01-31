Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85117344052
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879297; cv=none; b=svpWxue3bcKezaUTVBday1Xv2NGVRvwAGd5xY1Jjb6n1SMfKNzDjY/VRudiFWLp1e0q3pm7WBg6kj9z/Yg+iV7ik7Lba4HVvb2Pe6ywjlHikwLABfLRmwm6e8ogKCZWrzG5uQwELPts6FYehRU9v5Nld0s8mWIDl/qSupB8RBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879297; c=relaxed/simple;
	bh=CSouSbsCMcYIZ83QzKHPaIrpqMKad5xgDsAqb0G8t9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sw4fUpCtRUB544hfRtmBrsq+quSr6g38HtUDUS+AEaxMmmH36Rx/0ZuowyT7hTthuvC2hfT53sumsDOthuTUv/eaatZ/7dDrq4Mu/x0Ou7vf7/HsghAF/jdhKSjx1KucBdCKhR+Xt3Vv251b9fOUutg0cOKCYb7Ub+7iYq4reI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQg8IkPW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQg8IkPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9BFC16AAE;
	Sat, 31 Jan 2026 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769879297;
	bh=CSouSbsCMcYIZ83QzKHPaIrpqMKad5xgDsAqb0G8t9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TQg8IkPWLlSNzNh2ba17lYSaDbcJlBkKiSOORMqchEqAagtkyjCMuJcWWB7FYclxG
	 yR61Q/5Zd8jiKm5DaQ4nn4ZRYnkX8oZLPUU/QgK5qBYvkawk+ppZWtdkXun+66GAST
	 /4kguU6gCfSpNb85/IfO4kJs2yJhO6iGgdHaBnhNQ0K+d3RZ/oc/jvgpJf7/+g5WuI
	 /LB6zVlo27hpcUj5gvl+V9qUVzCJE3KqPE5ZUSkcZWy5TajqkaaG9879m4r//mXRFd
	 l4pLWEJ3vG9qoo/7ajEIP0w7yOo62RlnjHJBNj/C9AUFNLGoUM20P3C1hTLZDJ5vrQ
	 549E6dqtsUqEw==
Date: Sat, 31 Jan 2026 09:08:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Hodges <hodgesd@meta.com>
Cc: <netdev@vger.kernel.org>, =?UTF-8?B?PBtAZmIuY29tPiw=?=
 <jmaloy@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <tuong.t.lien@dektech.com.au>,
 <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH 1/3] tipc: use kfree_sensitive() for session key
 material
Message-ID: <20260131090815.73ae7b09@kernel.org>
In-Reply-To: <aX15HnlN8B_JOpMC@fb.com>
References: <20260131032508.4158256-1-hodgesd@meta.com>
	<aX15HnlN8B_JOpMC@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 19:39:25 -0800 Daniel Hodges wrote:
> Whoops, this should only be one patch, I messed up when separating this
> patch out.

You'll need to resend, unfortunately, patchwork will wait for 
the "other two patches" forever and never kick off our CI :(
