Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8043F097
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244435; cv=none; b=cFe9ShkmTiGGGMM7M2PlaG3ZJhsYMf9j0Sxk/KHYppbeJ0ZxOvx9du4gHUATY2V1IV6xFdWRXuY5yzbEUD3du0xvne608eH66eVyhi45roPNVkicdhvJPXC4YSDCDot+SM2xxgswTnjbwo8BJG9jOcx9h+BNWgbFL3wqxam8Gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244435; c=relaxed/simple;
	bh=lu7YV5CCiyyOEgBNVeSsxlZkRV4pW1Z5+pf0FhhYiGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJ2Cdacm8DsqJdl4nezkvuNnNQIRsBt03SRVxiLCbhGHh6gl08V0O38TQ7hyAbhXyBTpn5HXwgf4gmJY+rEhLiur2HQrKoivk2uRIXmOrZrtbjwTFJ+0uvxk+TxWWpjhmmtQ2deItoF/kxDhvxIVl6zEoSHInsDjFpwQrTpY7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmB6vs5j; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmB6vs5j"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15b509c323so946657066b.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 16:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784244432; x=1784849232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WXuUFnyylEezjX3V9l0E0T/Ofv34IDOK/Bhil0kWQpA=;
        b=VmB6vs5jM57ysQUsDiFFcPQI9s+ZbXzQN20hqomrughJ9Ud8GlyZ0OGVuqD9qELtW3
         Ps/2iCkmHjNp/R8Hy5HopqnyleavOJNUpUZzgVAVVBf52aGim6LSd3mwDTVuyPXf2Enr
         A/bosGHRd9cvYXh2r875s6LVhmXP8qbw9hf8i1jUMTYjDeA8yf8XtUHzBaQVcGUhar7/
         OVztUjQsV5sSrNS0jSFcp4DOaeGHNA5OaKeRqpD6fkjUq8+zxjCfDhD/CFvckDRPyEfo
         4iRD5ewtJuXD2sMMYPHSdxFy4Um5b7/P/xZlb+uCeYcfig5LhvaeP5r1KaqAmxGrtlPW
         f9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784244432; x=1784849232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXuUFnyylEezjX3V9l0E0T/Ofv34IDOK/Bhil0kWQpA=;
        b=RiP99r+AwaYtNzf/zlKYHePap84/xqIg+X6xq9yGoOqeEtF+h4xaSfE53Goeo3jBnT
         JIjo9QSwmtLpNbbdfpKTug09EQSMMNaDtVL4WQsIwlx37H0tPGavM4kRa82UPBXG8M3p
         2NoQ7h2gup+Tz3cbemnw9PXBs58wzj+AliceoQNnQShz2CNPrxyNZ761mHm6SiioHP8W
         CQnli/k2ijMJscMK/YFcaxhzsvHoPy28HIl3/hDRBfZ/SN7kVJVyJVuxRMBL7J8BNT7+
         BoCQmuDoJxNAYHS5q1ObSuCuSJua64zVBiYcojM/yxKjQLLt2miwU6U/6ow3xZuIft8G
         /Ltw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+WX+Xanrw3Fkjs4ZwttE4oMo3cFs5vhhGq0dFnHYZpdnkVBxmr9HMoKfmYx74WYvz9UrurSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCp8ljFMbDia5TYaaMWrnHenmUXbc7z3Upa5FAS+HWI0ZJG+ML
	O4MPqpUw/8Hv0sPtoCZ+vUv4Ng4l+GNGQwNI1Mjeq96jPzgl9Ztde/bD
X-Gm-Gg: AfdE7cl58g9XDOtjjK5I2Nfo7lLmGJnpJW5PUuHeywDmmhZhPheGK+wtRqRaaHIuvWv
	oy2ZNgQuILp29W0xoW+SC/68D6k4IWmYKNHQBmQtgHrlwt4tJpelXbIiLo7Ir+mZ0/BVc3YPFy8
	98mMZMVl2wFQ692zNc+FSZw6eMd7V8j9bryONA9DFlk7QHadyOCJWTdImofGHexybbAxW4FfBdc
	8B0gl57iD/f2xzNeRYHUoz265ycYYyVTyWusFYmHHQKngkoMRqKblPGMt6b9yjxCdBx0lr8MQTJ
	XNBdeSyIj5zk5Sop1oDztvSGiBj4NkJ1TVoxm3vX5YdRADlzr9cGEDHCHSHnz0Bj3f/H9AIXQPR
	RI9kjUaQGHr5vZKqnMn2meIphM2DPVPE3OtfGzOxnpiy6rxmgIjpEuhNrDzPA1i3EBFTFvQ==
