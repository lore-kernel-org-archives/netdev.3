Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846738DC71
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030864; cv=none; b=YHOByKvaRqMo50MzM/qq/qb+D5KaL3wreMlqZ+iVd/BdQAGtI8W/L43+FwDl63Drl+S0Rgqka2c0LNxlH1ZJOmQwyWUc72GhMAJNYpJS5NOGybVmAhlEaHN7gh7W96Vci9zgGTLTx6B3wOQcrJJDnxG+3RKgAaSZtYYl6mvFfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030864; c=relaxed/simple;
	bh=NiDvAbsWduwc9Ie7/lzQ65vAjTWmgNeFXc1Agxk/npM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO9ARvCJ9YGXM+AuszIYZ9cioRWfRl07+QNuCp8jcH5RK4Y8KtK/hEl5WR2xj+u+EZS9hrR50plEBncJcQIRKfxx+n18YwK46SKFD06qw0Zw/+4yBl2QY5IUbDMGqp6tc7zBolc+LoZYtQkAmWjYzUhvatyeEfV+qBFgsUJ/h5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=jUZWPaJW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="jUZWPaJW"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c25b661d37dso1005215466b.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1789030853; x=1789635653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sI6uVqqlwqaRtMuzW9jXOvHuhO1f712UR/f6QW76OsE=;
        b=jUZWPaJWmpb53Pj2LcFRmD0WJxzKrXbHxw6DZHD9HA7TEWGYS91BGY1kJPNA1PWSJ4
         QHa3AlrEtCT/60Q/o4pA+Ux3tQNRIMrWyNRp7jkQaN2ff0jjo3PWhKJPkmaDiTxcHtTE
         73SiGTX3DsI7cY3TCSaCHmwrE7n9CW31CcVcAR9V4eqWN7r2wAyvjp44wfQWOguJeQ46
         4Vrq1tr7IujaxG4MYISf2ZhQF4p7SHso911Q4lOXiIf3RV6HoSZy5UhciNj570CWgxZ6
         bQ97CpAEH8rbqYfT04X+lU6yaTABz6RFNMVWuqlX7v10mo9YggjtgO2we4nMb3hkZMCs
         +CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789030853; x=1789635653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sI6uVqqlwqaRtMuzW9jXOvHuhO1f712UR/f6QW76OsE=;
        b=hq3XfJAqwECDpjuppF760HFAQ/52cLNJ5rHcsIQMvPhiJcimo6nOpqzmMoLAQVPn/i
         +G12i3W2GpAmZxJodGkmm/otDIx5CSNSxn7bFJtAxSP4ieefIRoo+462M2tUGSpnvqL8
         faEo+DAIZHCZ+KEiq1DMWODO60yB/cFs+rVkeEVKZswj/qCQVjREhkwJ4g7zay5yTbtl
         BJZmIEbsVF5wWPhDNhVAxPCw0NxVzaLUyJNQ8Q4H/EnK0UqR1fEsUTJxrWU96VjxdWx8
         7jDpf7lBNRahJDBZPwWgqUI6rBrraAyX4Mk85HgpnGoFVzvluk5swx8xduUfQ4pvXwdO
         l9Ww==
X-Forwarded-Encrypted: i=1; AKwUvByI7YUUOaBEtVCVGnHhmlALyZvEy10LNHq+Kgzxtc5b9q3G0FErEfqNPL6NPYRBuLnmahYPYZE=@vger.kernel.org
X-Gm-Message-State: AFuF++lcIow+e5VA40ZRxCnma3/KJNdzfZwzRdnmN+Gvq45/OnHfkj/e
	lfFbojqE25YHfNiUoWBwpUj0MOarm+wvh8IYnhATrlFHvhyaljYk5ZOfLCKo9NYugA==
