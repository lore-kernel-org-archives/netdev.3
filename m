Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016259;
	b=roN4O5ioTu1/+lWA7HwyjBQ5y3Hosy5NNyQUUwGSInzhjpd/LKGK41qHDJkce43OifoS
	 Xhxn9svUpIFZl7LSdNV6kOLoC/3Y8JoF2hGNtiGqrFEvUSedBlP2r02vCwoZsc6pk3vLU
	 kxh+OeHF0PlnWbCrMUqtq7LT+SpaDEdz/fsK3zrsC3XuIW9/hYggBdCdJbxLq9oeHHiuU
	 tRrfYWqgsHgMifqpJYj1oQnOtPOf4GLkBqw1yYP0aE+13EHfnD6NqefQcKqrXnphvvTOF
	 FhPOfPtUkBJaPw23Ov1k4I1NaUj42nmNA5AZ6fFsyOyIUcEnA2+X2qjgSR/CpqIxUQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kLE4fUltKdv5uUw+RRFjSPgUp/UfLHROFugaciW1IrQ=;
	b=eBLqaUVt9GEWqH/m5L0zHYVQKC6QsobpPk+Waz+DZTQAzZ2wGt+9x9wTwbnn0s+sUuB7
	 ncXTiE8sswNkaXfAnaIJJO/i/0r/gArVGDKAjNEXwwS1TDcHt88A7PzquqcQtabzaDbmh
	 vdwmBtC3mK0/Qd2W0h70051TJbzq+M35y52/5NjDrfTTyz37em6s1JbACAihIbOVuJefE
	 t9oc8oPeF4OBAGoy0qRQtwyTwieLur2gxPDN+uaz19fGXeo2nRHAwuRiDVlUspr2id26U
	 C3OBE59Arf5dFZytdIGOUDZGrBzXGIWMB945DXOep8GXIYQa+JDbmCVDTWytv4WuxUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="c44ex/XP";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B7606A326
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2B7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c44ex/XP
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso1566439a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793016258; x=1793621058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLE4fUltKdv5uUw+RRFjSPgUp/UfLHROFugaciW1IrQ=;
        b=c44ex/XPmtqTVtiuqa/0GcvrFN4lsMr7UlokOnm3tm9vhaHcNfNJKiEURU+QVnnbv7
         77acTuyynbe0+PdVQGEaDijC3a7byLiox8BIL3MBqsKZF4Ylc+eAEO0vdFwsakKv8zDQ
         bfQXgM1jf4PGxlPRskyEuXcfL9qFOpE/k6BIeA2hGli4kIbXYD+1pH3VoTPkhxeon4Ax
         sso5eO+f7PVempwkWje+R68n+7ExMEGVIU1a5otcmxh6MYp2b3U7D9XsyeUQpM8WZ+zJ
         2H8tZnia2t1DL3MjtZuDJBqozookU/+h1WpjEl6BQ0vmR9nDamBBByuTjYa6jFWOaGVU
         s4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016258; x=1793621058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLE4fUltKdv5uUw+RRFjSPgUp/UfLHROFugaciW1IrQ=;
        b=qYHHH2hWibslhHTY8y+K66JKAW9PC2uT4D1Q0/P56vFllvsQrYd2jXM4XfCrQpVUhr
         RlvbKZ/r+l/89IEl67zEv0bhm0OgIfL8Goe4+d0zvGqyUMb5+Dvdr7mM6fCNIIclrjZD
         doOTMC2Pyl4p/HtW8KWDtvob9DQft3LXVuIpRz01sHbNL/Cry3qpOJT11aYMzHGZW7fK
         so2UFvGykB9Bvt1e7S9c7MVa5k5yfx07q3jgnK6lQ+oHXG940LQdR/X4hDFO3/E+iUQ6
         pylaY5dUrtLHqMCJLkkkZCY3+NiOiVJ/yahehcMk4mQUhq75ccZp6Z6lupIwn/7Ec/2s
         BjeA==
X-Forwarded-Encrypted: i=1; AKwUvByWXOXGcPTTDx+Xu2GlAkjDhSzITu7XAqSo1Onb462vFpYUwGbxN0ctFdJzMwjWmYTHD9tU6Ng=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfgrA7EMIr5fVwcaTVWqBsPHtkTZCqMkhkhZMT8zIpbytHzZh4
	PGKraNlX105cbLxIzqn5+F5zjRgjxXFEyKhxsoXVZ2IeYszjyJJl1Urp
X-Gm-Gg: AYBFou1xpcNH0zATPH9ut6KhJW3j1xB9yjf+UsqwdjK5kEmmso7+BaGO5PEErXv/hie
	0WiEzZ68a/kevHWF9h3rv8e3gcF/NrsXoLIVB+2jJ0uXNBYKd1kGSnxZYnRy86hVPTZ/FcnEPDj
	gGCKgbidTxDCI9XuDw0tLzDMO9J6EERnuvDfyh8zdUdxC7MH1XyQkyKLAFKCUaAHPxs49Kjy9uG
	wfIlEcn4mwkUoYeImFBUv3Sz94Q3Mnj4hn0gDY21kHt1JLNI87AAt4dY8tej0/o+wNgapMzQDlV
	2IxomWYXO50sKvv/JsQf7hOqYFrV+n0DwOrntMu99b/ZGWPtGQ18mTTnAQ7kvoa8osu6OIxon2G
	P303DmwyL3UlYpmdWkLUTn976DJzVdSOTUK53wBJ8QVdEKTRG6h2VCa1O61w/BmKAv4rEiHtOqy
	UBwXkgRbpxH0gQJXFtbgBITiNtV190MXv1PiNH1pRpg3IG6A5001MLGN2ZaPpZ7h0sTuEIYCRFd
	vSakT7Q+DmtceHNrfhA++XNYabL/k3L4BnsXPooeE+bZC47qZk=
X-Received: by 2002:a17:90b:2e8c:b0:3ac:8897:7b9f with SMTP id 98e67ed59e1d1-3adeae77a16mr5287757a91.43.1793016257392;
        Mon, 26 Oct 2026 05:04:17 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0639bsm8298309a91.12.2026.10.26.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:04:16 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: geliang@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH net 0/2] mptcp: subflow context lifetime fixes
Date: Mon, 26 Oct 2026 20:04:07 +0800
Message-Id: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two use-after-free fixes around the lifetime of the MPTCP subflow
context, both found with KASAN.

The delegated-action queue pins the TCP subflow socket, but its queue
entry is embedded in the separately allocated subflow context, which the
ULP release frees on its own. Patch 1 keeps a retired context attached
to its socket until the socket is destroyed, and lets NAPI free a
context that the plain-TCP fallback dropped while it was still queued.

That context also owns the only reference a holder of the TCP child has
on the MPTCP parent. Patch 2 moves that release to the same socket
destructor. This covers a BPF program that converted a TCP child with
bpf_skc_to_mptcp_sock() as well as a delegated action that updates the
parent after the ULP was released. It depends on patch 1, also for
stable backports.

Cen Zhang (2):
  mptcp: keep delegated subflow contexts alive until socket release
  mptcp: release the parent socket reference with the subflow context

 net/mptcp/protocol.c | 18 +++++++++++++++-
 net/mptcp/protocol.h |  8 +++++--
 net/mptcp/subflow.c  | 51 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 69 insertions(+), 8 deletions(-)

---
