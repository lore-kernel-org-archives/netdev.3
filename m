Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F13BFE38
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787464435; cv=none; b=i5nx9q8D6HkHzYz99YDvxoH1gDlsFFXvIeXhgie/B1oRew8SZ0WxComUIsO4zs7dZ3Tl8LxO1CmDutrm/OiD7pZxAIq59mjmssnYW6Nu6P8wSXaXLQqx8Bz6nGsbL9R4AnyjVc4KymJqJpJbXxmn0qw5jhiGx8D8vyhdseC+37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787464435; c=relaxed/simple;
	bh=SlD5lR1aIvJRJc4FywWIzTLHOW2kSU8TeeUrEUHNB5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Or931jW/G2IO3AJdxPrrAqKFtuhG7tlYG88XS0gylTEemRPu9QIn/0K61e3JItGSFIoiyecvbZFPykTRd+uKEK+5oIWLdjlScpdtI9GSg4+a0XXl0e5v/gcVegtY+nDsu+uu+Zxs1DA0vUkk2tqEOZg+hWiCJF9r6tdwCI8anbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jwzv8lvY; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwzv8lvY"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-45e2c1e33e1so1762581fac.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787464433; x=1788069233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfeuwGJyq2Vxzfo2kOM1yuG2Ob6x8BTRxw3KWGoeGBQ=;
        b=Jwzv8lvYOMyOw4XHSl6WGHODSjHZfBVbizNwqnfXeQSmqc0etfG09JEAbZV/Uys801
         XqM90y9+gc6C5TMp70L4OiTIlfwEhr6OXb2a7tPch6GynNct8gE3uHlIvj5hpFl90kCJ
         3EmFIz+wZb6m4UvblVVcVHd6j+mSs3M5WOlb5HdDX4pwkSH5+eP5gfApv7uBooD+40nh
         mGNaBd+VBo4fkLnfB7BAD7e7ke1+2Io97hj0uRBFXxniKzyu/tu8nQHt2Ig29Z05XnMt
         CtHN0ZEiB2crQIpqalspxytH28P3xjTwTgspdhjLYo3ZQWI4BWfWuVgznsIntducxb0G
         k9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787464433; x=1788069233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfeuwGJyq2Vxzfo2kOM1yuG2Ob6x8BTRxw3KWGoeGBQ=;
        b=cmycnErrLCtWgp/Wywez1Bi1SzijHcE9VMYd4Cqem72yK1u/5ZRYbxOoMZ8gD9FPc3
         tkMxc17FwTo0iVpw0s5GlSl6r6/Utfat91QZv5Ylt+MWkVbthyj5gFVaaNv8glBPaKK/
         vqWBwX0wcmyfRMrFUk1bmVlabysvJOfkRT0PN8ZopI6/arbyNy6ajgY1jpkA4qeV7neE
         5BRfzMs122MKxUZvjm+IiDrZYdTk/Tyys1bmvahBqD6+97ZbKEj0jW2DGB+sb/MCYEPG
         WGFvfnTKYHaNmI8ckxGUcB0aMsmMPIH0Pl90SkiAoQ0GtpmL4Iy/K3WeJ5C4y/OQcPWP
         HD0g==
X-Gm-Message-State: AFuF++lyqWX6F1oVVoPIRvD6jagx006Zin6Pt31mFY+rveUfLuhUGYj/
	4+oE5v0z/o9y+SGDf9S7TSygEJ6YTevXaIBJBXRLDjoPiNHa+Pps5V5vYNO+01IdJBc=
