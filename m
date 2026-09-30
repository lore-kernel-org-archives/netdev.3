Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33A3E3DB8
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759307; cv=none; b=FAO9jeIDo/WmSg47f2a3bZbwpcji3sy6Fkd3yOyfchKIoT52WEgujkEbpDYj1IFRzTi0bin5le/y/ZBZV84w9bznR72eWrEL4fmjCtHPoDzbTGAiNXjYBS+awkUPoE2V3YsuBvKkl1YT3S0QtTo2Ul24RUScoOqn/Qhtbiqhp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759307; c=relaxed/simple;
	bh=O8B46aZeTmy6k5FEdCgodDcPNx2x+6ffGJZ1jHF02jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYn6guXpeJnImjuIT7JnO+wiHnR41acQVXGnEoHhxiuw2XJ+GZsyXT6DDWsL1PbWkC5ZvySrth8gzDuC5ei+r+DVR1wHvzmtkZ2XeP7h2JRGvDNMDRuJjSvohwgptlzuQ04W9JG069AhV6OEgtdnrMrve/jLyK6GSQhzB+BxWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEQ8c01t; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEQ8c01t"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a4a33ed59fso230136a91.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790759305; x=1791364105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vaVic4qoDP2w2wGzJWUozbbrI5Ibrd1OOqs1hm+kxSQ=;
        b=hEQ8c01tVl0DDqjjYQZRADg+zvqbQ4amNScOLES7lNuUtMJ4EaoAc9vX6PNMM1ceJo
         F5NjB2AfVMVj1/c7gOcnvmytNHv+nQRE1Yplh4fnuXk96+Q2Z0migCQ1HXc/vLSnhNHf
         GBRjYzQOsea8SBP98yclnwM9zBkbnfdYFbg/Oa/OMlSEuvgc7mKFL9+JYKBcVJCW9jrL
         vkEHgDJlmhJvY53X9cN3FsWt0oVwjvEJdjW7NNvjcvxlvEcJjGPHShZuyBWkkdVe+lMg
         hOC9qUHU4ttoyoaR8nRjSvQ4iEhtx+cIryzZhxXp3ZfNEBUUI0JwmiGIzTygxVwfjczg
         au5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790759305; x=1791364105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vaVic4qoDP2w2wGzJWUozbbrI5Ibrd1OOqs1hm+kxSQ=;
        b=acJSfEui60EBh/5snezOwExEY3vaXGqHo/ehT2/om8cZ8hHQYTmfwi8CewjETurd4u
         EGFDtVfNwVqeW72LJni4MDe/4lWbzX2qOZ/acESJVN5nXsW4C/A70GM+7v8OJHfF+lxZ
         fhOyPFdiZAjO/ZPUqVvJCVrfzJOlt1vBk4shzz4Ucn5PImlGL+AveXLHTg9f27qykcFP
         xSTOkCxz7ryEftCbzelcIf8I8iAItSf6K1SyKJZzCDrRqM1DyfDd74//bp84F+eM+DBt
         5xdEMIsIWRH8d+ShiKv4sEQvykjejO636QdE3EsfTBfCaMuS+tRc3cGm0LXscpoV3Z8p
         N7Tg==
X-Gm-Message-State: AFq9FYLa9kGmMMI5txou2nkSW4xE/YqJheaw+uErYLGlK7bVNy8I6fiN
	34t6AY+z+Usw7EUlMOkIu32QGRbNRSH5n4Sqt533gtzAZpGsOCbkaLKnUZ9uPRhSYY4=
X-Gm-Gg: AYBFou1o+1Pwfz97eKbN0CnmCrN3g8cnpsJL+wQL7tjwZGn2GB6GNr0mSibDSZ5YZhb
	BnTgzP0qopLBGwL5XxxyIZ8Z6XZtJ4Equ3VmZvN3g27YuPo6wikqU0nYjgpk3WtJUWRxOsP8hJj
	G7SHhZ3cUDCCkCmKuqUS/rfUPTYOcVBJ7nHDF11Xa38advUv5875yJgVmjL56Ph6fZZYliwSz6H
	chZrBCgFCgjQ2k1kna4vKiXAbCQuiWPA9v32QQ7tzKZHvaEC6Drcl0S13S2Jv/6ZPTZrWCpYSGu
	JjygVC6VA6Gk2PaZ82xUFA/ifCxmS0K66RxOK5DDeDMC6/v46SVPXDSVTX4fAKP+ixkigV/cd9K
	8xIOfBMsZJj3l1owZkTiYWLj9wawSrEpuAaR2zdNUFIeW79uYvp6lGi1tWtZ0Q7QzKpMJWewwOX
	zicjUI5LcfGwPfeOcuwZtCdxtNYAWvnzuFc7XAvdKzdKSCAAIiok0ihd5izziw2CQWYmiR0n+d4
	fzMIVnNVshdaK6V46i6PpLESItgIogCQtCjkL4dC4pjV5gMVp/P3lBFr1sZlQ==
X-Received: by 2002:a17:90b:518e:b0:3a0:238b:db4d with SMTP id 98e67ed59e1d1-3a4d1b18399mr1082273a91.5.1790759305124;
        Wed, 30 Sep 2026 02:08:25 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cac328c6sm2578059a91.12.2026.09.30.02.08.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 02:08:23 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: [PATCH net 0/2] vti: fix tunnel device use-after-free across async crypto resumption
Date: Wed, 30 Sep 2026 17:08:10 +0800
Message-ID: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vti_input() and vti6_input_proto() cache the tunnel pointer in the skb
control buffer without taking a reference.  With async crypto the
receive callback runs from the crypto completion, so a concurrent
RTM_DELLINK can free the tunnel device before the callback uses the
cached pointer.  The existing rcu_read_lock() around the callback does
not protect it.

Patch 1 fixes the IPv4 side and carries the full description; patch 2
applies the same fix to the IPv6 side.

Qihang (2):
  vti: fix tunnel device use-after-free across async crypto resumption
  vti6: fix tunnel device use-after-free across async crypto resumption

 net/ipv4/ip_vti.c  | 7 +++++++
 net/ipv6/ip6_vti.c | 8 ++++++++
 2 files changed, 15 insertions(+)

-- 
2.54.0 (Apple Git-157)

