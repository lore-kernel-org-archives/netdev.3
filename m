Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707720;
	b=PH3Ei2x9aGnIpYcTa0TfB/t53VmAKsypPDR5i9NLx7YvjfFYwW+YyouGAc4T/X4E8EoE
	 NxcNM6d0XQW/XyPMEHBi8EAwo4Zl7GaeHxZ7FbiOx/JNChkmuX5dm1jZWAqzYVkk7ZYZz
	 n5pCFZcT8SYRCnN10mnpp3YCTX3/WQSEBkwM1fypFkRJ/n7LWIiVaeS4JKaESQO+FM6Ds
	 ZWyV5yAlP+lKoOXrmYHNSnAJ+u5IoypoPm5cggirExWwWDskdmVkIv4wvSulIKeymjkIh
	 PDgKlgv0OmNi1YVQ/dyZDeC7LjAhP+vdKqFN1qcwbXbnP34YwOMsaUPs28VdkyorB2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707720;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=M1HpJIBKVwB4sBe5LelfhtNY+qip7wrToh9kTtlLHj4=;
	b=iVQJDbFiKVcY2yA9X2QDEZhsmsvAgvqYKWvAGrkKMNEuKnKwqm/rBYpm+yX0UQjvblOQ
	 /ngtOsgUQk13AL5OxnKmtH507xa1jeuy92HFYCFOUgw3ZEL6JEIk+Hm6lbqpANFBW+SNz
	 JS/2sjs2ps3pIRNmDWdDYzMJjsD55+chj6g0TAXPYykDd1m8atzqvvVpa9O0DYQxKz4/Y
	 vW5tZQ5RZiDdDhRGXUzl0YjEFDTSoLN1deuvc1zf4B941gkPAwKA2N/0M0YUxHBaR+H4m
	 WFiUpVsrJsuW6MXZUryNB6MYC0hhEFXv5aq9tZloUOK5KxgvewaI5/qKBt99wOLGanw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=MkJxAzsX;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2D606A33F;
	Tue,  3 Nov 2026 12:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC2D606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=MkJxAzsX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M1HpJIBKVwB4sBe5LelfhtNY+qip7wrToh9kTtlLHj4=; b=MkJxAzsXMyXJ9XRbTDS0PZpFac
	ExeuR1CTGx9+HMqHL7aDyU7b60rYcS4gkj9Dr3iWj6aBUM2SB1EciHZ3TzPm4UIyZvAsl0mZdEja9
	lApW6we0hxeYwjp/XofnWXfGI9XQ5svpNIZmsHsLN1JlTDnb9HgsNjT15495J3howxZzqqB6v79iB
	Ix5h7B9Hu/za5+19o3UKNimelcW4epqCc31WVvzhkKVgm8bEmiPJudunZIznhY6S/64+GyhWiUxHs
	Tn1qRGbY5eqt/VV8P9UjbvjTMa/Wnc1zdCwjxiH4dtnI+QqIoA3XYW8D7i3w003fsW7AtRIIHSw/s
	L7JHr/bw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xODJY-006vCG-0m;
	Tue, 03 Nov 2026 12:08:32 +0000
Date: Tue, 3 Nov 2026 04:08:26 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 1/4] netconsole: finish enabling the target before
 releasing RTNL
Message-ID: <aunOsP4n9McXj_mI@gmail.com>
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
 <20261102-netcons-fixes-v5-1-bdada2f03563@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-netcons-fixes-v5-1-bdada2f03563@gmail.com>
X-Debian-User: leitao

On Mon, Nov 02, 2026 at 07:54:49PM +0000, Gustavo Luiz Duarte wrote:
> netcons_netpoll_setup() publishes nt->np.dev inside __netpoll_setup(),
> then releases the RTNL and waits for an RCU grace period before
> returning. Only after that does its caller store STATE_ENABLED.
> 
> A NETDEV_UNREGISTER event landing in that window tears the target down
> and we end up storing STATE_ENABLED with a NULL np->dev, leading to a
> null-ptr-deref in netconsole_write():
> 
>   BUG: KASAN: null-ptr-deref in netconsole_write+0xb9/0x7f0
>   Read of size 8 at addr 00000000000000a8 by task pr/netcon_ext0/135
>    netconsole_write+0xb9/0x7f0
>    nbcon_emit_next_record+0x501/0x550
>    nbcon_emit_one+0x10e/0x170
>    nbcon_kthread_func+0x2ff/0x3b0
>    kthread+0x199/0x1e0
> 
> Store STATE_ENABLED before dropping the RTNL lock to avoid racing with
> netconsole_netdev_event().
> 
> Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

