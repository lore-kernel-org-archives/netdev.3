Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016721146C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184860; cv=none; b=PBOp1J4OT+OaQ4ZsJ+8bGkBeGTOq95sx/hp+HReFWq4C+NhogBO0ZpRadqPinQ9uNNtdvQ69ign2r0C4GPEtRcVd0J3iEeWDf+Pr2NMNsLVCvo4FA7BGLJmiLmzsU/UUAupJ+6YBeuW1P+RYUJ0PZjPhRnz7d62SSw3GZn4M+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184860; c=relaxed/simple;
	bh=aLk3wlTA5BYgt/o1C3BnJ6eGYQBM95d/LBwRNKEhEBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VHuVCazMBBhaOqyCzlBgykOmZzOP5BqX4spMZBq8Uih6EgZUJEEwFVzGR3Kiq5zDYPYg73M0SazAR57d+UX0OoVDY3oHyJk2Dgu4o8TEgM41/ZDGQA4Y+trP4oB4E4P6pjn+CW4d++j+XgS0Tnh8Rx77tMaM58+M/pTR6DekrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVhXw/36; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVhXw/36"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso4706469a91.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781184859; x=1781789659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFV5XYOMdl0rTgeUoL1zf1BnAFYBoOnJJh4fcbZ3jGk=;
        b=AVhXw/36zrsy5Skj9hJK4HLHpg86W6EzyH/ItFQskXFs6uw1So56BYgniMfbOH0SK4
         vIWGTAkFI9kDzzMsiESN6Suj3DR7Ff8bKkvTXRojfyqJXVkMNsc2bdxdmNffxw+VXc7L
         UViTP0nzHKAO9AuuAK3EkyaSGLHzoqKGYAyhkcSTFoTgUYvHojD+5zoQHK75Nme2Xwzg
         2bHskARbJdICvTKBE8bjAadlj3vr4gAYpi8JYxhiNgPz5oaZYFlSzuEqPi2vIN1FUMqU
         Hexi4qVcP2/OW5X5wEewxodjabVTdIxOgxo1fPM8Foe8hSdxLtQHXhzzzk2L6LsZ6Pnt
         Hmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781184859; x=1781789659;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFV5XYOMdl0rTgeUoL1zf1BnAFYBoOnJJh4fcbZ3jGk=;
        b=RL6BIX0m0NIfBuL2u1VoCptYzIViO11Nhs3QbBZqUeND1A+Sbl5BVipmzdJ8sJvn1o
         NhhQE6NtJMC95hVnDJdx2nFoNx9AL89E1nypgu9rGEm2bBEL9+cltLskO8UA/effTDcy
         LOxMTwmZMQfmkfE4FAVwgTyogCaeH+CjOXeaFykFHu5LqvmWNHxueNeSQnekvwwJsYwy
         SU4e9dUDo/2+e3a/H2RGff5LkI164YgFF8f0oPTVAE+t/b+7Hhko6NHRqhRmZXWPuOPL
         zqKJzrtG22dRmAE/BATE1bTM5hFqz0zXjHmwii5gPjB3RBSjS8HrVRXKIm6LOphtmdjd
         +qNg==
X-Gm-Message-State: AOJu0YyGf6iJoq3Uq+tl4qZZP19WJ5MoCFMIMrvJ5srLU9c5xO+sJOxz
	+NhkpzILCRjFDEKmSC+N0GamG2rXlenlwuWqf2yYPYBXjsOk1kc+PEJ8CRiEiuTX53w=
X-Gm-Gg: Acq92OE9r/Lm/sqj/4U3/FkceH9ol4K6zMKYSptcIzy7Ju0fTCVkx+n/xr/m8k8q4hp
	fFNlnDNIq5Cr+HI9VlOubcr9SXssUIVhewTYfY4dIh7SoMNAAGz5Xvdm1TSlgxz1zYCEjvbX+BB
	j+Zd3aZgY/x0ZFeIbteJLKYv7+GONOlhUTiJa5tx3DK4yHLr5oRYhWGS5OR08XFvTK3kmsyWg7a
	r2ZETFFvk6g6qBcK6ZQ+mfclhr5LSU1bbtbI8qRDI7V/H1TTdrKkveT/u1M2anlSKuW4PTdSEmW
	+7RK9eNNkoors9vByGaou68+h2Tk4TNLJdSlYG3xNe86CKhoApoOMfoV+mUBLxlqV9m5gO8hcGS
	Eq1oRHbJR5VX8yOvuoiDXlG4CtcfRHkvS/o6jecaZBY66QbjJ7ACuwq56W06DAAvzYEu5RjJD7I
	PuPsueWU8EmOYmBhFizGhE30cl/8V8ZufmyE7L76s0FBUdEkFbgIIQ3Hpxb/EB0wAmkw==
X-Received: by 2002:a17:90b:498e:b0:36e:2106:dedc with SMTP id 98e67ed59e1d1-377a73e272fmr3296310a91.22.1781184859005;
        Thu, 11 Jun 2026 06:34:19 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37752b5a8ecsm3422304a91.7.2026.06.11.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:34:18 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:34:13 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: [PATCH net v3 2/2] ipv6: account for fraggap on the paged allocation
 path
Message-ID: <aiq5VQknt1QHcvio@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain>

In __ip6_append_data(), when the paged-allocation branch is taken
(MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
computed as

	alloclen = fragheaderlen + transhdrlen;
	pagedlen = datalen - transhdrlen;

datalen already includes fraggap (datalen = length + fraggap), but
the fraggap bytes carried over from the previous skb are copied into
the new skb's linear area at offset transhdrlen by the subsequent
skb_copy_and_csum_bits(). The linear area is therefore undersized by
fraggap bytes while pagedlen is overstated by the same amount, and
the copy writes past skb->end into the trailing skb_shared_info.

An unprivileged user can trigger this via a UDPv6 socket using
MSG_MORE together with MSG_SPLICE_PAGES.

The bad accounting was introduced by commit 773ba4fe9104 ("ipv6:
avoid partial copy for zc"). Before commit ce650a166335 ("udp6: Fix
__ip6_append_data()'s handling of MSG_SPLICE_PAGES"), the negative
copy value caused -EINVAL to be returned. That later commit allowed
MSG_SPLICE_PAGES to proceed in this case, making the corruption
triggerable.

The non-paged branch sets alloclen to fraglen, which already accounts
for fraggap because datalen does. Bring the paged branch in line by
adding fraggap to alloclen and subtracting it from pagedlen.

After this adjustment, copy no longer collapses to -fraggap on the
paged path, so remove the stale comment describing that old arithmetic.

Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")
Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
---
 net/ipv6/ip6_output.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c14adcdd4396..bfe16cb8a0aa 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1668,8 +1668,8 @@ static int __ip6_append_data(struct sock *sk,
 				  !(rt->dst.dev->features & NETIF_F_SG)))
 				alloclen = fraglen;
 			else {
-				alloclen = fragheaderlen + transhdrlen;
-				pagedlen = datalen - transhdrlen;
+				alloclen = fragheaderlen + transhdrlen + fraggap;
+				pagedlen = datalen - transhdrlen - fraggap;
 			}
 			alloclen += alloc_extra;
 
@@ -1684,9 +1684,6 @@ static int __ip6_append_data(struct sock *sk,
 			fraglen = datalen + fragheaderlen;
 
 			copy = datalen - transhdrlen - fraggap - pagedlen;
-			/* [!] NOTE: copy may be negative if pagedlen>0
-			 * because then the equation may reduces to -fraggap.
-			 */
 			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {
 				err = -EINVAL;
 				goto error;
-- 
2.34.1
