Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918868;
	b=03nSRhaj8n0dv1kxkeAAa1Ar7VLIiH/6s4uyoGeSoJJIISbiPHs0YEYHUHWE+UidONtS
	 SiFL405c4ArnZp90KoAyIP3jYUUuqS4VUa6A5SiTZzkfiOIownWiHDf35ioVWau43SKLt
	 OAMZEO6r608I1tJHGdvK/iFGfA3avX82W1LBA+rBNO5L4rCphCxcMbOugBJ6Bb/kxWCMs
	 Q47+j228oHFfx+Cp1L1EKvEUr89VBsArE1N3Xjbn9D/LI4J6UWoyAgPi1jt+XG0MNgWfy
	 QXC/BGuXyqaEyLWR8O0b6TXCviHkxjLdrwFmC67e5J1HJQXnqnwcUMEJSB6HS0bslZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oiVExxVVT0Fz3JK6FuEmAOW2fg9n/93PZDcOE5EMutw=;
	b=nf6HAdIpmLnzKCYq9S0PEJnRMJu2NIlb5uUHR4wpLoQXBlpfVo26YLm0HqEwCR327dMr
	 ri6XAcdfLyNUUXtJBYlA8ySegqvTChJnNuaQp4+eu1uC5ZclCimUqkkpB/4BoUYs77YXl
	 B5FeFLvgwtXgaEPTWVSG54i8MjMXkUrubLED0z+3TCuh9hTXL2ff0YAMTWtOBxKZcRHef
	 TaMbeKVt+p7wuQRauBCM/ocA78l51gRMVIwPtWecx3uXos5V6F9boL/79vHqxLvYUwmXE
	 S7/egGTv9x3xYlMt3QHkjoRTkSEPDCpezLf+3R/PcozxtC4P4AyudcQFMQOMnlKfvmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aQ5GeF9g;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B79606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 09:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B79606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aQ5GeF9g
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso19716175e9.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792918867; x=1793523667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiVExxVVT0Fz3JK6FuEmAOW2fg9n/93PZDcOE5EMutw=;
        b=aQ5GeF9gCBFKm0UYAPYKMdx7hfFid6OaDUdtoasgVOKCs/6unUo0B0xi8amcmgZ4rf
         9DwnU+BjhtwH1xZpyhZmH9rHh8oYju+8AQEPhwzUtQ2RJh3ymk8kSf1TtB4EOOPj5RxY
         pQinIr73sQZW7mPENFNph5wEuq+YeFyzEzFaMxTTKkRtmoFSCtlEQnEfYwDX8pO0G3y4
         Oud4aRvniY3WbWroBPRl3AxuHhMX1gYs+moMaofdZ0kbs5002w+Ig+PneeT1c+w9/mpt
         kpTKpFK3X9cNWxfbYC/dDMwNgBfcQRfwOPnvbUFDATI+RRgf+/gwxScUe2ybg1pDuBF3
         HkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918867; x=1793523667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiVExxVVT0Fz3JK6FuEmAOW2fg9n/93PZDcOE5EMutw=;
        b=2ZM7naupT5y9nSzU9VrL0bxRCc4WkzJUY7G5Mzl+U/G26P+/XPhlH5sfHx3fRESd7K
         MYYlDOreY0z42am65wRWQIpYtuMAwhcmfad/553JnxS6gSSF+KG2T8GNKV7kd4MvGLbY
         TP1/jU0KKOdqCKkJ6/JyRu3gPAq4X6wSjdyDrzTtaflmNPHKqObWzZC/c6nAyzLstfKa
         C7zJ0pCNcKQr64wJzuYVa40rCqC2bgJ9ZzQ+uGSF5eKSk8fQ4GQEkdHN0tewZ+871Jlb
         aRFRjP2JHw5q1t5hxcfPcQ4+sj+VIwOsQH2iXmTkYW6guumZMbHncKfIMYqDX7TrjX5A
         Vc9A==
X-Gm-Message-State: AFq9FYIeYJ5OhpfYPICOCtzFGHLN/VsqNkc0NeWzM0nVsMuyu2+i2u8w
	V0AXglzt3Z65PSejw6Fn66/ZCRgLvv8zTLnW7CfkUeMeX1k4jksivn78+gnp+WRc
