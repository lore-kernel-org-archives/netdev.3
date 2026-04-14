Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BD3B2FC9
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155601; cv=none; b=DEsGcXMDpN5dAD5ttokZtNaqJXQB4gDJptsC5BuoYsMVNai7HVhHuGstGeGBWXwILOr4d3msFOTgekScY3ewkIyuXIQ6QLK7DvXWuvbqtTUml+U9E0MXqbnvfReuVFKWVlPRl4RpOtMBqDe4hCKpJaoNuxS+DHnYUhHxMrWkFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155601; c=relaxed/simple;
	bh=ZhWN6SxhuWfyxgKUhrRsIRlcqgS38A0PyUD34h0n8W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqv1UwTqEqhF4/bCNUJk+YaeSOQR9vcqxZNOG1ehjc9fGGrB3x85Jy9Rg8+UAuNVw7YeWiw8WyPi24P0x//gxZrqtVfsDO/ec0Q08au/jKEvLWaxFrbj/IXF/+5EDnjY55oieWriQntoqRhNhwf6XubiIHOM/1Dyf6KEAYfpr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uI5KRmwD; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uI5KRmwD"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d00dd913cso5772119f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776155599; x=1776760399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yv6nANFBDeTvP7QOj+b+BGfj5pgYEttgQLR0Ky5nKk=;
        b=uI5KRmwDq/jPx7Wxt4qdgGVVo/Ikrnx79xDBbfeiiAD1mwCZFHBLL+IvYvhnoQYWB4
         spY0NU6qKmAZBzOnlefqjOrkzsflgKLBk94QGNSO1WId8//H4gbxO1o0GsNWaLJDay39
         c5jsa928o4x/ZDt5wXcdeOYgLusOL3xdHSWFne8PETsYznbRvMvXSAxtNUe0FwynKemG
         InyXelLuHjS2gYN9vsK9O4+npnMftV9xNN1NGY0t2u6MArgqrXnCyxONl3dI2nxkNsrK
         Kx1zaz8zf3civ7xANUZ6OF4y9500cwSlyqfilLlEnslcYsHQGDLO1uTerQrZ1yijXv/3
         zMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776155599; x=1776760399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yv6nANFBDeTvP7QOj+b+BGfj5pgYEttgQLR0Ky5nKk=;
        b=TXfa7CbOA4P45d/siwzaa3LAyhWcYg0r2YNso3TLwDYRqgMCNRCK7cgY39v1QbBHVR
         jp23s8hAOZp3omdkuuD3ZmpSWL/XLyGkt+b3g3QYsDdDxBVwnhYAt9R5ljIHgGoKAWmg
         CRIkhqC1Uo1QBcHpLxg2kTZBJFuhV+Dn8s7jGyv/IvdBVWQPJi1kLGEyHNAGB2Zy5QHg
         5EVt2rxMWPvt6WTV5ViB47DI6N9X33XM0yO1zHQ5YUuFoElxnqc2tV+dClv4aoaGSt8q
         XcjxZH/7Cg7srA1L2JK6p6mSg82zs+5SvOIhk4DJMIrJ0LVBBN48QHPVSuaPeTfSdxpE
         01Uw==
X-Gm-Message-State: AOJu0YyRwhRuoz4RIdrWyRSJdzWSGmLoIGlA68zcQo63bhUuKZyOrvH8
	8G+8zHNqWOuE6FpaYQZLMaQI0cmoFy2O4XOgp3rrHlkZk7tNmlEmuae54p9tm1feW+6ZwXvzSf7
	VPTQEUQ==
X-Received: from wmgg21.prod.google.com ([2002:a05:600d:15:b0:488:7af2:fae7])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3149:b0:488:ab26:8fe0
 with SMTP id 5b1f17b1804b1-488d68432f2mr230761425e9.15.1776155598632; Tue, 14
 Apr 2026 01:33:18 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:33:16 +0200
In-Reply-To: <69dd48c2.a00a0220.468cb.004e.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <69dd48c2.a00a0220.468cb.004e.GAE@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414083316.19864-1-nogikh@google.com>
Subject: Re: [syzbot ci] Re: veth: add Byte Queue Limits (BQL) support
From: Aleksandr Nogikh <nogikh@google.com>
To: syzbot+cib904ea9ebb647254@syzkaller.appspotmail.com, hawk@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzbot@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

(forgotten to Cc the right list)

Hmm, just fixed a problem that may have affected `syz test` processing,
let's try again:


#syz test

---
  drivers/net/veth.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 911e7e36e166..9d7b085c9548 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1138,7 +1138,9 @@ static void veth_napi_del_range(struct net_device
*dev, int start, int end)
         */
        peer = rtnl_dereference(priv->peer);
        if (peer) {
-               for (i = start; i < end; i++)
+               int peer_end = min(end, (int)peer->real_num_tx_queues);
+
+               for (i = start; i < peer_end; i++)
                        netdev_tx_reset_queue(netdev_get_tx_queue(peer, i));
        }

