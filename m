Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3B52D2CC
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170434; cv=none; b=FBQn6DqqXQ1FVb5uL1gbZJ1FAAHTznpDzHId9C0SjJ/yd3psP3rs02H5w14JI+aEWXq0/3bn0xivrfWvN/uSn5fcDOqDOwKpYk/lGygGc/D1QSjaOtOo4QKdwpYM7Lcl5oQiXmci5IThCijrgTTgcHNMM0HTn1w5b+f1aRcQR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170434; c=relaxed/simple;
	bh=w1fQS1nTWrUrIlI4ihs1ABgazTfXJca/Tdv4wLIV7Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQeIZp78wEKZ6EXjnYf6C9HYQFuWZCJaMiU/yG+1vy5Q1xCDz0YRhBepoiy11WIsUQAaMx/nyYHuew555L0uSbr7tcVYLXVxFuC7e6TalLtXtXhG8TL77PBmugJkU0y1wqs0T0mIM5gEWRepMQH7aWYknNBC6iM4aW1NKJvo89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeA96/Jq; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeA96/Jq"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7856441f7d9so363744137.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790170431; x=1790775231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VigpCgJFGr19aE1C6suxBlVqAbaMUssmLz2MA/9FLTI=;
        b=IeA96/Jqu8+7+EVEndBvA7LbfDPX2PAg2KtVQxvrR1rZWUW8mh7DxeFT/uEnhBmxXX
         iITMGiWlWfph1YW9aPMrLvs5WhZKrXijpgsqhi2BwRcY8WDHue6bjnCA4SvwP+mndEeR
         hyqdQtGyCwFafEPACmyZ+EBWuFsNi48OfZXL+sRFTe+ZG2LfqCS506llaJ1Pg+lIkbQw
         0lGA+AmuKaWQA3QSiOVfGWejMs6S5wBCaAVUVdg0uSZbl/nccFIX+V8Vxb5JTZ/QOufI
         tofOLHM9NuXQ0XlFxKOq0AmsEJBkxb9kDfuS61TCH2qQWiwte/kg0JAKSiygmaZA8D+l
         k3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170431; x=1790775231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VigpCgJFGr19aE1C6suxBlVqAbaMUssmLz2MA/9FLTI=;
        b=i9kzHANp9r9bSP1GH0EMOnYToLFxIq23H4qCAAKji34ZrDv8S49jiTcjNP5EbYpCCA
         ECRCZwu6mytjQBspwXlCVjamUtAwaoIcFOiF0o2ZyY9fJgLmmBjwZTWd1trzOyRcooEA
         kJGnBl1kafkn8Gd01tdMw/t36fF8i/6VVH/lCrcnCLhEzYaRwxVW7cT/2fUXgUmwTTfd
         s+11E1gZjpWXpe0QAhmPzUVumjm0tPpCnJZxYrJwKUtllZrY9ofmtHNlXysqWWmdw25N
         fkW7y2gBHVA8SwP45Uq3kpmDAhbjVeg3AfUstFaIk9ntag3DDwysVXJaFV2l78dVc7Ui
         JFWg==
X-Forwarded-Encrypted: i=1; AKwUvBwL4sRQ+fmv5NCkqoIl/jTEDIx/tr6H4wPUS2WNTnkuDn1dDgjeZKWINmootO8/GcPd2lmA/Bg=@vger.kernel.org
X-Gm-Message-State: AFuF++nbG4fuiAEmfd/D3MgLgux28YrslnBSegJCHCoOZGm4mNFsdnuY
	vB0TFw2la5rVhVmy3MV/aZ0n8ErYcmgtwcq1huNQZ8o1d99Cqbtp7aqO
X-Gm-Gg: AYBFou2UXQsmSiCKAAb7Q6SNnVd+aNy/4xZgzaHEn2U3nFRvEC7EWqckpESbDg3Bbvy
	NA4StsNHQPtoVJc+YI2sEc0+Xsc3VqtpMMjBDxTkK69S2NK2QURU2CX5kS369btNo9JDcCR7FGr
	NrE+Mwm3VS/aGisTEPVlWzQsRvbw4pNF74qk7ZKJWXluhdxyp5CbiJhBkAXfb4QBfg8JOlrXZ+m
	DeSjtrcklkwcWGtz9F+VIWO3nsCU4OJ2GWCCMOWQX2sHizJ+eFVBj/y3RLVZ1nnCdn6Vq/KQgPq
	xUBAQhXCCe8lrLT3eZ+bGlEcrufjcGe5d+qGumy3/STJ9e+HQmutYZLs0zDiGbt9JVgbjJPfJVa
	npRcMT/gIDSVerVIrho9sKN+rfPApEQD4jnk0K+cyb2WWZfXHtFg1UNN9m3lPfqBWjOIGSwi1f/
	52rYBRjEYqZm5W7/sErqhMBIdEfmA6geSRlO6BmZr6CcPGv7I/PbDybytVPtiWtSM=
X-Received: by 2002:a05:6102:38c7:b0:7a7:198b:674c with SMTP id ada2fe7eead31-7ac1e251385mr2374231137.33.1790170431324;
        Wed, 23 Sep 2026 06:33:51 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf61931c3sm3480402137.11.2026.09.23.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:33:50 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH net RESEND] nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
Date: Wed, 23 Sep 2026 10:33:39 -0300
Message-ID: <20260923133339.2518641-1-qwe.aldo@gmail.com>
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
index cac1b5487..bd6361e2e 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1251,6 +1251,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
 	u8 dsap, ssap, reason;
+	bool connecting = false;
 
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
@@ -1262,6 +1263,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	case LLCP_DM_NOBOUND:
 	case LLCP_DM_REJ:
 		llcp_sock = nfc_llcp_connecting_sock_get(local, dsap);
+		connecting = true;
 		break;
 
 	default:
@@ -1276,10 +1278,33 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 
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
 
-- 
2.43.0

