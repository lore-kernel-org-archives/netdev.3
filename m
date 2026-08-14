Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAB3C5DDE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717125; cv=none; b=lifglCdS5ImwNfI7z1VRpIBCkL3AvGftb2qhmbvjaljtboIwKU+nj7WmufPXCCkYy7n0wz7EdHzDxyBRlExwTbrXKUh0do+pW+RxeracyTCn8xfzhFDd4t15uarQl5UjTS24bn/bhju3NB5SYT58ZJvyjADOPn9kFX53W4ZEY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717125; c=relaxed/simple;
	bh=BCHoRF8o9Z05Fhp0WEe4Pr78updsK5bwAuofbTQLP2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHkRSYliPcYDKCJgSUvYE2f+RSuxkfClZeHiERl8wuAwuNJeDg5pjaHmhQt7A+rm2w2BzvwQwMGvT9Mi4+NgFzRMW7wUso1Wj2MKRThV/MTtH+AWiJJGH3XsFbWgnb9uE+Wx5Mp6f3cnLdWYuWZV/q38S1QlcAu+EW4MFsFFIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0DzFwRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0DzFwRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CDA1F000E9;
	Fri, 14 Aug 2026 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786717114;
	bh=r3ybb0M+f0MzRSCdHXPFPlw0Ty14F6E85o5D53OtLns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X0DzFwRVBNqGoCeFJHRACoMRnwuZ8Zkb+NSyejhskzEI8EICrBEq769p/9SYUpuVe
	 Q18L4SO+x+9klDNaOurjQBb08nQ18wKByhaHctjlC2wWB8d7vMtau/SNdfGwmB7RJ9
	 3KrJM6qtSycAupVt6U9dz5eoBGcdJbvJevXOJXrQHwrTGYbl+7nq+gRKF2ea8e9kMc
	 x1AEn9rs42jUT7FA/qrTjO4NAZ5OZosXp9lszY6SQso2c3DoOFOY33SwmJNh2Ucwp/
	 w5yH9TU1DWXEcZooWPwqYaTtaTseQ0lBzyGPh8iXg1kyhFBq3yhlYPOF9K8bei3+7e
	 KprU31YpkIY5A==
Date: Fri, 14 Aug 2026 15:18:32 +0100
From: Simon Horman <horms@kernel.org>
To: Wong Boon Jhee <wongboonjhee52@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net/ncsi: Fix Use-After-Free in
 ncsi_remove_channel/package
Message-ID: <20260814141832.GO265046@horms.kernel.org>
References: <CAOvhtVvk+HmPeyT94dumkmf2U-O032esD-hRmj2yp12gyUvMTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvhtVvk+HmPeyT94dumkmf2U-O032esD-hRmj2yp12gyUvMTw@mail.gmail.com>

On Thu, Aug 13, 2026 at 12:29:42AM +0800, Wong Boon Jhee wrote:
> From af39fbef05b309b7e183690dbb7e63295ff0be5a Mon Sep 17 00:00:00 2001
> From: Wong Boon Jhee <wongboonjhee52@gmail.com>
> Date: Thu, 13 Aug 2026 00:25:47 +0800
> Subject: [PATCH] net/ncsi: Fix Use-After-Free in NCSI channel and package
>  removal
> 
> In net/ncsi/ncsi-manage.c, ncsi_remove_channel() and
> ncsi_remove_package() remove objects from an RCU-protected linked list
> using list_del_rcu() and immediately free them using kfree().
> 
> Because there is no call to synchronize_rcu() or kfree_rcu(), concurrent
> readers traversing these lists under rcu_read_lock() (such as Netlink
> dump handlers) can still hold a valid pointer to the object. When kfree()
> executes, the reader is left holding a dangling pointer to freed memory,
> resulting in a slab-use-after-free.
> 
> This patch fixes the issue by replacing kfree() with kfree_rcu(), which
> defers the memory freeing until all pre-existing RCU readers have finished
> their critical sections. To support this, a struct rcu_head has been
> added to struct ncsi_channel, struct ncsi_package, and struct ncsi_dev_priv.
> 
> KASAN confirms the freed object belongs to the kmalloc-96 cache, and the
> fix completely eliminates the crash.
> 
> Fixes: 2d283bdd079c ("net/ncsi: Resource management")
> Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>

Thanks for your patch.
Unfortunately, it does not seem to apply.

Please:

1. Rebase the patch on the current net tree

2. Target that tree when you resubmit the patch

   Subject: [PATCH net v2] ...

3. Include a changelog that describes this change

The b4 tool can help you.

-- 
pw-bot: changes-requested
