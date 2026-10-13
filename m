Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC84E77E2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935023; cv=none; b=pbAEJS6pbUeACvS0gZUKmzVoTVXIYupVNZfoMpxSeagokTFS1QgKA4FAzACeyx4d+ku4geSME0nWNDLd18rruEu9BXreEg+mHlKJV7xoAV2kOsbOYmUOUVCE0ZnGjxzbWRT2IQVYiRP+H+l5xp83LpDoDPy4I198cA4ipevIwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935023; c=relaxed/simple;
	bh=bfxbVwtokcd01M2enVtTeTKpJh0bxmFffQUww3wsOoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hnbl6RP/r0IH40iyDNHcapJblHU5/IHNsiRpYM0yJD3VQFqoT7c4c6qDMFXRKY8O7IBSnb7nDVsOj89fvH2ltQ4qKkXFvVnPjiVFQnpBwDfVoXr1ssVpCAkGzWfIwB84JRRfuH+0HZqgSWE46VMIVIU9c376Hwscf431a23klqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loHNLw79; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loHNLw79"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so29070995e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935020; x=1792539820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbK6BK/Sj/b7bRnCH5dsivi2mNCZdQNMtkOnxkkzFB4=;
        b=loHNLw79zd9r57jsdzG0utlCvC8KHig8WqWCvYY0xOzvUd3S0gdZXRxyrlOgc8ftL7
         WkmnhH5dJPYRWLNG2K1CXrvmUT30dS3sa3+8WJvfkRwJ7m+yFWncgXYILgmywjXUjlvW
         K47P1MK3h0aTB4owJsfkMY+G9bf4ZTas0XYV2Ufuldv/g37IZfj5n0djv6cxeEdsn9Vq
         UgDoDy9U474zQUnu+qbjYDl/G59qgmq83BJezspZ/UQj8ffzYcRfVCmr/ccIv75cFQll
         fweRaxb48zenmYHz/olzaVM1kAZ6o6rBFE5aXHGIEUiUPu7ve++XsEAZ0YGHkhZ3/yRM
         A76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935020; x=1792539820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JbK6BK/Sj/b7bRnCH5dsivi2mNCZdQNMtkOnxkkzFB4=;
        b=pfF+Wu2kKYCCNWgvgo/BrGVEV2i7Pe1kUu1YC2wSUffLfnh0F198aOky22A/80eiHC
         0N3onjSGySHFeZ2JzeTm6+pT+n27hWOKtf8b6v3MWkc+Wyzbc+BJqSA8uHutVop14YDV
         8uHbQYgCtG+HPFDn+rGRjTAguyjRv6lizybXTHO0FaeQfRuqbXzKjVAF9EORnnfOcZls
         cCQizY8k1IK39mlydMGmSZTMsmjEmp0VHFqVm/KsD1HvKeNNsA4BPp8yzVn6Z5tj0x/p
         U73xqj/+k7dmJoNXlq/e7jrS/nJv/E2IwAsUSZ2LIHMWZlxyAXl2hcsqIwpStMUAe9mQ
         G4Nw==
X-Forwarded-Encrypted: i=1; AKwUvBwLtFXCZeOodtU/vVew8ZAWDvtZS63I4F8FW/QQDHTjZX7k9roL/0vNxWrMkpJ+DL4RhfxwfFk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg84d6iWprN4bVCTCLopQ5nIbYWJgY17PT8+J/izdQapn5mx/g
	+pCWWXr/H6e0r6wg7naSd7zAVmiii9xVfBf64oTM6PIQSOeTsY1eRHs=
X-Gm-Gg: AYBFou0ecfj2RGiXsmIlMGXBmYW98TcTM1TrT91vhCRFdL4pRJOYmsoPk9raxDb6PHj
	RIxlFzFyKzSzNVV5wSazGQFKQG2DynG3Y8JIzwUzaLFeuDK5srKsL40A9cNdMIh/DPICixDICqQ
	VJe5QrZi/4P6O3Z+fTvMPCWjliXhjDGjzUsfIa3TO/KZa1c2ffUjBBewueXRykrrJ4q9P8UPrIU
	4bLQxAvb+14SkoRBphV5ZmBWFTBU9SZjdl6xuc/FsgOhURhXRx08bBEHIwX+gVcv9meTnkPhBJg
	NR9LAUN2Sl5m8Vt2GfzcnyDi7hqRozq2DSlMQOD8GGsNnTUbSZteZFftwnD1/LZkB/Xi+6Wx89k
	Lt/MrqtDOQ0MOp+1LwGQhvfsZUEPcYX8XpYEJt/q9q2z2KwcvM3Tjuaika1FcCF4aqMbpaZmHVC
	LKn3nO2ZphvMQF3g1yuCm/lTGltJV/7ptGiagljJE=
X-Received: by 2002:a05:600c:c104:b0:4a1:96cd:2f73 with SMTP id 5b1f17b1804b1-4a196cd32b0mr144209005e9.1.1791935020199;
        Tue, 13 Oct 2026 16:43:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm390372155e9.13.2026.10.13.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:43:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH nf 3/5] netfilter: nfnetlink_log: pin file with get_file_rcu() before reading f_cred
Date: Tue, 13 Oct 2026 23:43:26 +0000
Message-ID: <20261013234329.2797868-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013234329.2797868-1-tristmd@gmail.com>
References: <20261013234329.2797868-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Since commit 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU"),
struct file objects can have their slab slot reused while RCU readers
still hold pointers to them. The NFLOG UID/GID metadata construction
reads file->f_cred without pinning the file, which could lead to
logging credentials from an unrelated file if the slab slot is reused.

Use get_file_rcu() to take a reference on the file before reading
credentials, and fput() to release it after extracting uid/gid values.

Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/nfnetlink_log.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index d923f2cb13980..8c9e297a7dc18 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -632,22 +632,27 @@ __build_packet_message(struct nfnl_log_net *log,
 	/* UID */
 	sk = skb->sk;
 	if (sk && sk_fullsock(sk)) {
-		const struct socket *sock;
-		const struct file *file;
+		struct socket *sock;
+		struct file *file;
 
 		/* The sk pointer remains valid as long as the skb is.
 		 * The sk_socket and file pointer may become NULL
-		 * if the socket is closed.
-		 * Both structures (including file->cred) are RCU freed
-		 * which means they can be accessed within a RCU read section.
+		 * if the socket is closed. Since struct file uses
+		 * SLAB_TYPESAFE_BY_RCU, pin the file with
+		 * get_file_rcu() to ensure f_cred is not from a
+		 * reused slab slot.
 		 */
 		sock = READ_ONCE(sk->sk_socket);
-		file = sock ? READ_ONCE(sock->file) : NULL;
+		if (sock)
+			file = get_file_rcu(&sock->file);
+		else
+			file = NULL;
 		if (file) {
 			const struct cred *cred = file->f_cred;
 			struct user_namespace *user_ns = inst->peer_user_ns;
 			__be32 uid = htonl(from_kuid_munged(user_ns, cred->fsuid));
 			__be32 gid = htonl(from_kgid_munged(user_ns, cred->fsgid));
+			fput(file);
 			if (nla_put_be32(inst->skb, NFULA_UID, uid) ||
 			    nla_put_be32(inst->skb, NFULA_GID, gid))
 				goto nla_put_failure;
-- 
2.47.3

