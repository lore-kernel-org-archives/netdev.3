Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389643AA1B2
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066976; cv=none; b=NQfUhmLFZvLzgOgGVdkHrcWSxXa8o3SM578soDcRk3MAya+i7jmt4XNMb95ShFsIuPhsPBTwSBjzpU4BA3e5BXj+dgXMiie7pmRV95f+wwBPq5WbH6DX4/p4tgwPp/uKb6ekH+gid2QGr5M+5FbhJz9ZGLQ/15AxTgHg0ZULg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066976; c=relaxed/simple;
	bh=Fu2n3BnOxXot3kZ7+JaRDlx1+WuO9eZ8yLgzOEaQxiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIRlRgGCBSxwqX9xteR+cBeVpsOp7FzhMgA3vTZ9jRKXXZjF3u5495xUDb832bKJKinPBmvgJ7yUBcwuvC0IUW4LrD/FhZH7tLG9nghLhumMWhfBsO/obGXZuvttrjIdXPjfjk+lFhYVDYaYe5sZYW6VlE8t7DkTAb3qGssgsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7fhLpkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7fhLpkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09141F000E9;
	Tue, 18 Aug 2026 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066974;
	bh=Fu2n3BnOxXot3kZ7+JaRDlx1+WuO9eZ8yLgzOEaQxiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M7fhLpkcm85yYr+S4YvfDk1ZyJ0JikJVkvVqSs5a7i77lp3GCICaHjW1TJIyAQ5ky
	 8w+v+8WEzKxNtwatOg9DdmOrIElZNO5Zlbmizi2D4OORnK5fg10I2vHWkke1+VMzPq
	 QJ9C7QAWGWu/U8WRFC4tyy/fxWoObOX0U/pgGPqesbVP9dGPbY3EPK8KB5ZR2jRrs6
	 wGWdlUDa/krBtcqSBTt2kj61cXxJavNI359zUk4zs+zLYlY3kIUvU46z4IgoksZokc
	 PKcrVKXMIf4bULIjHuEVp4wam/bI0Mprh7JoMf3qzXAFUNJaqEoPypnX6ZpBHxNhEy
	 qhZYgee67Esuw==
Date: Tue, 18 Aug 2026 08:29:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
Message-ID: <20260818082933.28b5c9d1@kernel.org>
In-Reply-To: <CALC2Apj7rQv=6uUqaqBjfJ9yO+VCddQqHB=yDhXH7+QUCh2JyA@mail.gmail.com>
References: <20260817090601.1256389-1-pawlik.dan@gmail.com>
	<20260817161756.5fd2185a@kernel.org>
	<CALC2Apj7rQv=6uUqaqBjfJ9yO+VCddQqHB=yDhXH7+QUCh2JyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 08:23:33 +0200 Daniel Pawlik wrote:
> v8 does not switch to coherent DMA; it only rounds up mailbox payload
> allocations (dma_get_cache_alignment() in v9) and maps the same rounded
> length with DMA_BIDIRECTIONAL, while the mailbox length register still
> uses the original payload size. On this board, mapping only the payload
> size regresses probe back to 0.0 even with the larger allocation, so the
> rounded map length seems required here.

Please trace into the dma API implementation on this platform where the
alignment makes a difference. The "unaligned length" path must be buggy.
We should fix it there, not in all the drivers (my concern being that
this is not the only driver that hits the issue).
