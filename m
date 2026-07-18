Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981E49620;
	Sat, 18 Jul 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399388; cv=none; b=Jq1nDNv7GDKn8N6lvF3fJZappxovKKjcWx0xWzsqMXett+oachA0b+pRlEiFiLQmX/exIgnBYOpRm38AqMWuI5CFfjCqr/QCjW2Tzu6oIQB70/N3RV7pcjMN2hW9+lFWU4tCSXTa9RTQNaI5cTF3NqLNC7pdf4lcxXw2rNQjOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399388; c=relaxed/simple;
	bh=x/hoXOquiFSZmVpL+mCxpWS8nCScMGrX8eax1dgfXAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Raom7jL3JeVDVgFTPWfwINRlZOrSUK6XnNhkyY6US70tz68zuiiSGo6SDjIFb6vqhGcqsDvHQsUJycQbWvuYH8QXAFE9vlpT+I0FCqMEsnFf4HL7EBcitCGk6dEPQGTE8pAOU8eJ5o31yVMF+4iv6sSJIvpOP1Mpw7lJ9i/xfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DkDGO/Wf; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=Obsidian.Systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DkDGO/Wf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 3810013001F2;
	Sat, 18 Jul 2026 14:29:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 18 Jul 2026 14:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784399385; x=1784406585; bh=J
	9HPas3hba4FTYVtnHMztMowr7lSfgESIwG17Wizsuw=; b=DkDGO/WfeVEVoBzZL
	kuGmIbRPzIG9b5xGVLRUGeVc8TX/M3ZpS3WKO2h/R30B0Ht88lLPfpBmkQuSFSZo
	OduGPQAQBHZ9eifmdSuXM5q2srgboiyVO7s89hkT8BXNhuUtvqnk5zBYuX0VFRSX
	T9I4r383z5t1B0YupP636quHrL/dWzffGsvZQU20GkTdhwNONle7pHbXnw7cA54N
	xzf6gJLOU+5dw0cQLuu9s853Y0JC/VzGh82IevE3+fvlWuHX533GFLpQCBfbVcSK
	S/qQPf6at7yhI+6Zt8uVDgg3fCiC3wRHQZYgSM5AKdjtzw3ccgD+B57D5oqnHKFV
	fFjJA==
X-ME-Sender: <xms:GMZbag25wpf2mEUnLLvYH1KokLX76oh7KMkqZx5CSHfOyn7zJ_uNkg>
    <xme:GMZbahkYlNOmkqSqhh5Su8t8ypLPrHRZPv545mfcIO37UAce69ANuKcfwuNyXi-y5
    IzIKRpL47c9PSy2WP3kTqxaaXESj68_FULgyEBUVc1xHGrcxwPECp4>
X-ME-Received: <xmr:GMZbam7DqqFpvMM3cVMT_YGnTZgIii1hF1wLvwpvDbApr3NEdxNjZVaZQn4wo_NtqEYUORz4CR-0XTKZlh5cINfDETdNctIzTFpjOA>
X-ME-Proxy-Cause: dmFkZTFn6QLaviPfiu3X2pydKmsR+mBXhjNZ+L1FI3fOmfGvIO9y+ot6Q2aIJf4p4PZz5q
    IfwP6fvPrvgylvfV7J+RfsmAz6YKr+30k6/gjG8+fYaN45Quo4mlW8ZEI/6O055ZFKmW4O
    NXFnceXONC/kbOiMHL7vZ6NQGDo4VZn3/1XEpYr3tX3UPzxwsdftk12PhLMAl67BY5ndwo
    3ZFrs0FO8+A6ejhX6qF3jzzAkRA/qrJ4Zs7gjQ8LEI4JEpTAM5gkfP6aqxCuY6/smDGgQ8
    s55ZOD6IdIv2xlaOfLKArzthCU3zqrojCgQ0b2+q6rkTvbhKQfsAGqaOkK+8hQ/MBG0lem
    N5dIPfIGB0YOig0ag7m940xVEe97cVj2FBsZJxsi3y4/BYF8BWbEw/pzabB4RF/4EzezTB
    EcLUS8aiGEDxyMoOC+d/FViIIyr56wjQrBcokN81vnQN1VX/R40JkIZBJrvhd3rhIZGq7w
    sW4uvhjf5Cgh1fvHdldIpsIo8Zth1/IlaezIocbHAkRuz5CPBOyeXTLHct+hfjF/XBMvPZ
    1zeWYJ13e0lrHlCSKXWnXxw+AkcYRaoifw2hw/gwH+CLQhF1G2QY4w4UZlWJoLLCA8wgGq
    d/HLRz0uS4PhFIh6R6icLH9auEZkFFL32ccOTasSAx187Fhqjc3XVDuiUT7g
