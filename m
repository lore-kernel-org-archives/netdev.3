Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495710;
	b=2DB4XGRIZafQ3qk1yDRuQNC1J/TGQsa3qmemdOPJjSuGMC88Y+uNcNkSJflo4w7vqe6c
	 lp19KzfYuOg4pw3kw8VkIexu2TuuaQlLOZTeFWGMBvAffoDEVu/gTkI+LDQki/+4LkFr/
	 iRH57El4xx+88ekZesKDFv+s2vKIihcuho/ARjlcujfYmxo7p3e0qQ3ClDO2zo4EBBtYZ
	 rwuA1U246hdd0cYMdTcZNI1Fm2TOuXbqtyP+0xmff+O4AtR3xM/YgWuASn4TNlRAqQNym
	 NvkZ3I8Y9IMA6NAhTNUn0QSqEupDIPWBYiv/qmg3W6TsyLtNk0bRMu4gpfV/lbJprRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qc4uEPO8Cmvke9ozBGIwJNLQ+cJCAHLnYttkfZRqa0Y=;
	b=2CBELE8Io7mfEg6htoa355zqBDZuWYaoNGMyQmOGXlusWUOUB4HsBKgJbzArbuC1tLav
	 mNMSNPPXvdxSkpLxofauLo8uJ7GvQMyAGU1orrrkW7xAT6fChyhr4VZDoYocGy+s2s87X
	 aHbmvd97GxOT2Essmr/8i5zJD5LuHFCkaIfbaWQjl/r+Zjr4G1vvHW6SoPsIBkkWGy7mS
	 mRVr96L418rTu/9auTFsT5A2BzB2C3gpK96nxq6RNZdp1YllodIcYpdzSoML7hnEbYbFD
	 V6ji4ZpBxe/PacsRZpmqrw4+OYngt14sf/1CcZJBschEQwUX69rRPf6b9p3iBFH6hpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yFXqY/uI";
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A7606A338
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C3A7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yFXqY/uI
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7d2dbc0a8d4so1518737137.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794495709; x=1795100509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qc4uEPO8Cmvke9ozBGIwJNLQ+cJCAHLnYttkfZRqa0Y=;
        b=yFXqY/uIBJokOTs0nvStnFKn1dDvyOFvUuPwGd/fHbSUGqlmqmS6k5WQvOmJzwuhP7
         D4fFUbO6lptZ/rnnvb15OHHof4Wn8/JIG/fH/7wlJnfoFh2Mi/sWG2HisiuFrDztYb0i
         o1MzeGiKxPEOC4OvGQiDa8Pfy368H3sRFqyBfvuvD2O9oIsS+C2AYSq01oSku4K7RNGr
         QxqW5fakCi3CGNoChMP2QMhUCNH7d1iSsenns/W9OLSQvf6tq/QMf+OCiP5k/JsYfC8G
         p9M4K23tjNghsMl8xfGgXxDh9SGxfw2vELs4iv6ZOEVg2zZ72RCvYiZRD+/jCcx1dFM6
         p75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495709; x=1795100509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qc4uEPO8Cmvke9ozBGIwJNLQ+cJCAHLnYttkfZRqa0Y=;
        b=EPpk4syonXYmwg/74qAuO1znBTP4SUZJVqzeV8AhkTRVvJeZ5Tc4zqvBTfa1PNDQc2
         U+qCf14YS9wR5AOdPCWeQ3ZXG5xt7TOAmi8bvDMvJRQuc2QcGzVUPyhH1CbdI9tK8QhF
         4xMqLdiXwofGgPyKCwSUnq00CDwEQVOuDR13aB9n+bW5xsQ0b5ZJyhFJ+TQ2eAPE+qqv
         iUuqinOvUOIz1EZ6LM1/1OA0zDsWFT+ETX+duhiQwbLZ1OrB0DivWaZIOOfIhOwdRJ0D
         ksEZrzgPjEexTe8nIGW0i1PxPoYjG+KubDHDFJyU4gCkNJU9zg8b+m3D46dx9B/VJKTY
         cVpg==
X-Gm-Message-State: APuU4Z8OuaS7AzcI54tHSjnx/JKsVqC18Xwa4SszYEG8r8/Er9TT6Npr
	GGYkrBA0lnhs4HtfPIVPHFvahKkiUSNtmsU4GDtDcS0bQ5AZw91PtaZMZpVJ7wI3
