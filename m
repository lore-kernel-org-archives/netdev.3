Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965A3ACA7A
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682484; cv=none; b=DypRgHtNvDcAXSR4g4b8e2dAJiumnwPv3Nnvn5Rppwe9cIQ9T/Z39vtw5pDrVFBTzgoWtJSUFLoxoUS1zLl+CSzZNcHVkDZVnJpWJeG2P9IEdxrexaDRKouUr/3G0H0fqTJrqMPZBX90dhRwc9Akzc0z1YawrJPm7iBmMmhoVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682484; c=relaxed/simple;
	bh=P5/CfOGFGVjMXctTHGuF1aX3rpeY4JVXEkJv3aLXfN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N/kLxg8CsdQbS5T9Jg2SFGaoHO+hmOGkYRHRLfhElYJlScEUzaX1Wyf+a08LOsr3EtOYdl0C4XMS6QCqJOKz8+diPvgQT0ILW5n8UxlfHk7FO9AdbfQyhUi3y2mAunI8V8uNNTpR6a/d0r9cin4WA5/uPqaDd5CZ6yXLJhP+Mr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=HJnUtMUg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="HJnUtMUg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so680755e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789682480; x=1790287280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ro6SttdQWiVFkbJS47mTtfdYN9m9RFgqNhFOaAFAJrw=;
        b=HJnUtMUgHp4vFeSGFazVo+Sj0jnptZomiy6ge+piDvd+enwds7FAfejcj+Qmk6Y38q
         7sW4GWLx3wZUvQa0SdwIPOvGP44U7QqzhSwiO1X1S6i5K6hmirsch6IrCooL84AF1UZj
         Lu6EPzCckdoEttrFIzpSqx3EzEoaya0CE8ydPZzKHIuV0bxr4WMcjZ+BXLivOBUwA5Ol
         fp3qj5IGdQ8/hQr7bua2YbXqzswZN4RvcJIhE6Nz8N20AxgcBGhvZgNFTGEzqUmQW3sB
         U/MrMZnqrEjW49f1z+PXLYDm/0dlF2R7NYLNYFwmzA3UUML7Eh5Q7nr0RhZhfTrHMI5w
         /XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682480; x=1790287280;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ro6SttdQWiVFkbJS47mTtfdYN9m9RFgqNhFOaAFAJrw=;
        b=cb4heCv+3FubMLzbaZPJ1rqmRb+jGG2avo1J8XAQc2PiQy6ToNTV3fse2YUQotKo7k
         TLfZ+bnDsePpe6WT4v1Vas11kMVvkfr5McjiLLXEVA2WTdud040A1BGFKBe2T54NggVg
         IjUNyNmSjIOsCMUNa9degrjywcoL1GN8LDKsNNgxECXjoQuqkP3iRzmU+hXsJ2d8IgNh
         7neOq4sUOoJpRIiL/B/fXEnPyAf1VGoRRAi9im+9StNsDeQNI2HrSYlaK0NCxN6DnG8V
         PSG/Aq2TZUrj61qqQN5qaX3kmH9ylUHrnnyNhO3MENDrIuYJE37HJFUsqhzAbtoHeldT
         ZBdw==
X-Gm-Message-State: AFuF++k8rxB8eQb1nf1ZpV7VPBL+u3qQK9eqdPLb9CDz4syE1a4TjA4P
	88PRq+XaaEAfTvG9JatM4nzQAGvZpDgvX4uHn/8Rs8p5q1xvqAUa66t/Aeu6sUdAisk=
