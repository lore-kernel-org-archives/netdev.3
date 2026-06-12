Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2A36E48C;
	Fri, 12 Jun 2026 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304238; cv=none; b=EdpsGCkSVtOVhm5BD+EB9jMXRFxdtXvJMbXK58UlglW5+bDrLHPvqE6zBtAh+HY4sogX/YUlB+qFv6qPMTLc4jZYieTJD8ZYsoYMK9VDfTScyLO1HXtiJYEw0jC0/gm079OZGW9Ah7LBxnIXfc8OgupJbPZhY5NfGHly1SP1+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304238; c=relaxed/simple;
	bh=T35Si9CnEdYuTGRZL8UJRLUR2/bBJ/8hSaxdwXr+WtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6Smmp8b7+Lnqb4Mmf/+FZn9DLQMi+8Pt0SulhzfyHtd/HuTqwEjEXRqeH4o9XAANMeZXkZU//vNEstiDi9oiyAMvVQg06A5wqz0eA22F+3wBfot5+2UrrIJaPGXiMUMaXSJbco7xG2XCgFi3IJ3vXHJVaYSXqMKhZDwuEjv/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqIpblb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqIpblb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0A51F000E9;
	Fri, 12 Jun 2026 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304236;
	bh=AmodO/H1wG/sjuRZupj+eYJxani2PIRdvwql/4iS23o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MqIpblb0ZFcdo/OqrGOSIg4cuBtRsGx2cV4arNg61QJmJBZ1nUo9V06VXlDDO81W3
	 o3ZS0ZMV9FuGKF9AVSNZg7HJFrvV0B5LI+IByMrzDVKfYH/c+kXhq8PoeL4KvtWdys
	 qelwW9oRFKl4Gszr3hBqzzdna6VQULW91j25VrTVhCqqvGeuCnBbTTmED1nijzucGd
	 5rOSpeJVzwKOXZ79Tjfp0DiRmeH2OzU+TF1JlMlyL4roLahohDh/CR0cnZFy9ntL1Z
	 P9HG4WUn51FRejkT3RPJdLvimRUgAv42nir+jWeytGVNVm0ryGl6qaZPusX+DBhrdX
	 nfbFbvKcOxR8w==
Date: Fri, 12 Jun 2026 15:43:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>, Eric
 Dumazet <edumazet@google.com>
Cc: gmbnomis@gmail.com, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: tighten the FIN exception in
 tcp_sequence()
Message-ID: <20260612154355.37bb426d@kernel.org>
In-Reply-To: <20260610-tcp_fin_more_restrictive-v1-1-eefc30d7ddd8@gmail.com>
References: <20260610-tcp_fin_more_restrictive-v1-1-eefc30d7ddd8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 00:09:24 +0200 Simon Baatz via B4 Relay wrote:
> From: Simon Baatz <gmbnomis@gmail.com>
> 
> Commit 1e3bb184e941 ("tcp: re-enable acceptance of FIN packets when
> RWIN is 0") added a special case in tcp_sequence() to mirror the FIN
> exception in tcp_data_queue(), which accepts bare in-order FINs even
> when the advertised window is zero. That behavior is not
> RFC-compliant, but was introduced in commit 2bd99aef1b19 ("tcp: accept
> bare FIN packets under memory pressure") to break tight FIN/ACK loops
> caused by broken clients.
> 
> However, the condition added by commit 1e3bb184e941 ("tcp: re-enable
> acceptance of FIN packets when RWIN is 0") is broader than required
> and allows other non-compliant packets as well.
> 
> Tighten the tcp_sequence() FIN exception to only allow packets where
> the packet is a bare in-order FIN and only the FIN flag extends beyond
> tcp_max_receive_window(). In particular, this exception is only
> reachable if tcp_max_receive_window() is zero. Otherwise the packet is
> already accepted by the normal sequence check.
> 
> The existing packetdrill test tcp_rcv_zero_wnd_fin.pkt exercises this
> behavior already and does not need to be changed.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

This is odd. You are sending this patch which shares a lot of
similarities with Eric's patch:
https://lore.kernel.org/all/20260608151452.706822-1-edumazet@google.com/

Why are you submitting your own patch instead of discussing it further
with Eric and letting him send v2?

Eric, how would you like to proceed?
