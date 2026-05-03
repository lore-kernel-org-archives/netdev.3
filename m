Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BE175A7B
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798436; cv=none; b=OusHLByZPE88yD/1+rvvlNSTnbRe2KRPrd2vJhjWPxORQxqptmyhyqUlwJNcdsTSsvWvT3jM+fpDs4PdTB0MldkVwwCD6dHzxviVtjkfHCjOxOXB/mEO9AsTOg1ITignIOV61QwA0dSzKUcpexHM1Xh91dImm3BFJZIP8mwe1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798436; c=relaxed/simple;
	bh=yAgBGauhItVyr5yyb1nDYByVFoSZhHduED1fEoG570g=;
	h=From:To:Cc:Subject:In-reply-to:Date:Message-ID:MIME-Version:
	 Content-Type; b=No8wg5EOk9ldjNJMNKdKu1r8Ary98BGjb5Uigcr411y6ceMpVlkHDLQrlnWnchVeVaJcz76Po3aC4mzNLiLlKcc+BtaAyOdkYhvtcyYm8NsK52HEVObGaqHumvZwEMrDklZ5vRXKzkMEk/klL0udlLyWzXwrNSb+M9TDPHGO+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZUGLidhi; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZUGLidhi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777798431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=yAgBGauhItVyr5yyb1nDYByVFoSZhHduED1fEoG570g=;
	b=ZUGLidhijoJB69R8DH0HYnyFbQWMYPdpUXmJdWD8thkB428vt6ZEtg4soJzSO1TPW88Xnf
	+jh8HcHm5PpCQ8UcJbnLttsJ8ZJxwOF5/3Q9uQBL0+YvvSohIgASq88VS9uBYEplJiHKEG
	AXACJv1FNkjqqklcFerPYCHhpVYEI20=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, tr0jan@lzu.edu.cn,
 wangjiexun2025@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions
 during teardown
In-reply-to: <14078459.uLZWGnKmhe@sven-desktop>
Date: Sun, 03 May 2026 08:53:29 +0000
Message-ID: <7ia41pfslvqu.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Sashiko's author here:
Embargo as a feature was requested by Jakub to prevent people from
posting 10 versions of patch per day. Currently all netdev patches are
embargoed for 24h.

Re writing feedback for reviews: sashiko support sending reviews over
the email. It's an opt-in on per-mailing list basis.

Some details here:
https://github.com/sashiko-dev/sashiko/blob/main/MAINTAINERS_GUIDE.md

Thanks
