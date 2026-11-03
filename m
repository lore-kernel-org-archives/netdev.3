Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698625;
	b=GxHeer5rbiKK9tonTHgjACOeTOCnfKcuX2Us3mbCdTwmfA7Ds+OgLTHfeDpy3B7lFXSv
	 PxqNDJrEH2dbiOr0tk9nX3AIoDTCfNW4liAow1s8J5zbfkPFaP90mzuS+1e3uRloGoZel
	 jSqPjYDdHf/KyRiCK9QA4nyKmJCXqObskOEP39OQS+rIb5mYrgmJF7IogKRNF3hFMlb1/
	 rHvZJv8ydEUrM9X53RaTMhgbpbg+hejz84HkhOMtIuXJwghCCP+LSfy6mncahvQQipuyb
	 5+XJfGPddBiZ6otJkyjvF7enJBZaxORsXgabsij4ptLIpS2GvGaeDWrwL572p3MvN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698625;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy;
	bh=FjGzHOT/dv0DDaqPW9o1/lHUQ69AWmhJS68h5YzkCFc=;
	b=cd0mbytCA3QU1PnPk3T4sij8iY/COuBoXaa52T0sGjfT1938s9d+ZLn+9spA9L6pjnZy
	 DhxtIam4z/nDCq358YKUj3zQ2tRRIoTvmnp3zOy8h76YATjKTJuBtxeaBG4bnKGA0j4Xp
	 Yk4ftifkD4ck/BqzSgpKd+DPm5OHwlC+dGLLhcebZKeGJ3ZtZaHg6b745sQEY8mxBVY7T
	 oT+1YI5DuxHYCngXjyYgGjMwnXQiA2mkntIjHi5ph+Vn2vzOyNfavokENdMDmUsYFb39L
	 uqUduXU2dBWtdLJ8GTW7+MSqjdkRG08QaNHu08eNByu9pP1AQuDtd93aOrSNRzFlySA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=lHs8QvgB;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83631606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83631606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=lHs8QvgB
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AD10120538;
	Tue,  3 Nov 2026 10:37:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xgURhkt53aW9; Tue,  3 Nov 2026 10:37:02 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 35440201AA;
	Tue,  3 Nov 2026 10:37:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 35440201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793698622;
	bh=FjGzHOT/dv0DDaqPW9o1/lHUQ69AWmhJS68h5YzkCFc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=lHs8QvgBC21XBqn0f+C5b0zw4C9zcO/m5BjylBTh/XzEdctglSxEDIgt8odMYgAeA
	 +Aer9iUITF9/3tYLH6KY86g9AKRIJ5TZrlpKN5J+yp18bKdmBl5m30+nvIhnWjihzD
	 RYG7XQrYCC2JgbKYEiGojYtGKxXPOF4tsS80o4fMftVhYjZBgsiz2gw5zylax1UTzm
	 fPutraxUs58beYpt7iqDMvbKRswikQmTrJv3hU5rgzzrwypHNdftRDTzGf0/sijcX/
	 dvoZ0Q5Vt/Di+X+JHk4XPnSgqgsibzolPRB6a0lGf8uusSf0c9vFVn+gredtExWtyj
	 WdQCD+FQ8XXTw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 3 Nov
 2026 10:37:01 +0100
Received: (nullmailer pid 3728905 invoked by uid 1000);
	Tue, 03 Nov 2026 09:37:01 -0000
Date: Tue, 3 Nov 2026 10:37:01 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Antony Antony <antony.antony@secunet.com>
Subject: Re: [PATCH 07/14] xfrm: policy: reject mark with bits outside its
 mask on add
Message-ID: <aumrPTtDFY2WS3CF@gauss4>
References: <20261102100451.2505200-8-steffen.klassert@secunet.com>
 <179369310395.488856.1196610792291916744@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179369310395.488856.1196610792291916744@kernel.org>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Nov 03, 2026 at 08:05:03AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch makes XFRM_MSG_NEWPOLICY and XFRM_MSG_UPDPOLICY
>   reject input that mainline currently accepts and that works.

That was intentional to avoid adding states that can't be deleted
anymore.
