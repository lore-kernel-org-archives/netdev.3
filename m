Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1E44DB6D
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305455; cv=none; b=SnMxMYIlBnLunUaOAby6gXHtOUCgtlYyJ3JggWfTdEzQBYkk0Ds+vMkh6P/nTswuFAueayreyTsYkipgImDRbybvApURqWlPYPIUZ07G+1XKP+Q+0OWTe7G5PUGjZRtwCY7okjcf5OIDPBtS86XfWDt5er0QpEgY9nxKdvvOF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305455; c=relaxed/simple;
	bh=UIYeLFA3Rh0AHsap3har2JOjjB8p5Qgmwzdh7XXzoaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJa82DbVoPpwMGqfMThJSY5SMOaSW41Hu0GNE2AwSj/Qwiln4UWuIi45FtiN5YcsDz0Gct0LsSBf3Mjrgv23151kyueG8SKu8plSV46QTOblzOhvyoIATuJxinI/9OJQp2p02uf4XzpHg7H2wbEwvcaT3xEQjBFNsVmhy7txtaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MT3qG6Cj; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MT3qG6Cj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787305443; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=UIYeLFA3Rh0AHsap3har2JOjjB8p5Qgmwzdh7XXzoaE=;
	b=MT3qG6CjIa/mjqissJKhVCEt6jcZEm8guIqhCS+1lCFq3QNJuRFn147w2VMCAfG4sGP144rkk23DJ11oQqIuSbefUmT8xywMUpB8xcZ6y5vnQYZGmLLaEiJ1rzaZldIjj6jBsIML3aaBThRsz+wGW743husbcCb4wcNtE8hQlkc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X9LzmZm_1787305442;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9LzmZm_1787305442 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 17:44:03 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: horms@kernel.org
Cc: xeb@mail.ru, netdev@vger.kernel.org, running910@gmail.com
Subject: Re: [PATCH] pptp: reject payloads shorter than the PPP protocol field
Date: Fri, 21 Aug 2026 17:42:33 +0800
Message-ID: <178730535313.476144.475903977991245292@linux.alibaba.com>
In-Reply-To: <20260821090713.GE265046@horms.kernel.org>
References: <20260818162143.gn-j15t2twSq3EK4tluniorb9JMdD9cS6_NWtWioiRc@z>
 <20260821090713.GE265046@horms.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Simon,

thanks for the review. Your concern is valid: payload_len is only a
lower bound since the skb is never trimmed to headersize + payload_len,
so bounding the new checks by the peer-advertised value instead of the
bytes actually present (skb->len - headersize) would indeed change the
receive behaviour for a peer that under-reports payload_len, as you
described.

Given that, and that this duplicates the earlier pptp patch from
Zhixing Chen which carries the same concern, I am withdrawing this
patch rather than posting a v2.

Sorry for the noise.

Chuyf26
