Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994366;
	b=vx7acD8Thwq2QDk43t/OdgiUg7PgRZSFtSi09s1EWlASntxL3eepe+V3EkUK1TaFyLIw
	 E3A+lz6QCF1iROi/fEIdfs7TTbGxBVt1cpeicqfeVgIasHdwTh22GwIUMmd77j70Bzo1Y
	 LzPbW4w+WHYSp2+mNj7A0Z9ETfVLlBU8XWvTkHUDIojC5utw5SmIb4JVx+wBuLM8nfNGN
	 dnO9Jp3o/+YAJqy23OzjqpKa/zl58Yh9piQ6NDO0qamDyTgYuQDioGDGd//R0vGH9Cp5O
	 AVI1gar02FGCoqz6sFLJbWbtR3edhlG3t8JacmfcuBT8FHHWdtx06XNEm/DcTUc2yIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994366;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=COs/TUk4qiU7GxyHISTIlP6sMzCcAoybiHUw6sCgzug=;
	b=j3pw6akQFMoWT/w3nhhbU/5LcXCVXVO6ZZ4L/nRKhr79CVlGUOpk98ZioL+vM89q0s6h
	 eCl4uPt2/x+1S0UKTmwia+hGCuGwHEuT8OYRBiz3YYaNIkOcvGKYKS/uWIagVIExHYanZ
	 NpZ4E1uDShGYIRwtJqmylYlFUKVVXjlsQsDhmQeY03FYP2lmrO5ZMj8oazS5mW4ou3oaK
	 K8WT2N0QyvOGGax0H+KLkyB59I2PljwwWqx/akLzzceG4Kej0n1hYByyfAe9QZn9htC7C
	 g4NkQ5I7G/vFle1xV8oULHR9epaBtcIB0gbFxJaBm0fJXmI/xqhaSnrt/npSaXDlQHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=al7HDrjl;
	arc=none smtp.remote-ip=95.215.58.49
Received: from mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB48606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=al7HDrjl
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VgV9fc/O4QmVrn4wr6/mmQ0PELV8z5X97stIcx5TCWc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792994362; v=1; x=1793599162;
 b=al7HDrjl6EvqnKzBlQ2T46KnmeTKPDXd6QhTLjZcDpJHbFc3+feAwO1IL+2PzOBvGa5PMCuZ
 E+NaAMWx3U5lVRF+8BQ5pcNIxtCMhhG3pPR15CCYdh8xou3VpaStDsgQ/jpw6qvN8tSnQjQpjDY
 yNSKtksaEkKTxf91HAcAgJMQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 612ba363ae14305c;
	Mon, 26 Oct 2026 05:59:22 +0000
X-Mizu-Trace-ID: 612ba363ae14305c
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 13:59:09 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@kernel.org, dsahern@kernel.org,
	horms@kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH net 0/2] ipmr, ip6mr: Fix several info leaks
Message-ID: <at7sLZYY-qkAj2Ts@fedora>
References: <20261025071729.34967-1-idosch@nvidia.com>
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
In-Reply-To: <20261025071729.34967-1-idosch@nvidia.com>

On Sun, Oct 25, 2026 at 09:17:27AM +0200, Ido Schimmel wrote:
> ip{,6}mr_cache_report() copy the IP header of a packet that triggered an
> upcall to a report packet that is delivered to user space. The header
> is not always fully initialized or present, resulting in info leaks
> flagged by KMSAN.
> 
> Patch 1 fixes an info leak in the RTM_GETROUTE path, caused by the fact
> that ipmr_get_route() does not fully initialize the IP header of the
> packet that it creates. IPv6 does not suffer from this problem.
> 
> Patch 2 fixes info leaks triggered by packets injected into pim{,6}reg
> devices via AF_PACKET sockets. The kernel does not validate that these
> are IP packets that carry an IP header before calling
> ip{,6}mr_cache_report().
> 
> Both issues were reported by Sashiko and reproduced by me. See KMSAN
> traces in the commit messages.
> 
> As far as I can tell, all other callers call these functions from the IP
> input / output paths and therefore provide a valid IP packet, with the
> exception of ip6mr_get_route() which fully initializes the header of the
> packet it creates.
> 
> Ido Schimmel (2):
>   ipmr: fully initialize the synthetic IP header in ipmr_get_route()
>   ipmr, ip6mr: validate packets injected into the register vif on xmit
> 
>  net/ipv4/ipmr.c  | 7 +++++++
>  net/ipv6/ip6mr.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> -- 
> 2.56.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
