Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159783DFC7B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234205; cv=none; b=t2I5OrHgTugRkK+cPskjJqmaI5W6xtqXDT2BY6Hp4aeEojq1km7H6sO8MJNx455oi/Yklb0M9+M6iCc/Da4mSkqSGOaLv02eTPb9OMa3mgy+Yv+heSNgWUOmd0lEiy/5WjueKOqw7FDmsvT+b3rcSXNXyrg9f/3AvFxLN2aXl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234205; c=relaxed/simple;
	bh=GTEVgAingNMNvYRd0hOrqYY22SEBjqYKvF61JqVY9do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mmz1oMvl2h0SULo2DICHSkuGopBsywE1VhI9JMsFBGSmH+sxxpsxdjLq89tnjVUlcYUUuJZJU2t0tBlQsfN2fblek8gapEfYNkaEezNrz0WN7eEjs8Ogk2CouHy3rOkBsHxx8nc68pjF37fKAyVPGcvld1sVJ3momJ4Jus1KO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxCcrb3u; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxCcrb3u"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso921561a91.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790234191; x=1790838991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DEBq3oR2dxLOGmSLGFiZZ9aV+cM/ZzcBmqDLieFfw5A=;
        b=FxCcrb3uD6nrom6kzH+joZQKgjX+gQTMX0Tg9kLJ5tp5ChTuUxTCnDqqRvsSx4V+GN
         lTt9XfKGvcd13EDV1E+I49+0vLMOD5fAv0gbWfDA3TNwsg8NLRPL2no5vGNElNaSrVpf
         TSvO90CS6NVy6mULmMGJmbbi226nKXaolR6gl10tVUzutRX0jRfWtEO0Y5ar+NAHxJ89
         XUGf9p5MXnEaxrT2/ia3kLyb6ISqxovLoqEcT5xJE4jlZmW8429/7J+OFacD+vBWuiSW
         Kl9pGv7RX1o0nqJ81pMXXav7a5VDv7+xGIJ3iPRWLD+c68tG6b4aBSSuold3tnLuspM9
         93Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234191; x=1790838991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DEBq3oR2dxLOGmSLGFiZZ9aV+cM/ZzcBmqDLieFfw5A=;
        b=x77J+UwvtnFAh1KEnzHR8Gcdnx0bFq5VFW4080XkMu4OmLsLb6pfdEZqASTumrEqVR
         7IeeDhx1IG0wN/ZvUEVkUyyG3IZ57IzkkxO9tB/x73EQKYLqas6WqCy08MRjkKrdFYlB
         vc+ljiU2nSzebjaMFP5FnxOYRvqVtkbSIBOXGhRgXs8nVqT2Q94exHfPQI+GteqvPcFz
         vzCBfjjZYGVyGnirZiSKGa6AddZwfdc/hwzJrESApDzVCx0N7tVJuGe6iFU9WzQrZkbB
         wg8mCet1L8F9Xb+LFZT/+YuonPssZipi14nZbDWE6LU7OKx6Dvt8voHlE0quMBJ6t56m
         slcQ==
X-Gm-Message-State: AFuF++ns0ZLqcrZ2MWH+ojsJvHm+o6BVy6RGfASVb9IXCF3VPYP0LVnh
	cXjF9lBoDsPVgTWO3kQLNnOqDJ3H36e67EPNHMD2k1itNxbymfa6VyeM
X-Gm-Gg: AYBFou1RrhbN9/cppsCbGxUcgpacNomXmCUZ5mRdIBqb6HTI6zs5NsDpKiyBMiezYSY
	q8UhnM1pm16otSPVNbOYXwbFkbehJRsk3naGDXEnyDTwQmTB/SCUIA/oJsmk7GQh6Dujl8OL6JF
	1OSZxIDtizhyPRrNUnrtpKtS7vTs68fSKNSG0phy5SZG0Fa7rGKrggkhyvDl6tke0H1FVxRpnxW
	3g3oGJP4oZQOrPhGu2jx7UNXMf92fNxinQzcO4m5tpuJN5iZ/X0pCeZcpFNGIAfJW2HNVkrisIE
	tDOpuQn5/XxSXps2HGigEr8fuFogDA8w2V9ZUDLRX+6HOf9ukcdTTX0q/vCcjxhw81+2TFxOJKU
	oRU+TPXO5gE7Ei6GwpLLEgBs0DcQG7sBpdaLXJ7xBA0tSaj7VxieCw/22/oWJVPhyx9RZuAu/yA
	1DvR5E1WETZhs61f0dFwTUq3MpaVLDibMSKIGx5fMlB8esKuVQ4hO3Rpihdyo3X7WO9NvXA6iWu
	38xZSLSeU0GD+2U+tAn5RSOuNrWJLeBTtLc5vuiKYqYAlG8fXiW//BGMW0l8XOyZnOjfrgszfqo
	s0F0I7jNnA==
X-Received: by 2002:a17:90b:3e87:b0:39e:6a80:dda0 with SMTP id 98e67ed59e1d1-3a09872e15cmr1359457a91.39.1790234190967;
        Thu, 24 Sep 2026 00:16:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa00sm4003402a91.5.2026.09.24.00.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:16:30 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: kuniyu@amazon.com,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v2 0/2] af_unix: fix inq_len accounting and consumed OOB skb handling in unix_stream_read_skb()
Date: Thu, 24 Sep 2026 07:16:27 +0000
Message-ID: <20260924071629.2683160-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two OOB skb handling bugs in AF_UNIX stream sockets:

1. Decrement u->inq_len by 1 when manage_oob() unlinks an unread OOB skb,
   preventing u->inq_len from remaining permanently inflated and causing
   SIOCINQ / FIONREAD to report a stale positive byte count on an empty
   socket.
2. Skip zero-length consumed OOB skbs (after releasing SCM rights via
   unix_orphan_scm()) and pull UNIXCB(skb).consumed bytes via pskb_pull()
   in unix_stream_read_skb(), preventing BPF sockmap from re-delivering
   already consumed OOB bytes or partially consumed skb prefixes.

Changes in v2:
- Split into a 2-patch series as requested by Kuniyuki Iwashima.
- Update Fixes: tag to f4e1fb04c123 ("af_unix: Use cached value for
  SOCK_STREAM in unix_inq_len().").
- Call unix_orphan_scm(sk, skb) before consume_skb(skb) and use
  pskb_pull() instead of skb_pull() to safely handle non-linear paged skbs
  as noted by Sashiko.

Hui Peng (2):
  af_unix: decrement u->inq_len when skipping unread OOB skb in manage_oob()
  af_unix: skip consumed OOB skb and pull consumed bytes in unix_stream_read_skb()

 net/unix/af_unix.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
