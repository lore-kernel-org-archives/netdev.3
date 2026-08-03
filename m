Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C7288C30
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742447; cv=none; b=ANlRfhblaQFCTWtM7mZJHCt0LHwCICW7iGSyOVXq22Eo+7kjske9R2+ON542I+T7/t+DDHCnbI5jsoYysmkPoGuZ9mLQ+8n3ygLx1Z7qhIGCTZzKEbxCbqFYIHxyhkjr6aitKYQ2orG3rzYuC52XLdxxbOHpwbufzYjH0+cbznw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742447; c=relaxed/simple;
	bh=JfqXRx8JxA6qPctLPEMsVO4C6pDFgeqjl6rhl7NgLvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWlNEQF49dSyqB+7yWSqznlu1CB00od/N9nZYX3mpEbpHa7nZwnQEZOx/Xd+yQov/36XaMV3+6udWautw9oGHpS2e4PCosxA1yuAw6XJgFjoueozrd7eReeXFA/Rku1ZbjJ5V0YmLgRIapx7fYdLFXnmk2sBV5/egfJnfxKCt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRB1wnjr; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRB1wnjr"
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a49b13b745so925080b6e.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742445; x=1786347245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZwsQZAUG+S/BjqVWHNHMZh9+biN0VXGTHnyl6NsuJJM=;
        b=bRB1wnjratCBTDYmKPcC+0j8oDOSOtZi1d8gk3ta6GxcOUUEmnpRGHgmSVz8DkR092
         iB3Ph6qZboqHoLb08ahwQ4pvX/kERpkqI2fTNV8NNU0Zs2JwbDXKMttPF/K/tHEHQok1
         Nj9qEnXRHUfXj46Y6enhUHnM+3bYKSGKIomxenNW5vvkUrqYhnFFvF6gikxHTxmU+XxR
         jaHgCU6zRAk/t2TLHXpGlEEJDNfQHld8D2ui9oriYU7BzH4nEi96MOMsN6JBGn03Daw9
         cgZdx+acOwD0G7oHmaW/JKq6+iF8NzLXKbJ2cHDWtclzhdhZDAokeF0rDY9B14CmkM57
         licg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742445; x=1786347245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZwsQZAUG+S/BjqVWHNHMZh9+biN0VXGTHnyl6NsuJJM=;
        b=nrTMGeozt4Iv8H8D+dy3JLh0AwvxhOsoM7JqL4feg1J97mt2hQxWWamtiMVC6+A1r/
         uNWKZmqsli9iF0OtY9WPlth8IhqlyWCYijs27DO3jQEZX/S9WQpvdYzO0WiilhjMrDwR
         a5eJvdk1NMUWc+QQAmEg5LMMjRvI0clF5UMGRjGaeFPTDKmxwZME3lBmLJGGwSrUrSSR
         w58ptRymLQpTYMJzIh914uxK/wiPyWHO0mYaCzHuG06SgnPQ6dW7uZ3Lqb4t0xP6pObc
         Y19i1ZUCqYEirzImCtb9JYWTLZXSfEQhCm7M2Ys4I0ZXq08yiMLxIhI/RdLqVE0FjrJa
         3r8w==
X-Gm-Message-State: AOJu0Yx0arX46SW2js2SLyNKvYM2bpo4JKBqhNUPBeCno99tJPWQHOCi
	io2q3yXqym2imqLNbAeY2roEtUw3mcnVnfgGVGI23jizUsIc+fJp7EOGonYlzbNwFMHeuA==
X-Gm-Gg: AR+sD10Kf8bq06494NMjcsplWHUAySOAKc0jJ1O+SVjFR7cH6Jhznuiu4QfcaG8ELHr
	dFDHtkQczlpPORpsKcmxlHhYknlbjSTVCWHrPmJukc4By1qLm2X7r24UCV8+qAZarq4eF+zt5jh
	lCsvHTpyFR7JaZqNYKkXYdZb6+ooRDv1yIslxux6lLewq+4RxvNSxgo2AyIQeaQ9wpTK4+MIpg5
	DRBkT91y14AazMSVsAO4py8gKi2N/74yNEjKXwd8Hksy9HpsdwFIXvIRFAQLMroTq2miZD8KqdS
	GQCkwjBR/t8L9ernB7vKMvzJqioKayWVKiyX4QbpHa9/kHAjEVkzC4d89Prz1l3qme/G0S1rEcd
	JMkFPkBV0o8BWy8I1c/8VlwiKA9SOOJ9e8voCVP/3YAItHpTbS1PJy8lgRLoGyWT6Mg1iR89T5N
	74B6/A557uNNs9uiV5Kp51m+1bGzpArrPOnd86rtnnXRm0DdWxDo6FWhbMeyjCI0aZe22+DK1ho
	HRFD4on4t1Lu/fVXyoA09GPgRwdqC9ogIcn
X-Received: by 2002:a05:6820:811b:b0:6a3:7ee4:11c7 with SMTP id 006d021491bc7-6ae4336d8c5mr13345313eaf.29.1785742445310;
        Mon, 03 Aug 2026 00:34:05 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae39e2f5c2sm6173749eaf.8.2026.08.03.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:34:03 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	linux-afs@lists.infradead.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH 0/3] rxrpc: fix three bugs found by autokbug fuzzing
Date: Mon,  3 Aug 2026 15:33:52 +0800
Message-ID: <20260803073355.3895949-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These three patches fix independent rxrpc bugs found by the autokbug
dynamic kernel fuzzer at Tencent Yunding Lab.

  [1/3] Stack OOB read in TLP soft-ACK processing. A malicious peer
        can deterministically trigger it over an unencrypted
        (security-none) AF_RXRPC association - an immediate KASAN
        stack-out-of-bounds report even at the minimum offset.

  [2/3] kernel BUG in netns teardown: the conn_proc_list assertion
        in rxrpc_destroy_all_connections() races with connection
        destructors deferred to system_wq and fires on a healthy
        state, killing the cleanup_net kworker. Unprivileged
        userns+netns reachable.

  [3/3] WARN_ON in rxrpc_alloc_txqueue(): the TX_NO_MORE entry check
        from commit ae4f89989479 ("rxrpc: Fix ability to add more
        data to a call once MSG_MORE deasserted") is not re-done
        after sleeping in wait_for_space, so a racing sendmsg on the
        same call reaches the WARN on a legal finalized-call state
        (spurious splat and -ENOMEM; panic_on_warn DoS).

Thanks,
Henry

Henry Martin (3):
  rxrpc: fix stack OOB read in TLP soft-ACK processing
  rxrpc: wait for deferred conn destruction before conn_proc_list check
  rxrpc: recheck RXRPC_CALL_TX_NO_MORE after sleeping in rxrpc_send_data()

 net/rxrpc/ar-internal.h | 3 ++-
 net/rxrpc/conn_object.c | 10 ++++++----
 net/rxrpc/sendmsg.c     | 8 ++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.43.0
