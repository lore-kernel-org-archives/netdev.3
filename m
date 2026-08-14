Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA330D3EE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751008; cv=none; b=TFuN78XkKTb0V83ko5LHD+4RL6feJU29S1bFT0d4eyhTBGWhN1wNtDhs1xIATnvjuMMRqKeJ9PT+IifD9y1te7I2RP1rqyKBdquGNNuJcU3vGAzdfkGoLHtxWMgYBbAbv6oGaXFyIlGcUE8HdvDMjSSbHCaV13aZoeP/0wm3G78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751008; c=relaxed/simple;
	bh=uXCmLdtsriIwhfcLVZktZxvc59oX7Vo3jJiEN92QLWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tstR9K2C5KEXdcVbxH36pIWKDjp3Au9/CIGyLr4x/3N5lP24AhOmqcGRQe9NJVE0OUHv948fiF9CqAsd1H57MnudlkcSO1oGw75t8M0nqJLfnDbfUxrYYJU6RmMRSp7c87LyXLxt44t3/kYSMbV+F7cdJjQFM8TQ19OSZN1QMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suKRTKQ3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suKRTKQ3"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1667746a91.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786751006; x=1787355806; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1OOjpIXR/O1gcOMsnaXMiF57IBf3F++it76I8JlmO8=;
        b=suKRTKQ35s7VhrLwFvFByXaqsstmnTEBgu9tMPsCMMXNHBPv+DICEY6Nkz7o3Kb5q2
         4+AnOVK0pbqg1dHQGFWbjurwPUZIDV2lCCsL4kacHD2SvhytPA0mrf7/ctIucjBfACVw
         RT6ch+TXTv5kOeI1NAct5ZX6D/hJgytiC9ty41kIKbWbMkxebCRmuSCE2ttFMCJVRiIS
         bacaOR5M9YNS1yvLWS3qG4tiH0Jz5PoZ4womCJjIpDffAQZalFWyj5xZ+QZLoljVIfh6
         PASfDEXWYj+jstQrjpndeIDu0oViSgTberhKQeV1qhGAKAqHtQjTVmJFb7znbw0vUgaX
         uwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751006; x=1787355806;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1OOjpIXR/O1gcOMsnaXMiF57IBf3F++it76I8JlmO8=;
        b=Y/saQADBzJ7o+y3hhrITzIS9hRdWB0JMxcZCDUTJ4UhVCeft476Z08w7zmd99opBui
         dr2uqDIjlj1SEvZEs2EJjUbB9+6z/iRdmtMhVwjvSmW70o6CF3ZjoAnVCLFwQSGchSmr
         eSGdNw98/7diPbqgWMKvDyA9AFiGj00HkN6D2kDxo08NKILYwri6XSmRkckigiQJjll8
         lu29HZxVmx9ary8PD5aaD2IeTV3utTooQAHE2ybQ5/7a9XYJhqxKQ6wQYC70AanJ355P
         lNCCDVPrv2nQSjmmdzsSSnb2yb1yHna5DjPACvdqaFE8v+cHUkZShhpY6li9FHilEw/6
         Kpmg==
X-Forwarded-Encrypted: i=1; AHgh+RrL49nOxeEHfp8ccyA2pAd9M0K7tjGSnObKF+GnzdyUEkpOyGGGAdFb0/DAWeh5uY1ClmmSKAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytwKo1gTEqtvoirFvodihlH7qWanuOvlyTKWIdwHk6GJaLyIj
	h3zreWjExY/wW1nd9jniNufm0MydtYy/igZOPfGEl9jB0f0IWyVkrHRb
X-Gm-Gg: AR+sD11q9yW4EBEqh/Qrwl9nFtdDYDG71VsGxKRV0ee+VcrDvROToKK9NcAcpiQgojZ
	+T11kovMIbWaq/hRRpy4VFleFNseYgbkitXn0EAcNGSYJF1uxHrzZ5e8NpoA9sRQ2BmxrHtzXj/
	k3p/PPWj7jLhqLhlv7QSxumwl+eqBn+3h0hhMfS77gKO+af61V/odY7CQayuR6VdTpMf5+J5oTb
	SZb8kCEoC8U3I0sUMxuR5HUIg9M2zi4/xZLWyyu0gIKwjLzcoivUzIQa+X/F3+0MKRvWMXZY64M
	IFQlZy7m2p+gYuBkxPJ3fOjYygNSRDLWD2HQXb4XaIvS1wD5bW+8UEdPecZjmoGtrA3zgpmwcDx
	zrPwNJp/ROPw8WcpdwGczFtC1JmTt/0b0Aw7FesdoZeJ4z4l/2Hj+TEH1kmkanF33V2pFJW6iIT
	qmx+t1yk07VPl1oog7C1iwuTGagBbMwc4sejHXHQnWN6l5f4665pG2yCDXnGciCEEjffuLyo4wc
	pepkl+1pQmOc50FK9w=
X-Received: by 2002:a17:90b:2d07:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-3933bd18856mr10849816a91.1.1786751006145;
        Fri, 14 Aug 2026 16:43:26 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea9a1301sm4537942a91.7.2026.08.14.16.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 16:43:25 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:43:21 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] sctp: drop a backlogged chunk if its transport was
 removed
Message-ID: <an-oGfEatacPTSX-@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sctp_rcv() resolves the transport once per packet and leaves it in
chunk->transport. If the socket is owned by userspace the packet goes to
the socket backlog, and sctp_add_backlog() takes a reference on that
transport.

An authenticated ASCONF DEL-IP in an earlier backlogged packet can remove
it. sctp_assoc_rm_peer() takes the transport out of the association and
calls sctp_transport_free(), which tags it dead and drops the reference
the association held. The backlogged packet still holds a reference, so
the transport stays around.

The DATA chunk in that packet puts the removed transport back into
asoc->peer.last_data_from. Once the packet is done that reference goes
away and the transport is freed by RCU, so the next delayed SACK carries
the pointer into the SACK chunk and sctp_outq_select_transport() reads the
freed transport's state.

Drop the chunk in sctp_backlog_rcv(), next to the existing rcvr->dead
check. The peer retransmits it. Guarding the last_data_from assignment is
not enough, sctp_assoc_rm_peer() clears more than that one pointer and
letting the packet run fills them in again. sctp_wait_for_sndbuf() already
uses the dead flag this way on the send side.

Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/sctp/input.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 864741fae4187e..83b8361d149251 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -285,9 +285,10 @@ int sctp_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 
 	/* If the rcvr is dead then the association or endpoint
 	 * has been deleted and we can safely drop the chunk
-	 * and refs that we are holding.
+	 * and refs that we are holding.  Same if the transport
+	 * we looked up has been removed in the meantime.
 	 */
-	if (rcvr->dead) {
+	if (rcvr->dead || (t && t->dead)) {
 		sctp_chunk_free(chunk);
 		goto done;
 	}
-- 
2.43.0

