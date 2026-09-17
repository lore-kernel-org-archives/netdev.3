Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A33921C1
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685122; cv=none; b=RqNMB4iyow7g/dBWd0Za5EU/gE+giiSybxYm8ouSggpVWCSIg0O+andBnGqUHmp7u2x7BEBM4hKk4p1fcQxL2r3h9qFjjfIV710g8sQjkd+sZ9GeL3hgh5CG0vPxsqtKiqVZ65vKRrjuVgO1/Uz2VFhjUhtRfGF1pIqqVD5ir40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685122; c=relaxed/simple;
	bh=ByNVme2n1YIrWNZOiFK9pNsKeYC3XAo0/8a2iUQH42g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScAsZcU7tMARHWiVmvXeMHrwg7m7eU4R7JUYR1YRAEknw8qgNcy3+Dc+uI+Jbtt3TqF7pSecXf7S+USzVxgIozwWzVg/RRXOQx9ImBZnLxbijhkRJXmjOCjVWxkfG6AHdyFHXHD+myZ1yB/xVyA9auLhel1uGbRPGro5tyyGb74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ts3xFlDA; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ts3xFlDA"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6b1ae6b2010so80707eaf.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685119; x=1790289919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OR6BZf25moQTcEwWthRT++90nK2WUH6jPtrZrKwJB6Q=;
        b=Ts3xFlDAW90foZVXeSmhNLXT5Yz5pMLP9JETzLiHrz8Frn6DpTvYktChbBEv8IGXy/
         pBVWt8BvUQRF1M4UJhz/D4wndSpthLteDK75fL+3gbzS3qo5SzMtMyDse2+AgZYtoko+
         yFPN7K6SfQM32Sb3Ys7z2UQLQO8s2/0bcWTTdbv37BHYdCCCHyhwMP1+483WoPRfHM9q
         gCVfRIsUZYXDTFsWjh3NOLeQif+LIsX/Ochs3Mlt1wt9XmwS9qCQ/Q9bd7x6S5C4uhVv
         9wQt6DInKw3KRHOf0vTR7T9lwW2cVTZD9fau+JPcyO5SzfKnwcumaJdJ3I3pQ47+BHOB
         /+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685119; x=1790289919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OR6BZf25moQTcEwWthRT++90nK2WUH6jPtrZrKwJB6Q=;
        b=o41U/hQVhbO2auyZPe+1Kl7X7K4p4SR5ojo0O+h/tRukB4V+Pbz0C0x6B309amGGNs
         Ufwii4MyoatxgqgC45wLJpMz4zc410Z/vky+1iWDfKleIgQIQlvfSnyrhtHV7qw2C5ti
         eDoHGYZHJlgacwXTZHFdh/JGuWxALmdSfIoCcuFIUf21MiDxFRMNOD4X5VbLBvd8V2+r
         YkTHZttMsK/XblgVaBNTlNtyqZzpqoTYmAA99MrxKnL54p90TKEqDPFguKEhSKPX0P/t
         PADa4Ty3E4IWUNelGDeoArI5zeR/f/q/kmu3rEdwjhnbZqzmXTNXIp+wjknWqHZO5VUY
         bAwQ==
X-Gm-Message-State: AFuF++lUUZoOAQZFypveOD1H9AqRDeJre494LXbs9Xn9oeZk3gnMLf70
	ztTvRdRgdbe8AaO418KTLvAJJQqgdT5TcPOmM2byEO05ptutdvEBn7wq8qo/1zdjh1z5m4fgH6C
	45JUIqTtRUr8+wA6HO6EL6oyklcXnz66o1aI3VObCHY5Nax7M/Oap6lJLXpI0QEVFpQeiNQQCwc
	CpHh5GZDbW74XgLDqMCP/1PHhGiCSlqwQy+LmxfwpHEskkd3c=
