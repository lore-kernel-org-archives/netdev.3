Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB004C6815
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533205; cv=none; b=X+SHcGY+bJEiQAT9vqgOcEzltCIwCDWCMB9u6lpTPXCWKIWK458T8NEsSfqw/Wo6GJ5FFv+M0DhFWb3pkN+5HZZxyZg3AYF1ZczOwLXrbstuWKIFrNCpRpKDlNK5kQk2bEUzp6R8ePrPicxDDl19k6YjU3kwTc0y6QlmD1uCjjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533205; c=relaxed/simple;
	bh=BbXfgWlfzRZyr4dPjeqVjwbHbbS/YICn/SR1Wtt7l2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/T+bbZ1hjXax2uxREuZX581u0DfIKDMTYA4AZ5vaHwHZmdDJyZ58EECgcMhMDnf2PEpXmSWiJMueX6QEwEJ2Cjdb/HBGObH6theTtT5721NpW83oYod9lsJlvpxFzSIQHvasof8aWEu+hhsGlZdGTDR7p4is5gmYxzy5EEwf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+rFf4yH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+rFf4yH"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1222282a91.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533203; x=1789138003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+KORA1QOawwybzzFnrAjqMpjLNSbqqT9+9DA9omrxog=;
        b=l+rFf4yHWql9AX6Qnnc9MbjhT1nNeQxPM89htsqNdtME5wCtUI8a8Urwr8hm2uDQLL
         nfgUB1j4e41oNxpVk2jwfBqMrHONAYwcILkAdTg1HjC98KVBKr7pZoEXZ1bYGy2YePjv
         ulP218h+vcSQbzh5k7uia6dk2YJgcHLdljNP1+oLNcrrTmYSld9MJI37Shkj62oAVBvW
         4f/dN/ceyOt/+q52BwDwGZ1GlQgACyQN6JfleuAp3o5rBI/wTvZqSrlqOvqf90ASXGWf
         RQz4muEo6C8nvnpVKJRQK618QCfn50LOmiT5zhY51UnC1b9c95btTJwXM6wliJAvKV/r
         P+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533203; x=1789138003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+KORA1QOawwybzzFnrAjqMpjLNSbqqT9+9DA9omrxog=;
        b=qzcBteZJEF5DyMrpP0uA4uXUuIqBXlE30H3aawYUqd5zyHvvFW3+U3ThWaKM6kLfrl
         MnVz05rPuG2n9ldoEXlQcCT3G9bGKv+vKUgCH22DQ72/sZHdcJewqSPDNb7rfUCmG84p
         Uc4VhYyIixxSk58V47PU3XpeUSG1YZ2sTK5D5HxcvTtSf9tKJA2fps1K1K/0ki/MO+6p
         2PKzric+1CTbbDNRJeG1qNNskzmfid56uWj/u2/IXBNUDel+mEjh/BG6R7aA8lpfxAIf
         rHsH4nC6H6qDQ/A7997rFhAQF05kTBQ0a4ESucT62ejZs+6uDn+wBG1/0Zpz1LhNihlp
         HVMw==
X-Forwarded-Encrypted: i=1; AKwUvByU0ixT6UEoIWqMQ/sf2py0Zi6pu5rcYwfOxPTVL/rMIbcg220HMZSPf73ax3g5ec5GKBEubfo=@vger.kernel.org
X-Gm-Message-State: AFuF++nka08VQ4vm5J4lUnHHXjy00cga9vzy1DtiMJMJDkJaHek9qVyo
	Ebmmv5J2WjRD7JeeLpdrmCIY6ybIiryuvFTpvpb/DvsVRpxxnFcq92UP
X-Gm-Gg: AYBFou3XZEp+KnJDP6iEq6WVs5KPv2wMGB7VkOWj6+PMWbbBe02M3hnbqWCtdG7E3Bx
	G96oc7lP3oNv6fEAR6KO4IMqZYUFI1ze6b9xn02b5QK058Wmof7VSdyQDWkB1RjWHrDKCO4B/wR
	MipeeJBwxtZtx0h1z3Z/N1/HCw8SQRex9YG105PbaVwIGGSEd5AeECvNSGNe6FTuInX8n6rzy1R
	rJZOymKLtt+BCD5ne5ZUq8RkheHURybuCZv1thrkQnL1zAoT67wRg1ZfEiiDJDALV5dOvsSYm90
	H0t74SBpXeStUw8rpfh3JhGSeY7C4tbetV8D+KptfPasaSZ0z9JkK1/hdyNou7O7VJ0kcL37PNJ
	/R50gKIoT30p9v6jY+j4nz8FV+jN0+uB1xzepGuia1AtWfiO+U3Swa5zdqYpuI93HsLwSMzgBjs
	Mm1o3sZDJOx5nUj7EXz7RfWrsmZmXeSBpJ/UvQVFKVxJSzdkCA9erVQn4r5aPm0j+zQ7P/dpVdZ
	fPB44ZsC2rvUg==
