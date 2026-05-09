Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5A339714
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294580; cv=none; b=gDVNXjiXPBZ5II5wjC13eEyKPYiLTun8ah8grMLxlCSjyTAEr2LVaWTApoQWA3pYL9lDTbYjN3GDLvCRqzwOEFZPcX2/a1ErwhRqkCK/AJugwOsxRxkekyEOAKG8EIkEcAaC5mJlsE/W2QOKwP1diiO5ESN3iVWhhAuMXqmkJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294580; c=relaxed/simple;
	bh=4vzDDMNpqR6XnxqE0iV+ACEr57IhlYRP/KePD6MMaNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+j/qh1mASaakwp2r2nNnzmp1R4bS8tFRJAFzdLYdShAU19UCdXHdRwBOfAFM4CWMzlktejxlrRYEFmVV3miL7I99xGF73JOMSB1JpyyMSOsWMJue6apxKnhKvn4JpCBBP+Xyw0ti4d4QSae/xIN90OEHSb4aFsj0jQLNzYD2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxnGpzM7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxnGpzM7"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367c26471f5so383719a91.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778294579; x=1778899379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEZSwAfEtGVARaVZB47NtatWA0STWDzc98J9o1Rr7Ek=;
        b=lxnGpzM7NSGnstjzUJbe+M6kBKLzZ0O6qz5+eSBNdebKh28omFG7jVWv0U4gU9qXfG
         sDYSoo2VLa/NU81HkFtqAgersfy3ReVKSfBmjAn78oYmBgZM+Fjlz9qIXqyzarjt6u1c
         56wCROklCGHbexGC0hvNNzYwu1tIehf+St7rI1SlVWis6qBCsZ3e5wMfqx6pwTPK/cvt
         qPsGWWiI0ICju/Oo4cUjq3mSbZCDhJhED20Hxyl5Cpjm/G1GlibDV2foNa95b8ehNsvb
         vjCyCbM3M6FLmoGZXCAIPHuH19ImH08tpbL1sShjyJt2ShsdWklC53eAu4kkeNPLw+dY
         N4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778294579; x=1778899379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aEZSwAfEtGVARaVZB47NtatWA0STWDzc98J9o1Rr7Ek=;
        b=T8IjEOhjrD4u2URvrRJiPv+mS1KQRaoWxRvERCSItgNcnhFEnE6qOvgKoUM6JkTlwD
         aVbiN/O3gyfvbKSdJ1y4sUVV7bmaJuze91x7WZt+0WA7nD1T6SWqyCpMsStGphltrG+v
         hvT6lFtwAy0+WAGNRnd2VgdLjof81OEaBZ6SICoaFBS1CfewEgVmW7hRWrsx8e3ZQpBp
         OtH3fYyIm0EUjfDMvoEwHboox7CiepPa9XgJGBCwz9lYlzFKn4bRh0tp4wLJ8VL1IPlI
         H5oI2gGiqT89bRQE0jH2H7FuVwdufj4kwgJrJYn4J907oS3Fe7v9mBKhpq529Esm0D4/
         VXWA==
X-Forwarded-Encrypted: i=1; AFNElJ/qWs5b/D2yMeVrOiIP3RyKn5wbgSnJ+x7tGcHszU3cU8moMDZOSiVa+xqILjhokKnhR33TDKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWzG74CbkktIDMq5d4heMn7EjldnPfExc5p/Z7C6JWFxSnnF9
	g8RhVODCMVW/cAKZxjx96I1h1eMqKlhoYOS9/SfYrHJnjMFRnA6L9H92
X-Gm-Gg: Acq92OEEffp3ji3FPBHlvNf6HLkM/0jQ78nvorzjYqH3BU4/bYeh3YFm9DHOYMXKnCI
	Swvc6wp7ynRFMb0pwlrmxvxm1soh3QBoePa4fsaXo5GIalgcp8URVqopbTUlzQsZDPnVBkAsRCd
	cl8sXjBAbOdccCHjZTLdMDg5p0zhIJ2zXLmF1QUEt0BtuJcUN3wbL0UFmQ/NaIE7bpo81Rr7B0f
	LMd58CQWZ4+Yg0UP66aA6JLT0Nb9iqgr0vDrcePDD2UO7AYDqmreXZiAK0HbsnsDu2ATzNxefUP
	20USH0kQnKcLHpaYX77u/XWaocyX6oTC2geRMF7UE/oWgumNmCea4Zy9efKb4/oO4RCGHo/Otl6
	7MTG7mTaWmXttSfH3j8gRHN/oxxBU78qPaAaJgoNor78V05FeM6X4EW4ZtFN/yfLGlCKW5TWYM8
	vJyhOOgE/zeiXPwK4WKRb30xslo/0NmkAWm8qsxBzOrg==
X-Received: by 2002:a17:90b:3dcb:b0:366:decb:d119 with SMTP id 98e67ed59e1d1-366decbd2c3mr3805777a91.11.1778294579137;
        Fri, 08 May 2026 19:42:59 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d623fd6csm591394a91.1.2026.05.08.19.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:42:58 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net v3] ipv6: validate extension header length before copying to cmsg
Date: Sat,  9 May 2026 10:42:46 +0800
Message-ID: <20260509024246.2249347-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260502012438.3685742-1-tpluszz77@gmail.com>
References: <20260502012438.3685742-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping on this.  pskb_may_pull() or keep skb_tail_pointer() with
the added pre-read check for v4?

Thanks,
Qi
