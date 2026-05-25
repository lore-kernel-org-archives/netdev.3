Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051C33C53F;
	Mon, 25 May 2026 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734136; cv=none; b=aMYsbMwya3THLImqpGFWp3pI+ztAc9R27LbjWvBOiPVpqN5h7sfpcEh/5CawETtTY1FN7O5LGV1mM1+JrIcAccjkj2whh6Viee5hO24OmFHtuQKqwd8zLiFQJm1O+ND0O2U174b5uG9ZEGwjQYyX2WYcYCxY73P/DQuQJLv+PB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734136; c=relaxed/simple;
	bh=RzsUrrhf9Q7ZCKFY6m0O4XIZT4ksovgXMtC8Ldrz/k8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKzQFcxpbfGnhuiDI7RY9h0eJy3FvbIsjZsGpENkl2Rsova63LTN6h/SREwIFsAEygxEJdG5kP14lwB2VX3XBtjDQ8t+jDcPHok1qqzI/KnJMiatwp5B50Oe5ed2NP4uSHETGKyMEcinRe80SQObFLPYAt3yYUwd3L488i8ojTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5hqwouB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5hqwouB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110DF1F000E9;
	Mon, 25 May 2026 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779734134;
	bh=mEvp6E1uZYwArkSwoi+Vn08rs5/YXn8OrbytPCNf47Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h5hqwouB/XaiUavPuT1WP/R1PBl7lwm33dHIHA04m10yywq7BEH5AAqxRaRYNtYFx
	 VPD6EVLU192q+09/AtaArq24xoRD5Uv9sG+MqTO1+6Kbp0EsnyHWyOhtf6q5Lviier
	 uLCjuqCGt5kpiuVXm2yeh7YraNj9/XyyX4rO0LRCGMdXZpAeGUOgHCahBHKeobEkRz
	 6xiJKyMpqVYjDF3R+ZfRe3F7JRQ/Mhzy2hIgLao5EynYOvH+bzBtQyaNr86cO5Bpya
	 dJd8bjUL/g6Zlx3F6Y1gWqZa3KEnYGLYH/SfULjmT2NFRbA/0UHDEBNKziBsCffTl/
	 R9sZmP9IPb5FA==
Date: Mon, 25 May 2026 11:35:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Chris Mason <clm@meta.com>, Christian Brauner
 <brauner@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>, Hannes Reinecke <hare@kernel.org>, Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH net v2 0/7] net/handshake: anchor request lifetime to a
 pinned file reference
Message-ID: <20260525113533.6405efa0@kernel.org>
In-Reply-To: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 10:47:06 -0400 Chuck Lever wrote:
> Three things in this restructuring want a careful look.  In
> handshake_complete(), the fput() of the request's file
> reference has to come after hp_done() -- fput() can transitively
> run handshake_sk_destruct() and free the request, so the patch
> stashes hr_file in a local first.  handshake_sk_destruct()
> itself is kept on purpose: it owns rhashtable removal and
> kfree, and remains the backstop if a consumer path bypasses
> handshake_complete() entirely.  Third, handshake_req_next() now
> returns its request with an extra get_file() held under
> hn_lock; accept_doit must consume that reference (FD_PREPARE on
> success, explicit fput on the fdf.err path), and any future
> caller has to honor the same contract.

Sashiko indicates races with handshake_req_cancel() remain,
and impact the code re-written by this series. What's your take?
