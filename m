Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EE489896
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537849; cv=none; b=PLL0pctUwMzcMpGlCcMBNDQJVy7cOMWdzzfkk9fxwFhF8m7tfAZIcW7orXT/xV0YH1y79mjUHNMtVmrpOlYdM9r7rIy+khprxC7cpt0beFT3Pzm/zxCJ5lwqnU8QxmW+Y/cpIJaEsAAud/vzlPoAjtietzw9zLqZpSxGD4ngY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537849; c=relaxed/simple;
	bh=lKa3gp1WaCClEgyOhxwh0Kpyjz1vx30z5P0bSQ+lhug=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KLyP+1fHgSMjb7toZv9BcFzhPvz3FjMDNZNQu0H1QBxKvexciUjh3oO3hgzF4hZ+DmpxqAk3htsvdhBHK2UTMNVSQRO/gUg2K9nkDDmJsL2XihKSGESHlUQO8Cx5bm0WKdA0foNpmyAVYxOttMr63cSDLzXRMDiDkzK8YUKnIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHajJwJs; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHajJwJs"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so2602617a91.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785537848; x=1786142648; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lA32BktiSOOWE+YKaOoIIA4pDDXfgej+UqmdHwRVo2I=;
        b=BHajJwJsZlyIw7exhBXPZcn2sH0V+Mxq/z37TKaC5OWc2lQP8obUjUdtKL86VoWxfI
         cOX8VbxmYiUyPqddg2yNcoQalEqb73mj34Iivuvv+hA6MHVHLBsO+zeJVdWv6kj5zZ5S
         Q3VqHCUBhPbFRMRAAugzFMzX/sOxPkPum0QOiLP4VsWVo5v601j/K2gGMINzCMVAV0kZ
         tVILam3ChiAG03EsSikBm4uXGlikYCJVc05Qhj6e29dPqtJHiTnUXZaBosj50bxPNZUR
         kj6HeCGuP7scrIdoST+xb3EMxn3W3oe5uMXL5xXZWmEY4rAT1u1L7uM4eouQDPYRu5BY
         pjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785537848; x=1786142648;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lA32BktiSOOWE+YKaOoIIA4pDDXfgej+UqmdHwRVo2I=;
        b=D55hEPoX313ajF5y4zxx4PqpTpNbFy7yishLrEKM74/A65DOFGK2PYmGxwPK5WSHEx
         VGtMauZQjFQYjTR48OonHuzrcrrnaEbsD9FcgbLQv3d7Hn9aJmIHdXfGjruLA7kTJcEj
         ZDDfTN+WG89I0wUyT642upksxpBEBNtFoH9pA460oTq4ngiMNm3pKXiXAjhdRG4lcNqI
         3IyMGQuxk2MoEpmJ4jw572Gi4273CD3xsIfMsFzfL23fgF1hqHy//h48EJCyJOSC3ptZ
         +vtlhyQhzNtwR4svAKW12WEAwc0faf+3ovxY9qnk4iVEVfyV+WBDDFdyB9t4G4knQTl3
         6e7w==
X-Forwarded-Encrypted: i=1; AHgh+Rr9LEFR8bfOhSJGitXbp/ROEwl60WSckm1GiPYBBlZLyQyuRxkr2Cas5P6G59eqTzrVeCJLeqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYRkzO2QkpwNsSXZHf3EgU5EOJFB8P54wndbRJxOrXO5Ln8Nm
	BgQU+ghx/xguIGFzAscE4z+D00YXV+HTxDP9alg3fG/CrwFIlOy5JCvGvOoi0bH0uEq9WKr+DBw
	iLeDEJw==
X-Received: from pjk12.prod.google.com ([2002:a17:90b:558c:b0:381:2647:fd08])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50c4:b0:38e:447c:9a15
 with SMTP id 98e67ed59e1d1-38fbc516655mr1200153a91.36.1785537847809; Fri, 31
 Jul 2026 15:44:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 22:43:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731224406.2444121-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/2] pfcp: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 adds a per-netns mutex for pfcp_net.pfcp_dev_list.

Patch 2 supports per-netns netdev unreg by using
unregister_netdevice_queue_net().


Kuniyuki Iwashima (2):
  pfcp: Protect pfcp_net.pfcp_dev_list with mutex.
  pfcp: Support per-netns netdev unregistration.

 drivers/net/pfcp.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

-- 
2.55.0.571.g244d577d93-goog

