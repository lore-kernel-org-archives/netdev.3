Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302504;
	b=jM7+QxjA7SgCq+k2ZGG8zWCepc1V2JzQU5HXn+iOXJhknOgdFUos+SYLw4YKAo89xLoe
	 aOqSS5n4VE9ys2T6XDKNKoC562QlKLPDSm5QdWTaZBnbMAENh1Ay7ecyHf/ycRFlK+F6o
	 oIa23W1u/2PuEKjqhfdilat4scOaHJaYJ3OAB7WaoKgmoUlpHe8prYaNbeQkKsfZc9UK/
	 qRLGYXlFNRCuyf2FpPDMqDwFheti3ctshIPXyEpfmPkr4lKEN53r0Dpyt+p1n8LVe+uOD
	 HxbWypGxfAnDBA2P2Id7AfMsp3dpDbVQOCmFssDXTyBtrI2CBvmn6qGUJBPqOT3gsrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=laioZ8N0OQR8oGU3jFarnfPkuthFm2r6CwyVihbfb8I=;
	b=LMlj5cxFSBqlcuC6jfandrpwgO3/ZQ6K3Q4WbCBZzj3hH6XWjP21gNsYS7dsP7fYYVKf
	 PRMfHwYumEXuTOnI1Au3cgfLXL6T8uNc3v+ouVeGabMFemRtsB5xRjXaa9oDfgFCJEfwo
	 JcVTMPLxqYK4oe0q1vHAp2vqGE5x/qPgYpUhRY0rE+3zu4EurYJuAb1RGTUmqF6MbngLC
	 U+TzIAZg7pvpHS4h/TDj5MeeLhx4VOxFltJ5I8I+ZZGjmiJkhYalC9moWclA01hqgZ3bi
	 C6jA/7+DUVR5fGutv1Nkn4+u0feTqLMW0Lb+K606/OQwkVOA0W7IPtaxaNCz4nNvrwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr4pNwCK;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC45606A32A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC45606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr4pNwCK
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso42970f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793302503; x=1793907303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=laioZ8N0OQR8oGU3jFarnfPkuthFm2r6CwyVihbfb8I=;
        b=xr4pNwCKgYGulSw/az3ibQgRd3q7lIyi9gAtf0ESPFgOodSG05E/NuzpYrS9AdfFJq
         /3XnLbnR81g0VIcYmNAbug97vSIHtPJoNSreJGScZ+D6+n1Z78pDSeecZp0ARZ8yxZqH
         ySR0BaGEWVVQv+B6HqFTgKIAFx0ANskp4JqGTrj7rzVYeYttOkZ31xZduzyXAwfSW2ih
         XSzjfCh99ugHcJbRPc3X5AyaqtFh4YJ7y9RXQUp5EUjP9Bp8EhJEJ4z9p3eh6h2Zr399
         soNi82h30lyjo8knSvtarMORMcxjDxE8Fpywhu/VDW1XI8pwVNkPu1JITIMBxOj82+Ol
         dnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793302503; x=1793907303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laioZ8N0OQR8oGU3jFarnfPkuthFm2r6CwyVihbfb8I=;
        b=U7VfW9WGvTHxhGKlWzxbmvF5yIsnF6YG4qfUqRW0a1i4h+ritWUR/cS0/5nLy0ceAC
         OyYiYACHiklork7GMpk4ixO/veBeixEjdXkjTR66EdBhzwhF7wEuvENBjcAgALQcER1a
         aLN5WNywmloXzZRH+TFwmwv1Uoogi7Xe0FhMQy34Aqk/1qEar1aQa92yst7/o6JdGwh4
         F8hgQ7ETjVCsKJ8STPslG/+SezGWB2YO2gGzYO5vLcVvIY7YbQC3OeeoFpNTdvkDSFz+
         yKzIXA4otX4xJsrJbF+vBXKgk1jRLqzBOGR2CQoB06MuNAUAb83VKYJjTfvK500gIsNy
         43+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxn0pGtBnSQgfKXu5Zesi/KHCWFR6o36nuHNgKVOx2fJz8/b8fW85RI+0ijIZzzyBty9PRVfnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVCPDfrFo0N36oehof0LoKkYOnwd6Zu/yzxeDwVy/4N3zOA0q9
	//PZCcIqkkznRh+YtDBkZtOz58g6iSkc2eH1gYtxyJ5LtK/POQWf3MVD
