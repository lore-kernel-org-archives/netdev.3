Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AD39DBCF
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454050; cv=none; b=BcKokLPkWQJDaH4YhkEH1VhmbOnEG1zG2UuJ9ZUlUuI00TyHJ/cOsW2LBDiGMaH7T4e6gzHw0VRoLvhSXp8lPmrOyvp5pJlPSt1kPp3nNLEsjjDMKIW9W7jxd1rc2Q8DKnnVhBbiyNOfy0yPOZWp6Pjt59UHHVrx8JKL2EhTsag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454050; c=relaxed/simple;
	bh=GlbMW16cWePyiBYsBiTwn3T2wFo0FMH24Fs7bx2UT4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APivTqe5lUNNVRQH/e2UtYps+XRqieja0t9POusPuSIZ3s9PmddgXF7bFrhW21YUejfD4pTokvA/eSZHENmisrUQhsrlcs10zPrqfDau9IBH1q4RGioY+0lIDqcDCEMwZeeXDvTXxvpCGTXBVxFycNaDhexzAW4Yv6/SerDUl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=c80VPhq1; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="c80VPhq1"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-141395927feso4487054c88.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791454048; x=1792058848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KowlVV3ESFLiuSvKMqmvAeVg6XfBGA7EpTgNWFJwW8Y=;
        b=c80VPhq1P4UwWuQhKjHUykbaGD2PfCAsjKGqlOSmgO/+VrAHFj1Igrwz/OsG2cM02K
         P5DzjchJbSu3FCTL0HYswFYCV8+w1YuKcuiCPl7X48sU9GTFo0Y9n9in/lzCBPosO4+d
         Za/1iPspVJeBpZ3S+wTn/o1Wmq/xSlFlwqCk6xGFPHfS6yW/I3QxEG77Mhx0T5fCp4Ck
         34T/S2iAoXpTW94K/gq/zcSOeThJgj7tXBtLUk7q16nliHk5TA/EpzfEheV+KS4CSty4
         8oLpiS2fp3beRetONVH47zVTalaCRuoged+AY1Cn5KWpf0W5nVH+/fp4OzB1SWkDaSq/
         v3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454048; x=1792058848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KowlVV3ESFLiuSvKMqmvAeVg6XfBGA7EpTgNWFJwW8Y=;
        b=Meyu7SfVtcTh+NXHDSpP2B8BDGRf48PoeNZldAmk4gL4rzOWFH/Cm55OwINmFkGtLI
         IDA1Qf2x08Q8kDdtpB/uwbZfjudXzndMiVWUKHFtPPnpNwPxeLjAuJ7XIH8ZQGTKLYtu
         usMZFpDZU9OHVNnZnDtpQFLZW/K9Aq5RAvBQjkofsxq+YIx0MV3PsfwNxMLAJpjA1taC
         beNTD+5Stee6IiUAQiu7m6OF6A8hXyZlK/Yfk4f73wra/+Rd46tfq/PSSQbDrPRNpEpg
         +9aAMX4XNNlIE45U+agZV84Pjjo7px6f/qlrqHYptQ7UMsxzM/Uh/ekquVMA/PyNTY+X
         klTw==
X-Gm-Message-State: AFuF++kW628Gli+rGNm+jnVg8iMZAvVpoIM5v5vicaJQQX/RXCXwWWKu
	OSc/v8zu8MUZ8chAt4R/lVIOw3LbqYmYkEBAbUz+wsLpGPb/aaq5oyl5z+pWj1ArYR2iC7uMVeK
	/YK6Ium/WwULkA1Y4h8PwZlim0mmwQHgzHgQlMdb0FfAvpahJCdg7xceobPEdObL2BgOCadyi
X-Gm-Gg: AYBFou2CtLOsSv6R2b0/9ipYnLA6Zk4QVZm7pjSMsMMTekCkTpZvCl/HMxa4bwhKjsV
	n4TWY4QYARld2bQI5uJfSRqsZtH4fNnSIBSHOh9963GhJwjVfdDCdk5ED0TSHBNqRBa86f70Qlx
	lN7eXPnUoH2nibRsx3lLp+/Uh2iM3taIFG3mQp8xIM833dMS3WRryXUg9jVqwnQiGrtNYjJhVPA
	i9GIN60Dd3XfNQJPVCwj5VL84zk1OdcVxxW2zJiuMuPOEtganvPj+YDjHqqjFi/eO1ZqgzoDHdx
	Rdp3CCHfn43DwmP4rV0irF3qYS9gKx6aaJOoYYW/QghCg2LuZzyWEubpSwAVkjGYpts0b3qbD+u
	sjNhKujECzS2n0Znoqr7aEW/Xs60K4ksRcEc0hYkABetGs3gRQMVKV4D55S3JAufxguWNfgeucN
	z+X0H0L99D1hUGSYBPKgt12GzeVsEz2KdS0W1EPtjBZWdnYwoB1Osjg5sSzL3DFpg3NIN9rXmdQ
	z+b5vCa3x01vCMwqxktXg==
X-Received: by 2002:a05:701b:290a:b0:14e:8d1:1012 with SMTP id a92af1059eb24-1620551441dmr5744288c88.19.1791454047363;
        Thu, 08 Oct 2026 03:07:27 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm14200933c88.12.2026.10.08.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:07:26 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 4/6] net: gso: clear the GSO state of the last output segment
Date: Thu,  8 Oct 2026 18:06:49 +0800
Message-ID: <20261008100651.2534957-5-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008100651.2534957-1-wang.zhan@smartx.com>
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_segment() clears gso_size on the last output of a group which holds one
MSS or less, but leaves gso_segs and gso_type as the grouping set them, so
the tail is still counted as the whole group.  Readers which take gso_segs
without testing gso_size first, such as the ECT statistics in ip_rcv_core()
and tp->rcv_ooopack in tcp_rcv_established(), see that stale count, and a
re-segmented output reaches them when a veth or bridge port delivers it back
into the receive path.

Clear gso_size, gso_segs and gso_type together with skb_gso_reset().

Suggested-by: Willem de Bruijn <willemb@google.com>
Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1feb038d9ff680..43d63cd29f694f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5125,7 +5125,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		}
 
 		if (tail->len - doffset <= gso_size)
-			skb_shinfo(tail)->gso_size = 0;
+			skb_gso_reset(tail);
 		else if (tail != segs)
 			skb_shinfo(tail)->gso_segs = DIV_ROUND_UP(tail->len - doffset, gso_size);
 	}
-- 
2.47.3

