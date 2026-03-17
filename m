Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F628314E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716903; cv=none; b=fLEj04bAUnZi0+6atZni1eBerHv3KEpT3Eeq4sVIooyR1SXqGlLkpJ3QVI8IKkdxIlywaLMXzQQzSklVpzSSUxABE1QMCzSdRETBoIe3CmPJhorxKWOfotw+qizXg9rc+AeNY09ShfdOFJyUQrCE1s5hFZwsbXDrGPWGz57WfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716903; c=relaxed/simple;
	bh=6VXcukEtq/Iisyi37qrAU7OE6MMDc4qqZXQM9ieuxCw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=U9C9tIJYAmpShh3aw0wYivawXikZ3xGn2Rufm8VEpTQGO189QleiI2KAURAdGrRwQw+Z7TzPI/4sxMnNO2KkyOaxzhA0/VzEpgPBtGtTm0G6EDlgXhlAS2RV83O5nsrZl1nvl2+gkQLlTc0tJe390dm6iVm6fXUg09E23OznFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EH2SRL+R; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EH2SRL+R"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773716897; h=Message-ID:Subject:Date:From:To;
	bh=6VXcukEtq/Iisyi37qrAU7OE6MMDc4qqZXQM9ieuxCw=;
	b=EH2SRL+RbIAg89kW6leDtIZxMw0TEkgmS63Wn2yS4TTyyIhuydb1M4cU/rjVdljssmTADpXmJW3uT3eMu8ateAcwleDn4/cFjKoK2O/LpnXLjaJ48qehvV6zo4QZsH5dFOsQguFvgsgy2e5LcNv7hyob6cbA6SCbbwgancnFewo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X.9SLQN_1773716896;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.9SLQN_1773716896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 11:08:17 +0800
Message-ID: <1773716496.6578078-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v33 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Tue, 17 Mar 2026 11:01:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S.  Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo  Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust  Li <dust.li@linux.alibaba.com>
References: <20260317015257.79494-1-xuanzhuo@linux.alibaba.com>
 <20260316195252.7fa24729@kernel.org>
In-Reply-To: <20260316195252.7fa24729@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 16 Mar 2026 19:52:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 17 Mar 2026 09:52:49 +0800 Xuan Zhuo wrote:
> > Add a driver framework for EEA that will be available in the future.
> >
> > This driver is currently quite minimal, implementing only fundamental
> > core functionalities. Key features include: I/O queue management via
> > adminq, basic PCI-layer operations, and essential RX/TX data
> > communication capabilities. It also supports the creation,
> > initialization, and management of network devices (netdev). Furthermore,
> > the ring structures for both I/O queues and adminq have been abstracted
> > into a simple, unified, and reusable library implementation,
> > facilitating future extension and maintenance.
>
> 4 minutes too early, v32 was 56 past the hour.
>
> Jokes aside, can't you got your own LLM subscription? The mailing list
> is not a public CI. Please do not post this driver more than twice
> a week.

Actually, I've been using LLMs for local review since v27 (or possibly v28).
However, different models tend to produce inconsistent feedback. Since Claude is
not accessible in my region, I'm using Qwen. This results in a clean local check,
but minor issues still arise after submission. Since v28, the issues have
been trivial-for instance, this time it was some incorrect references in
the comments.

I'm not entirely sure what specific criteria need to be met for acceptance, but
we are hoping to finalize this work as soon as possible. We have significant
follow-up work planned, including qstats, RSS, and XDP...

Thanks
