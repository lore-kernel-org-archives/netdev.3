Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195204DEC30
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396999; cv=none; b=qU40KGfQGkc4HAgYD5HuxMCd58mq9udRxNKqlmkQaRZDjRlw6CWspX+3PXq0mC7TUfqZCLjqxcS1s3hlb3KKAPraQc9HIXoogCjhp8gAYZB6qTS4p/J8LT15+/HjNRYuyV615ZLGzX2aZ3M1iE6rhVVynWcIMY+D7UeZYNT7BEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396999; c=relaxed/simple;
	bh=YaVSidg1Bo1cVWoGQJzV4z/nBT+SLxbK+9NmCYkL+oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7UwMaNwZHHkZb3890voI5AQI1qv0WCqxJi1ynykr49c5nryX6X43q+VqgFEaCB4GqLs4P+QmFZ/+91szk1gSu2i/aP2dGHLyTNSOjKwzscKUJPH748cEc2O9zhwxwaoIEsNTNiW8O9mXrAXz+wlZ+XkgTcG+1ELHDbEPsKlS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=lvQCrl+R; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="lvQCrl+R"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53506b44151so32689161cf.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791396994; x=1792001794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
        b=lvQCrl+RoI+yFumjZBSAaszStUuxGwx6XRx6oEqnfHCSH7HACC4TJOH2ezqbmxnSM9
         QeCrOqDxLbAlYJJ1MZd4z8u4MQOq/MUVqjpmROQRRfLlSfpmQmkNnQ63UxQuRhMXxpBa
         1jD/J5AtAvEB1v8PnIg6KBNR2c2PtrCBfb+5dyWZZRVvk1NY0lDBF0DyXtMxNR6B4zO1
         h7UrHzrGyeg6AFq2/2ESr2MEeJ0vjPV6eLJ76C5AedOmFu6B3hIc6R9mbQOkRYGKGTXn
         qHSF5EaNs0bRUFeSySTL2u6BMZRQI32QMs4+RQ6TM1zP1KEIjeXLlZZ2E2dwSEDi/LpD
         usuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396994; x=1792001794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
        b=hgLVeSpUvvipb0zL/7ePBGrxUNqYL5rp4FBfmJITwovahBmHYH+C0taPJEnx91l8bQ
         XuKDrAcuxmfBggxNB5Aodj1S+9kZjkMtpzZMP2EhQldVRmaJmFLcpiJ0suYI3iINjuSw
         Ob1u0cXcTFRDb+KKaHtB5HYQX61eKmmybCQL9vOyXQCaDoBdPimSCsoM8TiESt14ZewJ
         y834mL93eVJr9d9ZAfxN/0rqpjlOUb7N9HDjLkwZBmkcY4tVslx9GUga7+FBFOUea2aB
         NxE3pzxcMXCfCKS8kjBTWylcwawwRqARtSjKmrfVV7Y73IgGfDZ4zab4UtXCIw8nPsDB
         kKQA==
X-Forwarded-Encrypted: i=1; AKwUvBxIQ69GvKMVPfkkspOz6kR3XGpZcSf2DOku07iap7X3hEQsbDXSaBlmR2CJIrUV7ffgughc8z8=@vger.kernel.org
X-Gm-Message-State: AFuF++nJiVzMMyawkCHWFiYuhqj+t7C6up6c5cBkEEI1Qt8KJLg9Iqu0
	NSF/ErN51DcJ/zeLc8SKTbvm/1p7H6nL1Lk5OqJvAeSoXA7S7gaMJBRvcHDuWWxvSXw=
X-Gm-Gg: AYBFou2wCRaZcbA9c+eClQvchI9DpMpKWzjBJLJLID+Lv72xqsLWPER4l4Q66uo/tE6
	ZueWwoa7nXDh2zsBxXZIOAgfVuWxWCOoCzdOTYj2PIzgW7Hpctpmug/wYf1Evim89nG8eD0UwPv
	6WIXnoJwvvBT1HKesGPxqREEL2Rz/xZzBDe2SAEFa1yt3dgaZ7JSAg7pQDP36U7CTImZERUQn0F
	Ag7ShWlyqGDMg5nnuRp3V0K2idqv/5BJy3GE3ORUjDZR1pyBD34ErrXXdnmpsHt2mnmGnPow4tu
	X3jcljtbQ8Suw9zlPNoyDobDZGBKx6kZDTk2BiBaaPGMimzzI0vq+HnAtmzspLYevCr0A9cnboI
	1/OqxW+YPX0hK/SHVyRFkbACeEVPwieuSNXTsGsRpyC7m34pBsEbhX6tGLwwbNpFsWcpmAGqNoa
	Sk1KpSjk/ifdP+EVBtF8AIeBTZNK8TppsiKd+2w3MHh2d+bB6RJDzaTKx1uPuvW1bzWgR0SR4OD
	1/Wtl3bZQ5kmpa2JiBulMoDzw==
X-Received: by 2002:a05:622a:e113:20b0:535:8607:d2e2 with SMTP id d75a77b69052e-5358607f4bamr14319421cf.56.1791396994064;
        Wed, 07 Oct 2026 11:16:34 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53572163ceesm25476671cf.20.2026.10.07.11.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:16:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:14 +0000
Subject: [PATCH net-next 1/9] net: ftmac100: check for failure when pulling
 in the RX header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-1-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1745;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=YaVSidg1Bo1cVWoGQJzV4z/nBT+SLxbK+9NmCYkL+oY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLi6NM2cH1GaCjQ09bIeFY42DV/aexWSzx1/i1cHNG8H1PuIyQKikelvwnWe7Tmx+A2sBSVuNWU
 /fPwJUm49cAs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

ftmac100_rx_packet() uses __pskb_pull_tail() to pull either the
Ethernet header or, for small frames, the whole frame into the skb
head, and ignores the return value.  If that pull ever failed,
eth_type_trans() would find less than ETH_HLEN in the head and BUG()
in __skb_pull().

It doesn't fail today because the skb is freshly allocated, isn't
shared and has room in the head, but that's only true because of how
this driver allocates.  Use pskb_may_pull() for the header and
__skb_linearize() for small frames, which is what the two pulls are
doing, and drop the frame if either fails.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/faraday/ftmac100.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 40ba001d4b3f..a1eb04ead2d8 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -469,15 +469,21 @@ static bool ftmac100_rx_packet(struct ftmac100 *priv, int *processed)
 	if (length > 128) {
 		skb->truesize += PAGE_SIZE;
 		/* We pull the minimum amount into linear part */
-		__pskb_pull_tail(skb, ETH_HLEN);
+		ret = pskb_may_pull(skb, ETH_HLEN);
 	} else {
 		/* Small frames are copied into linear part to free one page */
-		__pskb_pull_tail(skb, length);
+		ret = !__skb_linearize(skb);
 	}
 	ftmac100_alloc_rx_page(priv, rxdes, GFP_ATOMIC);
 
 	ftmac100_rx_pointer_advance(priv);
 
+	if (unlikely(!ret)) {
+		netdev->stats.rx_dropped++;
+		kfree_skb(skb);
+		return true;
+	}
+
 	skb->protocol = eth_type_trans(skb, netdev);
 
 	netdev->stats.rx_packets++;

-- 
2.55.0

