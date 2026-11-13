Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564676;
	b=2yyjgyETabnpMZdKaKeWLK88pdheDVgGPW0ARPaABhrUjo9rTd5UgT9KPbzzZV94FSMy
	 JW2JHASwn80WakHlz3xS4Ro03PinoPQx/r4B/j05Rt6DU2jzjUBM/7m8kA+9p6L/CYBI8
	 +uhj/1SypJH92sZvamYWaN7DXdXv+ZrLYMpq2etHFN5wvmQaxBj3lGr3VVCj/r+PIdk0Z
	 lYJGFa+a7seck+YcnVlI5+UBHTfCJ5ZaTEGqpfXJZLss9A1W19I8kzSEEAk2xUZ4/d7rN
	 EbdzO6a3ARn0kLHFby2kFZQCdiY/GNAG6MURfJ1Sg5FYWfFY/1AAQBiroCJLXlm1Ogg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z5RL1Gs6qBWGEalLbjFuinE+mo9K4/ly08HuaMSPvVI=;
	b=BNoaXYnStqfhKsXDRkFg4nG8l15VOQF0qc3efFi6E8VQhhguxV15H/Ky5uRgtmy+JR+4
	 AaFhFMxIUAgLpxZP2OaswAz16BoOyQcO3HV0KI1j6ioeDaCKdTyrc0w4jWPqF4Ikcxp26
	 X7/vNXV8FbU+qyGVYGA6D1WUE2Ju+E3KX8hPZzFSa3i1TeLIykerKVrsiQZr4kdsiRx/I
	 r9Di1WIJkguiGCe95gimQ+Vbqu/AnD81GoSRGZJTsLUkHXqfHp4t9imf4IJXDIRDRcU5Z
	 HsjQIAjwZgm1zmMpNwqPgg3usmKUIUDxwDuApUb8dWLw/SmNuNAimZceLRF9WBeptFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axwNFDjK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A8606A31C;
	Fri, 13 Nov 2026 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axwNFDjK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBE51F000C4;
	Fri, 13 Nov 2026 10:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564676;
	bh=z5RL1Gs6qBWGEalLbjFuinE+mo9K4/ly08HuaMSPvVI=;
	h=From:To:Cc:Subject:Date;
	b=axwNFDjKra/n9fGQ6DitqiUJGJUTfTwNUpSzMjBM7UCepgbrgCqOsJYiF7/GeIVxy
	 UZqGu0peJSmnZ6+Lw9UIWBt89YUmE3uySjtUdbt8rBY9ZELWMnYjo9Qkkznnq5jjL0
	 JMXi1uyP6kjxGwfWfVb+pdfrWazOF1Bt7C1X2YNM1OcBn2Y4jImDZCk0ihBilqsUgA
	 lFqBJYenW5MRpc4fAmhG660z9GNs6L2OuuHqRtPBsVsagkBgTH+c/QsYn43tPFzoir
	 9NqcZ7Bhhq1Vq+i4hDEAeNCH/W945br1IDrcqI7ob8bmERm9F/u1vnHllz9qPEEbPp
	 MXctHNnE0BuuQ==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Wang Zhan <wang.zhan@smartx.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: kunit: move struct net_devmem_dmabuf_binding off stack
Date: Fri, 13 Nov 2026 11:11:00 +0100
Message-ID: <20261113101109.3227815-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
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

From: Arnd Bergmann <arnd@arndb.de>

The net_devmem_dmabuf_binding structure is really way too big to
live on the stack, and causes warnings on my randconfig build machine
with a reasonable per-function limit:

net/core/net_test.c: In function 'netmem_ref_test_tcp_devmem_recv':
net/core/net_test.c:1720:1: error: the frame size of 1744 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
 1720 | }
      | ^
net/core/net_test.c: In function 'netmem_ref_test_skb_segment':
net/core/net_test.c:1477:1: error: the frame size of 1584 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Since the binding object is never used concurrently in multiple tests,
avoid this by just having a global copy of it and reinitializing it
for every user.

