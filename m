Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED73BB12C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617628; cv=none; b=d9GPyUjBxiF1WZ0fV1MkVGVBRjh3ZcdIn2OaacHLuoB82p04v8LwezrfR9wJ41K/urEUeUzcoCTasllDV9gOpZc/I/AcXx1xj+b5mR5HdwbqijB8TJuhMcHPBZYmACl5WkQS8fiWyVi2CuIsQGmhtkdJW9RteeIAMHL1cNxCqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617628; c=relaxed/simple;
	bh=NndGd9GOf0I6NO8Ce3nP+s13O09BbawYzE6kgfvxPZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxkBo+vj/gVjRimujir1BfPIAEi4WPOGxopqHKn3pZDUZp0oAd0ZjAXdhz/XH+UD9jCJ+TGdpNMxGwMgoJhw3cwT3Jb8vBb88zup6gMGtvpqAUzwNtMYWuXKFlGI13p35kjPk2ZUBUeGIozy+4KnBSxWms75VQI5dkol07mufDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPELqpR0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPELqpR0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so2777065e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789617617; x=1790222417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TH7pqPWttSJGp/Lqeiet7/X4Ui7u8p69YinbdJusLhk=;
        b=qPELqpR04YALqjxUxYX27T5X6LbKk7qrq2qS4kGgGTQpyIJTtjUNQOrjXzVat2nJR7
         cvWbz/2JETY+eWMI5n/cGRtA4oVq+IorawxoFFcbvWCN/QgnI/Li/oJW55jlXl2wrhsV
         twyuzaKIivXO3EQQKVwb++qJFll81qA36yH9L8JeqFXW2mWXBlpS4CfuM5scboFuWneB
         EILTypVnyiaTrh/ZsQTpCGdE44iHP7oDfsclJ68X+avzaBrYLMBQ9PUXJCl2SNk4US4j
         p82EAspswa8ms4XxoRVCeSJ+NciuPPSlw3ClQAN6/sdvk+qGCMttXAnsmbCdz0v8xi83
         Z1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789617617; x=1790222417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TH7pqPWttSJGp/Lqeiet7/X4Ui7u8p69YinbdJusLhk=;
        b=XRA/MjUTM8Y/bP/Wsq3etlz7wtFpV7t6hxkCSuww03SIHspPAScAlw3nlJj1LHQ73o
         RbwFrgKC+y5/IAu1fCVdCHyiVo2ebHwzrIWjtp+ECpUbSRCqqdG65Iz45HHuaTx+nMpv
         9trdjeZnPvuqakas+dRmdwtJMaVwQV3QEQOzB6AsNSwd4Sv0hJEdkRUK7LDRDillMFGm
         x8Anc4TZQWaVgJ0dO9xaki71G5tGHzjhtMUT+qTqDuCpgj0BZI91TZGQVE/LyedK49f8
         8szivgpjCBwRc8xNZe67t6qfhl6+k4XtAMu3sPTtKgTtagPAuQohUPduZJ290vt2+17s
         BL/g==
X-Forwarded-Encrypted: i=1; AKwUvByFHzZMFjV2EKl12GRwCUPLc/VDN5GhSW54jxy8vL0Tybq3Imw347ipoZz5Dj60JJM72ZFA5Ho=@vger.kernel.org
X-Gm-Message-State: AFuF++nbtes8tMzbrsdvgEHe6fpWr41x49R6HfLb6e44mp8FI/R9ffoF
	Dz8luyZH7ePGqLtsYG5WnPxQ/ySop8LD3y5AmjF9mjMuCsjrpr4WKybX
