Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785E400E15
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404806; cv=none; b=Fow2Rbv+9PBTqcEL0oHvTadjOjOn8jZ9p0mKB57oOFf7Teu+eON4x0Nfr6NTSH91tw/+3e53ZU8Juw46fMUbadz3lUW8gmRlw9iC+9Z8aqCcZzw1P1sqFjzHSCgHUa3F5OvSq/GrIbyWdpltJ0k+Rhy8nXmV+zr+Srr1I1Mb/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404806; c=relaxed/simple;
	bh=EtJrfh3gWIgBwQrJoI9hQ3uIjjGozoh6Lke4Lv9BmRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGTEOKfkplenz80ErisSmgq3WDF6yoKEbXLaXpbyuEOtU9gNauKvo9+lLf7nYOXmAvoTCDWWGsnAeteEHklQeAjELsj5+n1OA68dvZgpvALAhEfR04mminPRaTJMqiSdm884nD1Uel+TfNhY47pbB2GG049K4q/pMk65QrIr+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F0QerX0h; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F0QerX0h"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1292282f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404803; x=1786009603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9EHZ0CHdtF8wFlrl6hQrJPZxdjWuXWMoN7dC7+RCGg=;
        b=F0QerX0hFXpwOyb6Qs1JjrOKyil6eF1qfFl79SCNEBLqSBALDKkAFdBlzi1l8vlIOJ
         zTeC6njf/WG+Rd9YT+RSCeAm7gl6Gp5hdpxv914G5Yv8ssRby3RAZrXx8KOovQSgC6rD
         9/OZcCY2lm29NIhguIMsigYKw70/0nVi/Nj/hlw9OdGlOxk8IsG0if8ugNbay1TzV5iW
         kZND9rJeuahOZnRA6RcutSVuyToZLCmc2Y2nPQN+S42UsZPQeKzqonT5a1P6tO5NLdCF
         cjmIHw6kNMSAEXYhuM9emgypff7DSwvvT1i3Pab+5GJVRc+9AHAQE0ErFzTZFAN0jYBX
         fvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404803; x=1786009603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U9EHZ0CHdtF8wFlrl6hQrJPZxdjWuXWMoN7dC7+RCGg=;
        b=dElGezisnxXSEWO+s8+6YHozVqV64Qa60jGTiRV18fBGcsX697Unawpz0kussRGGsZ
         l6N+JY47tZ+9SsFQXYpFF60jG54dpFf5hXvmOyV5GMh09du8GZ5q9W5+R3E6Gt/Jlalc
         4fMBmJ9i+zslD/CIC/9CMwoVL+rfbjFUBLG1r3TJEIOX6Pl/E9saRR7XcZL99pt8jMXm
         jNW6AMsPmAJ/O+kFGnjDEhvtipvwKGgQEnBvRLvGnmS8lUhYLSYiVV0X/2F69T34/zNF
         j4DoMPA1Pmp9LVxepGBplP/H7Biy/WWIIhBFW+plzRP7SWFMEunI8xVIAWaJL8Mpi8d8
         wpyQ==
X-Gm-Message-State: AOJu0YxsNDX75O9bpMTNkG0Rr6VS4TChQJMeq7nH/R067NW2VxNUeb4X
	a8J3QZm6X15HFOkU1W/6j+vR40EycbMvKlRtyyIb20ZPkWB7zbP0yhNkwzm0PqOkGYXI8/4j/u7
	4MkhUhJDTZrKkzX5w3QkHt9a5ZbZUmSSFwd7Z6PJLfTedXAGrzY0E15nLk9S0++4l
X-Gm-Gg: AR+sD11kASqoRmi/uInf2LUw4v/f9lJGOX5jmmxtW0vU2AavlXWou+ncfL9wfCcON11
	DmZY94xx8lwEI8r0Vn5SeriBsqd2w2MAFNZs+Ke8zPGlFSWn5sGf04nsdhprkZCeYnbij8eCPWg
	Dc6d20/mRvMsZBuXUDad+T4wGo5crUD2A6k586kT++mw8f/2FpSHjkr4tTVbJY36l5lRzfxJjZ2
	wFzf66EkIqrUHq0sURj6p0h0HHaeVVEE1dAGogNc7zx9wTh61SsOo4J+z2CBRtv3TE55A4k4pnu
	vh+OuigH/UiWgYpCwWMLWQ7OEiw6HhFfVI43DYy9YPcszS03mLO3Qipq8PR1qjxLeRfCQlotrao
	DTyBDoI7YAYA+QC23vyIzhrIjFka0EHI79zO3V1z15n8wX6KSdY+uTwYWTWVnSsRMHokK1iI2oc
	i6yVHFVu/BaE8UlVUTcljfc4No5Mjm5BoqzPallYlmondDTCZrLtZ7jV/UpZSyQq3Sw6gET6jB3
	A==
X-Received: by 2002:a05:6000:220b:b0:47f:4980:4908 with SMTP id ffacd0b85a97d-47fc8202b8emr2469720f8f.47.1785404803112;
        Thu, 30 Jul 2026 02:46:43 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:42 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@linux.dev>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 10/10] ovpn: fix incorrect use of rcu_access_pointer()
Date: Thu, 30 Jul 2026 11:46:21 +0200
Message-ID: <20260730094624.4102963-11-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730094624.4102963-1-antonio@openvpn.net>
References: <20260730094624.4102963-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@linux.dev>

rcu_access_pointer() should only be used to test the value of a pointer,
not to dereference it. As it's in a spin_lock_bh() critical section, use
rcu_dereference_bh() instead, avoiding an extra rcu_read_lock().

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index eada414a9d92..b0519f9840d8 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1249,7 +1249,7 @@ static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 	}
 
 	if (sk) {
-		ovpn_sock = rcu_access_pointer(peer->sock);
+		ovpn_sock = rcu_dereference_bh(peer->sock);
 		if (!ovpn_sock || ovpn_sock->sk != sk) {
 			spin_unlock_bh(&ovpn->lock);
 			return;
-- 
2.54.0

