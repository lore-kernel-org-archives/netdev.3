Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDF2F5A0E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985568; cv=none; b=XVaAz7eRtVq5FtwPJs2VLhmGkuH/CVanOIyrKSnVTsTaTgHsZ4XjNWk6R298CABqt09BCOz5kBmolfFCkaEj05ttSpOCp6n5QR3ynVRkHxQav+Mv/SkLJDB6oqJ5Gsu7dHVzcNqpMaX6W8XG7qHKO1RAW8malryq1IO97qWxYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985568; c=relaxed/simple;
	bh=yjqRVGTE3Rc4h5+D+5H9MMaW8vBqfF7YcG8L0eoMOPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLo9DjJYhPOskgcpcyu0VFTgZ2g9ecm2m86Qkld8bcMjhz8HRZ1zdFkY78IgBbXddAGrrTXK/PC3sWVXRfX8Sbw2/MV3PZd0LzFYt7rWJ+uuyRv/Mhew9SLyiac2qAoK1CYn9q/HMclXYgLgvAh9Zz33x4p073kB8IIQOZrROwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OObEkhRP; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OObEkhRP"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 994F9206D2;
	Tue,  9 Jun 2026 08:12:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NxnKJOyoBGsv; Tue,  9 Jun 2026 08:12:40 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C9E8B205E3;
	Tue,  9 Jun 2026 08:12:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C9E8B205E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780985560;
	bh=OEspFufAqgyNylr6UJ3m/gTm+1FTGPzN6/I2IqtRMFg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OObEkhRPyKsJPI/B0I6/2iMR5jCYQBBUQ2Qh1lEI7R6qJrglQeCb9JQfJ/Wc7ocpJ
	 5SweYJvWX3Dlb/DxZuhIXq3HZrcdLOBmp6sXphES4R9DUHg/yUd1LdYTDLF10VL307
	 SzLXcO1J3Yix3jK23kwO2/z2zptN6h1kbsHnQtIG6zHYJTJebf7A1+7JzZyHjhzbar
	 6SXr4t/Sp+wcPuC3/gLAfFFkQdpvnUl87OV+bksSVlE+AsqP9B7UGrrzYApnhuOE7d
	 lN5X7Pmq6q2Q8tzwuHBeepgd4qz6AWfIwMqHyZLpoINEAhCGppO/92qB+E0cePPaAk
	 sGzubTUEQwGug==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 08:12:39 +0200
Received: (nullmailer pid 891721 invoked by uid 1000);
	Tue, 09 Jun 2026 06:12:38 -0000
Date: Tue, 9 Jun 2026 08:12:38 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <n05ec@lzu.edu.cn>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <sd@queasysnail.net>, <yuantan098@gmail.com>,
	<yifanwucs@gmail.com>, <tomapufckgml@gmail.com>, <zcliangcn@gmail.com>,
	<bird@lzu.edu.cn>, <bronzed_45_vested@icloud.com>
Subject: Re: [PATCH ipsec v2 1/1] xfrm: espintcp: do not reuse an in-progress
 partial send
Message-ID: <aieu1s7D1NsMLTEL@secunet.com>
References: <f45b23780569de7e83d695bf5c439815d4ea4e21.1780377940.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f45b23780569de7e83d695bf5c439815d4ea4e21.1780377940.git.bronzed_45_vested@icloud.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Jun 03, 2026 at 12:46:27AM +0800, Ren Wei wrote:
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
> 
> espintcp keeps a single in-flight transmit in ctx->partial.
> Before building a new sk_msg, espintcp_sendmsg() first tries to flush
> that state through espintcp_push_msgs().
> 
> For blocking callers, espintcp_push_msgs() may return success even when
> the previous partial send is still pending. espintcp_sendmsg() would
> then reinitialize emsg->skmsg and reuse ctx->partial while the old
> transfer still owns that state.
> 
> Do not rebuild the send message when ctx->partial is still in progress.
> If espintcp_push_msgs() returns with emsg->len still set, fail the new
> send instead of overwriting the live partial state.
> 
> This is a memory-safety fix: reusing the live partial-send state can
> leave a stale offset attached to a new sk_msg and lead to an out-of-
> bounds read in the send path.
> 
> tcp_sendmsg_locked() already handles waiting for send buffer memory, so
> the fix here is just to preserve espintcp's one-message-at-a-time
> transmit state.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Patch appied, thanks a lot!
