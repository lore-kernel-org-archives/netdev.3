Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A16411A1A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379843; cv=none; b=hwmy75+a2T05efssaT63jRg3pJhQbA1lkjfsq1V+gJn1kZ+tJB+lk+/NlsTtVyy3c7TbYIqjZL5ARV5guMK4xCjQKs5rgG3RVb7B7qeHH38ewXN2uOqaq00qYpZtcf1dHVqXk98qcRakddM+yW/BPuy3Ji1dDWDGTVwUiVZ+ycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379843; c=relaxed/simple;
	bh=rWTCDK7Lu98+d3mkrV0MN4YOesMUBm1C1YFvlmoJwjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsLio4XSVjDtfr1bx6BQOwj9YYKGE2cYkNhJyvnr70rwiIXXPNUSSCuFxg/LGE1XFBC7rQ8aZgTGqTQ+X9/XwXndc2xcH4NASLk17FPJq5Gp90lJwcQShVJFNoKjxNiqLsH+P6myQVCzNLNYLNYxez1zDjIOuDU7KOyzxPOw1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=I3QQ0vvE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="I3QQ0vvE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so16751725e9.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791379825; x=1791984625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUZNOFnMcYElO0ClXptU5P2JhQobHKhnh+QtdfN2Je8=;
        b=I3QQ0vvEoHqU/EGs2vyPlIwnAhl7LdfuU13Fe270XU3nbG7Mp92Gq40Baw6wkKuD+j
         nY6iGcJ8S6LhpvYlRJWroP+5a5edfBj9lCpwWOJJJVVJAVEkkp8XvCOgZu+/hPn72ZMa
         K6Ll3xVv76LZKzVU0YiQplXfQjBYzI69IcYbX7wjE69m6dQqhYwHcOsMc72GLK9ndvbp
         GPrEIL/dNVhSKlYG37eef/zMuDnRyeDIZrtV8RJziLClsjqc+5dLGyelT81Hc53/oj89
         +4eKKtUFNjIEMBd+x2K3GE4qrbEe011soLtTv/0IX8XdBpRLre6YAm7QOS0MGiip29TV
         vSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379825; x=1791984625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUZNOFnMcYElO0ClXptU5P2JhQobHKhnh+QtdfN2Je8=;
        b=gle25kRkZGAsoCgQDwy3nhjpd/fl9Wmhzrq4pHqqmEDUAOsMg8ys5BGrWtL1dcgs39
         pMdpjIRlz22IqBZXogrf6c+7NYpHdFUGSloJHANMNlTYHP6l0WvksHIyXFbbCKRFywPg
         O5lgt6XaFkXsz1UQWBeDkDYVb7/QJEdLtxZrXCFy3ixG2cc222+JSzxUKqCyKwGhPqeL
         QdDmrwXiuhLpEoD3kq/Re80LvQ+wcvWJGUw/QLmD/UKlTmSApkiN+/tJ287d1LqTuKfH
         5f641Hjxj8SRp4XHt5cvs2cMueBkuKqu+S1BtR0a15/T96zOymC7uXQRXiTF62Edd3+i
         sDKg==
X-Gm-Message-State: AFuF++nfe3o6NVXXTDhb170wBGmEfy58OXmv9E7ywYrLc1x4Py/9nFbs
	oeaap8al8GZGF8101impb3iGt9MxFgdmNuq1vZUrXqD8tPh5CVPxE1cyzYm5Uv2vShBQ92S/K1Y
	MWVIbNY2448rudC6t3leB48rDknETAlxHy0QAlLyr61ZYmGqsR6M1u3ab4cNOM3mE
X-Gm-Gg: AYBFou3j6Ce0DzvFYe5oBj3x2hgXj9lM6Dm0094tZioBK+CjyWR71WDecULP9UT6hlv
	mt5nxvYvnAOtH+w29NXDh5/246sfggpLZs8frE2kxre3pNSs2w0lhDAbig5n5Pfp47HMAUc7XfJ
	eKcVDqoGgeQIUiMbihbojjJUcfuQi/1tG2YZ6mgSFqs2GGoBmAUKGiG3M8GdkV3DIXsFHA+Kpl6
	dVN7fGa3m8kBPJDhXiI6fSUbzG83mgpRLHNZPdynpb9sNZbgQ6xsEhgQZa9d9ul5kQVMz73oOub
	/cJIrnqda67O2bLFZ5okmYF45y9A80Mhn6C4JLq3xGVOuVmMvGuls1Ynuo7tkzhdvGrgdJQ7ovo
	s3ZDusGnTtcvOBfNbiAqLJGvr6VrueW/zilFTToaNdyPKA21bX7qm1t/ZJxfvEC86wjso/akLeR
	y0Rkn8ZjL2M8lul2gwD0UEyluRKbeMziM+8/EnQXk1FqN+K/iUliKqeS0+C8xk5Zmq9LhAdWyaT
	uG5NT5wNLw=
X-Received: by 2002:a05:600c:810c:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-4a18041f7b8mr36182365e9.16.1791379825283;
        Wed, 07 Oct 2026 06:30:25 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7fc5:5cc8:bac1:5ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm150356145e9.3.2026.10.07.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:30:24 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/7] ovpn: remove unused work field from struct ovpn_socket
Date: Wed,  7 Oct 2026 15:30:11 +0200
Message-ID: <20261007133018.1451958-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007133018.1451958-1-antonio@openvpn.net>
References: <20261007133018.1451958-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

work in struct ovpn_socket was introduced but never used.

Remove it.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 4afcec71040d..5c87392ecd30 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -24,7 +24,6 @@ struct ovpn_peer;
  * @peer: unique peer transmitting over this socket (TCP only)
  * @sk: the low level sock object
  * @refcount: amount of contexts currently referencing this object
- * @work: member used to schedule release routine (it may block)
  * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
  */
 struct ovpn_socket {
@@ -38,7 +37,6 @@ struct ovpn_socket {
 
 	struct sock *sk;
 	struct kref refcount;
-	struct work_struct work;
 	struct work_struct tcp_tx_work;
 };
 
-- 
2.55.0