X-Gm-Gg: AYBFou3doEPYL9e3OVYW0gmGhn8/MvasYXSeDMITxfrJFprGtV/lDKrzlZdNinLlaK7
	2/X+kmhEJbXCSphquIYe0sJdp9EzA7LNPusIJbzFVjYCikKkf5YQTTMhAI6euY0UFRFAoRRpD/W
	S6yPkpD8s4Ubdl/3QzXA0vT/u9KYFyDYh/aQofNYKHyS97A5bZX8fcJLbYRxR87J3BS+DVKwUtr
	0kVd7T7Nu9OJXvnFj07tGTWTcu4NGMvBFMA+fL7wU0Czgyp4QwW6xbiiHre5GJIRv5q3fHdEbQM
	HVrAc8N7wAvx2UyDSRZj+6ajXEC6FMiazEPQHaO29IN4D+HggW64iwAMmampqB347VC7dx0Rvr3
	/CmZw9FgtdcdDUqOWP/XJSH7EdQfekACL33BtQ1gUXFsjnWvNfMQ4UZlLR7PZIzjKNt81JAdmIC
	WtjrqnDzQbSTm3f4jb/U+oebinwPD3TomYVwNK5A6F1mGazk6JaavaJfPzJaze3t8jv/JsHaXX6
	p+rLZ9120y0TtDMkyz5zXmrc4IkeNXqZQbvD/Y8hFfyLxdK0jnD+EePZFCfx7HJ+x3ez7lgeCs=
X-Received: by 2002:a05:600c:474a:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4a35ace28e0mr65815995e9.32.1792918866454;
        Sun, 25 Oct 2026 02:01:06 -0700 (PDT)