X-Gm-Gg: AYBFou1x8esuIWMXVqKQJPBCTYTpaUXzAKvLZH7U13jVpmwVB0zqXNOUg/CKSWOgmxl
	DRsCWdofU5xt2OzokzEgxiX94Mriklsinwh7hkwFX+H7jme7PpRMCn4n5+6R6rlva8lj1+f/Qjv
	wgFud/2op/b9txZYGtGI1Rt+s4fNEAXvIqRZKioug7aqkdN5c3q7Bn+QNK0MWGnk9P15jgHNLmi
	GEfrvXP8WKaiyoDiOZ7KoZ7B3gvedZTHBmoT5BxYnChm36BlD2PLE7QgW8pLC5B0is/cmCku4ip
	4Y2uQ5lQabZJIsxIbAkeKgHxvkRgSW/OEGS3dG+Mpis6cuQmPfyoiCo6hzF/Boh8HZT57x2wupU
	K0v0lORDRjW/d/bodXKHPq7MvhqQlZMAdfkZuabaIkxzUBsA6xiAe/HfjtJFxiHPsH6jmZSiFHt
	sGqCkPVedNCSaXm4rcb/mlTK3L2DbSddGYhQCvJpfjAQMUaQdbpEM8QW9SsKkvdSuJHi8enrDbn
	ieHOTVJqP5RzZuYYLi6M6Rpw2bxnpVrp+00EaIK5U1A8pw6uGNfGLRkwsPvye9CylphIDCKopjT
	cjTCpUpxL5umcijyuIkVsUXlIKS1wt3gLu0amiwH+LOGQ5ldGRW6vYHLs10LS6TMg1TmYibyvAW
	cvzGbDJIGgUckMfJfGCmm/6wj+pOM5Gu2MTjyEFwQs1hoY0Mp4eyJiSRTpNbpuYqKmcU=
X-Received: by 2002:a05:6102:374b:b0:7d2:75bf:2fdb with SMTP id ada2fe7eead31-7d4ee1e5ba9mr1717334137.2.1794495707226;
        Thu, 12 Nov 2026 07:01:47 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04fb371sm74191346d6.25.2026.11.12.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:01:44 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	on Sim <tlatkdgus1@gmail.com>
Subject: [PATCH net] sctp: validate SACK pull length against chunk length, not skb length
Date: Thu, 12 Nov 2026 10:01:42 -0500
Message-ID: <3fbf59d17a91c46098e3d4115e06987918b68c45.1794495702.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
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

sctp_sm_pull_sack() derives its pull length from the num_gap_ack_blocks
and num_dup_tsns fields in the SACK body, but validates it against
chunk->skb->len (the remaining packet data) rather than the SACK chunk's
declared length. A malformed SACK with an inflated num_dup_tsns can pass
this check when subsequent chunks pad the skb, advancing skb->data past
the SACK boundary into later chunks.

This misaligns the skb cursor for subsequent chunk processing. When an
AUTH chunk follows, sctp_sf_authenticate() reads and compares the HMAC
digest from the wrong skb offset while sctp_auth_calculate_hmac() writes
the computed HMAC through the correct chunk_hdr pointer, bypassing the
authentication check.

Fix by validating the computed pull length against the chunk's declared
body length instead of the total remaining skb data.

Fixes: 730fc3d05cd4 ("[SCTP]: Implete SCTP-AUTH parameter processing")
Reported-by: on Sim <tlatkdgus1@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index b2f609f177fb..44b1770d43c1 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -6368,7 +6368,8 @@ static struct sctp_sackhdr *sctp_sm_pull_sack(struct sctp_chunk *chunk)
 	num_dup_tsns = ntohs(sack->num_dup_tsns);
 	len = sizeof(struct sctp_sackhdr);
 	len += (num_blocks + num_dup_tsns) * sizeof(__u32);
-	if (len > chunk->skb->len)
+	if (len > ntohs(chunk->chunk_hdr->length) -
+		  sizeof(struct sctp_chunkhdr))
 		return NULL;
 
 	skb_pull(chunk->skb, len);
-- 
2.47.1

