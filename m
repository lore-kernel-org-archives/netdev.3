Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204715;
	b=KStQ32oS8NbUHuygLf7H55asa6wRbIzImX7aYx6wxjVZW5HJUl3HFNEVS8ZGNFY4AXmX
	 092ObP2LMehKqp0nVS9MOe5G1hquZ8v3YxDRv0iyYmddfEhvjDMvApShGAAvEoKoICGPu
	 TDFNL7eCqY2K5gmNt1pXZ4YNn3RRhLF0d9NyeHo4fzTp9QGwrVAri0mrPye6wK6o40cx0
	 ZysOVsk8qWY/whUL+WblpzDr6qaWpthNZfa36MPTnDnEJcfmtM4dPHgoWGM6To8c7hDsd
	 ncnbBOcomE0YwYazceB6ILPROJEPX+5Q5Lq7keNPAL05Ddr6rZiNge8C9NTVntA9uug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204715;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nr8ebwQFBYYb53uHRZdPV3FvCBtaiAM6QgdoRj8eGSw=;
	b=LBgklbkN+ugm46ziG4U60W5qF6tI+2CQQovZZtRL8FMFiEpxRi1+4aVbocD3UZpbvSi2
	 9z+c4tsA7nes8H9OPZ03A06UAFhFI9VH9axYJ2ZhWKDAlXS3Td1sVlLyss3LI/rllDwZ2
	 kQ2RWNiYyohe8rBR56EZz+HTmCsNzdpeKJrSTTb5bHvThTA/gNHOez5OsXCErU1isSsNE
	 MTaj5QnWsaKfHt9SMFv3uiDtY2AtL/TnXI+Kag+6ud25Y33K9aXetERT0mitIyMELHuXi
	 top4o6X24HYV1ZWJqmlQtIEn6MJtDYWQtsRoxx51fUi0mqyrWkh/zQV6ghOGaHtTT8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWz30qJL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E0606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWz30qJL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989CC1F01825;
	Wed, 28 Oct 2026 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204714;
	bh=Nr8ebwQFBYYb53uHRZdPV3FvCBtaiAM6QgdoRj8eGSw=;
	h=From:To:Cc:Subject:Date;
	b=OWz30qJLxMltfO3VsL6upxuRHud8jatnTrHCKLPZIoKIJmP7QrRWufk0QhKb3Duuw
	 Z0b9jbHr55JK/K2+8WcWLS7cSwJBRLbC7Cf45PD/r7gWx0xPEG1k+b/foxiNqjvSek
	 h3O7L0zz05/nnZrTN0iOIWCGF64w2rBC5oKkqc8310qhXLxiaJHDSl9r0cgjb/ThcV
	 Hw6Q//7enRWOekIHd0AgjHT8s2iIk+1ISvamT7iEyqIucWrS3tjBQbKkCnvjPV+sPe
	 8KCoTfjnR7vFJb9lwJzTF1WDdBuVPZYLZgG8mmigKJ0rLEUGhNnK4d2OoVNiZdzU+S
	 mA5j1yyXCIKug==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] tcp: wait for TIME_WAIT teardown before freeing per-netns ehash
Date: Wed, 28 Oct 2026 17:25:10 +0100
Message-ID: <20261028162510.2180528-1-edumazet@kernel.org>
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

From: Kyle Zeng <kylebot@openai.com>

inet_twsk_kill() removes a TIME_WAIT socket from the established hash
before it finishes using the ehash lock, hashinfo and bind tables, and
before it drops the death-row reference. A running timer can therefore
unhash its socket before inet_twsk_purge() reaches it. The purge cannot
synchronize with that timer, and tcp_sk_exit_batch() can free the
private ehash and hashinfo while inet_twsk_kill() is still using them.

An unprivileged reproducer using user and network namespaces, a private
TCP ehash and a FIN_WAIT2 timer triggers a KASAN slab-use-after-free in
inet_twsk_kill(). The allocation and free stacks point to
inet_pernet_hashinfo_alloc() and inet_pernet_hashinfo_free().

Wait for an RCU grace period after purging the whole batch.
TIME_WAIT removal runs with bottom halves disabled, so this also waits
for removers that were already invisible to the purge. Keep the wait
under tcp_exit_batch_mutex, before freeing any private hashinfo.

Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: only call synchronize_net() if one netns in the batch uses a private ehash]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ebe5aa70374a3fd9e3305377efebec3004989945..3f8563a36db1e9ea853699ecb547af7ee9491b11 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3561,6 +3561,17 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 
 	tcp_twsk_purge(net_exit_list);
 
+	/* inet_twsk_kill() can unhash a socket before the purge sees it.
+	 * Wait for such BH-disabled callers to finish before freeing a
+	 * private ehash. This is not needed for the shared tcp_hashinfo.
+	 */
+	list_for_each_entry(net, net_exit_list, exit_list) {
+		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
+			synchronize_net();
+			break;
+		}
+	}
+
 	list_for_each_entry(net, net_exit_list, exit_list) {
 		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
 		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
-- 
2.53.0

