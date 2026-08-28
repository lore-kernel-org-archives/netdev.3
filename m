Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DE3B9D96
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894979; cv=pass; b=gzvW8py08Uxb/HKiP4C48pIiFee9ufiIzN5jhW/JPChQYnxXvl+LC7bH5VqlbLJnZ7fD9TwH6V0yaqBF1EcNLZTzn6Q0lUGANbK+mSTdd0kxNaJ7CC2L1MiYz5cY0f/Gy0Zn1wWsF7GUANqSk0b51gS32FwGRJJMb4xKpM/Rk9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894979; c=relaxed/simple;
	bh=5gQzlDU5Yw/kup+7ZjKy32uHtpa2jry3TclqVwl88kk=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=g79A/CvIKOqZQ0pp8dE3/FyYwBxEaMCpHXi/hA0frYtd0711JfDmh9Bec95ZfDyAmCQAXKpOcrOnZB9HfYokWrNwTnkLFYmw2Mpi5hiOJyYG5RfyRe3XA/wBIIj6BPHN/ZEAS04qXgq6+AVQZ//PD6PyCbDWpaoLGJi/GI/LyPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=VIChUD1E; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="VIChUD1E"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-382ef647e20so553089a91.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 22:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787894977; cv=none;
        d=google.com; s=arc-20260327;
        b=e3EMdbVhWtPUH0vEvwY7pysGhvl+yOzOnBpfCOuNiDr2ZflXdIeJQjDi6N7jG7UkTb
         KT4hTAroez33wkrq/BN/NZSZqBmI5d3FNZirnFdtfIAG6z6g1xRw6wBwDg3WGN6C2sWt
         B7XylVXkqhSZ1by+M9iM/506hSSXJQDKaPFo6RBynCTuRKFdwDHudc24B81xsnCFI1hN
         G67lj7Vp3RhJ3sFCMyesL+BX2tzBDMeALoL8i7SyfPUFR9kPbSeAecYM+fa8QxgBqdLG
         y2LvwSpmh16b5klVn0/riCHSGna39mUNpf39vnnQFzQrMiGcWvARlatwCu1+otgQ26Nb
         DSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=wySzWZ0oRbL3oNrX9dKVffVxG9TivUEYJv7g/hqtFT8=;
        fh=KQFpgvg+KFBewbz3pf+wyqj9AumR4WbfK0oLrsn0a78=;
        b=A8Q5RERE9I0+JFyGPnr2dmg0s06x9lPGaCoizegiiqIzKY8ejkQXeIaiszn7ij4smu
         zQByvI8/cU8VRGWjF2WbW0h4pTjxOG+nKwjTVLbEpZrppkr6MuhTn2yJ9THOSnRVqE0Q
         R77Oic7lhYPfmZGfTEOCGNlZ5cTe2LwnEdNSt5e4uMjueEZCWtHyz4gwDz7HFHuGtPpq
         MTwGHcYWuIw7j/a7F28GZzoqBo1XLy6odX03QoUANr0Nf8LN4yLM/puHw0Aw6Z0lVtza
         MFNWorDxMOxWhYkMAsFgfVsOJmMoJamfmn/zcPY+QHVgW/2BYgoAuZt2bmVyT6CLQZzn
         msqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787894977; x=1788499777; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wySzWZ0oRbL3oNrX9dKVffVxG9TivUEYJv7g/hqtFT8=;
        b=VIChUD1E9jt8bbVh4hBJVAMRD3Q9RPlSVo+r75ixttslM650FBc8jbPavEOl2MlJrZ
         RfmWKnWSpL2ccdTxB60b5HtBrZKteUjNH8ygmZXIsYKvjH1V1trRDk9EiWL7DYeu6EOJ
         aQ9InqqXPjgLQRZfgSOylTnobKMC8eKTCpDe1acsY+QSy3HLnNFC0viZI8W9iHsZAvUI
         cgjQNKpyl0LmZOaeXuYWt1tjM/TCUOnVQgIGE7sbfjAL8qffoD5bCMoXKpLhz9vwLIvL
         L+ZeqKjpYx9QE3EB7x+pG0oGbpn9K0KHEZVl6xPcEmsbOjVHtR1PgB5rlwMfkA1T3WcI
         3UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787894977; x=1788499777;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wySzWZ0oRbL3oNrX9dKVffVxG9TivUEYJv7g/hqtFT8=;
        b=YoCSMk1IXDom4gUp8vS4BO/kJmmIfGXK+oCe6VhRojca3g6CsWL28Gf4AKKrdZSR7Z
         Jdpmk6HnKcYfzVovzgJR0q6zIaB90CFdlu7kvOFRS946lhsEB04eIeq7LnbpLeUK8uKe
         zyYiYB27AsDke1boEm63XBetOBOj8qRDySkg1ggeaRbZyqn/tt+F3Ij+lk+XUgUnRztt
         tPfLmUKVuFlxAl5bVPkIG09Wob0NQV/WfE1j7uNKVmmxbz+PxdMC6cuqGpksH4P6aHHJ
         K1MaIYkALTABEmY936OKfLa5oYRFpNBY6TckUbooeO586aKtmKumNekjTOAnwK4/som+
         vvtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6ModskfXVAlkbRmUHUO33cdMye3tVvtlKWT9Czsyw3S4ovpJjEpKvkhuu3CA+JrBDaRfqNA4=@vger.kernel.org
