Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498D41DEC4
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576298; cv=none; b=lhxyGHPDwgmhbJ2/iwfApcZiu3n0z53sxBCcdDAkPkRUOly8p7YngD1urJKPdkbAjHYeCHRGNVsS+43kEz3bNwmYG87QecaxIPo5Sx1CxhwLl8t+zvb3Oebua+OKTzSxJAr0K+U1tRZqYMUH1DHQSoXHhlDsq+LRmisevvEWLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576298; c=relaxed/simple;
	bh=ztLYbWJ1y8k0+eUnrRRP6Ge2zqUEpkXCr50a1DVmokE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwTGOFR8dMX2oyOICdVp12tXYoGylcu3qQwOYFpUV+ZYjOBxbRtSUvt5yuBm3NftBHjBE+Y3X7CS+tSwQs+WXWKc4XAo+RhPeq9EeCjVIFnrpKK9I3fVxvGJ3hVdRvBFauiaQq6hodJiaj7bkAmPCZpjSNoaOrdoiEvMA92CyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTEH127e; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTEH127e"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-907ae240ac3so1722506d6.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784576295; x=1785181095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVmP6Q1Pga6fp07J2kITQdzujOlBsfUzlR7zTDUVucw=;
        b=jTEH127eQkMCqb+8JGwTuoJAPxrjQcFNSjL7w9hkIAgX+rlK/K8VL9dSF4djdTdJ0P
         hrioUDUlQKjVev+tqOZeXY6fbJL+yhX+96o4+Osoy8keKrdhZxGgYhEzEgTpad9JVXZ8
         /CNjxI6scFxxA3npC7gjLp47GCZzqE5DJR2+4dtNE7eTLEyrymlKXvg9Otaj06Gl40mz
         f2RaumLuay158ybCU9abRJBdWf7zX4o4wqbDpJuf7Rfq06dvMmmAmeW9Kk/4KjVhxPOd
         5eFAbpcX+MgggTtfAx6SSjM2DPNZENKOXGIELE16HNq3mTvG3ANyAZkX7UGd0ZUO/K6v
         LZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576295; x=1785181095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVmP6Q1Pga6fp07J2kITQdzujOlBsfUzlR7zTDUVucw=;
        b=hWGeKonUqza1VpXbfPbzVy+IClZzEtfcmBEwXP9FhmuO7681pXfK+Uzf1KRXYnp8tG
         XFl4gNwpnCG03iM6BJIE3Gkkrj7WKX2AOnjNTMU1psvZIzx5OVw1fE+uDH2z5WQuRDvw
         RzTTkBZ4u7QnGRCRDFXZuohPGA0DitK2TTKfXWMqCLebOC+PVhBo/YRX51sxq1sDbJtu
         VeEdwQ2mS3uXxv7eEqAUH2+96x2ILJ+QF0On/r1CESQJsGfmgjo5yz8ZiauQb1S+0kad
         tC7sd6u14TAly000MtKeBYTwoN9Oapi6zZaTNYgY8ZO8JET8DtxfpbWmfZr/8HFbxApC
         OlIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn1tuHew8xoQOXUiKSHjJDF+9cF4DT2fPRpOiPxZA+/3O74hiakkMiH0ihKyoJXou/kdOGV28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbV2I2eqM7LvnllfdcN4RzYqnAcfsVcGo1p612ERugcyoWb0D
	kjhRuDS7zWwPTpEncDwHLlxZSPVQz6CeUrqmoFVoNCAxbvt3L6VHtlBs
X-Gm-Gg: AR+sD12fJrGkHhsRoZhHRM4npcxGuM2UMUP7S9i6yO0v7KtWCZjn8e9T7Ffcaaxma8I
	jTiu2A4pi0T3FEGoAIgXKkOqtsj07ddpMW1/XETYyLmpLypW+9t31kzIePMjnvVEnB1ywUnUZNo
	CFb4gnlWh4DrPvD45Wk7C84wYmgSLWsXdw6XkaH5looB9kw7QLyHkI7fOB1FRpxM7pVKmXaTLBn
	WPf9MNcOrARkSDkRMYfDg+oVM+75thFPyxFhOmfwAgkmrRLH3eINRx7zpMNpZJ2ezO1UG0reOFI
	k/2UbkySyABd0bqDvXsj419o4/IcmAA5qsqOnaNn2aqjLkGMeD2599RY36/q6Gw0+ac9LKcVAin
	IjSCLshQ2lEB0j2k0iE9VqLr9ZJapKf8FbT26wBnp0GpE+4OzJWoPbBR7oAJuI4MYy0FfThBDfW
	qYboeYpy4G+4V7LBovQHyDgkOAaR+lsqk=
X-Received: by 2002:a05:6214:2269:b0:8f1:8937:5dc7 with SMTP id 6a1803df08f44-907784ddf91mr182320336d6.56.1784576295334;
        Mon, 20 Jul 2026 12:38:15 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871f650sm98436156d6.45.2026.07.20.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:38:15 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: david@ixit.cz,
	oe-linux-nfc@lists.linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH v2] nfc: llcp: Fix nfc_dev refcount leak in connect
Date: Mon, 20 Jul 2026 15:37:59 -0400
Message-ID: <20260720193759.1773705-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llcp_sock_connect() takes a reference to the NFC device and keeps it
while a connection is active. For a nonblocking connection,
sock_wait_state() returns -EINPROGRESS while the socket remains in
LLCP_CONNECTING.

If the socket is released before reaching LLCP_CONNECTED,
llcp_sock_destruct() does not drop the reference because it only handles
connected sockets.

Drop the device reference in llcp_sock_release() when unlinking a
connecting socket. At this point llcp_sock->dev is still valid, unlike
after a failed blocking connection has cleared it.

Fixes: b4011239a08e ("NFC: llcp: Fix non blocking sockets connections")
Link: https://lore.kernel.org/r/20260707183518.1888697-1-shuangpeng.kernel@gmail.com
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Changes in v2:
- Move the device put from llcp_sock_destruct() to llcp_sock_release()
  to avoid dereferencing a NULL llcp_sock->dev after a failed blocking
  connect.
- Add Fixes and Link tags.

 net/nfc/llcp_sock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index feab29fc62f4..0a3d87c2c9b3 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -633,10 +633,12 @@ static int llcp_sock_release(struct socket *sock)
 
 	if (sock->type == SOCK_RAW)
 		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
-	else if (sk->sk_state == LLCP_CONNECTING)
+	else if (sk->sk_state == LLCP_CONNECTING) {
 		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
-	else
+		nfc_put_device(llcp_sock->dev);
+	} else {
 		nfc_llcp_sock_unlink(&local->sockets, sk);
+	}
 
 	if (llcp_sock->reserved_ssap < LLCP_SAP_MAX)
 		nfc_llcp_put_ssap(llcp_sock->local, llcp_sock->ssap);
-- 
2.43.0
