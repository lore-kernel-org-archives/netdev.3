Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A1361974;
	Mon, 27 Jul 2026 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141534; cv=none; b=ZPHi1UVKIKErB0mL3L2cljzd1BXH7MCSyIA+FleeUIAamM6nL/escFAvAJMdX1PCiSXl6JOPaiQNJQt/kNdqqBdZxxU6KfBCIEsresBo9akvtHOxFEGEgLQ6MMGArVuzIJb9LK3/YXZ80Fl4iqwmo0prO5+kWIyAZuMcdMbymTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141534; c=relaxed/simple;
	bh=PXt+8MjJEqVoNZSSj5nMMvqwhGPbt8q2Ius9SofHVqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6FZQ5h7AMGsZCnjPN5EK754GrB9dSadjW3ZYLuhtEunootonPc16JYLoimbZsThqKbBYKiHQFJTuW8Rnmh2pxfU/8v9/R31fWGBzlUIkNdGInttEU0wiDI3kC7XQUltxOC0G3DmdNc97GVUyulDIxU2ISgMZS/z6zHzXRoEqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K96snuGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K96snuGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B461F000E9;
	Mon, 27 Jul 2026 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785141533;
	bh=214qHaKsK4amtX062wCoq/SQE3RaV1Z8rBCxzjwLx+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K96snuGrpqffihOEGZUS5yzjUyKH9GmWp9evaEgxeaLeCSUleoqBLXk1Ij0CSPSJw
	 EWPFa3Og1OroO+K8JAFdwMNYKEfPO9e0UfgpkWqPvt0d1AE4HBogVDAt/xUOBILO3k
	 6gCyKg/duQKQQl+4lq7vlYAxDpneGaVy4L+792/dHUurSHYi2J5ko0qXWKF/gVZD+X
	 GktxKqXjpGcMFXDEjZyC/ls956VE9zHP8+xxqSKymex0rcfcP5F+HrOjC1zh0uOIOs
	 f1VRjGH4HqJOQN44PSrinHQ3NTX0AOXX+YWtpMvquggQ/1Ay2AYIhcyaoOOszjJPSW
	 XYJa1JU+2SGZQ==
From: Simon Horman <horms@kernel.org>
To: shuangpeng.kernel@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	david@ixit.cz,
	oe-linux-nfc@lists.linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: llcp: Fix nfc_dev refcount leak in connect
Date: Mon, 27 Jul 2026 09:38:38 +0100
Message-ID: <20260727083838.710246-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193759.1773705-1-shuangpeng.kernel@gmail.com>
References: <20260720193759.1773705-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260720193759.1773705-1-shuangpeng.kernel@gmail.com?part=1
---
Now I have all the information needed to write the report.

commit 01a1553c1a8c5e891087997a8fe9ee0913eb3c57
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

nfc: llcp: Fix nfc_dev refcount leak in connect

This patch drops the nfc_dev reference in llcp_sock_release() when the
socket is still in LLCP_CONNECTING, addressing the leak path where
llcp_sock_destruct() only puts the device on LLCP_CONNECTED. The gate
is keyed on sk_state at release time.

Link: https://lore.kernel.org/r/20260707183518.1888697-1-shuangpeng.kernel@gmail.com

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index feab29fc62f4..0a3d87c2c9b3 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -633,10 +633,12 @@ static int llcp_sock_release(struct socket *sock)
>
>  	if (sock->type == SOCK_RAW)
>  		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
> -	else if (sk->sk_state == LLCP_CONNECTING)
> +	else if (sk->sk_state == LLCP_CONNECTING) {
>  		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
> -	else
> +		nfc_put_device(llcp_sock->dev);
> +	} else {
>  		nfc_llcp_sock_unlink(&local->sockets, sk);
> +	}

[High]
Can the leak still occur when the peer answers the outstanding CONNECT
with a DM before userspace closes the socket?

After llcp_sock_connect() returns -EINPROGRESS, the sk sits on
local->connecting_sockets with sk_state == LLCP_CONNECTING and holds a
device reference. If a DM with LLCP_DM_NOBOUND or LLCP_DM_REJ arrives,
nfc_llcp_recv_dm() looks up the sk via nfc_llcp_connecting_sock_get()
and does:

    sk->sk_err = ENXIO;
    sk->sk_state = LLCP_CLOSED;
    sk->sk_state_change(sk);

It does not unlink the sk from connecting_sockets and does not drop the
device reference.

When llcp_sock_release() then runs, sk_state is LLCP_CLOSED, so this
new branch is skipped:

    else if (sk->sk_state == LLCP_CONNECTING) {
        nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
        nfc_put_device(llcp_sock->dev);
    } else {
        nfc_llcp_sock_unlink(&local->sockets, sk);
    }

Two things fall out of the else branch:

1. nfc_llcp_sock_unlink() is called against &local->sockets, but the sk
   is actually hashed on &local->connecting_sockets. sk_del_node_init()
   still removes it, but the wrong rwlock is taken, racing with
   read-side walkers of connecting_sockets such as
   nfc_llcp_connecting_sock_get() and nfc_llcp_recv_cc().

2. The device reference taken by llcp_sock_connect() is not dropped.
   llcp_sock_destruct() only puts it on LLCP_CONNECTED:

     if (sk->sk_state == LLCP_CONNECTED)
             nfc_put_device(llcp_sock->dev);

Is gating on sk_state at release time sufficient, or does the release
path need to track connecting_sockets membership (for example a
per-sock flag set at nfc_llcp_sock_link(&local->connecting_sockets, ...)
and cleared on transitions out of that list) so both the unlink target
and the nfc_put_device() are chosen based on where the sk actually
lives rather than its current state?

The DM-driven variant of this leak predates b4011239a08e, but the Fixes:
tag and the subject scope this patch as the fix for the connect-time
nfc_dev leak, so it seems worth handling in the same change.
