Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7093C81B5;
	Mon, 22 Jun 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144317; cv=none; b=biJuK9L6/4EcOE56uv+udKcxI2TySKXO0gD2qjJsvlQtGP6z0MY32fxjDOrCZmflkuZXoSEHwzJtwlu3tJvkRGNB84Un1BCEsO8lCTeYJu3ltpbzemMPpMNd5LUyLvSQ6h9e1u07TMCTk7lLLjUb9Yzgqe2GIwbwUmuo3UehPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144317; c=relaxed/simple;
	bh=pt766DZdxBUcDyvKEzhF8XNX1Wfs/kuURE/UNuicCnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+NuMq6Nh8pBUESvIIKEAWmLOz4gL8KLspyxm5/TI72DM2ZYpNQ/yTKC8cissiasZ+pZUZ74q0cVSsmtgIuTpNaNzaBd1RkKwLOInAnE1vMWKsyILbvkjAqYNjlhAYOZKT4hxIP1A8bkzx7cR+hFcbJyCoG6eIiHyvt8pVI63Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=0CuzF18c; arc=none smtp.client-ip=195.10.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="0CuzF18c"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gkXqw2bQ9zDsRV;
	Mon, 22 Jun 2026 17:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1782143788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34VfxUHMz8Es3ucc1IX16yTEp9kPd8dZELhVzMf05/A=;
	b=0CuzF18cz7+Ya0IM7TCIGLWkEOibouzQ/XYIDOr7v+rHVul0tqxnxYof6KlXOTkjSGd9s9
	YXKKjYrRNBKU6SWGW3TckPx8G5NGxSq9dDko/jRdHSFx2mkzKwnPD21SVtH+Nr4d91p4qm
	7KHMEAtXBY35VhpR7C1xG4pv4o/vqsMhT4Urf07Zd93o1y/V4GLi5iNsKuO0geEQOuQ+iS
	MciC0yPIFN1+KNImq/cpzTgVLrDPcUGlBv1yk53h2iSgygbCjyMSJKFsvxAm7jr9811RLu
	quiRX9VSVU6npUTamCxFpUbPhR4RP3yVUIfAUC65kP4MXkOnm4hVtNuxQMI77w==
From: Ralf Lici <ralf@mandelbit.com>
To: Beniamino Galvani <bgalvani@redhat.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and dispatch core
Date: Mon, 22 Jun 2026 17:56:11 +0200
Message-ID: <20260622155612.591109-1-ralf@mandelbit.com>
In-Reply-To: <ajjzF3W-0xDC133f@tp>
References: <ajjzF3W-0xDC133f@tp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 10:32:23 +0200, Beniamino Galvani <bgalvani@redhat.com> wrote:
> Hi,
>

Hi Beniamino,

> speaking as a maintainer of NetworkManager, I would also like to see
> this feature in the kernel!
>
> In NetworkManager currently we are using a BPF program [1] to
> implement the CLAT, but that approach comes with limitations: for
> example, we can't fragment v4->v6 packets if needed, and it's not
> possible to recompute checksums in certain cases (e.g. for v4->v6 UDP
> packets with zero checksum, and for fragmented ICMP). systemd-networkd
> is also adding CLAT support via BPF [2], with a fallback to userspace
> for the cases that can't be handled in kernel.
>
> It would be very useful to have a native in-kernel CLAT that solves
> the limitations of BPF-based solutions, and can be used by different
> tools without having to re-implement everything from scratch.
>

Thanks, this is really useful context.

CLAT is exactly the kind of consumer ipxlat aims to serve, and the gaps
you hit in BPF line up directly with paths ipxlat already handles. I'll
cite this as motivation in the next cover letter, if that's alright.

While reading the BPF programs, two things stood out that would help
shape v2. On addressing, both implementations use a single NAT64/PLAT
prefix for destinations plus an explicit local_v4<>local_v6 mapping for
the host itself. ipxlat today maps both source and destination through
one RFC 6052 prefix, so this suggests v2 should probably support
explicit 1:1 address mappings (EAM, RFC 7757) alongside prefix
embedding. Is a single local mapping enough for your case, or do you
foresee needing several?

On the consumer side, is there anything in how NM models a connection
that would make a particular kernel model awkward to drive, e.g. needing
to attach to an already-managed interface, or conversely being able to
create and own a dedicated device? We're still settling the
kernel-facing model for v2, so consumer input here is genuinely
valuable.

Thanks,

-- 
Ralf Lici
Mandelbit Srl
