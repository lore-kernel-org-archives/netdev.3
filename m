Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C34F7986
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417599; cv=none; b=mVkl8WX7kJt6rUgLD2qcffYNqapOiowpCPlEgzE9934pjgj1B5+HcnrUulO9/bHGLFhHpit4ZIdeJBGLCu96+LtqDMJKagMwdUoskZb34yOqQ40ri3Q90js0rB2xecIBi5IHxnLpcdvZlAZ0Jt+eMqFlkk1go+857T4mH54I470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417599; c=relaxed/simple;
	bh=E5U0AD/EJZOCCwN8/VqoUxWGGZvlKKM5by9g03EkX2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5AP3DFGU+2FnmXhl0S4Uz+VYiUGBf0UCT3Tc/G4vcl/J5oyxiTOZ/WV7SSbyev+JyaRPLjeUmoVxD9QysdouuefRdajXIRamsmtUGzelkFYXdvoLGTkvBopGzVgLADaegBTyfr/liAQZeCcO3SoVNUQNYWDKhc61Ufk7ZuEXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQy4Su5R; arc=none smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQy4Su5R"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so1970251eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792417597; x=1793022397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcK8fTu+iCNwFArbFhodnL9AHFAK8ZMg+EiBVqb6o90=;
        b=sQy4Su5RbC0d3y+U6boZv7U+ZpYkr0ztVq+BLlE9A0Y6MVhI0nE+CmvQMzFL46DDvc
         2on3opdaKpaaj+lcml8Ge60xArgD++T1kxlglAllv0jOElBdHWmLzqpnh8B//a6DIkyR
         9cZfO/cVXPaxk6gQJfraT4gZBdRnUXgVthT03DOju3XE4CMr6A5MwgQYmlDhk3NKyr1y
         KXuZgpXIMnxlyfOCzNOWuQOIvph4bLZcfYsjXqj9FUMdW1kVzKtMTQMTkBTzMt7sy/9b
         7J1DEQqS5I2JmsWLxcdXIkfgXraFWxggfZ9PfKWFeDv5zBJ+cSlbYN9Esu0fGgRmXv8A
         Kx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417597; x=1793022397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcK8fTu+iCNwFArbFhodnL9AHFAK8ZMg+EiBVqb6o90=;
        b=t3v4ls/esvoA4+FUxvfZULakZGx9CO4P53yQ3mBtXPWJP+F1ksFQgg3XSbeb2rD51L
         LSecdY2FlOHQdnUU8O6D/fgiakslXbRPZc6AfwdbF/nBi/gdTSOtKvUW3+s4xOgsy51H
         Yg3J0D5fw5oHQmZ3TBB2uyfjwcFfY4/eh3CPxHRT+ZwYfgX/f8+nbDOm/hJu0+fguZ2z
         /UOLWs63+fFjBAODCKppGoyE4BGds66t7IxkmvmBW7RIH2fFQFc3soukSepESGyX+XQq
         dpYkG4KSUvOq+1MzVvSYPKETdoF/VWNhC0iBf2m+rnZpICAKvH4mHoFlQ8ZMunuV6BEt
         RUIg==
X-Gm-Message-State: AFq9FYLdz6YbsNgmEFOIPFI3Y//oqcreStGqju0UgSeCG+mp9Mx/TKuD
	JoCekuyoGgQMEOyZ3tyU5MgyEgL7KVzUNzwQUNSIW9KPF8+gqboDap0=
X-Gm-Gg: AYBFou3O7yj6nkYkwXMVN4nJef95EHc7Hby/MqSpzcAHwdyCTMdMx2IEAgYBGf/MaCU
	Q9lJu3xzJxXdiLfz4JIaKVinBEKwT/G8qUNXsymbg1Igu9zGUbUBQb6v6lKT00ohDI5NPzUC62o
	nWOSCxuO2GXCwikQdj2FtSgFej03IYsC/uG3mAWx96tQvk0hGYZ+lZOw7OAovyDhTHEhtKFaeDF
	8b8TRxso8E/asCv571OqW1Ly0Zgg+lrdUoDeTK0nh9Z03nsn+uczEuA1fZ+zG+O0q8qwu56rBrk
	QmWZKvY8h6QanzisbvjOIvykY6dLeCpkmLXzXhEbBekhPq8cm/AUAHmonFD5sCt/1xevNwUKchY
	jN4rPDrfwapAMo6t/v2M0IRuct8ywO/lnO6KB2lUJIqeTnwPQxqBAW6CpWo0dzLYuWjflHEnTyq
	+CBQnPdolRbnO6dEuD8Z9XplnW7EuMCEsyfNh93fuhNiCjLiiOFQPQgEoG6B/RoEQPmByTmvt36
	nMQ
