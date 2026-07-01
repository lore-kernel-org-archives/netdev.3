Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9252571A0
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894141; cv=none; b=Yv9AKNUR+Xs2ptBtZjSFt5NV+i91qtWNePiHRvksnQawaVejak26IPVwfH512MaHVNkXjcE9dE4jCoP+Rz5KA/gQd61QnHBDE/zz/0HpcaxONt4hEVlxGxo0kA1pXFC0hZ9pB1GHlXnxuXqGV9Jz67O2GoiQSCPQn3w5AWvQLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894141; c=relaxed/simple;
	bh=qQSyS8fSu3ZupCaXdhxpPxafeo35MlYgUzHpCaPCgyU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JJ5p2v5nqpNJl8OVaPijQklgg9dEeByK1oWRsGh+uzaIDHgpBaPU4SlwvA5j75vwxNH6aojpyUkvxvLnfC98mn8LTj1IM++G8qJ0pBvHa9yY+HsXzPd522gJF2miVpX5/hqBJa2cXGEVLcg6H1aE0Alldg8Pku7LSvupf8at8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHYi6pn1; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHYi6pn1"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-91931144870so48275985a.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782894137; x=1783498937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hKjuQcEuPReDEeT8Vj3MEK8WYjR2H2PEYJfyJeyD3CM=;
        b=LHYi6pn1DPjfbFi16Dn8XC2FmOH1Km8CfMGqv7ig8a7uUS16NCeBfjF3nOgcf59mQU
         BgFbuaC0lkjsq4VNOkH7T70gZiwwZOX5VQ/QIAZvFleaelto6i5G5Fp5bgudAH5Qd/s0
         Jcma/Vqj2SFCxLe1OczwDgORF7ep/SBWKa5fbd7MDLilg0cI6pUrSdTKJfpBnFMkuUwr
         urRMURxIiKEjF7MjKL4Bgx8Wa1ja9Ye6zxK57uLQrTI4lpIwKR6F7YTT7TpgKjw02cuh
         s+Djf1F6dQAwGgPQc5tUA2pp9HeDlf4A45kSYbdC4+jGdhzeZukMwzia1JfOhciDUqdw
         W0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782894137; x=1783498937;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKjuQcEuPReDEeT8Vj3MEK8WYjR2H2PEYJfyJeyD3CM=;
        b=jyiuUeS32/OxHCwHxHDKMp3l5OA6LNH4eD+pMq1AKParXhUeyBty4g/OmF0/XXfsxt
         TmPs6nXo8l4u+ajDaKTgjHyhSmHcGSi9yTpBl0DrMWaGOO3JdY5D/+7aRo2YTWm4YeJD
         qbpgzKlqcRbeILt2vp8/1a01KQlrz1jU7XxxH9bDSNc9wHIbqpi1IcshfOPACkxOofxJ
         c79lBugSUXwzG7wDtTxsPO6oeWG1y3shxH2KOaMmilXxe9UaLSO+z0JksBftXdYvfyoO
         3O8YBoZr5eBOffjqRdzM9woIrXMgShnfqsaCAJ4aGwjZHrU7y2ouF849rLa1avW00AD8
         un5A==
X-Forwarded-Encrypted: i=1; AFNElJ/bkWJEoaXKb8ysyste++sywSCRYgijwQsaJoEiBhLj5e1uYbTqNJKoTloZUDMof4qB25bwRSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuOSjftm3Ecso59RNDw/CAKlTtAnBgh3DB03Ii+0TAOkbwwMJ
	+UYI+JVi5M5MZSI+yXjA86q2c2fwsw+o7pYBRgv2vtpN+rzhIcryc74d+7MbyGPcPJX0MQFCn38
	DpIFMEUatBUlipw==
X-Received: from qknqh15.prod.google.com ([2002:a05:620a:668f:b0:92e:5fed:adf7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4612:b0:92e:5c0b:a6a0 with SMTP id af79cd13be357-92e782574d5mr84953485a.26.1782894136415;
 Wed, 01 Jul 2026 01:22:16 -0700 (PDT)
Date: Wed,  1 Jul 2026 08:22:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701082214.2974946-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] macvlan: RTNL-less macvlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series removes the RTNL lock dependency from macvlan_fill_info(),
allowing it to run under RCU read lock.

The first patch annotates data races on 'mode' and 'flags' fields which
are accessed locklessly in the RX/TX paths.

The second patch transitions macvlan_fill_info() to RCU, adding necessary
annotations for other fields and handling concurrent updates to the MAC
address list by computing the count dynamically.

Eric Dumazet (2):
  macvlan: annotate data-races around vlan->mode and vlan->flags
  macvlan: no longer rely on RTNL in macvlan_fill_info()

 drivers/net/macvlan.c | 109 ++++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 40 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

