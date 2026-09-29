Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53C4F403B
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675010; cv=none; b=SUo+9Qf4iGixQ+lVjDbLDROc8x93cHnqhVasRhxX/AfXhLnRki9dRiYB/lUybgjTVWv0n6TlRgdXBjpT+4OjHmUJCdHg03TazgUXVcAxM9+hsR76F8/nEipyQUPV/pdL9BZYW2dZVCOCKy9s5gTwNjjr7ZW5SiCdni65KcfKSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675010; c=relaxed/simple;
	bh=OdQgp1gL3QtlQrsCyzRykVIHp+LSRj6Wvz9fNOlGfq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoEa50X6BlP0JdiFMlLAE+6SWaj1qdYhWTsmzJmf67Ge48S9VHyPO1GiA43LddELJthMHh4cPfppAn8gqE2wzfvGqekttqbZLesqIAwtOiKFIFnEvJFuHuMjcIpwoG3d2j+0CXAdZ2a8t6oDPkqyLSa1ilq83SpPyNOUcoY70EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwiugqug; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwiugqug"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so2247111eec.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675008; x=1791279808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MMNDGpCcXlVn+K/qHQzmlZIK4VMU5usMdqSK6Jfjkss=;
        b=nwiugqugEBxWXwJ1f6Cn10SKxcinGVJ9OPvnea2HzFntgMPpgfvr33JXiDSezYcdBL
         MjNgwzuVOkt2VDMRsT7QLVM+6j4zmdIVgvb5/dLd9ObzWU6iEnC5vaMpPCR8gEp/11Gi
         9yWy9dPgH/AWA7Mt239c3HbpRV+d+pTz2ip+i4CpqQBTl2GvCd7d9tgO6qupRsrJ/Bzd
         unbba4Hctgj18nwCA5cqAazUKh/r44tpbiqS50BW4LijFanSu4bWQoOM0gR3cVEylvas
         boiI8dUxcKKFY37xZhVNIvHjBR3q9hlnMy2dBfdtPiW58hV9WJ76BW596sFKSo7D8iMH
         iTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675008; x=1791279808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MMNDGpCcXlVn+K/qHQzmlZIK4VMU5usMdqSK6Jfjkss=;
        b=XTkQz1Bi+aCKCz6lOhXGm33MmeEdTDOmrzbw2w2l3G9xF72VgQRH7VsE7hX5QBVaqB
         xpDavOlzRB+1E3uYIfCnhjm8RRmnkg3D3XlJ0mACYf7VfjDLviR78cCAvM8nF1W11tOW
         JltotKbaO7S4KimrzaopsdWJFES+MN9wRJtV0/1pgOXCgvHyWW1xvuAGbf/LRH0lq6is
         x7sf1hJIigVme49286Lhmb8JTi5IwBI75Hf0VZzVnNrmrpA0dCoVmxwOPdjPJPbwV1Yx
         /JHxkZUNfm6eSJKGBAEpkE/UrRdkSdXA+erBNgwMNDQ2G+YnAjOBZVM8lW8ZtGhHZOy4
         Yc6Q==
X-Gm-Message-State: AFq9FYJJGBiFrdfGdGE0W7/bHpULH9pEyibs57CTwPznfHeDZ/u8TyGB
	Ub99KCgn4i+kXNBNE0g6CuhOv6kbFhR8jL5jmfz51K1prL4WXoHy9qsT
X-Gm-Gg: AYBFou0isJb3buXyC2qXZk/dxWliUmH30X1owoN1btXARGeERqQQTOOSn503qUE2ZfL
	EstKG9V+vTdxEl8bB39pwsjZIj33mEBxlNhxXpQI01D2aDvkJ8NCECJq3vRCbdJl3RofQ8BQ1O0
	RtHiDgNzaG9Cr+j4faurb520iIvD1J5SFJRidYV836JiX/QgBtDgqBR+t/xuptHwBE1NxfsWIki
	jIze28jsi+R6rirVB9Zm6RA3fTRXOczSnlpUBp2ddvGn7JtZqEvHBR+uk0B2I5oTqINQVk+cR9L
	4ZiNt/JKDPEwY356q9xZA4lB7X29Ft2vvCYxpv0Vczen+RAgB2JuD+9viS7ec1IvR8E/HAAomV0
	8BWhTCXDrmMNYwIncH+4dk9xDums4rqTF2ryMtI2//Pcxowqal099smBVBt2PTRKHHkAfMQ3QXV
	M2fq32Lert/Cy4tgH/DfSJLkrc+3biaYh2ubxY5zMLQkC54TBx/eZ+zxEhhQ==
X-Received: by 2002:a05:7300:3e95:b0:33b:c29a:7c3b with SMTP id 5a478bee46e88-3426cddfb00mr11220105eec.0.1790675008092;
        Tue, 29 Sep 2026 02:43:28 -0700 (PDT)
Received: from evangelion-g ([2a09:bac5:40e4:11cd::1c6:2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a4a5ecsm36247742eec.3.2026.09.29.02.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:43:27 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Edward Cree <ecree.xilinx@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH net-next] sfc: fix kernel-doc description for efx_ptp_timeset
Date: Tue, 29 Sep 2026 15:12:11 +0530
Message-ID: <20260929094211.48125-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove excess @valid struct member description from

efx_ptp_timeset.

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/sfc/ptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 6ca9a75af01d..00cfd8d5b46e 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -193,7 +193,6 @@ struct efx_ptp_event_rx {
  * @wait: Number of NIC clock ticks between hardware timestamp being read and
  *          host end time being seen
  * @window: Difference of host_end and host_start
- * @valid: Whether this timeset is valid
  */
 struct efx_ptp_timeset {
 	u32 host_start;
-- 
2.53.0

