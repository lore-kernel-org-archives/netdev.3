Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618912;
	b=fhXMkZdt5AO07tmIuFoE6CWeN2i6/iBFf8x7B+sqeretnMDeFrR4BouD3s15y7eWEnh8
	 cZ13bQ6D5w5VePa8lCbfl5dxApECWfTL70cCJQ+ZSuLwQmRlsjCpehhXOfKzn539u54jh
	 NkrSy6YlMW+5LxL423J8frT3ykTD/+HY9+PE5GF2APCDLTsN1K1yK6huRT/IUXc4x2Jha
	 KuCvKDVEIf/PS4sUA+m/fTSyt6rWyngQItvJdf3btXARuuG5fhOZPS9SFw9N0uu2cfFFU
	 qmbGZNelW4vXsgzDR2ywYX2gPcRpxySU49yTpDajQzgApIfUiFdcG4T2EiqC81cY0kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618912;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TQgc/Sv/vVtb4ztVLDjp/apjsYVOlWeJnRW9JmC1NgI=;
	b=3vXTBjG0c+TVMIE9nFGNm6aZYF/HnfGfCOoHMM48+F18aLiM9rvd6Gy7SuVVF/ie1kTm
	 shEDE11gPXRpbPZRYU4E4LczD9Pa7zZQxD5wRkodNo/stTUkVVYBHQ8V66fFrnyv3RT7P
	 ubw1QYdCj3AvLXUUqBu4dfRRbWcQUv2xbFBh4WWSb6GymHwfEZ7/RmnR+9bqVOCyhLRQP
	 k1shEWVE2npJcu/xAJGQ47tnghdrqcC953miDQOX7ZEiA0nWmvHqVoS3WumWdiwN51oR+
	 6gd91glbal6DTUYgYXeZol1Bb9J/jaOEZOxRE4lBv3wNvUYKHDh3hbkUeHZ9S8Agg6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZnuzoiwZ;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD260A382C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FCD260A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZnuzoiwZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793618901; bh=TQgc/Sv/vVtb4ztVLDjp/apjsYVOlWeJnRW9JmC1NgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZnuzoiwZyZ4A7dbviuToFpT4xd3xgy4Hndl1bi5mzeFqKwY64L9jk0eXBzG6P3Tpb
	 aEaW6JsBdBU45/efmn+eIsRtg1inoE4WaysQnElmXIIBNCi+/qpzbV1gXllVhlX9nx
	 RTGjUw/GfYzwx8YNV2n49+U3Buf94K2T5C1iRamI=
Received: from CRASHEDROM.localdomain ([117.147.101.47])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 70D9DAA4; Mon, 02 Nov 2026 19:28:13 +0800
X-QQ-mid: xmsmtpt1793618898td3x2vkig
Message-ID: <tencent_309B746FDD0CC5631C016A178C8301E5A90A@qq.com>
X-QQ-XMAILINFO: NX5lOJh5Otailc7P0JnaA09peI8WHQBfxH9wsQWu2Dpw361Mf5m+lCQPXpGdRq
	 iEdJcVY65h2PqRWcBepT7LpaYPfFmi1jDJ/c/eNl1Rex6puMEx9EoihjL3g0ISOdRy4LrYlOkvY/
	 1rioAyMlt0jZHFyliD+6NyUrrSifC7dh3aZxWbKcDUTTf7qdNuAHUyIAp3nfKK37hoIf6FwEhJ0u
	 qI4PSxbU58dAzerEiXSsKMXP3SXBm3VqtxXr/p4c9WrgnyxlIActAMZQhq63hKs22t1UmGogUIe0
	 cZrpngojcFHTEU/qeyLjJZOu77caCeU36KEYElFSFZGAWetAJseqA8FfQMDv/JX07jzERsbFzASh
	 NbjVjv6VyI0kTXkVNRM1oGAtxIWqgs3yehG3pAYc+CkjvvyrXpd+Zimaq+DB5T2ZBIouqG8lE8HN
	 epq1MkCpjLg/N+vTYtUu189htx9aQJL7ivAARSZH/19L9Y3dSt8KJ5TCBxv0zwJhqKgskIbkj4SA
	 LmjUwcuygVc5ymFeDu/KmNKtciqdvu4+N0AYxeb4rGsWh0busNzMMOzITQ6999jjAFwVacw92IuK
	 RsnSqFfARpMBYP32PfsGwygE5cGhnxTCpqI3Sx79eU5TiZcxRIaYd5M0pMKmMsEVPf8qqi6J+y0f
	 E25a06W5vmoLxruz8qsUjL7TusElb8T7GcY/Q1eml0NbGUjdiW7BcYd2u1Z9e83pjvJVZ9Mo9bLU
	 CSKO1oabd/ElhA43K09IAHr3PE8AOeXgX5bu5zbFq3jyhUgzdXsum2/4EzQkTLvZxo2vEi8Tr/V7
	 Y1vK87dP7fWe2FuD/TxIBU0oHd+hjzoYh3zGabpsUz8kWhVs9yRJxsfLexQTsvsWEpdeXf1DngdD
	 9PyfceBYhCqvV2mzD1oH6lr5JXRDMLbSiA8Jy3I7upxn7juHCL1ibpRCDjxht1oD93sd9rMcWNvP
	 7Wberw27I8+5816E8vpc3/3XbBSm8ApBXXgR8DfjwIQ5J0j4kVl/+6/SFuzHGqajwCsHYYOyqz1v
	 0TSx8m+4JSeIVYDNL87chc8r4f7zHUIe3DVZNKa4OpUcBZmuJsbUSMQeDBT1k=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Chengyu Liu <19290937@qq.com>