Fixes: 2285346afc99 ("net: kunit: test netmem, page_pool, and skb frag refcounting")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I don't particularly like this workaround, as global variables are
always hacky like this. If anyone has a better idea to avoid the
last stack structure, let's do that instead.

Without the patch, I run into this every few randconfig builds,
which did not happen on linux-next before the merge window.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/core/net_test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 976d14896251..19f422300d9c 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -984,13 +984,14 @@ static void netmem_ref_test_pp_page(struct kunit *test)
 #endif
 
 #if defined(CONFIG_PAGE_POOL) && defined(CONFIG_NET_DEVMEM)
+static struct net_devmem_dmabuf_binding binding;
+
 static void dummy_percpu_ref_release(struct percpu_ref *ref)
 {
 }
 
 static void netmem_ref_test_net_iov(struct kunit *test)
 {
-	struct net_devmem_dmabuf_binding binding = {};
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.pool_size = 4,
@@ -1003,6 +1004,7 @@ static void netmem_ref_test_net_iov(struct kunit *test)
 	long base_ref;
 	int err;
 
+	memset(&binding, 0, sizeof(binding));
 	err = percpu_ref_init(&binding.ref, dummy_percpu_ref_release,
 			      PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
@@ -1145,7 +1147,6 @@ static void netmem_ref_test_release_data(struct kunit *test)
 		.nid = NUMA_NO_NODE,
 	};
 	struct sk_buff *skb, *clone1, *clone2, *ext;
-	struct net_devmem_dmabuf_binding binding = {};
 	struct net_iov niov = {};
 	struct page_pool *pool;
 	struct page *page;
@@ -1154,6 +1155,7 @@ static void netmem_ref_test_release_data(struct kunit *test)
 	int base_ref;
 	int i;
 
+	memset(&binding, 0, sizeof(binding));
 	pool = page_pool_create(&pp_params);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(pool));
 	page = page_pool_dev_alloc_pages(pool);
@@ -1335,7 +1337,6 @@ static void netmem_ref_test_skb_segment(struct kunit *test)
 		.flags = SKBFL_ZEROCOPY_ENABLE,
 	};
 	struct sk_buff *head, *list, *segs, *seg;
-	struct net_devmem_dmabuf_binding binding = {};
 	struct net_iov niov = {};
 	struct page *pp_page, *reg_page;
 	netmem_ref pp_nm, niov_nm;
@@ -1343,6 +1344,7 @@ static void netmem_ref_test_skb_segment(struct kunit *test)
 	long base_pp_ref, base_iov_ref;
 	int base_pp_page_ref, base_reg_ref;
 
+	memset(&binding, 0, sizeof(binding));
 	pool = page_pool_create(&pp_params);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(pool));
 	pp_page = page_pool_dev_alloc_pages(pool);
@@ -1634,7 +1636,6 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
 		.nid = NUMA_NO_NODE,
 	};
 	struct sk_buff *to, *from, *clone;
-	struct net_devmem_dmabuf_binding binding = {};
 	struct net_iov niov = {};
 	struct page *pp_page, *reg_page;
 	netmem_ref pp_nm, niov_nm;
@@ -1644,6 +1645,7 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
 	bool fragstolen;
 	int delta;
 
+	memset(&binding, 0, sizeof(binding));
 	pool = page_pool_create(&pp_params);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(pool));
 	pp_page = page_pool_dev_alloc_pages(pool);
@@ -1766,7 +1768,6 @@ static void netmem_ref_test_tcp_devmem_recv(struct kunit *test)
 		.pool_size = 4,
 		.nid = NUMA_NO_NODE,
 	};
-	struct net_devmem_dmabuf_binding binding = {};
 	struct msghdr msg = {};
 	struct dmabuf_token token;
 	struct dmabuf_cmsg *cmsg;
@@ -1780,6 +1781,7 @@ static void netmem_ref_test_tcp_devmem_recv(struct kunit *test)
 	long base_iov_ref;
 	int ret;
 
+	memset(&binding, 0, sizeof(binding));
 	KUNIT_ASSERT_EQ(test,
 			sock_create_kern(&init_net, AF_INET, SOCK_STREAM,
 					 IPPROTO_TCP, &sock),
-- 
2.53.0

