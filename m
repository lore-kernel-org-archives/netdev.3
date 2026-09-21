Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBB4C10FE
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006126; cv=none; b=Hh4I6vwaxnLgMcbgclT60Xi7d3ylZz7qCt2NU50i+tzGXpj4t1xUXpDiVVodsgi5tNd1hw5ckeSJI/ffG1rdBhpsqtkHVpaI9oB+8/meaONs0e18D7GOnVKyhza48k18AgvlfInw8gWDzy1NnAFi88HatLSEKqQm4xGtKg942Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006126; c=relaxed/simple;
	bh=BgCPQSrmQQtHki2anFvF7pE0uKcXpANqR//j8kTzGTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWM9AV32qV4gwsGpHMT0TCBLAnT2IE9aUd14Uxl/eOgH8CyNgfJ2SapAkZYBt67dptDluJKUyua3QmCmBtGbbECpWiuN+6ERy3/aJPL5DAjf19KH8lEUyRlhi7lDsHF1c4B3mHZEq89GnRn/42lUPg5Ptu1Y27VN55oHkJBdD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLNtAujJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLNtAujJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso23786755e9.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790006123; x=1790610923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgBrZUCBjhi/EUS+DIxSWIecz4wSV4e9Qc1X5uaxD64=;
        b=fLNtAujJtrxaVPXSsq+YXdgw6z18zA4vI6eNZtGFZRfm4rqve9L/P+748bFTeiYWy9
         0PLhAwRkCQa4BpOUufjHd+ITWPR3wIsEQBNtrTIrYI1TrSdUPqzgFrz+ZKsX6syw9Buo
         2+OqXJOfla38KvWDk7yypH2o9pFLMTCxk+7sCcosoXiOLMvc9qI5Ur9FlHIZprDecoNa
         RbNPNtJ9gwA+Fk/Ot3MDHuGzh8KrrqC5WvI8zjpSi8IWIb2ZcJ465Xn7sL/y+SsfNYvK
         xJ0+BJ0reqf+lkZOR1mCATchE7CjmZFP9xqpswFAXcLEbuzD6LPHh5fzx8BDESUZFg9x
         Wryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006123; x=1790610923;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgBrZUCBjhi/EUS+DIxSWIecz4wSV4e9Qc1X5uaxD64=;
        b=OWuBIffKaOHK66eNHgmH9jEdxgAD8lh5FReCXmwzvAOJYbNB20iusRi2R0I+p42mnF
         NxCDTEm/vyQGsrlyayowyhov3jtjI8pI+bADUWIWPuv5i6y3UBLG7/612IawhJdeYP2n
         UYMCtzv/RhtLtEDwdG1WFJAB1CAOFBJeMEQeNBmhL8OwgsuOoh3cAwjDc552Yciji4xe
         Tpo4LeQ9UetM/8UWZdnYlwDI0FWkAb3HbtIcUpDLJRG8bJm3ZaeJZNM6wPMjAQKysO4y
         cvGOiY88VB6WMFsSt09QZsjwzswpo79Kb4s8eRrytd1elC4KgDIRiFMk1FcGf9UIOLxU
         /fnA==
X-Gm-Message-State: AFuF++lVo0mfuSsEZlABiqKCCPIOnvrGbQfuc3GdQOWs3I2XyXRotLHb
	XMNyQnrT5IUICbbIoUKDlkJHSx+jg/SQHCfEbgSjsSwhljc+2yn59Z9TRSbIpg==
X-Gm-Gg: AYBFou2XmKrCZB4rUOMvON8JU2kvhjfESrTBSS9QGMrKEmCv5vxqpo2d7397IG5hghL
	OUn7tMT/x0bdR5CYX1aOklzJQ3wrHhzoB+q2SyXdAMum2MNw3N1UKJqNgn9+6CpG6gCC2I3E3Kw
	vlrawHCDNGEFOiVzueVGER5WAumfrARqpF/AuEgg+/xAAxBnAaMTH1djwW+/hIAtM3eIKbmPdEa
	5YiUV+Q3i44nwkSPDJFZKQ3flY/KuebEs16hgzqTlqOf+SBABAVhwEK72ReB+MFgEJX/0gh4xGC
	D+t5Yp8QojnM6oQl6en+bXXoh+P2FwRazZ8auHcJB5TJGI5We8aAIG5YJ0bhqRjCgw/2oZ0aP51
	jZUTtBJd4ZMkv89vcTa8z7b8cb6w18CdBHdDXzDgraxUONPaA2yamf3MvSvon+tnWj/hPniLkSE
	4Ne4CBJUXqyWYsP7iHrTJJaa9aUNTBStUJx3kWxO8i1lR82F3rIBV4emTDcft9ZvF4yIFJUWXeo
	yC+toBbw5wC4PMeto2ikL4LrRJTqMR57ckWY1wvTmoA6VCdPAiYXlGhd3iKzajl2r+G9qstVmEz
	nug=
X-Received: by 2002:a05:600c:1908:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-49fc56ad81cmr155896185e9.14.1790006122703;
        Mon, 21 Sep 2026 08:55:22 -0700 (PDT)
Received: from shift.daheim (p200300d5ff3cee0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff3c:ee00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd1f0a061sm176808045e9.12.2026.09.21.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:55:21 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.100)
	(envelope-from <chunkeey@gmail.com>)
	id 1x8gKr-00000002BrX-2Kwu;
	Mon, 21 Sep 2026 17:55:21 +0200
Message-ID: <c557d239-d0e5-4b67-be69-f1c05a913cda@gmail.com>
Date: Mon, 21 Sep 2026 17:55:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: emac: move setting of netops to fix crash
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 davem@davemloft.net
References: <f11843d8416cb3d94b79a7f224bd4af0bf859c1f.1789644724.git.chunkeey@gmail.com>
 <178999551085.2160803.13630958553679103031@kernel.org>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <178999551085.2160803.13630958553679103031@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/26 2:58 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> - [High] In `emac_probe()` (drivers/net/ethernet/ibm/emac/core.c) the
>    relocated Gigabit branch now sets `dev->commac.ops =…
> 
> 
> Would it be enough to hoist only ndev->netdev_ops and ndev->ethtool_ops,
> which is what the netdev_need_ops_lock() check in phy_link_topo_add_phy()
> needs before of_phy_connect(), and leave the commac.ops selection where it
> was, or alternatively set dev->commac.ops = &emac_commac_ops only in the
> non-gige case?
> --
Oh yes. I see, thanks. I'll send a v2.

Cheers,
Christian

--
pw-bot: cr

