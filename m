Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE34BE420
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792106552; cv=none; b=dxcrKfj4tRqZy4EESGwUaVMOPAYzyPdMhTmLwJUkS0zYlCD4TbtNKhVX4XkT8HGlFiG13GP3BnBMc9tTAFCLGb8DR7HJhP2H6ZAVFdnT29vbuSxejy59i7nUQtIhfp0jP7PPoXiw9XGmxTrnBqH80oX/oV4zQ07wKEYhmsg+g7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792106552; c=relaxed/simple;
	bh=flgSKC6pMf++7DJb38js+MGdU3o8QmC+4FmYXdajCnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMTHv4eGhX7ZpRSLyH8FgFZTd0KIQqRgMTvEhdeYDGn1+utprbC544/pFoVt2oBD0sE9NpFoLWOqLGDcUlOA3QiS7IebGGCdLOKM4BTNv8gpUqoGCdaAAwKirvggPwGeoZDjMCgIPcRqxsDkcJaTW5JqUfOaE/vtvywLnL8/sI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=hIGpUcGq; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="hIGpUcGq"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-17bc533fda3so2825507c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792106550; x=1792711350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=flgSKC6pMf++7DJb38js+MGdU3o8QmC+4FmYXdajCnI=;
        b=hIGpUcGqQ7Uo/Xo7U5LZkCBLYyOBhPl2ndaSzcuNGrQm+qYkjXEFnsibtvYjSBE1uQ
         4qUaGkMtKUOjQCVKZWIDQ3Jd/58EjObsJwqwwyxaLeYXJOuu24eeqbLEq219RZdhohzN
         kNlTDgmp5xL8iiWb2fKJwdkh6R/6x804jfwYw9hO/PxbS4IhxCGdHhE3dVTa377nLzac
         lfR/DG7r4HNSigLe52/TqRxRdvc/QFA5rOiE5CzIaRSqXpUtOm2GqAa4EYSdb692yX/o
         2/DYQ8uAMpXVzST8HoP1yBpHsMjYsAl8Nt8EdH17RfZfWxFzBKEPrqKQ2T/tMZPyizcJ
         WIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792106550; x=1792711350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=flgSKC6pMf++7DJb38js+MGdU3o8QmC+4FmYXdajCnI=;
        b=xGS7RmlJtpxPY9IRmGCllP86rySONN5INZDaR7O2+yiWRRLoTu8AGXUeYdLBT0c8E/
         mSvxemvk9pg7XxEMbgdpAvvafuH/s8Ya6kjJh14+/qSDax1yJPlrdFSqEBsN2TSO9SAq
         44l3sbVA0K+Z5SjFF0jukg/Z162if/WKJ5bOdgFydkrTgrjYcLqnS1CYYhT231PU5J1n
         J3p/Kj/t3kvqFP7wm018cONoLY1OL9dL75SuRq8MOiCMHT0Vrw1q/f4bgPxUggKN+THf
         5uQIoHprJDpkA/JLvKLkAbPEUAtEEqVnBfGOwgjs1kEPqaU0y9aszC0PomCRNDCS/CGv
         rMRA==
X-Forwarded-Encrypted: i=1; AKwUvBx6hgo9egzbflaN2b6/X0cxpBfdsdUAFdQAuqjQgjJX1vC9XOEdwD40TKaG4u3znLs5WHs6rMM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0HBwdQckV0wAFO3SoYXFIAFWsP5Ry2qS34XkKE8OIbv2LOfBW
	vHfvlsrxkH8nlI3O8MQImbbdcL3BHS/sLDe1hvGcFJHL/l+NO0xasyJWV9OJmYi4vNE=
X-Gm-Gg: AYBFou3lWYSW9/s/W12S8Y1vnGF753gKfSuhTrJRkY78Q3+MqeqY0viISZNcvboo+TR
	gqKy25miIiyl/eCwECnmWgToFHykowVot64r41r4ziKlHMhuVQ+GjDIvFaMuH/Ty3Oyrb39iCBF
	DB7I/F5sZ9ctqCno3pGZglp/W67zwgzmmJ240mlsCK4Mde4LtDQS0YvFD03W2mG2vpB9xR3UGCe
	yPD77xeo/mbupdaiyRH42oFwUcs29jxfb6q2P/pgrWDJTEp4BhGMsEIErfF+AvqEg0QN3nKkHHr
	i55OoAEPjTX1pHqUr3JRZ1im0M2H/dr7rM6HgghUEWB/rLB+FppBeIz0L6EFTBdmDM0WQjWk1vL
	/H4C6jXkc2nxVofkjKaco/jVcaMynlfRxoQpG++eI+sJetOi3H6Dfjoa1O0jYPyS0OHrN19pqnm
	/eAwTO+NBiUyobnckxdukF5U13o8X/pN6aDets3F0SOHgMoxIAM81B15rDVjBmVULYLDACBuYAK
	G+VT+KU5X7wl1v2MFnPoq++Cxq909EfK8pfuyrM/McUC1c8YGo=
X-Received: by 2002:a05:701b:2810:b0:14c:d8d9:9502 with SMTP id a92af1059eb24-16a5e49fe06mr29600227c88.14.1792106550027;
        Thu, 15 Oct 2026 16:22:30 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm619618c88.20.2026.10.15.16.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:22:28 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sashiko@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v4 0/5] amt: relay tunnel lifetime, validation and request-path hardening
Date: Thu, 15 Oct 2026 23:22:26 +0000
Message-ID: <20261015232227.2929175-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013175407.947606-1-omar@blockcast.net>
References: <20261013175407.947606-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review. These comments are against the v3 series; v4 has
addressed the review issues introduced or exposed at those bisect points.

The Update path now takes tunnel->lock and checks READ_ONCE(tunnel->dead)
before either the IGMP or MLD report handler. Both tunnel freers set dead
before clearing groups, so an Update that acquires the lock after teardown
starts cannot add a group or arm its group_timer. An Update that acquires the
lock first is covered by the same lock ordering: teardown waits for the
handler before clearing the group list.

amt_dev_stop() no longer uses list_splice_init(). It marks all tunnels dead,
then removes one tunnel at a time with list_del_rcu() while holding amt->lock,
and performs cancel_delayed_work_sync(), group clearing, and kfree_rcu()
outside the lock. Every lockless reader therefore keeps the real list head as
its terminator, and the post-stop get_or_create() path also rejects creation
when !netif_running(amt->dev).

The Request-only lifetime issue is removed by v4's final patch. Requests are
stateless and do not allocate tunnel entries; tunnel state is created only
after a Membership Update authenticates. last_seen therefore describes a
valid Update again, and the global and per-source limits cannot be consumed
by unauthenticated Requests.

The group and source timer workers now hold RCU while finding their owners
and take tunnel->lock before checking dead state. A worker that races with
teardown exits safely; the group worker also releases the device reference
that its timer owns. This closes the callback lifetime and double-removal
races raised in the review.

pw-bot: cr
