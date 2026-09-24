Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA033B71C3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235271; cv=none; b=C+g7WTli6xC1KhC6dLUerKmoPLNNvpRXj5bcPI7R+SwnxpiWxwdbOO7rT2dZ7RxbEc90Juu0EUSn8qMMR6chMmemh/8d2e48xLi4Xb6KpP+F627Zd+PVoFHYnyxes39kyTXqdaf8ubbwMC++lgt4tzwA3ge3ciNjdd3eXigOpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235271; c=relaxed/simple;
	bh=MygDLt77CAWexrvXWHNdRVysOGikwZW7aGyxat4mspo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUn8sXvaHBhs4+6FNbxXWY2Bnh1xcga6w7QueNCw9uIluN3IigWWO5OteJrvJi62bT0v7dW0CIZ4KSJWZhJUukSkgeV1hEV3jENNlHVAqtK0QEB38L0chHtHvyS05JTkDFrWk9GEshRSZGtImgXxSfzEgHq4yqDdWs4JdtGqYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LuS1KZ33; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LuS1KZ33"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hr5F70Rh2z4NB0;
	Thu, 24 Sep 2026 09:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1790235259;
	bh=MygDLt77CAWexrvXWHNdRVysOGikwZW7aGyxat4mspo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LuS1KZ33CklYBOlwsAqs9/QrxI9dSGf8IeCa8Vx/JpgwBH7xzIy8OyQW1wwQYgKw+
	 4orq/C+jHH+X4bgwZoi8dxvn+8b99Bayalo5pK03K5MOzromw/9OZ1548Rc5eMcwUh
	 3iHSMZtrBqAp6KozHPLKJEq/wWIW+RpDdhpfgYyg9ZJr2k7Y8C1TOuCexXP3y89Up1
	 XZBseHFEmdxEYTsZIy8UlwBs1l+g52VYBlyVaJcV2Y5oVz0Jl26gl+ZS0puowDEp8s
	 etPQpFXc3Kg3FZ4Z7OeSQfLGp6ZH7T0DgvrUwC4B5i0VaY04HsIFhENXgaqJ2RbmHO
	 QbTqhmFh5hI2A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hr5F66rPXz7xFf;
	Thu, 24 Sep 2026 09:34:18 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hr5F55zj7z8svW;
	Thu, 24 Sep 2026 09:34:17 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BFD145FA13;
	Thu, 24 Sep 2026 09:34:16 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4f37f217-fb94-4d4b-a2aa-9df8069c62bb@leemhuis.info>
Date: Thu, 24 Sep 2026 09:34:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] e1000e: heavy packet loss on Lenovo ThinkPad P14s
 Gen 5 (I219-LM, Meteor Lake) after K1 re-enable; fixed by disable-k1
To: dima.ruinskiy@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: Javier Herrera <javier.herrera@afronta.com>, vitaly.lifshits@intel.com,
 netdev@vger.kernel.org, regressions@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org
References: 
 <CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179023525718.4133067.16941654907970362532@mxe9fb.netcup.net>
X-NC-CID: cGcaaXxBdAKNLYFFv6hi9U+IhSapvlba8V2FM/uAY+tvOOFUJOE=

On 9/15/26 10:57, Javier Herrera wrote:
> 
> Since commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and
> re-enable K1 on Meteor Lake") the integrated I219-LM in a Lenovo ThinkPad
> P14s Gen 5 (Intel variant, Core Ultra 9 185H) shows constant packet loss
> and erratic latency on the wired link. Wi-Fi and a USB-C RTL8152 adapter on
> the same cable, switch and router are fine, so the network itself is not
> the problem.
> 
> Setting the private flag "disable-k1" fixes it immediately, so this looks
> like another system where the PLL clock gate reconfiguration is not enough
> and the DMI quirk table introduced by that commit should be extended.
> [...]

Dima or e1000e maintainers, could you please submit and upstream a quirk
entry to resolve this regression? Ideally with a stable tag? Javier
afaics provided everything needed for this. Reminder, Linus rule of
thumb wrt to regressions is "generally fix them within a week,
preferably before the next rc.":
https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed

Or is there some reason why the quirk entry is a bad idea here?

Sending this as things looked stalled from here; or was there some
progress to resolve this already which I missed?

Ciao, Thorsten