X-ME-Proxy: <xmx:GMZbaslVXNzh9Yt2Rue64-7EzkNTiDAZ0xwxBVkFsWa_GFeytuE4cA>
    <xmx:GMZbapX_nKUmmYpDjUYttKeqwum3uZ3n3GV5hCwdjtLolL3tywYyiA>
    <xmx:GMZbatSjmgJmXyOim-4JWQGwixrxM_E2Texj4rNxoUzxh0e3cAfxoA>
    <xmx:GMZbauCG77Hxj5Y6hDygK0rTxGM_uLReHQNF2a7TzSI5XUiV3xd9EQ>
    <xmx:GcZbakxvoC89y5ijCZnZwpDVAheLVX0eqwKs46EIaOFsMINg12tdVuk9>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 14:29:43 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Ericson <mail@johnericson.me>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Cong Wang <cwang@multikernel.io>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] selftests/net/af_unix: test listen() rejects wrong socket states
Date: Sat, 18 Jul 2026 14:29:02 -0400
Message-ID: <20260718182903.2295560-2-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
References: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Ericson <mail@johnericson.me>

Add a regression test for the unix_listen() state check. The key case is
listen() on a bound socket that has already been connected: it is no
longer in TCP_CLOSE or TCP_LISTEN, so it must fail with EINVAL. A
prepare_peercred() call slipped in ahead of that check once left err at 0
and made listen() silently succeed there instead; this guards against a
repeat.

The neighbouring outcomes are covered too so they cannot regress the same
way: a bound socket in TCP_CLOSE listens fine, calling listen() again on a
socket already in TCP_LISTEN is allowed, and an unbound socket fails with
EINVAL.

Each case runs for both listenable socket types (SOCK_STREAM and
SOCK_SEQPACKET) and both pathname and abstract addresses.

Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Ericson <mail@johnericson.me>
---
 .../testing/selftests/net/af_unix/.gitignore  |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   1 +
 .../selftests/net/af_unix/unix_listen.c       | 187 ++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/unix_listen.c

diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testing/selftests/net/af_unix/.gitignore
index 240b26740c9e..973176644103 100644
--- a/tools/testing/selftests/net/af_unix/.gitignore
+++ b/tools/testing/selftests/net/af_unix/.gitignore
@@ -6,3 +6,4 @@ scm_rights
 so_peek_off
 unix_connect
 unix_connreset
+unix_listen
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 4c0375e28bbe..57d159803a3a 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -14,6 +14,7 @@ TEST_GEN_PROGS := \
 	so_peek_off \
 	unix_connect \
 	unix_connreset \
+	unix_listen \
 # end of TEST_GEN_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/unix_listen.c b/tools/testing/selftests/net/af_unix/unix_listen.c
