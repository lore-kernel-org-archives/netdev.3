Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFE35C68A
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668153; cv=none; b=Z9QTQZUFT0+pzWgIxEJmzcVwsvif9njE4cCYoZhpAOxodd+Fp/UeP5HKOMGN01Z3fKD66Vn5BS3eYMT52YhvESWG3HI6Mrc3BhQv24Ue3A1S5uW4q3B/TuBfvbOqtyZFsGnlnmdHegUdhnoaxCKGsjAyCIijP4l+uDhRzMzzR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668153; c=relaxed/simple;
	bh=HdH5SmJHwL7sYywdCK4BqyRyotvmOJ2Cdh/e52BoXOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jw09BuIVRinM9nqsFECNc0SZpnkdgsBqD9j11fOARKi3tomKp0+z+QM6EBKncy+rRWe5OW6zTlo3REwBA8TPuCA6baiKoRtFJNT4VszqlUwbUWSayTV423lJqaEA6/nw+yk3nce90RWsxlL+PdtkRMbUsJyCoBQeGrGVr+FMEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNCLDS+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNCLDS+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EA51F000E9;
	Tue, 21 Jul 2026 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784668152;
	bh=RIaQV6tMoa9LUnC46dI3d7MBiNCMMgLrvrWnt49KBD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dNCLDS+aZAHRLfIf4eG1nq/FGuR4um71zNIOvXxxm7+Jhs9hVSOtuRg/rTNyPmwz7
	 XT85/ahD3c1SHsEUKo35E71oNfO+rOlPs6+YSKUICKn67gcS/dPqZp40fDFDJklEzi
	 RIGXt7F67SRgMbe+g3x0rsp2D3bJjPf+dQr90tEZ3si/ikKhYafsxHTf2I31vZA145
	 x2VEUhG5eoPmx6nKItHQfnvbw8hLeidBY4VVliccdlorBAeLizpE12pLYNxL8UzZK7
	 kb7cRepSTdkZydSYnEM6YEY32NmFPGDqtbJt0xTxK10xR5DKYekNBZwFTidYXkqW3C
	 Yss3g1EM2U72g==
Date: Tue, 21 Jul 2026 14:09:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vimal Agrawal <avimalin@gmail.com>, kuniyu@google.com
Cc: pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com,
 vimal.agrawal@sophos.com
Subject: Re: [PATCH v4 net-next] net: neigh: avoid calling neigh_forced_gc
 on every alloc when table is full
Message-ID: <20260721140911.2e12e60c@kernel.org>
In-Reply-To: <20260715055311.90403-1-vimal.agrawal@sophos.com>
References: <20260714133909.82424-1-vimal.agrawal@sophos.com>
	<20260715055311.90403-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 05:53:11 +0000 Vimal Agrawal wrote:
> Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
> on every allocation attempt with no rate limiting. In workloads with mostly
> active/reachable entries, the GC walk traverses a large portion of the
> neighbour table without reclaiming entries, holding tbl->lock for an
> extended period. This causes severe lock contention and allocation
> latencies exceeding 16ms under sustained neighbour creation.
> 
> Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
> performed within the last 50 ms, but only when the table actually contains
> NEIGH_FORCED_GC_LARGE_TABLE_THRESH (16384) or more entries. This avoids
> repeated full table scans and lock acquisitions on the hot allocation path
> while leaving tables with few entries completely unaffected regardless of
> how gc_thresh3 is configured.

Hi Kuniyuki, are you still unconvinced by this?
