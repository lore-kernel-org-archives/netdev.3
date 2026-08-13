Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2049503F;
	Thu, 13 Aug 2026 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638735; cv=none; b=e/xynovrpvcRv9GwWezVbROG2DOpRZFp3qKKjFeH/4PCUZdMC53gYUmfmdlWVJSvmKyw7e4Mb7JvuwHKU4T2Z1F4PL6UJoRTymueWroK1Uflem0eGsJjFJDwJWmqAfUwcmkk5vOdvguRP+OnDiGzYnKEuD1KgelGDBZsGjYfMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638735; c=relaxed/simple;
	bh=CTkqjLHeGvQBnnLHc5YZ7V+/yg9UN7vh6Nu4jRMQRe0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nVwSKzkW9aJKyssgbSUsbdjFqvHxktvjnLUY3ZgHUAxQroyXYaXbk+X/foOMjwpHC96O24MiMGriU3dM8Ry3vNosFwU9acFDup0t0cXtFgzwg+yzNohMmtXhX+YKoqJxqPIFCl07O2eyH1CcSNFvvPPa4lFN34GwHw8buuhesQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kDBMkbMT; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kDBMkbMT"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hLW902bX9zKmX4;
	Thu, 13 Aug 2026 18:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786638724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhYB31gK0RBUlszjo222A/qXdg2ZTJtwEYFPORH8z9M=;
	b=kDBMkbMTc0vKozAQ547YlG++sKkyA52PNS9Dwh71FpPGWmAXXp5sT57QpcVITV3lpUz42x
	CEwrL+tqX4adgDl03qvkiRjb5kYgRJhj7ZL6YYcpoSBkrmlunmFMgNt2/qyqMeS9kletCV
	xMmCQbNeYeTMBCLcAf/Wcdsn9zGHbQDTxMuodJyeu4M+o7gDaY7vgU+MsF5yCbTPPc2wkk
	4gzfcn6pCpi1tmz2KECUn/Y6PwPBtdXKP7u+d2fR7EjJCJcxWZjOOGns9l58CgNpv88u72
	2bxpjcWki3iVjOawDRQQ28GokJR9CEEfYEdLcvg9Drpty80t3jxP+Xd57GKlsA==
Date: Fri, 14 Aug 2026 00:31:59 +0800 (CST)
From: Ming Qing <a0yami@mailbox.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>, horms@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2125081283.36735.1786638719082@app.mailbox.org>
In-Reply-To: <anrpdUa_ngVKH6NR@chamomile>
References: <20260811022012.5416-1-a0yami@mailbox.org>
 <anrpdUa_ngVKH6NR@chamomile>
Subject: Re: [PATCH net v3] gtp: serialize PDP context updates
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 0c489e9920faf4672b1
X-MBO-RS-META: xo3xui45ft54u8hgbph669i3fsjsc6or


> =E5=9C=A8 2026/08/11 17:20 CST Pablo Neira Ayuso <pablo@netfilter.org> =
=E5=86=99=E9=81=93:
> This can go away too, for gtp_genl_del_pdp(), the mutex replaces this
> incorrect rcu read size lock.
>=20
> Thanks.
>=20
> > +=09mutex_unlock(&gtp_pdp_lock);
> >  =09return err;
> >  }
> > =20
> > --=20
> > 2.53.0
> >

gtp_find_pdp() calls gtp_find_dev(), which uses=20
dev_get_by_index_rcu(). Should I keep a narrow RCU read-side section=20
around gtp_find_pdp(), while using the mutex to protect the PDP context?

Thanks,
Qing
