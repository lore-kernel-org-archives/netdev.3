Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F483A1682
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823074; cv=none; b=sQUOWibgqfOEPSGkpzaSgZOs1jnNyUGAWygAj/ptgXqBUa2YERluN5EkY1taztNFQ+FeJqVJz1Sq+R3GayGvsJeBzLoRqWDulpUSU3Lp9k/IlYDax2VvssT6BIOPbySSu493NngfFpL1gI/eSmb8wdQHrV5bMle7eucK5XexCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823074; c=relaxed/simple;
	bh=lw2nnT34Etua4ay15ouQMqbrt61GRC7NNnHbhINLdNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmMTpwBhqfa/ncnOgE0DLnQpa+Y9AQr5nobukSNHKA+UvHcUX7K4t6D2JRP9E7l2HrmOlQzNhI8D/969Ba1D0+TICazzof1oB7+k4uvwxfEtJSRZvdhMGpxGDJ7qiptcAi2jqKU4QdlSSgoy0DWyNxha8StewZcqe86QSJSPD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtX03hJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtX03hJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BA0C2BC9E;
	Fri, 10 Apr 2026 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823074;
	bh=lw2nnT34Etua4ay15ouQMqbrt61GRC7NNnHbhINLdNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtX03hJogZ/zgjR0a/l4OyfvHtVlEPXXuW7BitHXqXuoZO7WEAPz9xZJPecdUTksB
	 AkA+VBxRmRDtIwL6qPRiPn7vH+t9iUQcBsIW7gvkoILC6qsPHYm7AzmFEd2Ll2tUZC
	 F7NzvM/7KUgB3Mtj4f+7yVtcQfxXyKvyfixOwvJwIyf/abNSe6ohrO2A62ur4GGDaM
	 UC71Y5Vg+gMDq0Jk++UgMFjkGGnHd6gQBb5PvHDtr2NSplvtRUZhktT+NPkwLDAFi3
	 AYbyDzgr/XFT8RbsjVODO8U0Pv+yawXuzkjxHSqR0EIIrCqJRspQi8gCrQghMrvcZQ
	 WF6/XxEKFdtJQ==
Date: Fri, 10 Apr 2026 14:11:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	xemul@parallels.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	yuantan098@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com, wangjiexun2025@gmail.com
Subject: Re: [PATCH net v2 1/1] af_unix: read UNIX_DIAG_VFS data under
 unix_state_lock
Message-ID: <20260410-abgewandelt-rampen-c2eba2a546f9@brauner>
References: <cover.1775207252.git.wangjiexun2025@gmail.com>
 <20260407080015.1744197-1-n05ec@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407080015.1744197-1-n05ec@lzu.edu.cn>

On Tue, Apr 07, 2026 at 04:00:14PM +0800, Ren Wei wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> Exact UNIX diag lookups hold a reference to the socket, but not to
> u->path. Meanwhile, unix_release_sock() clears u->path under
> unix_state_lock() and drops the path reference after unlocking.
> 
> Read the inode and device numbers for UNIX_DIAG_VFS while holding
> unix_state_lock(), then emit the netlink attribute after dropping the
> lock.
> 
> This keeps the VFS data stable while the reply is being built.
> 
> Fixes: 5f7b0569460b ("unix_diag: Unix inode info NLA")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---

Seems good, thanks.
Reviewed-by: Christian Brauner <brauner@kernel.org>
