Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682208;
	b=mtjvmaX/GpN1rHLppgIdzhtBRYZwKk5v8swprOaerelBFJACcj+dqXOWXnNH3+u07ktc
	 L9j/8XMIHnc75EmBX2Ot4y5/nj/O05cJ1uu9Qvx1IRjTAQpWnQd9tNi9RfobB34XY3R9P
	 3ipfSCU5bhwKj0kOHV99kEAZSu9SWUjTqYjNS8Hq2WLwt81AANiWwEfxSP8/WNq3fWrI7
	 qUx+byWR9GgEXLaLR7aBwPM/i9wnrFMbX+HtmRGnBoht/04AKr6TJ/yumfUsXoV5vzaMy
	 WTd3FQOMxRNxkIuTv6bo1kHhGBZ4VE7w6Up/InOY0Xk3n7bpJ5ZKyE7vcK4AXnk75DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=xUZNRCeZ9z5gfh4C0SQt/91FcFEsF8PF7oTyP3jiUAE=;
	b=kz5vSZDJI5b8HGEjgWZnB8mRy8ZhNdo24p85Zr+OHdRkKM+V0Lx7gYwZJi/4mUSNxHyq
	 nz5qgwGNtOvqnZ5NxJreAbCmbai1Dtdx/yB9mJ0qUvdGHb/I6LwGD+6VZpIsUzMYxwd0U
	 g/FMajQP9fN4AHCRdfrWZ4fabe7Mj+aeK/bJfgnNSEwfG0faPgwtS2hOV0zsb0z7O0H2K
	 vyfRerWxEet2yzfz2ziXL7T9+iHF5qh8Bt+OwxcYM0BYBmznfiDBpoG0FP4GO/iF9A5mb
	 vn3W53/bNEHJEidWzX1YF+oWdrnfPP+eGzNYOZY8vrYlpmF/3RPlQH48NFou+RxUZKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PQNQg77c;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917E606ACF3
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A917E606ACF3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PQNQg77c
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6d290b10a35so882293eaf.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682206; x=1793287006; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xUZNRCeZ9z5gfh4C0SQt/91FcFEsF8PF7oTyP3jiUAE=;
        b=PQNQg77c9YG3sMVbs/CRq0dD0jdqBK16WUU/HsZLvNRmD61ES2q5Gq7LW9qCfkXlV5
         X6b2DjRZxuGdiriIhuEKnr7aSeVz41KF1PzdNamzm2BE901YBOl9tE2ooIcKGQteDybK
         KhbfsOTlAIQjCUV8SOBe0l3TmnMyLkfva4pk1fTo9jKhSgRR3UXjdMKgk+X6HZMYoql9
         sosC7O5QaEd7hQK9rAO4AP425tqoMxzI28lFLGLNBcMyUmbBWM4rE+4Ik0h9vsUxWlCn
         69adrX1U02e2t9gzo/dHFpIJqnn0Tzbt8A7K4VCvdNWRfY2N2yL2CQ2cc9bq7LsFTRJP
         A2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682206; x=1793287006;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xUZNRCeZ9z5gfh4C0SQt/91FcFEsF8PF7oTyP3jiUAE=;
        b=jbpwg3EieOlU3J/VLgiQNaIkeDT4Dg0RAy2kDIeGFt1aTiEsw/8RAkaSMurOKJuJj6
         kcamSns1NSz4aJAe7nKcdYSdhRZY3aqBBhVGMHD6Gl6O3ktEigAdbCdNIwTKP1DsohIv
         IgKF/kCElYr+YUrVPVtYIZ0OSY0ziL97/ZKn1wt9AFsBDxIx3jZOeRGbGdeC9uYsIhlV
         i7YazMAOSDZQjTUnAAH+ByUMDs/OC0Jh10zB+M+VN7K9h3WGF6uyQEHBq6xRvW7lp5LX
         in31+3/Y6uxKeOjdITJmWF4OaptmzdhoQZDZWsuJYar/LVJO0ox44t79ZsmPb89K6+V5
         jVYg==
X-Gm-Message-State: AFq9FYJVDZSAt4NDemQ1OFXWqsXoMKg+7NzSCVlaDAlI6z3jcEm4hfbY
	ujmXmIgbWNTmrbzO1xzC3xo9rhDP59zDdJGzOEf6M4yyurTjZ4ay5BMD
X-Gm-Gg: AYBFou1dw+2WqBIdMW2DMzwhvd26nFSAtLsLX9bTpMs9ndwhQVnPgk7afquRLyA1rpe
	cSTzFEQy/eGpWym4625Eu3S07KRheKVEpNa4GVRdtJMnFKlA9QOPssxKuvXieTzsXgllsCPk2Ci
	dRqpYpzkZlRNiP16khal67gFVK8ZGSW5PQ7Dpn8bjCnTkaXkKRgZatSu6o7UXKPmeS1RuQW5Avu
	sCCriYIpQ4fk00mJPhVyIB7uo95MHh6qN3Hs+6MQQ2md8h8JAOvG/yhj6ZHKJyu5V3tU6XG/RvZ
	WRrvbe67rFb+NBx2KDnWhjUjXjB9T5KTCslJeHgN4zXCwdC7I4TJ/8eUPNi5yr5ErDY4NL3EMeT
	GomrqTI1+SV3soVXaxtok5QzmV3UuUEIZ+T/h801z+611Fu0R1QF2DqZhWMEL7sM4LlEaxpaGwn
	mCPeJAkNY4TfvBhLO2QlDx/q8au7MiylzbjupyKNWB6etTPe5O4th13WvyyjZL8JRSBUAPQPJSm
	Ne4ykAWZ0d2fxaK+n/LaLiv03jQFkJar0FM/S4mbfFklSvF0bhqmw/69rB6MsPqma/RFiEviiK7
	XA1PtPbAJIBTANr17TFezF3BfHgFQu1u0BtKXTK5MJZGsxGnfDYoUMhG1LfIZAfH8+LJy3GOTyi
	muTs8cG+8Wb2wAtBI2+/AAtRMY3pAyUzlNZT4for+Pmp3gUqYFZO0FgmDTam0Jiyh7/Ir5ILB6W
	lXStQ=
