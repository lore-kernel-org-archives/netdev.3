Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F73BB57
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116522; cv=none; b=atyrNbUe31o29vyzM+jRmG76xcjco3ZGforZ7uLJXkbpWrQxrwNvwM/4izLziQIO/BiCVmUh2LP8CqcSNw5yfjJx3D+UoZns+ekzNs7KVuS18DG0d1dNwyTKeqnEEGZbgeKkkAuVl/+sf9ygFIw1puh3i/UMJqR64XsQrD3cmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116522; c=relaxed/simple;
	bh=j0sMEPq2AA5hcCJzEfDCayKWc0NTPUfbf9yWpGlcjWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDMylpXmIOjZIZRRSZQqUwpm9S8esQzCQjaoTePWlUhkjzYhI+Fph3SHCX6R6ZlA+cgnwiVdSSrOUFoj1e+fnZ0j97TqtWt/HvbNsd6i9qTJyLcE1bUR3UpRcmOXuKsRB+G1dqfTrUnxFGd9Ah5PjBjgRU4+eSVcMrVoKnKgywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fapsf2fk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fapsf2fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962911F000C4;
	Fri, 16 Oct 2026 02:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792116520;
	bh=vDIIUftqRZ2TKJGmVipLpGowTGgcw0HOnSmojkd3fpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fapsf2fkOGU3EO1oxO5qxEjSV6WgAKHg4m5Q/uadmZO57e1p+lxSrjn5HmELFXzWI
	 dU9uwuvyu/ZL1Mo8P6sbGDs/t3AMzFHhZkpSYcx5SZT58duf45mkr1Nttp2yJlGsTM
	 qRTbF/x1cwIIH/4siQx9MPlFSTEGa0FPQjtadZGWzBi1Y1pjwcONZ1B/WWKYC/NJya
	 9cFM3vk5lb8F7asxUkuFc18oqnArfj7gn81zJMJ+VvIIwE7zBSAAwoDWNxATxO0G4W
	 vKaMFsAg1GBL2TuTpuM/o2x7tn0n2xrgmw9QTTOcy7OY6lB1IKuupmCVm/RHTijOff
	 4i4bZWu0SXs1w==
Date: Thu, 15 Oct 2026 19:08:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rongguang Wei <clementwei90@163.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, Rongguang
 Wei <weirongguang@kylinos.cn>, Willem de Bruijn <willemb@google.com>
Subject: Re: [RESEND PATCH net v5 1/2] tun: keep a kernel copy of the socket
 filter program
Message-ID: <20261015190840.1f972d69@kernel.org>
In-Reply-To: <20261012021113.45939-2-clementwei90@163.com>
References: <20261012021113.45939-1-clementwei90@163.com>
	<20261012021113.45939-2-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 10:11:12 +0800 Rongguang Wei wrote:
> +/**
> + * sk_attach_filter_kern - attach a classic BPF filter held in kernel memory
> + * @fprog: program to attach, with @fprog->filter pointing at kernel memory
> + * @sk: socket to attach the filter to
> + *
> + * Attach a copy of a classic BPF program that the kernel already holds, the
> + * way sk_attach_filter() does for one that still lives in user space. The
> + * caller must hold the socket lock; SOCK_FILTER_LOCKED is checked here.
> + *
> + * The program is built by bpf_prog_create(), which does not keep an original
> + * copy of the instructions. sk_get_filter() therefore returns -EACCES and
> + * sock_diag leaves the filter out for a socket that uses this helper. A
> + * classic BPF program cannot be duplicated with bpf_prog_copy(), so keeping
> + * the original would cost another allocation and a copy per attach.
> + */
> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)

Warning: net/core/filter.c:1585 No description found for return value of 'sk_attach_filter_kern'
-- 
pw-bot: cr
