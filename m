Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C53009CB;
	Sun, 27 Sep 2026 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548224; cv=none; b=B16H7SHO1EjeZLfkRPpDSk0JGt7xKMti6fX2ueEOmj6NQY+mk7tqX28P/aTfxM0yXXKBE8xntp99MG9RZXBwYXwpHL7Lqj1rZ5RBxllIR1f5ZdwjErNjbXZQ3pancN8xb+PUiuouVauWAwxCB6N9QsJB0J/ylXXWkvB6iTehxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548224; c=relaxed/simple;
	bh=kDcOmst1QB1GDmfnhBuMLNQ8/tHcgA6+af3aHGg9NJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZftBXtddA+4cUQchkIJLxR62ZDADetnM14VrDN+Phe9h2A8c8ET/6zwi/FlfacawIZL1Tc/qZQryVuQBXiTkAMK2ASgtP6nqNzleiVTeOuiRZs5O2+szdsQEzWjZ8TUvV07ejbaBP+XwvyDebl9PFDJ048VwHBsPR+IyTTw73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RasLFjY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RasLFjY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C401F000FF;
	Sun, 27 Sep 2026 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790548222;
	bh=FzmEujC8nWC0Ixq78nyENTqf5HHAu1Xrj8Twqk5+TEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RasLFjY2IKwrccADHkDrqOF6Yd40pxfinlbj/og9IWz4tMl6SJby7sq//Y6EktL2J
	 LlTJupNyOon1+ebiKd9VjZ9qVs/xizqk6aNgPODfNbHk5nbrglihZD4Jy5H+IaGEc7
	 Q82vcK5nsKdhQMSUz392GuEQ35wxrNK1wJ8UwuEDUDxMfQua83u9IeY61L+lejsTam
	 /W/QDPv7r4d2OmBTiq9Jh/SvDwL3XQEeI4JbQx5LRPQ9C1qI8syoXiuYquDQVbOynT
	 A4npSi6TM3yRn2JH1eB1HCNGEsqnwCk7AZ07uiewD94aPUgxgtXR2IhHVP1p8mVehi
	 RGuuQkhJ97GQg==
Date: Sun, 27 Sep 2026 15:30:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>, Frank Li
 <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Jian Shen
 <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>, Niklas
 =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@ragnatech.se>, Paul Barker
 <paul@pbarker.dev>, Byungho An <bh74.an@samsung.com>, Russell King
 <linux@armlinux.org.uk>, Nicolas Ferre <nicolas.ferre@microchip.com>, Soren
 Brinkmann <soren.brinkmann@xilinx.com>, Fabio Estevam
 <fabio.estevam@freescale.com>, Arnd Bergmann <arnd@arndb.de>, Zhangfei Gao
 <zhangfei.gao@linaro.org>, dingtianhong <dingtianhong@huawei.com>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Dongpo Li
 <lidongpo@hisilicon.com>, Mitsuhiro Kimura
 <mitsuhiro.kimura.kc@renesas.com>, Sergei Shtylyov
 <sergei.shtylyov@cogentembedded.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Vipul Pandya
 <vipul.pandya@samsung.com>, Girish K S <ks.giri@samsung.com>, Siva Reddy
 <siva.kallam@samsung.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/7] net: ethernet: release managed IRQs before
 freeing netdevs
Message-ID: <20260927153020.5311dba6@kernel.org>
In-Reply-To: <20260927144741.1320558-1-yaojiale02@163.com>
References: <20260927144741.1320558-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 22:47:33 +0800 Jiale Yao wrote:
> Several Ethernet platform drivers request interrupts with
> devm_request_irq() but allocate and free their netdevs manually.
> Device-managed resources are released only after the driver's remove
> callback returns, so these callbacks free the IRQ data while the interrupt
> handlers can still be invoked. A late or shared interrupt in this window
> can dereference freed memory.

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.
