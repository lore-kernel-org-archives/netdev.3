Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627123C39A;
	Wed, 20 May 2026 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284927; cv=none; b=qlfmxxFBaQYl8ULmLqtDp08dObdSZX4X8+9l3h0FaXVs7Dcl+O6ARamtMepyxnt+VP3tyDgmg4xIxsQRK21E1BDRJZnPpfkSitAZ2MuDOfqvkz1errvb84/KmWHxX+wmPfckue+hBMW8iskSuEl/iGDakLhkJBaKeRwuROMvOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284927; c=relaxed/simple;
	bh=Q1bXY7UlxwnmfwjlCVNcMh70j2jjziqp16h8olKSqlw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dKOVhw7lDICqpQRkF9s+s4fSwnOnzgf4bVuiwEPQTqAWZxP8VGHtE+Ez5MxYg8hPqvbRfUOzcRxFioX64P/oVe16+sCtQ+OrGYdbNP4v5nFRCI8+JyUwyhDgOlQU95Nszg5R0t56wk+PB8McuHXLJfc5dCnnKP6Z3SlZ3+otwDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cryIU+Y4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cryIU+Y4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1861F000E9;
	Wed, 20 May 2026 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779284926;
	bh=aumXBrLrxxQFmyzkYmXrDbHFCke8TkoH++Nv66XdtSY=;
	h=From:To:Subject:Date;
	b=cryIU+Y4SMQ9BDgSuvTAmy0n2kIsz1lB3M5yrQ5jiOMj+aVUAkKbf+7fkl6OfNhQk
	 5dxIhleIBQTI+QCbMiXSGp1pUZ6lqcRBvcJBWgsvCjRDQBJjANUWCJJ1hn0rN5dlCd
	 lGSVi4vzAKQHW4mhPtPT6gvc5kMLc2jIz2MK4bv5O11xzLeSzhyKsZUE/74epR57bq
	 WmAy0m9amqUEHnnGjL+7SJARKJLk5jEqZEAH6k4WI2bYsv+M3Sd4b5Hk+Fhe0jFcoA
	 it6S0qGpiv6/xp5UkHikCKh1gnnYG4Ov58G/HftILvfUI3JYdiGiPLu+LDHKPfL0Fx
	 0FqepdA7HfjYw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()
Date: Wed, 20 May 2026 14:48:36 +0100
Message-ID: <20260520134837.2780050-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pppol2tp_ioctl() read sock->sk->sk_user_data directly without any locks
or reference counting.  If a controllable sleep was induced during
copy_from_user() (e.g. via a userfaultfd page fault sleep), a concurrent
socket close could trigger pppol2tp_session_close() asynchronously.  This
frees the l2tp_session structure via the l2tp_session_del_work workqueue.
Upon resuming, the ioctl thread dereferences the stale session pointer,
resulting in a Use-After-Free (UAF).

Fix this by securely fetching the session reference using the RCU-safe,
refcounted helper pppol2tp_sock_to_session(sk) on entry.  This locks the
session's refcount across the sleep.  We structured the function to exit
via standard err breaks, guaranteeing that l2tp_session_put() is cleanly
called on all return paths to drop the reference.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 72 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 99d6582f41de..9a2243a32ceb 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1045,64 +1045,57 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
 {
 	struct pppol2tp_ioc_stats stats;
 	struct l2tp_session *session;
+	int err = 0;
+
+	session = pppol2tp_sock_to_session(sock->sk);
+	if (!session)
+		return -ENOTCONN;
 
 	switch (cmd) {
 	case PPPIOCGMRU:
 	case PPPIOCGFLAGS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
-		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return -EBADF;
-
 		/* Not defined for tunnels */
-		if (!session->session_id && !session->peer_session_id)
-			return -ENOSYS;
+		if (!session->session_id && !session->peer_session_id) {
+			err = -ENOSYS;
+			break;
+		}
 
-		if (put_user(0, (int __user *)arg))
-			return -EFAULT;
+		if (put_user(0, (int __user *)arg)) {
+			err = -EFAULT;
+			break;
+		}
 		break;
 
 	case PPPIOCSMRU:
 	case PPPIOCSFLAGS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
-		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return -EBADF;
-
 		/* Not defined for tunnels */
-		if (!session->session_id && !session->peer_session_id)
-			return -ENOSYS;
+		if (!session->session_id && !session->peer_session_id) {
+			err = -ENOSYS;
+			break;
+		}
 
-		if (!access_ok((int __user *)arg, sizeof(int)))
-			return -EFAULT;
+		if (!access_ok((int __user *)arg, sizeof(int))) {
+			err = -EFAULT;
+			break;
+		}
 		break;
 
 	case PPPIOCGL2TPSTATS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
-		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return -EBADF;
-
 		/* Session 0 represents the parent tunnel */
 		if (!session->session_id && !session->peer_session_id) {
 			u32 session_id;
-			int err;
 
 			if (copy_from_user(&stats, (void __user *)arg,
-					   sizeof(stats)))
-				return -EFAULT;
+					   sizeof(stats))) {
+				err = -EFAULT;
+				break;
+			}
 
 			session_id = stats.session_id;
 			err = pppol2tp_tunnel_copy_stats(&stats,
 							 session->tunnel);
 			if (err < 0)
-				return err;
+				break;
 
 			stats.session_id = session_id;
 		} else {
@@ -1112,15 +1105,20 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
 		stats.tunnel_id = session->tunnel->tunnel_id;
 		stats.using_ipsec = l2tp_tunnel_uses_xfrm(session->tunnel);
 
-		if (copy_to_user((void __user *)arg, &stats, sizeof(stats)))
-			return -EFAULT;
+		if (copy_to_user((void __user *)arg, &stats, sizeof(stats))) {
+			err = -EFAULT;
+			break;
+		}
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		err = -ENOIOCTLCMD;
+		break;
 	}
 
-	return 0;
+	l2tp_session_put(session);
+
+	return err;
 }
 
 /*****************************************************************************
-- 
2.54.0.631.ge1b05301d1-goog

