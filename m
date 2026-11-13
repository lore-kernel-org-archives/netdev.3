Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532377;
	b=f2OeUdaCP3nb2MyhrotDQkGu/8F+8F2AAEWpWzKUfiJSJmKn659IEBhDFLHdgCW4IVpy
	 92CZ4gDf/ihs5MUAPCrGZo/VxFjvrmQRXMliL8fUR8w76ROjXQI1DM3+GgodcmoVAAI1j
	 n7xc7JYFDcfWAt/QMQgQMHciUp1qtJL/MQU7in2OwCzU8p6DNlJRBIjJxC2Bu2WjeGrxq
	 exeelPL59wYgbKvIjJz9BJ+J/zRNp/Lp3EUUUR75CtgMWi+KZGwF1pYcMDDPJygBjvHO5
	 VV8JvKvEvVfwjmebzxYIaBpQ4tprDggJF6NhsmJ2aKLq05bZ+KKSBNwJf0T2OAMAPsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	b=GFCHWPU2GBpJNRc4n0peOGiVMrihDofG1C3gABsktNwI/+wd7uzZ9qOWJY7WR3Ql71CT
	 o2u5ZVJ+mxOY6bRJuaAKscj9mgd/NOucXiRwmgdYHOwrW3NL3l6Iu29MS+w/HKr5fiv+a
	 4yxYLtrDy30SEgV7PDBQostp32K9F3med+7INvCpIEn2DjjyCVRz03FyzkbrGWvTAaGmD
	 ZQiC5ramoPEob65c/qeUcSEu2JBFJnIxLD7H/gOfwpK+0fog93sfQSW5O/VzkNWjz46Bk
	 gp91wLHopqZhriFzq+xz5K0XBTztRKVXvAtEft/9sCXtBg/WQ9oZNrqwxGr1+fzGWOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZYHFhah;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F06606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZYHFhah
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE071F000C4;
	Fri, 13 Nov 2026 01:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532377;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZYHFhahqmElA5MW2pQ6ZQ2qOg+lf/IYVwyL/n5aQ2eWzMT7TAk4ouf7Ae8UIhxuQ
	 QEGndXlwnASTEI2oZaUtLpqaV0JwJbOmuRIymQ79hZWtGrEAmLIJZekM2klU6G/9Hk
	 Uephg7ESa4Onh+knber4yDnnIjiJujkQM8DotLkcJ4yHqIjt5GsjKwsgSiKUmp/LkP
	 ve1Qtj4aXhGwaVXuFENVPJ02AZha19GaR/0kJRy70R57y4eTeaAeVbaQaNHRxaPJti
	 2HFRvE9I+/CMRerPV5TkcUnEghpH6LKTmsLS131JepVhxJFcLF8hi66YYsQSK/HsJm
	 haqC+gSoKk+kQ==
From: netdev-bot+sinfo@kernel.org
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 Ivy Lopez <skunkolee@gmail.com>, dima.ruinskiy@intel.com,
 luoxuanqiang@kylinos.cn, nsvatoslav515@gmail.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Moriya Kadosh <moriyax.kadosh@intel.com>
Subject: Re: [PATCH net 1/3] e1000e: fix incorrect modified flag check in
 e1000_read_nvm_spt()
Date: Fri, 13 Nov 2026 01:12:55 +0000
Message-ID: <179453237593.2168702.4296888375202263590@kernel.org>
In-Reply-To: <20261113005823.130021-2-anthony.l.nguyen@intel.com>
References: <20261113005823.130021-1-anthony.l.nguyen@intel.com>
 <20261113005823.130021-2-anthony.l.nguyen@intel.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
