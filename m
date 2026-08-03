Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370D288C30
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742468; cv=none; b=k4e++FSTSnVWMqWMBHT8pfbFsFU1CKBnhhPoslJE67+VUANNwYIlse9RRrOOOQdeImWJEDn6szrWNrxx8KUDd9e1aCfojdRWBbW0WJfQA8+eD3F6t7ra9iS+7WVwGEGcf4W/Zy4KQ2FRm39qgpSduIVdCasPUYTeHeO5/mMPw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742468; c=relaxed/simple;
	bh=SlD5lR1aIvJRJc4FywWIzTLHOW2kSU8TeeUrEUHNB5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kni1ArqFnwVFv38pLq5tB0zD4JB8PPgZIqppuIuChoGA8dxmd81my/nMWdY/5X6N/7vE/qXr+VqAjnvXgggmUjlswmq0hHhF0PoBrIujw6AmRDdQu0e9iOlq85CTaXUiiEyCd8kxk4iXPqRrKHgd7AQvO3MNmqJfsZxx0CTEz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7u9xp8M; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7u9xp8M"
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6acbe402385so787562eaf.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742466; x=1786347266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfeuwGJyq2Vxzfo2kOM1yuG2Ob6x8BTRxw3KWGoeGBQ=;
        b=A7u9xp8MBPcsAKMD3ZMvZ8iPmR64ohUX9KlXDcDhqz1RSDxazJWUqqmb+cCZnJmcaM
         Z/TPsJRucdvqgMnNetwo+FPXtS43jWL82tmISsdDTOUZKj1M17uvGLiZTc2bDKvIxGgN
         WbCiJl4YRnUuuBq2Uq9S2KRkpi/pKR5WRmQs6I/Y+qhgX2oUnPKhZiN3L9xRhEKIAAyb
         EJxXvZ0v5p0tUyGetKdz6wEyYx+guxZwnAEnyMhXUhv3uOSdT5qSr6qOLqAyd18CniOh
         NGL8b9AjKD3bXNE9fGksDYgBBZAfmpvw/9Lirr+tf/fkakq0wQKTUW9S79m2WBApzACM
         mwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742466; x=1786347266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfeuwGJyq2Vxzfo2kOM1yuG2Ob6x8BTRxw3KWGoeGBQ=;
        b=rukdbBayVu9d2GKD34a/6a4fih1uyhPw8VMRU4Q+YeErPkpbiq4S+VWbGctA+mGeaH
         XrPCCP50G83Bh3360a+3R7IGtGWVIjxFvCZylgxqlL7QcjOs0/t6v/5YDjGu8va5v+r9
         La6hjIZ7OZge1WHYrbo3Rh26iB2TM7cnWoxHq1Md0OS0vCj83IQKQ2/wIeiEBwDPxuud
         lMpg3FwB5ivfBrWekUPHtLHQQdX3nAJjhH/dJ4u8y49HLuRa05dHaYfOLk1wRSGVaYHs
         QJZQvmQNoD4oy1cbs2WnnYOw5f+eYOS1Ezq8mNY+m2eSH38QaQdiiL11BOFOGjWBShe8
         H2zw==
X-Gm-Message-State: AOJu0Yy/Byn4vmz0wr3AmpekWzWIk8ADRFse8ycZybPYO/tPhbWxbEqt
	1WRBwqE5KwvXP3HsBOpevDms7vWVGF8jTmQSjbnr1Ib06rwTdK3vKWDvr5GlkWeP3lIXlg==
X-Gm-Gg: AR+sD12xkuvMMzulz+g+O84NmIjdUgKvXwTwiwuJaSBkK3zcNF5uZUsyUBOmV1TARge
	b1sLuM92P6u4oMMknMuIQSuc9Y3dQt1h61Jc+nzf/Q73cOQ5Ww0XppnzvNjypZrAqeIZzCc7PnF
	BHuy373RkrmFVcUjFtwVSyFbCHUELpfziqsFYYJfzPa+0TG27oJUrTJt2L4PE41cJAw0UWTABV5
	z/BWdSTpSq/I7QbAtj2Ldj++Pv6XsNuExHP7cDSLP44S9I21M8VnyaceNKWpLqOCfaJOAUs45Sq
	sv+JrAJkVtbeyxNT31MFzjWwExmBVRFphYLRsgfpeREGAZZEsJAyNPwda2fpMDiBSuqchEm/kSf
	U6FjT5Xw0U0Wa157npwRsc+q0nO5e6BSmFL+QLcmHnJ26zYJQN1lMdiD8oo3E4s7Pdky41WDKZT
	DrCbeu0LfWFSynAirVJaoOotaDVr6WhUpxzU4/ZLsTh1jlojKy7FhruJB1zzdp8JZUf3/BK+He6
	dpSEmtugaIO+yuJFAJDzSoHLw==
X-Received: by 2002:a05:6820:a28f:10b0:6ac:bcd0:7a26 with SMTP id 006d021491bc7-6ae4343946amr9911562eaf.28.1785742465794;
        Mon, 03 Aug 2026 00:34:25 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae39e2f5c2sm6173749eaf.8.2026.08.03.00.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:34:24 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	linux-afs@lists.infradead.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH 2/3] rxrpc: wait for deferred conn destruction before conn_proc_list check
Date: Mon,  3 Aug 2026 15:33:54 +0800
Message-ID: <20260803073355.3895949-3-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260803073355.3895949-1-bsdhenrymartin@gmail.com>
References: <20260803073355.3895949-1-bsdhenrymartin@gmail.com>
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
