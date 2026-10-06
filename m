Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5CA43B3CE
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291450; cv=none; b=okm8TI5wOKEdbEW286UIONHECga4e7u5QKG/OiOAwa002mdhf4qrRITEqO22ROHs/W8N2zHSs1f+IHb9qjTC2DaX5E9ZgrLJxGyicXMiKMahd/U5DzYA7JDGrpq96ivbopcHUrK7qKSC0fgFQYRi854LXJ+y0SCQDXE40UkupCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291450; c=relaxed/simple;
	bh=Btqtd0UsCjcmoPb7z0rRhkP88XKfTDkNPWQFKJwxpPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkDM+Cw4RRCDtKIA/od3EAJtVOFbeOrQESMCRCQaLMd/3Y6Maz3rw73I9eFzL0X64S8yJxvRGYBTu1UQ+42WDeyqZDVRJkwxXXLrqeZoON62Z7j//9O5lXcvN20DTWNitWkeU9azKP20sDk3hbZI8biHd+21z1Oh1m9fh9sFfhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=rpbBwRry; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="rpbBwRry"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e4b5d94277so4901045ad.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791291448; x=1791896248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGJoDXN8ML+5H+vmHlmrXHOZlyl9hQU4oGT+sBqpTVs=;
        b=rpbBwRryqlhYsivAKvTJ/AETTAXITegzeI1Ou+raE7HQznk7Lt77ONZg3FFYXEbU9z
         9/+pjQMXxa3mwvHLaPx7U/mPq1VYyWIjV9tR+7rI+NQhSqDz07bpyZCFrdINDO6rtp2a
         OZkBy4FbN/pIEVJjBdVNZciG5BIzNZxHYlmD1wthe5lQwUDEEnbxTJApXq7znpX++EC3
         UxTP4cOB8fIC3TtPWVA08wRKCNDnY05vfzdVd/GOUx9Ru7sYnfDopGxE5Dl0yyHhUh7k
         vN2UfGRE8zsCc2YSzTWp0+0JRKbyA2TqbodPRgQEtBlT8sSaI25OgbynOtaUUnMc7VnC
         nYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291448; x=1791896248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XGJoDXN8ML+5H+vmHlmrXHOZlyl9hQU4oGT+sBqpTVs=;
        b=I/OF0+n3SVmlp4AHfZ9kKxUURPzOw9cFY+gw3DOvYY2Eznh1rKbjGjLjhghD3scxJy
         NudFogVF1MJwpXtC2GjXhr3CanEvBITJ+V1eA4FWp7//96m/EzuHj2AMePKSpH6+slcs
         cPVEL9C7lcQcT/oPFTGdjzr5WMuNqWNv48cGWh2JRArt3Ow3/Z+DnaAk5BzAZydhenkd
         ho08efIEps7Ju5TESuDii934GhjUlYgjRM1IYBtxGZ4Pase7PkWxMBjRb2ltgHW2zwR6
         1XW/fpEEkT6KSzxHwPrFu0DtG0EzcYoWqJzCLipXAeLAiwVYYPCeBGhKZMKAtn/Yia4C
         PMxg==
X-Gm-Message-State: AFq9FYLSUuTclcMx9yCOjb0cFehAgKSC5dRgU8ARO1PKXgaR8jsRB6kh
	miPmK9ujeDKzlgiIxus7L7+aiSdhBxh1Pm7PHx2pYbYxVvmzhv6T2zQwzMF7E3RZzMwfdAKOpSW
	3eLuJ
X-Gm-Gg: AYBFou2W4QllaGuQvC4klJB/srm8spPvDl8ODLHCFhqezZGYDs6Ev8z0N9uTbywMKhr
	x31tocBE2DJURI7ApXQCRLQH4O6TqpPMcv3pAsm5qEfA8rtU/3HgW/Te5qMA/4Tb4X+YArhMPbI
	992OERH5R3q1ZDi9YYOuBYDXMXivHAFBboUqua95qhqY6SefMUFN05wHyQykkkY4lzAQdsCiYzc
	9+R16ejzwp5Kp9BScHC6BS5vl7+hl86QhK0PZkh1nfRyjuq4siYiNwHZbWHmBFoCzlooMsH31GC
	O4nTd2vqYleCZXGlPsEVkilyaEoAXZ5UgTEhZOH+FoUyvyPYyvxwKyKxDSz0KadWbhBIaPf+Cp7
	ovvXvWS76nGCFcE01CPj5P3AQgpr8L2jzhYBaWZqfPA5pNRbfhTxWwxF1w0k54OVqao+rckwTB0
	cUvGvAPXKghvzzZca6xJwr8HDkxOWqYJ2UfSPRBoK8xUvEXuSEjBAaPiJe5t6+moVFOJukVDfj9
	qtKZ205dALL5R5EfalvZpgOXtJB5fUAhjHQTlgyr4383OP8HTJ+9C/J3qdqHF9Onqra6SPJiucP
	3oKg0XPFGMUL0g==
X-Received: by 2002:a17:902:d2d2:b0:2df:950d:8f4a with SMTP id d9443c01a7336-2e5dcd9701bmr11664305ad.22.1791291448027;
        Tue, 06 Oct 2026 05:57:28 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ecb12fsm22942235ad.50.2026.10.06.05.57.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 05:57:27 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Giovanni Vignone <gio@octane.security>
Subject: [PATCH net] net/rds: ib: drop fragments shorter than the header-declared length
Date: Tue,  6 Oct 2026 18:27:20 +0530
Message-ID: <20261006125720.81227-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rds_ib_process_recv() accepts an incoming RDS/IB fragment once the
receive completion reports at least an RDS header
(data_len >= sizeof(struct rds_header)).  It then trusts the
header-declared total message length h_len: for the first fragment of
a message it stores be32_to_cpu(hdr->h_len) in ic->i_recv_data_rem,
and rds_ib_inc_copy_to_user() later copies up to h_len bytes from the
fragment pages to userspace on recvmsg().

The number of payload bytes actually received into the fragment page is
data_len (after subtracting the header), but it is never checked against
the amount the fragment is accounted to contribute to the message,
min(i_recv_data_rem, RDS_FRAG_SIZE).  A fragment whose header advertises
a larger h_len than the payload it delivers is still linked onto the
reassembly list.  The fragment page comes from the per-CPU receive cache
and is not zeroed, so rds_ib_inc_copy_to_user() then copies up to h_len
bytes to the PF_RDS reader, including the uninitialized tail the receive
never wrote.

Reject a fragment that carries fewer payload bytes than it is accounted
to contribute before linking it onto the reassembly list.

The issue is reproducible under KMSAN with two hosts over rdma_rxe
(Soft-RoCE); the same reproducer confirms the fix stops it.

Fixes: 1e23b3ee0e94 ("RDS/IB: Receive datagrams via IB")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 net/rds/ib_recv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index bd6cb3ffa..fee77b6d7 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -949,6 +949,15 @@ static void rds_ib_process_recv(struct rds_connection *conn,
 		}
 	}
 
+	/* h_len must be backed by the payload actually received (data_len),
+	 * else the unwritten frag-page tail is copied to userspace.
+	 */
+	if (data_len < min_t(u32, ic->i_recv_data_rem, RDS_FRAG_SIZE)) {
+		rds_ib_conn_error(conn,
+			"fragment shorter than header-declared length; forcing reconnect\n");
+		goto done;
+	}
+
 	list_add_tail(&recv->r_frag->f_item, &ibinc->ii_frags);
 	recv->r_frag = NULL;
 
-- 
2.43.0

