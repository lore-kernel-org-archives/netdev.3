Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707459;
	b=ok5ASlFnH4Qdw/QUZMpKvBs8Jc4oS+YUjP6Vr2il+PVuBx7j6V/MzBwljcrLLVLALTG/
	 Da25TMz9u+w2slUt3weNpnTVpzc3z/bClTk1LhFS0t1QrxIyFPhfR7ywNV+WkUP1znsJB
	 9AXPVN27KqyH8dDOcc6/X/GdIXAySBw6cjfjbH35o+E5chzV8pL5oSYpJ+vs+lMp4uIen
	 adKhk6ltq9vZI7bLxEFYwsECX3cQP38+nev10T1u517RnS96pGWqlatmx6V8MP4fDVrjw
	 MaqhUq+j5Di85nVHOvog+YBdft4RZQ+mqScOzCGkWfVP6MBZwkCcZ2uZbmcS/DcFZlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZeRVw68ns3dubaW91d1DmHv0Hys0HQ5dAgi65zzLGos=;
	b=YfEy1OUOlfNx8xtfs/sABV80w/zB9CQoChhTp9HC5kUX91Dmmo5tT6KCsCmkjSm8KY72
	 1JNNbiXtnuG1ghXJ3yR+5YqdgiUuaaF90BjsckqNL3VKsGoxUAgdyc/GCOpJ/dU1yhigl
	 aaY+zuIoWVM67dXktIxJejJ5td0uyhsgRpYnYUUuRA1vZaq+My39Uo0dfpPVKxeRcBh3u
	 9hjNL0iqHEYelauu2oB1yq1MuMrtllUB0awj0bwHHBJtTk5cd6UDNAlM/Fl9xHgoy9s14
	 Fk+WaDGR4MknH4t9j+2SFIRY8wFQLcOEKNV2w/DM2k0b7kwtLbPFhmY+ZiQCYaLerzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Qhkr3iQz;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789D3606A327
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789D3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Qhkr3iQz
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e987a2ba0cso1675105ad.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792707458; x=1793312258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZeRVw68ns3dubaW91d1DmHv0Hys0HQ5dAgi65zzLGos=;
        b=Qhkr3iQzU5r+xm1zqm8l3OMO1Z6GhDd8+H1b+P9KkQtJzuuXsonkyYS3OXYgyGs+3U
         Z+3OZ2elaZY5S3Y+mTHHQcwz18T9n6oC13gzUJilud+/5YC5VIsoiYQNhJ42aD0MnUuw
         X64/okuKz5cFTjkgYAoD6nqqIxbaYXdLXfv+GUBSNclWMwtS53SOmteVm+eNcex7GV/O
         siAK7j2f/IvKkM1oh5+0qxYANQKDJlSTNGMU5je8gzrJoBxHQFYNbgSHnkLkVCI5T3By
         bHfVGDxmjX1iqra8i6ssQYw2C/SaMWyxX+ou3TOPZPWVmqsWKPAcJ/Edo+UAAnKAKqP6
         RQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707458; x=1793312258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZeRVw68ns3dubaW91d1DmHv0Hys0HQ5dAgi65zzLGos=;
        b=QGRgMQ7RIrM0Zd0sRi2LgYW+pLK9XTC8SqqfVBLXLdFA9Mcr19c+n4Gh2xFEXQ+V+n
         r9VXbbv09OIZ/AB92x/S1wbt12CObRP6wKv/Fr1x/0ei/A2SsDwTFkcjMu+giPLW3Amh
         qMreGBj1f+SCztV9vzpCW7XREOYoPYvElVup4As2jNWpfOkfTcKmcwA/rP+awliOyno4
         GlpEvGKo2tBf+9+eMNAS602AHwloeSmRk9B43Tyd/F6S8NRWBrKalF7krDrlwHa8MOkI
         CW3D3qY+oP6m1J+2UqPLDV2r4D5IQgy72OEntFGFNUTf2A+JRthsOBVXs78IUJodO3B+
         JJzA==
