Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198BA27AC54;
	Wed,  4 Feb 2026 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211501; cv=none; b=bLwar9GLTXDNkIgjVa/Ddb+FpmHkzF/uB5dkBsWEda3gAW5CkcQaAtH+nboxqtacyWoGwgwk7NlUVHNL1PCwbRf5DqNMKbWM9MbAXlGoFe/VTP+GQ5GWDXxFJ1gopYa+qvJ5Ie4eMRCWfK35HKKgWpQ7jXA5k6llm3m32qGYEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211501; c=relaxed/simple;
	bh=y5J9FdIkgBihr8m8Ct8phQ8NDSlRb0vHCjsK9z4zHyA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cGzAHR1ltvkaM10iI01gtuo0kk+QZps54k5/Wh+rHB7BcWzfhOMB5SxO3N1FtQSdsSIRtRl8HtYQlpiA+KE/4p6pmoH6E0APYrNhGwk6W996IohUdNwKmEFriBi2jJNMqV4yly8rNxliYlKWvThV93ed1WIoKqY+vdzoGdtSg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=oDtcuWwX; arc=none smtp.client-ip=185.70.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="oDtcuWwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1770211490; x=1770470690;
	bh=8UdYH20Bp0hbyqP16ovzBzv18gwP0SMHnY5bP9+6fcM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oDtcuWwXSkt9Cvtq9u0ZJkoXdY9u4+OQ+PGRE8P5gX/h3kadUTxs2iimaI4cQ3Fjc
	 q7tBE8ZBGxEawE78tGZ/ZjkCeS3yRtoyOEKXZxVJN6ce/jryUSTHBUv4zh/IDhEIxR
	 yC+lqp5WrKcE/vpyKYLMjkNv0X4efVgSJFKAXv/rbtdC3KJwa2B55+FqDRyLyUSrPJ
	 tmicxKZFbwIbufUAwh7OJYV2c6fWi0JZMDggpw5GenZyxivuQcNiZgS612DbZ6l4D7
	 cwr7CyE+H8aMrpRvmNU2K3zCDEjG17hrLmtLvPNc1902glRS0RtWXoqDWVtIhatVuM
	 Kx4pwGmUKLnNQ==
Date: Wed, 04 Feb 2026 13:24:46 +0000
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
From: Paul Moses <p@1g4.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH net v4 0/1] net/sched: act_gate: protect parameters with RCU on replace
Message-ID: <20260204132428.224465-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 0e09f7f141399d5bb85942c246210f1cdcd92001
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes a schedule lifetime race in `act_gate` between the
control-plane replace path and the running hrtimer callback (gate_timer_fun=
c).

Changes since v3:
- Drop and fold the previous patches into a single patch
- Move hrtimer cancellation before rcu_replace_pointer() during cleanup
- Drop the NULL guard
- Treat an explicit empty entry list on REPLACE the same as an omitted entr=
y
  list (preserve the existing schedule). CREATE rejects empty or missing
  entry lists.
- Split the timer cancel decision from timer setup, cancel outside tcf_lock=
,
  and use hrtimer_active() in gate_start_timer()

Paul Moses (1):
  net/sched: act_gate: protect parameters with RCU on replace

 include/net/tc_act/tc_gate.h |  29 +++-
 net/sched/act_gate.c         | 300 ++++++++++++++++++++++++++---------
 2 files changed, 246 insertions(+), 83 deletions(-)

--=20
2.52.GIT