X-Received: by 2002:a17:90b:4490:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-39b279ad968mr4255057a91.0.1788533202363;
        Fri, 04 Sep 2026 07:46:42 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccc72fsm5392354a91.2.2026.09.04.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:46:41 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com
Cc: horms@kernel.org,
	alexander@mihalicyn.com,
	brauner@kernel.org,
	adobriyan@openvz.org,
	akpm@linux-foundation.org,
	leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] netlink: render SCM_CREDENTIALS pid in the receiver's pid namespace
Date: Fri,  4 Sep 2026 22:46:36 +0800
Message-Id: <20260904144636.3443342-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__scm_recv_common() translates uid and gid into the reader's user
namespace but copies the pid as is. AF_UNIX gets away with that because
unix_skb_to_scm() re-renders the pid with pid_vnr() at recvmsg time.
netlink_sendmsg() renders it in the sender's namespace and stores a bare
u32, so a reader in another pid namespace sees a number from a namespace
it is not in. The sender chooses that number. An unprivileged sender in a
child namespace made the receiver see pid 300.

Carry the sender's struct pid in NETLINK_CB and hand it to scm_set_cred()
in netlink_recvmsg(), the way af_unix does. netlink_skb_set_owner_r()
takes the reference and netlink_skb_destructor() drops it. A reader in a
namespace the sender has no pid in now gets 0, like AF_UNIX.

I found this with a CodeQL checker. I used Claude to help write the
reproducers. The ones that reproduce the bug run unprivileged and need no
kernel changes. Tested on net with KASAN and lockdep, no reports. The tree
has no netlink SCM selftest.

Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 codeql
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 include/linux/netlink.h  |  9 +++++++++
 net/netlink/af_netlink.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 882e9c1b6c1dcc..26266754e27c14 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -30,6 +30,15 @@ struct netlink_skb_parms {
 	struct sock		*sk;
 	bool			nsid_is_set;
 	int			nsid;
+	/*
+	 * Sender's struct pid.  netlink_sendmsg() stores a borrowed pointer
+	 * taken from its own scm_cookie.  netlink_skb_set_owner_r() takes a
+	 * reference when it takes ownership of the skb for a receiver, and
+	 * netlink_skb_destructor() drops that reference.  A clone starts out
+	 * borrowing again, because __skb_clone() clears both skb->sk and
+	 * skb->destructor.  NULL for a kernel generated skb.
+	 */
+	struct pid		*pid;
 };
 
 #define NETLINK_CB(skb)		(*(struct netlink_skb_parms*)&((skb)->cb))
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e6b1d9758c9c92..170d90d472a0db 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -379,13 +379,24 @@ static void netlink_skb_destructor(struct sk_buff *skb)
 
 		skb->head = NULL;
 	}
-	if (skb->sk != NULL)
+	if (skb->sk) {
+		/*
+		 * The reference is held for as long as skb->sk is set, taken
+		 * in netlink_skb_set_owner_r() and dropped here.  The pointer
+		 * is left in place: do_one_broadcast() orphans an skb one
+		 * listener owned and hands it to the next, which takes its
+		 * own reference, and the sender's scm_cookie keeps the pid
+		 * alive across the whole broadcast.
+		 */
+		put_pid(NETLINK_CB(skb).pid);
 		sock_rfree(skb);
+	}
 }
 
 static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 	WARN_ON(skb->sk != NULL);
+	NETLINK_CB(skb).pid = get_pid(NETLINK_CB(skb).pid);
 	skb->sk = sk;
 	skb->destructor = netlink_skb_destructor;
 	sk_mem_charge(sk, skb->truesize);
@@ -1880,6 +1891,13 @@ static int netlink_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	NETLINK_CB(skb).dst_group = dst_group;
 	NETLINK_CB(skb).creds	= scm.creds;
 	NETLINK_CB(skb).flags	= netlink_skb_flags;
+	/*
+	 * Borrowed here.  scm_destroy() below drops the scm_cookie's own
+	 * reference, and every delivery in between is synchronous, so the
+	 * pointer stays valid until netlink_skb_set_owner_r() takes a
+	 * reference of its own.
+	 */
+	NETLINK_CB(skb).pid	= scm.pid;
 
 	err = -EFAULT;
 	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
@@ -1971,7 +1989,15 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		netlink_cmsg_listen_all_nsid(sk, msg, skb);
 
 	memset(&scm, 0, sizeof(scm));
-	scm.creds = *NETLINK_CREDS(skb);
+	/*
+	 * Render the sender's pid in the reader's pid namespace, the way
+	 * unix_skb_to_scm() does through scm_set_cred().  A NULL pid gives 0,
+	 * so a control block that lost its reference reports "unknown" rather
+	 * than the sender's own untranslated number.  scm_recv() below drops
+	 * the reference taken here on both of its paths.
+	 */
+	scm_set_cred(&scm, NETLINK_CB(skb).pid, NETLINK_CREDS(skb)->uid,
+		     NETLINK_CREDS(skb)->gid);
 	if (flags & MSG_TRUNC)
 		copied = data_skb->len;
 
-- 
2.34.1

