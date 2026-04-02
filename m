Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFDC1A01BE
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106836; cv=none; b=p78nl25v15KDOowRs0+IolG7ajlyRT5rxX1DQ0BV+R2x3QjjujKD9wRhPCLRk+2TegesRVo1eRRE4upU/iMoI/m6TjZcXYkLzRt28xa23FGWlZHbB2VEs2A97if85hfFXQSArXmHjmlGgw6P2kh3398nlEWXpNtqkq/hWHpgSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106836; c=relaxed/simple;
	bh=M9D0t1F3EnHTpEoaQcZeWtDrxL7SQRvJCLOglFUNAZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCkzol4rDtNICahACmYl62tfCu0eXbCGZqhmK7NclOq7fW7mo1BnXBvVAeeUHc6dh2vlm0j2cUEpj+0SsGBXOLjDYRlY3p/hF1br8bT5TlQ3nTVMjFkEywH1XT8EMs50TbNaR82GcM71G6H+WWTgt41mzjUe4vp1YpmotYXrRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrcuJreM; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrcuJreM"
Date: Wed, 1 Apr 2026 22:13:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775106822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ryojKH5prEL+2iJaE8DUviv6fmuqOdoK9QXdN3IQb0o=;
	b=TrcuJreMkzwLXt9bqfYhGDIDDb9mAsLSYaODJ6wAdZzlX4h+QVlwmkddwj7HrcsEoTFCv4
	OvoS4MaQxb1z8xpCaBkOmMzLEmEhjj6EbwVv1ipecfI78aA+/EuO6o4B8Z+YE96Mn0sNZE
	50viMJS1+lvw44w8/rKF2BdPNgXpgWA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test
 input
Message-ID: <ac33zzsqHlFc4GgE@devbig1721.ftw5.facebook.com>
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
 <ac2ccb5NBAB3Zq1D@devbig1721.ftw5.facebook.com>
 <CABFUUZEdh2-bpYG+inQeUwxs9UC7D-xm5tR4RtAsPHrG58WBSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABFUUZEdh2-bpYG+inQeUwxs9UC7D-xm5tR4RtAsPHrG58WBSg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 02, 2026 at 10:54:41AM +0800, sun jian wrote:
> Ack, I'll respin a v2.
> 
> BTW, v1 was mainly meant as a minimal proof of the fix, so I
> kept the existing structure intact.

This is already v2.

The minimal proof of the fix is a selftest for a tricky case
like this, instead of spamming the list, and now also the
AI-review tokens, with an unlandable patch.

It is a few line change, and I don't see how duplicating the
existing switch case makes the RFC review easier.
