Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB438DD3
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678662; cv=none; b=BB99MEml7HX16FLH8vgN07koEBjeLZSYth438dEVgKXXYOlrtgqCEPGnKwD4CUOd713I1XNTxZONYOlIHf5faG0ojjJNnrWFBj3yE0y9CHDZ+VCmban/aNa5mDXDLp857pKbZue5qN1o7a4pKm7LwFnAGITogY8HJ4P/19cKdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678662; c=relaxed/simple;
	bh=H5OoVqwcomxba93CbnCnGebHeLG5lAJIhTQocwSdlxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDKRHKTcWYVBrGLi0CPme3MPTygC7pZvxdu6yMcu7CMER1kKx10fPe9Rp+omK/kQ3B3Iue2r3WP3DatzSJCqsiRIkFakexJPXnZFKhY3EOmUC8hlnLS0xe/8q91qK2RathGQ8k09RgqwUqkJ6l/k9Ofuo3fg2YorO8anh597D7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOE5J05k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOE5J05k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505B4C2BCB4;
	Fri,  1 May 2026 23:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678661;
	bh=H5OoVqwcomxba93CbnCnGebHeLG5lAJIhTQocwSdlxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOE5J05kPn4VFk9YVUQu7dwBo0eZ7gr1mz1BlLhBzOPUgk2gSNf8qUNjZwdvgVFt9
	 lxIwLpeOt7wtJWhylYkvVlbGqqgiC0/7Udlp59hD/L1awtBu+78Wf7bH2wZX1oGT+Z
	 vVyd7wVyQ76EOkKNJ7LIoeqMl2mXm3gCd1Acx6yl5iEejnnAdBuSf4OEM2P7JHjkMh
	 +mN5/yoadoTgQ+TbuIFuanB9zqc0k8Xc37kOfrGvYm05RhpsnYHpZj4uDvHmToS4c0
	 XHLO1As+leNJcaFFeqBWwYrB2GgEnbYq5NUyyIdAhc5QHyv4PubI815+XHN2SkaifT
	 k2p4HfNWrZ9Kg==
Date: Fri, 1 May 2026 16:37:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/5] ionic: Small improvements in devcmd retry
 logic
Message-ID: <20260501163740.0f775e67@kernel.org>
In-Reply-To: <20260501031555.43259-2-eric.joyner@amd.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
	<20260501031555.43259-2-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 20:15:51 -0700 Eric Joyner wrote:
> If the timeout time is hit when the last attempt returned EAGAIN, the
> driver returns -ETIMEDOUT. This causes the -EAGAIN result to be lost.
> Fix this by returning -EAGAIN if the timeout time is hit and the
> previous result matches.
> 
> Also, reduce the sleep between the write to done and doorbell
> registers. The msleep(1000) was initially added in an arbitrary
> manner. However, this long of a sleep is problematic because
> it reduces the number of retries when -EAGAIN is returned, which
> may result in the devmcd giving up early due to the timeout. Fix
> this by reducing the sleep to msleep(50).

It would be useful to explain the significance of the return value 
to the callers. Are you trying to return EAGAIN to user space?
Or some kernel-internal function catches this?
