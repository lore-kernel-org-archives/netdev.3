Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F230357727
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770982758; cv=none; b=aNq2FEOnYWuM6rfpjZTj17dZvwEb4y2z55E5H+HwKzz+t15vLlnTb6JcUNUNlPPmEzdAUP9QS2AKmKgSbrZYLEKaO33V87yKSfVHm72Q1D7reY82GhWjbfBwsDGTNSlYCAcphN/4OvN+fDApOgp+dWTc3dCLbnPAHBNwh8RJZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770982758; c=relaxed/simple;
	bh=OjOeoNeXbk8BHjb598E2R0UWd310v91zrIUSuceT0dA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uU2mjpbHcS0noaunbvcR/08bCpbVDQBxwr0pdqR1Vkwd/+w6qGBeChZSRSgYulyMsl7ZuDkHj0+XjZlZzZ+ZymrL40upqUlwrJ/WQg0vyBUZe7XVjs6NSnWRlW1VuXg7ULxeDDxayL8uEmyreMrcrJK7v2z3iTofJ3XY2nqfXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=FeJKY4sg; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="FeJKY4sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1770982748; x=1771241948;
	bh=wRGHsAld12SXilvXxUlkl5iF+FfXB1D4AFtT+lQLOwg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FeJKY4sg+aJn6+iZVa2Y0v/X6zrMhJx3WXiGWdDsamoo+zvOoN/JXBrCgU/M4El9j
	 ApRkOjt6VUNEcHk0kM2OdOwH0ZVtv1wnGPXFVT9/VkY5oBAlu9kAMuEZ7jy40m99uu
	 hg89TcdAGJaKqzMTzQReOcJo99jyQFXCf2R8Y3V6Wy4QRRBUzpgCyI5OoLb4VDvYZs
	 /euPiX7n+UoNvGH/KIYOCq4T8SAV+6ChwA8RCXUexwbNv9e2anEL0Gbc2JqsF7gCCj
	 sygnxt/RanR4ah7oejtQN6PLMuo+iWPe3eoYpnQEXulQGBM24Yb3aU07dJ2mcZYYxY
	 Dw8IsZfTyaAhA==
Date: Fri, 13 Feb 2026 11:38:57 +0000
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
From: Paul Moses <p@1g4.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH net v6 0/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <20260213113849.136695-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 4563e7e333f1f0db8f075c3ca391ea98a408cca9
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

Changes since v5:
- Reset stale err before optional old-entry copy on REPLACE
- Centralize goto_ch cleanup at release_idr for init error unwinding
- Snapshot replace defaults from old params once=20
- Drop redundant early clockid pre-validation and remove clockid_provided
- Resolve clockid once into tk_offset and pass clockid/tk_offset as scalars
- Deduplicate init error cleanup by falling through shared
  err_free/release_idr
- Deduplicate empty entry list rejection on create into a single check
- Rename lock-only accessor helper to tcf_gate_params_locked()
- Simplify entry-list handling by deriving use_old_entries from attributes
- Remove replace-path defensive old_p NULL handling
- Keep helper name gate_setup_timer()
- Align cleanup dereference with act_vlan using
  rcu_dereference_protected(gact->param, 1) and call_rcu()
- Switch dump to lockless RCU read-side access and use
  READ_ONCE(gact->tcf_action)
- Compute need_cancel only on replace and keep
  gate_timer_needs_cancel() focused

Paul Moses (1):
  net/sched: act_gate: snapshot parameters with RCU on replace

 include/net/tc_act/tc_gate.h |  33 ++++-
 net/sched/act_gate.c         | 275 ++++++++++++++++++++++++-----------
 2 files changed, 219 insertions(+), 89 deletions(-)

--=20
2.53.0

