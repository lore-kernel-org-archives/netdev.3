Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D53537FF
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795636; cv=none; b=QPT+GHvorqC7mhKwHf80NABwHLH+o0zzzsaxoGECsyd9SqvSXhJGqXpxTfnpYrSn6Sk0nH/FuVngV+RLFc4qD+Pu6CZMQmNM2q4grpfficFWQZ2TnDPX9zgSTIJ9Qd3iy2NsZzVV6JAJzgazr15t5Nt1dhGVJdaauefBBKcVs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795636; c=relaxed/simple;
	bh=8GQrmu2eTCD5eCD6iX6Votrn3u0utXOmGZPXtLEigkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDdN0n/KVjTl0FJUjGNpUAmocl1ib3VpOYeAqNaK7J/Y/YaHzsfGweVvfPr698fQsO53guebhnSxlgpGi+756QspTws75Ln8JtiKJW8kXcyzn6O5ggI0C2b2EKv5PBtWXp3BQVuJSMOyZMN3+53M4JfWKr7IUUHOGnLnmtOFLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QtXqBqH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nn4eqpKL; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QtXqBqH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nn4eqpKL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 65B491D000F1
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:00:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 Oct 2026 05:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1791795632; x=
	1791882032; bh=lT5XSeL1PlZooH8BMH08iMBNCGh+Be3Nit7pw06NqB4=; b=Q
	tXqBqH8+fI8VcsRQAba5HGFqLlQjyVtzgtDCev08XgbWx6cCbnxY7nJdC8dPZ1ds
	ocREgurPc5qlnhuY55HVgAuMHFY5GsZLbRQfa1doxC4yqAQouIbE6tgLRbKzIuTe
	od1+cG3rT3Ds7G9s/wdk2rHnuJQ7y3JtGWUrKk1WrZmzQ6Zur5TsHBaJK2Cqgnqt
	8xdAYZG4eP0MgOe0dz07/YbAMBoLAJQ4n8hN1Z2/tdSY6jHW6SvHXOyLkWbv0WzB
	v5/a/5KPr8kVi8yGJrYcMqoubv3xOQ4yBR+o3s8LpkH3SfBzAJ660H2zmO7IK8ZT
	wahlpb/9uGYAjY4XQSFkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791795632; x=1791882032; bh=lT5XSeL1PlZooH8BMH08iMBNCGh+Be3Nit7
	pw06NqB4=; b=Nn4eqpKL+pbNob7eR/ajF+9/SM/8bNrGjwA8qFr0RHxRLxjA1n/
	1gUviC7ZGGIoyolpT9UPCtQbRt0BuoQ43oJMATSaYrSlT5kEcFP4J3gQK9tOygC9
	S66/6WsOHDEY03DBe+kAaoalS2rlNPkuNdoGMfkjENulYyzxjU5cQw6W4kPOeNRk
	adUDx8Q3YSRedejq8fcQal5DdFd16/u+I5r6K5B3M40VciDeZ2xsenUHGIiCbdYZ
	LlKoLrElLHss804HOhcFNX5/yegbWB0wCthGk1kj5YrdLUoIVaAsFNSezSA60epV
	sjSmUMlbhleCXOtMQVxI5twrDWaaM5l7OGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791795632; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:CAxZmLpPVsGaIdvoBDRvkzHLPIsZl06fMtU68F+/kvnoqYJ
	mkeDMaCuQ2HgcM82UjCIABGZSdfBHfLxz/hT0WRLYcnhoKzDY8jpMNY9rsAHSNQb
	ZGKXEwj3mHvljF7U9pJoM1FjfnMTPUQ7vQhmwemHWkAtgppeslZooLUCcBjrG8iZ
	iu2rabfEjK6356Bx1N8ymh0AMxijyBuNrrL2GX+PFUlE7oobr3rZwhdkbe9QcqEl
	uPeGDwH+NhN+VkyWdUICenZazCK6mJW42ns0kD5K/b9WklJARIpkp4m2L7Z0jWOd
	OpSriIwfOcPT8IxlbDJAcz8mWzaVGWChlk9KBJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dVaiifttCVGL0cTbYX8PpUBzDubxwOg/bw2YUx2+jrk=:8GQrmu2eTCD5eCD6iX6Votrn3u0utXOmGZPXtLEigkE=;
X-ME-Sender: <xms:r6HMaqGXSZsbcfPbxM7vBR6L5At4OAPBtTNOLkIMphhNBjrGPbqNyg>
    <xme:r6HMalVT5Re1bj0CTNn8cTX_JDDI7iFu8FW9rdrGS50mclYaL4Blypo-qc0a7nB9Z
    QHf9jc4UnhItZzYePlzukzeOrCVgtnUm_ieAuwWEffvcx1NVUJXW6Oz>
