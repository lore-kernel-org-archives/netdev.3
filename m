Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D04E534A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935019; cv=none; b=k1793U6VATcgcuWoqML5qTw2RL8RR+X5fR51qCZ/C+7DP24QNMpYB16nMnbafYLs/xewgdE9KwpXwoKU/bV8OKNTEMNZBASeLwG8DaUgJxYrpTp4eZA9j3V5EPNdydGdHgWhivh9p06ucGkCVhI9LYru99U6Aj8p+sAHQ96DlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935019; c=relaxed/simple;
	bh=5jdOROMNUHVO4P/XHZZp6UpoiUjluiQa0QfEWuTjMEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0ES54yAFjRdi1nQX9Glgx9D8fRWATUa7aAh0R8IkZqon5mQYv64y9nD6FvXtgPVXU+5wSTEGe+bdah6xzJYgJXyPn6/8YlLg5/WAPp1DF2uihtHs3MEvv/rGX6TnEMshdC2a3Two/A974ezesBlGDFivBd5pTUe7zZ6cvuuT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWDbdg3T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWDbdg3T"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16c399641so34854625e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935016; x=1792539816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzq/x4mddpbPm3Ds57DNlSCPWkulDVxUviBcc2SD7NI=;
        b=KWDbdg3T+ybtsvARg3GOaK1CNyJ+QSbEVuDuVVyHwQTPypNjluQXXZ5nrioYUug8EC
         z6hmKhWL7ip0lV2+t9jdfB3lenkEdzVsnxXh/2yz8Kc/Jf9JmjzcEHDxO2Vo1xfJjDYb
         MgMLBSuh5OOnWYxu+3Kc2jgNaXQbIcOvIbRPjFCpsSMDoMDd1OH6z+agAeQZzqv/EcUx
         qsvQrJPdLpLSU7fy+MokCSZM6NvTrkcRo4SDV7R48F8RBiHhhNpeTwzW7cJr9kfjc+9/
         ZvjjFZrbVn3YtGrW+4ix8vCY8n+aubrvh9kwtgDaoXIsdCcDcZMrOT1iOQYq1sxS3bGR
         tDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935016; x=1792539816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzq/x4mddpbPm3Ds57DNlSCPWkulDVxUviBcc2SD7NI=;
        b=qdhwkAOmwQp4jboqCnlXBWGPRiOHHR6lwiPh4LQs6oOYMPBp2lg4mna4ilvkGoCx20
         br5PXeA+5v0w03LU8RY1xWr5yyYjlZNZd32heN3NePr+aMfE/ACrmLdakqNI1V9sEMBg
         RwK9Nk96Z3ePkm7cqxqqOMsOfvUSDuRUJraacf7XmWiQbk+XgJYJSSx9EqVCcxqVzdAf
         8dEF6OeMvKE3md6Uk+Q3rQuBSC2r22ib7jxv5x/ULEM9g29o1zNMLTL8sprVToll+DB2
         RcDSB3rw5nJCbem1tYJVJxLu/kmuEkyFxb5QG26DUyv0AhoEQML7hz75XqkX+vOAialn
         6G3A==
X-Forwarded-Encrypted: i=1; AKwUvBx/c9OEN+qVCg55B1Q5xchpppLXYJ8aNO6me9T3vkRa9j4qLDMtTrpvv8OezAxplNZ2xWvP9/g=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6PuBA+cD8MLmI3rnb7BZcbAPmFMvXY3jUOED/jP7SWpXZ8Gvx
	1Y1Sy1HrsjJ2BKhYkbx7z28VUtw/lFTCZHrGe8U/BIMxTOGjfWxZ048=
X-Gm-Gg: AYBFou2eU1qoxeZqmvsV4l27IyfPsitbfdwyr45a6CvV0nbatOSTXvxbvunYcCPCtg4
	ky4HFtMQZGRvPSiJsqbtSZH6zDUS8BUYavm0GAbv9JgrirAnctgy/4iwfp/LcRIzhtNr94AyKK5
	odT913piMtDj3MQlH5JjYjBecxVpm0bPdhbvIcvb0fKbw8JW5YeziKU6bg2ja19kVBRHX5YYAMZ
	23ezYIixtXiCNt5lrPCX75U07iRsiENCWTFDgE/jsiyIgaOv3/1TfJplJisUMBDyYNTxmRikgFY
	QnEJ3rejZDYkNo7vtfI/iovWa648w/eHgNwjXlKx9sgTGiWoAy9jtxy4LlpCROehbw5c3xNxXua
	YWAGiW+6s5Fvddf8g8rrZ47kNXAYWs4w4NFVSgbJ3GVbsEW2hlzu7ncb1dKoXW5dCJOSIyFwnv8
	g+Zil5tzbB3kX50KsEA5l05MNVOtpeqsBY/4PdA36abt3EKkfliw==
X-Received: by 2002:a05:600c:3f1a:b0:4a1:ac66:6ac6 with SMTP id 5b1f17b1804b1-4a1ac667160mr77160605e9.26.1791935016224;
        Tue, 13 Oct 2026 16:43:36 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm390372155e9.13.2026.10.13.16.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:43:35 -0700 (PDT)
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
Subject: [PATCH nf 1/5] netfilter: xt_owner: pin file with get_file_rcu() before reading f_cred
Date: Tue, 13 Oct 2026 23:43:24 +0000
Message-ID: <20261013234329.2797868-2-tristmd@gmail.com>
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
still hold pointers to them. The xt_owner match reads file->f_cred to
check fsuid/fsgid/group_info in the packet path without pinning the
file. If the file is freed and the slab slot is reused between reading
sock->file and dereferencing f_cred, the credential check will operate
on stale or unrelated credential data.

Use get_file_rcu() to take a reference on the file before accessing its
credentials, and fput() to release it on all return paths.

Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/xt_owner.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index 8f2e57b2a5868..6386b52147d87 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -65,8 +65,8 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	const struct xt_owner_match_info *info = par->matchinfo;
 	struct sock *sk = skb_to_full_sk(skb);
 	struct net *net = xt_net(par);
-	const struct socket *sock;
-	const struct file *filp;
+	struct socket *sock;
+	struct file *filp;
 
 	if (!sk || !READ_ONCE(sk->sk_socket) || !net_eq(net, sock_net(sk)))
 		return (info->match ^ info->invert) == 0;
@@ -77,13 +77,17 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	/* The sk pointer remains valid as long as the skb is. The sk_socket and
-	 * file pointer may become NULL if the socket is closed. Both structures
-	 * (including file->cred) are RCU freed which means they can be accessed
-	 * within a RCU read section.
+	/* The sk pointer remains valid as long as the skb is. The
+	 * sk_socket and file pointer may become NULL if the socket is
+	 * closed. Since struct file uses SLAB_TYPESAFE_BY_RCU, pin the
+	 * file with get_file_rcu() to ensure f_cred is not from a
+	 * reused slab slot.
 	 */
 	sock = READ_ONCE(sk->sk_socket);
-	filp = sock ? READ_ONCE(sock->file) : NULL;
+	if (sock)
+		filp = get_file_rcu(&sock->file);
+	else
+		filp = NULL;
 	if (filp == NULL)
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
@@ -94,8 +98,10 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID))
+		    !(info->invert & XT_OWNER_UID)) {
+			fput(filp);
 			return false;
+		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -120,10 +126,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID))
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			fput(filp);
 			return false;
+		}
 	}
 
+	fput(filp);
 	return true;
 }
 
-- 
2.47.3

