Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACD43CE4E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818104; cv=none; b=fQNxEAo5jMrLnkoCbWw6Hi8KA/ROdh/SbcujJW91u5ONM+KXCuTCz4fx34XYf9VEehhBOMLzxukpBB25WQ2YwL5w8JhFiarqNVCcVtptQZlh4xdSd/pE/dPvXVJn4zVwIOlfCqz8DFV0SM7kFZ01nOZCgOy/7grCZTk9Q1wrP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818104; c=relaxed/simple;
	bh=5QSvUUBEwul0t3wOfYWCRctJgwUlnqFBztayCoeh9K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hooGK35xQ4SX0NwjonZsGDFov4/GW2m4UZrLGp6hB4qKMbg4A6Yt7SSD0ckfTCdE0zLU0u4iF9LZ1xwxtXy/EwfvJstmiMoFctLs4RS2vBfxxWws4ytGY/zkb8+SJ7Xt41x1Cbft1GGNiIjaQpMSCePriEdoTGtvAn6aEuR1IHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghWEb/Xn; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghWEb/Xn"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-865bdc6ed72so66848077b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788818089; x=1789422889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kb2gmiVIlb5vlxpKkwwNuzRtWNaOFk2YDHgZ7G5RM8s=;
        b=ghWEb/XnNyy4QmDPJ6GZIOY2NBsnV8RtAhU7Y3YaeS+VYJjDZyvQh6LE2C+50My4g9
         +yXdJphB2Sd2yolBWiyE6e6h7gDNhCjTrPhoppjhQOUDoEnRzIe2bokaeDnDv2tLvIvu
         AIQIQor6M4n/ikeOgcIDVCPlhJq61TvzWtsYGf9Z2HFvkiOlu53dkIhto9bF0aVxK2W2
         wSZi1qJFlUIpX7lM/rAV4JM6odFIQktAV+g4KkvqIrZxrQbDHvu9I9HsQ5FeqPgVeU0W
         hatk3X/z/J05tREj04viygGS+rgnX+c0IOFASyhpJAhkNLcKq+wH/0VHMzjUHDyIaaWO
         GQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818089; x=1789422889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kb2gmiVIlb5vlxpKkwwNuzRtWNaOFk2YDHgZ7G5RM8s=;
        b=dToU0BkZMhDgxYSgNpTwC2hrt8/nY7TSZkEBCbrgxTNhyNWZvXFfvvKznt3u+CMIxG
         13XTHc/Iz7vO9I3Mcv9dMtvKo5EHXPxAuZlW5QWye4U8olXrhpAuK0H1sJ2Npqr9QP5A
         idxX70bQ3RMPaPhf0LPBTB9TynQ/AI2K/xMCm74IUzE/Bye8k7k+470dlMttNCQwABob
         NAYuFW2MtCdDQrsNDynpCBNHpjMP0AqJ8VVjlRS06qifso0lNBb3yD3TkuYu0IuhsX7Q
         d/laGLuAGKK7X0syCgG0c/vv3JROWPCNc7g0XlDfVJYqms2nL5F8U+vLEoNcvgkQf7Kv
         owSA==
X-Forwarded-Encrypted: i=1; AKwUvByRpOGvyNr5zq6odD4RkpzLsXgRLtCYo881rzoJsftbL0wbZ8YIl3YonoOOx8GK/J+HghNm+fM=@vger.kernel.org
X-Gm-Message-State: AFuF++m62LtrTn5Xobxxcm5dta1KwjcTqgzkxI1CMG4mBMHQAEKLOI2E
	aOkPbD0CdUe03bq1lKOROb1/3SYyndX9m94gNbyw1VmJUB9I78/nFCJt
X-Gm-Gg: AYBFou3GHDdm+EiqtG/Vn1Ua3rM5Hl568eWOcg7k58ETI3ZTgcKFcI3CU8gHNPAKoum
	uciESB8SFgauBjQLCV1dlKibhanqZjrOoShl3TEMxaQTIriPLDZFC/8fI2wH8PpKj7Dehtr5eoL
	Kecj6e0hK0pgnK6A3DuhgRRNIXNMBTY66Pj+lNrhCSEoQBWy129qWRuIZxU6UxHmhaPSIilo6ki
	uIO4DFE2tMq67pfXfVqEQfY60KeSlpUECnPsZY5R3pSBptoEVQRlFIis0UpruHKubC+iBaIlYYo
	kD4ELli28nyJCjUKXeLCnnzjjlmk+9G5nxWK6lHqlsSia3HBo/b6vC3sC71OeJqrZ5uXueRORMK
	1KbrGgMZwufOvowDswH6qCEvEoA5mrA6TMfRAKhiKB1DEPsrOkgx2bOH9APyBGnFfFlMJVspF2Z
	o73j1jruNB7FbKVxLDEWpT01DUmr/IfrMJ0z6GQtG4pUN1uCl2WZLWGvMkwBr7ZFaogfW14nPxN
	NTt+0OU+LaUSFumIA==
X-Received: by 2002:a05:690c:4adb:b0:873:5bd1:98c3 with SMTP id 00721157ae682-8735bd1a0damr49302177b3.53.1788818089522;
        Mon, 07 Sep 2026 14:54:49 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439bcb5bsm78484247b3.3.2026.09.07.14.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:54:49 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 9/9] MAINTAINERS: co-maintain linkmode.h under BITMAP
Date: Mon,  7 Sep 2026 17:54:38 -0400
Message-ID: <20260907215439.409858-10-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file is largely a wrapper around bitmap.h. List it under BITMAP
section for co-maintenance.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..b78f0bccff54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4646,6 +4646,7 @@ F:	include/linux/cpumask.h
 F:	include/linux/cpumask_types.h
 F:	include/linux/find.h
 F:	include/linux/hw_bitfield.h
+F:	include/linux/linkmode.h
 F:	include/linux/nodemask.h
 F:	include/linux/nodemask_types.h
 F:	include/uapi/linux/bits.h
-- 
2.53.0