X-Received: by 2002:a05:693c:834d:b0:35c:de00:93d3 with SMTP id 5a478bee46e88-361a2c3503amr10589246eec.40.1792417596679;
        Mon, 19 Oct 2026 06:46:36 -0700 (PDT)
Received: from localhost ([2a09:bac5:3b20:16aa::242:77])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360819be413sm32661349eec.13.2026.10.19.06.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:46:36 -0700 (PDT)
From: Murali Krishna <muralikrishna2444b@gmail.com>
To: mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Murali Krishna <muralikrishna2444b@gmail.com>
Subject: net/qrtr: would selftests for AF_QIPCRTR be useful?
Date: Mon, 19 Oct 2026 19:14:48 +0530
Message-ID: <20261019134605.40645-1-muralikrishna2444b@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mani,

I am fairly new to kernel development and have been reading net/qrtr to
learn my way around it. I noticed that there are no selftests for the
QRTR socket family anywhere under tools/testing/selftests, while
Documentation/process/maintainer-netdev.rst asks that series come with
tests under tools/testing/selftests/net.

Since AF_QIPCRTR and CONFIG_QRTR_TUN both work on a plain x86_64 machine
with no Qualcomm hardware, I tried writing some, to see whether the idea
holds up. I have a tools/testing/selftests/net/qrtr/ directory with two
programs, modelled on tools/testing/selftests/net/af_unix/:

  qrtr_sock      12 tests for the socket contract -- the ephemeral port
                 range and the CAP_NET_ADMIN boundary described above
                 qrtr_port_assign(), the bind() rule that an address must
                 name the socket's own node, rebinding, EADDRINUSE,
                 auto-bind on send, and local datagram delivery including
                 the source address seen by the receiver.

  qrtr_endpoint  12 tests for frame validation in qrtr_endpoint_post(),
                 by writing crafted frames to /dev/qrtr-tun: length
                 alignment, unknown versions, headers truncated below the
                 v1 and v2 minimums, bad declared sizes, control payloads
                 too small for a struct qrtr_ctrl_pkt, control types sent
                 to an ordinary port, and the legacy control port number.
                 Each frame is malformed in exactly one way, so a failure
                 names the check that regressed.

It is about 590 lines. All 24 tests pass on current net-next, and both
programs skip cleanly when CONFIG_QRTR or /dev/qrtr-tun is unavailable,
so they are harmless on non-Qualcomm configurations.

Writing them corrected two things I had assumed wrongly, which is partly
why I think they may be worth having: that bind() accepts sq_node == 0 as
"any node" (it does not, it requires the socket's own node), and that
rebinding an already bound socket fails (it does not, the socket moves
and releases the old port).

My question before I take this any further: is a test-only series wanted
for net/qrtr at all? The netdev documentation describes selftests as
travelling with a code change, and I could not tell whether a standalone
one is welcome or just churn. If you would rather tests arrived only
alongside functional patches, I am happy to drop this.

If you do think it is useful, would you be willing to look at it? I can
post it as an RFC whenever that suits -- I have not sent a patch now
because net-next is closed.

I should be clear about the limits: it is built and run on x86_64 only,
with no Qualcomm hardware, so nothing beyond the tun endpoint and the
local node is covered, and I have not tried to test the SMD or MHI
transports.

I should also say that I wrote these with the help of an LLM coding
assistant, and a posted patch would carry an Assisted-by tag as
Documentation/process/coding-assistants.rst describes. I have read and
run every test myself and can explain what each one checks and why; I am
not looking to send anything I do not understand.

Thanks for your time,
Murali Krishna
