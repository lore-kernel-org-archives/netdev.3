Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EF44C661
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963559; cv=none; b=fro+LTKQQmdraP8ee4CirjqYmkGjmpyHwmvW1YiPYXNtqz7ZhD/kXz21UpAYRmANzVzNS29saWguCqAktrz3qh97Av0mV/o4m/murn+9tYi2bv7IPdGFZizIWwefbWOhDt0WfpIQe4347Hsu/WyPA38WLR1GGOzSZ19Crw5iRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963559; c=relaxed/simple;
	bh=tXmjl1dAb/phXW54xGGz5IzlHD8mbsf0iACKL18Lc7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlOY9APN3v5uLuRRf2XpAOi6OYhGO9CWDjNMuXbBK7vz/bQnHU5Dwjk2HY8sOuyzBCb4R0EzC45A++PktDM0Pk6sOkSdxyLhiQm7Pz//v8WYUGMv5Dw/6OpEY03RRPMGTI9uCzW9hbpOabbqKpA4X1yODQqQCMyrm0ShuGHCFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JSrjZFcA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JSrjZFcA"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 088D8201E4;
	Wed, 14 Oct 2026 09:39:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ik0DS_-sErUy; Wed, 14 Oct 2026 09:39:08 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A63AF201C7;
	Wed, 14 Oct 2026 09:39:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A63AF201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791963548;
	bh=cPtlbxQ8lVOc4doU3xbjvuIhhvryDaYUeNBDO5y+W64=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=JSrjZFcAHh889lj6RyjkINCwLX87XLBenKsue7eeS/+GNRFBPBFzXLLwKfgk0NXye
	 4UndccMG6V3VxHHStyju4HHzJn1hZOnjn7rMCKpajOUoONVVj6awgtXPf0iWYdb0lW
	 G2x4G/xKDjQ70+/aarDT15VHVDDupZ7gYiym1c6H6XSVj4z86h+mybm43s+AU3nruY
	 M5zBUuMHWzKQRNZKz527YQN/KFkAsXMLG1lH4VJa5/1v57RM8LS0UaGr10BtMiX26T
	 kaic8QTjTseEysloJ/JoiFaQkaCcA9fDv/SfjEws5LmaKUjT6dv1HqBzk2ujUCNVRN
	 Adpwus2rg4o9A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 14 Oct
 2026 09:39:07 +0200
Received: (nullmailer pid 1275093 invoked by uid 1000);
	Wed, 14 Oct 2026 07:39:06 -0000
Date: Wed, 14 Oct 2026 09:39:06 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec v2] xfrm: espintcp: reorder operations within
 espintcp_init_sk
Message-ID: <as8xmn5QhJfMwo2m@secunet.com>
References: <41fee34088a7ae150f255493b40f54ecbdc300df.1791462408.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <41fee34088a7ae150f255493b40f54ecbdc300df.1791462408.git.sd@queasysnail.net>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Oct 08, 2026 at 02:38:32PM +0200, Sabrina Dubroca wrote:
> When enabled on a socket, espintcp sets the socket callbacks to its
> own before it has finished setting up its context and published it as
> icsk_ulp_data. Any one of those callbacks that gets called before will
> dereference a NULL icsk_ulp_data.
> 
> Fix this by reording the operations, and add memory barriers to ensure
> callers will have a struct espintcp_ctx available. Add a few
> WRITE_ONCE/READ_ONCE too while we're there.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Reported-by: Peihan Liu <ronbogo@outlook.com>
> Reported-by: Yilin Zhu <zylzyl2333@gmail.com>
> Reported-by: Ren Wei <n05ec@lzu.edu.cn>
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> Link: https://lore.kernel.org/all/c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com/
> Link: https://lore.kernel.org/all/20260819155349.3555804-1-jjy600901@snu.ac.kr
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Applied, thanks a lot Sabrina!
