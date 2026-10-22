Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687004;
	b=0/I2KvtCvccex0ULTrSdRju7Kkrnwh2PC/SrMH7BqhnvKcEau2FsXOqM47lhej3hYxBz
	 Yo0WSiPj/juL+9XLtP1jD4UDVV9ykuwgQhywgBcU6v4Q55cB6y79zUmzhqqKPBxQ5xOzu
	 dG619WFpiNVDWjalzdslPhfWEY3YcemTNXli/G6RScGmHENSaFb1ffkqxPSOnuuFGO6wc
	 iDUJKOgwBn2adGm0q/PT39oRgO+aeXfp9clgyy7xRmzHxRIazz+8UWjjEKowVYgurzS/d
	 vYuh7nrxiPU017pdFz88oTMFs+ALAVGMKaMulb2EA5n38WA2wm6DOgUwd5lBGmPXNEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R7l9GBldBqggvq/zvWK0w7jaQ7qb61TWRK+g3QMrrtM=;
	b=0UR57RqzxraGnuDWQHbdJ4qk8Gn7gf/mcl76+B7HLBtMWC4nuyJo+l1w4tJcNP8LkY2P
	 lMmRIVRKLpejcNSJFPYYtLVr3HbcFBx3MarxOhn4UMp6MLpRONuudveNZL7YW3LJhhJaF
	 PeuhCPh1S1vrrOtPceJkVz97j31iEmEUZWuyRwz6qVrMzZ9IrsCgfcXYID4f1DPm3SGnN
	 Nr9qIeZ2yMBnEdOcwpGzmB9hvYwN2AYuCnE7nU7+zp5ZxaYv3XsUfv6lPb0w4SMXkBaPy
	 sfEIicAt4UkQKpWMnnVmLu6hv/B//KyHlHWhwrbx3Wto1TurgjMbaXe541IgWXBR8YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Vokx/Tg8";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83C606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B83C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vokx/Tg8
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso142055e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687002; x=1793291802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7l9GBldBqggvq/zvWK0w7jaQ7qb61TWRK+g3QMrrtM=;
        b=Vokx/Tg8TYjm7F/SKH8DDaZUu92EOwWBEPcfCIIyGelydx+ks+r3kdT/Q7Pf8xeFu5
         Q93181FjebSTzRVLLMCnCIgs1ZtiJPV3dJTwJgt3PsEDXNq8O0NssbWA7dhYpG5cdMa6
         rv2M7wIv4eaS+CHYapfxkr5yKhlLjjGMdu1R/j2MjAIXxwdQabrnCVh6EnCXGziI0K9U
         XlO4jocMxrcN1M2TjO2Qp8EUHcTGoxAeWykVXoJ3K2NFKCv8ujmiHjJGh/puVnGVBQIs
         LVhhycFDpcGDnbNeR7uxY23W6NEAzsNdg0eK4riZzHlw4Jgm45N8SCjxNdT2OQjGo3b8
         aq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687002; x=1793291802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R7l9GBldBqggvq/zvWK0w7jaQ7qb61TWRK+g3QMrrtM=;
        b=nhf80DL8WUUeNj29hrOmgJH9NhmHfbAsT5VrDeXPUc6hVPDiBc3fNzTO0b2ZeNxsu3
         uaGbnc5vOU5LNNTkEV+7N5Wb6CWE4xxeCIaU1GnKmQCl8DO36aCKLLPO8ZfPplGjIyYA
         wnE6X+IM+DAlle5LgOakSsPJLSRz8jbixvFeLF3WJtog6vK7ySPcL3+bgRk9UfH54XXv
         EEjWI6F3AEdKXia4FO6tpfPWbkXl/qGamMBp4gA2v8WsyL1Vhq7dBUFDKOaQRlOD41+w
         RCM+chuJh8hsDgpot2P1BqeT+OLdm445aoNiasaIX6vBkRIqjsU1FAXElCE7jGJH9O1c
         t6WA==
X-Forwarded-Encrypted: i=1; AKwUvBzzKkyrST4RZzMKLLgiKu7EqVC8btZKBbh9FWUQux3A0cWtXzk4mAGaGKknZn0B9tPgwhsqJo4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbC5VfyDXpSAI8PSAm7UAmTfQGktCfWZMZtbPYfzrUYC/iz+U1
	uCFSpklQ65Yornqhc1jAz85LSjKVQdd46/GTkkTVmwp7PnXholF7L/6D
X-Gm-Gg: AYBFou2B5sbjBGTD4KZLi89WiEHd8bD3CvDHnySuL3tsnrxtRRjXljh7I5Y2CEc3jRh
	lO7H6f4AVkqLbHZoXnOEQO0uQASTeFMSmPDFDS227anVa4S0udTjh7exi94hudyDncNMF5PXmhN
	0FRWsEB7Y3TetBCjICERyOpXdLXzZnRPtgT0Wvo7NnY1+kiEdCaYcntSaCpm3nOWk68gbXQ7GW8
	R+BxAmvqTX9aqC0TsfRY2jAyjw491XZzolW0FnGrKuNAwWrw+u+VTSggLhUzx0vAUC/Pnt+jMtP
	42VDjMQWsTRfPTigj+iH3bas9g0T39EuiLrKBraj2KScfG8fhoNkzXdotL4fcN4wC+3p+07gSJ5
	Arwfnb7e7VTuLp5jonbnYuN7xBjk9G/MrDstnGHmqbgg06/zdX0bIplx3v9rbq2Fx5xAgYZRQi7
	auhUWgE+svPvOtBdxcgkuVn+SOEgvA+DX5cRhFigOBVxRhvvbSjGridi1Zcv2pb76CVuNwoHrrq
	rysTC9HMpO8V7Uhi8rbNKCV1AsUSoAGBOTyYdvHSrGd3vjF6Zs=
X-Received: by 2002:a05:600c:620a:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a1fdb1a609mr102596995e9.7.1792687001668;
        Thu, 22 Oct 2026 09:36:41 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210299910sm8263415e9.1.2026.10.22.09.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:36:41 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Jun Yang <junvyyang@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Misiurov <andrey.misyrov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: fix ASCONF address change on single-homed hosts
Date: Thu, 22 Oct 2026 18:36:39 +0200
Message-ID: <20261022163639.2566945-1-andrey.misyrov@gmail.com>
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
asconf->transport when a plain DEL-IP removes it.

Fixes: 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in DEL-IP processing")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
 net/sctp/sm_make_chunk.c | 15 ++++++++-------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -3150,9 +3150,11 @@
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
 			return SCTP_ERROR_NO_ERROR;
 		}
 
@@ -3165,13 +3167,9 @@
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
