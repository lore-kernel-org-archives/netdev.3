Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3853C553F
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790417051; cv=none; b=ZcA2COkM5owy1wSb4uO8dUlI1Gg4Dfa1YMiN3AfqFMx+zkUfr9N+g+o6qKmUbljv0GbkXsKr+/Kraugu9XOCi7c8V9TLgXTrpGk8O92OSg2nP9OiLbmzsdxMcHdeQynXc9gJWFADQl3/ALUL6YZXnHhaH8XzDPnFH31vd8oeFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790417051; c=relaxed/simple;
	bh=sjAoSVC5G2dj/0GLKC6sL5Re6fss3PLBE3wRn8okrJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gEirKa7dK91omsEnQ74M3OOfAaQGA6sj/6f6n3hKDHLnXPhe5jJ0YoB2SS91Bb83NGbaSdZMDZ3OxGGrLjNSm5sEMzetl8XQgSnnQWJBW9/QHH2L/LMkuLAk//MERMRy/b79uOfzGkKjzyPFeJM4OMy28utnAIbAPMkgLNe90dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I77vizvc; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I77vizvc"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so50965a91.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790417049; x=1791021849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=os0qPh4HhL9xA5LMr7rZ5FtS+AFAyE+IXe5pNTCIpTE=;
        b=I77vizvc1tWHXz0gCXuxeZBsLT6Csi4a9PPaxsP5pv+I17qT5rQBH8KHyGvsWzban/
         W7gA6z69altW6YzucutTizPTQt8cgHK7f9m7WDxNZDqcH/aCL+nNs3AqGF6BwetmlXm4
         vdNXZyGmnQMxi8jrINrmVY+dnobAOoBrOpSfYNmOGTkNOSqMrS/UyX/3C/RmPiqjzcCX
         gXUfOGfyxrXE2O9afyUf20OxvFQ1SSuQ001fOeMAlo3/5RA3LEJXBE/ePdOAf1AqinvD
         ckVn2FkBhLtRXArQsJqK5DRt2vFxLPiK8TgdBpyFJmWaTJeS0KqD60u88ZKZ2N0vSesw
         IjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790417049; x=1791021849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=os0qPh4HhL9xA5LMr7rZ5FtS+AFAyE+IXe5pNTCIpTE=;
        b=taEq6HF8OsEOPEAB5XYktpEvu9gAjneKMiMR6Gl/kbfRe1/ubnKRMBcMEkmZAPyJL3
         BtiPa4GIe92UX1AUHxy+s6rq+YAbh+Rye3mdEb8wBdIMn+Kato/4uk7ajs8PE+1YBSvn
         rJ6YLXTg9u60M8YBra/5aiJf4o1sxFxRd2aDhV4RuHIn5R0ik5ciThXIDUir2bInkkgJ
         8Ny86lcxh7HqWy//hsjMPx1eOUpNGQIFWMiiw5VMZdqczm3O46l/0oQL/Su5X6a+apkn
         LqoZlRwse/d4QiBpo14qXHSDpNpAwiFcRepltLYvLMQh52NGnaSuxFcwD6/XFvdsaez2
         vDQw==
X-Forwarded-Encrypted: i=1; AKwUvBxvnDfKZfcvM6daUP/ekKqdA0X0Va1dK+GJp87unQJxe/HNWiIKnWARS810SHBfHUknrWOK/sI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJT6m9e2JPt8TyULThg6oSF9mSV0pKfdTTQpy76zXWfX8Wdfye
	QnEtKa6/fR46NRFTWxmIshgdEPsc8N8b9HRlf1o0o23uiOUGnIZJ1Re6
X-Gm-Gg: AYBFou12alyV54i2BpK2KD4peLVZzQ5cQdzC8hzNSAemSmMPxZAJ5IL/70qVVDpjNUV
	9WcCYjM5mnNtiMFy8ceMRcKHsxG7oxi7ubwoHC9aJvxIsLGthUVwZGfov9Hwtw5Z9u84XSL8530
	oosKSSLaHcCdKHusD7aW5iABz8MS1ZA/c4rWfXjzUfBYtqD4snm9V0XMJbCAOSiMaoyeOWvvnY3
	gWqbyPGoCL6F87sIR6bNJK3pc14UVuYEpTK+NDrpw6Q6z0rnx4L4wyAp8e+tg+GifuVUwSeUvr0
	cH3PjdsHv0GS/U0eg2t5jmpcUE9grGkmfcdzFywgk8dAbk8R9Mz7Xm4pfM+fl9BUNOWG65ZUL4F
	VXHXsYGcBWhcmkUp7jEdL8ExJ68ZGySulzwGOZM3Hg+aLtnw/1CH5iP0+UJKVRDx38QgytCbwSg
	aucYmBiPNOfTAc3KCODXN2Xmt7TWXThAiJzJU6WWd2BdMUNf70p4wFbWHf85fCG8svRNo+qJb+/
	J1pcmLCc7O/cf+OSHfea89GeVhDbrpxRXI9hZ0Nf8SK8uc=
X-Received: by 2002:a17:90b:518c:b0:3a0:dbfd:1a1f with SMTP id 98e67ed59e1d1-3a0dbfd269bmr1071394a91.25.1790417044551;
        Sat, 26 Sep 2026 03:04:04 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c719f86fsm6730826a91.7.2026.09.26.03.04.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 03:04:04 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net v3 0/2] sctp: re-point retained control chunks on association migration
Date: Sat, 26 Sep 2026 18:03:56 +0800
Message-ID: <20260926100359.78731-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 includes David Lee's shared-key fix [1] without code changes, so
the control-chunk fix in patch 2 can be applied with its prerequisite.

Since v2 [2], patch 2 calls cb() directly for control chunks, as Xin
suggested, and keeps the existing DATA checks.

[1] https://lore.kernel.org/netdev/20260731120558.558957-1-david.lee@trailofbits.com/
[2] https://lore.kernel.org/netdev/20260804113705.45754-1-juny24602@gmail.com/

David Lee (1):
  sctp: hold shkey across socket migration

Jun Yang (1):
  sctp: re-point retained control chunks on association migration

 include/net/sctp/sm.h    |  1 +
 net/sctp/sm_make_chunk.c |  2 +-
 net/sctp/socket.c        | 41 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 6 deletions(-)

base-commit: a644f09b2090ad22a13fbcf9d141084f573108ef
