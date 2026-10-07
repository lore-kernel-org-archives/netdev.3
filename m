Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A1331EB3;
	Wed,  7 Oct 2026 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356090; cv=none; b=cDr/08jqU7g6WQKPM1NtpJbaCXFspxNjw/V1q+K6iZghP+AF1fbMKz2wX875NtZDNN4X7AJlYliMmgB2qCzc1iOnJWE9oZFmLXaDqfcZNHtjwZ605q6MMeFSybHGdu4jWnzULWM+rFebJzES0MNes8Sf2WujQ9ONiorfsuuqa8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356090; c=relaxed/simple;
	bh=Set3kyt3NGr6wdIc4vkbYWiU/oTejxt+HTBAA9PyjQA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFme4ytYs8GkYmreEZxHRoVdQ/fNnOwQeXjjeeB58w6/6AMWs8xWe98zZ7a+cawXUTKTZPCwdW1tpYODCzsWOvpQ3p5+K6cl3s1AAjuFvPKxuD2ZZPVDlheIfGksT989lxkPtB9u+k3ArGGwr0G+M/HWINHkli+pOXwpeYn3oFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=H7BfHDaD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="H7BfHDaD"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 833712083B;
	Wed,  7 Oct 2026 08:54:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TiOHKnZ_-_TI; Wed,  7 Oct 2026 08:54:45 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EEC1020839;
	Wed,  7 Oct 2026 08:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EEC1020839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791356085;
	bh=JJnaSOMtHtuqb4es19bM70PlTRZ/QHFRk+6jKp6Bq8M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=H7BfHDaD7CypmYxSA5GLVZqlKh5sJJfWky+MinRkMk591IF+RfDXz6IRQDrH7WdaS
	 +rZFrdj4UMfMNvrEiNPFDEktdAx0hExzx1cqFBhp3TFffIcADTEv4nEYhRDt5hEakv
	 vtWb2ChfrgEeYHbDIHAi0axpvCMfUKGjD0p3PZ/+85lPAcmFfRbYvZMIiqLLMmkbHr
	 CbrU9IT8YP00IoG92oOghUP1PktoeaPuCJL+lJNI77LOz90ZiqGYKdOJczPwgxeD6F
	 qstirYYEUnH20fucxFTjW61ScLXDhCJzGFn3qkKYci3c1qJbOBiNCgfDbY0rzhvd1+
	 GjMn6JLMxQoFg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:54:43 +0200
Received: (nullmailer pid 3308355 invoked by uid 1000);
	Wed, 07 Oct 2026 06:54:43 -0000
Date: Wed, 7 Oct 2026 08:54:43 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Shubham Antil <shubham@octane.security>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Giovanni Vignone <gio@octane.security>
Subject: Re: [PATCH] xfrm: zero-initialise km_event in replay-notify to stop
 stack disclosure
Message-ID: <asXss4xSHDfrkMFs@secunet.com>
References: <20260930093137.7163-1-shubham@octane.security>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930093137.7163-1-shubham@octane.security>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Sep 30, 2026 at 03:01:37PM +0530, Shubham Antil wrote:
> xfrm_replay_notify(), xfrm_replay_notify_bmp() and
> xfrm_replay_notify_esn() declare a struct km_event on the stack and
> initialise only its .event and .data.aevent fields, leaving .seq and
> .portid uninitialised. build_aevent() copies those two fields into the
> XFRM_MSG_NEWAE netlink message header via
> nlmsg_put(skb, c->portid, c->seq, ...), and the message is multicast to
> the XFRMNLGRP_AEVENTS group, so two dwords of uninitialised kernel stack
> are sent to group listeners on each replay event.
> 
> The request-driven paths set these header fields from the requester
> (xfrm_get_ae() / xfrm_new_ae()); only the kernel-originated replay path
> leaves them uninitialised. Zero-initialise the event so the header
> fields are sent as 0, the correct value for a kernel-originated
> notification.
> 
> Reported-by: Giovanni Vignone <gio@octane.security>
> Assisted-by: LLM
> Signed-off-by: Shubham Antil <shubham@octane.security>

As this is a fix, please add a 'Fixes:' tag.

Thanks!