X-Gm-Gg: AYBFou27Ekkz0lhh1jyANWHZZbxS5oP0peYvTwWCySga016oEwInmrSoyU73iROG38B
	JmogUj0kSLGi/vm1PH0EkImfnho7l0RJ2a6b/eT9VsjNmS2I/EmJJHIS1/GhdjRDNBD9wxH+0Rc
	sFwS7pD48dc4uWyiB+SRw6nNbkciECosfvAxAduBxOJFU09wrz6ZUjVne3COyupkiJ7dnRqx66s
	+u6wcK4752DuccHyZ79nwfGQukb5YcGT+IWlY5PCzwd1V4FC/cUDiKnLDJd264eh3R2hiy3w7Xn
	9YpKMzDKaCZA4NDL1oSMOJzKDHV8Pqo4BB8AYqlrGz9rt38La66iAbqA/4J3d2Bw8YgUq/M2Ngb
	Bqi9It5IjL7kuCeJ01gXE/IyqJYzFQxp5ry3pYQ2mfaJ5dB5vORVf9RRoKvE0/oKSq7E/Ig95kX
	DBQdGRNECzNrnAPf+BzuXoSaBZd5XHVil6huXSbM2YTHTgzzFdz7X555O8zVeuKq3SsarRWIYZT
	vxBNZXvF3gqMSU+YghL+BC9Qfon9LOrW0MFimpGX2fykc5iSzLJgf2rQ/JaGmd5QnNOOgryVkCX
	TdmDNyxGBFQQcNavlu4B5/iof4HmrL0b48JGTUTBHplMH2RDtuChpCCIztLuSjQkCHvTFikqdc3
	T
X-Received: by 2002:a05:600c:83c8:b0:49d:28c4:b304 with SMTP id 5b1f17b1804b1-49eb7341406mr52441125e9.29.1789617616894;
        Wed, 16 Sep 2026 21:00:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9dc6-c001-54ee-4741-4927-0a28.310.pool.telefonica.de. [2a02:3100:9dc6:c001:54ee:4741:4927:a28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbfd935cfsm6880015e9.0.2026.09.16.21.00.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 21:00:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	eadavis@qq.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	pav@iki.fi,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Subject: [PATCH 5.15.y 2/2] bluetooth/l2cap: sync sock recv cb and release
Date: Thu, 17 Sep 2026 06:00:04 +0200
Message-Id: <20260917040004.21041-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260917040004.21041-1-kmehltretter@gmail.com>
References: <20260912065526.833703348@linuxfoundation.org> <20260912065546.976652519@linuxfoundation.org> <20260913202907.3100-1-kmehltretter@gmail.com>
 <20260917040004.21041-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 89e856e124f9ae548572c56b1b70c2255705f8fe ]

The problem occurs between the system call to close the sock and hci_rx_work,
where the former releases the sock and the latter accesses it without lock protection.

           CPU0                       CPU1
           ----                       ----
           sock_close                 hci_rx_work
	   l2cap_sock_release         hci_acldata_packet
	   l2cap_sock_kill            l2cap_recv_frame
	   sk_free                    l2cap_conless_channel
	                              l2cap_sock_recv_cb

If hci_rx_work processes the data that needs to be received before the sock is
closed, then everything is normal; Otherwise, the work thread may access the
released sock when receiving data.

Add a chan mutex in the rx callback of the sock to achieve synchronization between
the sock release and recv cb.

Sock is dead, so set chan data to NULL, avoid others use invalid sock pointer.

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Karl Mehltretter: applied in the form this commit has after
  f1a8f402f13f ("Bluetooth: L2CAP: Fix deadlock"), that is the
  chan->data clearing in l2cap_sock_kill() and the guard in
  l2cap_sock_recv_cb(), without the channel locking in the callback.
  That locking is what caused the recursive chan->lock deadlock.
  f1a8f402f13f removes it and moves the lock to l2cap_conless_channel(),
  which the previous patch does here. l2cap_data_channel() already
  obtains the channel locked from l2cap_get_chan_by_scid(). ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0b51c3e0f469..bef6a948d7d5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1237,6 +1237,10 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
+	 * sock pointer.
+	 */
+	l2cap_pi(sk)->chan->data = NULL;
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1519,9 +1523,13 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
+	struct sock *sk;
 	int err;
 
+	sk = chan->data;
+	if (!sk)
+		return -ENXIO;
+
 	lock_sock(sk);
 
 	if (l2cap_pi(sk)->rx_busy_skb) {
-- 
2.51.0
