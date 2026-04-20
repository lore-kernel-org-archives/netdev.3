Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6703876C0;
	Mon, 20 Apr 2026 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672875; cv=none; b=MUvdre/gpAAWSLZlYF4LfHD/5rqjNCoUbyU9vRmR3bvpxGhwBFntYAC1kmaWCStPVKh4uocPHwSNcbxnE+oHLupp57woKtDZiyJy9nWYjVOd5qQet8vhv87tfU9G/lBNiOtLuTyYyyc40khSBIcG6Ddn5wTiAQxwCJIjAkbhD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672875; c=relaxed/simple;
	bh=Sv83K/Ryrmzulm9brumEpwXAOUjC02md5peR3zyQU1Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pMcfuayXflLRosqg8VMO2aSYugTycsAqaoJ1VQ6b4yJIAmbpS8gSJE+vjfzal9egdJT2o+CWfIraN/8plxHSPYE6P4+HAvaUGbK870q/XaPyXtkUQtpvniYqk5Je22m3H0cI6onf5IT5VnxiReG/9uBrmiVFIama0laivH9VADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WvnYgycS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPqBEWla; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WvnYgycS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPqBEWla"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB96A1400074;
	Mon, 20 Apr 2026 04:14:32 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 20 Apr 2026 04:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776672872;
	 x=1776759272; bh=aPJEIrQen864YDv1MGyH5g83G2kcjKMSTtyhwJANOdY=; b=
	WvnYgycSta+9DZfNsQsijzt7BOGYIiobvk0v6S7xzGM7o9jWvC+AFsyntJ6uQF8n
	wuLCMUeoqOvo/pGspr3EdWX9kwfgWtxYKrvMRmUHYaXmFzO51QHCrmimn11SEtYN
	Gc79rurUvJqBJdGbDB706HHvCvfXFYHe58tyUft1y/50bMzHAgzAyij/n+Mxzx9N
	cfdCM9LfKExFyk6yMuz1EbbZASJRx71YLZRZdEc/PpK3kPzRqfV10rLR37qScpFz
	ialgnznA79ldjuzGjOr7RSjo7i8CiZquzZPDv7wmJNTaM+ypfJ2BuX9bMjDnCPOH
	xzUdIigvB+Jz+IHvW4ZQDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776672872; x=
	1776759272; bh=aPJEIrQen864YDv1MGyH5g83G2kcjKMSTtyhwJANOdY=; b=H
	PqBEWlazUA2llTO8/oFwfkQH6zOLKqReT4IUqAiYYikyXagJ0D1rlUzCm2QId9u3
	6KmbnKhAtnR4Jp0B7E88Sy1Vzwzpwk+ym9QWgoztASIHXlWpdd8w83W921Sqsuut
	xPTn7xuY38id0T5j+f0hId2ni3FEHD5fr78CA+KoSmaFDSVn0Mgbwx4i567m4gjw
	10ze/gfbNNiEeW2Z9myTmcCWn7b9EoZVmqdaxKBZm/gbrgLBLcg3/9Mt7h26ERVy
	Kr4onfTyPZAgBScc5lKz3b2j5Di5/EqCV8A9xTCeAigIbA7vxMriA8JE0jtOlb4U
	rd8JZgMj/n1S7exCefHAQ==
X-ME-Sender: <xms:aODlaXGLEUuI02P1STMBcZ4jwc3ImpQOhXgQBswqUUC4_RBZE4OEYQ>
    <xme:aODlafK4eh9GA1QNuSw4lvDUlCA63pc-8qIZ2B2w_PuwisPtS-UDQQrJIc--dYEJs
    zin9pwbkYZOsJn3J8D-xM76tlSgQtIYEDQtPBi4jt3fJctZf2kr4P4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepgihirghoghhurghitdelledvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehthhhorhhsthgvnhdrsghluhhmsehlihhnuhigrdguvghvpdhrtghpthht
    ohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsjhhurhdrsghrrg
    hnuggvlhgrnhgusehsthgvrhhitghsshhonhdrtghomh
X-ME-Proxy: <xmx:aODlafDTDsFQd8OM0iaLY92I070f6UXh10sahZhTlPPqLRGudjqmIw>
    <xmx:aODlab5bZFn7uo3LRvzuceRklsDiIKZkeQ-VQie6GGg2TQCeJmdwXA>
    <xmx:aODlaW3lPw63uKk8v6g3VizOc5lM5cBjlNoSQdVlocuP_mGddxVNbg>
    <xmx:aODlafk8PuVMJTcqnTJ6i2LT9PL_iCgWPtRz_Wbf4JEpNCyR9ufAuA>
    <xmx:aODlaW-yRaPp5TYtToyKFAlPfnzw5mIYmC4OEp8q4AKBPDoaPsvobMaF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 85B72700069; Mon, 20 Apr 2026 04:14:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzSL-Zt2U7rV
Date: Mon, 20 Apr 2026 10:14:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kangzheng Gu" <xiaoguai0992@gmail.com>, "Simon Horman" <horms@kernel.org>
Cc: "Paolo Abeni" <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Kees Cook" <kees@kernel.org>, "Thorsten Blum" <thorsten.blum@linux.dev>,
 sjur.brandeland@stericsson.com, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <85ec14af-bdd5-45ea-8c06-ebd769499bd1@app.fastmail.com>
In-Reply-To: 
 <CAKvcANPEa91paujTQjpW2hZhpXEhwfOjjy6CsN=OJ32iXYXdTA@mail.gmail.com>
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com>
 <20260412135743.GK469338@kernel.org>
 <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com>
 <20260414112951.GD469338@kernel.org>
 <CAKvcANPEa91paujTQjpW2hZhpXEhwfOjjy6CsN=OJ32iXYXdTA@mail.gmail.com>
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Apr 20, 2026, at 10:09, Kangzheng Gu wrote:
> Thanks for all of your advice, I am preparing a new version of patch now.

If you are actively using CAIF, please chime in at

https://lore.kernel.org/all/20260416182829.1440262-1-kuba@kernel.org/

If you are not actually using CAIF, maybe wait a little bit before
spending more time on it because the patches may no longer
apply if it gets removed due to lack of users.

     Arnd