To: netdev@vger.kernel.org
Cc: khc@pm.waw.pl,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	Chengyu Liu <19290937@qq.com>
Subject: [PATCH net-next v2 2/2] hdlc_fr: shut down the LMI timer in fr_destroy()
Date: Mon,  2 Nov 2026 19:28:07 +0800
X-OQ-MSGID: <20261102112807.1395951-3-19290937@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261102112807.1395951-1-19290937@qq.com>
References: <20261102112807.1395951-1-19290937@qq.com>
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

fr_start() arms state(hdlc)->timer when LMI is enabled
(settings.lmi != LMI_NONE).  The only deletion lives in fr_stop(), which
is unreachable on the protocol-detach path: detach_hdlc_protocol() calls
only ->detach() (never ->stop()) and then kfree()s hdlc->state.  FR's
->detach, fr_destroy(), tears down the PVC list but never touches the
timer, so unregistering an up FR device with LMI enabled leaves the timer
armed on top of freed memory; fr_timer() then fires into the dead
frad_state.

Shut the timer down at the top of fr_destroy().  Use
timer_shutdown_sync() so the timer cannot be re-armed afterwards,
matching the CVE-2026-63803 ppp fix (ppp_timer_release()).

Initialize the timer in fr_ioctl() when the protocol is attached and
drop the timer_setup() from fr_start(): attach_hdlc_protocol() uses
kmalloc() (not kzalloc), so state(hdlc)->timer is uninitialized garbage
until the first timer_setup() and fr_destroy() must never run
timer_shutdown_sync() on it.

This bug was found by static analysis and confirmed with a KASAN
reproducer: slab-use-after-free in the timer softirq after rmmod of an
up Frame Relay HDLC device with LMI enabled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Chengyu Liu <19290937@qq.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: retarget to net-next and drop Cc: stable per maintainer guidance;
    no code change.  v1: https://lore.kernel.org/netdev/
 drivers/net/wan/hdlc_fr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index 5f0e54ed1e..2086ff85b5 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -1009,7 +1009,6 @@ static void fr_start(struct net_device *dev)
 		state(hdlc)->txseq = state(hdlc)->rxseq = 0;
 
 		state(hdlc)->dev = dev;
-		timer_setup(&state(hdlc)->timer, fr_timer, 0);
 		/* First poll after 1 s */
 		state(hdlc)->timer.expires = jiffies + HZ;
 		add_timer(&state(hdlc)->timer);
@@ -1153,6 +1152,9 @@ static void fr_destroy(struct net_device *frad)
 	hdlc_device *hdlc = dev_to_hdlc(frad);
 	struct pvc_device *pvc = state(hdlc)->first_pvc;
 
+	/* The LMI timer must not outlive the state being torn down. */
+	timer_shutdown_sync(&state(hdlc)->timer);
+
 	state(hdlc)->first_pvc = NULL; /* All PVCs destroyed */
 	state(hdlc)->dce_pvc_count = 0;
 	state(hdlc)->dce_changed = 1;
@@ -1242,6 +1244,7 @@ static int fr_ioctl(struct net_device *dev, struct if_settings *ifs)
 				return result;
 			state(hdlc)->first_pvc = NULL;
 			state(hdlc)->dce_pvc_count = 0;
+			timer_setup(&state(hdlc)->timer, fr_timer, 0);
 		}
 		memcpy(&state(hdlc)->settings, &new_settings, size);
 		dev->type = ARPHRD_FRAD;
-- 
2.25.1

