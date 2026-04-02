Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C731F9A4
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120768; cv=none; b=kZnV0uK3FpszoxWSFGEuhijFw5dq7Z+wH+4rRHius/6GrttnDML6JnQNzV/ez3RqniCe4sbM2MIOxOdhbNGwtfN76Za7CUmeLE9GQt8r/zxWVeRKV4ypGLWKq7BLyF5f2Q5DalkE8nLfMQgU7jtUeYtGMd704DMQreLzXjoSIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120768; c=relaxed/simple;
	bh=Nc7fhhLS5YUR+CO/VR1vbBlId/eSXlrs+lyAwDCOALU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCf9qpgsCYHNGI/jk7JFnYqnFQ++OoVVuhdGHJnLYDRkYQ6UEkF+6e90aExKEC4E3JZjKZ3rMCwuhbakf0ZN1PWA6TbjiQqIFP7HDc6AAJVRZxXJueA4Hrt+QNOwvru98XB17ZsIElq9j6VihY/xtHzV7vqMl+mJ2rCqG3fP/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VqTbZRFE; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VqTbZRFE"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4fmbM13zkhz8DKf;
	Thu,  2 Apr 2026 10:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1775120205;
	bh=Nc7fhhLS5YUR+CO/VR1vbBlId/eSXlrs+lyAwDCOALU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VqTbZRFEYygA9iumgyXVFVTRTHBab236GDx+i/RjMy7r8TlutjBlKo7rEgv8wFiWm
	 tgYjqDXdAuywbKpAEron5OL6NwKWi1wRWhptvlbBTs96CQWF06b9AQ1EA+PdYXgb+Z
	 ZELXSTVnoEHv1vVChVCBq0FYQeAFZd58v0glIQLHCWbR5egnJl70nGABInDlZ+MHzR
	 WSJGRdHFI3dFSQjY5lrJ0Xn+Y1N2BvAwkuHz4kmMqEOIhinODb0ppuwkADY90YvFEl
	 TedjM65CJiOOHD+AkFljunxBXAHHy8gZjALKB1Q6v7Z5jMeyOGti5v8g5oZv/Pf6CG
	 PwkuhW5tIhCwA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4fmbM13H1pz4xNZ;
	Thu,  2 Apr 2026 10:56:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fmbLy4g7kz8tXc;
	Thu,  2 Apr 2026 10:56:42 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id B9DB763618;
	Thu,  2 Apr 2026 10:56:41 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
Date: Thu, 2 Apr 2026 10:56:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
To: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
Cc: "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
 "johannes.berg@intel.com" <johannes.berg@intel.com>,
 Friend <netdev@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: 
 <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177512020201.1134988.17516151596232902051@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: B9DB763618
X-NC-CID: fZLlAXXf+FKoAxYFp4qKaeb9AU+B8xkJpdFCkTbvyXFJMJeOsE4=

On 4/1/26 04:28, He, Guocai (CN) wrote:
> Johannes and Miriam and all:
> 
> when we test on kernel 6.1.166, find a deadlock caused by commit
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=0c4f1c02d27a880b10b58c63f574f13bed4f711d

Does this problem happen with 6.19/7.0-rc6 as well? That is an important
detail to know if this is a general problem (that needs to be fixed in
mainline) or something the backport caused (which mainline developers
might not care about, as that is the domain of the stable team).

Ciao, Thorsten

> test by command "rtcwake -m mem -s 10"
> It will hang (detail please see the attached test.log file )
> 
> I revert this commit and it works.
> 
> #my analysis:
> 
> This creates the following call chain:
> wiphy_suspend()
> cfg80211_leave_all()
> cfg80211_leave() # takes wdev->mtx <- LOCK #1
> __cfg80211_leave()
> cfg80211_stop_p2p_device() # <-  NEW from 0c4f1c02d27a
> ieee80211_stop_p2p_device() # mac80211 callback
> ieee80211_sdata_stop()
> ieee80211_do_stop()
> sdata_lock(sdata) # = mutex_lock(&sdata->wdev.mtx)
>                                    <- LOCK #2, SAME mutex!
>                                         DEADLOCK
> 
> 
> In 6.1.x:
> cfg80211_leave define as:
> 	wdev_lock(wdev);
> 	__cfg80211_leave(rdev, wdev);
> 	wdev_unlock(wdev);
> 
> but upstream, __cfg80211_leave is renamed to cfg80211_leave.
> call cfg80211_leave directly. so have no this issue.
> 
> Do anybody meets this issue too?
> 
> 
> Thanks very much.
> 
> Guocai

