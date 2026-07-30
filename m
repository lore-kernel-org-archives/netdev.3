Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262723FC5AE
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404800; cv=none; b=ng/xUEPJ/UkbWiIKkLd+RZydP1GNWcQceiSpQLrXZmbv5B9ynYTVGi3ak/b1Jqs3oxi3C/XZnQveIGPtsAgGzyxJFzdY2/jR5+kpMnfbHCCVrAYbYq8QMJwGq9wxGuVp1AmwiNugC/nNOU0szqINYVnpa0kSd8vZRpwAf3T2CXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404800; c=relaxed/simple;
	bh=xVH6tWHuI1lRPTlxaP7bRyuMEEX0Xjk/LDTBiZdN5+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igZDM6EXRk5FE+zemsAqaJoZnqdmyP3ktnOh/1oZV6no41jDtQC5mjtmGjMK5h0jH1IcGEU1Aj3m6YkXMcY29onmeSDbglYuBvCMXD6uet2SANgRnhhkSndYqDFGX8K3Cb0vaLxTME9NOCeSYKCxBNDtdQOMVlS4MVV6kaibolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HTYj1CCq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HTYj1CCq"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso889503f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404797; x=1786009597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exNT/nY9qzJ2meJdzg7dg/7lugPDMQCo/ZK7XDMuADo=;
        b=HTYj1CCqSddVfyQ457cTSamAFGQM55hyGwKvjhaoUG2euU3TBUUdcJuaVn0a9IGEqJ
         V2CSLhLNp9kM+VtryoFWKCcvdKFIWx4zAl9MJiCOYM1vHlV++uz+70Y9hqiRustM13Ns
         cunigsSqXfNiSEnHOFsbzOp0B+e21CKJttxyMGrBa3p1RremGD8TtQQ9ApwKe4LypYlo
         XloT8kqxNtb/cS+kSbtagqOmdZWpODBL6lOzOTfSwQMHVn0vnaDGUeOgE+bhjyGPuMHe
         PnvBV465GiJVFRyBzTsLZymWg6+jtbtQ1sfg76zTH4AEHKvYtdtOhIDyYwYlqTdaWVf6
         ydag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404797; x=1786009597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=exNT/nY9qzJ2meJdzg7dg/7lugPDMQCo/ZK7XDMuADo=;
        b=T19fWNyFAWvm0LgUcF9og4y/CbP/+Rni17GDK0rwrcPEEHLybUApsXTfnvplTyYt9U
         6cSEliAYcLTsIOLlG6lcJ5YW2sMspUAT8nOcWN4F5elDLUjalnR//jlZXo6V5WsHHEQ4
         Ny7sQygQGOyXWoBsJntzi+vZmgLkF8HBY/vdsKcRwNsMIyYtow9CJxakjU3/EXTv7klG
         2+hGQs3jkELj27THmpO2wJS4KYaO0Dy97GDjNIq5cZTsQQt39mhSNW9mMTS8mQt24SNI
         Stb//rJOE+S3N8X1UIYMtzW7i+WLH89/0J7Eg/uOrDXnDtflVp8cHFUfXP3sMefjpmFq
         ccVw==
X-Gm-Message-State: AOJu0YySAef5m3kZnsuMY7lIuSmyUYc7IXsL0V6tbx9kjV+jSwH/piH6
	uBO5nXaztalcX4QbAI93OZJNN73J/zq5w3qsHrnrlhYCwC0OEIPzCTF7HNvKMxzZhKcyPX7Xy2z
	kI6iVHhvBdvhg7r9XZv9tFkV3snxFFvBMKeQv0s+b5tGHPIvMd2Bt2gsQO2rzlNiY
X-Gm-Gg: AR+sD101aG7mXve905ULWot4toud94nKgjYbeKfZoH4zeEmdy7xHasOMRDqJr7TYUbW
	cfSXljvVEW1l4XVc5Ot53ye0UOia52pd5W51MBxktkAXG5/B38Iu9COW0/lRrqULp5N4rtLM8RM
	6rFeuGZj7AOev3Ql0F5FzP4Eyt26rI0+7ZtmWUwZ6pP2BIcsLR8kh4PpTqK44ha4oHck2oIvACU
	0nVZb15AjO1bJreFs9GUO+hFre64HvBjx5gQUQNH5ljQFNW53U0g+RYaekXyc3P7Cqk6+hhpzAA
	uHVfqFPDqO0L5NvzgOQ4aEk/5UR9XLapVKnnQpOkWZaQx7XukZagxCcLhjpAf96cJVPy7DOR2HA
	mDIi+QBpQQrKj2PFqgCRdDIU01enLAJV76PbqWCx5HpBK420TX6nQNtQyIzXpnE1nsPc9wuRg/S
	4ATvXUZ18KCthWP9XzKtOOeB99VLEScmPizbGmWqCUobTEYdVS3sXpoeSjZIjxJuhc/X204DCid
	A==
X-Received: by 2002:a05:6000:25c2:b0:47f:96a4:227d with SMTP id ffacd0b85a97d-47fc81f339dmr2428746f8f.31.1785404797394;
        Thu, 30 Jul 2026 02:46:37 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:37 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 05/10] ovpn: ensure socket is owned by ovpn before deref sk_user_data
Date: Thu, 30 Jul 2026 11:46:16 +0200
Message-ID: <20260730094624.4102963-6-antonio@openvpn.net>
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

Some subsystems, like BPF SOCKMAP, set sk_user_data without
actually setting the encap_type.

For this reason, we must make sure that the type is the
one ovpn expects before dereferencing sk_user_data.

Failing to do so may lead to out-of-bounds reads.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 517caa64a4fe..6cbeb2caaeec 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -162,6 +162,15 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		rcu_read_lock();
 		ovpn_sock = rcu_dereference_sk_user_data(sk);
 		if (ovpn_sock) {
+			/* something else filled the sk_user_data without
+			 * setting the encap_type. Reject the socket.
+			 */
+			if (!type) {
+				ovpn_sock = ERR_PTR(-EBUSY);
+				rcu_read_unlock();
+				goto sock_release;
+			}
+
 			/* socket owned by another ovpn instance, we can't use it */
 			if (ovpn_sock->ovpn != peer->ovpn) {
 				ovpn_sock = ERR_PTR(-EBUSY);
-- 
2.54.0

