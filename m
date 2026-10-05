Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7736AB5A
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225941; cv=none; b=sSsgPH1Ua+XQtlnXubRvFIxkmH/4FgRJkC2rNWoVKtRAZqovynHiisGMBiPLBphgd0rU0mhxICOOPH81We05fjSLY6fOfAbylkky+HckOJxFb5AB4i8ksEORNQvkefEJU5oiKnQCaY4UsukRUG2pYlSj+fihJvjT8DtDc0tiu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225941; c=relaxed/simple;
	bh=b//zlVXeuJXL7Lb4hosPufcIxqNJUBJKw/gIENPO8t0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NZuW30BtU+mZwRt3HyFsrIjfDQQLClDGJZimCNFFpN3SMJ+TqdM2o/sSREOeld+vjzvAsifo6tI9oVyRv0oVEIiYJUIVLPf1MeogKoF9hv5cPNwMF7rlIBvODfWqdWHxEJmkuN42lfxeSZTVzlUQMP5f+uKRkF0Pdz8FqVfTA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHLW/GkC; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHLW/GkC"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-483a66818edso942852fac.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791225938; x=1791830738; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qHXIZ0/VdQKV88LxM3mtQj2aJBqOHLmw3glvybCULXM=;
        b=iHLW/GkCQ+VaMoywl/A/ZxZLHwRWK+8+1Z/2Vw0vYXkANfyrof6HDB11EZ7HLF8NCt
         WMffUYodizRaQl4IKCqYa93FJHNGNq1AIdOn4aOec14XikSWQvKkgonCaDOeYUrBR0HS
         m2qP5IUwFUlQqn8kO1XQKN+cK9Qknxhb6A2mWrTR8fwGi98CpEVXN9ooI9ZGM9ZxnWOC
         UTPNsRCVWCeafVXPlW5YdZoNhs8uecaQwHkI9As4GlXcoX6BzdUAOQ4nDr3rxzbGNWr0
         VNrhTZmTDKfQ6yXrsJfEDriaHghxL98xyYEiTicZSBqsSAOqD77hZcZJusBxFJGyn0kj
         u8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791225938; x=1791830738;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qHXIZ0/VdQKV88LxM3mtQj2aJBqOHLmw3glvybCULXM=;
        b=Il8Dyc2dySGJboY6sDkGBDDBbpYfE1ffhugKBq0MnuUwUhmrihLhjBjM4kQfimIw3A
         8VPsxk7wKemXCIZJILgQmt+T+8dOm736bJJXcxMbTGtpsXbEvxGhD6e18rmd3eETuM17
         94qYD+tVRnpFk8TcCX5YZRFO2R8z2BNi5QJdr0GfDUQhf6GqQi/lDiyxe5lwFGLiSJ2l
         GXPLeHViBXsNSHStaeE7vhfSseoum7n3ym6mdiRF7u0guKBwE1OdyzGU1ZRdUYpkaHSD
         FxxJgWWzb7aUtU/DlT6yTNBm9b5DIa8WUXvCsS8gZHvU2gGubMTxYSUxofWI+s8Y5k3s
         csqw==
X-Gm-Message-State: AFuF++lKliNZJ0dwAK7ZlxlyUJGi7GoMR3Tm7rOg3oq9QW/pN8NVnnL1
	UR1O2yfKlACNGi8sYTKMdId1uN06MY10HtgkZfb3XHG35ia5t8waBKIW
X-Gm-Gg: AYBFou376U1mI4DG4pfBRwJQ/+7USQlZTetd9bnzUE2v+lc6MsWDZKDhKx5NIzJFtUo
	N70IWjFZ3LwwgEldOUZjc686VPqyR4pMH8w7H7bFoCkEd3vEqQ/PfIUmS+lvI3umURCtI1elqt2
	+foo5FIKV+LbZ18ogtfqAOGso6MqR7BhNKb/my241BOMtpjG08+rrwJejxVy6u89R+pr7lzZRIw
	wGteSXf2DfSpIKqsT9Blu4dyIAlo/J+zLXPGyi3FECi53+8kiJRK4WQYi3537j0ddWF2gp9J0bm
	WFng859arWs1LnZVi6V8v1/046dlDa2wmrj7K9bn/S2Sj2nsF6LmU/OLpM/as4AGoH8vCFMwM6C
	L3YNojPixCbq+UdvbktwgaWHyb1f6BH3WG1yUkTdG/vP+EaK+S6/0h7AhoAnzXdCI2m9cGTkJMj
	oWcIS+AjsX1RPsMU9q0PKofs0u/BKmnAV3fmX8qYmSCRLXOu9dn0teBts86vM8diW1m0K1dqS0X
	zHVBHwfHxTgZM1rWUstxDa7aBfsH/hB93KaaURHNXj6JajtUAOpp67evDR4FG+tvtAJmbYrleIm
	90kmmE33QnZXUTFfhIsiNZmc0nwG1lhcsJ/sQQlnwIqNTFk0ydT4OZDADk8W5PafthUWGSTzqFX
	D0vJ101C8+Ck/Ohaw/PGb
X-Received: by 2002:a05:6871:69b0:b0:46a:ad97:9ba with SMTP id 586e51a60fabf-49e3a581b13mr6547284fac.8.1791225938410;
        Mon, 05 Oct 2026 11:45:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16ead0dbsm10666593fac.12.2026.10.05.11.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:45:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net v2 0/2] ptp: make virtual clock sampling and teardown
 failure-safe
Date: Mon, 05 Oct 2026 12:45:32 -0600
Message-Id: <20261005-ptp-vclock-sampling-v2-0-8ed12d4d10af@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OS27DMAxEr2JwXQWSnMpSVrlHkAXN0g5R/yIpR
 orAd6/gdN3ZzRB8My9IHIUTnKoXRF4lyTwVYz8qoBtOPSv5Kh6stk6HWqslL2qlYaZvlXBcBpl
 6FbTtgj9qT6GG8rlE7uS5Uy8wcYbrO4x8f5SG/HdpMbGieRwlnyos6nzDGELrG+cooEfU3BjEo
 2XXksfP2uqddZOU5/izr17NDvt34GqUUWRMS8a5YJDP/YgyHEo5XLdt+wVh2FpIBwEAAA==
X-Change-ID: 20260930-ptp-vclock-sampling-902f98408c93
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Keep virtual clock state intact when a physical clock cannot be sampled,
and retain elapsed time when errors postpone the next successful sample.
Drain virtual clock sysfs changes before parent teardown so failed
creation requests can safely unwind their newly registered children.

Assisted-by: Codex:gpt-6-astra

---
Changes in v2:
- Drain virtual clock sysfs changes before parent unregister walks children.
- Use full-width samples and overflow-safe scaling across long sampling gaps.
- Update the anchor for extended and cross-timestamp reads under the clock lock.
- Link to v1: https://patch.msgid.link/20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com

To: Richard Cochran <richardcochran@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (2):
      ptp: drain virtual clock sysfs operations before unregistering children
      ptp: vclock: preserve time across failed physical clock samples

 drivers/ptp/ptp_clock.c   |   5 ++
 drivers/ptp/ptp_private.h |  10 ++--
 drivers/ptp/ptp_sysfs.c   |  14 ++++-
 drivers/ptp/ptp_vclock.c  | 148 ++++++++++++++++++++++++++++++----------------
 4 files changed, 121 insertions(+), 56 deletions(-)
---
base-commit: aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320
change-id: 20260930-ptp-vclock-sampling-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

