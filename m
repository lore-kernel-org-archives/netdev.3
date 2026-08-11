Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87ED345EBF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474058; cv=none; b=VpUC/NMSkEsIg368pas/DvlGfNg5c4geXbvMRTop02DSjKDLH0I5rhB8ky+qSkgTkpr3n2FBI8OutKhy/dKzc6V6DYpzZ796jPPqZXdeGkiGgtAT+xtjuctQ87lIfDvIA/xaMmfCR96O1fuu3Z+e2bZ6m73B1V1g4+0ULumpK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474058; c=relaxed/simple;
	bh=zMvkxHxIYAUfCFK1U4o3YSxMN8M2kvTzC43Cl9ZFBeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wkw9T+aZx+VYb4xq9F42qq3W+AmK5UzQAGzUbAZH9VKG96vhhWZYNXLYxzuMgvnsxlN+WSDvby1ykGgI/maft1MGVNvA/fZbqcc4XruXcb4bSLqraWzeeGq5QAeaB+BNrOOZcIvq8/UFr5vgYMUhorTTJ7sW6Z8rYVbFsz7rqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Cam5w4L9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Cam5w4L9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so279977a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1786474055; x=1787078855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UheRMizwUT08h/a5LMsuRZonsUF1EJIKU2rHpF/W9s0=;
        b=Cam5w4L9O+TevlImfxVRuN4/zocXemJcag3JVTKOnDNeiZJ3UGaUg07WqcLfkKXcHw
         OqAWNlGd0HEK4BOZA0iDlIxYkB7AIF4ig1woKOKsEA9kKfNTSc6zjEX4HLHahUSrJpuK
         oM1HD2RBg6Pnl+a9xGu1sO1iGIURLj08F9PZqzWG+YC1MPO54+RBAB4VXtDYDk8lhvQM
         +q8lGvJB6j/7i1Jt5TZc52l8PrR85Z+GVtU8wBakSSgr6mPOU7DzWoHDdK8ZcYfHy5Ga
         slKg4MydpfpteC2XmmySEkx0ulF3VmPSty3s0JmK2vbbUfE1THtmGQnPfE5oyn8jcMjN
         0euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786474055; x=1787078855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UheRMizwUT08h/a5LMsuRZonsUF1EJIKU2rHpF/W9s0=;
        b=HYM05fzHybVSYtDvFQiv38+3RORyWMNqHaeGl1riuhk4Ef2lEBy1MRBWOUQPqLLJKo
         A8URpF9SxhiReTTqmdr8lzjG2altjNBtKxvKy4qbq2hdwC/VNAjPIEMVpbJgJ54wGWyp
         SoQDFUc68AxDQoLcE1WgFmE9Xq58w1TX7UBdF2n2iP9ObhMPkQDdvz+sUx0LZVd0tJz8
         HX0suWwtPs8lWsiOyHfzDJhPlv/MwUi5PXl5OeMNAeFW4j0YU8aH/8I5U19FCa4hlF9d
         PLYuFITCNE07nNqrbK9JqCu8CoX4RjxCP1Eh3ncmfKujGu/eskXzTTUqrmInPeQNQib5
         KAwQ==
X-Gm-Message-State: AOJu0YxKk8wHo8/RTqrM7B2dtvF9b9vfgWUxwJpz37e3J/3cqz5qWzVB
	sVLU5jVsGUpS+BmBkWqLf2fg1pnowTVrJDp/jKytHL0FqyhpxBRbYdZTvmJ+KtFlI1Hv3bfPDSM
	THq1r
X-Gm-Gg: AR+sD10pFzubo6d4exK1n/Yc6JOErgtI4pqGg1m9jsZlH0iXbI/kCGQAHiihRzRXe18
	amc1jELraPgbksisno8Q5ALPFdQ4UGsiHjFWXzIshQwViFcS1gdrET4ghiTJ+eeufGi+MvbHWRE
	vN1fojkS0XaqzBp9pQEftuibMvRX2MFXJmQniyvOovOOIH2RZNfHeAMMwJ/SnEBdeuqM44fwTTR
	0QB7zKPgXpl4BiGZ9Hvv23HtU4dWQosJ2zPH8ea41nM3iafmUMCKP1WPx9yqzkjEd+YE6XEfegc
	KDNgaJs2maqv/w8a+ILwcDKM6sSIHJG14YJLkKPHp7MfHJxNWK6g99y36dL6XVzCDpI/NTMs9Wq
	8Z/9plW4FZZj/mhkJ1AaVKyjgH9SGWiFN6uQWTHFzXADkvbyIr6bLgWbffGnY4lmGUOeI29XTAB
	cjG1FW5DWJ4+1Y8Rr2JiALJuNz2t4Uu8SlcUy9l6t/9w==
X-Received: by 2002:a17:90b:3c8b:b0:38e:f6eb:2b38 with SMTP id 98e67ed59e1d1-392ec68540amr6199784a91.17.1786474054900;
        Tue, 11 Aug 2026 11:47:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94d30b9sm524532a91.13.2026.08.11.11.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 11:47:34 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 0/2] packet socket cleanup
Date: Tue, 11 Aug 2026 11:47:18 -0700
Message-ID: <20260811184722.2612345-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This series does some minor cleanup in the packet socket code to reduce code
duplication and use existing helpers (like copy_safe_from_sockptr).

No functional changes are introduced with this series.

Thanks,
Joe

Joe Damato (2):
  net/packet: Reduce VLAN tag code duplication
  net/packet: Use copy_safe_from_sockptr to dedupe code

 net/packet/af_packet.c | 116 ++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 54 deletions(-)


base-commit: 31397cf1819210bd63fa3d2c7d8c24f7c8667d99
-- 
2.53.0-Meta

