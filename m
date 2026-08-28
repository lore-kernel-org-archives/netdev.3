Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3938B7B0
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886962; cv=pass; b=c+ZUiWWpdPXHKCWQHeq+thN4iCfPapbFSntHthMAXHXxr1yiRm0lYVWjDz+E/Lx7hadQN03KXBlvGelmk+5vqIu98B/6qU4mOu07ieo9KAtYD+X/pq62lLefTU3v4A5ONPKozN3haYYSFn1h/256jIDxnNbP3dw9EVUXvq0SA24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886962; c=relaxed/simple;
	bh=1miJQ3XU67QGxzaMp89AvZFl+Okgcn5d5LRthW/MVn0=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=IE85dotzIqR3ifEZtMkDpp4gYrSAEY89635IXegGKzSMjBXLnLaICX2Ci12hFOvvL3CtOHxd0D3jlZppOkL5LXEv9SQzmH49C+6WNLxKdxRxyBFZjK2ZVrc5mfaBcbHhgxpx9dTJsW9L5FEe0l3L5bvuU5grTzJbkO8vMsghepc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=neBLinKC; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="neBLinKC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6f9e2f681so3100025ad.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787886946; cv=none;
        d=google.com; s=arc-20260327;
        b=IUVzxermPd/yHZFcwUF+ywoO+7S8HR4pp/AVIdpqGV39k4AgiDQDtBqP1yVWns0qo+
         2rNFeb35OUIKftidvF4KxOeoMwe7OQldhJWNo+x6/4yzk+7kxDYDgJpEi+/doa5SVvdD
         glUR/AD/7vGHRfi6lHs9lisFdwk36PA33ZcLBJG8ICb4k3ffaJiVQhNgHE1w1NE3YpFB
         b9PhFROt1Cg96Mjqalo8dyM3+RDcxwnbiG4i7to/JW6KrNBk0Q7iMpGvTCJ4R3XxRXCN
         xBUCW+vzpE7zXCKZ8SHYYEtg/zdjEv9O08TVZKI8oc5m46S8EbMwAvHu8ScO+QbLaB+N
         7z1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=GVDaim1d9W/nazmbFLIR9MFq39kGfUIj6rnd22ExSQs=;
        fh=ivEx1M8FfEkXOcbXnk56V/AjZI66gnzK6WT98XzUEME=;
        b=pGtb6hxQIlPws8GOTrIWu+6mt2TjSVoRqBvp9819oZNLesRl/0n6ijlekBwxMb7RTI
         uv/JlwMslAUw97knBb+szUgDPFcLnTVD05GAH/rtGle4lKsURJOheMiikU+a40+uES81
         mu0ImSTRrlUoTVE15r4d/54pc30nuxkLCjETQQc622k2cE1hrGNklLywoZAuhiK+PD3s
         LpTjo8do4pcoeJK4APYcxbIHW9MXqYFNoH/VWTcKag1lOukG/PQqLrs85+5LGN4eeaxa
         Zk4KqWAoWt2IZI+yImRLv76goeFsXBOAyBN5rMLAK+jcdtLCGRUl5CJpKGFuLzojtlAB
         ekiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787886946; x=1788491746; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVDaim1d9W/nazmbFLIR9MFq39kGfUIj6rnd22ExSQs=;
        b=neBLinKCAT+MANInucguTZWim03AHHpj+bO5hrp1IvLBqrDqUNUFIi3HnOaTacaN0A
         BSzXklUQ4ZkMuoCQMMC1lMD6Z9kUCHgKc42RAoR5TFpM1yoO7fcRWDUrNPjBVTM6DZgS
         f9pR736ovN7AgX4QHJLr/jIy/9n3RuQMjXyoBiC0FAfBQ4XDeHTPVwFpKTfJZm9Uhmyl
         oSZSmRPMDpfNEx+H81fNBdQJlHL6B6x4qrzwEziyIcS3ATYAE0coIpFpwVV1vQaCoQGy
         VWPdTrA5jhiBIyYE7+jTp+yJZKCVNcByX+LTUgxVRmyjjNtdtjNwNNEi9gNioNv1otMp
         5d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787886946; x=1788491746;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GVDaim1d9W/nazmbFLIR9MFq39kGfUIj6rnd22ExSQs=;
        b=XmYn4yXW7tDf/VeLwFwvuF1C31MAkPvbDVdJhgCPVlCVPwZWrzp+klGlIy7qjM6ukZ
         VBMBwDDMf0m60xiS3GE+hIDofg4VLSjOckl5ahpHxPmFVUtzAR5wqB6bDP2uAOAFiijz
         kN+IywrbrjOwnOIajiKXR2JLSqNUzMxJwSGiQaQQW2ShT4hrI0yTCW0wa+jl9a3FcF9g
         dyWTAn90gmnOGS+6irYh6qR3/G61Y6jl4Ed2lj0Rfvzj0HN9HAty2sdt4i8sTGIMAwHv
         mpnFks/467lGyFBHsATWjGcmo/Ue34r56AXIuPlM0GAl/4mOIuCkmGuD9IcM7AnNvNvc
         zt2w==
