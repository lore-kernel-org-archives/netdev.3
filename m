Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BF4C224C
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213001; cv=none; b=lLai0f49EVzoVbvF3scSyhQEK7U6A1MJjMjmx+Senj64qgO6GFp9NOPH0EbY9gEVJbkzdH3n0qiwMPMYLEyID0lRSEtnI3kRuFvFBI0eHJJpr1q24HzDqFEmD6/Z1dVeO4abnjfFfekCPuuog1iO4Io4yio4hePIDXnK5VxsYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213001; c=relaxed/simple;
	bh=mgbyJhEgBJGneHMBihhStS+dXS5x2dyMqyW+sSOWoRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHvTd4J51rmv3zY9xP0TGR2rzYypeiOZSD3XbEt+nSxltucw/R63fPYyLXJ7437kyT8hr7FWeT4lSzQUS2l9b/AcGqh6o1zAbiofzZxFTzIKmj7KQdH5NZZeQPMKkt3wjhgiWp43PPtSJX8FithJY+NZRZ+QtpFdXNJBLIB//OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=fEjqu8wi; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="fEjqu8wi"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-6729ca45e37so1457042d50.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212995; x=1791817795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lgUC7T7/VHvtmnRhJu6KYjSavDN2P9DqRdXTfg84HuI=;
        b=fEjqu8wi5eVzzAkmnfsIiKCLAHG1K8807OnoGe6+/dTyLQkc3tsc19y39mNPggQPkn
         AEY168lWuNnf8eX+f3e3CJYzqWMvTbt7DSXnNlDJ4JbAFqLAKT0nIZi5/Aw0FrcOTneB
         ErkQKVlBC6vosRyRg4X97ywdogVmbSyiAQmOPvJtJWqv6R5key8TfAA7DY8Py9zzkKgv
         80CDnsMny8xTsNMD6N5XZ+oLobMha2WX8JjEG4EOsEbGIwaRtLBhkEItTL+EihBI5E8H
         v2YBqR2YqyGoWPdqIsOy9TcS5wxfzqQfrbJ+wV8dMs85MNL5zFYccSFPsjOHoBRnl74Y
         9QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212995; x=1791817795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgUC7T7/VHvtmnRhJu6KYjSavDN2P9DqRdXTfg84HuI=;
        b=JYyN8LWdzriJ4dsykrR0EYOhv7UjuaJKd8szpA4s70W2Y/+MnMH2MXwI2b0LPKylcw
         ZZvfcv3XQeNi/s+JIft2uD8KXDPCCCVBIa+BmC1tKium0PxmL+eqT8aEfB0uMZXj3V6h
         lMQ3H3hdhWRuzYofRS+jRB+XgomaEX+KYH1gaUP4/7TxYGu68H8rAyFyHrjwDGwzCbUE
         Z6cUCSnStEPSG3/E29ulQ41GiExpfGQSvrR7fdTCMDmu9LX5+wOcWy5OTa9N8OIpbpuJ
         IQ8keJFt+Zi6lgKWp4td23vu/xl2JZrSjDX1zYvqdhtND+dqHVMlhIgdCttIlThByhku
         xUhg==
X-Forwarded-Encrypted: i=1; AKwUvBzbviBtm56MifPiMH3nNefyp5osX9LYKN8NDFATpigWrRnMUFwwQFjcLcVPXWKNrUovGphz9bc=@vger.kernel.org
X-Gm-Message-State: AFuF++lsKv5NvaZfoIlXyX6dC3W3+elF9LymYthmKb8rB52BkyHN/qef
	GW24ty+lJS1YE58/fXf+ovBwpLaMo0cNnfJ7XF/JCpv5CDf2hY7IyZUZHlnhyxOccEnv