X-Received: by 2002:a17:907:6094:b0:c12:a16f:6864 with SMTP id a640c23a62f3a-c16b476b7b3mr599666b.48.1784244431513;
        Thu, 16 Jul 2026 16:27:11 -0700 (PDT)
Received: from beelink.. ([164.5.253.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744966asm295102766b.50.2026.07.16.16.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 16:27:10 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH net] nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
Date: Thu, 16 Jul 2026 20:26:57 -0300
Message-ID: <20260716232657.203145-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_recv_dm() handles DM(NOBOUND)/DM(REJ) for a socket that is still
linked on local->connecting_sockets: it looks the socket up with
nfc_llcp_connecting_sock_get(), sets sk->sk_state = LLCP_CLOSED and
returns, without taking the socket lock and without unlinking the socket
from the connecting_sockets list.

llcp_sock_release() selects the list to unlink from by sk_state: a socket
in LLCP_CONNECTING is unlinked from connecting_sockets, otherwise from the
sockets list.  Because recv_dm left the socket physically on
connecting_sockets but in the LLCP_CLOSED state, release() takes the else
branch and calls nfc_llcp_sock_unlink(&local->sockets, sk).  That runs
sk_del_node_init() while holding sockets.lock, i.e. it removes the socket
from the connecting_sockets hlist under the wrong lock.  A concurrent
connect() linking another socket onto connecting_sockets under
connecting_sockets.lock then mutates the same hlist unserialized, which
corrupts the list and desyncs the sk_add_node()/sk_del_node_init()
sock_hold()/__sock_put() pairing.  An unprivileged local process holding
LLCP sockets, with the DM supplied by the remote peer over an established
LLCP link, can drive this to leak kernel sockets without bound (the
mis-decrement goes through the non-freeing __sock_put() path, so the
object is never released), leading to memory exhaustion / DoS.

This is the same class of bug that was fixed in the sibling handler
nfc_llcp_recv_cc() by commit b493ea2765cc ("nfc: llcp: Fix use-after-free
race in nfc_llcp_recv_cc()"); recv_dm did not receive the equivalent fix.

Fix it the same way: take lock_sock(), re-check that the socket is still
hashed (release() may have won the race), and for the NOBOUND/REJ case
unlink it from connecting_sockets before moving it to LLCP_CLOSED.  The
unlink drops the connecting_sockets membership reference via
sk_del_node_init(), leaving the socket unhashed, so the later
nfc_llcp_sock_unlink() in llcp_sock_release() becomes a no-op and no
double put occurs.

Fixes: a69f32af86e3 ("NFC: Socket linked list")
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/nfc/llcp_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index dc65c719f35f..d8dbb1bb857b 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1249,6 +1249,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
 	u8 dsap, ssap, reason;
+	bool connecting = false;
 
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
@@ -1260,6 +1261,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	case LLCP_DM_NOBOUND:
 	case LLCP_DM_REJ:
 		llcp_sock = nfc_llcp_connecting_sock_get(local, dsap);
+		connecting = true;
 		break;
 
 	default:
@@ -1274,10 +1276,33 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 
 	sk = &llcp_sock->sk;
 
+	lock_sock(sk);
+
+	/* Check if socket was destroyed whilst waiting for the lock */
+	if (!sk_hashed(sk)) {
+		release_sock(sk);
+		nfc_llcp_sock_put(llcp_sock);
+		return;
+	}
+
+	/*
+	 * For DM(NOBOUND)/DM(REJ) the socket is still linked on the
+	 * connecting_sockets list.  Unlink it here, under the socket lock,
+	 * before moving it to LLCP_CLOSED: llcp_sock_release() selects the
+	 * list to unlink from by sk_state, so leaving a connecting socket
+	 * in the CLOSED state would make it unlink from the wrong list and
+	 * corrupt the connecting_sockets list / desync the socket refcount.
+	 * This mirrors nfc_llcp_recv_cc().
+	 */
+	if (connecting)
+		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
+
 	sk->sk_err = ENXIO;
 	sk->sk_state = LLCP_CLOSED;
 	sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	nfc_llcp_sock_put(llcp_sock);
 }
 

base-commit: 3f1f755366687d051174739fb99f7d560202f60b
-- 
2.43.0

