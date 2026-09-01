Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630E33263B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267890; cv=none; b=GXXDsMiOfj5g8wGoc9YmX/MTVrHZdoPTD+TkUdRgrot8MZdwujt1kWKYZ1KzzX6rllRDioPu1amJkPOZwn9kCCXAft+aZ01s4yLIY17/KBKE/L2C6Rg01A21J2/MqUjcb084/x71ddw72/a714qT4JwRE3JuDRNtZcrVfMXSWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267890; c=relaxed/simple;
	bh=A4mU+ZrAkvQl8NVxFJ/4s/Y7PH4gaV/BiB2sBBPkW9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDnbJxNN1G+jw3JanpDjHH0TtjGmeVCQ6ZgJKtcsgH/tFVd08/5H2t9fAHlBr1Bq5F+nio/0BlM7lnGs93KjM4y2FH7Lae5NQe2xwwRRy+laspVslkBTVmLla/UyeHuO4p6t+6S2EwqWnAkXeZy9iL29dpNdTckPfEpneh5mECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AhEOjRMr; arc=none smtp.client-ip=95.215.58.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AhEOjRMr"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A4mU+ZrAkvQl8NVxFJ/4s/Y7PH4gaV/BiB2sBBPkW9g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788267887; v=1; x=1788872687;
 b=AhEOjRMr3LAlbcwEzW1DgSZwtZSWioNhfaochcQtq9YQ3u3oJrC5zuHYokCR9j+G6D5uovP/
 4FW8OG8EImZu1MVv/OzZva+FuceL5PNKZPB796elgLqLuYiRxT/zou2M7I3T+6iUkTHbLsEpbez
 Q6irqQYeHKBdge9UUxgZfehw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 46f1897b22d68139;
	Tue, 01 Sep 2026 13:04:47 +0000
X-Mizu-Trace-ID: 46f1897b22d68139
X-Migadu-Flow: FLOW_OUT
Message-ID: <4a664246-eaf9-47ad-98a0-10a0fccce572@linux.dev>
Date: Tue, 1 Sep 2026 21:04:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] octeon_ep: remove redundant memset in
 octep_setup_pfvf_mbox()
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260901110913.977745-1-ekffu200098@gmail.com>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260901110913.977745-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/1 19:09, Sang-Heon Jeon 写道:
> vzalloc() returns zeroed memory, so the memset after the allocation is
> redundant.
>
> No functional change.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn> Thanks,
Xuanqiang

> ---
>   drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> index 0867fab61b19..e4175d5bdb3b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> @@ -274,7 +274,6 @@ int octep_setup_pfvf_mbox(struct octep_device *oct)
>   		if (!oct->mbox[ring])
>   			goto free_mbox;
>   
> -		memset(oct->mbox[ring], 0, sizeof(struct octep_mbox));
>   		memset(&oct->vf_info[i], 0, sizeof(struct octep_pfvf_info));
>   		mutex_init(&oct->mbox[ring]->lock);
>   		INIT_WORK(&oct->mbox[ring]->wk.work, octep_pfvf_mbox_work);