X-Gm-Gg: AYBFou0W+UIs7WpGPzqguctT2/SBSVn0LgEgpVNH5h1Pk38BKYaYOhFURabcSufnwIg
	8NbqDFZs+PYS4fcvZuceTvydhmxkB9WNMbhg0/BbvUVIe1t1yaDn9gmKUb7SE7nWrWY7kFLgLjx
	P5q8iddnGzOSKGC5TPqjoHSbqVvlQ9/LzNa+SskZfDkThYGOvOm7aJiYafkpoc8D45UFhIvJCkj
	USfwFabsQC2wukI95Ie3niYy8OndlBEMPitL7VTKNGmvvcyOTxHq+J8aH/ysEYcJYJ15bVSZdne
	uVO+fwygKklDtO7i40J1iCEpv5aUf7T3zQGBjthmE0lr08e2CIOc8ZyPtiUB90ngVja6AWWg79z
	rYk4yIZKOvWe97zyR1SbQ3rk9dT/OjJUBDiHcyabU6BMfj1zYJ+hG3NlVzEv/wBdlEctALrPbZi
	/HGmdCYDJw3LJuwrWZOAV64ZRor9Rf3xJ25tmubsh2PHehojF/TOCQGpapwqVbPCraj5WdLyS2I
	cqk1t2kxSGF+T0DfP0ikvKZAV3ZAXjmeSN1n8Urt9+HYkzG
X-Received: by 2002:a05:600c:4e46:b0:49e:642a:4f6f with SMTP id 5b1f17b1804b1-49fc585e9edmr2469425e9.33.1789682479877;
        Thu, 17 Sep 2026 15:01:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:744c:a1ba:d233:283a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc6ca43edsm1669305e9.0.2026.09.17.15.01.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 15:01:19 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [RFC PATCH] vsock: keep SOCK_SEQPACKET message boundaries on interrupted send
Date: Fri, 18 Sep 2026 00:01:00 +0200
Message-ID: <20260917220101.55744-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A credit-limited SOCK_SEQPACKET send transmits fragments as credit becomes
available, and the VIRTIO_VSOCK_SEQ_EOM flag is set only on the fragment
where msg_data_left() reaches 0.  If vsock_connectible_sendmsg() exits via
out_err after a partial send -- notably the non-terminal -EINTR path
(signal_pending while blocked for credit), but also sk_err / peer
RCV_SHUTDOWN -- the already-transmitted fragments carry no EOM.  The
receiver only advances msg_count / sets msg_ready on an EOM skb, so the
orphaned fragments are silently merged into the *next* message, violating
SOCK_SEQPACKET atomicity.

Reproduced on vsock_loopback: an -EINTR-aborted partial send of 'A's is
merged into the next 'B' message; recv() returns one [A...][B...] message
instead of just the 'B' message (reproducer + before/after below the ---).

Since a SEQPACKET message is bounded by min(peer_buf_alloc, buf_alloc)
(EMSGSIZE gate in virtio_transport_seqpacket_enqueue()), the sender can
wait for room for the whole remaining message before enqueuing, so the
message is committed atomically or not at all; an error while waiting then
leaves nothing on the wire.  SOCK_STREAM behaviour is unchanged
(min_space == 1 reproduces the old "wait while space == 0").

RFC: an alternative is to close a partially-sent message with an explicit
EOM on the error path; feedback on the preferred approach welcome.

Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
---

Testing (vsock_loopback, unprivileged, single process; reproducer in
t_vuln004.c): receiver buf_alloc=16384; a 14000-byte message is left unread
to shrink credit to 2384; an 8000-byte message is sent with alarm(1) so the
send is interrupted (-EINTR) after a partial 2384-byte fragment; the 14000
message is drained; then a 1000-byte message is sent.

  before: recv() returns one 3384-byte message = 2384 'A' (orphan) + 1000 'B'
  after:  recv() returns one 1000-byte message = 1000 'B'   (boundary intact)

Normal SEQPACKET send/recv (the 14000- and 1000-byte whole messages) works
unchanged.

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2250,9 +2250,16 @@
 
 	while (total_written < len) {
 		ssize_t written;
+		/* For SEQPACKET wait until the whole remaining message fits, so
+		 * it is enqueued atomically.  A credit-limited partial send that
+		 * then errors out (e.g. -EINTR) would otherwise leave EOM-less
+		 * fragments that the peer merges into the next message.
+		 */
+		s64 min_space = (sk->sk_type == SOCK_SEQPACKET) ?
+				(s64)(len - total_written) : 1;
 
 		add_wait_queue(sk_sleep(sk), &wait);
-		while (vsock_stream_has_space(vsk) == 0 &&
+		while (vsock_stream_has_space(vsk) < min_space &&
 		       sk->sk_err == 0 &&
 		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
 		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