X-Received: by 2002:a05:6820:2219:b0:6ff:fcf5:40e9 with SMTP id 006d021491bc7-70942610aaemr3372897eaf.70.1792682206527;
        Thu, 22 Oct 2026 08:16:46 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5eb8fc0sm4685631fac.1.2026.10.22.08.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:16:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net v5 0/5] ptp: make virtual clock sampling and teardown
 failure-safe
Date: Thu, 22 Oct 2026 09:16:40 -0600
Message-Id: <20261022-ptp-vclock-sampling-v5-0-06ceace17bac@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Oz2rDMAwG8FcpPtdDsl0T99T3KDs4spya5R9xM
 Bsl7z6Tw+hKt+Mn8f2ku8i8JM7ifLiLhUvKaRprOB0Pgm5+7FimULNQoCw4DXJeZ1mon+hDZj/
 MfRo76UBF1xhoyGlRm/PCMX3u6lWMvIr3OrylvE7L136p4L76Fy0oURJiS2itQ8+XbvCpf6Np2
 L2ifgwEOL02lATZcEAVTEDw8dnQDwbq14auRtDMhr1VkeyzYR6NP/4w1aDW2xipIW5/Gdu2fQM
 rWwO0hwEAAA==
X-Change-ID: 20260930-ptp-vclock-sampling-902f98408c93
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Fix virtual-clock sampling errors, registration rollback and parent
teardown in separate patches. Keep failed PHC reads out of the timecounter
and serialize extended samples with virtual-clock adjustments. Also
preserve the zero sentinel for packets without hardware timestamps.

Retain the existing cyclecounter mask, scaling and conversion windows.
Retry the first failed refresh promptly, then back off consecutive failures
up to the normal refresh interval. Queue the first refresh immediately
after registration. Prolonged sampling gaps remain subject to the existing
half-wrap conversion window and full-wrap sampling limit.

Changes in v5:
- Replace the fixed 10 ms failure retry with per-clock exponential backoff,
  starting at 10 ms and capped at the normal two-second interval. Reset
  the retry state after a successful refresh, following Sashiko's report
  and Paolo Abeni's review.
- Report: https://lore.kernel.org/r/179245576913.3135.17393378308394380121@kernel.org
- Rebase onto current net.
- Link to v4: https://patch.msgid.link/20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com

Changes in v4:
- Retry failed refreshes after 10 ms, keeping the normal two-second
  interval after success.
- Queue the first refresh immediately after registration, while keeping
  counter initialization before publication.
- Clarify the half-wrap conversion window and full-wrap sampling limit.
- Document the zero-input return from ptp_convert_timestamp().
- Add Vadim Fedorenko's Reviewed-by tags to patches 1 and 5.
- Rebase onto current net.
- Link to v3: https://patch.msgid.link/20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com

Changes in v3:
- Split the independent fixes into separate patches, as requested by Paolo.
- Retain the existing timecounter arithmetic and conversion windows; drop
  the full-width rewrite and extended-read anchor updates from v2.
- Propagate registration errors through sysfs, including a failed initial
  PHC sample, and initialize the counter before publishing the clock.
- Preserve absent hardware timestamps instead of converting zero.
- Correct the sysfs teardown rationale and its Fixes tag.
- Rebase onto current net.
- Link to v2: https://patch.msgid.link/20261005-ptp-vclock-sampling-v2-0-8ed12d4d10af@gmail.com

Changes in v2:
- Drain virtual clock sysfs changes before parent unregister walks children.
- Use full-width samples and overflow-safe scaling across long sampling gaps.
- Update the anchor for extended and cross-timestamp reads under the clock lock.
- Link to v1: https://patch.msgid.link/20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com

Assisted-by: Codex:gpt-6-astra
---
James Hilliard (5):
      ptp: drain virtual clock sysfs operations before unregistering children
      ptp: unwind partially completed virtual clock creation
      ptp: vclock: propagate physical clock sampling errors
      ptp: vclock: serialize extended samples with counter updates
      ptp: vclock: preserve missing hardware timestamps

 drivers/ptp/ptp_clock.c          |   5 ++
 drivers/ptp/ptp_private.h        |   5 +-
 drivers/ptp/ptp_sysfs.c          |  18 +++++-
 drivers/ptp/ptp_vclock.c         | 117 ++++++++++++++++++++++++++-------------
 include/linux/ptp_clock_kernel.h |   2 +-
 5 files changed, 104 insertions(+), 43 deletions(-)
---
base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
change-id: 20260930-ptp-vclock-sampling-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