X-Gm-Gg: AR+sD119WrzaScFfafAdrlUbeezUVqbJv58fR0neT5V1jIbYxojeKeusBzB1HFFzxwA
	WDCMGC2FsvZSUFgHoNwfTU/eJi+5MjH6keTDPZPhT6q+tqznfXWR9X8lirKvaKfaeg71Pm/MpQl
	4GGEi9iTGtJKconYh5bmdcu9j9tkmbh2Po8HUIJfinIj1P1tsr8RPADAfQ0BTx9DddCpShtScue
	rVu6CpvZRgljbavPy53QHNtIIpkBMz4BsPJ/EfrZlDj5c2Jfo/uZFE8JT8/+MBytYBvTTw16PAx
	Yj8855q/xxR+Lzgo6bi0iQ/N547usOXX7KTs2hwQLvoo4CLe79JJLieSadlxtZ9buQUWMjnNpm9
	aOjiEo2QtmkNwb9JGeIDj9RB6egxhXCyXteWdIkRSb9n301tHAuKJ+slUIGnZK/Cyx9BmYnUPzM
	rzvnWF/BeXMrEgkJY8DKDlatjr+qy6VuIQSnWQOV/R+zMQsHgfb2HVZEKgpRfRH6hYF2ZfiaRuT
	mogY3ng0Msou1T76FBQGBsryA==
X-Received: by 2002:a4a:ec4b:0:b0:6b1:3cb7:f535 with SMTP id 006d021491bc7-6b158fcbe26mr18729841eaf.0.1787464432934;
        Sat, 22 Aug 2026 22:53:52 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4638313340dsm2791832fac.2.2026.08.22.22.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 22:53:51 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH 2/3] rxrpc: wait for deferred conn destruction before conn_proc_list check
Date: Sun, 23 Aug 2026 13:53:17 +0800
Message-ID: <20260823055318.371374-3-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260823055318.371374-1-bsdhenrymartin@gmail.com>
References: <20260823055318.371374-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_destroy_all_connections() flushes rxrpc_workqueue and then
immediately asserts that rxnet->conn_proc_list is empty. However,
connection destruction is normally deferred to system_wq: the
final-ACK timer is still pending when the last ref is dropped, so
rxrpc_put_connection() schedules conn->destructor instead of running
it inline. conn->proc_link is only removed by the deferred
destructor (rxrpc_clean_up_connection()), which the
flush_workqueue(rxrpc_workqueue) call does not cover - so the
assertion can fire on a perfectly healthy intermediate state:

	rxrpc: Assertion failed
	kernel BUG at net/rxrpc/conn_object.c:488!
	Workqueue: netns cleanup_net

The BUG kills the cleanup_net kworker mid-teardown, leaving the
netns half-destroyed and potentially wedging later netns operations.
This is easily reachable from an unprivileged userns+netns running
loopback AF_RXRPC traffic.

The existing wait_var_event() on nr_conns is exactly the right
synchronization: nr_conns only reaches zero after every destructor
and RCU free has completed, which implies proc_link has been removed
from every connection. It is, however, placed *after* the assertion
it is meant to make reliable. Move it between the service_conns
leak check (whose outcome is already final once the reaper has been
flushed) and the conn_proc_list assertion.

This also silences the spurious "AF_RXRPC: Leaked peer" messages
seen during netns teardown, which share the same root cause: peer
references are dropped by the same deferred destructors.

Found by the autokbug dynamic kernel fuzzer at Tencent Yunding Lab.

Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rxrpc/conn_object.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db0f85..df3f92b1a42e9 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -485,11 +485,13 @@ void rxrpc_destroy_all_connections(struct rxrpc_net *rxnet)
 	write_unlock(&rxnet->conn_lock);
 	BUG_ON(leak);
 
-	ASSERT(list_empty(&rxnet->conn_proc_list));
-
-	/* We need to wait for the connections to be destroyed by RCU as they
-	 * pin things that we still need to get rid of.
+	/* Connection destruction is normally deferred to system_wq because
+	 * the final-ACK timer is still pending when the last ref is dropped.
+	 * Wait for the deferred destructors (and the RCU frees) to complete
+	 * before checking conn_proc_list; they remove conns from it.
 	 */
 	wait_var_event(&rxnet->nr_conns, !atomic_read(&rxnet->nr_conns));
+
+	ASSERT(list_empty(&rxnet->conn_proc_list));
 	_leave("");
 }
-- 
2.43.0
