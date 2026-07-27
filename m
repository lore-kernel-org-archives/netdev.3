Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BC3DDB08;
	Mon, 27 Jul 2026 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137465; cv=none; b=ukJ+wcOSBHsO4w5bKxdfIsiI4AYck+5mSa4lp7G1+2GoS5Fy4jvXdh6/aqNK28KaJ6TagZcGRsxdLlI29bN/FcicJhPkXjfP4NjX0j981w2GF5VgdKrjE+Hhkl59ghANlfWRzNF1rauBmjYn5/Lzh2HlqPf76lxJMIROQ+DKaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137465; c=relaxed/simple;
	bh=Q+SH3rtqApItwsxpRAcOgnivnvLj0btVm9NjjawpMXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp0nFSkV4C1n1Pps6uftd3buaOZphyJ7d6n0jYC0GQlWjTIDO5yQgk1hcGo16MaO2MlhfZ5Bm/O7mt0rrbCr0UCt0vM6meIBmVjOYq12v0VUAgl8qswk2Ry+fNM7kse2Qd82QKcFnv1upl6t+rqyqhLUhp2P2sOvTxc/AU71KhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jNKZICpe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jNKZICpe"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6EAF8206B0;
	Mon, 27 Jul 2026 09:31:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NCxz-kugAqCp; Mon, 27 Jul 2026 09:31:00 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E8AB0201E4;
	Mon, 27 Jul 2026 09:30:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E8AB0201E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785137459;
	bh=AWLD7JMZez/iGZx93ZXfOtRfiUZNAyBMQcIFj//E40U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=jNKZICpetOAlwstIkzqDAdnxEYhTRkMIPSTxHUxUOUyYmGL3N6dCGT876VdrUIJqZ
	 JIkcIuW+/4BIxPQl+gniEM99rdVKkjshqgAgaeTRw8+B5R4c0Q29S4NZzrcBhmw2If
	 aWSicISYVYmP+X6AS7iHUD6fltk2tx0H6qAZVtzoCF3bm/3rmMs0xNJ54htFCjdOi/
	 5sqM4adwrq8QyA7cIOZ55UeOTKWjZYgGzq/eOGcNwkZVXjMpZ3tCABzx5IJvAbGOUZ
	 NilApRfUziUvwkOYqkIb0u795+YsBWgOuzopmDSprhau2lnoEYLIzd6YyMPyks/TNt
	 92W+35NxBZiKA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Jul
 2026 09:30:59 +0200
Received: (nullmailer pid 3824405 invoked by uid 1000);
	Mon, 27 Jul 2026 07:30:58 -0000
Date: Mon, 27 Jul 2026 09:30:58 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, Alexandre Cassen
	<acassen@corp.free.fr>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: Fix skb double-free in xfrm_dev_direct_output()
Message-ID: <amcJMm5nRdSLz6-z@secunet.com>
References: <20260722072837.2011916-2-sanghyun.park.cnu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722072837.2011916-2-sanghyun.park.cnu@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Jul 22, 2026 at 04:28:38PM +0900, Sanghyun Park wrote:
> A return value other than 1 from local_out() means that the skb has been
> consumed or its ownership was transferred. xfrm_dev_direct_output()
> nevertheless frees the skb on this path, causing a double-free when
> netfilter drops the packet and invalidating any other owner.
> 
> Return the local_out() result directly, matching the ownership handling
> in xfrm_output_resume().
> 
> Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>

Applied, thanks a lot!
