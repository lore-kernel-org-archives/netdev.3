Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4357C377ECC
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052373; cv=none; b=PBya8LQ5NNFOy0X1T5nvQXpHKyAkkWAtDPb+NvdRSUuqe2CRoXFNC6RO+9OCcF4CzQr5JGP4qS22zznctmxVAwTKjTKHR7Gs+rliKGMmeDJiZpiUm2Uu0GEl3UQSkweuBuMdeLnjvApj6956Wr8RvUlpmUHUXkN786ePapowCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052373; c=relaxed/simple;
	bh=4O9b2fhqkP+W3xXPcxSroMY1Stl9Hf0z/8z2N+sFacI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETsxMRV3ymsOZiw/tzFLhQBTH+QQFOKklgkUxINPisSmfKFuFK6IE16Np5HOboe7NC2UmHU0SSoXWV2zigkm6Vpsj2fNevvKFzDUkradsQo95osu0MVWGq8F5pV8v4DCtr39ZzM126w8YCvVlu3CHDA8iDOOXmP5swR09Bd2sgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwcM4DdX; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwcM4DdX"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35123548cebso3655eec.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791052369; x=1791657169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjhFw2Ze94b8Op4Wrc9mSVlEKmb9LEFTwAUiX7feoLw=;
        b=JwcM4DdX/Lyry8WJG1nMvsKFJZpTghI5xUrcoNF0rp7DfJeHIUl6XRe62jTGwgrTL/
         FhuvSlPospUK3tGyqISio+7pwGt8K51eiXiwdus5TixWBeZT4oJewImGCw4NXqaTT4s9
         NiuNKg6wTQ9YOGC6iL4NXIEqbBCxseoHG4DeLTUoUlL7F3D/57iayNFObP9jS3sUuDrO
         YVOOj12qTRDyutpDhF6w4nyfyA8/GFjGveyDvsYOLOzOGDLp3yiLcnwIHDXF9kKixVvP
         1V9sltluPd7gN61c0Yln9Ei/+LikpjaG//NUXX6vaUscV2z+WrfA1wKzb/67tFYWkmOx
         l7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791052369; x=1791657169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjhFw2Ze94b8Op4Wrc9mSVlEKmb9LEFTwAUiX7feoLw=;
        b=c2CZQdl+MjS1kDwC+NEjYgb96UHFsppw9dwixs+pXXku+7BclWHO8GcVN1NJE2brfs
         UfY1UuZu/Hgd9oWwY4GHlzX5ZiUGGlvL9RjIo+7/GRVuFDPxt35hPApNYstTR8A34JHy
         GamnT3TRKj3Y+diUyPIQWrzV0tJsgLQgs8PQ2Hdq5S5ErrJEQHY6xEdjUwS4lbTdHQa6
         A/KbX0mqjkgqbyDZNbBiLXJOxPyZwfkU0tkhj+BMg/FRhSef+KA3ql6iOcsgwVxdYbvm
         XJQnHZ3AxvKLi1aDf4cXB2qZxRFF2ySuEzQbFzWx85LVRC6W2HKTcJH1sVvZlV+jaZ2u
         wJBg==
X-Forwarded-Encrypted: i=1; AKwUvBx+g5YbFuSlS/Q0fZW354bWLfQflxKjhH0Y+4anK4/rxRp3qGslOPvb6lUYtiPvZS/N3XK0jLg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyoni+urP+Ry9cX8ts0+DM6P7KNcutqVHCoxiEEgfqlNB+8Ps9
	zZ/rlbD642W6yxp05nDRRvPZQT6+LApksxviI3IYm7UYn85fEmkcrINb
X-Gm-Gg: AYBFou3uoLj95xwQ8oQOYyRpu+VtX18psPOm6h8us5ydVvXcNsgig6GIO4I18zcwq3e
	avUdGYqS667fHtFj6dfLFxULOxFFr4mNho7rGQQYqE7SU0B3y83TM3FOEmFg2gFolywpjWZILCL
	HRhPJkPDHoYDmBPGlLyZZZ/D7dgCzVBC0Ec5FTiC71wsKtKgy3VBXzi043EJ6khk6Ns0hF1YnBF
	cXyHoZBvDNBUuINATLgDOC1cnv45yJVX8yYT7UtlKxWb5hp5Oy/W+UTzEyB1eOwK3Bs2ZDIDVzR
	7yu863RbHT7hGfWXUiYUNvqDrqOAuoogURglIyxxBwc7i8KY1XIZbyi4fU2a4V/1T6KgA6d+Vyh
	K/23qbeuvv7tUt9KqZwTToCJ04KxH5SudktNguI0u2NIF3r00INEotVaJNZ1HV+z0zb3dmZbj9Z
	D7kLbaFCaa/Hh06q2vz+2nLemsWq0y6Gk6Q7NoKbG//mDlUvpSZ0L6yH0nUP1Vu6WW8CQWqoDb6
	NMEBbzAbH6kpxqaE9oUrcELTcVTMQVgcu5k3ati4mbq/v87N1u6GdMcn7iYKjyAb62kaQ==
X-Received: by 2002:a05:7300:24c9:b0:343:fdea:9a0 with SMTP id 5a478bee46e88-34f15028c8fmr12536988eec.2.1791052369159;
        Sat, 03 Oct 2026 11:32:49 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd9698sm17118191eec.23.2026.10.03.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:32:48 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 0/2] net/smc: fix link group teardown races
Date: Sun,  4 Oct 2026 02:32:35 +0800
Message-ID: <20261003183237.2284245-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two fixes were posted separately, but both change the link group's
freeing protocol. Resend them together so scheduling and early cleanup
use the same locked teardown transition.

Patch 1 serializes the freeing check and delayed-work rearm with teardown.
It gives freeing its own storage and sets it under the list lock during
early cleanup, so another connection cannot rearm after cancellation.
It also corrects the cancellation comment: cancel_delayed_work() cancels
pending work but does not synchronize with an already-running callback.

Patch 2 excludes competing early teardown and pins both early-cleanup
callers through their ownership checks, including failed registration of
a new link group. Each patch retains its original KASAN evidence and
Fixes tag. The evidence comes from earlier instrumented runs.

The separate pre-existing race in which an already-running free_work
callback outlives the group is outside this series. The callback reference
and cancellation mechanisms are unchanged. The socket-lock versus
abort-work wait cycle also remains separate.

The series is based on net/main 71a77ab76e74. Local validation results are
recorded alongside the exported patches; no runtime test is claimed.

Chengfeng Ye (2):
  net/smc: serialize link group free work scheduling
  net/smc: serialize early link group cleanup with termination

 net/smc/af_smc.c   |  8 ++++++--
 net/smc/smc_core.c | 16 +++++++++++++++-
 net/smc/smc_core.h |  2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)


base-commit: 71a77ab76e74131a101f4d2d2afb0dcbf81b4e3c
-- 
2.43.0