X-ME-Received: <xmr:r6HMaqxnHeZ6_OLG2MlbYqq2TclCyHFdWn69lJPudBSK9nob5BMkCgsn-Q8>
X-ME-Proxy-Cause: dmFkZTERHKo1BpUPkS+OGP2SrFA5cXbF26ZAAsoBCmIsTmEu6NUYR1VSV0g6S4G6d9SlaV
    lc3Im23bzrNqOLcWrMMcr226bS9LToydvqQ75AujU4WN6DYozPWbR/B3gdY2scDACtS1sk
    PQvoL3+FiSIo91/Ch4rj9shWFSUCsLIG/l0xGWfpEdJaNJDs1oWCvObNLjLzTy/KS6njOg
    J9yS5MwxUKS40xT2zt28UaSTUEt0i2gGGaPEvoG0uJ4cdo5fhP2TPtyeHERnVuz/jHC4gq
    XK1D8EZHdcS65+WyFbvlltuHiXMCzzw5EtHgmV5Jltnwwm2VN3LYTym6eyJeXWqDuNSzNT
    /kfO9I87GUMgqGvwJ8i1czU6oNp19ueWA7IjHCVLFOrYMHiu4xCW79QeL7IrE3CVwUukLR
    bb1wFt8rrorIkFcxp86NdCuwyZ5z3uEDv3WuxRecdb0mooBP1OBgkksixt/kD44sLgVe0s
    BabKHnNGNRWXKLQ+g5dD6EN+uiNWpPhIT4M1i24UVeE4LJlc+bKT4m3oIiNQKPWmFlkvT7
    u7z+Y8tSM+uH/IU2rC0XkDzE6tWz9l3TUUIsMq4iwUzrFeD5Ik3MOWkgoockW8ypvEAEDQ
    zXoU/Cnz4IFPKx4Q/H6koXtYhU6Bws6rbnCPAhh08LH2bol3XHbExLg/DPIQ
X-ME-Proxy: <xmx:r6HMaiSq8QDzNYHqzR0YFhgI1-KYzksp2NQIyU1nrDUIG3IACzQLLg>
    <xmx:r6HMaugZtRnstBaa8O5U94NIcQry8nVbqr7XHuRTx1VMVl4RnFVIvQ>
    <xmx:r6HMahlY9uvQpVuIYXhE77VXiB844sDro8vRqU_VmXUixVjNS4RxjQ>
    <xmx:r6HMapvNMzdG0N0K-U20TQsL1F5L31wtxhHgxE8SC6cYX2jtaJ6SZw>
    <xmx:sKHMakIrleakyn2KsiNgTltiFMOfh-NDPY5YgOdh-9A08uo9enwdfrlw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 05:00:30 -0400 (EDT)
Date: Mon, 12 Oct 2026 11:00:29 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Haseeb Malik via B4 Relay <devnull+haseebulhaq55.gmail.com@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] macsec: check for duplicate SCIs before
 registering the device
Message-ID: <asyhrW6tEeMvEQdi@krikkit>
References: <20261011-macsec-early-sci-check-2b1f06af193f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261011-macsec-early-sci-check-2b1f06af193f@gmail.com>

2026-10-11, 21:57:11 +0000, Haseeb Malik via B4 Relay wrote:
> From: Haseeb Malik <haseebulhaq55@gmail.com>
> 
> macsec_newlink() registers and links the device before rejecting a
> duplicate SCI. Registration can emit link notifications for a device
> whose creation ultimately fails with -EBUSY.
> 
> The SCI is already resolved before SecY initialization, so check for a
> duplicate there and return -EBUSY directly. Remove the now-unused unlink
> label while preserving cleanup for failures after registration.
> 
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Link: https://lore.kernel.org/netdev/ar2KmwhtCMbOKLsG@krikkit/
> Assisted-by: LLM
> Signed-off-by: Haseeb Malik <haseebulhaq55@gmail.com>
> ---
> Tested on arm64 in virtme with KASAN and lockdep: all 15 MACsec selftests
> and 80 offload/cleanup cycles pass. Rejected-device link notifications
> observed by the diagnostic drop from two to zero.

Thanks.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Sashiko is probably going to complain again about the mdo_add_secy
cleanup problem it caught in
https://lore.kernel.org/all/178951752525.22033.8547704610100726932@kernel.org/

If you have the time and interest to look at this, it would be
nice. If not, no worries, I'll take care of it later.

-- 
Sabrina