X-Gm-Message-State: AFuF++n+rzt94ondWtixMleSfLMk0+A6Gx3SpfLPiywVRH0nknohZ0kU
	C0x1gI1OrMnouZXpkRUo2zQSku7GhKwY2ooT1iHABuGNdYh7ast3VKpImdngIus425HX41gQL/d
	/JVvSDCu/KDBzAQRucpemL6M60g9k9z43pBaqXftT
X-Gm-Gg: AR+sD10EP2w2F0408SzZq3ijLPtoSLxAQRftCLk2I1oj9fTOVY6/Hi/IhbJSfeqdto8
	YkiCqleYJx9LlV1RUMSNar3MA0/e3k2425ToB/8yhNO/b5fHfAfQDzIdhSM48hA5L2odGX5XqPb
	vTR1cKrfOJHDnKqhg75Dkjeu/m4RdfOZKnEcTDmWj22nRqNguO9ZBIpbsIVcJYgeytTFrZc9/sT
	GIN7oamDEhasc2KWkU8mFUx/3lJoCWH5whVnbDYk7czY1PcyPXEyCTRcsgIfl0xAvxa3GKYFO6K
	BD1BewxVYmA1Lq9BhVCjAsGxon/dtcL4HECzY+R0b8D/BAf3jS3Q+JZYE1D9fSvaHjRl9/Qwx9z
	Dz2y6AlGkhEt8qSMYUOJDs5hp7oVjTvryeJf0QpP51ZA=
X-Received: by 2002:a17:90b:5443:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-396d0d4cf4emr9102094a91.1.1787894976530; Thu, 27 Aug 2026
 22:29:36 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:29:36 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:29:36 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:29:36 -0700
X-Gm-Features: AcwNN1VO63bjkd2n_6mccACQVNrK0RX-U_09RMsQQJ0CGRGMOkLHVtgRLdncZrw
Message-ID: <CA+0ovChAkaCGmDrkaAzfrmpccDXVampiV9OmjLKwDgkYXThvGg@mail.gmail.com>
Subject: [BUG] _phy_state_machine / phy_stop -- a USB PHY that reports an MDIO
 error to phylib panics a panic_on_warn kernel
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/146-phylib-phy_error-warn_on-mdio-error/

  smsc95xx 6-1:1.0 eth0: Error reading MII_ACCESS
  smsc95xx 6-1:1.0 eth0: smsc95xx_mdio_read: MII is busy
  _phy_start_aneg+0x0/0x480: returned: -32
  WARNING: drivers/net/phy/phy.c:1352 at phy_error_precise
drivers/net/phy/phy.c:1352 [inline], CPU#0: kworker/0:3/5063
  WARNING: drivers/net/phy/phy.c:1352 at
_phy_state_machine+0x667/0xf20 drivers/net/phy/phy.c:1613, CPU#0:
kworker/0:3/5063
  Modules linked in:
  CPU: 0 UID: 0 PID: 5063 Comm: kworker/0:3 Not tainted 7.1.0-rc5 #1
PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: events_power_efficient phy_state_machine
  RIP: 0010:phy_error_precise drivers/net/phy/phy.c:1352 [inline]
  RIP: 0010:_phy_state_machine+0x66d/0xf20 drivers/net/phy/phy.c:1613
  Call Trace:
   <TASK>
   phy_state_machine+0x2b/0x70 drivers/net/phy/phy.c:1652
   process_one_work kernel/workqueue.c:3314 [inline]
   process_scheduled_works+0x881/0x1170 kernel/workqueue.c:3397
   worker_thread+0x988/0xde0 kernel/workqueue.c:3478
   kthread+0x333/0x420 kernel/kthread.c:436
   ret_from_fork+0x351/0x940 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
