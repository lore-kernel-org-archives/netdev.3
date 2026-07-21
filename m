Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620F39768C;
	Tue, 21 Jul 2026 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672924; cv=none; b=ZB9LzRElXre3n6/z6JdOFY4WqkUVWbpCgGzDQ3LLERw6YZhkIfbNqBp02GUQdscUbzVOaBCwKc1DFcepjvElNYMwjuvNKRsGWiW0jhiEmQXj4aM8YiI4YmQqnWxLjen/+o1Ee0QeLGxli7tsLbMjbMb0mWlRGDqA89WUCKQcTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672924; c=relaxed/simple;
	bh=8ZPMmpE9Yd8t2kSj5AVGIzDNSzCMoGFqHFEgTg6GC5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msiGv5tMSplT/1h3ArgCiEwG8zBP40QqCbgk6x9SqDQNPSx5EyKQ1m1gBpsiyZdqQtbfIEij12FKngpTV8VgcER7WOvF+ZxRQaDEEkZ5rcQXvDo/5KSnn8A9uL7EELSnajUaceDEGJcHuUCIEcGXGI89d7FOU8f6Xozt/SuY/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/GZ3eAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/GZ3eAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFF81F00A3A;
	Tue, 21 Jul 2026 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672921;
	bh=JM6u5NbwgOPdzr18zeF4SF12g7wrQy7/ZLOT7oLfNCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N/GZ3eACViPk+M4Sm11CgBv5p7GmHju5I8SklR8OL/n48xS5guVpUm8YYbFY6779H
	 UaEk2tG1h18//4NaAM/FUzD0slJF6/y7zkQ73dinn7m8LjuwMrspPtuBbRygYEOnRC
	 US+rInvatvUtmrpYOyrfI0SAvMm+YrANPMt5mQ6CJuvFr6oNK6BdJdusk46Uv81rj/
	 fw+FSaafX0O+iVZeA7QZ/Q3GPN4rIFKbi2jlY9K7dacwGZgyfPGNxlnlOkw6hDJxQL
	 0eAcI9TOT3tbRnrqvnyOXYIoh34zaHBRxqcs0g4PdoIM7iNuldEuZJif5dgMBWx+F+
	 IrW2Uw8hlW2SA==
Date: Tue, 21 Jul 2026 15:28:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 00/14] rxrpc: Fix CHALLENGE packet handling
Message-ID: <20260721152840.407c0a7d@kernel.org>
In-Reply-To: <20260713081022.2186481-1-dhowells@redhat.com>
References: <20260713081022.2186481-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 09:10:06 +0100 David Howells wrote:
>  fs/afs/cm_security.c         | 311 +++++++++++++---------------
>  fs/afs/cmservice.c           |  33 +--
>  fs/afs/file.c                |  12 +-
>  fs/afs/fs_operation.c        |   2 +-
>  fs/afs/fs_probe.c            |   5 +
>  fs/afs/fsclient.c            |   7 +-
>  fs/afs/internal.h            |  63 +++---
>  fs/afs/main.c                |   1 -
>  fs/afs/rxrpc.c               | 137 +++++--------
>  fs/afs/server.c              |   2 +-
>  fs/afs/vl_probe.c            |   2 +-
>  fs/afs/vlclient.c            |   8 +-

Why are we getting fs/ patches?
We have enough bugs routed thru net as is, can you please find some
other way to get these to Linus if they don't depend on net/ changes?