X-Gm-Gg: AYBFou10D+nWzd2ZL07EeVonZIvLg8WMY3H7uS/UO/L0noZQbyHPH0Xkv4bDZLwoBqa
	BKCaPeB+jB9lCaF3d604WCeN+rNF57KuOU/ZNE3gjgYYi6QWsLGbBmpTi1ne64qUiLgawpHblSr
	0Fy8XYZpCaGbfU5wl3U4pNphPGNE+L6TyOW42Ot0YTf7Hdb+9dzNPTlnj1EeipB+pVWoBJbjJSZ
	Bw6PR2lhmImp0OJUeD0YXCTTstT3kywQSPsnAClh2oYZgf3IzPousGurvOAMcW4wJkQMo2Qm0cp
	PVhGTMUCT2OxqmO/PtouzDo02lASOmIx+bQPxSApSQiuRLaklRn2o7ePNslqSHX4n3op4D/pBP/
	5vIeyDbvzT2nTWWDJf3stv61tcDB2H8oHp3iLAmbhv6e4wZsfPwKnhxS1eiLSxifvtXKaR/C01K
	x+OwHfcVpED44Ldfp0gvRlS642QJzcUZTtKSZkxKin5vSJwr/QsM3IYTalkuuCf3KhR7hFCw95v
	I7H+0xyeYQzrvDuKG9A1Y6zAXgh0Cg5oSIdIKKDndfvJbvPN1RExKsEZ/kDaDaETw==
X-Received: by 2002:a05:690e:118b:b0:677:d375:13d2 with SMTP id 956f58d0204a3-677d3751a58mr1307931d50.42.1791212995292;
        Mon, 05 Oct 2026 08:09:55 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:54 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:36 -0500
Subject: [PATCH v4 06/10] af_unix: record the pid of the connecting thread
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-6-350183b6e02a@amutable.com>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Currently only the struct pid of the thread-group leader is recorded.
The identity of the actual thread that connected to a given socket
cannot be retrieved.

Add the plumbing to make it possible to retrieve a pidfd for the
connecting thread. Nothing uses the thread-specific struct pid yet. No
functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 net/unix/af_unix.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4e571c5a0e16..b7d62e61d9c4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -743,51 +743,47 @@ struct unix_peercred {
 
 static inline int prepare_peercred(struct unix_peercred *peercred)
 {
-	struct pid *pid;
 	int err;
 
-	pid = task_tgid(current);
-	err = pidfs_register_pid(pid);
-	if (likely(!err)) {
-		peercred->peer_pid[PIDTYPE_TGID] = get_pid(pid);
-		peercred->peer_cred = get_current_cred();
+	get_task_pids(peercred->peer_pid, current);
+	err = pidfs_register_pids(peercred->peer_pid);
+	if (unlikely(err)) {
+		put_pids(peercred->peer_pid);
+		return err;
 	}
-	return err;
+
+	peercred->peer_cred = get_current_cred();
+	return 0;
 }
 
 static void drop_peercred(struct unix_peercred *peercred)
 {
 	const struct cred *cred = NULL;
-	struct pid *pid = NULL;
 
 	might_sleep();
 
-	swap(peercred->peer_pid[PIDTYPE_TGID], pid);
+	put_pids(peercred->peer_pid);
 	swap(peercred->peer_cred, cred);
-
-	put_pid(pid);
 	put_cred(cred);
 }
 
 static inline void init_peercred(struct sock *sk,
 				 const struct unix_peercred *peercred)
 {
-	sk->sk_peer_pid[PIDTYPE_TGID] = peercred->peer_pid[PIDTYPE_TGID];
+	memcpy(sk->sk_peer_pid, peercred->peer_pid, sizeof(sk->sk_peer_pid));
 	sk->sk_peer_cred = peercred->peer_cred;
 }
 
 static void update_peercred(struct sock *sk, struct unix_peercred *peercred)
 {
 	const struct cred *old_cred;
-	struct pid *old_pid;
 
 	spin_lock(&sk->sk_peer_lock);
-	old_pid = sk->sk_peer_pid[PIDTYPE_TGID];
+	swap_pids(sk->sk_peer_pid, peercred->peer_pid);
 	old_cred = sk->sk_peer_cred;
-	init_peercred(sk, peercred);
+	sk->sk_peer_cred = peercred->peer_cred;
 	spin_unlock(&sk->sk_peer_lock);
 
-	peercred->peer_pid[PIDTYPE_TGID] = old_pid;
 	peercred->peer_cred = old_cred;
 }
 
@@ -796,7 +792,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 	lockdep_assert_held(&unix_sk(peersk)->lock);
 
 	spin_lock(&sk->sk_peer_lock);
-	sk->sk_peer_pid[PIDTYPE_TGID] = get_pid(peersk->sk_peer_pid[PIDTYPE_TGID]);
+	get_pids(sk->sk_peer_pid, peersk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 	spin_unlock(&sk->sk_peer_lock);
 }

-- 
2.55.0

