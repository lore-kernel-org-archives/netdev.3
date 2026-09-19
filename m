Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F973363C72
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853342; cv=none; b=a+hX5T9LkAmfX5pyb+/AYES2VOCCgBsYgQ2mzSnR3ezmluaNinSdvjS8kNkW2GMlxFisR7ozphyp8v3UU5Ho9f0zy45xMBR9TDgbgQCNjTl01EqFSgbDiaVtJRb5Z4Tq7BJZNY8fj3xgBam8seBzHCuSn5VOge1UFq+Gf+w6i6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853342; c=relaxed/simple;
	bh=uzB8kYqSwZvvHWdVSonXqwgcJ53XrnKH2GGFgTD34aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osvpMd6rd3Ykutl5tFsXNhQ58tXEUjKa6aNzzAnh1uMyDA7nXajrR2LhUTyZo4t+gCy6vZsIKWcJnR6wwrI0wDBJVGoMIT2w1tEjhJ5LR5aB826YsZeG1I1MUQJwMyNQjDMyY5mbLX6X8xnq8H0TCz3JDZi5aRNahFJWO2Sdhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPgjUUNG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPgjUUNG"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so1852403a91.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853336; x=1790458136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ysTxERdXo3UK3i3xCiazMgzFqeboSXwQYQC9nO77h0=;
        b=HPgjUUNGiawKAiSzn5NHo2pAbh0y4wrQAIo4pyQRcu5yM+e94lVjkXUmgNEMyKQWVY
         Ssyqy+iwtce2U1cw17Q6WxS5la3sM8W3ybY7YQ5R25W5UBE1iuXNLFr6v2bzNrCEwrn9
         RDNsBRm4S875g+dzhKtmLh8DwzizlagHLJm6f47Ad6qptP6LQPmn49WXxf69rDrJCLz+
         eg5G+8icGwvTlIHjS7FJS2MHtKF0a0TgpR/9q+LcfbKmsFsH/kZz1KJmETJQW2ehWGeT
         J1Uqgy37TtyBdbWFbx5ms2+0/BF0PSrsXHYTJMv2DnVg/E1CztbcNY5BsooJAFrByvsb
         E0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853336; x=1790458136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ysTxERdXo3UK3i3xCiazMgzFqeboSXwQYQC9nO77h0=;
        b=elz6x0fttxbsrbHSsnbwPY9J7mzJ5PueSHAD55+Wfb9bvmTQWJ9Vdhj5W0ylSmDRgs
         eiid3dJ65de/wn0/Y5ghJ6YsdUOpUzCrQ6m7TAx+2QVLcCFy9ot0BpNYtYhueJlkh1xo
         6SGcPeRuhqoW1MpqUyQK6JKLN3a7VEUOo5VFZo5qWZSql3lLLlmmlrCSYjtQ/K23YzmZ
         NlYIjPvJjJAJjwRBdu0oUG/IKnWauLU8WDiE5BAsXTelY12V6HoNhNkNGLVFJX0eNKsH
         oMS2GoonIwEgm5UQExaoIfNDiJhew501oTHRGShPLcHODSpc+UkMEJxop0ky21qCOO3U
         OQHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRQCpauiePr3LXlfR2uSNuRci+BVaGbuKg+NeOZ3deOMz/Vluyh/9jlGlQ8THB2XMlLEKlRqY=@vger.kernel.org
X-Gm-Message-State: AFuF++laMg7NcCsbfFq8Q59ohgBs0mN7nEnjtEJ7dnMV9z6YkmXjCXGv
	J29INywCHIhjI/v1W6219nIzNlh6ZfkaNQsh0UM2snn8bBGbP2BqbJ3x
X-Gm-Gg: AYBFou2ANJ+lyDvUfUQ9d4+zYKWgfPZf25mGwWqFsxTYqPG/wjG22uHiu3UB5RfrRKi
	5csxF/yoVyK7YwWrsrmMzZdV0qm0k+zJMg8Zl6YCTdaV/li42iTnWUgfZmXLyAqMkUpAF38vb8m
	DDrA1e2lu9WXdW7D+6sZs63h5FAtX0FL2mWdxeK07yztRQV1ZM3/9ekwZrFxp/qbvGjE/8eEiUs
	l6xeHrBxZObCb0gQEfSVJ/f7Zyga1FDYXiO8046Jh/GSh0mMvDXMZChjI1MT7EFwGpnnSB3wQ8p
	H8MimR0ct0N66R7XEhjx62kqpnrtZ/v2D++Ei+oVp2zVTwV3afXdzjqZteH4o0r1T5Tupfv929U
	bpjwDLuvOyP3q/9TNqgCWab6gvw/a3QMHn3YM/Oz7tlW/iilYIntYMDZ9+Lf0xWaI5Y8bTNRVVw
	rf/ExLmu87AMMcaWoEYMne1cUcZV8xJ5xfOjepDHlF4ZVtkI3w46yr9jZ2pAAPSfP8f2xh86gJN
	BBYOWeHJrkf9eZm4nKtBVQpQgWlvuBXNX4yMSYm8/1GczI8c8nhpG9mdoICsV74j6X2xoA3Qq8k
	0mGsG6rC9g==
X-Received: by 2002:a17:90a:c105:b0:39e:6a81:f350 with SMTP id 98e67ed59e1d1-39e6a81fcc4mr4626297a91.42.1789853335756;
        Sat, 19 Sep 2026 14:28:55 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm5802399a91.0.2026.09.19.14.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:28:55 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: socket: fix shared skb BUG_ON and double header subtraction in dgram_ioctl()
Date: Sat, 19 Sep 2026 21:28:55 +0000
Message-ID: <20260919212855.3241205-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `dgram_ioctl()` (`SIOCINQ`), the queued skb at the head of
`sk->sk_receive_queue` has already had its MAC header stripped by
`ieee802154_subif_frame()` prior to `dgram_deliver()`, so `skb->len` is
already the exact payload length that `dgram_recvmsg()` will return to
userspace.

However, `dgram_ioctl()` computes `*karg = skb->len -
ieee802154_hdr_length(skb)`. Calling `ieee802154_hdr_length(skb)`
re-parses the payload bytes as an 802.15.4 MAC header and calls
`pskb_may_pull(skb, ...)` while holding `sk->sk_receive_queue.lock`.
When multiple `SOCK_DGRAM` sockets receive a cloned copy of the frame
(`skb_shared(skb)` is true) and the payload is non-linear,
`pskb_may_pull()` calls `pskb_expand_head()`, which triggers
`BUG_ON(skb_shared(skb))`. Even on unshared linear skbs, subtracting
`ieee802154_hdr_length(skb)` a second time underflows `*karg` to a
negative value when the payload is shorter than the bogus parsed header
length.

Set `*karg = skb->len` directly in `dgram_ioctl()`.

Fixes: e1d001fa5b47 ("net: ioctl: Use kernel memory on protocol ioctl callbacks")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/ieee802154/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 5a36e87893f6..8d660fe87d4e 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -552,7 +552,7 @@ static int dgram_ioctl(struct sock *sk, int cmd, int *karg)
 			 * of this packet since that is all
 			 * that will be read.
 			 */
-			*karg = skb->len - ieee802154_hdr_length(skb);
+			*karg = skb->len;
 		}
 		spin_unlock_bh(&sk->sk_receive_queue.lock);
 		return 0;
-- 
2.55.0.1082.g2b9226bbc0-goog

