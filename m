Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA839B978
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705523; cv=none; b=SuD3yIA+z8TU351NVAGndCakJM5KzyysfwRRoE1d8rNiECpn1WOVPS2DUGgJvuUD+845fTKIYmMlC9AlrnI1McIVIDmgHKXcr719PVIGuMcm/vKPj0ZQzF5NU8kpMX6CjtOQPH7Nlsi64nyKWm1cMtpA4RtJ/LKrA3BQmzRmU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705523; c=relaxed/simple;
	bh=NC2vt/oMVH3SUHwWhJX191I0AVsA2MCRqj6NCbXBJHc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YnLcqLrWWiMdMlZvwNXIftpZ4Ok3slDZ4XzFnu1K4/0tRwKsfBLhWC0QNUADK4XTQlCDnf5nVHfdJxr1PJFFM2NkkSveuziCkIJHt2tnPtyCQCs1V3SFMzn574tdz4xpc8Puakk+K91n3Tpx9OJ8RbRYdU6SmRKwOn3Vy3OSTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WR5UDxRa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WR5UDxRa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so3806966a91.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705521; x=1777310321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1pFD8c+B3MWSO6HzZ+QwDA2dWr+pU0xKoLUDgGQ0/E=;
        b=WR5UDxRafDgFqu7DLmxZ748urrcv1C/+M8dBkiIKuRFGdV+k87Lz8ePUHVie0VYC6R
         jtmtJLX0F05UAv0I6rX2pKvfTH/JCsMSpWNpp+CuYC1+KWnCnBPTSKJ/sC7ySXm8Y52d
         aQ1Sxpu8AJoN/rjqr2WR+ihkjs8LBMspN22qd8EBULM6IHToHd9sV1ZpOe/fZ/0cGxVP
         Z20XJH/wqNmJPvDXydfcFmbd/ObFoWQUn8x4caTBi1sd1D+/LgNTpJ1oSdC0VpQ5SltK
         nHs8yOY7v54BHLv7K6Fq/827doeTBpuiNDEFqwnvNpmZ9VqXw40PgOt3G0naUxR2DFFt
         OMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705521; x=1777310321;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1pFD8c+B3MWSO6HzZ+QwDA2dWr+pU0xKoLUDgGQ0/E=;
        b=DaKQ2wA8UAWJOxNjaIOan4g5JSyI4P34qcrhYtM3VuFi+8hXS7Mf8HC9P0jdphr9V1
         O6GdqAGixZnyxtCWBRsU99VvuX1gyWTPk3as87Ip/KcyTchXFgumE6OMVs5+NPUrOnEf
         ONTkLW+gLWbvf9bk9x5pUzpU7TiwOZhOwcSri9zHlqYKxIfujWQE65xb6Mr11/a7F8Uo
         dzu71bSKH8O2ETiHe7UKDDwL40XDvAKxMSmOlHfIMh/355L7D3lVmYEnWh5ZGsJkcywa
         /xGqyZIc1L1MUsU2nU3sqS9Ez5LKlO73/cbBqSlU2rBSGEzoajqbQ2tL6APhawngaXwq
         1J+g==
X-Gm-Message-State: AOJu0YyiL5J3fomk+QZ93/ipZ1tKtQZFz4MmRjw2C5t2CwLePJW3egOr
	hD2s4TMNdJ3uU5ifw8uH5SCeV5dbOjEFOOf+Tx1fFHfG7qSD1247ljbArZPylMe3giNVB/tzeBs
	rGWsNLWLrON5jMQcShH4oQa5MghMLP6dLrNtv/pl877F5xCnmmpaq8qfMwCyX9WxlxFj56gZWqx
	7pd28Bq04vJxZhNhKsidTjqHoh2ALQRxI2L23oOo2AmJMpjD8wF+E/xIS/gFfmupk=
X-Received: from pjzi12.prod.google.com ([2002:a17:90a:ee8c:b0:35d:9536:315f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c52:b0:35f:b50e:defc with SMTP id 98e67ed59e1d1-36140473f07mr15386341a91.16.1776705520611;
 Mon, 20 Apr 2026 10:18:40 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-1-hramamurthy@google.com>
Subject: [PATCH net 0/4] gve: Fixes for issues discovered via net selftests
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

This patch series addresses several issues in the gve driver. All four of these
fixes were uncovered by running the net selftests.

The series includes the following changes:

- Patch 1 adds NULL pointer checks for the per-queue statistics code to
  prevent crashes when the rings are queried while the link is down. This
  was discovered by the drivers/net/stats.py selftest.
- Patch 2 fixes an issue where interface stats would go backwards when the
  interface was brought down or its configuration was adjusted. This was
  also discovered by the drivers/net/stats.py selftest.
- Patch 3 ensures the driver falls back to the default minimum ring size if
  the corresponding device option values are exposed as 0. This prevents
  userspace from configuring unexpectedly small ring sizes. This was
  discovered by the drivers/net/ring_reconfig.py selftest.
- Patch 4 makes sure ethtool configuration modifications are done
  synchronously before returning to the userspace. This was discovered by
  the drivers/net/ping.py selftest.

Debarghya Kundu (2):
  gve: Add NULL pointer checks for per-queue statistics
  gve: Fix backward stats when interface goes down or configuration is
    adjusted

Pin-yen Lin (2):
  gve: Use default min ring size when device option values are 0
  gve: Make ethtool config changes synchronous

 drivers/net/ethernet/google/gve/gve.h        |   6 +
 drivers/net/ethernet/google/gve/gve_adminq.c |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 128 +++++++++++++------
 3 files changed, 100 insertions(+), 38 deletions(-)

-- 
2.54.0.rc0.605.g598a273b03-goog

base-commit: 2dddb34dd0d07b01fa770eca89480a4da4f13153
branch: gve-misc-fixes
