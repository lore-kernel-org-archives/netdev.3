Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285B3E929C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427599; cv=none; b=DwHiORNA2CjZSf7e7TIYfz9tAuzvKJGtZMiYTQMaBOxKEiyGFsjzKpQKiFdfiU2YkjmocE91em1+cyTqRvBp3MU5OQHuToLS7HKUFmHLMEG0KIWaeVVRC+drWbIEDLNoSZyzTzczPNJKequp+22ong6j3FzQGAnNjeXnek5V/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427599; c=relaxed/simple;
	bh=5W4ArnJ86wA+s53i49IW1Ss6cZ7Vs8PEMrypqQMgHeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sr+iyluWOB5nefgMMeaD+p3FHLualOw54K3t+1Pd+V+m/w0+R8dX3ZcZDf0xG8fEpY3z8hf7zY7t89ZJmkk/Ctkzf3dnT+EuKLtH8ULO/SmM1CSPAbyG1h1LCFHvJIkRjFl5UyuUl+MzxvgvUQ6o1u60srf/gKSoxG+Is/2JFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sOcqjool; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sOcqjool"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788427590; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=5W4ArnJ86wA+s53i49IW1Ss6cZ7Vs8PEMrypqQMgHeI=;
	b=sOcqjoolXhtNRqP4ADWAAqMIVOzmFD6bHN+tIqpWt0FBsYUw/08m7G351ppgUsqD5cSWXXfpcDRAZ58jNEtOI5fhAmmA/5oveFVuKAEphd4qyB/H3BRqokXBUr2Lf/za8cnkRXTNLK8zTfFvZD8Ag15v3TXciuWeEGs0z6uGst8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0XAFZIge_1788427589;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0XAFZIge_1788427589 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 17:26:29 +0800
From: Yifei Chu <Chuyf26@linux.alibaba.com>
To: horms@kernel.org
Cc: xeb@mail.ru, netdev@vger.kernel.org
Subject: Re: [PATCH] pptp: reject payloads shorter than the PPP protocol field
Date: Thu, 03 Sep 2026 17:24:30 +0800
Message-ID: <178842747087.1044540.6008885003196112246@linux.alibaba.com>
In-Reply-To: <20260821092618.GF265046@horms.kernel.org>
References: <20260818162143.gn-j15t2twSq3EK4tluniorb9JMdD9cS6_NWtWioiRc@z>
 <20260821092618.GF265046@horms.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Simon,

you are right. I double-checked the arithmetic: when len == 1,
pskb_may_pull(skb, 1 + len) only guarantees 2 bytes, so p[1] is read
one byte past the validated area, but the pre-existing
len < p[1] + 2 check rejects the frame for every possible value of
that byte, and the len < 2 clause only hides the read behind
short-circuit evaluation. There is no control-flow change, so this is
hardening at best rather than a fix, and given the read stays inside
the skb allocation I am withdrawing this patch instead of resubmitting
it for net-next without a Fixes tag.

The point in finding 2 about the p[1] / p[2] mismatch is valid, but
as there is no memory-safety consequence I do not plan to pursue it
here either.

The pptp patch from the same series is addressed in a separate reply.

Yifei Chu
