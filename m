Received: from mail-dy2-f40.google.com (mail-dy2-f40.google.com [74.125.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A53C5DDB
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879378; cv=none; b=jhNNtl3NIQl3/BLBno1mJMQZJDq1hDGfa1KdFbpDpEd+qa0teN4GVWgzcEd6cIC5eoKtv6yFdbeHxwKdWXjPkvMKs34exLyrzAUvscl67DR19FGjs+ejnBYftkmSNkFnsCEbypziL6MN6ASeGSQEh6KYnnADDIq3dhvndbjXD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879378; c=relaxed/simple;
	bh=i39JXqmYvD+XNNv0Kh8aPCXHi6VrE/TIaE02ID95wWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boc8t+P8ae6xyo6D8kgW2FnLKlXYwl3DWm/65s8PDrJiubHOpjMwcOSUsKmxcaqgeDsfTvQMiVave+x/ihlhxSufDBasXiVc81NQAX1GXbhAr8yMwqgg85UaGawU4edml7LOr70cwXjZJgMlOZpLvoKtVelUwnCKstx/nLt+yAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeNBTDpF; arc=none smtp.client-ip=74.125.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeNBTDpF"
Received: by mail-dy2-f40.google.com with SMTP id 5a478bee46e88-34ef63eda66so40574eec.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790879376; x=1791484176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyCdVKYeqbUD2FjDh2ZaOn3IuqAWBAvX9Y8VJFP48H8=;
        b=YeNBTDpFoHjZBpskPgjztw0WomC6uAqInB3e6tzoeUcBshBtrjz9tygbja4KF5iR/B
         lFsuqjFkDTkR3vTARBkLb0mzG8gc3xfgHsNkyms04GKByQUIOR0nJjPSLb4DIsZViq4X
         TB95aGFv0DP5iVl3xqAeWe/yB/CyLXtGHL7XdaI5/0d2/zUdpzv9qaVKacPSoEc/2rzA
         WEd0wJPqnQcXEagF4Hx/68caO1ePicicTg8jvuWcNfGjQfDX0ro0rRFMi+U3WZd1vL6j
         jBv/8935ROe5BIK8LyzVvEfOFgoiqlJ3q+LdiRS4J9PLOZmMKf5FKobL9CZ/qAEmd4rp
         0C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879376; x=1791484176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lyCdVKYeqbUD2FjDh2ZaOn3IuqAWBAvX9Y8VJFP48H8=;
        b=swGf1w81ZQ0mgq4wwX/x8EYCGcTEQQBSRuDX22aKOHRQguFxdRQpoXk9Vi+RV0ao33
         sIEoUwSr9nBNkutFHvzzQkppaT3+1bgHxgk31Trd7NkWB+mC1r9J91eEdAk/j+OntVrr
         PknnJiiTudsTwOA1rG/DaQMS5w4C83dQOkTTR5x+daHeSo7AdAkgDBOxax+TH/v7Hg9B
         ymQqToYR7ZiHHRDrM/WhhTHBcJ39IN009mtry0DlK2mQKjs1a6PR9T7KEbGR/OhKAjua
         HRTvHBc8xud5Q4qp0wV7sCoSvS0m3ri7rZnRs65LFFEfL5KD79Upieg1HJSVR7Q1rZiK
         jM6A==
X-Forwarded-Encrypted: i=1; AKwUvBz8YkpaOfyn4k4Mot7gVywimnMkQlL8bhRlH/4lPOFVeyMx0HJ0zi+3pFH9tR4Xd1drtAlC5rc=@vger.kernel.org
X-Gm-Message-State: AFuF++l1aCgyTr3uc7jdm7b2RvZCaMtsqVH5xanl3jMLVmSmM1KROmVq
	urZd6WdRKi44/EvA4H+ZUkHbl+Bsmpa6od4otm9LMKzPklfoS/yBbgDH
X-Gm-Gg: AYBFou07exzYQJSGZxi3zj7erc3t0XkDuB9JIM/6tZ3IImd5yVVoWoJyltj4KEY0OBg
	ar5AsWBzUWK0f8Wd91QIF1M5eQA6KBgjzsiJ9geVlLwdb+xMrs+O//FvC8lytTw2uwKn+so6p4p
	a22cbcSDFjCVCZmPEvYDiNrqOXpyhrXJOP+tkok6+kggztJPfsXLEpOfEOQh1bqVKcBf5it1XDe
	ZcUxM/3hC2XbjGM0B0995iJe1yFmMsqwk2CzYJ2ogrj0kI/kY28ztZ+LpyEOIWPZeOu+upaqXI+
	qk4qiwzYffSUJaGAS04xJQ+91byHqbSH0RrzGBX67bHo8ElwmNDmUNfaH0mXFzcizgGGfmJmp3Z
	cSnSK4p0bsGH0e3XIUhEUHowzdASwFhyYJ4FiAJPd7QzviDzatDOD0zbBX5Idq2p4FsTkdhdp9k
	2FeseBbcohrlyjFR9J2E4hqEbcMkOWAV5wlw5zs5xLcaLN4GEThoSegDPq5grU/KS+eNRf4RhcJ
	dS6uWEJDXNOECclPZMgyN8ezh1I2GY5K0XxgprYlnL+ysE9lPpR5nTV1GFpKuFNjvdV+g==
X-Received: by 2002:a05:693c:8858:b0:33e:8552:6e06 with SMTP id 5a478bee46e88-34f06674f4fmr266687eec.0.1790879375908;
        Thu, 01 Oct 2026 11:29:35 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f43eba13bsm390711c88.2.2026.10.01.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:29:35 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net v2 0/2] tipc: fix publication lifetime races
Date: Fri,  2 Oct 2026 02:29:22 +0800
Message-ID: <20261001182924.3928331-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
References: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two races can leave the publication lists referring to objects with an
invalid lifetime.

First, tipc_node_unsubscribe() looks up the publishing node before
unlinking a publication. If the node has already been removed from the
hash, the lookup fails and the caller frees the publication while its
binding_node remains linked.

Second, tipc_publ_notify() retains the next publication from a failed
node's list across an unlocked interval. A concurrent withdrawal can
unlink and schedule that publication for freeing before the purge
iterator advances to it.

Patch 1 unlinks successfully removed remote publications directly under
nametbl_lock. Patch 2 moves the failed node's publications to a private
list and selects each publication under the same lock, so no publication
pointer is retained across an unlocked interval.

Changes in v2:
- Split the original fix into two patches.
- Add patch 1/2 to address the unlink-before-free issue reported by
  Sashiko and remove the now-unused tipc_node_unsubscribe() helper.
- Add the decoded causal call trace requested by Tung Quang Nguyen.
- Explain the ordering of name-table updates around the node-down
  publication snapshot.

v1:
https://lore.kernel.org/netdev/20260927180806.1315902-1-nicoyip.dev@gmail.com/

Chengfeng Ye (2):
  tipc: unlink publications without a node lookup
  tipc: serialize publication purging with name table updates

 net/tipc/name_distr.c | 36 ++++++++++++++++++++++++------------
 net/tipc/name_distr.h |  2 +-
 net/tipc/node.c       | 20 +-------------------
 net/tipc/node.h       |  1 -
 4 files changed, 26 insertions(+), 33 deletions(-)

-- 
2.43.0
