Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE83E3C68;
	Sun, 13 Sep 2026 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295490; cv=none; b=axUQGKR0cdKtsXJxJVKqUlKpUZlxZvDj+aAgMBknA0d1phBNTu+rGUhAtgukR/QwcJU5HsqEHKxYvJd76p4mG6TZIz0MMGAw2Gn+T+75doiCMScf/VC15/EGZxdgQL0eyKFuTiDZj/DkSJsJwsoYYBEiUtq/9RNqqWGXqSA1aCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295490; c=relaxed/simple;
	bh=3bUIIGOt0JE1NQatAjl8/5kJaLYEMt05J/vnnTA8imA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nx/8x/wUmChkZk8aiUo4bZzFXarUjQgiplTUiyExD9hGkwcSvKBaS4irszRTQ3EebY5r/MHQXZZoYGYDieCURs6NbTZ7/IOvKFRe46VHbq8rqcjVoOuEp0d3FCOWdpp2TOKvmFwRZ1EtG/ESYN38M8ZLrY9LdYzwJiOgtm6HnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXBLmWq6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXBLmWq6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73AE3C2BCC7;
	Sun, 13 Sep 2026 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789295488;
	bh=3bUIIGOt0JE1NQatAjl8/5kJaLYEMt05J/vnnTA8imA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=JXBLmWq6zDhr8rcZvdQvLsP6QV4IKAPEZDvpvB9/m+i1UsqIGalYxGt3ext1gcHbx
	 8k5PksIFVJ+6PCUncMl4vExXQ0ALByhDcRlO6QtttMFR+B7QSXGchdonoShjJCqO41
	 hoD2SHgkMZS3Q7y5Vu2x6YifjuOmqg8ro8VSTpsrIdsPlqQTXXiq4GJNVeVC/CLXvd
	 pPiP8/EB+WamKlKOGcTUpavsNaQvpFC7jg9dguzsVG5M2WAx8D9hwkCVVlaXShdQaH
	 0iICEiiMYqbA1QRjmeeg1Eor63vAfhQOCMmb/fNqatobMeYhoQE8PGct9ekEc6fIXH
	 i+N+XPk4lH6HA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E8CC88E56;
	Sun, 13 Sep 2026 10:31:28 +0000 (UTC)
From: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>
Date: Sun, 13 Sep 2026 10:31:08 +0000
Subject: [PATCH net] net/packet: avoid truncating TPACKET_V3 private size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-b4-send-packet-private-v1-1-925eab2cd388@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGx7pmoC/yWMzQrCMBAGX6Xs2YU01mJ9FekhP5+6CjFkYxFK3
 92oxxmYWUlRBEqnbqWCRVSeqUG/6yjcXLqCJTYma+xopn7PfmBFipxdeKByLrK4Ch6m6H00R2f
 HA7U4F1zk/RufKaHS/Jf68neE+l3Stn0A6apwK38AAAA=
X-Change-ID: 20260913-b4-send-packet-private-49dbbd08a265
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Chetan Loke <loke.chetan@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789295487; l=1549;
 i=markdamirkan@gmail.com; s=pscsi-20260818; h=from:subject:message-id;
 bh=Xrbgrj2e+0VtiEmFZJKiwvN6mF1r9zb2KOZmKfHcoEo=;
 b=ViISPkrNOzUErHhzk7g0veNyTTw2KwI8ocX+cBTB3PYd/mydDVg8fT9d6MYU0RCIejslPrWW8
 Rdbb50RwMGhARgPIOKVxfjIlFowy/+OU3YfRnddMS0s6UKzqsQffI0/
X-Developer-Key: i=markdamirkan@gmail.com; a=ed25519;
 pk=/wb49ibt4gZFDncmhFQBYtjPvzT1tfJtvK4Mqt1P2Wc=
X-Endpoint-Received: by B4 Relay for markdamirkan@gmail.com/pscsi-20260818
 with auth_id=961
X-Original-From: Mark Amirkan <markdamirkan@gmail.com>
Reply-To: markdamirkan@gmail.com

From: Mark Amirkan <markdamirkan@gmail.com>

tpacket_req3.tp_sizeof_priv is an unsigned int, and packet_set_ring()
validates the full value against the block size.  init_prb_bdqc() then
stores it in the unsigned short blk_sizeof_priv field.

Commit 2b6867c2ce76 ("net/packet: fix overflow in check for priv area
size") fixed the validation arithmetic, but an accepted value above
USHRT_MAX still narrows when it is stored.

For a 131072-byte block, tp_sizeof_priv=65536 is valid.  The narrowing
makes offset_to_first_pkt 48 instead of 65584, so packet records can be
placed in the private area that userspace asked the kernel to preserve.

blk_sizeof_priv is internal state, so widen it to hold the validated
UAPI value.

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Cc: stable@vger.kernel.org
Assisted-by: Symbolic
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
---
 net/packet/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/internal.h b/net/packet/internal.h
index b76e645cd7..f5c8cd0eed 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -21,7 +21,7 @@ struct tpacket_kbdq_core {
 	unsigned int	hdrlen;
 	unsigned char	reset_pending_on_curr_blk;
 	unsigned short	kactive_blk_num;
-	unsigned short	blk_sizeof_priv;
+	unsigned int	blk_sizeof_priv;
 
 	unsigned short  version;
 

---
base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
change-id: 20260913-b4-send-packet-private-49dbbd08a265

Best regards,
--  
Mark Amirkan <markdamirkan@gmail.com>


