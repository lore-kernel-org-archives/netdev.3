Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A23BF676
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565306; cv=none; b=HHh5GAJvOjA6yB5D9Cs0sbc+xl6t1mktAO+6aD/fPHJc9fH0EkGZUvDHaoUSPLJox3SBcYzCaP99tKGZgLpYdDS+eHSUxSGyKamoDhT5y8wCJAXmGacq2XHccpTAe7Rjq1UQyZAIGh+rQi0DhyC2Uw05X21t29znKDWauCk9c2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565306; c=relaxed/simple;
	bh=WsLPNFk7IjZmdxQCR5/z50hxBU3y/LeHii1/DbvRQ5o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gSqxJ6yV9mb6HTbtCpYv73FyZr4+VERFwh0xeYawG4aYhDWEr/85wRdASIRcxOfQF/k8GOX0v7QHM+SinPtgw7X8ryozpnIeXMUDJrNiGSwfrZmnENYEjBSD6eMfHBrsygcgApJnXgGRlv5BZS5TWMY6u7tN+tKvihk9ScdeLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6lUDbwI; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6lUDbwI"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a1bffc2eeso955042385a.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789565304; x=1790170104; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6dtGATP9zwPL2a1NMNdml6RyprSnMqaZ2717nq0DAhk=;
        b=m6lUDbwIXUQy3rIxczGolo3fBhL7N0Q4AIWJiHgh5XopSQwrzhz/ELv2I0o3OMVzu6
         sepPHeUhfHvV32bPmGgkbIZb3I7oFSU105eeEBvk7Yu+PI2Po5IKET2MlqvsFprT24iv
         zhMTZ0xaJt384g5+Bqn8ACQO5Yt9/SMK7TpRb5ZNnP8JN1KJ0tGK5Ui4C4irsEByf7o2
         SBhla5r8dNCaexRCbnHhSPM0twhCtedIzVwcOCgtdIeZDBEmzv+HWUFZl3Vzmpjl6ZnA
         m4t1AF0t1LLwLRe3gBQshFuTi+BScSrI5Pe+M4CjunKi1+LuiMMIjFJFJo320+Q2fFmU
         S42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565304; x=1790170104;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dtGATP9zwPL2a1NMNdml6RyprSnMqaZ2717nq0DAhk=;
        b=yzE3NqqcWAAR1S5Imc0TDsXISqvf1/gqHDfeAdC/8r0SfNvKTxWhIgNh44swuMdFXl
         7mzr10a5qYkH6aV5mXiXdod5u48HsdMOHyW8N2nd8YMyd1tslOMtKdeRFGXEwgf5jg5C
         vM1Mzoyp0HbxCTkNHj8COdqtVw3Dqw3Fi1fTCl7W3LPLNOG5ryCPqTWg8Cji/MVI+Xm9
         jtJwsz8GTRsWPLRqFa1jTWWRnwYn9/h6nFK09fYfq1IE9frPt1szVXAQ0FpUUTINO7mO
         rtcG8UVikPP05pJUJRZQTeeHW7lGNZWKW6xPIwWtk/RdzhI9VCfwFsDc454DybD9jD33
         sgNw==
X-Forwarded-Encrypted: i=1; AKwUvBwTClAEM6CAy99IbxW/04u6pUe1Uu7B3xSmazZun2lxdzQIKTTxQrj38qufVX4mCSHlujZvEwY=@vger.kernel.org
X-Gm-Message-State: AFuF++k5MXbV06p3kcN82t4wa4MNEDli9Eu8jx2EwDtx4XVXgsJjw/X2
	XRbWjUV7nQwAJr3t+tVuNxZH18Qzhlyjt6fRPscrdvOarYtON7JWPG0BwYxhJnKPqe9f45YrMD4
	VCkCMxl6e7kviZA==
X-Received: from qkd27.prod.google.com ([2002:a05:620a:a01b:b0:93a:10bb:552a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4542:b0:92e:5d44:73fc with SMTP id af79cd13be357-93bb7668b19mr386133185a.12.1789565303759;
 Wed, 16 Sep 2026 06:28:23 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:28:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132822.1791040-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] hsr: lockless hsr_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

hsr_fill_info() currently relies on RTNL being held, because
hsr_port_get_hsr() walks hsr->ports with hsr_for_each_port_rtnl().

- Patch 1 annotates the data-race around hsr->sequence_nr, which
  is incremented from the transmit paths under hsr->seqnr_lock but
  read without it.

- Patch 2 converts hsr_fill_info() to RCU, using a local RCU
  variant of hsr_port_get_hsr().

hsr->ports is already an RCU protected list: ports are added with
list_add_tail_rcu(), removed with list_del_rcu() and freed with
kfree_rcu(), and the data path already iterates over it with
hsr_for_each_port().

This is part of a larger effort to remove the RTNL dependency from
rtnl_link_ops->fill_info().

Eric Dumazet (2):
  hsr: annotate data-race around hsr->sequence_nr
  hsr: no longer rely on RTNL in hsr_fill_info()

 net/hsr/hsr_device.c  |  2 +-
 net/hsr/hsr_forward.c |  2 +-
 net/hsr/hsr_netlink.c | 35 ++++++++++++++++++++++++++---------
 3 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

