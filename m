Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1C3AA1A6
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676652; cv=none; b=fDMCB/pYEf+GTb910mt0doFGMMiQETWBXU0utkwlGxXdVQgsO3jxR3rp1jOVImQfUhk9pF1DcvMtXkCw1ImBwyuXbwlPom4SUGcN6bGLsb8sKJeQhrhNzuHgE8p98FN3cvluCNn3QpUPKaWFQ/nNVrYqpaQNmBAQyPfCcZgH1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676652; c=relaxed/simple;
	bh=pagONdv6g6sVLo6prEeXJyORVUNqZEAazjNn/2zge2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQExUIHzWKPWHoh9NNmKcmGVGQBJm0kLNQYRmZB4G54qYUL62Rut3tiHlOYbIVNqkv5H6f2EbaAW/t6lji0MPD290ETkQM0bXxfmxoQicCrOJscLzP35eAPDyCZs+Pih67+5fp/P+GFWlDnQxKBZ3SkmzA1REUFphgx81Cu8WY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ntmOWTxU; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ntmOWTxU"
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D45A3F640
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781676650;
	bh=pOwT39UQWLw0qIZF363opJvNkgJrZg7ks6patcKb+Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ntmOWTxUwe9vsV5PycXK2rU8SO1vcA/gJfZanXajS2iI9iuOm//CFanrpcIWYNBjj
	 8VaCrZbYPwsrkNlgPhqj76yA0lxuDRNGWo61Iv01K84xykR+MiM+lnfscPDXDyVztA
	 xW5OopWhlxYNG1GrSwXspBIkENaYYE/00sZj86QyY2p84BAj8LvncSU3r0wTcZYecu
	 b7r7XPG6UXsyFS0YcHIVp/9oQ22DFzCl4WTfVdm3Co4ySmed8LdfaGBPTdi5xNpTzm
	 mZtnp6QXebmPlN2CfQzzgqdmCPzIuFJP+SWgieyzndos6b9nwb6bMD9uDtIyVhEgn7
	 1K/3iz1dEHju9DSy9ff5NTtuWKJ/FxJCa+HIZN3KDnyQuSQuWGlABtpvkmDXYR6Xmw
	 kotTHxwv1zRPlrj2RqyIV1cMxCBL5Fb8rqFsHKsck+AY6zrEFwPnxAd8vjIfPRanET
	 xMgxD66s/ynerLk/VI2JOjrXezrHVX8gAf2cz7s9DxVtQ4vnVlHBM3vZZw3tDjd6wM
	 MpaqnKW6lC7WFEg7sROu47LnmJydUIzJdN0m3Grsg0+q6kyo9qETWJBcfrEVOZsVPo
	 g3ZEIDYCNrsc5f/a8aNeTaifMRNWHP5FBGI4tUPbSfuc266YMdCtucp5ludBL70A83
	 lIJOP2umFZld2SDrBWRvdONg=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eec2badc4so2931073f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 23:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676650; x=1782281450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOwT39UQWLw0qIZF363opJvNkgJrZg7ks6patcKb+Oc=;
        b=Nq0gNqRXYZLeq8uknwzBTKriSGPt6g+1id7pvsTsIkPML/0WlXOgYzuTBwNTlr+ORj
         zDPdWaXn6kkBngjK6BA5t2gHYQjozOgXf3aGgjcyVmgnai0ZaoaTOMsJ7WBinFHz3Yd6
         xeQ64VMSxyYSXCu8owIfGxPYOqMFx9V973h2QHm8GdC1mihl11gr/CS0JQCosTxW6aju
         YRW0RbJXtPCkPHjHlY0Mdy0I/yezGQvYWaPLfYxvxZmcsv+Q1TGP0/6oTfDCc+2PVo2F
         sneF/X2dxXhCQQELKgEGhQongj8++ytV72M+qE4L0poz90FhfBC+u1KqpxfaFMG9wM62
         nKNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hcMt4cUYiFfWrFb+7wQ0mGtIZJnbTi22ywofAkpadtxjObNTFbVzaVTD+DtGNGJdo9WH54Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylft/LO94BafOmF1tPfxUNmrM29QjxFhPXM9IB4S8f1q1HP5jJ
	9U6mAI+KFh+MZ2m8qLvhpN2qxQRSgYcEDyX/mYEENcubRDn267WSS+e0eh8SLKNwIl0bNgLDs3W
	aiymzbOWCj2xi5Fay1KQTfpi06fEuZYL/hvuLW+e0Am7SN3ceyLvkKEVObMnRAl/9x7RFD8vQ+Q
	==
X-Gm-Gg: AfdE7cnnGdviDYp/NDwu9k+KFn8l/6zZuhiwC1j7KxDn9LLoloyOsVFHU52PoV57dAi
	LfvM9wO0g+vkWl/VOZkQk5s3iQ6iEDsa54LWUVlnOhfEfDZxzPkZXddTgOWZivsYmymnD3dgllW
	LWKRVAIBhian+ps2rMPB21YUTx6G6XDQeOd9CFLkpHFm0pItZ6tm1SaH0QsvB+NdgKfM6UJWqMT
	a2/pmVz4j3TbUYbOThlqZHRdr6NZmo81PsEm6Nv7pRb7tebKWWFmad1WHMNqiRfrFULm+UWc/ph
	iTpHmwYMtM4m5CzrthC+9uJ3SIzC+0QdWP3ZqdUjUhAoD9QOM3sNWP0tBPMlrsPP87E0F9Ai7z3
	OCbKU9iLsZ00=
X-Received: by 2002:a05:6000:2481:b0:45e:8526:7dc8 with SMTP id ffacd0b85a97d-46238aca122mr4401223f8f.25.1781676649667;
        Tue, 16 Jun 2026 23:10:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:45e:8526:7dc8 with SMTP id ffacd0b85a97d-46238aca122mr4401158f8f.25.1781676649267;
        Tue, 16 Jun 2026 23:10:49 -0700 (PDT)
Received: from ross-pc.local ([2001:67c:1562:8007::aac:41a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm46674988f8f.14.2026.06.16.23.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:10:48 -0700 (PDT)
From: Ross Porter <ross.porter@canonical.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ross.porter@canonical.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Oscar Maes <oscmaes92@gmail.com>,
	Brett A C Sheffield <bacs@librecast.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] selftests: net: fix file owner for broadcast_ether_dst test
Date: Wed, 17 Jun 2026 18:10:38 +1200
Message-ID: <20260617061039.79717-1-ross.porter@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The broadcast_ether_dst test can spuriously fail due to file
permissions, depending on which flags tcpdump is compiled with: If
tcpdump is compiled with the `--with-user` flag then tcpdump will
step down to the provided user after opening the device. In this
case the test fails due to permission issues, as the output file
is owned by a different user.
Debian ships tcpdump with this flag enabled, so this bug
appears as part of our kernel testing.

To fix this, we can ensure tcpdump remains as root (regardless of
whether it was compiled with `--with-user`) by passing the `-Z root`
argument when invoking it.

Changes in v2:
* Moved '-Z root' before filter expression for POSIX compliance

Link to v1:
https://lore.kernel.org/all/20260610062230.71573-1-ross.porter@canonical.com/

Ross Porter (1):
  selftests: net: fix file owner for broadcast_ether_dst test

 tools/testing/selftests/net/broadcast_ether_dst.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.53.0

