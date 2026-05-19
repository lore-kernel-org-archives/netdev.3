Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C13F0AB3;
	Tue, 19 May 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183247; cv=none; b=FBPnt2JtM56R/9/abXhKtxkRK+hGJbFLdkttuB1Xm5zn6waIfENGEXMuVmKWmYtY7Mnhdxs2CP7pArGynbx0E03eijHASZiBvjbgL/7vXIQOWex3Iaucg0LhOtHYKcH9HjkujRdVr5Dauzf/gdpddLsJxZp5vTGBScVK/KlFinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183247; c=relaxed/simple;
	bh=9JHcOzht1n0wfKVTJuq0d8Jgtu8JOvyjFJ+NPArVa08=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DxKEhHZQ/MVTY1BiUSEdYZ9mPvZWQ4bjojlLR5TKORaIUey6o6SI+9V5djCyvQ/sx+BGRx8QE8mlAqYtMXSRDrQbMzlqXVk8JyRFtv2NH6zAGTQVP0Pqun7EcpbIlYRpC7R1nsykWen4RhzDtEoyVEBHml8Md/KYTQLkebUp7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=H6ugWpLk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iajCMxdo; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="H6ugWpLk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iajCMxdo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B06C1D00085;
	Tue, 19 May 2026 05:34:04 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 05:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779183244;
	 x=1779269644; bh=9JHcOzht1n0wfKVTJuq0d8Jgtu8JOvyjFJ+NPArVa08=; b=
	H6ugWpLkIoztUOAw5JR9QLk/qk0eaMhQXCerZiNCkSj3wN01YD7oY9FNCVVwscUr
	4ijhDnk159vWVC5/e/267qUhtuLg+UQti6zEPes7sp2nGznW70nZQDsM24GBQhNb
	2WnHasYB0+cbtkLYQet/weSrI7/USmg0zjCCe2Mql9sXZAYsF5antFkWQXkr8LVi
	6hG+AtLtMcyRskKtBPSHQn27Sdh7Z3nRu0t8bRpN5njc47UOOn/wnYs9LoqxRSoj
	KcP8t2zRuIuGvKOI8/mjgpq+jnTy5sjeboMCAJJFRPAJLoKYPJ24Hp12ZTcZYPB1
	qvM1yY+TMnobA28ufQ8nwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779183244; x=
	1779269644; bh=9JHcOzht1n0wfKVTJuq0d8Jgtu8JOvyjFJ+NPArVa08=; b=i
	ajCMxdoNsH80/XVkJb9mNk0HqA7ElDQPG1/RTRs7gBtpDF7eLCKhh/eL2Do6JvWV
	FRUfvz0whPX1ZkOWPYgs0OtG4Z1OimguwWJvWHMwbz6urtTzHbmMzL4CbB4Gd+hp
	Bs8mRAjR8j2zpfL/XEJnDyzdj8xTv9VEldnWmyn71TUQcZkx/KCdSiihTWc5fg4O
	BK13jEF0Of1ZRh6j31fpR0znrgR3B6CZGi8VNOmNt9q43Q1DqzxmutXWLDwGfgEX
	b3Y0VtbqEwJKSWWnAXVM06ZJ1p3XeM+Xk5+GDElmUvzQZHp1TA4KZixgUXkT+3h3
	zqBVyz1yTgtdOjzk/419w==
X-ME-Sender: <xms:iy4Mag96X3tWADTpDEn3fRj7yZHuGGLUuunythREV9QMb8t_Qc7Xhg>
    <xme:iy4MajhGs7ItTnl3w7HaoxtobLvI6Yjoh_ljHL-Zk6nphPGFfS2CTtCl_Ic2Dr3dQ
    Ix66cN_Ww0Nj28j9k2NAykTU7CR9XN0UyZBdQIaiPQOQ5WrXsb-7kW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrd
    gthhdprhgtphhtthhopehlsghulhifrghhnhesrhgvughhrghtrdgtohhmpdhrtghpthht
    oheplhhukhgrshdrsghulhifrghhnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepph
    grsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqjhgrnhhi
    thhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iy4MajgDqaCwXHQDOMiFnKzafgJ_4IzATzLcSP5w_dEqFiS9UjpXlA>
    <xmx:iy4MaoO_7IrKQUAJnU_giCvYjEFzT_JqO32UvvYn60nweflHSirG3w>
    <xmx:iy4Maur-G4v0MnTSC0bT48E94Hkznv0WD4qs_APPpeXLLTIbFlk6hA>
    <xmx:iy4Maq5LIrDbYMJPqCdz5Vc1mpNtu3GUoNs7nqGlNq-TMpW2i2tWXA>
    <xmx:jC4Mah_O-0wsYoZWF9D9V9os8vDHDjRa_WhPLB1yU92dASr6Efxk1U_k>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CFFCE182007A; Tue, 19 May 2026 05:34:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACgEviAZ6E4Z
Date: Tue, 19 May 2026 11:33:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lukas Bulwahn" <lbulwahn@redhat.com>, "Jakub Kicinski" <kuba@kernel.org>,
 Netdev <netdev@vger.kernel.org>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Lukas Bulwahn" <lukas.bulwahn@redhat.com>
Message-Id: <a55cbd57-b81c-424e-af61-53a3e7caf3c1@app.fastmail.com>
In-Reply-To: <20260519091646.302458-1-lukas.bulwahn@redhat.com>
References: <20260519091646.302458-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in NETWORKING DRIVERS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 19, 2026, at 11:16, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 5e138e0ec32b ("w5100: remove MMIO support") removes
> include/linux/platform_data/wiznet.h, but misses to remove the file entry
> in NETWORKING DRIVERS referring to that file.
>
> Remove the obsolete file entry in NETWORKING DRIVERS.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Thanks for the fixup!

Acked-by: Arnd Bergmann <arnd@arndb.de>
