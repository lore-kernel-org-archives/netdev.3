Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283243;
	b=l0IZH22OmIrH/oAby9+NHIjY7/q8WK5BpVzdRVtXbB5f9ZTcLIYD7GmxJK0G5RAVn6tG
	 A8Mx+Q/rp8/UyLpqUod6LIsqbkiOOulFv/HxMkFhHj19SKJBxT7vmMsc15q59NxDBcDCR
	 MAyF9atXTEfWYMZleC4eQQTm9pfPT+T3QTUN5QCwjgwxhXOy9oPhAoKHBzKKslySkFVa0
	 XLFWkZIJMbxjIybTz2Ed6wIAVwyVFwcVqoxod3jalkqTsUdPeAOzPCPWbDJuTGAfcvE6a
	 ZoUMVVkTbbgGwWuUtnCZMvDC8yC3/bjtQ/y9quvqrFqUGoIA1JtXIuoIsiPSxzgpjBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JbSTxllG6qq/Srrtm566fJNVCNWR5pySfmfZ5YTXfSE=;
	b=Z12IEwlxIsOyovrEu3pEqvOoxKOtoq17vsnnLFp/Hcq66JMGYrmviweUvZOgdATh3cNx
	 Dc3cGvH06xE3tJugNB/57+WwybGaeO3aqmY5kStPiG9BE79cmqO8sWCMN/fvMEdo9j2ee
	 X5XOK71oI+yvNg/9+w1IDNmOlcjxF0TQ2Bl6qPldt6rGjiqm/vzrNwQzIYxEw3tLAJ1uA
	 wM+FwbGQSGmlTak4GqzrBNNSI16NnRVglvapA9Sif/8t5qXOoKtQYT5CtZwEEDj2O7njp
	 RtpfHQBnWJH4vUiut556PKMpIkV1zCpIkoAOEFhq+CWUcBncux5KY6iJtEsgm1SVcrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQdf4MGW;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8F606A338
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA8F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQdf4MGW
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a2551d7b5so1024236eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283242; x=1793888042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbSTxllG6qq/Srrtm566fJNVCNWR5pySfmfZ5YTXfSE=;
        b=FQdf4MGWZ9bAl9mcM9T9HJiMRdlOV0GvYu8FXKDD65tJpfGUpDVnousJRkiQQzY06X
         VE6wOqz/GJXQuh03lvxzdh163X49k/phL2ZMOYMTCPTR6wkxSLWFwlX9Vy2bQaLhHzdw
         P88hhYy0w47jqRxUGK20jhU8a51XHApsyj9/gJihOB9Ew6/1wKu1cWF9LIs9HmOBeQPv
         KakOTir5ZO5eocT3g6LNVocWCTLTlcUB4JFwAX7zv+t64KrJqlO55to7mgu9Fvzkzozi
         eU+cSlahUosFGKEGZ6RZpDm8ndL5jX8gE+Y+ZN2k53gn3rsSAPrcGoZd0Ov66kTul5rm
         Gg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283242; x=1793888042;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JbSTxllG6qq/Srrtm566fJNVCNWR5pySfmfZ5YTXfSE=;
        b=uIEqxfQBdkVcXADC6qMUf48Pxe+ELI5qZHhecmNG87n9q9JuO2YA8Z62RWZmR9scDY
         kU722WiT0l0iOxk9hmAx+Kv9o1V16qVOfyewVORda72Typ4hr91d5FLw3YjCLG16mooJ
         eATXWkgoM15S8METC/CmnaX1QpH7drJWI6MZlX3XyZqwq/uUQ+b1p4SgPYOhckfIxJWn
         6KHU0YwvADWnbzsq7dBgk9sArbSfKwCk3J6vmyCQ6qSQSIeXrzEQYk9jewY3UjZXH8cO
         0m/d2V0zosQEfKcpZwBGMj3ij7NX2WVmvy6apUDkpvgqiCjAYT05YXx+SQbX0xb9oRPu
         d8ng==
X-Forwarded-Encrypted: i=1; AKwUvBxVlFBXgOJ3PnraQgoFad5m3xz150mMGkYXHlbhzYIZiWn77VdfP9w+YgUxi5BDiJokF/YWP8c=@vger.kernel.org
X-Gm-Message-State: AFq9FYICqyGU0KyZux8v3wRg9+4i8XPrtLlqHpydl1qNmkHWViYIE8cy
	LaA17pZJl8Popo1unfbUy3vl6QVX+kRKCBpj9latyofc429j0Hpewcje