Received: from zheweiy-mac ([2a01:4b00:b60b:cb00:c67:3956:189c:b7c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5822a7sm111588615e9.11.2026.10.25.02.01.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 02:01:06 -0700 (PDT)
From: Zhewei Yuan <yzwlhm@gmail.com>
To: netdev@vger.kernel.org
Cc: Zhewei Yuan <yzwlhm@gmail.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net 2/2] tcp: Add KUnit tests for bind fastreuse caches
Date: Sun, 25 Oct 2026 09:00:48 +0000
Message-ID: <20261025090048.27870-3-yzwlhm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025090048.27870-1-yzwlhm@gmail.com>
References: <20261025090048.27870-1-yzwlhm@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add eight KUnit cases using real TCP binds in isolated network namespaces.
Six check the tb/tb2 reuse caches for SO_REUSEADDR, SO_REUSEPORT and both,
with explicit or automatic ports. Two guard against reinitialization
when an owner or another address bucket already exists.

The six first-bind cases fail before the fix and all eight pass after
it, using matching tests/configs; both conflict guards pass before and
after.

Run with:

  ./tools/testing/kunit/kunit.py run --arch=x86_64 \
    --kunitconfig=net/ipv4/.kunitconfig --jobs=8 --timeout=120 \
    inet_csk_fastreuse

Codex assisted with test development and review, following requests for
real binds, cache inspection, automatic ports and conflict preservation.

Signed-off-by: Zhewei Yuan <yzwlhm@gmail.com>
---
 net/ipv4/.kunitconfig                |   8 +
 net/ipv4/Kconfig                     |  14 ++
 net/ipv4/Makefile                    |   1 +
 net/ipv4/inet_connection_sock_test.c | 303 +++++++++++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 net/ipv4/.kunitconfig
 create mode 100644 net/ipv4/inet_connection_sock_test.c

diff --git a/net/ipv4/.kunitconfig b/net/ipv4/.kunitconfig
new file mode 100644
index 00000000000..11ba2dd7bea
--- /dev/null
+++ b/net/ipv4/.kunitconfig
@@ -0,0 +1,8 @@
+CONFIG_KUNIT=y
+# CONFIG_KUNIT_ALL_TESTS is not set
+CONFIG_MULTIUSER=y
+CONFIG_NAMESPACES=y
+CONFIG_NET=y
+CONFIG_NET_NS=y
+CONFIG_INET=y
+CONFIG_INET_CONNECTION_SOCK_KUNIT_TEST=y
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 3545fb0a045..913bf9a6f43 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -778,3 +778,17 @@ config TCP_MD5SIG
 	  on the Internet.
 
 	  If unsure, say N.
+
+config INET_CONNECTION_SOCK_KUNIT_TEST
+	bool "KUnit tests for INET connection sockets" if !KUNIT_ALL_TESTS
+	depends on INET && NET_NS && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Test initialization and updates of the INET reuse caches through
+	  real TCP socket bind operations in isolated network namespaces.
+	  Exercise SO_REUSEADDR, SO_REUSEPORT and their combination, checking
+	  the fast reuse flags in both the port and address binding buckets.
+	  Cover both explicit and automatically allocated local ports.
+	  Verify that cache updates preserve conflicts with existing sockets.
+
+	  If unsure, say N.
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 69e4baaed12..2194bf2a3a4 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -16,6 +16,7 @@ obj-y     := route.o inetpeer.o protocol.o \
 	     inet_fragment.o ping.o ip_tunnel_core.o gre_offload.o \
 	     metrics.o netlink.o nexthop.o udp_tunnel_stub.o
 
+obj-$(CONFIG_INET_CONNECTION_SOCK_KUNIT_TEST) += inet_connection_sock_test.o
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
 obj-$(CONFIG_PROC_FS) += proc.o
diff --git a/net/ipv4/inet_connection_sock_test.c b/net/ipv4/inet_connection_sock_test.c
new file mode 100644
index 00000000000..7b210859de6
--- /dev/null
+++ b/net/ipv4/inet_connection_sock_test.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/in.h>
+#include <linux/module.h>
+#include <linux/net.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/user_namespace.h>
+#include <net/inet_connection_sock.h>
+#include <net/inet_hashtables.h>
+#include <net/net_namespace.h>
+
+struct inet_csk_fastreuse_param {
+	const char *name;
+	bool reuseaddr;
+	bool reuseport;
+	u16 port;
+	int fastreuse;
+	int fastreuseport;
+};
+
+struct inet_csk_fastreuse_cache {
+	int tb_fastreuse;
+	int tb_fastreuseport;
+	int tb2_fastreuse;
+	int tb2_fastreuseport;
+};
+
+static const struct inet_csk_fastreuse_param inet_csk_fastreuse_params[] = {
+	{
+		.name = "reuseaddr_only",
+		.reuseaddr = true,
+		.reuseport = false,
+		.port = 40000,
+		.fastreuse = 1,
+		.fastreuseport = 0,
+	},
+	{
+		.name = "reuseport_only",
+		.reuseaddr = false,
+		.reuseport = true,
+		.port = 40000,
+		.fastreuse = 0,
+		.fastreuseport = FASTREUSEPORT_ANY,
+	},
+	{
+		.name = "reuseaddr_and_reuseport",
+		.reuseaddr = true,
+		.reuseport = true,
+		.port = 40000,
+		.fastreuse = 1,
+		.fastreuseport = FASTREUSEPORT_ANY,
+	},
+	{
+		.name = "reuseaddr_only_port_zero",
+		.reuseaddr = true,
+		.reuseport = false,
+		.port = 0,
+		.fastreuse = 1,
+		.fastreuseport = 0,
+	},
+	{
+		.name = "reuseport_only_port_zero",
+		.reuseaddr = false,
+		.reuseport = true,
+		.port = 0,
+		.fastreuse = 0,
+		.fastreuseport = FASTREUSEPORT_ANY,
+	},
+	{
+		.name = "reuseaddr_and_reuseport_port_zero",
+		.reuseaddr = true,
+		.reuseport = true,
+		.port = 0,
+		.fastreuse = 1,
+		.fastreuseport = FASTREUSEPORT_ANY,
+	},
+};
+
+static void
+inet_csk_fastreuse_get_desc(const struct inet_csk_fastreuse_param *param,
+			    char *desc)
+{
+	strscpy(desc, param->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(inet_csk_fastreuse, inet_csk_fastreuse_params,
+		  inet_csk_fastreuse_get_desc);
+
+static void inet_csk_test_put_net(void *data)
+{
+	put_net(data);
+}
+
+static void inet_csk_test_release_socket(void *data)
+{
+	sock_release(data);
+}
+
+static struct net *inet_csk_test_create_net(struct kunit *test)
+{
+	struct net *net;
+	int ret;
+
+	net = copy_net_ns(CLONE_NEWNET, &init_user_ns, &init_net);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, net);
+
+	ret = kunit_add_action_or_reset(test, inet_csk_test_put_net, net);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return net;
+}
+
+static struct socket *
+inet_csk_test_create_socket(struct kunit *test, struct net *net)
+{
+	struct socket *sock;
+	int ret;
+
+	ret = sock_create_kern(net, AF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Close all sockets before the namespace cleanup action runs. */
+	ret = kunit_add_action_or_reset(test, inet_csk_test_release_socket,
+					sock);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return sock;
+}
+
+static int inet_csk_test_bind(struct socket *sock, u32 address, u16 port)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(address),
+		.sin_port = htons(port),
+	};
+
+	return kernel_bind(sock, (struct sockaddr_unsized *)&addr, sizeof(addr));
+}
+
+static struct inet_csk_fastreuse_cache
+inet_csk_test_read_cache(struct kunit *test, struct sock *sk)
+{
+	struct inet_bind_hashbucket *head, *head2;
+	struct inet_csk_fastreuse_cache cache;
+	struct inet_bind2_bucket *tb2;
+	struct inet_bind_bucket *tb;
+	struct inet_hashinfo *hinfo;
+	struct net *net = sock_net(sk);
+
+	tb = inet_csk(sk)->icsk_bind_hash;
+	tb2 = inet_csk(sk)->icsk_bind2_hash;
+	KUNIT_ASSERT_NOT_NULL(test, tb);
+	KUNIT_ASSERT_NOT_NULL(test, tb2);
+
+	hinfo = tcp_get_hashinfo(sk);
+	head = &hinfo->bhash[inet_bhashfn(net, inet_sk(sk)->inet_num,
+					  hinfo->bhash_size)];
+	head2 = inet_bhashfn_portaddr(hinfo, sk, net, inet_sk(sk)->inet_num);
+	spin_lock_bh(&head->lock);
+	spin_lock(&head2->lock);
+	cache.tb_fastreuse = tb->fastreuse;
+	cache.tb_fastreuseport = tb->fastreuseport;
+	cache.tb2_fastreuse = tb2->fastreuse;
+	cache.tb2_fastreuseport = tb2->fastreuseport;
+	spin_unlock(&head2->lock);
+	spin_unlock_bh(&head->lock);
+
+	return cache;
+}
+
+static void inet_csk_fastreuse_first_bind(struct kunit *test)
+{
+	const struct inet_csk_fastreuse_param *param = test->param_value;
+	struct inet_csk_fastreuse_cache cache;
+	struct sockaddr_in bound = {};
+	struct socket *sock;
+	struct net *net;
+	int ret;
+
+	net = inet_csk_test_create_net(test);
+	sock = inet_csk_test_create_socket(test, net);
+	if (param->reuseaddr)
+		sock_set_reuseaddr(sock->sk);
+	if (param->reuseport)
+		sock_set_reuseport(sock->sk);
+
+	ret = inet_csk_test_bind(sock, INADDR_ANY, param->port);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kernel_getsockname(sock, (struct sockaddr *)&bound);
+	KUNIT_ASSERT_EQ(test, ret, (int)sizeof(bound));
+	if (param->port)
+		KUNIT_EXPECT_EQ(test, ntohs(bound.sin_port), param->port);
+	else
+		KUNIT_EXPECT_NE(test, ntohs(bound.sin_port), 0);
+
+	cache = inet_csk_test_read_cache(test, sock->sk);
+	KUNIT_EXPECT_EQ(test, cache.tb_fastreuse, param->fastreuse);
+	KUNIT_EXPECT_EQ(test, cache.tb_fastreuseport, param->fastreuseport);
+	KUNIT_EXPECT_EQ(test, cache.tb2_fastreuse, param->fastreuse);
+	KUNIT_EXPECT_EQ(test, cache.tb2_fastreuseport, param->fastreuseport);
+}
+
+static void inet_csk_fastreuse_existing_owner(struct kunit *test)
+{
+	struct inet_csk_fastreuse_cache cache;
+	struct socket *sock_a, *sock_b, *sock_c;
+	struct net *net;
+	int ret;
+
+	net = inet_csk_test_create_net(test);
+	sock_a = inet_csk_test_create_socket(test, net);
+	sock_set_reuseport(sock_a->sk);
+	ret = inet_csk_test_bind(sock_a, INADDR_ANY, 40000);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	sock_b = inet_csk_test_create_socket(test, net);
+	sock_set_reuseaddr(sock_b->sk);
+	sock_set_reuseport(sock_b->sk);
+	ret = inet_csk_test_bind(sock_b, INADDR_ANY, 40000);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_PTR_EQ(test, inet_csk(sock_a->sk)->icsk_bind_hash,
+			    inet_csk(sock_b->sk)->icsk_bind_hash);
+	KUNIT_ASSERT_PTR_EQ(test, inet_csk(sock_a->sk)->icsk_bind2_hash,
+			    inet_csk(sock_b->sk)->icsk_bind2_hash);
+
+	/* The sole address bucket already owns A, which has no SO_REUSEADDR. */
+	cache = inet_csk_test_read_cache(test, sock_b->sk);
+	KUNIT_EXPECT_EQ(test, cache.tb_fastreuse, 0);
+	KUNIT_EXPECT_EQ(test, cache.tb2_fastreuse, 0);
+
+	/* An incorrect reset to fastreuse=1 would bypass the conflict with A. */
+	sock_c = inet_csk_test_create_socket(test, net);
+	sock_set_reuseaddr(sock_c->sk);
+	ret = inet_csk_test_bind(sock_c, INADDR_ANY, 40000);
+	KUNIT_EXPECT_EQ(test, ret, -EADDRINUSE);
+}
+
+static void inet_csk_fastreuse_new_address(struct kunit *test)
+{
+	struct inet_csk_fastreuse_cache cache;
+	struct socket *sock_a, *sock_b, *sock_c;
+	struct net *net;
+	int ret;
+
+	net = inet_csk_test_create_net(test);
+	/* Make both 127.0.0.1 and 127.0.0.2 local to this test namespace. */
+	rtnl_lock();
+	ret = dev_open(net->loopback_dev, NULL);
+	rtnl_unlock();
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	sock_a = inet_csk_test_create_socket(test, net);
+	ret = inet_csk_test_bind(sock_a, INADDR_LOOPBACK, 40000);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	sock_b = inet_csk_test_create_socket(test, net);
+	sock_set_reuseport(sock_b->sk);
+	ret = inet_csk_test_bind(sock_b, INADDR_LOOPBACK + 1, 40000);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_PTR_EQ(test, inet_csk(sock_a->sk)->icsk_bind_hash,
+			    inet_csk(sock_b->sk)->icsk_bind_hash);
+	KUNIT_ASSERT_PTR_NE(test, inet_csk(sock_a->sk)->icsk_bind2_hash,
+			    inet_csk(sock_b->sk)->icsk_bind2_hash);
+
+	/* B creates an empty address bucket, but A still owns the port. */
+	cache = inet_csk_test_read_cache(test, sock_b->sk);
+	KUNIT_EXPECT_EQ(test, cache.tb_fastreuse, 0);
+	KUNIT_EXPECT_EQ(test, cache.tb_fastreuseport, FASTREUSEPORT_STRICT);
+	KUNIT_EXPECT_EQ(test, cache.tb2_fastreuse, 0);
+	KUNIT_EXPECT_EQ(test, cache.tb2_fastreuseport, FASTREUSEPORT_STRICT);
+
+	/* ANY would wrongly admit C despite A not having SO_REUSEPORT. */
+	sock_c = inet_csk_test_create_socket(test, net);
+	sock_set_reuseport(sock_c->sk);
+	ret = inet_csk_test_bind(sock_c, INADDR_LOOPBACK, 40000);
+	KUNIT_EXPECT_EQ(test, ret, -EADDRINUSE);
+}
+
+static struct kunit_case inet_csk_fastreuse_cases[] = {
+	KUNIT_CASE_PARAM(inet_csk_fastreuse_first_bind,
+			 inet_csk_fastreuse_gen_params),
+	KUNIT_CASE(inet_csk_fastreuse_existing_owner),
+	KUNIT_CASE(inet_csk_fastreuse_new_address),
+	{}
+};
+
+static struct kunit_suite inet_csk_fastreuse_suite = {
+	.name = "inet_csk_fastreuse",
+	.test_cases = inet_csk_fastreuse_cases,
+};
+
+kunit_test_suite(inet_csk_fastreuse_suite);
+
+MODULE_DESCRIPTION("KUnit tests for INET bind reuse caching");
+MODULE_LICENSE("GPL");
-- 
2.52.0