X-Gm-Message-State: AFq9FYLnb4mRmgeUUWHLKfVlNvuxJEW7ie0LC6NBnYa4R9P5oRgDnsd7
	WAbDiYpTQhTZXHXRTb8TRSP0WsDeoG2AEXh3ed59ODC2UDkU767y2zJnFbRSgGEixhzfFuz0La8
	HiKrmp53j4F2cdFMPT9+BgR9FvuoaAQNJynYd
X-Gm-Gg: AYBFou0Gjd/SiIRxjZ7I2DwfCFM9S55Hk/yOihNR1AVoy6AXq4RjITKE8QGi/zUSJ01
	MpSyHLe5Amq8LuvmOmcXzIXkNWgBM+hFlmDvM3A2IMcwVl2m1eVIAXmhXJWZ5lQ8COz7FW4YEzF
	2W0UNio/Q4lBUYF4HSyd6P7B99e6aWuf5PZhL+EahE/1riwt9X/JIGlpDPdFNm1O8v/+E1Mdadn
	NYfYgDDpfYyHStRdJW06jQGbj+ggLu/yadCiyp4wZ6H/aAW7CP5V53qD4klhiDhLwYcnR6urxfW
	x0pY9Vo1emrZrfrVkKgCnhiXc5lwWyCOZX6GpJ6Jqt2tJzejHO2PGEPmYYCNXuIzVZqeICTyzrO
	PYXnaKYouagaR1OZwKeUfxcn5u8oquLMAcoc=
X-Received: by 2002:a17:90b:3b4b:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3adce74cd8dmr182025a91.37.1792707457866;
        Thu, 22 Oct 2026 15:17:37 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada488f10esm2924461a91.2.2026.10.22.15.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:17:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 370D94029F;
	Thu, 22 Oct 2026 16:17:37 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 27598DC48A1; Thu, 22 Oct 2026 16:17:37 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/4] tls: device: fix next-record sequence in core-driven RX resync
Date: Thu, 22 Oct 2026 16:14:58 -0600
Message-ID: <20261022221732.1397620-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022221732.1397620-1-rjethwani@purestorage.com>
References: <20261022221732.1397620-1-rjethwani@purestorage.com>
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

tls_device_core_ctrl_rx_resync() asks the device to resync at the next
record, passing rec_seq + 1 together with tcp_sk(sk)->copied_seq as that
record's TCP sequence. With the original strparser the current record
had already been read out of the TCP receive queue, so copied_seq was
the start of the next record.

The TLS-specific strparser leaves the record queued in its normal mode
until tls_strp_msg_consume(), so copied_seq is still the start of the
current record. The resync branch is taken when tcp_inq() does not
exceed the record length, i.e. typically when the current record is the
only data queued, and the device is told that record rec_seq + 1 begins
where record rec_seq begins. This can prevent hardware resynchronization
and keep subsequent records on the software decryption path. Further
resync attempts are made with backoff.

In copy mode copied_seq is already past the record, so the sequence is
correct there; the only exception is a FIN consumed along with the
record, after which no further record can follow.

Use the record start from tls_strp_msg_seq() plus the record length
instead. That is the start of the next record in both modes, so the
reported sequence no longer depends on which mode the strparser is in.

Only drivers using TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT are affected.

Found by code inspection while working on TLS 1.3 hardware offload
support.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index fbfe6ec3df04..a6c4d0cc54c7 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -839,6 +839,7 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 					   struct tls_offload_context_rx *ctx,
 					   struct sock *sk, struct sk_buff *skb)
 {
+	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
 	struct strp_msg *rxm;
 
 	/* device will request resyncs by itself based on stream scan */
@@ -877,8 +878,9 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 		memcpy(rcd_sn, tls_ctx->rx.rec_seq, prot->rec_seq_size);
 		tls_bigint_increment(rcd_sn, prot->rec_seq_size);
 
-		tls_device_resync_rx(tls_ctx, sk, tcp_sk(sk)->copied_seq,
-				     rcd_sn);
+		tls_device_resync_rx(tls_ctx, sk,
+				     tls_strp_msg_seq(sw_ctx) +
+				     rxm->full_len, rcd_sn);
 	}
 }
 
-- 
2.50.1

