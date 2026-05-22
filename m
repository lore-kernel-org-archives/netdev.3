Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDA27E045
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434093; cv=none; b=UFppyC1bepeTz15LsckD3dMbHWJx6dmtxBpDTGrbKVLYr5k+AMu2Ipe5EABDSgDB0bN4FzSh9sm1ptEaIsYcdFWI0Q4Y0oayImNkzwR27qKAeLNGKVaaKlnc6Tw7rBj2F2/THJFy9GiIaDgvvj6vAprCGi4uoORnday/DAXTSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434093; c=relaxed/simple;
	bh=CO4Ggy5gZgXcsBerYEDw5pCHEvls3FOCmSM34rQrW6I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODQishX58d6NsQtRjquVlXmA+US9oEYJ2fus2AxM2ZM3/Hc5vV+TENhTrTZS7co5glooIghIbEuWjIb+K+AnleBY9bYARAAsmEAEQjLGCDcNamBwe5+Sj00DyvWtcN2yK+f2XdDPWZYbgaHE66uPEe0denrbhXswv/NQjmz865U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=B5PScOIG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="B5PScOIG"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0B7CF20754;
	Fri, 22 May 2026 09:14:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hrcbkQxQGkQD; Fri, 22 May 2026 09:14:48 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8A22920844;
	Fri, 22 May 2026 09:14:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8A22920844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779434088;
	bh=bC4uXPkRNWNNk2VKP3hs3pOuekz8gbPy58f9l4lsKf0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=B5PScOIGNewsZd2u5PTi31l8J2jE2Zmt3DrZwsUS5tRQyg0rvCZ4uAmitkghUBZrx
	 9lCT9eezyZc+IpCLiVS7HT/3J5xrp4BnogE1kB6StQoxKDsC85MO7ziCRMzhG09VfF
	 ES96dhtE2ABmtj6TnL74y4CtiHOSzYgIMJFeu4Xrgn5JwLJfVbYo77O973SqfRP269
	 CIlTI33H/qdBbunJoAotsGllzvVk4NPdN+YhL75TGymcjwbEae49U3CsePfadR5qeE
	 unZNbueWwF5p2I8ef/P1Mkdw1I4x/ZtN/pGYVBzRuaJsEphW1X+jKzLDG/ArTCuDhm
	 fP49/C0/MzjFQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 09:14:48 +0200
Received: (nullmailer pid 3616769 invoked by uid 1000);
	Fri, 22 May 2026 07:14:47 -0000
Date: Fri, 22 May 2026 09:14:47 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Takao Sato <takaosato1997@gmail.com>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: iptfs: preserve shared-frag marker in
 iptfs_consume_frags()
Message-ID: <ahACZ9vjB8SXeqqk@secunet.com>
References: <CA+Dks+FXQju7ih8BMYAdOu+qhzGm2tr4A0qEr1PUcsoJt7A4JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+Dks+FXQju7ih8BMYAdOu+qhzGm2tr4A0qEr1PUcsoJt7A4JA@mail.gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, May 21, 2026 at 08:34:43PM +0900, Takao Sato wrote:
> Hi
> 
> Thank you for the review. Please find v3 attached

Please send patches inline, not as an attachment and review

Documentation/process/submitting-patches.rst

on how to submitt patches.
