Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com [209.85.221.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515C31A81C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098503; cv=none; b=trIIpscy1FfeWaCufZxzWKB/MVCzONP1GITs3OmLo4HF6RskQdRvBG1fSrgyU6hMP5DkF49KWRT/0r8CTKNvYGCGUxqR/gxV76pVLIQkDwXefDhDGdTNshqZvgv5jkL6ff8YxXq7o6hzR5DZ1E2YSUQ50hNimqQ7Jw/8vhkw5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098503; c=relaxed/simple;
	bh=yDHTUnUfDdoEzAxgmVSBfa5EK5ubRDXSb8RjZRVELrY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p59JgoizMcRbVf45jXcQIy3sDNwZ3nYtlRs0w/OYf/oYmFLbXhEadUx3P4U47rpyh3qnIRGUrRvjegMvb+glWqdHM4j3VQvMfZ0wYKmImUXcvmD3RKc4nplteXWLGEwaJImqP8XkL96BsM3JTQLi5aCQfNLzZOmdNpGfLSY8wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChRdRFkH; arc=none smtp.client-ip=209.85.221.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChRdRFkH"
Received: by mail-vk1-f201.google.com with SMTP id 71dfb90a1353d-575b418c83cso590245e0c.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779098499; x=1779703299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fyGiY2daxHKdAn6HM3W7HptPp7HNwwQRZG0TCAJK0iA=;
        b=ChRdRFkHenBncH+D4PIBYWsVLjQHzaESNi+qvpMXSMUDM8L8AzTceQTwVSvjnk4D6R
         iPT4ni1r0YTmCE8cnsvrTRt4/fW8DN3NMIfaB/gkMUQXOGQFwMsFOdw8/7SeoYPOPg0n
         0lpUMvONpUJac/9QUgCFizaI3SEYnRPDQZk5WZdJXESgp7jHzReJc0fb40MSD9bWVLcd
         alc72QcYINeXgfLd4u/69UmEcJkxxLTQwaXJvcKHSFS8vE+p1tdmUHkF3MltxJ4cU62+
         5XhFp7cIAg0oVT7Ubou+u/+IUFbcsVbO//GPIclpKnhyw+pSIxDv7zaYk8TKNr5FxJwh
         usjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098499; x=1779703299;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyGiY2daxHKdAn6HM3W7HptPp7HNwwQRZG0TCAJK0iA=;
        b=TIrlLuIVKKM0eeKjcMzlbAy23EuMuHpJ47+LO3XjZAblPdDA2Chlp63wny/PC/lk8B
         xXD98FoGou9vBFg9YCGm2TKWI7CVyJvIGnn2gpzn+TB+uEdhpO7LxmDz54I36CdCXFl1
         ex1FDzOF2BeHAQfGWsoyGaxQW+ox/qqOujJOTtPWIA5Z7xGJ3vwQEt7joi7Dzw81PUUn
         +8zfSOaVGdTiRzgiwc0bZmJ+qD76wBZ2d8VmxjdzZVZKBTSJzKP+jBqm//iHAnYKA0bA
         Hw9OdId9RssSjyoc5p/v7V/HpoECDejrosjwbJmp8mAgvC52x+x+XV2I5WeclJGciZ1Z
         5c/g==
X-Forwarded-Encrypted: i=1; AFNElJ9sKBMf3xTBtQdutMn3v05/J5Y2Yd3tW84lrBFoYvMR7Qj4V+PVnoqTEcgFg4m2Da1cglZbBns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpQL2LNy2YlCSQUk5y9UQjFXESrC2I5ZurS4Wt9umpZsN6ZTE
	oPlaO6wMEnD23vhBkRbcvROJZNyxhwxLo3oM7tSwxAwcZBk/Z6z4fw/ggZjbAIpqZcIUTI68XF1
	hfR1TXwaQtTmq9w==
X-Received: from vkc11-n1.prod.google.com ([2002:a05:6122:620b:10b0:56f:4636:3d71])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6123:86:b0:575:29ef:7df3 with SMTP id 71dfb90a1353d-5760c05e326mr6542588e0c.12.1779098495967;
 Mon, 18 May 2026 03:01:35 -0700 (PDT)
Date: Mon, 18 May 2026 10:01:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518100134.809042-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] rtnetlink: RTNL avoidance in rtnl_getlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Many shell scripts invoke iproute2 commands specifying a device by
its name.

This series improves their performance avoiding RTNL acquisition
for their (repeated) name->index conversion.

Eric Dumazet (2):
  rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
  rtnetlink: do not acquire RTNL for RTM_GETLINK with
    RTEXT_FILTER_NAME_ONLY

 net/core/rtnetlink.c | 74 ++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 20 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

