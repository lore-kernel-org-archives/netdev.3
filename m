Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FB556B8E
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712952; cv=none; b=g8VDnLoKQ5NFrTnWfvn7H7Z0tCqDSkEldOi6T3udjnXf4Aag74qGh3Y7DWgBNe0YjvMGuNUrBYujfueW3Ms9bw6d428pp1+6H9W6uUMlrTLll8Lt9+8Uy8h0i0aa7B5c2MgwCZkc9ZsTEGbPPnTsTaxEBCSHAWYLS1I9bJKq2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712952; c=relaxed/simple;
	bh=J4xznEtOUK7c9Fp2BsM0yH6sIzBmBXfICe7mCBgx2Sc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lkTt59VDSR6infDW5bVtH5Y3ZmZbnsb+d6oxlk4PIL4Eiw/0FMQQBGiySwmmGqz4dCZX2Ms1estJ/BSQTDjc9CsJ6xtyAqyo3KGkiI/SAPTovPtYssnV++vip0kS1MTSM6Kh8aWwPBGWkryZlWwsEuoodibVbrsHSH5+TwIgRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGXrNwF+; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGXrNwF+"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a2639398cso6542248b3a.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790712950; x=1791317750; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZJ6rXpmYv8loDrlFpUsR6AHDlOlbutvuR3fef3lmAh0=;
        b=nGXrNwF++IgHGaLl0vvR0jbAFZMZwKxW5uNcOomOCEzE/A9s/idpPnDgLlpl8izXUR
         64CqC4VB2VKInh98E8KHJEc+3BXaR+SLR1/dgMv7wI4VnVTE6GGS0cBnHAS60kyYa029
         prFuuYWC6DwcGaioznf3VOpbyygyy/FeU+jxO3PuAmJKQKnQY32v0XsYhEqKwNvw6TlB
         P1dbUK2j1HtyBvyT9YPM6sTjbIGJBnR1JMHVH3MjKf/CWLR+mCzncF55Frb8PVtI4N7h
         ps1qfVkDf48HT5AT4+K7Nd7bZh4PIYMKpfvVsMwO9nrjWi/Ta0O7u3EXgTa/sB1QpXZ9
         zrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790712950; x=1791317750;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZJ6rXpmYv8loDrlFpUsR6AHDlOlbutvuR3fef3lmAh0=;
        b=MLbdh4MClH9+A4gW6cvfx2uZ89R2dqaszTEJbGMeB/lf6zfovPCjgAwimlxy2+1QXD
         ZUrzHA8g48GtMRtP40Wa57HkIMR/9JvlB1vXNlSuciqRjJoE2CeHrc6PjRHR8TV1ZdTV
         eHlmobmlmhSb+yikWU8ya+DenUkTIMXuDwBtLvz26CCFngqnNKL0iB4MyCehGa0o9xvN
         G/nIztM0p3Bupqr4xIkPnS7TGp85CnF/UIvAYxaR+jIxfAyYaH/+YKwsBAmc0lFLW9EI
         ju+EIBgx6mNvUrkT5JpEdy+BWCK1o+N62bDUgfoJ8kRmRsDLHxpfCfvYVckznNc87V3k
         oOww==
X-Forwarded-Encrypted: i=1; AKwUvBweNefi6LWUBn+L80Crt0HL2sc0IHRBpnyGsnkWx9FlZ1sXD0rDTLXs8RLjz7xzceaxcH1sFNE=@vger.kernel.org
X-Gm-Message-State: AFuF++k+Gu3DVUkp54cBK++zDFJ0ehKUBZ6AxsZzPMtpPSELWf/XKaWV
	BEe3Gsjy4x5BPW+K6LCkH77TJ3O48M1ITCAJNYV2kK8DLh48KTRqQp82qwOExgXvWGJwViygwXS
	h/9lf/Q==
X-Received: from pfje30.prod.google.com ([2002:a05:6a00:de:b0:886:4ae3:fd96])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c15:b0:878:34d7:697c
 with SMTP id d2e1a72fcca58-886c6e60675mr228708b3a.42.1790712950210; Tue, 29
 Sep 2026 13:15:50 -0700 (PDT)
Date: Tue, 29 Sep 2026 20:15:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929201546.1533268-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/2] ip: Batch flushing uncached routes per
 batched device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Chris J Arges reported high RTNL contention during cleanup_net()
caused by rt_flush_dev() and rt6_uncached_list_flush_dev() iterating
over the global per-cpu uncached route lists for every netdev in
dying netns [0].

This series resolves the issue by batching the uncached route
cleanup after __rtnl_unlock() in netdev_run_todo().

[0]: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/


Changelog:
  v2:
    * Drop ->pre_exit_batch()
    * Do batching after setting NETDEV_UNREGISTERED in netdev_run_todo()

  v1: https://lore.kernel.org/netdev/20260927202429.2452589-1-kuniyu@google.com/


Kuniyuki Iwashima (2):
  ipv4: Batch rt_flush_dev() in netdev_run_todo().
  ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().

 include/net/ip6_route.h |  7 +++++++
 include/net/route.h     |  6 ++++++
 net/core/dev.c          |  5 +++++
 net/ipv4/route.c        | 11 +++++++++--
 net/ipv6/route.c        | 18 ++++++++++++++----
 5 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

