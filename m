Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038293;
	b=P2CXigLq55pqFIcP+z5lJMS4GMYXW/5S5etDu7piW1hxwYGP0x12SeIHuZOzSUS4AOKF
	 x/eJGaSMsxIrasO7FmeeTVn8aj9W51ymAe5YL21+dTAuaeIc4vxO8ie0myAwOL2OoAvvK
	 sNSYiw4MmtCO/M3tbgso1cgGKigLk8tNfJbjXsOEmyELran5QEFB7KpZ+uyh5sFH0bUHo
	 Vh0C1NOY+eKvsytGGPIhSiSjycynat+sKJMlgF5A/PD6U9M5+4nNLYfoUk7QnI3qoj1rl
	 clLY1yB31KUK0Ve9pI4l9jqCxGt3r0nXHHL5Q48X8vTe/GC5i+RMnc0zYsadSKvS0aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=UMYXIJ45/1/3YPl2iK5WQNFu/t5LdhcHA7vjqVZ0J9I=;
	b=s5hHUWayMAFSlKIUBjd7ttPBCKXcsy4ZOQ1BIHZuNHQMhHlvWda3C1fJ3eCw/wZsYVNF
	 H89OS7lSLfiE+nU7tluhAJ4bcIT/fFSp/jQ1+W0pNQ+jSCZlGoDT631v6AfN7oDkaNo6r
	 CwVqcxPGU1oIiMqcSKvSM3Zsyh6LZy+PInpJSmKE35ONMESK47m1MZDQp8iReVYjfo8oM
	 i8ddxd4QoiQ0+773OqXok67jRtPD+L96zcLQIy89XJWJlS8lB9PQi7/yRjzrSeufVsZU7
	 VF950t42U5TwyTbA8gK+3746gFHb+kHz5dWr5OM9h+/n10hoQUzffShAtZrsAOgq0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gUyQYbMQ;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D0606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 714D0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gUyQYbMQ
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-53ec92375d2so1485576b6e.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793038292; x=1793643092; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UMYXIJ45/1/3YPl2iK5WQNFu/t5LdhcHA7vjqVZ0J9I=;
        b=gUyQYbMQG/6cwFXy3ujd1lb4zciTUS8crwmX8CdmNLcm5zkn3ntK9kvmBjYf7b7Wt6
         BM0PsU52UoB63r3rnNchR5g9Ec7ANDwvuc/Tx+PBhurS5lWeTdEo9PqEMYtI6sy05vyO
         gQGlv7jOcTECwspnDtSM/OK4LQ2DMnOjX4ZIdDhNjcWwcF87pBH0U7ewvRmBOo78Jlll
         QRryCYf2GJWGGsmEmr11aUsplWkNJ85bC6QvZjX8SNmU0HDdnIBliEpSobSCXkdd/Y9k
         AXs7SbMoobvWVshs8WNcflqkUYWkuRDqSR8w587PYqA2hPyY8LM+yLXEccJqbO5seAz6
         TCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038292; x=1793643092;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UMYXIJ45/1/3YPl2iK5WQNFu/t5LdhcHA7vjqVZ0J9I=;
        b=zu8HTRC7e8qc86zMPrevnX+DHaWPQuxsroIJiBN7GS5EF0g4T668qpEt2tyhyDzg0g
         A8+Yce6WMthfGiH1cyrWXKTjugI8fkuQoq4wjGf16LCibE+hCvqLTBNSo5p8qhpYj/YY
         LI5h0rFyVgH5JKGjD2gCOu9xp7kFWtAqowt+0yBhtymIWt8QJhV7sMfKygIFQeu714SQ
         mvQyRTeD4dksty2LYJuQwWNGzKhFDgAUn8I72eDJWvm+zMWvyTZCdX7hxUoQROcRf4Zm
         9qiP80Ws82oHcxVbhVsqnva7PJcDVLH+m90K7K+0BJbQjsmEqeBXkj5I4BGWq4HLfxc0
         Dz5g==
X-Gm-Message-State: AFq9FYJTGtmdjkkYJiYQdPlZc/Wso2Da6ozv/x+ua4TbGP3M/sxhfoyC
	M86x3NuGxkMk0LttHR2qJNTYTSAGZHoWkfEJ5rqikpi/rweNPs20AAWa
