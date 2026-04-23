Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FF35966
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905239; cv=none; b=VtqNAa39S4IAnwzK5qErj7Pa2VUYRVrZdy1+HWBnOnKGXBbn9L7Mh4VKjSqXgkDuaNFL8zLvsp+fAEUn1eKoKc6s/Gj0hffb7cLx3+GeLn0ID2Oao6QpfqBfrDSI5gZR6of9TLg9aXAL23JPOMbLUTJ6jWDWm6ttIPl4J+BXEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905239; c=relaxed/simple;
	bh=mjqTjStdH4Ci331vrPkqQG1XjQmLcqba80Y/zzNziYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNMi2fPu3x/NN3oyf9vLMs/Q84OnRWg/ULbBQE7KsZvWwU2RFJx9pQ1jBR/kjNoWCUmqUP7Jvm6Dl0Gp9eZHpVcglWRI0Ct1A3Rs1Qo/bQ+MqFBc5q8SDoKLlJyNAaLisNT5PNV3YPCHOCCjdFWPf+9OSJYa9G8AfWkinCmweHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WZDNCw/+; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WZDNCw/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776905231;
	bh=zFSBpvs47LhGZs+3T3U/fMg222IcLvrRI8ewKb6Aoek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WZDNCw/+DhaqoFoqn11yYOeLmCZcPFdSGK5GQ4L4Sdf5H0snfeCHDhKAO+WaFnqDJ
	 niThDSyskgadoaSeoHH2ajvRWEo31XxWXPvnlx+SZJwj0GXaVfBprMrisY16jsBG+K
	 sTdxg0t1y7asABm7Vj0jD8FsVm0S3S7a4w0gBAdY=
X-QQ-mid: zesmtpgz1t1776905225t576ebbd5
X-QQ-Originating-IP: LwCWARsPpnwh1kZxVyKpfJ6hAe824mOPQoMaIRvdVUk=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Apr 2026 08:47:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18018664094774004843
EX-QQ-RecipientCnt: 13
From: Morduan Zang <zhangdandan@uniontech.com>
To: remi@remlab.net
Cc: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	zhangdandan@uniontech.com,
	zhanjun@uniontech.com
Subject: Re: [PATCH] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
Date: Thu, 23 Apr 2026 08:47:02 +0800
Message-ID: <380EA6DD33CD573D+20260423004702.136366-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2466095.vKB9LnXJlr@basile.remlab.net>
References: <2466095.vKB9LnXJlr@basile.remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MidxaXJBY8ZS6+LwbXiLvKKFoozKhnrOqzX8qOPSvtoeGdPuZIRGh1kd
	ELxlAjbfh84kQB7108LtYuBS2Xhz2q8J2PW7jO8krE7hZGe41FaiGndSM41c+I5gT3o/YPU
	oW3Zebzin9zhjlLTacvP5iBfB3MdfzcgtnvXO4wtaruwC+BQPmQH3s8asPn+Okh57r9/HPO
	5jykY5yfsk0X0uxc5Rb9RDMvSZh0zhCNAjBslkFhjcUmlYf4Z44UvEcBo3NENAVeUgvcoFG
	yN0+A+8AjZl5kaEO2vqcrfB8zKW8m7bSZfCljJVEmcvYmQWiEa1WHH1euP9clPr9ZkBsJrq
	WPBNzDfWF/9Kg1nqz8JweCOhaZ1IJbx2RicrJhgqWlY1Bqbi7Jmrnca6lQSajYmHAxsRZWp
	FdUKvsgl/vjbC9rA9pjA0Eu1NiK1nzeqa2PKWQa8JFYQUfJDhUNsSvK1t/16jjo4ccAwClL
	vncrlJWjrYdfALkODYKipMXfIlLxxn2E1hzLNtMmn5jiXyLpSzLQUNYBeKJITvMERVFg2XH
	MRM50MXgmonqpyccaFTmiGvFC1N6sNMM5/SNDIYZSLR3FR/IiEKncb3pvpxIhoNd5rusSLj
	2yVyi0Ds9motmAaz856q2Ca5U3Z28ybJEJR5Scu3cK1jm4+DVLW/kEdn09NTg2sUF/A757Y
	5yQqxOEL5lfIk9lz45uR3FwR+eR/eNZtkIRaNpQDCSjFFW++1ddX72sZnB1xUDbbb9CzyJ3
	wu2Niu1CPQQam6EsLPRiri3KQym/WG7PcZQVkPMYmJY5P9oqKV5kMx1vCb5O2T97tkB951R
	0cbVif9EgNbGEb9kbh3d4ps8VezjfGrZ0Ng+1EP0LAardRanPTvEwhTpqtQs+m5jiKWWfrY
	s+xYBKGxc3wnSrr3+cBKAUNDJJYUtjXlNolkuP6n4MnMWgupXhuNLNmokupfdosfeJIaGb1
	NdApShmwoWhbJpg4n2JLYEg66BXUlHgsEUJ3gCeNdUB1iecD2qGIP+fAU7xdzIoKExHRfbN
	SEf4RwSF4tah2jJqlVTfcZIq9Rl8VGOGrljZ6+VQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hi Remi,

On Wed, Apr 22, 2026 at 06:18:48PM +0300, Remi Denis-Courmont wrote:
> This could be written as just
> 	if (err != -EINVAL || unlikely(...)) return err;

Thanks, that reads much better.  Folded into v2 and resending now.

Morduan
