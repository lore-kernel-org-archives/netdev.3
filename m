Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241EF1A9F87;
	Fri, 10 Apr 2026 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797744; cv=none; b=aX9ER6mYozSHq2J7Fyr6mhdp9fzrmnUAtV78asZDJJnMsy1DwMomiF7PXfsCTWUjI46ajtsZBAuUc/DzvbGImy5SBpAPKrvnmdTZKKphXYYjKrv0vAqi7d88FPz5Rcy/OYeszw9bqdqNDTccOadjiuv9YuOzpBuk+TU+pJ0xY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797744; c=relaxed/simple;
	bh=w1GSQUdk+ohCeNmshfJJ//72ky+g9gEaS/K7kEdQ6tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMwd7pQRdGLGsZ5TQXB2vjiA6DtaLAwKfGVHUTmpE0uelOUUtTyCWEujwuB5mbqabtIfl2egiJt6qO+FcAWziFy+CSY1Xj8wBKcOPogDBUK2S0KO01hLHdB8bKV4g0EV1EOlVn8s0ghnktmdJn8aBFhnu0tnVyGb3CeHcWlI4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sSy+XtwU; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sSy+XtwU"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fsPwV6hsNz9ybx;
	Fri, 10 Apr 2026 07:08:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775797739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqZBQf8u48iamiCPb8jz8sKBQZqMz55AUf8Elg3OBk8=;
	b=sSy+XtwUmKM/ozpOtvtViZLYCNw+k0DWM1XUWtcNptYC19LrllIcVVqy/27WY6VIHzSTHB
	APGHjtoZSv+cpiISy6wDJHHlYB+59HLmIR+y774FT3csM5ou1nCHOIELSB1B75abe9mJi0
	ZYTXZC5SVASTH7PqXo74NRcxaY3jK5KMeNlnYQE6k8xkEaRWa7YORkHanRro2bqggZao9S
	jbAphdZRcrYdOx/3AieiLUkf5jv0vWKj1rANtGfrmXChKc5kwngm5klMb832+2xOoL+a/u
	kbeXUeKHC/uI4c1FeGJPQmYlVAtpgrwcLolSIdZl3ZT9wE+9ySmZkRVa0WMiiQ==
Message-ID: <2a5c79ab-423d-4900-a81f-e1e568962dad@mailbox.org>
Date: Fri, 10 Apr 2026 13:08:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net: rose: defer rose_neigh cleanup to workqueue
 to fix UAF
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com
References: <20260405125830.89251-1-mashiro.chen@mailbox.org>
 <20260406170125.175258-1-mashiro.chen@mailbox.org>
 <20260409194957.5465e98b@kernel.org>
Content-Language: en-US
From: Mashiro Chen <mashiro.chen@mailbox.org>
In-Reply-To: <20260409194957.5465e98b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j1dks63mkhowiy6dr9d37ocht8o7o4bg
X-MBO-RS-ID: 3187a8e572b2cbf6a5f

On Tue, 7 Apr 2026 Jakub Kicinski wrote:
 > What if ROSE is built as a module and gets unloaded?
 > Please don't post the next version until next week

Got it, I will not post any patches until next week.

I've never thought about the module unload path, this is
the point I missed in my previous patch. I will deep analysis
if the timers are properly stopped before the module is
removed. I will address this in v4 next week.

Sorry for low quality and  simple analysis without auditing.

73s,
Mashiro Chen

On 4/10/26 10:49, Jakub Kicinski wrote:
> On Tue,  7 Apr 2026 01:01:25 +0800 Mashiro Chen wrote:
>> rose_neigh_put() frees the rose_neigh object when the reference count
>> reaches zero, but does not stop the t0timer and ftimer beforehand.
>> If a timer has been scheduled and fires after the object is freed,
>> the callback will access already-freed memory, leading to a
>> use-after-free.
> What if ROSE is built as a module and gets unloaded?
>
> Please don't post the next version until next week, we're drowning in
> these AI generated patches.