new file mode 100644
index 000000000000..416fa3e5bfe9
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/unix_listen.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for the state checks in AF_UNIX listen().
+ *
+ * The central case is a regression test: listen() on a bound socket that
+ * is already connected (i.e. not in TCP_CLOSE or TCP_LISTEN state) must
+ * fail with EINVAL.  A prior change accidentally let it return success
+ * without doing anything, because a helper called in between reset the
+ * error code to 0.  The neighbouring checks (unbound, already listening)
+ * are tested too so they cannot silently regress the same way.
+ *
+ * Every case runs for both listenable socket types (SOCK_STREAM and
+ * SOCK_SEQPACKET) and both pathname and abstract addresses.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "kselftest_harness.h"
+
+#define SK_NAME		"unix_listen_sk"
+#define SRV_NAME	"unix_listen_srv"
+
+FIXTURE(unix_listen)
+{
+	int sk;			/* socket under test */
+	int server;		/* a listening peer, when a test needs one */
+	struct sockaddr_un addr, srv_addr;
+	socklen_t addrlen, srv_addrlen;
+};
+
+FIXTURE_VARIANT(unix_listen)
+{
+	int type;
+	int abstract;
+};
+
+FIXTURE_VARIANT_ADD(unix_listen, stream_pathname)
+{
+	.type = SOCK_STREAM,
+	.abstract = 0,
+};
+
+FIXTURE_VARIANT_ADD(unix_listen, stream_abstract)
+{
+	.type = SOCK_STREAM,
+	.abstract = 1,
+};
+
+FIXTURE_VARIANT_ADD(unix_listen, seqpacket_pathname)
+{
+	.type = SOCK_SEQPACKET,
+	.abstract = 0,
+};
+
+FIXTURE_VARIANT_ADD(unix_listen, seqpacket_abstract)
+{
+	.type = SOCK_SEQPACKET,
+	.abstract = 1,
+};
+
+/* Fill @addr with a pathname or abstract address named @name. */
+static socklen_t unix_set_addr(struct sockaddr_un *addr, const char *name,
+			       int abstract)
+{
+	size_t len = strlen(name);
+
+	memset(addr, 0, sizeof(*addr));
+	addr->sun_family = AF_UNIX;
+	/* An abstract address leads with a NUL and has no filesystem entry. */
+	memcpy(addr->sun_path + (abstract ? 1 : 0), name, len);
+
+	return offsetof(struct sockaddr_un, sun_path) + len + 1;
+}
+
+FIXTURE_SETUP(unix_listen)
+{
+	self->sk = -1;
+	self->server = -1;
+	self->addrlen = unix_set_addr(&self->addr, SK_NAME, variant->abstract);
+	self->srv_addrlen = unix_set_addr(&self->srv_addr, SRV_NAME,
+					  variant->abstract);
+}
+
+FIXTURE_TEARDOWN(unix_listen)
+{
+	if (self->sk >= 0)
+		close(self->sk);
+	if (self->server >= 0)
+		close(self->server);
+
+	/* Pathname sockets leave a filesystem entry behind; abstract ones do not. */
+	if (!variant->abstract) {
+		remove(SK_NAME);
+		remove(SRV_NAME);
+	}
+}
+
+/* A bound socket in TCP_CLOSE is the normal, allowed case. */
+TEST_F(unix_listen, bound_is_ok)
+{
+	int err;
+
+	self->sk = socket(AF_UNIX, variant->type, 0);
+	ASSERT_LE(0, self->sk);
+
+	err = bind(self->sk, (struct sockaddr *)&self->addr, self->addrlen);
+	ASSERT_EQ(0, err);
+
+	err = listen(self->sk, 8);
+	EXPECT_EQ(0, err);
+}
+
+/* Listening again on an already-listening socket (TCP_LISTEN) is allowed. */
+TEST_F(unix_listen, relisten_is_ok)
+{
+	int err;
+
+	self->sk = socket(AF_UNIX, variant->type, 0);
+	ASSERT_LE(0, self->sk);
+
+	err = bind(self->sk, (struct sockaddr *)&self->addr, self->addrlen);
+	ASSERT_EQ(0, err);
+
+	err = listen(self->sk, 8);
+	ASSERT_EQ(0, err);
+
+	err = listen(self->sk, 16);
+	EXPECT_EQ(0, err);
+}
+
+/* listen() on an unbound socket fails: there is nothing to listen on. */
+TEST_F(unix_listen, unbound_is_einval)
+{
+	int err;
+
+	self->sk = socket(AF_UNIX, variant->type, 0);
+	ASSERT_LE(0, self->sk);
+
+	err = listen(self->sk, 8);
+	EXPECT_EQ(-1, err);
+	EXPECT_EQ(EINVAL, errno);
+}
+
+/*
+ * The regression: a bound socket that has already been connected is not in
+ * TCP_CLOSE or TCP_LISTEN, so listen() must reject it with EINVAL rather
+ * than quietly succeeding.
+ */
+TEST_F(unix_listen, connected_is_einval)
+{
+	int err;
+
+	self->server = socket(AF_UNIX, variant->type, 0);
+	ASSERT_LE(0, self->server);
+
+	err = bind(self->server, (struct sockaddr *)&self->srv_addr,
+		   self->srv_addrlen);
+	ASSERT_EQ(0, err);
+
+	err = listen(self->server, 8);
+	ASSERT_EQ(0, err);
+
+	self->sk = socket(AF_UNIX, variant->type, 0);
+	ASSERT_LE(0, self->sk);
+
+	/* Bind first so the unbound check does not mask the state check. */
+	err = bind(self->sk, (struct sockaddr *)&self->addr, self->addrlen);
+	ASSERT_EQ(0, err);
+
+	err = connect(self->sk, (struct sockaddr *)&self->srv_addr,
+		      self->srv_addrlen);
+	ASSERT_EQ(0, err);
+
+	err = listen(self->sk, 8);
+	EXPECT_EQ(-1, err);
+	EXPECT_EQ(EINVAL, errno);
+}
+
+TEST_HARNESS_MAIN
-- 
2.54.0

