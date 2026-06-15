Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27430F533
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506919; cv=none; b=OvSjLvt8JQKHQGdvJaRZZ03ou5ULpwvD6OU1qn9hbQZvEkY/cvLOUNo8oObZ1WNyJITjs6XLX6hCb6ev2RmCHf5FBcojvD4Mhke+MjHWpM2B31/XhG0Bq9amq1EE0kcvtQNX9jR62noWvqFrzENHk/HGKwN6hRtS7Frq4YcNCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506919; c=relaxed/simple;
	bh=Zg3PZZceVWVnzLK/0U9jN/wv1jhAvnLbMgpKpi93tZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r3mdN6CedMJ3kS76JaLVrN/HMaMYMEpJ2pBt5UUCimTABWfQl4h6UqoF65tGf8TUZQLzobvIDmJidsNg71n8jzOuOek86wnCkJtnXqrlrAey6zXm7REQ+BqdGfRzj5UidEzuc9BZjOPOOSNfHYIXz5eB8lrQlapbMKWGjWlTegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfFH/o6t; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfFH/o6t"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so1815790a91.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781506918; x=1782111718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfjOiJOK8cmnc7WRNYZddSGB0RkM01zSadnY6B/8VhA=;
        b=LfFH/o6tzzkv4xBpcP1XqF78gKwCiYeFHrf5iNSoT82ouaevSsDL00ruas4optGaWl
         nSoyJ1CpoYCFdp0vgLFG4tf4sXgQnWPQ1L65emsnafWwTZBNgs9V2Jp17+aq2hbvvi/P
         ccFOktoENYa1+kn6sGf6M+Iy71KZxC2LIVhhQl9EsSRBxaQG4xd3AGk6WDiFK+9uL2IT
         Lh+DC8/B74toR/qdRthqF1QIQwkwtGHKEL74enWdZiB2uNKM9KXRs/IWH6ICLxI4R89o
         iHzyMr5Fb5gqLKFJ8RKWPGzIr/huAd6mgEqQJsIzKxmouKfKPo1UKzrJPoaDFmtGLJ5A
         P+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781506918; x=1782111718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfjOiJOK8cmnc7WRNYZddSGB0RkM01zSadnY6B/8VhA=;
        b=PuJ8IgEEhEHJB1ofv0Q+tc9z4f4eCJdybX2Y/H9YYb5AjhCeuxevMgZt7LCISVV8un
         SLqJYCJvqeuS0wvaBLJH4ZSt2ZDz1FL3RLfYu5sa2cvZdxJ0drAIn3Y1YDBYs1LZvf+0
         gft0dXGQnvEOCE2RjXE/Q9T4QN0SrfkwOSY31irI6qofFCwsVPxYQYAgHXXsA6SyMSZr
         cvNYZQGnGcpsoN+DDw3TfhHIh2Nhfyx7CbCjh+eMxfWnmalwF/D19RhlxnOudhmob/pe
         9u9B1LszlTMWD+p8S9BMs0JPVTeFPN3rODz4ocKXSu0k0+eJF3M9phZMWQv3XaFO/eM8
         VvVA==
X-Forwarded-Encrypted: i=1; AFNElJ+w7xCFycGaX6xCujo4vDUio8BH50S+5Jx0rtWXqDunYzWps406soELP2e+/xRzSOulsKB91nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84jNGBSy1GIF7CRdxnBE5GNjlYkwOflRVdFWxrbHhC3imn5uX
	ABharTpVvCfgov0zdirivhdOlxfL49Y6BTjrwURW9dH8gj8ah3ghhJAc
X-Gm-Gg: Acq92OHJ+uO1dbaj2dWHvvnZHa9k8e4N1g93vzpy5KsdTKLAL8JuY1r5KL5VDUN+pTH
	oWYvuvMfaq5cVSwZGwbGFr63/OsilTx9ByqmBLueBZfdjGd9GRWpVxmzErgO6t85I9jaBKeGXM0
	dDITAcyXaMy8Sohtl992uHIQ+WuTgL8rFM/BaztXLKn3+IGYi4l+HgZr+CEFccGER7v2CREIYy8
	mN4hVbbJdk/mzfix6YB9O+oNE4di2MwPPODHxEB6xJeVwo1kEx0nMZrLg0Oqy8pM/C2wWWuf4sf
	QNe7UJujSr8KCTwITUMFCnv+kHd5XGL/jzcVK9LzQetcH8UiLAu0qWfEWuM97Szu6rcJc0fy4kB
	PvXXoP3LGkjwOhauDj13+5QKVQHp1+FeNt1eUFuAAjIU8RYRZLi2bWAauTiQL7dxjy/99Dof2wY
	1XMzAFtnXG3q71a31c9p+e9vUd1slneZ5JVFSBa5WsmQ+/HYjrO+zFufHVwcw=
X-Received: by 2002:a17:90b:582e:b0:36b:b1f4:e0ac with SMTP id 98e67ed59e1d1-37a034f522cmr13518398a91.14.1781506917867;
        Mon, 15 Jun 2026 00:01:57 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e7e217c0sm6891919a91.2.2026.06.15.00.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:01:57 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Amritha Nambiar <amritha.nambiar@intel.com>,
	Simon Horman <horms@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Samiullah Khawaja <skhawaja@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: net: netdev-genl: NETDEV_A_NAPI_PID is the init-ns pid, not the caller's
Date: Mon, 15 Jun 2026 15:01:52 +0800
Message-Id: <20260615070152.1211050-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I noticed something in netdev_nl_napi_fill_one() and would appreciate
your view on whether it is a real problem.

It reports the NAPI kthread pid like this:

	if (napi->thread) {
		pid = task_pid_nr(napi->thread);
		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))

task_pid_nr() returns the pid in the initial pid namespace. It is put
into NETDEV_A_NAPI_PID without any translation to the caller's pid
namespace.

NETDEV_CMD_NAPI_GET has no GENL_ADMIN_PERM and the family is netnsok.
So a caller in a child pid namespace can read it. That caller then sees
the kthread's global pid. The kthread is not in that namespace, so the
value there should be 0.

This looks like the same case as commit 3799c2570982 ("io_uring/fdinfo:
translate SqThread PID through caller's pid_ns").

I checked it with a small reproducer and a fix. From a child pid
namespace the reproducer reads the kthread's global pid. With the fix it
reads 0. I am not sure how much this matters in practice. I would
appreciate it if you could let me know whether it is worth a fix. I am
happy to send the patch.

Thanks,
Maoyi