X-Gm-Gg: AYBFou3BnunwGKpS8ullCT4hxO7IihHEkI49lRtXBLVW+jwUyiWb3N+3qH89fBBIFyQ
	tnmh/+3C6aXbmmdYnPYtd2TNGEXbkSBNxleZqXrXsdGFcFm+vdQXsdGnAqFWT8yJ6pjXp5Sq88N
	OA2tg5z2+I7pLGP/baq3hDTunrIPOiTebguPJKb8xwdiXhaW/Bx+I/ZpyyzJrrJosIPHS6Gp2IK
	02cCVZUu8/1zHQzx6bYeeOE0HttO812okvtjS3IQFS3R77Rhg4MR3tzxaIAQg4QoQLJ6Bs9Z/d0
	ce+W5AyQNpX6XNiIKessSZPxphVkO1dLWIW/8SxWNX/oE4iYk7SX4fwYBwaeYHIkf88eBfMBn3a
	BhreZoF+kabGrmQf5IMDvnowSCPWOCpEZtpvi8IH/2EGUvLh4NHlCNfPoSj6l6jCA7FirrMx9CH
	4uzom/L8TYw2sc8K12CBUhrngPUcSBF8ycRPQhgQr2RVaPeJ4fjX34DuCpKJWBt0WQ00cqu118i
	aJY4gnV6MkXLRgktwQnCz4YI4MeZiKcUpuQzEGE42yEZL18R4MKyxSmpxyn8zzSaX2ShE4pYeEC
	zqi3EMbqbI79DCP4fJw1HNGkkVPfmXwaFGFif4LQn0NnyCgdwQ3zog==
X-Received: by 2002:a05:7022:5e09:b0:152:dd1b:4fa7 with SMTP id a92af1059eb24-1a944ee37e9mr3337955c88.19.1793283241701;
        Thu, 29 Oct 2026 07:14:01 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm15197319c88.10.2026.10.29.07.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:14:00 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To:
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: mcast: release the EHT host budget for
 zero-address hosts
Date: Thu, 29 Oct 2026 07:12:20 -0700
Message-ID: <179328314076.648427.17991367257682028617@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__eht_del_set_entry() decrements eht_host->num_entries only when the set
entry's host address is non-zero.  A report sent from the unspecified
source address 0.0.0.0 (or in6addr_any for MLDv2) creates an EHT host
with h_addr == 0, while the set entries created for its sources have
non-zero source addresses and are counted against PG_SRC_ENT_LIMIT.
Deleting those sources never releases the host's budget; after 32 counted
sources the host stays at num_entries == 32 and every later counted set
entry is refused.  The same sequence with a non-zero report source
releases the budget normally:

  host 0.0.0.0:  IS_EXC/ALLOW1/BLOCK/ALLOW2 = 32/0/32/32
  host 10.9.9.9: IS_EXC/ALLOW1/BLOCK/ALLOW2 = 32/0/32/0

Only set entries created for a non-zero source address are counted:
br_multicast_create_eht_set_entry() rejects a zero source when
allow_zero_src is false, and __eht_lookup_create_set_entry() increments
num_entries only for those entries.  The auto-created wildcard entry for
a zero host uses allow_zero_src == true and is not counted.  Release the
budget based on eht_set->src_addr instead of h_addr, so counted entries
decrement for zero-address hosts as well.  The uncounted wildcard entry
no longer decrements the counter, which also removes the converse
mismatch for non-zero hosts.

Fixes: baa74d39ca39 ("net: bridge: multicast: add EHT source set handling functions")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_multicast_eht.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index 18eaf9c..548ad78 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -167,7 +167,14 @@ static void __eht_del_set_entry(struct net_bridge_group_eht_set_entry *set_h)
 	RB_CLEAR_NODE(&set_h->rb_node);
 	hlist_del_init(&set_h->host_list);
 	memset(&zero_addr, 0, sizeof(zero_addr));
-	if (memcmp(&set_h->h_addr, &zero_addr, sizeof(zero_addr)))
+	/* Only set entries created for a non-zero source address are counted
+	 * towards the host's budget, the auto-created zero source entry is
+	 * not (see __eht_lookup_create_set_entry()).  Check the set's source
+	 * address and not the host address: the host address can be zero as
+	 * well (IGMPv3/MLDv2 allow an unspecified report source address), but
+	 * its real source entries are still counted.
+	 */
+	if (memcmp(&set_h->eht_set->src_addr, &zero_addr, sizeof(zero_addr)))
 		eht_host->num_entries--;
 	hlist_add_head(&set_h->mcast_gc.gc_node, &set_h->br->mcast_gc_list);
 	queue_work(system_long_wq, &set_h->br->mcast_gc_work);
-- 
2.34.1

