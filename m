Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A23BED42
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849332; cv=none; b=GmSIRDpRnieQ0oo7pVbdm4NkbeUQ4HgIjOKBvXwxHJSSgWGC7g9SvLIDJAF908tHd8bT7QXSD3xYvkKG5A7xJXFatBult+HO3OcYhENtzVhlYq7IYfvYdKmlOgEOdWTAtj1UqnCo7dFsjm18i82DaUcGGcCqZZTj+GrdzL1xwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849332; c=relaxed/simple;
	bh=1w1F988jNPgirGYn7lWZqWgUsbQey03z212sKRJwP10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ihe+Zu7ljTU20LJPtpgmtUCoF3GZ2sjurboOzwyCMdP7GDly2jwZox+BeD6nFsZhqEjKHCtcb/xN1td4mW14eM4alYw0PAKAq1pcKuesnAocwQpeGeETg40fYS/CJ7zjJMZuTC7iXZNQeBfR3jMLgq6mZ6Efn1hWuaajNxTOWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XckFBGxi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XckFBGxi"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c411d6615so1654349f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791849330; x=1792454130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/evjTB7G1IHnw2ZoU85Mql0h2mL/HYgEXMQE1oqOuN0=;
        b=XckFBGxic3rN23q5lYFNzH4V1bj9+xn7Gjkz0C1xc7hRqA8IWWxpGZgr7fIh6DpOR0
         FJBZiI+BLgoM4GTLtYBAY08CYuXkxRe30WM0jRysriQ3DCnlnDh/QD0VRyap4Zu+iv74
         kQIPFLNeCgg9qFHSHgJjBhPhqtwFR5a8Or7QF8Pk5dCYf2qd+lOF4WnWaxJ/EeucfgWy
         eThgyYAdOScTyv8tyZ1g4E1Cuoe72j8GuX+emCxssFeDxNy+8zNFGSYVu0p7pEP47oZ1
         y3PxN6Uezxv6VIfNJ8lIMVurppu+CpiQ8vO2CQA30M7GfC6ZsgjmhlDhBsG5YhCJrSIM
         uIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849330; x=1792454130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/evjTB7G1IHnw2ZoU85Mql0h2mL/HYgEXMQE1oqOuN0=;
        b=vX1GA1KXEIEzMXWIhBwIqM0AirWep8VK9tvEZKJb/WXV6PAByEOhWjPj7kxuzLLLt6
         RfvPWneco5d9sTg3kS+cW7Df1eJC452qoRsHEHQOSTruVcIZPSGRoA9h8EcmW/7/n0DS
         hzMAecEVRoKFoN9SuI0ZHkC/Gj+upwpxu08ldpCHM2Z9/XYSE3ST6YfUxwS3gPYY+T61
         px/DvmOGURkQQGRNcmSUNsUZw/OVuYa1Kf72PBkfoNatYyy4LJfpUuQeTudRjZ8PSh1/
         M+2dIgp6l89LRw3wYte3N2xnMRSP2faht7MylVJGOfAmxPMsSdoIiFzbz1E2OwrTjoo3
         2C0w==
X-Gm-Message-State: AFq9FYIe3R6p3PxB7uLAiJvQHUeIAnVXlNKr9Ujv+nhohMskFQSVX4jj
	81uRrA2mo0cq755yCbSxLAonHKMN8diyg43vct2vTirNqPdU1TbPgq1gIWa3ow==
X-Gm-Gg: AYBFou3l+nRup5B3CyUiEKdYXbq4xesyt0Kks9+DubMNw8xLBFiq189f/S3foKSSavG
	ieEfzxGfAhus4mScMcMVxrDDSMr9C+fxzevlIbur332IyIrdDOxfAQFckZYQ/57FquSGHkzUJnb
	ILJepkupo/I1ncqyzgHAI4UYgv3j3ZHtx12uweewRVKCNagxyGvcQ2jLXMGBWkXHZEU/QzOx0is
	xB1lxJlbXaKOnbnhXUDZkeliq1H8dKmnANAmiyytIwqhjvobR6y8WwDMQo0ev39QXM8StWK0HPf
	a/NsQFEAtTsCmKQhRNi0cw2CPd0ndn0DxRY+NPrOSPl8LlkmcH/Hlid4QY/9sT3HeEcKU+5imt1
	RB/rvrPMuyOM7avSugfC6NZBjCfHHt0AIdhfnDlMFTnO1eAgMeD2i/GBev/9J84vTnuoQX55nm1
	S9UZHlQ8ZMQIYtp2llcza/XOa6OFaRlRoG91N40XkYwpXR+Djnjck3Dfi1EzAOQNFVNYBgqhZ9T
	eskI4uU8N3ixo4QvZK4DWk/h47IELOvZ8flYi9M0r77H09pZSzd/NNRxr0=
X-Received: by 2002:a5d:6b92:0:b0:48c:8126:a266 with SMTP id ffacd0b85a97d-48dbace9838mr16800523f8f.34.1791849329200;
        Mon, 12 Oct 2026 16:55:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm1933762f8f.3.2026.10.12.16.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 16:55:27 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 0/2] vsock: SO_INQ for stream sockets
Date: Tue, 13 Oct 2026 00:55:22 +0100
Message-ID: <20261012235524.41468-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the follow-up announced in the receive queue hint series [1]:
SO_INQ and SCM_INQ for AF_VSOCK stream sockets, as AF_UNIX has.

The value is the one SIOCINQ returns, so on Hyper-V it covers the
current packet only. The flag is per socket, is not inherited by
accepted sockets, and the sockmap receive path does not report it.

Tested over loopback with vsock_test and vsock_uring_test.

[1] https://lore.kernel.org/netdev/20260923184008.153541-1-devnexen@gmail.com/

David Carlier (2):
  vsock: support SO_INQ on stream sockets
  vsock/test: cover SO_INQ

 include/net/af_vsock.h           |   1 +
 net/vmw_vsock/af_vsock.c         |  41 +++++--
 tools/testing/vsock/vsock_test.c | 191 +++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+), 9 deletions(-)


base-commit: a4057f51efc2b74ddf46721e83f45e9efb13649d
-- 
2.55.0

