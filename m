Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F60364E89
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821141; cv=none; b=EDuQoPoC5m6qZZyaILM6p7YBfQxhCzX4Godp5/24MySbXJIKBM9XIf24fUBj/7gzS6lnQs/KpN3fxGX2TwsHJc3WXG9i03s3Hn+54+lhoFF4NpBlUMi65Malxv3nMjcXZeN0emcz3JDvo+il6z6gYS3L9ZGTBpFbCXwVeYIkkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821141; c=relaxed/simple;
	bh=ohMLhoHsIhyrQR++saiVhSXMuKOsrbcqrQpd5HS7woc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNjiidK+hMPo2N5cB6cyRP3Qzq5DKxzgUS81nw+pAhZb8wlR5qV7twSyDhTLOdBhA+2WL76Vfl0L3+O+PObDqsSD2tF+k4YRs46vAV3/KCYNi1cm9QGV/X+Es5xmzAjSJ9o23Ja5Te8BhJ6YZ47o2x0Eqhj5Hr+H9k3rj2Dn5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=VEHKZ/ei; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="VEHKZ/ei"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so7448745e9.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789821138; x=1790425938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UwlcS9+bFUXKkO5ovoMUYQeBuvELj6Lvx0WboaUWawc=;
        b=VEHKZ/eirlNE3GqF6ljgbufpC1whZ7Ox06fewUk23pQGYZulQ5419SF3E1i+tYTLFt
         IIgeZNUjZR9StsPxqAvhYTMxd4omBw84doRKzizA75mlvt/5nx397opG0u+CtBTK54dZ
         PJRQEZEv6A5OY2PGyBViaxOQ5zey2/zKFt5gdJILTD7LZXggjV48ZjEhsJFVXGbFBKQP
         4LiTcahUy75vtiLr0hv8D+ulJNlXFoIkzQgMqOs/S72ajV13612e2tNNmkrl3mjgKfN7
         1BHcKVTL8CH0G1v2BPpsHKWsYyXPq6PWaMO7xj0CZj2u2cTnp+RMU7RDjSmxxWwAdkDz
         KLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821138; x=1790425938;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UwlcS9+bFUXKkO5ovoMUYQeBuvELj6Lvx0WboaUWawc=;
        b=ot51bGRAWcd9mjum93z4vceemywtWKQZeVTBNgCNgs5iqI0UU9mh9uyMX8BqUYS7Ww
         2g0ELGnUq/M5k3itkDBRU9OfMquM56THtJJHd27Bc1ELiF/qx33W+F5ciFmKe3Zhw4SA
         HSG4TytwqRpa/mjN+kMOGqPEckjgM7GFUE5PsE0vyMnR9SihWMP+HOhxSt4j4qOv/i89
         v7z0YHYkQ7P5FFtnRj5JWCmdDq9JCv0XFJ2p0zSV3fWTCjTGTSbDWucaqWpqZvAId2DC
         /KF/O29r06R2kSwoeTVgRVQYJhSy2RVY4b65r+garrIWsOxYPkkQV/BhnI5FyA9Tuy7l
         39Dw==
X-Forwarded-Encrypted: i=1; AKwUvBw0P6WYfSPk/RdpARCL1g10TsioiaC41EQUZSbkSzW7SrIgs/g0LHuM2O/FEPnHeiFNdWDsCew=@vger.kernel.org
X-Gm-Message-State: AFuF++nWLjw18Du6YbsHlHDoqMDjRyEpMz276RZHKUAnQoz7grrmsN9X
	1YCgsIS/EohBk8cdSFhhnncitRQ3Kv60OJRUGM9egD92WyBlGUjbIeiJdijcGigUA0w=
X-Gm-Gg: AYBFou0pGSlpd/3pUgOtHlcxqyZRQi/O1IomBHZtGjVm8NqcF9fDGkOFGLag03hLs/E
	eDQf2Sk5ztvkYeWGyVcdImZCip9wrCpyLX0hu6IXy+VbQBZ00abTikrRC16ongbfMr+3Jz5TRHr
	yxvPZBAZ4V/ye5ALBAz4h3zMq8boAlqYbJ72mt1eNAyG+0dTNZnCwikew8wefzQLXybRj3QwkPD
	QIGS5LS2QGfBhgUfjFqJ14rnNemvMU3P+Sw/Zv6mQ8v3lhulgQRryA0cDK5AqqCmxoNqp7rNrjn
	38Ej1VZr6/qDb44/mA5eyGSMMzeF3BghKQA4nebfQejQnyb42zJOmyDen/pOMtAOpCIMQz+VRwW
	lNo4cEMkfW1wpICXuYnHdeoSeOu6Zc3+GeSBMbZ+2ZlDvVNoP9ZxmkDfG0sKJddA8IKmln8mjOj
	Ct9ZBT0kmVoIdwB3LZtQRkddDM1Fj0CKZHM3QdTknCjQTa0grAVSNHsE8+gqE9R5Cm+gyhw91KB
	JLTbhm7Teed4HAWKgSYCf+aSIckIrIZhEcU4C+woF8Ne6o=
X-Received: by 2002:a05:600c:5251:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fc5736898mr67615405e9.23.1789821138247;
        Sat, 19 Sep 2026 05:32:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:dcd8:ca10:f229:8aed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d21asm88593265e9.12.2026.09.19.05.32.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 05:32:18 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] vsock/vmci: enforce per-netns mode on the datagram receive path
Date: Sat, 19 Sep 2026 14:31:57 +0200
Message-ID: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The send hook vmci_transport_dgram_allow() refuses datagrams when the socket's
netns is not in global mode (vsock_net_mode_global()), but the receive path
(vmci_transport_recv_dgram_cb() -> vmci_transport_allow_dgram()) did not, so a
socket bound in a non-global (local) netns received datagrams from peers it
could never send to, defeating namespace isolation.

Add the check at the start of the receive decision, before the
VMADDR_CID_HYPERVISOR short-circuit, so the hypervisor CID is covered too
(matching the send side).

This was found by code inspection; I do not have VMCI hardware to test on
(compile-tested only).

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
Assisted-by: Claude (Anthropic)
---
v2: perform the netns check first (before the hypervisor early return) so
    hypervisor datagrams are also gated in local mode -- the Sashiko AI review
    noted v1 left that path partially bypassed.
v1: https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmitruk@isec.pl/

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -532,6 +532,14 @@
 static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
 {
 	u64 access;
+
+	/* Enforce the per-netns mode first, symmetrically with the send hook
+	 * vmci_transport_dgram_allow(): a socket in a non-global (local) netns
+	 * must not receive datagrams it could never send (this also covers the
+	 * hypervisor CID).
+	 */
+	if (!vsock_net_mode_global(vsock))
+		return false;
 
 	if (VMADDR_CID_HYPERVISOR == peer_cid)
 		return true;
