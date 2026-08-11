Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C23A0B3B;
	Tue, 11 Aug 2026 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438459; cv=none; b=gFBbbYcrhresXEb8i2Llt509uu0G8Pq+j0OaEM8afqu8OJBfywXuN0m158Lc08T8VTrDP61KK9ajnOrnXryWLHbVtVeI5ufOP5RtdsRX8ICrx9dlMrUfgJFxbNp/H785EyHH+4kD+a3nrRizKuhGIIJOjDRbhH5ESuEV+OHeA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438459; c=relaxed/simple;
	bh=lp0sKMAHx+JPnldTEzg5tcfvs5dcuF/k2/59ECwnA4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgZ+XWdSD6ujFnxswapzdx9UmICbzS4dFO6OLhbIlQZAb7NwcT02sTyuIlGYZEA+g95SY3jlrcwdMVcOQ7y1YVveKJ6WefF7hC2iOkC5Tm3h08TXSkuzl9/434XTPbexLt/OZmkzZEYnzhcveoB+mJbYWFyKi7EIUv9bZPuJszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnhjgdEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnhjgdEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCF21F000E9;
	Tue, 11 Aug 2026 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438457;
	bh=Dl3da2NyBdt2K013UUfznZ9fhyKlMogMX5EOQOmF4bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QnhjgdEdpODHxJ2GthLHbODxfsbFdWVMKpSRHMkYOlA5YK64If9aliuK4DFmuwrXq
	 v1N1XqDQJLb5reoOe5QlCeQZuYm/YXQfWiIhvqs6N34bJ6NUlu9sjW1znts5MZ4bYk
	 fLoE8/6JvzXnTLOP5e9E2DxXc1e4F5iVh1YsyIScy+QMLi2NhCLZU4pXVBxXuhY3VH
	 YuLKZquRSPeMGIyErghzdrM1T0sjRPphi7G0dPn0qgfyMbfnsGrDOPUh7j6mxmP1y6
	 A9GzatMq08qcKG8Cm3kmVx7MWKS3Len/xHUK8DL8/PQWQODuVTO+Zaw3QfgUbrmnRb
	 mxQXUBnCMoRnw==
From: Simon Horman <horms@kernel.org>
To: thnkslprpt@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] be2net: propagate bridge config query errors
Date: Tue, 11 Aug 2026 09:52:57 +0100
Message-ID: <20260811085257.814556-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809071725.944734-1-thnkslprpt@gmail.com>
References: <20260809071725.944734-1-thnkslprpt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260809071725.944734-1-thnkslprpt@gmail.com?part=1
---
--- Patch [1]: [PATCH net] be2net: propagate bridge config query errors ---
commit 7ca874943675f3c258ffbdac77a92f7564cc5f1a
Author: Avi Weiss <thnkslprpt@gmail.com>

be2net: propagate bridge config query errors

This patch modifies be_ndo_bridge_getlink to return a normalized error code
when be_cmd_get_hsw_config fails. The goal is to propagate the hardware or
firmware error to rtnetlink users instead of silently masking it with a
success return code.

> diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
> --- a/drivers/net/ethernet/emulex/benet/be_main.c
> +++ b/drivers/net/ethernet/emulex/benet/be_main.c
> @@ -5028,7 +5028,7 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  					       adapter->if_handle, &hsw_mode,
>  					       NULL);
>  		if (status)
> -			return 0;
> +			return be_cmd_status(status);

[Severity: High]
Will returning a hard error here abort the system-wide rtnetlink bridge dump?

Looking at how the netlink core handles the return value from
ndo_bridge_getlink:

net/core/rtnetlink.c:rtnl_bridge_getlink() {
...
                err = ops->ndo_bridge_getlink(skb, portid,
                                              seq, dev,
                                              filter_mask,
                                              NLM_F_MULTI);
                if (err < 0 && err != -EOPNOTSUPP) {
                        if (likely(skb->len))
                                break;
                        goto out_err;
                }
...
}

If a localized firmware failure causes the be2net driver to return an error
like -EIO, it appears this will terminate the global netlink dump. Could this
cause system management tools like 'bridge link' to fail to list all the
other unrelated network interfaces on the system?

>  
>  		if (hsw_mode == PORT_FWD_TYPE_PASSTHRU)
>  			return 0;