X-Gm-Gg: AYBFou393o3URKrJRhLibkUTkmaL8/W5C1TN0/xYx1hvb5UNoc9X+Zaqv0X7BY5eVIz
	QWjm/reFG/6tvZRtXW9jEAZmJSCsq0zZJlJ+PW5cw/Jsnwd4UolAl5ZKc2iGT8THBDkBDtPeIA4
	QDdeFDER0MXHM33Z1TEmMq9lKwUqW3tgziCFls/YVPAsnz4Zr1NRT6Myq5jEjpQChMxPW7LGNTB
	Yxi75e+dz5Dr91JFQE1vzA0VVsjI7YNdlfoRyiaBgXmFozKCuztJhUWyUTxak1RCl7t3TgRqJL9
	EfA0kxbHXMJW9OllEHW8mjTt5GoHw6U0XNcjCrWU/BqByjIDWw6qGKcePv4kqvQerb0Or216dYF
	KMi6YdFqiQTvIUns5XQH1NbXPaKbxBxc3y4cxVIMk3vJYI6ut2CPki94AtN6kfXI3E5KcYw3cBQ
	ZS8WM8ZieNSaEiWh76hmWgL2EIIZZ5PxrJgVLR5xudM1eCAapGUZRJ5rGwf9GKWlzdX++v5Inut
	Rovlh4TuSwSsXw6iIVj/8Dmh4lSeWyQ/S7Uhua3iPfDGDOCPBovqS0WhvcrAmHSe9Juq9o/ZWvb
	gz4v04IRMchNVQ9eUUjYnsQK
X-Received: by 2002:a05:6000:250a:b0:48a:f073:336b with SMTP id ffacd0b85a97d-48e6e2fcd88mr842417f8f.23.1793302501851;
        Thu, 29 Oct 2026 12:35:01 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb81d48sm274585f8f.24.2026.10.29.12.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:35:00 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Jun Yang <junvyyang@tencent.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andrey Misiurov <andrey.misyrov@gmail.com>
Subject: [PATCH net v2] sctp: fix ASCONF address change on single-homed hosts
Date: Thu, 29 Oct 2026 20:34:54 +0100
Message-ID: <20261029193454.1028626-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
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

Commit 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in
DEL-IP processing") refuses a DEL-IP of the transport the ASCONF was
located by, so that a later wildcard DEL-IP cannot use it after free.

This also breaks the single-homed address change (RFC 5061 5.3.2). The
host sends [Address Parameter L] [ADD-IP S] [DEL-IP L], the association
is located by L, and DEL-IP L is now refused. The sender never gets an
all-success ASCONF-ACK, keeps src_out_of_asoc_ok set and stops sending
data, so the association stalls.

Fix the wildcard DEL-IP instead: look up the transport of the packet
source rather than reusing asconf->transport, and clear
asconf->transport when a plain DEL-IP removes it. The wildcard delete
can now free the old asconf->transport itself, so point it at the
surviving peer; otherwise a bundled chunk would reuse the freed
transport.

Found by manual code inspection while reviewing a backport of commit
9b2854f86f0b; reproduced on a two-namespace single-homed renumber.

Fixes: 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in DEL-IP processing")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
v2: the reworked wildcard DEL-IP branch could itself free
    asconf->transport via sctp_assoc_del_nonprimary_peers() and leave it
    dangling for a bundled DATA chunk (sctp_assoc_bh_rcv() ->
    peer.last_data_from) and the following SACK; retarget
    asconf->transport to the surviving peer. The pre-existing wildcard
    SET_PRIMARY / sctp_source() point is left out of scope.
    Reported by the netdev Sashiko AI review.
    v1: https://lore.kernel.org/all/20261022163639.2566945-1-andrey.misyrov@gmail.com/

 net/sctp/sm_make_chunk.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index ddc31a5..9719464 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -3151,9 +3151,12 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 		 * packet MUST be deleted.
 		 */
 		if (af->is_any(&addr)) {
-			sctp_assoc_set_primary(asoc, asconf->transport);
-			sctp_assoc_del_nonprimary_peers(asoc,
-							asconf->transport);
+			peer = sctp_assoc_lookup_paddr(asoc, &asconf->source);
+			if (!peer)
+				return SCTP_ERROR_REQ_REFUSED;
+			sctp_assoc_set_primary(asoc, peer);
+			sctp_assoc_del_nonprimary_peers(asoc, peer);
+			asconf->transport = peer;
 			return SCTP_ERROR_NO_ERROR;
 		}
 
@@ -3166,13 +3169,9 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 		if (!peer)
 			return SCTP_ERROR_DNS_FAILED;
 
-		/* Don't free asconf->transport; a later wildcard DEL-IP
-		 * parameter reuses it.
-		 */
-		if (peer == asconf->transport)
-			return SCTP_ERROR_REQ_REFUSED;
-
 		sctp_assoc_rm_peer(asoc, peer);
+		if (asconf->transport == peer)
+			asconf->transport = NULL;
 		break;
 	case SCTP_PARAM_SET_PRIMARY:
 		/* ADDIP Section 4.2.4
