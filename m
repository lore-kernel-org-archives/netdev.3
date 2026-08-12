Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7331E106
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520124; cv=none; b=FuLj8DYLdQwT9LNHmutOKjoeoe1qKLGSLr/07ep20S4bHgOWOISe24pbhK0eCnL9o6U/usNhsSoG3snFdDy8O/wUYWYwZ83B3lGGzVaOcv3V6v42uEYRNhr/ZfsMy4Hn8lj1z/4gjxoRfmDSNOjRQKghvxnLNb2vdMGT6ZyEi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520124; c=relaxed/simple;
	bh=7B8tE+cjteSKGkPNTNCILX/erEQE+pSMtnVnVaNdEqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1NQozj+BhI66NezH4Jpb5GEOwlg0zwpQuIrZzqqXrZemOUozvJcxLuf78HpyBmt9tJTPTYRt/0WvUJK5Dv/f/Wo7hiiyxuVIdoStpeKeodXFwtqX/Uqojb1EMVpVxkXIZSyGfwL0sKwTVL0h9N2HR/W/5QoGS+Wxt678kkzvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvVSXxyI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvVSXxyI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceaf8a1265so7240765ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786520122; x=1787124922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7B8tE+cjteSKGkPNTNCILX/erEQE+pSMtnVnVaNdEqs=;
        b=cvVSXxyINDrOc91wYC+8pqoqgfrBm4lNO6PK2WCxLN6/3rB0waIgpmuUhEQee9wLZ9
         uXO7IzNYBUYPyq7jYJtUF7gzO8BOU7yKT6O5D73ynNFD2WBaMvATMFLCdJbbECykJldS
         U+vMY5uIJ7PcWii487OubVpZwsi4hFKgv+zDdMYQ4R4/+0dvsC1u9UZ9LyF440pNyyk1
         8fYaK+jfe1yzHwpo1l/LwR9oMPZGtUQJN3P0EQMo353hH9DYgvs5glnkH644irizoAPw
         GmGWLdLWQUn52cQlnnGm8RkTWqBb9V+eEQ3tch3e12s3/MqH5IzMg1wIo9yqgwKxkRl9
         FrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786520122; x=1787124922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7B8tE+cjteSKGkPNTNCILX/erEQE+pSMtnVnVaNdEqs=;
        b=aFn83Ukme5DZa69lxABWEDC0S2tyMJz6rpY4S1jspWP+HGqz2TZlUproUDjjdvQpLK
         9MTeOA+eSQcqJqYORmGp3v1AUc/sLaxc3FNNYe43kj+gbs4Eot+ABEH340xIRkrdSOKw
         0TNnAmh0gTIVgg0m8dxVME+9FwhFCSWgUp0Vpr13JWqWNP+/skah4p4VJevs7gnHG23I
         gSYOH0M/+XbpFgsT8WcJx44Qop1/B0XmU1k41XnXce6WXvukXzZxd0Yy7NBbCVLo1Jhx
         FlFrwJfIz5DmXZVpIIHtUCPcEaG2JmcBocSy43LWIxwKeLDZUf2fdHls7rvw9yU/ylv7
         /JXg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9LR8+of2BGpy31QYxvYU+lxOk5vW6Knnb8Dv42V2ids0+aVZ4ji3s0kszCIRETepk49YQyS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB75HZKZr45wSYXwDXgIDIBqG5TOqTXXLeWng+Ui/ttGgN8Zj2
	+h1xP5OPi7fjw8GiBAVMQqQm4cgBa5d6YaVjQsAIy8VkJUsdA/+6rhOX
X-Gm-Gg: AR+sD12pPzj0BhWR+foGYNlz22om6OWD6Nkp0ML94SZLOtrnw5e4qmexgWJPvM0BuD+
	KGN8bYrRJQhmRarj+7ymeTDuEAcw/W/+76txAtWjYk3RQWU/Isnj/G1hSfA1KOoJvwTngV0y9Ti
	g4rdMLPBkyyI281ViZrADnztR4C1zoHpPJ7s3NmZDwzUG9hXBJtEdRfhEqnq5XXcoJcnL7ZsddI
	GKCUeDv2LTiMV1TAakHx6LPiYjw0Kx6a707rMFRLfn7Jrz7RQvL76Kw8OKDmN3HWkyuRm82GS+k
	lVBvgrNce1VvpcdpXWNC5QHi2u2OwF8FUmgVqjfjgvXyrs3RPxtXFVAx1cUnPSl3ZqrxY/jIsea
	KqmMamrBEhTi+q9xAGf9yKE2amICjnQAfvMaXD0+AnEBlea/TrQCEEJjhomVIeabh9sLCTxoRW3
	dgG0Om16tkOn1Ng9MDkdccEI3nG/ZKYHwd5B89k5/iCwOumXMTNumnLaQKojjmC0uZntzJ7HfcO
	KhFik5+9t2CFVMtdnRX3Dysv3WCecY48Pyntl0nsxK1ozrJEsSG
X-Received: by 2002:a17:903:2cb:b0:2ca:d658:d874 with SMTP id d9443c01a7336-2d345713af3mr38231045ad.23.1786520121828;
        Wed, 12 Aug 2026 00:35:21 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3511496f9sm2661295ad.25.2026.08.12.00.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:35:21 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Joe Damato <joe@dama.to>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] nfc: nci: Fix conn_info use-after-free
Date: Wed, 12 Aug 2026 16:34:14 +0900
Message-ID: <20260812073415.507615-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <8e5c2ea4-53fe-4dd5-ac71-5bb3ab5ee911@ixit.cz>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello David,

Thank you for the review.

> Could you please rebase against
>
> https://codeberg.org/linux-nfc/linux/src/branch/for-linus

I've rebased the patch onto linux-nfc/for-linus, and will send v5 shortly.
