Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EC380FCD
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373075; cv=none; b=sSnHxttlKvSgCYMHWhmuLa0bsQeZixmqoixCMegnS7rZzgBJm3Y4bsoKp8Aa9zM/EthDLOfchAYljJgCaWoQRT80a5creXy3GKKonBQGBGgPhLSddbzoX7+xMq7vOwrBDL+nitsRhbbmnbG2TJ/zIvGvihDX+TjWOmEj81iZVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373075; c=relaxed/simple;
	bh=FIvSl4PT5M8wd2L9jYTo2dqNn3AMqaJytiBoP1qEqHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aE76CshNZDfrtOxbb60GNSonu5wpMeArLuC2Sri0trLYVQGULQs7OgWgtW457NqnNonlsLYYeEgwurqjsIFhFWHeyvbS8x+/84XHxKLw+bFu654UuxvuWmC/OEGZ/IzKKKDMd0VJwfsfWSRoNpFMM/ZkNT0ij2rQkB/PrKW44KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNuikx9Y; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNuikx9Y"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-86a29a48ed9so17567967b3.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373073; x=1788977873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fk3ssK/NaqTImHGXbrUIvdUPCFHN5JxriIUvdrQJYnA=;
        b=PNuikx9Yz1NSDYC/fpWm83C/FAKyv2BXEKrNQt9QyJ7M8kmeFbc1V/8/SLXpO3TfaT
         O0/Q4dA9Skn+NL1CC81dqAxTJ2AEb0JE+SPgGFS8iFitvjlukdEYaBC1bCRkbMOe3lTW
         V1WxDa1Yr5SMUqm7LuZog5kfhIj6yckYdeaKnMoLeCu8nLxFW1irVdbLQ3axxV6pSXOQ
         fSVWGDRIu8ZxmkS9atIEFRMjv9wvLxjNFSOpfGsyVzJBAmFebtRZ5qq7m1FINMI3UvvQ
         QNNaOxvQIu/Fe6C2X19ILUBei7BHvvXOA+eBKXaSpFlFfvQ98XYr71+lvh6oHdJPUa38
         9PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373073; x=1788977873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fk3ssK/NaqTImHGXbrUIvdUPCFHN5JxriIUvdrQJYnA=;
        b=rJETrDdR4/CD0rP+YFVrUV8PHDzuf+ceq4sHSOjit25NhvXX0KAG2fGEKnqQnsXQaB
         vWrz3Q1L8f/F26IlWDOeoYofh7m8jV8/fTAU8bN7HlbG0dV98F0CaPF513AffuA23+ON
         OLmDwOj2As8pSpRZwrd2bZfw1ConBq4yYDZ68fzzRHJLl10XMykMqtOcOs1PpILoe7I1
         bFG1dv+1rT9a+WIJwqkkAUdohqqXXhZUnL9vSmrCjB2xx4qzIJZCw7cyjlLtTLKCnxve
         CW7BmIdKI3ukFLEVhsQHFqBGP6f/n28xyef51i6Rg4sEdIlspdmvwsM78JpMfK0xdiLT
         fzKQ==
X-Gm-Message-State: AFuF++l5kE+mp0DZV0sa52Kh0I+n6vFOeTEZbXf9Ck7oz7zpoR+3yYmI
	EG7GZ8r8PWrchKWNjBr+gLl/lQ8lUT9g64fulsQqSQ1cxZEKucUT9pdptshm8w==
X-Gm-Gg: AYBFou2As+yei6Xxv1wFVnhsAsdXzzdqTEGIduJ6FxXDWpPPginqtCzUTaK0nMBofMy
	R9z0KyzIQBfoLMwT962QHADdLiA6ao2BS6RM1uzu696HVvT93uNP/bPuTHKJK+W+XbPVRz9gPWc
	bTg7GF/Cg3Cyrdh9PpMNIR3NlnXiVlLNWzd9nX1eNvPCAzUPodG2AmYXjBxnSt3oIPHzC/Icz9A
	WkTWKM5eLquke+5+vtunqcoVdFnipOIjINQXeenj6uVVH3/dyPLhlhb5Z3hNUflIv5DRAEpo3XZ
	XVfxERrAMekc0INzsGui6BxXivMZM2wDQX2LP5gkW92UcVjyfv0MVNxDPqOgqEsARx1S8cuHuCs
	YBHV4UnwAUSGCoUUUo9Ko2zvNNGcxm5WD0nngUyYjP8nDWzroTO5EqvaDoZgbT/BW6k5yxhkq5k
	YyDRe+Ytadb8EjeJ84SkId9ryoJTZWjCTBeqbWJnAjnMrO1OjYAcAPXpjC0UfxrPrBUY3zsp4bB
	YbRNiBXrvycHYUTNx9PoEVTgup7aO3kl2FItd2UYzkBMn+4qmaqwKOnbWhXaBLW
X-Received: by 2002:a05:690c:e3ce:b0:85b:f1ba:b111 with SMTP id 00721157ae682-86c533981d3mr26928207b3.26.1788373073185;
        Wed, 02 Sep 2026 11:17:53 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784192bsm23162297b3.30.2026.09.02.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:17:52 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v8 0/6] hardware pacing offload
Date: Wed,  2 Sep 2026 14:17:10 -0400
Message-ID: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Enable safe hardware pacing offload on a first device (idpf), plus support.

- Add rtnetlink support for admin control over the device feature
- Add device support to the idpf driver

Besides the main feature, also

- Small optimization to FQ offload: avoid unnecessary ktime_.._get().
- Expand so_txtime drv-net test with hw offload testcases.
- Expand pktgen with txtime feature.

Details and detailed changelog in the individual patches.

High level changes:
  v7 -> v8
    - 2 small fixes: unused variable in idpf and new ruff warning in test
  v6 -> v7
    - Rebase onto conflicting patches and address feedback
  v5 -> v6
    - Address substantial opus 5 feedback
  v4 -> v5
    - Rebase + small kdoc fix only
  v3 -> v4
    - Replace ethtool API with rtnetlink
    - Drop/defer pktgen patch: not essential

v7: https://lore.kernel.org/netdev/20260831213221.1370774-1-willemdebruijn.kernel@gmail.com/
v6: https://lore.kernel.org/netdev/20260813020529.3506539-1-willemdebruijn.kernel@gmail.com/
v5: https://lore.kernel.org/netdev/20260808155217.885299-1-willemdebruijn.kernel@gmail.com/
v4: https://lore.kernel.org/netdev/20260806232913.4020403-1-willemdebruijn.kernel@gmail.com/
v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (6):
  net: rtnetlink: add pacing_offload_horizon attribute to net_device
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload

 Documentation/netlink/specs/rt-link.yaml      |   6 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |  12 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   6 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  66 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   8 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  60 ++++++-
 include/linux/netdevice.h                     |   4 +-
 include/uapi/linux/if_link.h                  |   1 +
 net/core/rtnetlink.c                          |  21 +++
 net/sched/sch_fq.c                            |  23 ++-
 .../testing/selftests/drivers/net/so_txtime.c | 159 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  74 +++++++-
 13 files changed, 387 insertions(+), 56 deletions(-)

-- 
2.55.0.970.g62bdec98f9-goog

