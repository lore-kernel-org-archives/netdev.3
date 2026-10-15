Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C83E008F
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079040; cv=none; b=Ba64R3ysND22MQ0Q4O7ctYGuL6+EsJdx2EvKPLXxh7OsIWTKZWGsamsVDxa5wWEg70S33Clz4rp3uTwRLsAA03q7atAW8cSD+BSPkFtNGiOlYIt1utiS0RZwwm02JkGeSO94nzRvEEWGY+QhYdUpQeFcMsCPBNj3ul3H1xwIwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079040; c=relaxed/simple;
	bh=G6IWS1Zxi1tU+lwJpiMqXpVXB0OLHXCMig/G7veIfHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnoxPMdngqb+WzkDDzsfqLG+kPhHa8itIxYU9pmG7x2xNiH/B0Yeant6ahZYBbELQ/Tk4rae2Dw2PQj4CVL2oApKEaA25s/DEHQfaWPiTzc2tz0NSspwsBT4TzwqWQSlphVgK6UJebjI4hGS4MdnybBGnIB5fDO1UyRknZ1XBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw2tzLCS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw2tzLCS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so46410805e9.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792079019; x=1792683819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqgpHM/R08a+17QdyNzhk9UD0dnMaaklUgdhuosg/ak=;
        b=dw2tzLCSwauATYHaAFqvl8JCUygKGjre18m4SwVFozmqCi+G/8NVxPnzs1holXT+oM
         iK0zFS2uqpFNx414AfItDKQl4ZT3dHTqIoihu4PF7jJ0DahrUoDswiIbZKglTJdipH5v
         2OC3+LUEZQWsXmM3W7NIeAE46S9gqceRddKE1Mgh8Nhk9aMySMFLxh/nPp7vxMYM/zkt
         IxoMxMypnSNK6xA0gE1mQ3nSnbxg1/zE1EKLclzVWJ4CxzghTUMvcalx/SSd6bq1tCdL
         zK5+oftiEdycGbaFtvBRhtGPCvOMI33P5yQoeVHTnodVSLKgwpX1/r7NX2Xvo3/sVPfj
         mKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792079019; x=1792683819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqgpHM/R08a+17QdyNzhk9UD0dnMaaklUgdhuosg/ak=;
        b=b1i/rb1JlDR0qKsC5DDtkQLgbg4iI2fvs+jXHcFD0sdIIXRPCe94ZL98pHNzZrim8I
         jbcPihqd3L0uuwjUtSJT9HIzCPFCW9smh404t3UBQAacgsMQG/AdQ7kaJWVJIpSwKAZ7
         jg4vQaZYvh/nehTD9R43EdntbuL7pN7bhyDIjFapswdk2lMa33D6H8vp0bwD2LeRvAGX
         zeZo3pcMbgfkBcpTC8ZV0iRA5eYs/IyfSU7qxVvzXbhzAi9RDzTUbE93sk9II240mKDg
         +xmWjGS5xqJlJtm9kZ6JeNce6aPAb/ylHjPoiA1etWHVfFaeBPZR1bubGYb408zelbNq
         JYkA==
X-Gm-Message-State: AFq9FYIIN2slEp2I3qHtfEZnrLdbqjcamkI4BtoX/RGXcdCOS7XWLCzI
	Yj6E3w7qn0q6TdDZJSDvNVzy8zIZe1RFndP8jV1MqeBsd7ckDqy4O8VW9qfd/A==
X-Gm-Gg: AYBFou2g++iodRf+V+o5vsQ5dvWrpFw6YMPIHxT9mer4QT2wcxGoGntT1rENAxGXo0M
	t+ursOZOcczfQIlKqbcxfyN26i+vJYzDipHWwQwQeBR5giEQOQVurmc6UX0XoKvMed1U2eONw8s
	7XSKYkasakS56x3M85r7gFCid6EIcpWFb9GhpVB7motdNWAotkdo+lDy9XJKSdqNYMh/nlcVXxT
	9oqVRS3c7hqwHfgszlSyCkEyrs05Cx20D/5RBNGR12fu/jwHAYpB6oGZhSVGZeaiYM04K1++Zh2
	MEF17oAJz+jk28Uk3Fe8vt+AZNfQDqPoBjkGudEyhyc1RWuGCy8gWOvPval2XzGlTUlV+JoRKTn
	hRMqeD2laHYsQGeJ5CiDfghitKjbbq7G9hJ4wzRg5yZIN8hSq9W4IHprUgYnHboZuto2iSoROl+
	flBnY/Ai+IuD75GN11fR8RuiioGs4SMp8vl7a0tO4tZ3o78Q8Y0i3Z+gjR5fkZswlhWTLpPRQw4
	YSEQRy1qPFrqeo58i9vFPCecabjcRP0d4d48C2SyqHc7T6I5IezW3X3GvE=
X-Received: by 2002:a05:600c:8a09:20b0:4a1:9687:bbd4 with SMTP id 5b1f17b1804b1-4a19687bdcamr244753945e9.31.1792079018628;
        Thu, 15 Oct 2026 08:43:38 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd640be0sm61940825e9.1.2026.10.15.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:43:38 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/2] vsock: SO_INQ for stream sockets
Date: Thu, 15 Oct 2026 16:43:32 +0100
Message-ID: <20261015154334.3217358-1-devnexen@gmail.com>
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
current packet only. Accepted sockets inherit the flag from the
listener, and the sockmap receive path does not report it.

Tested over loopback with vsock_test and vsock_uring_test.

v2:
 - move the SOL_SOCKET options to vsock_sol_socket_setsockopt(),
   with vsock_custom_sockopt() and a switch on optname (Stefano)
 - accepted sockets inherit SO_INQ from the listener, as TCP_INQ
   does (Stefano)
 - use || instead of | in recvmsg (Stefano)
 - test: check MSG_CTRUNC and the SCM_INQ cmsg length (Stefano)
 - test: cover inheritance by accepted sockets

v1: https://lore.kernel.org/netdev/20261012235524.41468-1-devnexen@gmail.com/

[1] https://lore.kernel.org/netdev/20260923184008.153541-1-devnexen@gmail.com/

David Carlier (2):
  vsock: support SO_INQ on stream sockets
  vsock/test: cover SO_INQ

 include/net/af_vsock.h           |   1 +
 net/vmw_vsock/af_vsock.c         | 111 ++++++++----
 tools/testing/vsock/vsock_test.c | 279 +++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+), 28 deletions(-)


base-commit: a4057f51efc2b74ddf46721e83f45e9efb13649d
-- 
2.55.0

