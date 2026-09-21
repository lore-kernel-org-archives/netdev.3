Received: from mail-pz2-f34.google.com (mail-pz2-f34.google.com [74.125.228.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF24BE44B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005339; cv=none; b=WdN69Fcw2ev030K/mAdIWZ/+rEZI8uc/zNRkSSPYchG3bUfVCm0KRfijTr22bGNZUA7AkakoLsFC9Ks1mfr8imTKYduyAhgedetJBsvR5IBbPUi2WSyae7rkqjEpW7EsRvPdFopd4RwfPsHPM+4xsKp+FDZX4oMKUygyqT9thUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005339; c=relaxed/simple;
	bh=jpe40CSLnJR+ASP1Jg44D29KqeaY3jYEo9GeCz6HsyY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U0odN3D/IFXdE3oy7dP6rvdtCDHEucb511p+CgMgFKIOUm5FAVPsRkV0Fiu3ueqHm3rRMHwtCmzH4LmZZ5ZNcrRejL6OjnxcFG+OAfYXTKUiSZHYunPCF/eGRuR6VPhgMKs+X+Q7jk3OYIZox0t6NmsleIXUc6SWtkbrz/U0Igw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6VH7ZXN; arc=none smtp.client-ip=74.125.228.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6VH7ZXN"
Received: by mail-pz2-f34.google.com with SMTP id d2e1a72fcca58-8748f34b1f2so2982196b3a.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005337; x=1790610137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRhjynb+XOldg80DbanEpxDJlHVPgFhgfFcVSMcrcWc=;
        b=Q6VH7ZXNYl2ryaCaKiai35pgt4ftO5aur89FU1BBqVA8oFNg0j9Xcl4Dhu8HVirwpc
         YBsY9n8T1pHnCeiZzlfuH8hQ8tU2Kx7AIBu2crZRMcH/cCce/GN4jA5fkINWT6drU/Je
         NAYbfbsMqK6dlf+dwgJd9AXjj4Fo1WlL00jNIwlAUXT/7gPncj57r272Nng6w2jRh8R2
         l9idaJPYY7VYQhaklOoaKcisyfFeGUnx5w3J91d3u44T7dXVxc9XCPG+IMkhEWW10azL
         DktYU7565s27YKVffV5WtcAP3QLpbd1YGjvIEBuyIlRmXTkdG6kIY+7/t13IWooDnv6T
         oHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005337; x=1790610137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oRhjynb+XOldg80DbanEpxDJlHVPgFhgfFcVSMcrcWc=;
        b=CQGQ+0Vi6OyAhO3ImB3BGGN9ak4lvjmwo54CC/5WTXrZ7ASpST1xj2OYjQ5OJpqiGO
         bznn2t/iOJe3JDJHxygWjHTnKUh8vMw0hO06XYVyDexsAlTgJFdqRq7x1nKONCTj+1AC
         exVfWZd3/Aku530bZYz4yoZtyDdEsOoZ5o7iK6F6FZLOF3aXcO3LE+Fyuu9rC9YH7Vq8
         nOB1VC6fvz6d47Dg9V2IOFUCBYBof6e7NUTGs4360UgZTGxeYHMrjiCOLeRDzwUn/PWe
         xT3M0g1Ygbjw2+ZHws29y8K8KJeZQ/o5Y2UTQCX3PgdF9rHbU3vlz5kpAa3xPQHE9lFc
         VMcw==
X-Forwarded-Encrypted: i=1; AKwUvBzNUtcTyT7a6i3ciOOHf5vPDHWvacx3i7Igw3g90u/OJsvJAaqHiRiDiXBrWet+bsOyfvuBluA=@vger.kernel.org
X-Gm-Message-State: AFuF++mqufV+kFKtIf/Fd4Wr4/UvwgdUu02fCM1Rj2exSRVgMoqRaPbE
	2/FtcCbYuJb/STkHzeFYCsDMigmZHM2hZky2j2MoOBHdUK0WzU6uxQYa
X-Gm-Gg: AYBFou1u4JNnGZKYGFIKYp0mB94SvQ8ZbV7/P+DL3j0qKMRR52iNdVp6m25r78TOXd6
	ojKvyBUa2q8vMBgLBfpRi+AeE9SCqpyt+73a8wOK2xb/nvmxALdSVX98Ie0Pw22TGr/Saetq7HH
	ufHCGBHo+pyGB3bGFcXVqhkEmTOTpGDUcV57vPxj81U2D+atrWRerwhIVNK62tVLEvZkSOS7/NR
	m+AxD/RZPkmYo/af1nPeUfP1hYhYjwJzGoreqWEwYOQzHeotSU8+BYIbYfS73QRS62AaVxTMByF
	GfrpZagaymf2OmKciN7tWRCsTD6RjAlkbvt38b+TGtW7JaVll/4rXNvyVoUtDlIAJzzp7PIFdpm
	NFp2NbStehKFdLklrH65rNMaMiDD23a5/iMhFJ+S0uLKBv+9qXOrOr+Rynsb8OolPvys/PslR9I
	yUT0l3i/CEJyjSnJOFKxxpHkDGGwVXw0Ovq9JJ4DKzCyl2dD+WTTqZuQ==
X-Received: by 2002:a05:6a00:8008:b0:874:705d:f64f with SMTP id d2e1a72fcca58-874de006378mr14763780b3a.29.1790005336524;
        Mon, 21 Sep 2026 08:42:16 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa70200esm3449599b3a.61.2026.09.21.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:42:15 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Amit Bernstein <amitbern@amazon.com>,
	Netanel Belgazal <netanel@annapurnalabs.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] net: ena: fix resource cleanup on probe failure
Date: Mon, 21 Sep 2026 23:42:00 +0800
Message-ID: <20260921154202.471662-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two resource leaks in the ena_probe() error path after
ena_device_init() has successfully initialized device resources.

Patch 1 adds the missing PHC cleanup.
Patch 2 adds the missing MMIO read request cleanup.

v2:
  - Resend the PHC and MMIO cleanup fixes as a two-patch series, as
    requested by Arthur Kiyanovski.


Guangshuo Li (2):
  net: ena: fix PHC cleanup on probe failure
  net: ena: fix MMIO read buffer leak on probe failure

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.43.0