X-Gm-Gg: AYBFou0O543cIke9eg9BOOhAII4UJd9arGD9uVHWZOCDO9yTgfA9WvahfLbpm6PoNOg
	Nr/peAmcdsnavWRcGWh0S4mikMB/JG6tus7WVigxUM+8rqgDofc7HmpRVZWKrHB2BVu5c6aoFI8
	Bw5slh2hDw7PRMV9luUVnkfceUw+u8LQHAjRB5N3dCnpvu6vZnggkhWTe+ajpGqTc670CK7XOrT
	i3b62klOuvBLdqfw3bSEfd+rsr15QwG4cxMvEJnca+Xu0436urbLBWUO4mV49F+ifm+3dyneNsp
	uKYYW7il1EOYlHjSZ8d+4zEcR1JC7xI0nO8zttwYvvnEH3FijZhITMS9EVrmmOcNty6v5XQmqc6
	9hwYGI+E9MjU9KeGr5nkmDSyTOq0WYcK3CTENGY8jTAGxFEMvno95jHvsylW742AttzqlTeaWcX
	kKe8JFV4cycH88EuqardXmuX77g033+hq7GrTe65VB3U1U6yXO+3X6QHqufY35ddz7lEoUsTy5q
	SXf3aHHg2Kk4FbEt0QkRN+Vnde5s1qEmKhpl8m/zdyB0YpOz7jSMl6mChijZBx5eu85+cNYeKf3
	j+Nv+bH/D92PNjYDHrnE+KTSNvKQsDBevy+lzKQqnFJw2fHoxOTWqOYy4BCNxxIihLYBBe4zBlL
	GvgYwFoHfwhwzKwvoUQ==
X-Received: by 2002:a05:6820:f029:b0:6b7:46fa:169d with SMTP id 006d021491bc7-6ca9c84e6admr588976eaf.50.1789685119118;
        Thu, 17 Sep 2026 15:45:19 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:18 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v17 08/15] tcp: fence collapse against rtx-queue tail when write queue is empty
Date: Thu, 17 Sep 2026 16:35:19 -0600
Message-ID: <20260917224355.2288021-9-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917224355.2288021-1-rjethwani@purestorage.com>
References: <20260917224355.2288021-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_write_collapse_fence() marks the current write-queue tail as
end-of-record so a later tcp_retrans_try_collapse() / tcp_shift_skb_data()
does not merge across the fence. When nothing is queued for transmit the
write queue is empty, and the last skb of the current state is the
retransmit-queue tail (its end_seq == snd_nxt == write_seq); fence that
instead. Otherwise the boundary is left unmarked and a later collapse can
merge it with the first skb of the next state across the fence, since
those paths test only the tail's EOR, not skb->decrypted.

This is a critical fix for both TLS device offload and PSP (PSP Security
Protocol). Both use skb->decrypted to mark encrypted/transformed packets:
pre-key skbs stay decrypted=0, post-key skbs are decrypted=1. A collapse
can merge a post-key skb into a pre-key skb, whose decrypted=0 causes the
driver to send the post-key payload in cleartext.

The write-queue-empty case is the common state at the time encryption
keys are installed (tls_set_device_offload() setsockopt and
psp_sock_set_tx_key() in PSP), when the previous handshake or request
has just finished and nothing is being sent. The existing fence is a
no-op there (write_queue_tail is NULL), leaving the boundary unmarked.
A later retransmit of the final pre-key handshake record can then
collapse against new post-key data via tcp_retrans_try_collapse() or
SACK-driven tcp_shift_skb_data(), leaking the post-key payload in
cleartext.

This fix makes tcp_write_collapse_fence() fence the rtx-queue tail when
the write queue is empty, blocking the merge. TLS 1.3 device-offload
KeyUpdate additionally relies on this behavior to keep old-key and
new-key records in distinct skbs for re-encryption on RX.

Fixes: 1be68a87ab33 ("tcp: add a helper for setting EOR on tail skb")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tcp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5e5f5f9b89a3..8c6d90e962c4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2340,6 +2340,15 @@ static inline void tcp_write_collapse_fence(struct sock *sk)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 
+	/* When nothing is queued for transmit, the last skb of the current
+	 * state is the rtx queue tail (its end_seq == snd_nxt == write_seq).
+	 * Fence that instead, otherwise the boundary is left unmarked and a
+	 * later tcp_retrans_try_collapse()/tcp_shift_skb_data() can merge it
+	 * with the first skb of the next state across the fence (they only test
+	 * the tail's EOR, not skb->decrypted).
+	 */
+	if (!skb)
+		skb = tcp_rtx_queue_tail(sk);
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
 }
-- 
2.50.1

