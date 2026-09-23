Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1056B857
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192058; cv=none; b=JHvykvS+Z0oWwgvDFuqf0vEY0O7KRZXvkYYSg+PGl1tFjAN9ax9OZOSJBujTb628P0fZZTQ8KDjNs2TyXgZqDP9Ls+SG+1nneWJkmHz/LiQOr/QEc1Z4nsevPI6XFzLhV7eicoRvkbk+TWjyWpAcIYq++CxjfD0yx+sua0fOIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192058; c=relaxed/simple;
	bh=VgdVHZfb9ZqoIhcdj+YWq79Pk6RvOJZCncaSg3smx40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m52u7xkFZYEpE7zPRySSP2H6geP43jwrlovs/37B0OidPx80HUObqawfqIUR1YkXjbvZ3BhZ+29kjdJoMlzNSHJJo+BYNuZpTmvwsPaUi7usKqwwxtyhGQYFX3VRvnJalOUNH3k7aUiOUtQ7vE0MBQIdIpW9gwnkWiz9x0P+UJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWTceuvq; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWTceuvq"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7aa0603e450so795728137.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790192054; x=1790796854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UA6HnleFaKMNeHtZg5wP2wOLqxj3WJzI/h2c9pM/vFo=;
        b=MWTceuvqqQ+kXTvt/QG4T18lnWdOWddLBlrIELOuND81U80lyDWjhhcbqUDRXeA3Cb
         mbsy2gXMLoA7iaWm0oZ531QAZncNP0sXCtdDeBr63wQPNlRhZVov9/UF3R1W5m6iGZeD
         fxIO2Ur9oS15z5IblCjqhzpEJhA6UmPSs2h1mi3K0LSafV6NOTQ8jl7Z62iAS6HCPbLP
         kRzBRT8hi0dCAI/6N1TyyScXw/6EJo6mwUe6onlDSVsZ7t3GXKjvBId7SLggBcZs8Bh3
         Am4WEHbfDvD0VN5uYTddOhb1BinmnMKQ++ksgwkQsJjy5f05kn9rx25MDzLE63qyXi4M
         AzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192054; x=1790796854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UA6HnleFaKMNeHtZg5wP2wOLqxj3WJzI/h2c9pM/vFo=;
        b=SifYnXGeZf0UDKN0w3oZHWmzeD548igYgM+MkZOW9FUa2YXbw9ogiWh3Uqk54R/jJv
         Kq6q53MGNlq04+j22ZMC0CC1BSeqEAIeHRWhyt5PPzVG1RLiYlmm+5mKCvD+ZQIdUrTs
         +yLdwhsmJJDfTrQ7TlTnpuFytopK6GJmxCRfN1ZHUXHAImICW8NFYp8DBkow1VI5+KoL
         1dedpPeBlUgwGbKQxIAbD6bgEuHQ4C8o+1hPJcsKJ+m3hVFGnSDCgzHdGjN9roBs80Vl
         YAi3shwzh3GDqdfv327aFkRQKS2DOmg0jbP4uL70zvPmU/tLCBbJTUGghLBwue5tCRsv
         NGgg==
X-Forwarded-Encrypted: i=1; AKwUvBz/WJdziroz9OaRrfrEseh6kuDMOW/dDvG+1h/rL8F/UK+voHZAWNVYJ2ko4mojhyxh5TdZR4A=@vger.kernel.org
X-Gm-Message-State: AFuF++nJORyCCSTbnqg1YGkE8sochdLmAFUmhZLX0zlje2DxbdfQfGlH
	Xm1wN8UitjP/ec4jG1u853Tx/pHvGmvAe7q4K0h3TrIGjGhWhQ3QqFE8no6U/jlo
X-Gm-Gg: AYBFou2nhsh9/6mreg0LL6gAqFHC4VVQxJ/U7FAE4Qq/uGiqPl5AbLbu+TGq4qMm2Zh
	hxd41A1ZoVVDLcNSnElFhu4+olUhKhOjyaEI+dqVbwCQjvV9p93iOsLK1YdNQmjCCSsPcDxM+bv
	gy/I4KijSB09ROcyi+Kt7H7hyH9OcAjM+4oiqRg82sWpgI7xbn8ISJyivTmpDK7z0ZpyjXTjeo8
	9TUk7hK2bc9cAbIrMRM9A8HpR8NwiQb6kbNY+VZSKwNzlH7Us5KqnJoFMUN9ZhoARfnUk6kOSu0
	WGueIjEMYePRF9lKPEFRratPcE8gPeiC1BLqMvg2xnlI/u6LsCRQct79J/7sZO9tqiprxaAp/7/
	ER7o5tBwqx47xYV02s+/AL3sqAL3taPN2mBLXaGjKgFFmBjzdMBUJ1mrm5MVBDy+uwUYrWPVksd
	RH05Z2/pqmz8PG7ifeYTvIu+bevxuyWQQhxjefAJbEFigesFAFbt3qFuEdjAGjydM=
X-Received: by 2002:a05:6102:3f87:b0:7a2:6b90:3d7b with SMTP id ada2fe7eead31-7af1c691fddmr271537137.8.1790192054343;
        Wed, 23 Sep 2026 12:34:14 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98527fd0592sm110188241.1.2026.09.23.12.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:34:13 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: andrew@lunn.ch
Cc: maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Date: Wed, 23 Sep 2026 16:33:54 -0300
Message-ID: <20260923193354.1537557-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e0515b50-8a7a-4c4d-91da-9b62c2f663bc@lunn.ch>
References: <e0515b50-8a7a-4c4d-91da-9b62c2f663bc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

You're right that the relevant question is not merely whether the MAC can
forward frames shorter than 64 bytes, but whether a descriptor with a
reported length smaller than ETH_FCS_LEN can reach this path.

I found a closer NXP/Freescale reference: the i.MX RT1170 ENET_QOS
documentation (IMXRT1170RM, Chapter 61), which describes the Synopsys
DWC EQoS receive descriptors used by this driver:

  https://www.nxp.com/webapp/Download?colCode=IMXRT1170RM

The MTL receive configuration explicitly supports forwarding error packets
and undersized good packets (FEP/FUP), and RDES3.PL is documented as
the number of bytes transferred to system memory, including CRC. I don't
see a documented lower bound on PL.

However, I also noticed that dwmac4_wrback_get_rx_status() returns
discard_frame when RDES3_ERROR_SUMMARY is set, including CRC and
receive errors. So an ordinary CRC-error runt would be discarded before
reaching the FCS subtraction.

I therefore don't claim the documentation alone proves that a good-status
descriptor with PL < 4 can occur. I'll verify whether such a descriptor
can actually be produced by the hardware before claiming that as the
trigger.

The length check may still be useful as defensive validation of the
hardware-supplied descriptor length, but that is a different justification
from the runt-frame scenario in the current changelog. Happy to respin
with that framing if you prefer.

Thanks,
Aldo
