Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch [79.135.106.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264B35CB8F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859171; cv=none; b=LP6AjeGthGc8nqoF55d5RS1M+q7fdqwHQLzZ5dWQbc+yJMTMjOM3O5qR6rYmSnVBeMVKFlxH70nLo9mB+XYoKPEah2q0Si1po5L212TsOLvXqUYPCmx/r5Om7KfjsBjAHhDU3JCbDBoXdgKAFbMNAUASU2ytgvWAEllJQupt+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859171; c=relaxed/simple;
	bh=k4g1GCy7hdBKFU3mcdZccyVMmjPMK/xXcnBPZiPyuGM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GukM5tYc78koj02ChlBpu87RfmlWGC8fKJ1DsZcuvRSlBDfa49tLyMTg5s+y4lmgyvLLd0dL5u/eR7x1PZJkQXKA+AUCk7Y0e6NRrPxVKNwKT4gCAWMJZt8KfgFnQ28ridHqGaU25bOLsLaJFa9UBpyQ5rPwQtDdbc/Pvy0q1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=szc1u5K3; arc=none smtp.client-ip=79.135.106.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="szc1u5K3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1771859144; x=1772118344;
	bh=uY8xf4L0aw8Sj/KWMLxMcfP4MGZC7FIJYLMda9Jk2Y8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=szc1u5K3Q2gYL0Mcs+Kg6h7IAcabZgB435Rz+UK/IzGKjPoTkqIS6I59L8JyAKcQ9
	 zwP+5j+RnnIFeGQ/ShAxlWz+4OPbMoWngvgU8t9AvzE5iPEFl2gyVbz43sTNTtfKHx
	 kCtg9gFfliOS/PJpXy7TRAay/y0fK/BVf8lpJD9DscnmN2RzW4ZzZmw/WE8QwXw4vf
	 ynl9d+Kilh6EenfmdHwdNKIeedhx35OG4xWOl+9Wz5Id7AiY1mxcl0Tk9BRwlBlTUW
	 xtB3zlsIoilynHXFOpMjqD1bpi2RsBXdd2quMvsBXmKvh3XBW+JSZmTWMnhGOG/vHI
	 vwGqPKMF+4Chw==
Date: Mon, 23 Feb 2026 15:05:39 +0000
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
From: Paul Moses <p@1g4.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH net v8 0/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <20260223150512.2251594-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: bf0bacb12b742b929473c72a2a6ccfd37e2ec0d8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes a schedule lifetime race in `act_gate` between the
control-plane replace path and the running hrtimer callback
(`gate_timer_func`).

Changes since v7:
- remove unreachable `!cycletime` error branch and dead `unlock:` label

Paul Moses (1):
  net/sched: act_gate: snapshot parameters with RCU on replace

 include/net/tc_act/tc_gate.h |  33 ++++-
 net/sched/act_gate.c         | 265 ++++++++++++++++++++++++-----------
 2 files changed, 212 insertions(+), 86 deletions(-)

--=20
2.53.GIT

