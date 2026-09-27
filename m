Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883281D5AD4
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790483524; cv=none; b=e/Ck28fFb/Fn40aDbdmhrp5/WIHqntscDsZbAjBdx49NFXTs1iKdMr61KMN0Eh00jWMcJWNRFF3iEyKSFOdiL5vQeQghn8kjvzqxt9l4mt0WLF9WZJHVTsObYzLFtS23E25vkPLoy1uM89b+NyPPv3PgoDzsB/3s8tmpRYZ83d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790483524; c=relaxed/simple;
	bh=kKGtxVUKPtQ0j31gyrV1yVNdSd0n7CPMai1BfRcV/zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O038y0JXNfw8hUfnW4sUSFzzLYVV2sG7VqoOVCCWZeQx3iM7xyHSGsY6uH1127CrTsLQ27VlVv3RTyzqf5MTxJvAeVuvm2g7+B8y9hJ8X1UhHaGc32KjkYzoGOkfyEKpVZUm2iMRaZYJWWa7CEOMKIg8hImSdDjjACGz2s7eBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=KEc4xjl7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="KEc4xjl7"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1221159a91.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790483523; x=1791088323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwbJ4pEmU8P1v6WkKeChtnGUndufDFY/6HPdG1aruyQ=;
        b=KEc4xjl78+Wh2Xx2cfIlDjPh0MLb+Q6051xzCn0OOXBn3DmpF1SFPYhkJpQSzM8jqy
         grMx+LAN1Q0TtF0Z7G1adWcf6Uj25qsEnq+n85DCPEMoMYChBX5Hr+pMD3C61iCKtDod
         eiufpALaFW5hdpwQ2N7iLoW8VYS64SEQo4rHeh8Sugi3WrlLewSRlPVT4O5f66f45uyL
         zQdytsYOi8wovi/yd74d9y0BnXDj2hnsYyjNmSZTZo43ueq3kJnU8YbbllOefm/5KcFW
         ox6LeFfKG3XeggTOk0sP49S+NkiCML+8UZ+SnNYNapotKJz9UM6ZcAmBAOr2JkrScMCe
         MfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790483523; x=1791088323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwbJ4pEmU8P1v6WkKeChtnGUndufDFY/6HPdG1aruyQ=;
        b=yUT/EdoEQo0/HKaX6URmtmia7G0InzaqrXGkSMimJOIHc+sbkVlPlbJ1S+aSwqnupf
         +QxyYIjhrWjgsE6YjUh1wxBL7LT/xnk1oVaFJ8Ba/AJAS3e/SoXaqL8Yt/0Do9uqcwWc
         uGItX+SlgnosvTmdNxqw4nNlqdc8jSlJC9KTDV2h17z+DP1xZymU/WuXwFJ3GdBuJimq
         GB39D7wEKfUkGrmc1DUJ7YfR5rj3ViA/3nrC3CzExNSFdAUeQ9KBbfUaEVgj2WGUJEvO
         aS0QQo9VOBK56U+Z/IkYJXMG70wrYbwET7d02cJ+v4u19Uzu+8FTbgTeR+lERL3zEKn2
         reWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQawSn/BbQcPwhULTA/YImMNmgSVpxvB7t+a6FCq/tFB0zngzjtOdW8ap5eISe91zkeHJOtUk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBEpYzmnqJmiCV1rAV/bLWutXB/pxWooRULPgklt9uhaRY+dNM
	GQBK4S0pP8iW+nDbr5H0T9+s9eJ6Sw5duDI/U1FOg2V6b4pqKyfJwvMkj9MkemCoUP0N
X-Gm-Gg: AYBFou0/WTXV4CDjXKLyOZonBU+Qq+HAEu3GduppME6i0VNZamrXpMIeK4u8p3KWS3w
	N8Ha36YFCW6LcQYnWue1K31Nh05Ipd8WDHKRjJj45qhlpNHwXCQp8DFGPvR0BncS2Ehod50jso7
	Lj4/qX2HZX9Pkz9W8ApQJvRLT4MEvSljqagMPoSKpoJ+x5RJjudTsAFRgi8iljZrjfrVOSj8BB1
	BFnUNJE3anfs58FmNXe9fIRA9yUzng3a1APfPffFEOHhgp2ooI+YTLUGEYHLinV9c8O6n/BwYb5
	Hq9Ut+PJk4y60Bd6KkiJmWmw0PQPTHncuzmexGigB6f81w4rA/pWdpmXA4xo4QOCh4zuhkl5BS5
	iIC/ubry5FDr2fL5mRwrQYa/m8w/RBDD7ZwdLv9PCuK3VmDA0IVwhSRFX80uGe4f7pVaKWGdbpm
	OVv0peyEAUIba315nSGv8/44Ril1esGPrxsbMEu85TJC3d8Z71lul63L0XoJ13Z1SNToDMwFQdz
	7mrxRN2/GOE+gPw0KX9NMix9OxDvA==
X-Received: by 2002:a17:90a:ce:b0:3a0:4146:2955 with SMTP id 98e67ed59e1d1-3a0bb6596f3mr3377478a91.61.1790483522629;
        Sat, 26 Sep 2026 21:32:02 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e05d674dsm2795629a91.4.2026.09.26.21.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:32:02 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zihanx@nebusec.ai
Subject: [PATCH nf v4 0/1] netfilter: x_tables: avoid holding mutex over faultable user copies
Date: Sun, 27 Sep 2026 04:31:38 +0000
Message-ID: <cover.1790439054.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

This patch keeps faultable user-page accesses outside the per-family mutexes
in the legacy IPv4, IPv6 and ARP x_tables GET_INFO/GET_ENTRIES paths.

v3 Link: https://lore.kernel.org/all/cover.1789885804.git.zihanx@nebusec.ai/

Zihan Xi (1):
  netfilter: x_tables: avoid holding mutex over faultable user copies

 net/ipv4/netfilter/arp_tables.c | 49 ++++++++++++++++---
 net/ipv4/netfilter/ip_tables.c  | 87 +++++++++++++++++++++++++++++----
 net/ipv6/netfilter/ip6_tables.c | 87 +++++++++++++++++++++++++++++----
 3 files changed, 197 insertions(+), 26 deletions(-)

-- 
2.43.0

