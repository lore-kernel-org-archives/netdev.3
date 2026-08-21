Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA439DBDB
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305434; cv=none; b=oRamIhr6xInlc6SvaQ7EQl2O/zZ5PLvciYN2ZE7xzMT1eONLbwUbJfeRAUsTkqSi7G/ejhZVq+5lRzp4D8WlV1ytJq4Btwpt3dYRvSQQKgrskqJVMRk2jSFEeZ2ujZPBVWJSBmJrVHP+w8WO14hVXiuNKHpLHQYguE3cNwehRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305434; c=relaxed/simple;
	bh=aDkfHaQnUx+u6tOWJkwto0jjaDrFKtIIxAA4ZunJrfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qw/INHNCeLxkAaD1lzSBCyO5m+TI2m3xtNODieaaTOGgc/CUsB5afzR5xdoK0eL48HLnPzePSKN/uKrYvviCJsxOcrNR9jTMnK81YMAdeu4yQ0HoM+prVbspA5Y2BtaW5N+E0EpZcSktF5BgLGPhwDsHOCbsJ7fEKJ5iWliZnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GqdVUjaS; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GqdVUjaS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787305423; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=aDkfHaQnUx+u6tOWJkwto0jjaDrFKtIIxAA4ZunJrfI=;
	b=GqdVUjaSji9237z2MBALfcNmsokFF2N/u2hvkLN0jxMapOpdqcabCpUzBtYP73rCyDQoRrCmYYXgUVZ+aVzLwy7hYYmN/+8sGpewvG9PA1tJNcEzt9xwzJy1zPAj0SwdovvgEDy8UYxETyANr2di4altdPDoB9dsGAFuwUuadf8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X9Lvg8P_1787305422;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9Lvg8P_1787305422 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 17:43:43 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: horms@kernel.org
Cc: xeb@mail.ru, netdev@vger.kernel.org
Subject: Re: [PATCH] pptp: reject payloads shorter than the PPP protocol field
Date: Fri, 21 Aug 2026 17:42:08 +0800
Message-ID: <178730532802.474692.15922523828621281026@linux.alibaba.com>
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

Chuyf26
