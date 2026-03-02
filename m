Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CB38947E;
	Mon,  2 Mar 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443303; cv=none; b=C2NnuZFLiI7GDpwdePJRpDS+T2AKbgHB0A9Ugg4UC8Gw9t/bkiki+CJ8iNPXN98T/0768OpgEKfwphpcDvPdefuZ/HB284siKyLrZ7g83/tkbKmyeRWbma2ytf5BdL8Wkz2WtZS54/Oavgf0/R8q3AL/as3fKJtY4hl4QZZHe8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443303; c=relaxed/simple;
	bh=e3A0TQuxHm2c/J2IERt5Maht65ck+XaZXA/n/HhZtAs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXj0EZlpaz9ATeSrGAIqNLNZwthv8ZAoLRe+Rf4BbXQB5ZvbX+6GbOjhaAQ7SjY1bR3Lh1RgvxR9G9O/JWsfTuWK7aLGksMJfSkjhLpediiC8uy7gBIw8lwng2K50UmDZSBcufi3bMqnn8wxX+UjAhb2Xr0KpbUpswhMygtZip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gGHKl7rH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gGHKl7rH"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6B16220764;
	Mon,  2 Mar 2026 10:21:38 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bCFLX9y5Xmd2; Mon,  2 Mar 2026 10:21:36 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DCFBC20826;
	Mon,  2 Mar 2026 10:21:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DCFBC20826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1772443295;
	bh=0xJXxwMW11i7dE1fhZSGumAw+bc6d/8r1e6qqmyDxH4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=gGHKl7rHYSQTe9nmM+O2tms71Q92Bhj/lrmePgxkQIQhjhExl2bzLu682DNboO1T+
	 QIfTkep979N+SH1TSA2Howyz3/E41R1fL2mxT36ORWw9uouQzM+tQiqJMXrCfisZ23
	 qGEmp/AN7wBZNR2DJUhhusgix/oFuSTzt+0Vnq+QL4p2YgYOZWlIAUXNzO1m55+d4q
	 H+52UYp0PeCvvv3A3HmAPPNBor9p1U27ISKbDhRElw4Z9xzZ+5Kg12qHRxvRG9qh+6
	 auTEKYCVYIoI3ODtOIDgGY8Vr80aHIRQPpn/JkjJxxejy3jeIREgCO0nnC7Cf83D1V
	 V/siaVC1b7u+Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 10:21:35 +0100
Received: (nullmailer pid 2888656 invoked by uid 1000);
	Mon, 02 Mar 2026 09:21:34 -0000
Date: Mon, 2 Mar 2026 10:21:34 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: kexinsun <kexinsun@smail.nju.edu.cn>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<julia.lawall@inria.fr>, <xutong.ma@inria.fr>, <yunbolyu@smu.edu.sg>,
	<ratnadiraw@smu.edu.sg>
Subject: Re: [PATCH] xfrm: update outdated comment
Message-ID: <aaVWnqgk3lRhUYUK@secunet.com>
References: <20260224021821.1502-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260224021821.1502-1-kexinsun@smail.nju.edu.cn>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Feb 24, 2026 at 10:18:21AM +0800, kexinsun wrote:
> The function __xfrm4_bundle_create() was refactored into
> xfrm_bundle_create() (among others) by commit 25ee3286dcbc
> ("xfrm: Merge common code into xfrm_bundle_create"). The
> responsibility for setting dst->obsolete to DST_OBSOLETE_FORCE_CHK
> now lives in xfrm_bundle_create(). Update the comment accordingly.
> 
> Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>

Applied to ipsec-next, thanks!