X-Forwarded-Encrypted: i=1; AHgh+RoKoXXfU6/jaAm83MeOEIpl7p4A19P/qyPDgKr9bYpZW2GxquJK9yYICC+QT6dxHFTYR35kNR8=@vger.kernel.org
X-Gm-Message-State: AFuF++ljt708B9jNlwQPrq/ikZN7QToXDFNWhwkNdEdf7erxteXZaN/U
	xDhFfjQdrf9pJCm3ZJXc4L/j5iBd0THHKxsVDgd8J5do5lAcLbvu7RYCrDMBge2s8VjVvy1bdnq
	Bxs35M18NnfDV3dm58wxCIz4FXBiSn60LtRywqGpH
X-Gm-Gg: AR+sD1086nXfRrUm7T7yi9zg7IDhodzhfzfXeWV5/M8FEkrtxtFwTl27nfI28o2SopF
	w/01EsvWPe02s/FFfQxBIUgZk2P9c/LZi6rHg/GpwFYN/QpRDeQHteB/nIZoZomzgaKR4DSq+On
	6DzcP46TUSRVk4KuMAOQhBCe35rE7bd3AMMEg6vrKhh9QedkNYAFngriSt1nfeFBt/SX5IlbX7y
	TYG5Xrcg41Rz5OHoc+cH7efBSh6/Bu3E1/hHqMul1u0vxiOHrVoeaJEIK/1gCa5ETubVEBBskvP
	DzyRqmieL3HZIsZLC1LUVvKNESS4fVqZIQgD1+5isubGlEz5DA1su30S9KS4FbUwpJS6up5Suw3
	1S1fy8jTEq66Luny8WFaUsroTIoUeKw7c
X-Received: by 2002:a17:903:8cc:b0:2d1:1a18:4d0a with SMTP id
 d9443c01a7336-2d74ddc4043mr72395145ad.9.1787886945097; Thu, 27 Aug 2026
 20:15:45 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 03:15:44 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 03:15:44 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 03:15:44 +0000
X-Gm-Features: AcwNN1XK4N9AZ5nSdtzZJJ7gOvoMbccpDuyxz4tcgDKwL6eXRIcA7BljFOFKVRY
Message-ID: <CA+0ovCjbbonrZ-eWsjT6r7VhBaO7t8M_HCYwWzU5XJDettsd8w@mail.gmail.com>
Subject: [BUG] can: kvaser_usb: WARN_ON(!dev->cfg) in kvaser_usb_probe() from
 an unhandled clock-frequency encoding
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/123-can-kvaser-warn-null-dev-cfg-kvaser_usb_probe/

  WARNING: drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c:989
           at kvaser_usb_probe+0x14a9/0x15e0

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
