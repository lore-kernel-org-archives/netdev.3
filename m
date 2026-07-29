Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9D382F28
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363517; cv=none; b=ZYLkkEzEA3wuXvBrOAPbNu/l1Hhi2Bj3s2l6xJ0dIjZJGMZs8ugk3V7sJ/iTxMBvt9u9MD+UGHfT2GF3SlESkN6a+it60gzX75aQTuT+r/+o7SAlFqrdCEufgUKSqftJ6/kYqszfttMI0DLSUcrvmmj7N2eH95o1J8BSLbb6UPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363517; c=relaxed/simple;
	bh=nyleos4AoSWbfZPVZWWGj/vCZsfcuuzsttq1Emv2tZ0=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=nBeFz/XJ9/XTtBSxr6TpIbZJVyz/KsfkKvPGZrVdhSbHJtb+sfoykztLS2N1t/FPPZ5qGa5Pis2S66OnrQnLgVgzvntOyOYlhUwTsAuxpg4eT6q3YQVihICC1wJMkSfK6Coz6AxpUhfUXvxXkIoYRmh3Ex+GKNhXq5kk5tnLCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m19RAPYi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m19RAPYi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1527532a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785363516; x=1785968316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lP8ssPR/bx8ZNeUXDsh51j7Vek7sgVAeH3Nw8OcnkCY=;
        b=m19RAPYicbk88yLp46uu3QcT0zpzSEnvBiGz7tJpJie8bVY1Ntk3JpLhQGOJDtiMwP
         la7CEJ1qtbxaziYJ/PaHBBBsYjaWJjyQnoeWxwWUF0di6VR5dhVbp6UQWW6UvAunkys4
         sLpqA7PpmytsD32pXntoVTHkGFzGrRMj7mZO1Ms4q39NmiaeiZfdtlQIBdWUWKjdSGqx
         U9wDuiKe78Jts/gWbU9e7Xg2522xuWwjv3mtwD70GOpORRCspyJir1x7zvGs7PG2pz5G
         ttZ6Sp1/Axp9Z78jjC7voJdH7JDPI1JQKGvYMrUBYdIVWHmLEhBQyZSZ9i/Ma0rqSHmu
         gBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785363516; x=1785968316;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lP8ssPR/bx8ZNeUXDsh51j7Vek7sgVAeH3Nw8OcnkCY=;
        b=amIMNwHklnSj12Ib1KI2Hgrk6DQ+kpvwaDCHBglXwWrCltIYG/XIwT6wE75/EufAK1
         7QS3ZW02xuXqL47ySNCSslk8pgJKsV1ArTYrWJyWJ1QXu5sHfdl2Hl4AJxQ/TpX+s1Ne
         ruvVAWPQZHfkFDkvWREwZRbszxjPfcEDfqXpYHcKn8XAS6KEFjaEYcHF6Dq9FAih+Z16
         t0e9GCYg40efr6QvMbfN0fSV0K3wUBDKSpbSUVTVvD9/WNfDwTyxT7VOn6chV6mLWwz9
         ffufQn3LyykiZcb8RrGrqsuUFysYsYCkSwOwnKS5YPtcoVdjvxZz5MNj6Q76pvISOxWg
         UHPA==
X-Gm-Message-State: AOJu0YzLWrFQuX60Fdy8JetnUClw+XB+YnTyi5uYzO9jD2T+oiluNa86
	oSg9No23cDnAwHKm6900yCo0+47oyHBrA8kTgUTU8DpywGwwmRIkBTGT
X-Gm-Gg: AR+sD13LBM6s1n2BP/ez6wO/Ft0NvSRaeMXNNJc/R6uRddJKvDKV3WYp4V1FvhMf+ts
	8j9q0pbS5bi2efv1Kl5GMBRXpeSENWB16rx1ooXYakz8Sv3VW6w3v79lKFM3QlcriWoKK3Pj/ak
	VsmRtRGYlIZi0q6u2rwyGu+SmoLa3LSbnoP7bq6U9Khlf8klt9cWbde/ljVxQdCK9UCQDWvKoMn
	82vu7fhnwETrC4LJu0n/xl2u/1MLA/aBZ0IUQO9m4OX2g8fkCfHSFId+8QrzR8p3Nev/NocuGH7
	+1pfvh1nIx64tqsUofrjotdhDYLRFGoeqzZZ9rju6pKdGglViv9T2DuS4ghLe0yBqS7U76W32Vg
	Y6L7i1zDkYsE1BfV7BkNMQC9QGcdP78/9PFSDRGhbWo+ZWZ0JHNdG5xHcE/B4lIsrOULqdKSRzw
	ZubO7bpVgFPXck5CRGh//UjQPjmd9jCvBX5RXFlcNX1Ks8cyUKdgLFVAwvSfgsL39mlUDTIGPYs
	HQYajpsp5OMlcMkwjUfcbAgWRohiq/xkG+oxPrvBa+IwlePekJOQcKvVar3wPYPKsWqsPG+Na+2
	qQ==
X-Received: by 2002:a17:90b:28c3:b0:37e:1430:769b with SMTP id 98e67ed59e1d1-38f9c0952camr56905a91.24.1785363515732;
        Wed, 29 Jul 2026 15:18:35 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b42d176sm43910a91.4.2026.07.29.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:18:35 -0700 (PDT)
Subject: [net-next PATCH v4 0/4] Add support for XPCS based RSFEC
 configuration
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: mike.marciniszyn@gmail.com, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, jiawenwu@trustnetic.com, kees@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, mengyuanlou@net-swift.com, mohsin.bashr@gmail.com,
 pabeni@redhat.com
Date: Wed, 29 Jul 2026 15:16:25 -0700
Message-ID: 
 <178536329631.250758.9931617589255894843.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series adds to xpcs to add the necessary configuration steps
for the DW PCS/rsfec for high speed interfaces.

I picked up the set from Mike Marciniszyn who is no longer with Meta. His
set ending with v3 can be found here:
https://lore.kernel.org/netdev/20260527000958.81108-1-mike.marciniszyn@gmail.com/

v4 - Address AI review comments
   - Simplify the set by just using separate PMA1 instead of scanning for it
v3 - adds an alternate xpcs creation that allows for specifying multiple addr
     values for creating xpcs
   - remove probing in favor of new xpcs create call
v2 - probe mdio bus and use phy_find* to isolate mdio address
v1 - initial version

---

Mike Marciniszyn (Meta) (4):
      net: pcs: xpcs: Expand mdiodev member as an array
      net: pcs: xpcs: Allow for multiple addr in creation
      net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
      net: pcs: xpcs: Add handling for 4 channel rsfec device


 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |   4 +-
 drivers/net/pcs/pcs-xpcs-wx.c                 |   4 +-
 drivers/net/pcs/pcs-xpcs.c                    | 304 +++++++++++++++---
 drivers/net/pcs/pcs-xpcs.h                    |  37 ++-
 include/linux/pcs/pcs-xpcs.h                  |   2 +
 include/uapi/linux/mdio.h                     |   3 +
 6 files changed, 308 insertions(+), 46 deletions(-)

--

