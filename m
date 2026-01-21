Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66F3A35B9
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011543; cv=none; b=TUr/0e6uTrlESVhn89TGNidfluo+t3d7QCzOUtrcql6cv9JUWP6bj0ZZ3g5psSjoKoCbrrN3D3/OmwSF6TzHy2/AyskUwPQyezd/xACzZuRg9LFYCnCgsaIhqTWCPzXJ4zIWfyiriJ01NaDn1XlrjrUpbkA88qYKOFLDbhBAjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011543; c=relaxed/simple;
	bh=wlwTodmtch2dfBV6AIyb8q2tjn/FPjWqWdc1JlVWOrw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xbhpu+7Wc9cwFV/qn8Tl5+/SDfD+s+1/WOsmdv03aGhoyzmRWN1JMYfXA/lkRMKyDj1ms2L7WPYjwHOmfrV31Y8tjGJJgGIJNZMPJcU2/qEnrOFGW+L6TLWWT8+/0+IwVeqc/fd96qC1/3pjmKL01q48d633HoQ5uCTy3Eveuc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X335iacH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X335iacH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-79064868702so81252427b3.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769011541; x=1769616341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V5MinaxyXCHjn3WK1bQbxOSKY2oAp9x1UqjzdL+AycE=;
        b=X335iacHP4QGq/U6NFo/omuzdreUmxSpZkJqTvFaef6DiYUzo1rdukVAtcOmBS2zUk
         IURbd2TXvf/9zBjTejX4F+Worvuo1GZ+n61g2buJY0FptVuOP/RkNimFfbhXlFoYN+s3
         RCvNA4OT8Vg2hQ+EbN/6in5fOrkFJPcZFujVpMBQEon+sBzZFfHoQ+PXghDWLVvA4r5a
         xjFbQbR5Bn2xCBSf6ECr/pFwj9iStMo2DjoqJNnOLRrOyVlFx4jRWFhBWbm5zQW2Noc8
         YrQNVzOozJDKTdG7ZADs8CiJLL3KfpJx+BtP4dZZ24nSky3PRtICZL1p24V5sj4/mf4x
         xXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011541; x=1769616341;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5MinaxyXCHjn3WK1bQbxOSKY2oAp9x1UqjzdL+AycE=;
        b=C9SDh9TASJjnfGkKaHxPkZAVKKe1R71HGHSW22pYgD7p5R1Zczrn0PS3cua1c27SXn
         TZUpaUxX810DLG1Q/IqcNmI+JUw/5lIm3JFiCUVii6fYhNcFP2xGf6tgv0CME3cFNX0E
         lIcnbuIZewI0OUsWOi0hn+SGxmHREUfpkx8tQ06fGM5BmvpLk/68/lNSTrsR2QRwm62N
         wnoEcsZl2ObsmTHzWfJGbnstjIx8lCxHcBJaZNw07IRAxH4GDoy5CjsuXGqWGtJiHOmL
         /rCGeQf1hksmHEeVkgLTEfvQfSlTXENWW7fR+NObAoPSegn1DhkBWrBq8dGzXodo6Q0e
         lmUQ==
X-Gm-Message-State: AOJu0YwQ9BOaff+BzYBvgJ1MlyEXvQnfNrHnEcFUqYQPZZJUx8REWjT3
	amJlu04yyGGg5hLOlhNuaSrEhxlTI75zfRU1x9GufXRLUTpanQkgv3y+//HW+PTwQzpyQw==
X-Received: from ywbiy2.prod.google.com ([2002:a05:690c:4d42:b0:786:4a54:13e4])
 (user=yyd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:e3e6:b0:793:c8be:ea05
 with SMTP id 00721157ae682-793c8beeb09mr135559227b3.18.1769011540654; Wed, 21
 Jan 2026 08:05:40 -0800 (PST)
Date: Wed, 21 Jan 2026 16:04:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121160458.990785-1-yyd@google.com>
Subject: [PATCH net-next v2 0/2] net: extend ndo_get_tstamp and implement in gve
From: Kevin Yang <yyd@google.com>
To: Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Joshua Washington <joshwash@google.com>, Gerhard Engleder <gerhard@engleder-embedded.com>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, yyd@google.com
Content-Type: text/plain; charset="UTF-8"

This series extends ndo_get_tstamp to support other timestamp types
and implements it in the gve driver.

Changes in v2:
- Fixed 32-bit compile issues in gve_ptp.c by using div64_u64 helpers.
- Fixed a div by zero case in gve_hwts_realtime_update.
- Added kdoc for ndo_get_tstamp.

Kevin Yang (2):
  net: extend ndo_get_tstamp for other timestamp types
  gve: implement ndo_get_tstamp

 Documentation/networking/timestamping.rst    |  21 ++++
 drivers/net/ethernet/engleder/tsnep_main.c   |   8 +-
 drivers/net/ethernet/google/gve/gve.h        |   8 ++
 drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   |  27 +++++
 drivers/net/ethernet/google/gve/gve_ptp.c    | 107 ++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_main.c    |   8 +-
 include/linux/netdevice.h                    |  21 ++--
 8 files changed, 188 insertions(+), 16 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

