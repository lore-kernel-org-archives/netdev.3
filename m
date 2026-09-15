Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EF4CE671
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503273; cv=none; b=EOs/46qKVBWXutD6spXvUDhZPnbdh3MsowB2uodyYPwt2oZMqrozdaDedWP5qR2kAWHfJ+2QpIwqfuuGL4M5pu3o48eHmbs6jx3wAZ5J7QxeQY1w68m5UY7A5cYynfu+21FJhROx9ZIevDq0BS9gpu71pSiShTpEF+7XCzMA5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503273; c=relaxed/simple;
	bh=kF0bFQjlJ4smAf2L/p/8U8zSXIal9EgRzABFkLeLW5w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZvIVbOLczgoXuaU8CpWsjs2Gj/pCZuxaFVjpEDjzoMX5n0DJm/IpfiVxK+Cfg3G6A9PYuVNxJcNBFNgcl8NS1iNx+KRR2A5R4f64NfoZC1k2kYzBsd0nO3H4sQ66Vi82wnq3AlXPHbNgXF7EH3Q0eGEp7vQkW+Ff26YrFqKiIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7nJEjNq; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7nJEjNq"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso8910901a91.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789503270; x=1790108070; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lz6JQ9DyNXrrBYAi7OPQklI2Q9gqOs0XY31hFzf+BM=;
        b=q7nJEjNqqulS22bsT9Gp+cjf7BJf00kKg8dPBdl0fatGe8f8zhy/BhjbwjVKANURY+
         2oxd5bFiDRIdweYGwkkZjbW8c9/Ilg7zxQ6jNsF56l5oelYORn/kQFIgygiuVfyhjiIB
         lP+R58wnxN9ub+z+LLuwzf+V5oo2h7kPK8ANdmUuC/0kCu3t7Rgxg2G0af80ABFd54GL
         tm9croLhv//TPrZv/fNMiCL05Qmmrd7y2MmW8JK8uvnN+0Y/ckwFIR+gMn64wurw7ngg
         6oVpElxRN/IvcsmPETjLnECcb65M3wEmjhVrcpXGonBPY9cy2ajTzXY7hxuu+CT8wYJG
         umyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789503270; x=1790108070;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lz6JQ9DyNXrrBYAi7OPQklI2Q9gqOs0XY31hFzf+BM=;
        b=qgpLNgkCSZHXfQtjG/UVEE8F5pO2a3FNZYdH5Ybg64O+U5YTmCjeHMsTjfVXnTVSTn
         mOkECUCgll+fa4JlLAbc/YwWheFujcLk5ZNyggk9SxROomc4UfQJ0gGlykIv8vkRA7f1
         ATG69RVsOwrO1YtZNbF+qi9oGuqGRUS1QhPwHUYoc6qPBUPuIA/8R54GTme7/Cs4XY4h
         JIDXPfoe5CVU34HJEPvKMf3Ys0zf93jvM82hsimdZiXmYRe5QLK7bS6/C2KXkZJvnMPV
         1qZvN1wwUubjTxjRpHDlZaXrrqa6tcrmGqCU3Aa37BX0vTdYM7lc7CWf2262jFhGzy8w
         u/TA==
X-Forwarded-Encrypted: i=1; AKwUvBzzgPYfJtsvQC6gqEnXyrNN4xmoQJX36FUuKfz+EUQrq07Gruz4r9Hv9hIhKfJr0VTA+H2zBMw=@vger.kernel.org
X-Gm-Message-State: AFuF++kpAG0dxMGWAB13Zj/hhBclcD3Oy+MBvorexKKhR3jRvtto59kT
	T+dXZuLEkhKgr0uvkq49kEUQwD3L4JP0MyicG7nUO+NhLXpCIQIe3F8uwIZ86HeV86s6s65IXPV
	8kGqzog==
X-Received: from pjsd13.prod.google.com ([2002:a17:90a:bf8d:b0:39d:c3e2:7c8b])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d64e:b0:39b:2c55:365
 with SMTP id 98e67ed59e1d1-39dec07ab33mr17055207a91.12.1789503270153; Tue, 15
 Sep 2026 13:14:30 -0700 (PDT)
Date: Tue, 15 Sep 2026 20:14:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260915201412.2201757-1-weiwan@google.com>
Subject: [PATCH net-next] mailmap: add entry for Wei Wang
From: Wei Wang <weiwan@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: akpm@linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"

My Meta email address is no longer active. Map it to my current address
so that git and get_maintainer.pl stop pointing at a dead address for my
contributions.

Signed-off-by: Wei Wang <weiwan@google.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 7c02242d4ed7..7133315e0ba5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -972,6 +972,7 @@ Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
 Vlastimil Babka <vbabka@kernel.org> <vbabka@suse.cz>
 WangYuli <wangyuli@aosc.io> <wangyl5933@chinaunicom.cn>
 WangYuli <wangyuli@aosc.io> <wangyuli@deepin.org>
+Wei Wang <weiwan@google.com> <weibunny@fb.com>
 Weiwen Hu <huweiwen@linux.alibaba.com> <sehuww@mail.scut.edu.cn>
 WeiXiong Liao <gmpy.liaowx@gmail.com> <liaoweixiong@allwinnertech.com>
 Wen Gong <quic_wgong@quicinc.com> <wgong@codeaurora.org>
-- 
2.55.0.1082.g2b9226bbc0-goog

