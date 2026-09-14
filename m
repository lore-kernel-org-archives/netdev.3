Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF265331A63
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376608; cv=none; b=nYg/Is2YVwKNntY2BlSrtSdg/ZjZGMgT9wDy1bWbk2ZvlQe7LXw5QAtUqhprTPVT9tnfh14XAtRShtdg8ALHaOUTA+vk922PLxp4WlQKqfbQrwvI0OGXyk20tUwWOW3PV0FWe1wN9815ROAU38xrxKq1GzE8sUSkfN6EBlVgPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376608; c=relaxed/simple;
	bh=WI+TVWUFTFDe7DBtvoFy8AKTnIzHqypmjcK/F4DWbag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYvqu3Bu6/iP85RarXP5c0DC+oABw1IJTaU48Lr8P2rlXZjkmYsSiG3QXURUZFgXaCgb/0QplwweBV0YW2Hdu8qIGuruXfMo99hcV41JdnNcM8OqEFmRzfRGXBZX42oBHuXaWvQQLYHh2TAV2PIAwMs/1zJc+dZYBwI2jUyjKg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=N76Z206n; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="N76Z206n"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae45so3786773a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789376605; x=1789981405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ofrWejGiR6SHoGCutK5goPX44BYR7HPIj9AuQ4bpEgY=;
        b=N76Z206n2xCNteZ19+62Brw0emy15QDAFLlQRqyxOqZqI/RpIXtblcEDI6br4/zZA0
         nv/WQRgKR2rfTob4xFt43b474Dpk7ijqjQR99s3p8pwUj82KLKzGMDclP8MNJH6Qgyej
         30O0OgLRvjmIVm8CBUiAcQpJsmvO8q4Vgq0E//DnMmT56ftIHAdXwNHByWVvfqfu7JNM
         kr8QvcO3PD7d7ha+Xb44BGvPnlQxb956enbs13s5iCfS+pC9W8irVpvDKJUfHsYCVAr5
         nJfwD2OFEQDm+NwyZHxA8G8O/xVlL8ED8cx+w4Fvur+K4TabKuaotGFAyNpBHSpn4jl3
         1mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376605; x=1789981405;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofrWejGiR6SHoGCutK5goPX44BYR7HPIj9AuQ4bpEgY=;
        b=RM6etl1sSOvIDzD2F8RuO/4TcCUgf8i1T2PzF3vERFWkabKDXRCFvdQfzKFgW62M18
         t6/CPifFAupYNuZj7iPnMk2VeZFQrkU2V/r5Zl/lztTFdlBMAkhjNfjrP8pTR0xuoB0b
         5WmAqDF6Byb78EaUJ1AIspUPxCDaYtH3mCs1E9/b1pawacGDgpdo8ug6mbt3OvvTEXQm
         lmYCOJF6NysUUWJ2Xt4EyJGQxLswQr3ToQXhH8J9lIhJo+XdONyMAsIrA2Ecc8QbjHf1
         eIT/owpgDxc6ZXG9JTCxB0lSMOuE6j+PHdtCh7OvkvsD8FmNrCCdMFlnUJqOagJpiXcP
         s8cQ==
X-Forwarded-Encrypted: i=1; AKwUvBzV3A54y4GYTJk8vSFIDVa1L4h8UTIgYslmHVYpWQAvY7QHbTX2t3yRK2mQz01gu7Wew1eRfek=@vger.kernel.org
X-Gm-Message-State: AFuF++lCWoGQekX6a1GrsM6HPK3m5hqdZLaK2v82pospb1as31igKlt7
	LYS34NBbKXlfzC8XsTEkfB9WfAoPQDlBDsRX1iKYxA4YRwtJWw/NCrMCgql1Vr4or+6ZVUi3YVH
	k4Q3dBvcGv2XEsx0Qnzmej9dqvKt3yaRBwJCLhmXvucMWEZ0yNChrS6CTUT7T38BkQNI=
X-Gm-Gg: AYBFou3zRlsCCw9bF7w9K2g00JRQz+1vCcfT+uqsT+wgtshGwrBJ3uAigOte2L+C8CG
	cUZw4JH2NsImDEosqFhv4YJyWcZm/ezNF0Z3xJ9VBy7AUHgYiXmb/zAHY/KZDkY3+rK8T/rPZa0
	eYT/yI2ezED5NrTSeec3MzgfPEjFkE5IPFYaGngj5dFWdGiwHPoTLWHQRj9Q5Arwu9y3e6bPPB/
	Rc99N/DuaPzOwXbOiJxMsDbAdl43fLAD9U27WgiewCola5zKwIRLet9c1Xl5vc74XZbUxfumjXM
	jnVTpVIlBNCdngw6iq5kUMOrgftXs6oaEvqqjA6zqKIh26FYxVTJh5M/20WON74w5l+hzipV3vp
	8ZVaGykkQ94/W6HOE4lzTQKfXTpbHaS78DiBd9A65uDAmfm7+L+L/YWhe7XNEFi0mPdptFI8s7J
	7ZlS2KEyz98/72X1jNM3FbeQv84sIQomphYtZvkU/jlkvYoxeJ97yevXX3D3fnxxODw3Jh7iK/e
	oCwGVUvaw==
X-Received: by 2002:a05:6402:46c8:b0:6a6:8dd:c76b with SMTP id 4fb4d7f45d1cf-6a9f61e5270mr2016134a12.1.1789376604966;
        Mon, 14 Sep 2026 02:03:24 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:ae69:df2e:3415:7d4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b593d7dbsm3953252a12.22.2026.09.14.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:03:24 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Karl Mehltretter <kmehltretter@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
Date: Mon, 14 Sep 2026 11:03:10 +0200
Message-ID: <178937657696.1981013.15922073260198899920.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911231352.12706-1-kmehltretter@gmail.com>
References: <20260911231352.12706-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 12 Sep 2026 01:13:52 +0200, Karl Mehltretter wrote:
> ovpn_bind_from_sockaddr() returns an ERR_PTR() on failure, never NULL,
> but its kernel-doc says "NULL otherwise". Say ERR_PTR().
> 
> The wrong text came in with commit 80747caef33d ("ovpn: introduce the
> ovpn_peer object").
> 
> 
> [...]

Applied, thanks!

[1/1] ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
      commit: 1087c84dd9554a427f6ca6e350c22688eebd3075

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>
