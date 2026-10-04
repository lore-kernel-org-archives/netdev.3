Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D863FFFB3
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087198; cv=none; b=kpQ273zRRezEcnXDH4XU0MjuBoxt0nLAdxdM4KdpfppGzSlQa6sHgh3GPbYfp0c8h3vwK845MifQNH+3X5V7lru+AyY/k8fKfxdEX9n9KoYod3dRWSgFcHyxgGnHtCVbBopj75mnqUduPscty5hjZb5WwPGkgC7O7m1mFckuDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087198; c=relaxed/simple;
	bh=FqQ/IuOHKIqC7d6Pwir1eelXkSlwk9OJG87QIJC610Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZ147RMv4x0gxWD+Wp4f0PgmGZUlOIiyQhyGAx0uYNxXkIerdAgQiH5Fd8UJ6fyECWqJWDm8cy/cnEKhui9EX9UwsFQHmXwWptFTIotVsqSDLxy6SsEqMXBjmmC30L8oXSTtZzbN4Vgpb1h4ZZpvYcjT/aTYjZ1kIgkoer0uNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/gSWb7Z; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/gSWb7Z"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35125d5e9ccso75593eec.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 21:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087194; x=1791691994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o06QRhU6XAKybPqQQLYE3nZ539hXW0JwrsMXBpOaGMY=;
        b=T/gSWb7Z9qQV9IhGvVnpCtn1D2wn7KIWeb5xV879id/rsoSU7ayNm8kVwKQEW1EZqT
         aaoZr/T87vVqiBNgXHhnKkgZ2B9+FTxr/u4RjHh6MwqdGvsMY+Rp13KO/Yt7YOy5/KQ3
         SxiqcIllNSRRJufr6HnMcvPYcymBfmUoXAmy3tA0y+9tcWvUOy5/je8NWhRHfNWVNVgs
         TsAU+SWZQNpIrb9Ipd+a8Z3oMcsj85umG/LQBaXmlFDWrkCxYp49WOzbSmE9u2Uu1+lb
         NhycT/Tp6aqEItwysQkmf4aF3lbK7zJr4BG8epcweLp2sjGOlDKrgPxdatqDRn3MkHkL
         WWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087194; x=1791691994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o06QRhU6XAKybPqQQLYE3nZ539hXW0JwrsMXBpOaGMY=;
        b=T7IEjPicseB3o0p4B3lyIa1+UXuv7b+e6s8q/u05fZN0diFkuzLYhiKdi4OLcDaMDX
         1V7sndc0Io6YVSvM17W2foDlVscyNEv+TnOGuoN5k4ORwLIZ8QVDfqM1lVD3+uw9AZcf
         Vx5z8QE2A7T1l+m43Nt4dzY7aFWgr+BbRQt4c6Of59SXjXv7wmpUNAYhs1UjYKUgPbM3
         m16/VXtaOGyu6vuhycdBl3CnsER3XoS1ijv+g0YmlnyKN9xfX9tv/Abw86CdXKhjP54f
         ghV4yeosc0Py/nqylq4K+/SaD3Ie2nZIHd2TYLkJ5ZXYOkWNh07Vx+XqfPYdBJ+Idpt0
         o5Qw==
X-Gm-Message-State: AFq9FYKIjSEf67HeVAgnF3m1D9YfINJouxlkkWEl7UAxBTQCo5w2LXoH
	h7lDIxoo0G0k7X978YKJt4k29YEnlw/brBULh6UYRHkyxm88xe8ScDPMy6iaHA==
X-Gm-Gg: AYBFou2Mos0aw6B2KPQF+IZC/lMvfj2pLVv9zKcXtEEIcUG0U22KQE+p7MRDxbA4IjQ
	WhEKvMFqVZj7Yfw9BwxxCg/SN3/UCIkB0COHapUgnoftIk+9BTsMuugczS1Fo+JPkuAXTHmB5D1
	8dn2YeLqA0mF9mzaOFQMVoIjwwopQ5ltfFXo9bm/ldbHxF8NmLj2ClrunVBTfUuIwBJnbJLm+Kf
	GpNBl98TqSF4eMiJY2c9xBu3tAam3d6yqgtBwLhepkJ+csTjQsKw4iCbK+Aiwcc0v54DFFTNW6D
	RMrqzVzv+PH67Fj9vk7yxEGd7S8ZGZV13J9U/Xb5N1P2k20DoAHCXBoKzn4JxijUUXqSGSja8oi
	7O7buWy/IZAPPMcAfyCW+NEoNuOnb7t7GMKMAuKc4mEi+tDHpZhMwAkYU3/4kA1BCcCCNlZmzch
	7h5qGtONH3rGp8Iml93HMTFv4WKZDK4MHjnZKsV5VEP4ZlOFd0mr7cIXR8wDweypRnzLGoikb7q
	osWDDM=
X-Received: by 2002:a05:7301:d788:b0:351:d0f:c808 with SMTP id 5a478bee46e88-3510d0fcb46mr6834841eec.6.1791087193555;
        Sat, 03 Oct 2026 21:13:13 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm1366253eec.6.2026.10.03.21.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:13:13 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev
Subject: [PATCH iproute2-next 0/2] bridge: add cfm command
Date: Sun,  4 Oct 2026 04:13:05 +0000
Message-ID: <20261004041307.2683990-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge has had 802.1ag CFM support since 5.11, but iproute2 never
got a command for it. The only userspace for it today is Microchip's out
of tree cfm tool. This series adds "bridge cfm".

Patch 1 imports cfm_bridge.h, which has the domain, direction and
interval enums the CFM attributes use. Patch 2 adds the command and a
man page section.

I tested it on a 7.0 kernel with two bridges joined by a veth pair and
a MEP on each end. CCMs go out at every interval, each side sees the
other as a peer, the TLV values and the RDI bit get through, and
ccm_defect gets set when one side stops sending. I also checked show
config and show status, text and JSON, with more than one MEP and peer
on a bridge.

While testing I found that the kernel sends CCMs from a workqueue, so
with HZ=1000 the 3.3ms interval actually comes out at about 5ms and 1s
at about 1024ms. The man page says the real interval can be longer than
its name.

One thing I wasn't sure about: the MAID is given as a hex string, the
same bytes the kernel stores. The Microchip tool builds it from an MD
name and an MA name. I can add that, but it seemed better as a separate
patch.

Separately, I'm sending a net-next patch so that CFM config changes
send a notification. Right now only status changes do. The two don't
depend on each other.

Abdul Wasey (2):
  uapi: import cfm_bridge.h
  bridge: add cfm command

 bridge/Makefile                 |    2 +-
 bridge/br_common.h              |    1 +
 bridge/bridge.c                 |    3 +-
 bridge/cfm.c                    | 1058 +++++++++++++++++++++++++++++++
 include/uapi/linux/cfm_bridge.h |   64 ++
 man/man8/bridge.8               |  196 +++++-
 6 files changed, 1321 insertions(+), 3 deletions(-)
 create mode 100644 bridge/cfm.c
 create mode 100644 include/uapi/linux/cfm_bridge.h

-- 
2.53.0

