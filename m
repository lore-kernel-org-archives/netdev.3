Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22C3A6F17;
	Wed,  8 Jul 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524363; cv=none; b=aK9GXyoX+9i3EYdYb5TQ89oFsA65HI/nHhAX5TCVszcUPoMNsxoxTazUPF++KVoVoOLgeqJy4fwDwLm4C6Tdi5VDOhqrTIKxZfBh5G16tENXbLzIvLv8Ucnho7npgMRyXavNYfVgDOj5yFlAa787EjYAXkCzRPMq+4ogfwP/k8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524363; c=relaxed/simple;
	bh=odcECtMHFEoUn6zU4zviED276a4aIPGxcfNjbkl/W2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf7pIODjdJdb02ErX/m1AKtu7ZFE0Q9umGFPoDxckuMPq1nzAtQZhreQJY7bYy+iV2OEv59cToU+yDue2mPJTpphwkBkzyPPYbe3m/U2TtksUSZBWXm4rG+TJK6I4T0MJv2iEA6ckL0loWN2/HutRxz9fcs3DI7zNbJ+NJHYLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hBiuNXRz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hBiuNXRz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=odcECtMHFEoUn6zU4zviED276a4aIPGxcfNjbkl/W2I=; b=hBiuNXRz44gyJFpaWPuKfz6gri
	TnLPMnrqYk/DhyAjZ1aywdiQQlaIjzyWM0nq5FskuRqBV+eMyYt96hWOz+srAvJLOUmowTYXWY0YM
	2sTCI1LgaBjRYwj7DrlLR5pQejUPmmsPkNBxmkwptZ515o0R40xmvukBnp+dlrqDSh6KTUcnc6TML
	o56dxX9k6naSnKKQgF5VoxqGTLWGmWtU4/0JWDh0goiV2D+QDihcBOgz7+rwbYApwobIspxKi1pFp
	affFbVAyb7eC/5W/Oc4XVdH4NQ12KGylJIGmeEZrwRVZ+lnZ6YP6piS5bMOr0OIZaeZq+Q2aXDepC
	GEPybpfQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whU9p-0032gh-2n;
	Wed, 08 Jul 2026 15:25:54 +0000
Date: Wed, 8 Jul 2026 08:25:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH] net: use sync wakeups for socket error reports
Message-ID: <ak5rH-SWjiqR6MVe@gmail.com>
References: <20260708133815.3419465-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708133815.3419465-1-usama.arif@linux.dev>
X-Debian-User: leitao

On Wed, Jul 08, 2026 at 06:38:15AM -0700, Usama Arif wrote:
> Measured on a 176-core EPYC 9D64 host running a Meta production
> workload, bpftrace on tracepoint:ipi:ipi_send_cpu with a kstack filter
> attributed the sock_def_error_report -> ep_poll_callback ->
> try_to_wake_up -> ttwu_queue_wakelist -> __smp_call_single_queue
> chain to 16,326 IPIs/min.

I am interested in why so many sock_def_error_report().

That's seems a lot for genuine socket errors (RST/ICMP) on a healthy
host, so I suspect these aren't errors at all?

Can you share the full stack above sock_def_error_report()?