X-Gm-Gg: AYBFou0/+nDR14VfIbFvnfmZ15bdx/XOW32d8/g7XbmjdUzWIH9HNesi+f1JYlXj6jk
	Ar1l4aBRiEFVJnfPbgkxTMTEWeTBunKweK+AMw7M2fLehBRhetQca/Vq75ZDdIzboJZ170BlN0F
	GrMAebY8PcZ/2FDfeGTcxLemSPiHExqJCAEQdabsyn9ri7CLjSRy+vemoYy3+qyYinW7L0jGJiS
	Kn8APmF1Mc4I0yvfZDK4MaHmIM6b4C0bDfwGPuMGt291x3IZMnWGPkrmjMibANBdk0Xs+rv94E7
	hntkbkSLg+n/nrVhK/r3kA3SOVwYZiDHpXY5dFiDs+aGKkY8TUrvbilfecF4CsfXCA7PZIPJ7ln
	z5ANSZK5iUQ7vtNtN5HpEUWuJ26dbsNbCLQZ1HCejdVaPtIQ5YuMYgTgznyAPx4NRKAt2kghJLh
	xGRAPfHJLdMDmWwhFH/w9WGkty4Ha+HWQ8mKfmnHODM3b3mST6Vori+7goj11WFBG/n+/MzKqFh
	blmYhc78qbcj4Kqzioq6JPXLXoybJTLXmQh/tV2GTHqr0fr2GrZM9aNNfKSmhVQoOO88FdNPxQJ
	koA96u7Flv9q6KfNcTOSn4IO0tW0nHO8ctWbKRarAyDf92h3pdU0H9Dg5fQeNOOxygrqEkAdA1z
	IWykSt7S7T2CBkvVc5sxdLyLkwoS/kjLlnqgFoXg2spRJDIJOKdIKjfGUeUID8UUAXHgJFltUov
	WtVg==
X-Received: by 2002:a05:6808:14d4:b0:4d6:90f4:48b1 with SMTP id 5614622812f47-55c0038ebe6mr4688694b6e.51.1793038292173;
        Mon, 26 Oct 2026 11:11:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c043115bcsm5795251b6e.15.2026.10.26.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:11:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net v6 0/5] ptp: make virtual clock sampling and teardown
 failure-safe
Date: Mon, 26 Oct 2026 12:11:26 -0600
Message-Id: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTU7EMAwF4KuMsibITtLQzop7IBap43Qi+qemi
 kCj3p2oC1QNheWz9T77LhIvkZO4Xu5i4RxTnMYS7NNF0M2NHcvoSxYKlIVGg5zXWWbqJ/qQyQ1
 zH8dONqBCUxuoqdGiNOeFQ/zc1Tcx8irey/AW0zotX/uljPvqXzSjREmILaG1DTp+7QYX+2eah
 t3L6sdAgOrcUBJkzR6VNx7BhUdDHwzU54YuhtfMhp1VgeyjYY7GH3+YYlDrbAhUE7e/jOpgKHV
 uVMUAS+yI8aV1dDS2bfsG1K4/bssBAAA=
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
while preserving regular two-second refresh attempts. Queue the first
refresh immediately after registration. Prolonged sampling gaps remain
subject to the existing half-wrap conversion window and full-wrap sampling
limit.

Changes in v6:
- Limit retry delays to the next regular refresh deadline so exponential
  backoff cannot skip that attempt and lose a counter wrap after the parent
  has recovered. Keep the backoff across deadlines to limit repeated work
  during sustained failures.
- Report: https://lore.kernel.org/r/179303002839.3134.5595255852218546734@kernel.org
- Rebase onto current net.
- Link to v5: https://patch.msgid.link/20261022-ptp-vclock-sampling-v5-0-06ceace17bac@gmail.com

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
 drivers/ptp/ptp_private.h        |   7 ++-
 drivers/ptp/ptp_sysfs.c          |  18 +++++-
 drivers/ptp/ptp_vclock.c         | 123 ++++++++++++++++++++++++++-------------
 include/linux/ptp_clock_kernel.h |   2 +-
 5 files changed, 112 insertions(+), 43 deletions(-)
---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20260930-ptp-vclock-sampling-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

