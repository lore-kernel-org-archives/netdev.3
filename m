Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950066;
	b=28NfUsepYqBF+LNybqiiwr8TnsTAtrmLwMpeKwPcMNrIkQ1ajWHtmtJr2H90CeIVTflt
	 CL6FJC4t3/o8WMTVS67BAJqA0hlG2ZPfVeDICPSjR2JLgbkdHq9TTsJzlXSq3n1cwLA3s
	 E1WNrebH98KSEsjthuxP5x01ER5dzef1XU8RVeeyaMRq5ayCg1sj1jdc93VSrMYuJxSum
	 WCY3bQ2L6nk7n9zeyKQy2UHl1QpVjEywh0HBXV9MnHq1PxmKX3J8t0V6dH/gIKXqCq5o2
	 7uXkv3A3yORPDeCKnZRJDZJrzG10x2Ef4X3OVhrjjO9+pbxTxwUgxqEkXmGAg/L1NwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=zB51csUn3+jXkaINxILRF8MBk/g+5oHekQQzrkY/CYjd53F4UKTTnKKb9RSjlBK6zw6o
	 MIki3fApP5EnbuAa74u53DuRdtsUPbPX8VmV/iChE+OSwLVHc3Vt7YboysBt3dCcWsiGy
	 5Ff3go1Lb4l5W9Q9OS7l+6XK4YIO3f+Xo0Ch9LsHU1ueBDbuzhx3I8rr34sf9Uy4gf14f
	 X/KbA5tXEmKa7LcsNS1Ho+iYzoTaxdS/qlPdcKBnBMncDXCSxRYvGe/5SNJ1s2Bf8s+8h
	 exYPXvGS0F7xDAPgUd+9lcXgf7efUdEFH2bq/t9JDe1V6MEtGEycYeve/SH5jHIndjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKNhEjMR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53047606A328;
	Fri,  6 Nov 2026 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKNhEjMR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC61F008A1;
	Fri,  6 Nov 2026 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793950066;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gKNhEjMR74cIFZOUA1+Ep9r3zugd2rYr3x7LAOhmt/iSSRTB1rheh65+EY25Thmdt
	 INZRkytec0ymzJUuQzDfNSp3uEuqQhhBLBGcbBguorgyTfEg5k2B3gwX6FlEwHUMfY
	 nufGX9aZECuMDIfagOMnVKh/GiIlrgfmZ8L3Lj7HeVWZ5f3INVHqVoabSbLKDLNSDv
	 TxZnTIYt5SL9G9Z0zdFEtT3MIKNInMAc7fl6MA4XKiz/IKS5s8i673bdlwbc+9XhAY
	 GeJWW10isTvnTepbZtY3PusFfEOpOz/hnXO9qBOkuIuWc6ffZs/yKCBmpXO2Lv6HUr
	 lmqtBIQulCPJw==
From: netdev-bot+sinfo@kernel.org
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Ciprian Regus <ciprian.regus@analog.com>, linux-kernel@vger.kernel.org,
 yana06070@163.com
Subject: Re: [PATCH net-next] net: ethernet: adi: adin1110: Fix phy_device
 leak in probe_netdevs()
Date: Fri, 06 Nov 2026 07:27:45 +0000
Message-ID: <179395006518.488859.7603845397469844366@kernel.org>
In-Reply-To: <1793949783000.333861.5224091507677300156@cmss.chinamobile.com>
References: <1793949783000.333861.5224091507677300156@cmss.chinamobile.com>
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

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
