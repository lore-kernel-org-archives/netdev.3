Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4643F0AD;
	Fri, 17 Jul 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290867; cv=none; b=NbLE7uYsONwqJqscTGR/FB9PvfdyMLNMAF7FvgF5SCZ8tKRwezRlOfArsJXAMEDc0F1N0U8zdGmj4de93jkYot0KREEigKnpkn0e0LzKkIMH4f382uCpJOZe+LIaGR5WwJjsTs6qGDFRrw2Bto3SIWARv5kN6nXBAXUVEu4CV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290867; c=relaxed/simple;
	bh=YJtj6bXIpzuzu2Zc9WatWzV1Og8A2CGjjw8W/A0dF+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTUEdV9cnQ6FctD0HuydtS/dgG6erTKpnb9BZv+9N/gTPkZemVu88/q1LHR3Q7VxMDWUj9AFOG88FyYCZOXmVN9JiR15w62ZlSZVJ2Ig4NqE0piThwnGl+7Jgv8MYdpu35N5xORU89kkkLlRMIA0eFr1p49tu8ozJWeXKtZVawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FXTxrodc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="FXTxrodc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hZhnv257zE+3qmGPEfspO9kr91fDoKR9jG/O42LJHaY=; b=FXTxrodcLzUqO+B48wR6AoYYqg
	mFRIahR8/WoR7M3ZSziMlNpqMyu8o/X0brpII1QjufF2CD0of4F6/xSrvCeSH4mKxrVOwXNo03B2j
	6vr7pyIYvwpo3iQdS+hB+Ps45Oodg0atULVfJMCbJwzxdZUnXEtVpI4ZNrtXATb4ZUjB1EVPA62e5
	xVRW5IS9mLePIlYp9Dc3GdkLG9NJtknKz78wVatuPpTLyE+D2iAFRSeUPxxh6ihXPYBPZytCU8jGz
	+jJ6shWIUnkosDZG49VynEBfRTZzCkDJLgHDWi97aKfoWVWsPx9JTRvVK4pQ9D8WjHdHm0FJKd58+
	ndlCIPbw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkhYW-004ahB-2A;
	Fri, 17 Jul 2026 12:20:41 +0000
Date: Fri, 17 Jul 2026 05:20:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>, guohua.yan@unisoc.com, 
	xuewen.yan@unisoc.com, usama.arif@linux.dev
Cc: davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, willemb@google.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH] net: use sync wakeups for socket error reports
Message-ID: <alodxQoCH5A5iVGG@gmail.com>
References: <20260708133815.3419465-1-usama.arif@linux.dev>
 <ak5rH-SWjiqR6MVe@gmail.com>
 <bc16e45e-32ef-45d8-99af-14f088733ab3@linux.dev>
 <CANn89iLc1Bv_wmKvr_9mtGRM3gL7kgoy2Prr2SgtHY4C=ZgfBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLc1Bv_wmKvr_9mtGRM3gL7kgoy2Prr2SgtHY4C=ZgfBg@mail.gmail.com>
X-Debian-User: leitao

On Wed, Jul 08, 2026 at 06:32:02PM +0200, Eric Dumazet wrote:

> Perhaps this SYNC heuristic should be a per-socket choice so that
> applications can decide what is best for them.

Something like this?

    net: add SO_ERR_WAKE_SYNC for sync error-report wakeups
    
    sock_def_error_report() wakes EPOLLERR waiters with
    wake_up_interruptible_poll(), while sock_def_readable() and
    sock_def_write_space() already pass the sync hint. A socket with
    SO_TIMESTAMPING enabled delivers every TX and ACK timestamp through
    sk_error_queue and raises EPOLLERR, so the error path wakes a sleeping
    consumer very often.
    
    Without the sync hint the scheduler often places the woken consumer on a
    remote CPU, which costs a rescheduling IPI. Usama Arif measured 16,326
    such IPIs/min on a 176-core host running a production workload with
    SO_TIMESTAMPING enabled. [1]
    
    Switching the error path to a sync wakeup unconditionally is not the
    right fix, as there are different requirements for it to be async, see
    [2].
    
    Eric suggested that an options is to add SO_ERR_WAKE_SYNC so
    applications choose per socket, so a consumer draining a high-rate error
    queue can opt in to keep the wakeup local and drop the IPI, using socket
    flag SO_ERR_WAKE_SYNC.
    
    Link: https://lore.kernel.org/all/CANn89iLc1Bv_wmKvr_9mtGRM3gL7kgoy2Prr2SgtHY4C=ZgfBg@mail.gmail.com/ [1]
    Link: https://lore.kernel.org/netdev/20260526063650.952-1-xuewen.yan@unisoc.com/ [2]
    Suggested-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 5ef57f88df6b3..2a3c27aaf4e95 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -155,6 +155,8 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_ERR_WAKE_SYNC	85
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 72fb1b006da93..00f31c74a63df 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -166,6 +166,8 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_ERR_WAKE_SYNC	85
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index c16ec36dfee6b..db5b6cad17d49 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -147,6 +147,8 @@
 #define SO_INQ			0x4052
 #define SCM_INQ			SO_INQ
 
+#define SO_ERR_WAKE_SYNC	0x4053
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 71befa109e1cf..5e9ff3634265c 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -148,6 +148,8 @@
 #define SO_INQ                   0x005d
 #define SCM_INQ                  SO_INQ
 
+#define SO_ERR_WAKE_SYNC         0x005e
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 51185222aac29..d8ee1dae8ecaf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1022,6 +1022,7 @@ enum sock_flags {
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
+	SOCK_ERR_WAKE_SYNC, /* Sync wakeup on error report, %SO_ERR_WAKE_SYNC */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 53b5a8c002b1e..5527c9318b40e 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -150,6 +150,8 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_ERR_WAKE_SYNC	85
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index 498a57f34f5b5..59caab6a7223a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1557,6 +1557,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		sock_valbool_flag(sk, SOCK_SELECT_ERR_QUEUE, valbool);
 		break;
 
+	case SO_ERR_WAKE_SYNC:
+		sock_valbool_flag(sk, SOCK_ERR_WAKE_SYNC, valbool);
+		break;
+
 	case SO_PASSCRED:
 		if (sk_may_scm_recv(sk))
 			sk->sk_scm_credentials = valbool;
@@ -2064,6 +2068,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = sock_flag(sk, SOCK_SELECT_ERR_QUEUE);
 		break;
 
+	case SO_ERR_WAKE_SYNC:
+		v.val = sock_flag(sk, SOCK_ERR_WAKE_SYNC);
+		break;
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
 		v.val = READ_ONCE(sk->sk_ll_usec);
@@ -3641,8 +3649,12 @@ static void sock_def_error_report(struct sock *sk)
 
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
-	if (skwq_has_sleeper(wq))
-		wake_up_interruptible_poll(&wq->wait, EPOLLERR);
+	if (skwq_has_sleeper(wq)) {
+		if (sock_flag(sk, SOCK_ERR_WAKE_SYNC))
+			wake_up_interruptible_sync_poll(&wq->wait, EPOLLERR);
+		else
+			wake_up_interruptible_poll(&wq->wait, EPOLLERR);
+	}
 	sk_wake_async_rcu(sk, SOCK_WAKE_IO, POLL_ERR);
 	rcu_read_unlock();
 }
