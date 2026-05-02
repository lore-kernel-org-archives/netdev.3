Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34692F25F5
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777758846; cv=none; b=ba2/xRaqR8KdPsMjauy3NmdQmpSF+lrgM6zGR8iT/a3131Hmw7jyi6Bh6UU7Ywc3Q5PEHJh5TKeIRLn9QJz0aHeL88YUg1ZvLVNJ4eK8YU2TVUsaA3EUuD3aSMl7y+jfyp3HIeKh0g7QlDhrL9s1jC42DXmcz/zhV5mb4Y3CW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777758846; c=relaxed/simple;
	bh=U5aH7Za61W0x/7+XVBfewdQiy/hTCYYV/yURqrayD9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeMygj43Jq8qlg2hc/VTCLv+7Xtfd6+nEhp1+8PxHuS8qf3cCLHiB3kpVY04S93hWZsEkrChOo3ibb6s6EWVU4qwKM2i8Dz5DmGYolQ48S4WL+iPGOM2L6zeHILWH2YdYx5V1vP5/sZ/VTUq5O5ivQGYwxk0cx/17eBg82aMMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDB1sAxi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDB1sAxi"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad617d5b80so17518445ad.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777758844; x=1778363644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7flZfQhk95XsF8PTxfflJuslaoSaNUBeMCqpvskpnyw=;
        b=SDB1sAxiaCIydaquCqDQJ8ktaVuMxvsB8pg9SZ2PuGN7ZxS3vMpy4GEyFDVhpK9fIU
         7HaIDHQvdWho2G3/munYoPd7VJ2LLJoQPz1a1uVF17tUnxcSpfK7Xl/rWDsxc9IsJQx2
         7AOVgHpV04gTJNxS0KW7PHQYrpfYKZjQ9YJkF5TyCjz/qCfI90XNrXxo8uT17Pd8W3d8
         88YwVYv+jzjoVRydiKgRMnqG2XO/+qT9LRCbXCm1czSclGDmXExWMvB/3SJ1O1xrIdPC
         JVoofXqL1axbKawaTH+7x2qsBA9s9TnRNWQYyOeBI/9JmHt4HA8EdSKpN+GR51Y9T9HI
         w3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777758844; x=1778363644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7flZfQhk95XsF8PTxfflJuslaoSaNUBeMCqpvskpnyw=;
        b=DS8FExUh+hkGTds2/2UjVD70PJfXnkqaUrpsHiuuEmpAj1gvP9tFUZB1Cz/y5T3Kbn
         S2k+F6YNPsbwKQvMxWChAxAAbZ2zslLy5LTUjQD/dSnpR1vkfhwkeTRraBhFWGlBWLXC
         AHk0HCsgd+49XVVnQ0cGF5UlAvH5Eg4LbaykgceW3TDcu8mK4vvRqmncrZcpCuNepZME
         DTFtq58nujUOfFHid6T3JN+7jITkeaVmMppwMFXpP6BGG2EJMegtJ9hzICO2Z11zxPh9
         V/1Hrbh+CKkxPjdZp3D74V/tW1QBFm3+U2egznZMF7cGSKnSM6Khh72j/g7h2J8grmS+
         B85g==
X-Gm-Message-State: AOJu0YyQ5F7owEyvX2Hfn/X4pllbvyAPDInKxbpp03HmqP0BVkKD6cE2
	JSPTvCX7fVkpOY4AFL/GWbJy84GvjsBImWSEIDnvVtjXFuq3H3nkaniH2q6auJYy
X-Gm-Gg: AeBDievz1ks/Qhemr0dYm24eLr3qpkAZxK/91SvcC7ShOL1N5PYlVJU/WCydUnKTxGA
	4v36FDST6CGg14vwCVeNB9GbjHOYWjdAV5GnxC4//bvBMOB1eunhQOtCnUVOISL63Zlatcycpwz
	hNKjj4lK8xlOfNmi+ZLrIONprR0DKuEehhsCuWZHg/Ib39e+e7Y0VMI1NeOtKygEqdurUCM+UtT
	zwfpXTKtB0EuLE4Mzu/3Ux0tYNu/F9InW+kQZFDph6S62eBlhaLwqXlOKzIDx4O0qxUlgdVk7we
	lRUUIKUqyLiVtloXbVjjAslxPHDWVuuHXu56hXDDnblQouy6Bxap7XQrSiOyeQX9DUoFbcFzKtq
	98mZg3jRTldckzFp5LfZIUDG5yH93QqM5qwWfmJka2ZJzjcUIRscAtLkHsInfqY4CXpbAb3+L5q
	ShbS3RGUTn3n0blh6t32F4cVlvJmCLKU8FwBvIfnivN1AsLZZpPsjCUB5WkONH
X-Received: by 2002:a17:903:3c2e:b0:2b9:ff02:a15a with SMTP id d9443c01a7336-2b9ff02aa03mr23916715ad.9.1777758843930;
        Sat, 02 May 2026 14:54:03 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae1e293sm60508315ad.45.2026.05.02.14.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:54:03 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: dsa: yt921x: Add port qdisc tbf support
Date: Sun,  3 May 2026 05:53:07 +0800
Message-ID: <20260502215314.917687-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v0: https://lore.kernel.org/r/20260409171209.2575583-1-mmyangfl@gmail.com
  - picked from old series
  - add extack to the offload struct
  - add all params to the offload struct

David Yang (3):
  net: sched: tbf: add extack to offload params
  net: sched: tbf: pass all params to offload users
  net: dsa: yt921x: Add port qdisc tbf support

 drivers/net/dsa/yt921x.c | 138 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  66 ++++++++++++++++++-
 include/net/pkt_cls.h    |   7 +-
 net/sched/sch_tbf.c      |  15 ++++-
 4 files changed, 221 insertions(+), 5 deletions(-)

-- 
2.53.0

