Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E664360EF5
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274077; cv=none; b=MXEToZgLHdXYymb1oAWL184mnxQjtsxl4QrUwYN0YXX39o/0XVlv0wjJX9zpBW+mhkvbqZwdioNFnpGfHOBjM/b2VN5eTDPak39bUeaJGoih5BJZG5GJ2h9uzrvlQJ7/53rdNQPKru1rq4YNdt6tsDdOOWsRgHUFBLHBWC7ZFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274077; c=relaxed/simple;
	bh=bqnDidL0h/ZcQFW836nIF9vhE8xMk4iT7WurfKQvwcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bg6cJ2ADX4gadPuA2wcb9zi4lnwvtUXgU9dcbGbDfTXh2QAGgDXz2NPpjfCPfkoUmzVE751qSBdFO6zd2xYNOB/NIHnaeIxuQs/CtP0YSGzMxySSF4itAQaH9GZLhujnh1T33sHQ/Lhujz+beSgGRKSQS083mAUtvd170YGq7f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ude4K045; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ude4K045"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d560775ca2so36039815ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788274075; x=1788878875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hXcMG77ozJuXk/Ixzm8x0lK3YDKIcZWH78CeLX8unbw=;
        b=ude4K045JsbqAOmMb6CI4wtFRbgoLVP2kpyDF56PHLcp702uKhALrFEMEQHhaOXXRF
         YdtUdGtifbyJeehKatkvXLcqvf+RdTQSygO8ZgxVa3VRrsEEZml070JlGd/OipBG/VOb
         ls+UY9vg13qSgOn/xg4dvYRUFyWbStOYZeUFgQyGPfjXmLvdRHjaDIvRnIJeXOSPjnPA
         1rFSYAPW6SONBL6kAmJ2Wj/4VMErFJniWff+iCwPunfjnYbEX4fi1y3dqWWq+3uQdM/I
         BgONaufYeQFTgRQyR1kdk+yyippZeE+rZN2pd8rICmT95c7Rh8wC00J/kb81PWi/4jMg
         L39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274075; x=1788878875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXcMG77ozJuXk/Ixzm8x0lK3YDKIcZWH78CeLX8unbw=;
        b=oA1DnvlxUBCobJ8j+KL7OSHoloKSooJB9TPmMdgKyiyFdH05bVWOjvKB2a9YuLvH7N
         PmG3KAfOrpCJ1h50O/k68onWs5V5uE+Yii02RbPUN/k6udE7Y5QD3NNudxo09FZOMmEJ
         maeJE8DOvYWHmTqd6j1fn7AWAOmG5WvO6YYEwPOhZgZa359/YqBD8HobwI3t/E0JQUSL
         KJ9b/LWM09aE/ApTvyY+t7utMDW4r6q1QFdMLfZzwtYJcn/rTj8335UT5EUk4cLAnC9B
         yZ6ajyo9QKdhZa9DUPShxN7r0aJiB+o6yj2mTVLorzI8MdKW94yjL5oOqo1QJzNab5B8
         GsMA==
X-Forwarded-Encrypted: i=1; AKwUvByviRzVrYMQFTD64r7QUtXOag2P0CB2CB7tH89EnHC5KCd243gtAp3txBWK5uykgTH+GyTK8U8=@vger.kernel.org
X-Gm-Message-State: AFuF++nVPtE04dRKdC8nLi5dUuKahToCnzleHhTOe8NrUduto7NpJCaN
	SUIXoVHADvqpuIwzWwqWcetBR8eCEFe6d3Nz2ouwWCUNcwanKZH4Qu4k0qLbq65CEzZG
X-Gm-Gg: AYBFou1zr+tYNnGqrfrCLgeSx/+b6sTfOg68UBdn3LvEmsXNrdpoSJyHIifrdGc+fVc
	xLCUT6lACBQ4S+6zj+jXiAHxvBtCdE0ewsoxUkefP8QTUe6Ng1SRZ4CLE2esRE6boxrhCQR4eUc
	Fftq9PGK1+/DEWbWZsdZ6JqkZm4ndc9ecZbzP1RNK0z5sGGHLVy009bo0iyGIka9NmkIsga0pFu
	2gR92lYln1X4tIQpAztDMNWklnHy+T21VlatZFwCkPp6WeI52umAfTkovGp/uNyn5SzYoubKA3W
	ctliCzH+mZtD495YQo9hIWxCPDWqLBESitdn77YMUpleJYswnpGXXaW+choJJ4h7DIek5nNDFeL
	u+rBSCKVyvpo5/9NAc3xe89/52oRo5KU9d+AuNxb9mV6paJmPslGKQPdPEpx53VXnof9/1LGiU2
	P3jbHZeUKy5U/K9HYlYEc0eoZhoJwaB0bGFDwFEvJpuLys4nbfBejZyJCFKuBazPMeSnkbeUei
X-Received: by 2002:a17:903:2c9:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2d906dba09cmr306818265ad.11.1788274075242;
        Tue, 01 Sep 2026 07:47:55 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd35da91sm245975ad.15.2026.09.01.07.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:47:53 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	horms@kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	error27@gmail.com,
	kees@kernel.org,
	pengpeng@iscas.ac.cn,
	raoxu@uniontech.com,
	rosenp@gmail.com,
	dddddd@hust.edu.cn,
	joe@dama.to,
	ian.ray@gehealthcare.com,
	kuniyu@google.com,
	linma@zju.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v2 0/1] net: nfc: Fix use-after-free in general bytes retrieval
Date: Tue,  1 Sep 2026 22:47:31 +0800
Message-ID: <cover.1788157545.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi,

This patch fixes a use-after-free (UAF) bug in nfc_get_local_general_bytes()
where the local structure could be freed prematurely by nfc_llcp_local_put()
before the returned pointer was accessed by callers.

The fix refactors nfc_llcp_general_bytes() and nfc_get_local_general_bytes()
to accept a caller-provided destination buffer and copies the general bytes
safely before decrementing the reference count.

Changes in v2:
 - Fix GCC -Waddress compiler warning in nfc_llcp_general_bytes() by removing
   the redundant nullness check on 'local->gb' array.
 - Fix line wrap indentation and column width across modified driver files to
   conform to the 80-column limit.
v1 Link: https://lore.kernel.org/netdev/cover.1786029423.git.rakukuip@gmail.com/

Thanks,
Ren
Luxiao Xu

Luxiao Xu (1):
  net: nfc: fix use-after-free in nfc_get_local_general_bytes

 drivers/nfc/microread/microread.c |  6 +++---
 drivers/nfc/pn533/pn533.c         | 14 ++++++++------
 drivers/nfc/pn533/pn533.h         |  2 +-
 drivers/nfc/pn544/pn544.c         |  7 +++----
 drivers/nfc/st21nfca/core.c       |  8 ++++----
 include/net/nfc/hci.h             |  2 +-
 include/net/nfc/nfc.h             |  3 ++-
 net/nfc/core.c                    | 15 +++++++--------
 net/nfc/digital_dep.c             |  8 ++++----
 net/nfc/llcp_core.c               | 17 +++++++++++++----
 net/nfc/nci/core.c                | 16 +++++++---------
 net/nfc/nfc.h                     |  3 ++-
 12 files changed, 55 insertions(+), 46 deletions(-)

-- 
2.43.0