X-Gm-Gg: AYBFou2UVufkxw0ii+3TuRv7lVlAVxH/vJkTDgJqNimPMz64kZmtTYh/5EzlhFigifk
	yKwiypha81UWcLskmFKoVTvLgkCfsBMw4LULV4IJtZpXr+6JPWpji06KubzkSrrFjbbGT01IUFs
	YeSEz632FqLizFY7ZbM1yFaElWhRTnTQws4yVZB10mbSiuKxXe0pG6TOECAQXvTZ27LoUTWYzTY
	oERiF4IYUtRaQN7lfdEeNzLW+ksOsJPudzwnF6rRDO2KmWdNkXVnMqqYikm6qLlaq19k4tfUnBe
	Ox6p416R+xiUVIyRKqUVW8fqV8dSRctc4900WW3+HXkMhGAcZUncVRR0a2fQHAl/N5AsCw7/YpZ
	9Q0Xe9oVD1UsqeA9RyoXbcNBnoYg4pz1p58M4rozTXGP1mLHvA/VfOyZ7nLpS5vqCim6+CmPogk
	mN6pnypZ4ify1tQOApB9oWiXPwOCsMMxB1Qs1fmLUVAdCxq/fW5eefHkceKkjbcHRKFikEB3JFC
	1EVxN+r9n0GscdCcpfI1qG9xULt9SipX/Xdo5xCjBF8xpWiIOat7zWrKmrIfZ0fvZ10P4CfQ7NH
	Y8h0ytRbOeS+tbNjdN6GxNxrN1pok5gnl6poN/K3s2DJmWZV64+yA1ZnSFNmi/I0o4/tboZT3PT
	ms+a4n5louc2QmwHfbNM3nUs7E4NscLHGGRxltzRQq8zIqNHVgPAUd8Db/zUjXweabNdCg5/FSy
	rTQ+KeFg==
X-Received: by 2002:a17:907:7204:b0:c26:19e3:e98b with SMTP id a640c23a62f3a-c2619e3f02cmr1404442066b.43.1789030853259;
        Thu, 10 Sep 2026 02:00:53 -0700 (PDT)
Received: from Desktop.fritz.box ([217.26.235.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c293eaf1ae8sm156106766b.40.2026.09.10.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:00:52 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: kadlec@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	geldot@protonmail.com
Subject: [PATCH nf-next 1/4] netfilter: conntrack: pick up a TCP flow whose SYN was never answered
Date: Thu, 10 Sep 2026 11:00:49 +0200
Message-ID: <20260910090052.2034970-2-julius@bairaktaris.de>
In-Reply-To: <20260910090052.2034970-1-julius@bairaktaris.de>
References: <20260910090052.2034970-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Dotzler <geldot@protonmail.com>

When only one direction of a connection passes the host, the SYN is
seen, the answer to it is not, and the next packet is an ACK continuing
from where the SYN left off. The transition table has no entry for that,
so that ACK and every packet after it are invalid and the entry sits in
SYN_SENT [UNREPLIED] with one packet.

Treat the connection as a mid-stream pickup. Delete the entry and look
the packet up again, so it creates a new entry through the loose path.
That path fills in the unseen direction from the packet and stops
window checking in both directions.

Signed-off-by: Gary Dotzler <geldot@protonmail.com>
Tested-by: Julius Bairaktaris <julius@bairaktaris.de>
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
Assisted-by: Claude:claude-opus-5
---
 net/netfilter/nf_conntrack_proto_tcp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index ad6f1986d52a..335b11301a78 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1173,6 +1173,25 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			return NF_ACCEPT;
 		}
 
+		/* The answer to the SYN never passed the host, as happens
+		 * when the reply direction takes another path, and the client
+		 * continues from where its SYN left off.  Take the connection
+		 * over as a mid-stream pickup: delete the entry so the packet
+		 * creates a new one that seeds the unseen direction from the
+		 * packet itself.
+		 */
+		if (tn->tcp_loose && !nfct_synproxy(ct) &&
+		    old_state == TCP_CONNTRACK_SYN_SENT &&
+		    index == TCP_ACK_SET && dir == IP_CT_DIR_ORIGINAL &&
+		    !test_bit(IPS_SEEN_REPLY_BIT, &ct->status) &&
+		    ntohl(th->seq) == ct->proto.tcp.seen[dir].td_end) {
+			spin_unlock_bh(&ct->lock);
+
+			if (nf_ct_kill(ct))
+				return -NF_REPEAT;
+			return NF_DROP;
+		}
+
 		/* Invalid packet */
 		spin_unlock_bh(&ct->lock);
 		nf_ct_l4proto_log_invalid(skb, ct, state,
-- 
2.53.0

