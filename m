Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7E3E316B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421018; cv=none; b=JN8SYPJg39HIEY5Wrj/soMtDvc8QNSbP0xo5cyDi9xAd9qEswziFmNBjU0rp9tuAnx0ndPlcKyvJOoQGX3XWQq+gFCHO20MOHkgQ9V2CN+2Upto9ab2WWdEJBpEMs0+1SJyePoxNqzYgIB0KnWLc4+g+dcafhu0azkGFavG/IeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421018; c=relaxed/simple;
	bh=mCk+Pnq25GG92QWdl7zx3xDVgEAizAApxbsIG77iA8k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7OkpV42F+UJdfvRAtureViCWmMphOVT1KjMI3N7+zixT9SQZev33R0Nbs2gaP1gqEzmjyCN5Txaiqmc8W7MJc0PPoZMEmrqu03ffGlD7i2/dINNwhhaw/hP0sk6JeiV10EhGzT8j914yQ0hTb0TgStR3GcDEGQxpN3LV3geen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wL+2VG4M; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wL+2VG4M"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C2C0520189;
	Thu,  3 Sep 2026 09:36:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BJrAQ_pLLghE; Thu,  3 Sep 2026 09:36:53 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 30C2620820;
	Thu,  3 Sep 2026 09:36:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 30C2620820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788421013;
	bh=lq9s2/KXSqlMuNeyfMTmNt05hOE3oyezBMSOJDPbs2I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wL+2VG4MIsF/vDTr/N43LHDHSxkcRPZekKzJ8nxQ/qARchq82R4H8sZDruNEcSCni
	 ih9uXLbM+4Dr05cOPw6AW9sKP7p7N2hPdvulEEv/02UThLc1vhYTWrhF8b2FUpp0ny
	 NHdsyA5bMuSjx2aCCK0+WtMfOlu4VwlyR2+xw8+fM1SSFQYTpZcCG6ssDYivtFBCwp
	 VWgqnegGMfMLTh0I6X//j+fOCYV7Z0ULHsbBmLp17x43HDnPFl+SF8FlQVCIjFETiS
	 0wcJHHz/uEjBYas321eY6OuwdVf3exkAxyjbfpo85mhAYQ8Utz99S1XFPDHbRpfe4/
	 4rftKbS7PqVAw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 3 Sep
 2026 09:36:52 +0200
Received: (nullmailer pid 1408915 invoked by uid 1000);
	Thu, 03 Sep 2026 07:36:51 -0000
Date: Thu, 3 Sep 2026 09:36:51 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <vega@nebusec.ai>
Subject: Re: [PATCH net v4 1/1] xfrm: save input state data before secpath
 resets
Message-ID: <apkjkwIE5g0MhknV@secunet.com>
References: <cover.1787994112.git.zhilinz@nebusec.ai>
 <52e0da6a8ae00868e180484645dee769402ee5f0.1787994112.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <52e0da6a8ae00868e180484645dee769402ee5f0.1787994112.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Sat, Aug 29, 2026 at 05:24:24PM +0800, Zhiling Zou wrote:
> xfrm_input() stores the current xfrm_state in the skb secpath while it
> continues receive-side processing. Some input paths can reset that secpath
> before xfrm_input() has finished dereferencing the state.
> 
> Receive callback users such as VTI and XFRM interfaces can reset the
> secpath. The VTI receive path does so before checking whether the packet
> crosses network namespaces, while the XFRM interface path does so only for
> cross-network-namespace packets. The XFRM_MAX_DEPTH error path can also
> reset the secpath before the final drop callback reports the current
> state's protocol.
> 
> If secpath_reset() drops the last state reference while the state is
> concurrently deleted, xfrm_input() can still dereference the freed state
> when selecting transport_finish() or reporting the drop callback protocol.
> 
> Save the state protocol on the stack while the state is still valid,
> and use the already saved address family for transport_finish(). A larval
> XFRM_STATE_ACQ state has no type, so retain nexthdr as its protocol. This
> preserves the existing drop-path fallback while avoiding the post-reset
> state dereferences without adding an extra state reference to every
> received packet.
> 
> Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Patch applied, thanks a lot!
