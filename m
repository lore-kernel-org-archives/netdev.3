Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947E51A72F;
	Fri,  4 Sep 2026 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548664; cv=none; b=AxCEY2/72lMt4+V+PT5VeGEohtZO8fibMndEPlOODDL45zYKEQXIm1BqsrQ0KH5yr7mpQ1BWxUBGDkW4e2BiF/1t8twbApXgRfybJ2Ef6q030vrZlpoVSqS59UAcRFlCVzF60QPNkztluqdsZM6kEBjj6qMm6J8pqFSYhE2wnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548664; c=relaxed/simple;
	bh=yfgnJgH1ZxB+8KCXYP7eRutA9mZjCJKMQbKhRzpiROg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRtB+N55DzbByK4xqQWgIu0kGLCzj2uSZ6Y0pvxU2iauAwH6nl7niGV29Y8tXokYWUx2PKZH3BMhVvHok7Y3A4GAsAq8OVKWVx3w4QKqcer9a1lgv19zpdctPJJEfxtMgUBpCUm25BhE8mIoyA60Cj5nw4KQRUF7tRozl0FFenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0PUEZB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0PUEZB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E211F00A3F;
	Fri,  4 Sep 2026 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788548655;
	bh=d7+Xke1S3vggW6XCP4Ja4gE16U8Alb+AunnkjdqloCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L0PUEZB+GknDSubWU34o+SDV+R8MaAt9/qKRnDgy85bPfr8Qkr5xdSJNjdRDuA1yX
	 bJgWXv1rYzeoS35QT0XxgnOmxrAca4JIHhXRVwcVwwgTp0xxoo8lKBLEWfk3H4/7V5
	 mJUS5x/5ifx6D4dEe3dvIp8wpRXRkyYljuBmTBNOpH13sMTjHGdQRR+SkzsoyUxCP5
	 3lMpbT4eemaNcnaCPl69iAVnGQEn8kf5xTW3GFVvOuVCgcmE4dVOmBJ+r1p37+QwtA
	 iUsjJAEyz0F4vylXVjk1+KWGCdwsstES1yllGuR90DYRKMNVYx1723ICINxSuqywA5
	 XcZtk7b6+E7YQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	cel@kernel.org,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	kernel-tls-handshake@lists.linux.dev
Subject: [PATCH net-next 2/2] netlink: specs: handshake: do not accept the handler-class sentinel
Date: Fri,  4 Sep 2026 12:04:10 -0700
Message-ID: <20260904190410.3864660-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904190410.3864660-1-kuba@kernel.org>
References: <20260904190410.3864660-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"max" is the exclusive upper bound of enum handshake_handler_class, not
a class a handler can ask for, but the spec lists it as a plain entry.
_init_checks() derives the policy limit from the highest entry, so the
generated policy came out as NLA_POLICY_MAX(NLA_U32, 2) and
handshake_nl_accept_doit() takes class 2 all the way into
handshake_req_next(), which walks hn_requests under hn_lock before
returning -EAGAIN instead of the -EINVAL a bad class deserves.

render-max is how YNL spells this, and unlike a hand written limit it
stays correct when a second handler class is added.

It does change what HANDSHAKE_HANDLER_CLASS_MAX means - the highest
valid class rather than one past it, as in every other Netlink/YNL
family - with the count left as __HANDSHAKE_HANDLER_CLASS_MAX.
The constant is uAPI, but I could not find any user space user,
this constant seems to have been added for kernel's benefit.

I think the risk of changing this is worth taking, having MAX
with different semantics than the rest of Netlink is very confusing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: cel@kernel.org
CC: donald.hunter@gmail.com
CC: ast@fiberby.net
CC: matttbe@kernel.org
CC: kernel-tls-handshake@lists.linux.dev
---
 Documentation/netlink/specs/handshake.yaml | 3 ++-
 include/uapi/linux/handshake.h             | 5 ++++-
 net/handshake/genl.c                       | 2 +-
 net/handshake/handshake-test.c             | 2 +-
 net/handshake/request.c                    | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 9ab46da04c49..0498ada2dd97 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -22,7 +22,8 @@ doc: Netlink protocol to request a transport layer security handshake.
     type: enum
     name: handler-class
     value-start: 0
-    entries: [none, tlshd, max]
+    entries: [none, tlshd]
+    render-max: true
   -
     type: enum
     name: msg-type
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index d7e40f594888..f907aa082520 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -13,7 +13,10 @@
 enum handshake_handler_class {
 	HANDSHAKE_HANDLER_CLASS_NONE,
 	HANDSHAKE_HANDLER_CLASS_TLSHD,
-	HANDSHAKE_HANDLER_CLASS_MAX,
+
+	/* private: */
+	__HANDSHAKE_HANDLER_CLASS_MAX,
+	HANDSHAKE_HANDLER_CLASS_MAX = (__HANDSHAKE_HANDLER_CLASS_MAX - 1)
 };
 
 enum handshake_msg_type {
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 58606c2a4600..26e3efec64ca 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -14,7 +14,7 @@
 
 /* HANDSHAKE_CMD_ACCEPT - do */
 static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HANDLER_CLASS + 1] = {
-	[HANDSHAKE_A_ACCEPT_HANDLER_CLASS] = NLA_POLICY_MAX(NLA_U32, 2),
+	[HANDSHAKE_A_ACCEPT_HANDLER_CLASS] = NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 /* HANDSHAKE_CMD_DONE - do */
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 3dd507470d5f..4b99acd9f9c7 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -42,7 +42,7 @@ static struct handshake_proto handshake_req_alloc_proto_2 = {
 };
 
 static struct handshake_proto handshake_req_alloc_proto_3 = {
-	.hp_handler_class	= HANDSHAKE_HANDLER_CLASS_MAX,
+	.hp_handler_class	= __HANDSHAKE_HANDLER_CLASS_MAX,
 };
 
 static struct handshake_proto handshake_req_alloc_proto_4 = {
diff --git a/net/handshake/request.c b/net/handshake/request.c
index cd30d54d0501..ff739ee81cb8 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -115,7 +115,7 @@ struct handshake_req *handshake_req_alloc(const struct handshake_proto *proto,
 		return NULL;
 	if (proto->hp_handler_class <= HANDSHAKE_HANDLER_CLASS_NONE)
 		return NULL;
-	if (proto->hp_handler_class >= HANDSHAKE_HANDLER_CLASS_MAX)
+	if (proto->hp_handler_class > HANDSHAKE_HANDLER_CLASS_MAX)
 		return NULL;
 	if (!proto->hp_accept || !proto->hp_done)
 		return NULL;
-- 
2.55.0

