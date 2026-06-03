Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A5304976
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502707; cv=none; b=GWjbbA0sGJ+l86Obi8xAD9yUBX/bxTk9DIvRFh3bLnYewJnEkskfxdlKB2YWrunqg+uQVDEaYCCEcdNwAyGE3ue+hu0PrErh3AHJyUXxGvS0FCbDS9bwBqbxng/7GWDq0boeWIzmCInrlBg0mnFVzWmR6A6SbMvSurpUqoG29Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502707; c=relaxed/simple;
	bh=JNOHnc1OQ2S9Oh4gIkTpWhNDDRw65TOsYC+3imQewl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQlU4XX0FzFwNuQhGEqjgy9SoV8Q1pVs5C+MRTmGyDZ8xLejFIaPm57S0VYR6FRAY33jvVCe6V/v/IDnxsIfgPYVz3OS3qA6+nOOpVaUwr0sMsKU9N08QYsMjTcLeZZWJdn5WJGjmJXGNkFmURU9vKUCtzysvPwwtPhym/fMSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TEt91cxb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TEt91cxb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AFDAF4E40115;
	Wed,  3 Jun 2026 16:05:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 825755FA0A;
	Wed,  3 Jun 2026 16:05:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE15C10888CC6;
	Wed,  3 Jun 2026 18:05:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780502703; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JNOHnc1OQ2S9Oh4gIkTpWhNDDRw65TOsYC+3imQewl0=;
	b=TEt91cxbTD3F3Dn/lZ8+0gQwqaZpadXmeCtwg0M2c6IvMJ/SvpXAIqTVPPMWtBju0XW5Pp
	zqrGv8oOdFrBBNWU39uujWQ2K5xZqhGdsz/19F6lA6oXnHZiDtLk45b7EuMO1iw/E1Mn5N
	/z/RtBtkPTlx0E5CaJLJwInqnTjvK1x3lKLxKQ5BXtqXWuRmBPQr6XLQV2B1Sjf2ZPARR9
	k7IDjzAmaTc/veC/D3oQYL5PdN9NBGiGsySwMkLF/ZP4KP/lo/lpvcn23nNfj0LyQVgQsB
	xRhCPnDjfCOEeFGabaVXsMoI9auGYvpaCK0ka9VfHZX7wWkT8gphVbKTWI8eaw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  netdev@vger.kernel.org,  eric.dumazet@gmail.com,
  syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH net] ieee802154: 6lowpan: only accept IPv6 packets in
 lowpan_xmit()
In-Reply-To: <CANn89iKObcLouP=nE1RvZmq1qWywkTrA9x=O871-7_FKiWsFyQ@mail.gmail.com>
	(Eric Dumazet's message of "Wed, 3 Jun 2026 08:57:51 -0700")
References: <20260603072955.4032221-1-edumazet@google.com>
	<87h5njzkyy.fsf@bootlin.com>
	<CANn89iKObcLouP=nE1RvZmq1qWywkTrA9x=O871-7_FKiWsFyQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Jun 2026 18:04:59 +0200
Message-ID: <87tsrjy5hw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

> Hey Miqu=C3=A8l,
>
> Yes, this is only for when the interface is configured as 6lowpan,
> which implies IPv6 traffic.
>
> If it's configured differently (e.g., for AOE), then it shouldn't be
> using the 6lowpan xmit path.

Ok, perfect then, thanks for the fix!

Miqu=C3=A8l
