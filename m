Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A404DEC29
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397004; cv=none; b=gk1DXGoGg1RTnzyS0h5UWaO3g3+S3y6cZeuEbXJf4SODzyMZ1px/SomcUgg0/0ug76zPJZxVjYzXrp5daOPlhJPJz2QiBZ+Ox5kM5T6BT/+xXFgrJ0XMnuFQvKm2KWejGXt4ovlyEa4o4r+NbjGWFZ0r3eJBoKO0icftBP3YTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397004; c=relaxed/simple;
	bh=3f5WzTjnDsDOAnT0hR8gZXIWFT9KoT8c/AVMjDx6NOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MG2xfLdw899v6V/LFZwWCXogoF565+Ik4zdT7V5VWogkWELHwqwhQbHFcSTt4mf1Ly4C0yielbhYYVqHgMgTRMvDpkO13WXj1cmq+jI+sjNzvKxBVKhQ4UUjUqHZr5iGqQSXyggOjMb4gZpgJtpdo4oe4vNaR+HbX4dmmDrDqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=IgU+MJoW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="IgU+MJoW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53519e20d7bso43147511cf.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791396999; x=1792001799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
        b=IgU+MJoWLuObc2XG00qLChJqslorgxFmiugvO9MVsdFghTeLqXN781FVVWV89At1Sq
         r1hsw3aBnTrAFPwE/na12WB56zt5huZOnsJg7B5lT8ysleur/ABBcVQME9pZ7foka494
         dHNXVIWz/6GV1Jsp4ndgqmddb22wpi9rPFoi/W6vL0sl4EwPB5iHXxxQLxZTftnQ0Wf8
         J+n/sqa1cTwPF6eRLZ+cM85Lr6sTQ1RonBpEoRxXq8TrP7IKpzEo6wY0XsB7956GB13e
         +K4zCTsHWHjB6D1P/1+H0pbT9k5EmBzRI23MRK714J+H9oOncMwKuIy5Iqkl0YxKbKa3
         3jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396999; x=1792001799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
        b=SZAsVGuYU8n/GoiWClHeEDRbMLHxdeR7fwlafXTIA21b9prVB3L6PzGR0wSUZnDVYO
         sklcZ5ADOX5ud9V92s6NkBt0s204UX3oIKzAZh3uYI/ztzCD9JFMWMRhCfIEoxppzxxW
         yGEJb4gHXKKDNYuLqjPOu5A9FMcnyFMBRCBToEDFuWGQKQRNL9r7Sdnx7hKdhkOcGP6Q
         6dEVxWoQMaF9G3wgzQmWEG7+Hooy6XtAwt6fxvs67ZCkjXTrisnDtnpNhkWbvuhIb7Ux
         mHTg7NcqriCGwAvq1POqVzAP8vboD8cndO5JJvDr0rMOZ5w4fKTpiWQb/BT0JDL+9/c7
         76zA==
X-Forwarded-Encrypted: i=1; AKwUvBzg3ak2b/JjjUEwfWazoCBS0Z9QZixJI0ivRYA9l6uPdpC9kGtsotno6jNSSohwmOCvOvRzYtU=@vger.kernel.org
X-Gm-Message-State: AFuF++k4liMJ/F/SY++pSETV+EKZCaz0vYqv95vBEB/BKY+4eo+3bI9/
	FepZF2m9Sa2zfKO8douWY15ZZ1/TVJ8KoRPJ/amGx2gpBqufNwBetH55tlyQ/QD7ODE=
X-Gm-Gg: AYBFou0iMCJg6qobEYw+qIyNJXAJpB3mN5ZHrJNLmehZEQEruL7jcN2yJ1ZPV/Y7+Jy
	R/6gKAn5+ygfP+Gbh3kRxKvD20Q0Ea7UB2QLvusZjxyzDUIkb2ArxYM+oUPtQzxNnVLdWaOW4Uu
	Spe8aYkCFKsvcHWc6BiFN94qrasKMonN64uoytSXkQRIzIfdEiJAEyqV+ucGVjK2yLFbUdvoH0l
	VrGoOtFDXdGQ5t32rAT3TunoT3TJGwMfTiJD+jRqolrRhRtMsAhEnoqvgH/sElWkY3NjIL6exJQ
	3qxl1/LfuGxhNr0Qwfn1z+DL9EKeGHNRDQgCGHFLc6jc6B7czUgCm42/ieGyJ4yUqH0bvdPLXkS
	jGyGWNaI7XD0MUXNLIXGNPpOQ6IoVFrCRshiM1eZVlm4Dty7ncd9mkYNkaIWdzlTRCuI3HSgaQI
	kb48r1xBTMsW6wiwxfV38wv2pRZmEVxfN1q1c8zrMqg3git1mEhoDJKI04M/sHGNQyhlgcffkaq
	6hrY3JLSxRmM5Lazjc59d9+4w==
X-Received: by 2002:ac8:59d2:0:b0:535:1740:d334 with SMTP id d75a77b69052e-53575201aa2mr52033281cf.3.1791396998937;
        Wed, 07 Oct 2026 11:16:38 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535720ea17csm25632781cf.12.2026.10.07.11.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:16:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:16 +0000
Subject: [PATCH net-next 3/9] net: niu: check for failure when pulling in
 the RX header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-3-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1236;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=3f5WzTjnDsDOAnT0hR8gZXIWFT9KoT8c/AVMjDx6NOM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPE8F38TpAIjOskJy1CfHBTawvG2+Cdej+o6C6KckWCrmqZc3RT77tIgX51AS0sYEQy/f1nhpBP
 sPFJm2+lltwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

niu_process_rx_pkt() uses __pskb_pull_tail() to pull the hardware RX
header and the Ethernet header into the skb head, and ignores the
return value.  If that pull failed, the skb_pull() of the RX header
right after it would BUG() in __skb_pull().

It doesn't fail today because the skb is freshly allocated, isn't
shared and has room in the head.  Use pskb_may_pull() anyway and drop
the packet if it fails, rather than depending on that.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/sun/niu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index c74a97fe5464..d1c0e868004d 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3488,7 +3488,11 @@ static int niu_process_rx_pkt(struct napi_struct *napi, struct niu *np,
 
 	len += sizeof(*rh);
 	len = min_t(int, len, sizeof(*rh) + VLAN_ETH_HLEN);
-	__pskb_pull_tail(skb, len);
+	if (unlikely(!pskb_may_pull(skb, len))) {
+		rp->rx_dropped++;
+		kfree_skb(skb);
+		return num_rcr;
+	}
 
 	rh = (struct rx_pkt_hdr1 *) skb->data;
 	if (np->dev->features & NETIF_F_RXHASH)

-- 
2.55.0

