Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA573C8C7C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078722; cv=none; b=WJv3piP3fcDLFSarG8v8T7nOoTdxEFExcXmb22CJXVTQdzuzSWIMyczrGxCe0y2NlU1tEtb/L0jhZHkx8xaJkqKVfSxy6mmYPr2a4Nhxor6eOmwFbywLNo/WIEMtmPTn6btCRGpst4oP67b607iDNa/lFXUoPtHvLaJYh09nOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078722; c=relaxed/simple;
	bh=F7h0usnQsuGtJCv5kXjbol3+qgJKG2AiZozjGMxt9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upqYD7JBAKCG+P7pPnIxZxN/ED08TR+PvC5pPElmuPZPX7jPhNmxRQVBrlMPFGiFUBlkZU/nL4TyawQg0rcOBFCwOJIOhnc1fLn4NA4ETyXs/A0/ouhP1siw4oWA8vEjN5v69QNYtZvP+n7ih0QGw8B84mVUI8KQemT0LuCOv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=OQcirJKd; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="OQcirJKd"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 813A560579;
	Fri,  3 Jul 2026 13:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783078719;
	bh=A3WsYqXQKspJYG5FBmk1Usbg+qmRCujBeq0O7Jg5Vso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQcirJKdxHB+cJhwRFuU65a/jVa5is+Q2U6rYe7ey6NwM+l/1QM3aZNtKlf4KD2fm
	 MeWhfvpo6epJ0AZPZ6EwqNo+SbvbBPGg899GK2oiZRnW8nP6R2gtoND15vjVUgLgMv
	 do64JD8cNYRYBKf98zNBt6IA/E0Ky8/WmXAN1eMiPZjHqPcFKDKWDGpf6Yjrx6t4ne
	 +V73zGXYFcIPgOugZclimvMXNODYGh1JyWNDMSwNaDTudUYInuurNKFdfOJFWCJvn+
	 50BRAxX4XC/XAG1p5h7z8DixrvHc8Mve3ArJQH49aBOXE6g2/DFiRJn+wXhL/4RokQ
	 j2mQXHEHSQ+ww==
Date: Fri, 3 Jul 2026 13:38:36 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Zhixing Chen <running910@gmail.com>
Cc: Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] gtp: parse extension headers before reading inner
 protocol
Message-ID: <akefPJ5cCrsZcpRw@chamomile>
References: <20260703093708.18141-1-running910@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703093708.18141-1-running910@gmail.com>

On Fri, Jul 03, 2026 at 05:37:08PM +0800, Zhixing Chen wrote:
> GTPv1-U packets may carry a chain of extension headers before the inner
> IP packet. The receive path already parses and skips these extension
> headers, but it currently reads the inner protocol before doing so.
> 
> As a result, the first extension header byte is interpreted as the inner
> IP version. Packets with extension headers are then dropped before PDP
> lookup.
> 
> Parse the extension header chain before calling gtp_inner_proto(), so the
> inner protocol is read from the actual inner IP header.
> 
> Fixes: c75fc0b9e5be ("gtp: identify tunnel via GTP device + GTP version + TEID + family")
> Signed-off-by: Zhixing Chen <running910@gmail.com>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
