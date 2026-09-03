Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C404D90D5
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458275; cv=none; b=lfGnxkJfccr1e6212Gi6pG7e3KjjVJR7lL9duHcZ006Q4s2WJeLytzp22xtv2KKwOrmkFnTXCatj64vYd5PZXwDMQXK+zuHwGSmQLp7wajFDF3KoYTtojxoRRxcWLE10BT+dEGz50tbtxP9bkszLni4+CvT1y5wFE+ZdcoF81ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458275; c=relaxed/simple;
	bh=uQIy7MwQONr0qj+lTFmPAvqehjP5quRPj+YoyLvrCSA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mHGXejgyjLBtCND9+zu5gqNVMdfZE1I759TPu68m0fs3IkwfG/wJ/ZkfwudUq7kaUsOyEANBaem3lLbCj6gnlFSK0y4AvusfjTk4vhtabpJqaWu0o2TH3HF2oAANHMeZygHscrWbLRGks3XOsD9P9VnE98Gw2c9SVXW7Xp6uuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL3MpOoj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL3MpOoj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d94c868ea5so1106925ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458274; x=1789063074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33CyE9gPmHOvwQcHXZRQ4nchZYRCfwGcCQUFEi8B4LQ=;
        b=OL3MpOoj9I8ZmiJcj2idypt8q6V07/uFXqB0Y4xIf3rTc18BTPOKd6sA/VLUPye01H
         JP4fYtd/lQ8yho25KnOSR85WncDSSgNjlALh7GBjD/nVXqxeKnteUdL+/WNnCPSgCdMx
         vx+kndZ+qiAGvx7gkljrtXo0tujQDmlU67O+LGmZIQFzERDW8+fcqcKeb4fTpMJh1foY
         Eq7eKl3/gnWT0DOb7DTIkpqnORseRwP+4apMpStVaj9DbdcK4HrZ2lvN9wCPdH4E4lph
         ODCm8JC9Ke84J3q3I2kODgQct++cjZWw72GEXIbkDLnAmbVtm6m2GS6e8UlSuau3NFQj
         FocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458274; x=1789063074;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=33CyE9gPmHOvwQcHXZRQ4nchZYRCfwGcCQUFEi8B4LQ=;
        b=Ufdr5/RGearcn1e7R/FVpKYJZE6XS2iZpccYnP2K+AHmOJ1m181CHLPuat50nG9iha
         lfQza6ijNTL1NDyHw7zbNaqnfq2qiyUfEeSkQCT6+n1Y+dKyC2t5L610fvvPtVGoiTUE
         6Q97SySb8VyXw3qYqjZsxglf5gF3igmtUljNi67oSyK2f5kgxpkVfgK1+9UtnX2iV9rN
         dv5zT0XIXOtBby8glaXWddpd+cCabaed8MxRQEa4dDNBwpsdYYR6Qs/dCWQAINHMJJDZ
         OfkH2SLr9Gi52fLnlUSw41rRxYMkqLTaLpLzQbq68slnV721GCkDvs6QgqGXE1cBcCRV
         CtLw==
X-Gm-Message-State: AFuF++mp/H1Z+fcLEUKQLQa2lY/uQA7XF+hnH0XmTanqZHGJN+UiWbRB
	O58zggoj5lpwCrnheIAwDIevtBwDsQvbTbHdGb7s8+IqvMKTlBSvWJff
X-Gm-Gg: AYBFou2Mq3gBUDBoS+qOF8akW0PJgRhIuCMdgKs7VMCsLt9FcwVreoDcixMMzZ1dreH
	oHDfFymG3AT2iDPAFNCyRA90d841t6D4DeChVySmoCyLvU+CzJVdy74OGVOXrYNUTn5Gj1zjNbd
	4nzafY9iz2tsDZbDKFuLwYN076C7TVxeA8dk8i9iV1+GS2/JJRoRuKpD45KlQ4gytpziUmQt9oP
	WS62MWTleW/gt8p7FchF08YLZ7n/OxNgWTmTOM9a2Oq6CRPTmL5wAAJTjlvhaPxotUErwR5Top+
	nqrBhcw0mXHjvco6svlseDFL78mFeY3XM/TyH6HJFnN5BipaDPPvSvv0scQhyqbPBESOj5jZnMY
	EAf2ZIdJRH0Q9IIdMqbG4yKOeQ/x5tU2k5fwRdSBTP6COSkZfx5uedt3k0NRRitulY9pEr9EyVw
	HVEjiPPOzUZ8XpGjgEfvsCVnD8kgZEd2GFq/AmTMyA9GEnP7i4TolSfZAA3gEWMSX1bRAUEP+6d
	1pOdCjo3wh4vi+mVFs055uuh5+19u4/ALdyJVW8HP36QVs6scOmd3q9oy4N9er7QGCyQ66AtLKy
	b7hlvUAM
X-Received: by 2002:a17:90a:d44b:b0:398:bee5:61d6 with SMTP id 98e67ed59e1d1-39b26252edamr260921a91.24.1788458273862;
        Thu, 03 Sep 2026 10:57:53 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:4db7:e37c:a6be:f5bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm6624722a91.17.2026.09.03.10.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:57:53 -0700 (PDT)
Subject: [net-next PATCH 0/2] eth: fbnic: Update BMC MAC address handling
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Thu, 03 Sep 2026 10:57:51 -0700
Message-ID: 
 <178845766796.2787.6001399537275460493.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Update the handling of BMC MAC addresses on fbnic. This patch series
consists of 2 patches.

The first addresses the fact that if we had BMC present but no BMC MAC
address it would cause the system to fail to come up as it would consider
it a malformed frame. Rather than do that we can simply treat it as the BMC
not actually being present. The assumption is that the firmware will send
us a follow-on message when it gets the MAC address sorted out from the
BMC.

The second diff cleans up the BMC MAC addresses in the TCAMs if the BMC
opts to disable the channel and the FW notifies us of the BMC removal. By
doing this we can terminate the now defunct paths through our NIC data path
to the BMC.

---

Alexander Duyck (2):
      fbnic: Don't reject capabilities when BMC is present without a MAC
      fbnic: Remove BMC routing rules when the BMC channel is disabled


 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 56 +++++++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c | 81 +++++++++++++++++++++
 2 files changed, 118 insertions(+), 19 deletions(-)

--

