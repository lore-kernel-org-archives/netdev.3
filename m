Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353877;
	b=uwFs209KZG+u5LPrlixRliyqbrTUybyeGkDH5hhWWb+EWb33WtvLDrVENmLa8eNfJgPO
	 J9MCAnSiYFJguxu4NVaRD67M5Om2sgSmnNLT5QzVYbFrzQdt+cAT1In0U1n+zr8t0+LMT
	 bAasFZNKgFYJ0q2yL5d2vyE9DwNzJ26Ev8/wVA937jwYX1Nom+0mgrCu+bcCEkC6Haf2l
	 GGsJB7MbDQnN/oF3aabpubs6ZxanlUTj5D2c2A1A5SDb6tYrOXegWimySU3npmLYOyeQQ
	 e4SohjVgAeLIXP7zuVuRkwloonmemJ3Q2Sqiv2Qe4JBjJTXLmuZSms8L9RtuJk6cyKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353877;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=Pc05rPVx8BUnwZN6Esfs/3POdwyr4e457JoVhP2uVHo=;
	b=SMn2Nxd57vya1Fee+wgf/nflyjAw9UqBxtSkIHJ4V8TXe9WbPh+r9ZVIqomPldAgp42Q
	 cxXGH9C+Fy3Zn+PhFBcQDIKmNl37coNvWOYF3bNOzxbfTz4cK4Sef68FAjmAS2229X+zN
	 KcWlN1UchDZBQmSCnhGxNWmIG742ATxgDMUD0e8K/HqEWkazGap9+FaZkdds0giNivDmr
	 tYwyvnB2dThZjh0I0uKomxxlivbiPcjsnMr5hwmjLRzPojhWXLUNA8OIKVBBDp95tF/je
	 a1htXilUwsIMHEmi4t0TyF5d96XkvB9FIu8LwBNVxjk7tw76sOvuEfBNrkRuwfX85Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="x/ieRjDT";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE58606A320
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE58606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x/ieRjDT
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 494501A1398;
	Fri, 30 Oct 2026 09:51:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C25B603C2;
	Fri, 30 Oct 2026 09:51:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5485D103287DA;
	Fri, 30 Oct 2026 10:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793353873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pc05rPVx8BUnwZN6Esfs/3POdwyr4e457JoVhP2uVHo=;
	b=x/ieRjDTB/siPI1w1YtydrICOdZux15f16W7k7Gh1k1ZcH1N0eaSyZvsog5fPMrXRBMEzW
	WhhGVlBVeNorl1LqQfUncEujshyeShl8yzGGtRk2CWDhBrtGhwFwzNjj0Lt9Ftj22P8irG
	gGV9donnbH+JD8hU7c3LrjrbugEgps9BY/Ufq8YyAFHcMA7XLy/ohCJbVZS/JomRgR9pKo
	Ie53dbEqaGsbCx7jMEq/qc4nJKVbKoOWcbNnWbkBnjJtFjfMJlBWjl9rboTGLpMJh6FLI+
	fl7BnBpLdJ63wgLKhrJkLRYO+xKIio0nQpuQDhvxiMQVX9ryuQLFIc2YM4yBtA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@kernel.org,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  zihanx@nebusec.ai,  stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: use pinned interface for beacon
 transmission
In-Reply-To: <179335297474.14852.9229658182764909973@stu.pku.edu.cn> (Yifan
	Zhang's message of "Fri, 30 Oct 2026 17:36:14 +0800")
References: <179335297474.14852.9229658182764909973@stu.pku.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 30 Oct 2026 10:51:07 +0100
Message-ID: <875wyjectw.fsf@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Yifan,

On 30/10/2026 at 17:36:14 +08, Yifan Zhang <yfzhang23@stu.pku.edu.cn> wrote:

>>From 1e3faf146431b4c28bdf0923fa54754c1f8d8902 Mon Sep 17 00:00:00 2001
> From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> Date: Wed, 28 Oct 2026 17:18:59 +0800
> Subject: [PATCH net] mac802154: use pinned interface for beacon
> transmission

These lines should be in the header, they appear in the body. Something
is wrong with the contribution. You can use a tool such as b4 to help
you with this setup.

> mac802154_beacon_worker() looks up beacon_req under RCU and takes a
> reference on the selected interface's netdev before dropping the RCU read
> lock. It then passes the selected wpan_dev to
> mac802154_transmit_beacon().
>
> mac802154_transmit_beacon() ignores that argument when choosing sdata and
> reads local->beacon_req again. If the beacon request switches to another
> interface between the two reads, the worker pins the old interface while
> the transmit path uses the new one. Removing the new interface can then
> free its netdev before ieee802154_mlme_tx_locked() dereferences it,
> causing a KASAN use-after-free.
>
> Derive sdata from the wpan_dev already selected and pinned by the worker.
> This also removes the redundant RCU lookup.
>
> The reproducer hit the use-after-free on two separate v7.3 KASAN boots
> before this change and completed without a KASAN report in three runs
> afterward.
>
> Fixes: 5f26a690e8ef ("mac802154: fix netdev use-after-free in beacon work=
er")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> ---

With the commit fixed,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
