Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADBA40A92B
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099253; cv=none; b=KVgBI8SSo7vFYxCG/kmTPsDP1rl7YEYtU/w6fn9iC7xNufAI6uffSNOCdKGxGaPqMl2WMe06BryT4eXhRyMIil8haChOXisl93RekC7zy4QxsH1YjHfkeeqmLDUMlLQLdea5UxftPPv7Y3VT0UJm/7IzZMgBa0K2XXOhLBAjPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099253; c=relaxed/simple;
	bh=PVwIXQQ5/WGjpPJCRs7zgHzHTHu6X07EUwTtNa24yqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwtYFu/eeHwc5hJDG+R/BsG4NcsW55s3FCGvIWAoW9rXRYjh56cfv/eqVHdxtGcGdS4g5VCR2HKbqSPMVkIa7JGb23PDeKXRk/USPgcN4iBMjzzAzbFre76/YommueQpoKnMxTRoxVub0Q2o9nYs7zw4hBBFtwma2ZFLgn3DHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GerNWho1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GerNWho1"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso350029a91.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791099244; x=1791704044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATqBSGgki2so7eu3mfXFJfLMGYQGWd86CLIs5RcaLgw=;
        b=GerNWho1PMFs3FM71jALYluT/hDPYCH1rkP7w7ib+mT0SnrbHYaxV2fodt2ANOKpVS
         +4g3FN1GvpPKMhWR63Nu7Yu5uBv8RaNxn13eX6XX5v4NT8Wus549VEaOmm/THcEgIpNa
         C6MNRyVj8WOFyZistXcmfax7a1t8Yl8emn/GHJDg9zxTxMhiINTQyAugQOuYVRSzTYb2
         4Z15R4LvCOkRmeOCt4Vz8Vgj1h3BT4kIe9s3lyziR6BSHNtmrIy3wEAgQQGJSHmi4seJ
         YRAUrGbPP422oTBGODLjn98gx5gL6aEntC3Ihfg/PYVt/8KqcPKB86YPIbeQJv7H+GpH
         qXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791099244; x=1791704044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ATqBSGgki2so7eu3mfXFJfLMGYQGWd86CLIs5RcaLgw=;
        b=rQ9uCApt3XdWZ+Z2rEjiiaCVEN2rMEfjHm0T4GMiNIoxcMSj6u3va5AA9I5HgY7V/C
         Hkv6vJ7m889qPtHmf3qLCs2tcyZcbjd1UmsmsExFzbZ5e8yUk23Xrbcgei861G5aqq4G
         +zgIPH7m33oyxZToMhc7e9E+iyz6WRGJo0n0rWvNsMB1EyC49WpnrSvos00qtaIt8Iky
         JCBD8sejwx+whVGwWI8eCvqgTsgoQ9KkqWpxTNEP0aRtfnvrwTERtYqcL0mC79P8wllV
         zRIU7HuoPLj46D6EJJNIAAQKfb1pFyjkXqhKzromScd9BoIV2cwRemLpeO33wrJMI4Vq
         29fA==
X-Forwarded-Encrypted: i=1; AKwUvBxvEYvcamHkmJ9V5P7JMbt39rwfIrQfxptKM/OAYtYEqwtaeBL14fYUSBC5fGtzeDFBwGeGe2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAfe2PM9BT6JyxMpInOti8Q+5x8XfYeO+kDoEkFucRSxPrAs4v
	Qu5TAU4+sM8TB5q0wkcY3DidPeQ/vvurp42baMnHtXDwYaBhsWfydaAY
X-Gm-Gg: AYBFou1R50xfW9DJvKoHiPEab5dNIDUbg90rAZKgsKmVPzHBnOfMkyQLnpx0FRO8U9W
	27/oIJKXGENfe+WhlQaGIY1kFWFVLmkWTEh8beslNeI3pqyhDErrQGrMCd88Jgiuyj88RSAqm83
	tq3NEv7fx1Rk2EGjOENTP43wotc6qMXIjqGMFWcljCbJbPOhBQN0ymERWoHUBHaesib28/puwnG
	36twQ6PTbsz9DPxe/2+mulua0vL47OkrBFd0BuEXL2kAlKQXR42cL6Qk6uwFBtKGOS2amlLUqeP
	gJkOQkPtLNgjpJNWlhAnN6u1jo3GhU/FGFQzEcUe0CRgkcOxyjlcqFcR2Glx57GcaCUCp76+QUT
	I0Iv1uFVnt4fOOVZwkchYLOOm5XCvxvH8TSrT9T4qzR4jyMr3WhwiBksud3YQwaOsKA811l9E3X
	oomfwoKnU3qiOj6E4WHuu5Vu7o1qG85RvRWjjYjpVw6e44SCo4WpSUFALob8akgk/BP9d/V7yg4
	Dlk342aY9M=
X-Received: by 2002:a17:90b:5310:b0:3a7:b2d4:e411 with SMTP id 98e67ed59e1d1-3a7b2d4e54cmr2200992a91.21.1791099244227;
        Sun, 04 Oct 2026 00:34:04 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4f3911sm5749884a91.15.2026.10.04.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 00:34:03 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload length
Date: Sun,  4 Oct 2026 16:33:35 +0900
Message-ID: <20261004073341.4034680-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179108986364.434549.5339286904514687491@kernel.org>
References: <20260930044147.3818241-1-4ncienth@gmail.com> <179108986364.434549.5339286904514687491@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both findings are valid.  V2 validates hdr->len before allocation and sizes
the skb from the declared payload, which also avoids the 32-bit addition
overflow.  I am posting it as a separate thread per netdev policy.  Thank you
for the review.

pw-bot: cr
