Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA5475339
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933637; cv=none; b=n5TJ1Wz8VA9N9EiWLwB/aLqwPKRrWnImv4+5478FFyLv9AC/dmXa78Bg82fBg6potSN1N/Vi0Xulp939Kpp0B4vL1wNf7XDNx+kneWZ4iibqLxwsmjsWEzlWPndHnTp/tVisw+aXjGYyQwI2MVRb5rQpwfkD9gAfXjYLNVelT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933637; c=relaxed/simple;
	bh=k//2B9OVyNb3LfKfZMQ5Ujz7TjjuUTfaf0JY99BJpE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHTGMM7iB1S2grHH2xeLeh3jLzXf5Bedm0bAYbqOvpAiHOYLUDkVXVeeEOTb5+lHgxBvMkxaii6uR4DVBzyILrkIzZnIRihtFlAWwV4s/LjMaDrTrw9lE7PVAaGr5o+MAvDH7+oyPg7Qn3Xa3132kHE4ecyJbcRGwe7A1uDQvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPqRH5NN; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPqRH5NN"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f8694aeso124153466b.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933634; x=1790538434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6GiF+RaRfkQVR72zMKUjo/mKJQNiAbemXLgy1Bp7FnY=;
        b=mPqRH5NN4DqGY+QxwZwOpDwH3nJ55zoBkYnZs+uYw5jPRw1ztZEE7Xhk/oCbTUv7HA
         KPSGGzHKvThRWO/PA0zKt14MXcAUoS1bH2wEjhN02f6QtbO2QjLpK9nvBSD6gnqJPJqT
         Z9Q+pyb5zu8Z/f/3lxxLdcmt2Mo0EvdducdwEJLlRRYSbjsgV1peuWAsl1aTIVLKSnsi
         njqzCxUr7f2IlvBwY1NXO4SiztC/KXXPgHOmUD0vCEUJjpeYzbTwlmOL8nF/mOqrjgTN
         Pbp4BNpraUyf6V1BGtVJGVG4ViiKRE6l7XxHFGQb/vjaHoC4arUkG9Aur4BVGK4mwsEz
         9oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933634; x=1790538434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6GiF+RaRfkQVR72zMKUjo/mKJQNiAbemXLgy1Bp7FnY=;
        b=H+67tg/Zy9yWb/Em+ZG9d8IsiHXG6rCCrkMFGcRVe0i8SKXvUqwcYZ/H9HnJyDVeY6
         MjwlQBy7oZ6fB0n3l8Hb9m7LSpSN1aJBoPlowRJM4BSpgHYcAfZ3QlmM0kdpueEovuwn
         k1dHQrCn2SRI5YDPxWpEu8g7Oiku3ewWCsJmpc5KshPJdV1lBTApq64GsK11LTpAIKOn
         gbGZhsZ60rQIv9vpPMmfMsi9nQzyebYXdNQCG+4JBqne2TpahPvf7cEcMB0WCR7Uqwqt
         XFFdNEzoml7Gn5M3l/wA9rXN5uDgW6T6GL9Zzco5GHOFktTZVjISH0qW/Cls++gKzYnz
         TddA==
X-Gm-Message-State: AFuF++mDTWC+/0VE/JJ484CSIN/itpXEx9xExNaHU+dZ+Rc973FOsmJt
	0p+v92AWWykIm0WXlByNnBs9Nxd8ZfJV2U1QsTR9glGzpr0w9SwEqFa0B8cO+A==
X-Gm-Gg: AYBFou2gP748/1kJm4rXfY6HkW59xD5vTjVSbI9Myc+54QvUfTyG+BXGB4B/yR3hX4D
	meOrkDJNTRnFoVCp7Bb68EbGl8nou3PZdJm1mHRvgUCyFhWS8zDp73tM73KIZEmjnHHNIHxCmAr
	Qc7JHlXFhZAD1POt+xvsQX6AfHFKxw51rS8wAv1lMJN1hpeR4lV3h9K8CP+mQCXOrTL4iyCJB89
	C9QZDynUpwZPYufJ5KezPfqmJtAthbSB3jXx5VBhVZpHcIcCKv0ucSjmkNWJ0u9RYpzW4fv02q9
	QO12vAq0/vLqDBgRHkfhLZcKsh0HoacNUCOg8yEN0Sj8XMOG4WIF4KED5Aqi7WpqhzAUJ020j3d
	az5HRie2Fbq5Li05IpBpZXn8+ZofbaLLN8XH2hX18qUOODJ2ssNWja+hCA3zc3VcjK2v63dZYsj
	IFC3zMV2rX24YH5z/v8oReDz/QazPlE90Vb7o0e8aeU1S09G1dp+ZqqAkGrFBVy8aRRx9zu7+I/
	PX3IJohMHy+ksRk+cFTl+5RzSzQPV38FBmRmLEGeuji+PsfuUdlAxi4n1Q=
X-Received: by 2002:a17:907:9616:b0:c29:d1b8:6c4b with SMTP id a640c23a62f3a-c2a16401446mr770255366b.4.1789933633593;
        Sun, 20 Sep 2026 12:47:13 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358ff8edsm211768466b.61.2026.09.20.12.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:47:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 0/2] vsock: receive queue hint for io_uring
Date: Sun, 20 Sep 2026 20:47:08 +0100
Message-ID: <20260920194710.1114748-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_VSOCK stream receives never fill msghdr.msg_inq. io_uring initialises the
hint to -1 and treats that as "unknown", so it cannot set
IORING_CQE_F_SOCK_NONEMPTY, and it speculatively retries a multishot receive
after every completion, including when the queue is already empty.

Patch 1 fills the hint at the common exit of __vsock_connectible_recvmsg(),
reusing vsock_stream_has_data(), the transport callback that SIOCINQ already
uses. Following tcp_inq_hint(), it reports a terminal hint of 1 once the
connection is finished, so the caller still performs the receive that
observes EOF. Patch 2 adds selftest coverage.

Numbers come from a ping-pong over vsock loopback using io_uring multishot
receive, 4 KiB messages, the queue drained between messages, with kernel
receives counted by a kprobe. The baseline is the same tree with patch 1
reverted:

  entries per delivered message   1.97 -> 1.00       (5000 messages)
  receiver CPU time, median       1.640s -> 1.587s   (-3.2%)
  receiver wall time, median      3.260s -> 3.183s   (-2.4%)

Timing is 25 runs of 50000 messages per kernel; CPU gives Mann-Whitney
p=0.006, wall time does not separate from noise (p=0.12), as expected for a
latency-bound workload.

The hint is gated to SOCK_STREAM; seqpacket is untouched. SO_INQ and SCM_INQ
are deliberately left out: they need their own per-socket state and
ancillary-message semantics, and a byte-count contract would have to account
for transports reporting less than the whole queue. That can follow.

Testing: built and run under virtme-ng on loopback, where the new cases pass
and vsock_test still passes 41 of 41 with a clean dmesg. Other transports
were reviewed but not tested. Hyper-V reports the current packet rather than
the whole queue and can return -EIO; an undercount only understates what is
readable, and a negative result leaves the caller's hint untouched.

David Carlier (2):
  vsock: report pending receive data to io_uring
  vsock/test: cover receive queue hints

 net/vmw_vsock/af_vsock.c               |  39 +++
 tools/testing/vsock/vsock_uring_test.c | 367 +++++++++++++++++++++++++
 2 files changed, 406 insertions(+)


base-commit: cea851523034d83dc61d882b1a6a3ad273480f7b
-- 
2.55.0

