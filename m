Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA645D1B1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493434; cv=none; b=liXIuJekpfuWNsr9UAuDDQD570btFqtm33ac8R8EeGE29aqQ+OunQZd/W05zVx6AKCwmO+JyZKOjcmyiH4LRJXanN4B+qgRWLtMFOkaEHX6xDXtcglEVW2g1H8CX6cpcFJk3qpsOHOwtSVN52X2a766BtHbYxUIixogumTXKtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493434; c=relaxed/simple;
	bh=G4GQSS/z86H6HrzRjtGCGkhfNcr1ZqkSUEOCEKTi8N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M43tAsi/05E0IE9gRhPb3VN5NPxu6ifqoRpsQEaQqLyT54l1VrFYPE+T0mHRkuf72DzGeOF6oYswckk2w3JAQsKET8IOMBjW76YAHDC/I2dxvJYn+YSWnpFc6Fgn+ToL/lHvxgknMfSNJcRteccugEoh1F82eHPejaTolCB0MtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=eTjSebB5; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="eTjSebB5"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917d595138fso34773946d6.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791493424; x=1792098224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0uSM/A3oRPIUcCVkMNaXKAYlboH4f+zE5JovH6Ln9w=;
        b=eTjSebB5sOc8aErg8cT/L7MyU56/ql9J7O3y8pCm1Kxh5LmxJiwRLpXUH+z14e8g8e
         Z9UHllMXXQ6iH2NX1W5c3e3zSfdcEUIWNaCGgxbLL1phM5cjpcGPGxcj8qRxjRKsFDcH
         Dx3Ns3otH8zlAnfexu/pb3vu5oXZo7ir+HNHrQKqEvIMlN8s8xp7w4LRIQ5VZtg/eZsp
         yESTj6lwB6FyO1L7ktK5JCcF0pXkJmC2c2J6U+Tp6O/rE61gO4FdJ3/louoq6lgpqE1s
         fjfEgRBxJiLcTpVGSYW6OtmB8Jm5+GiK8jnHS0ghpb7xcWQTGeMiPkTcpHrNmUbJy3F7
         kS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493424; x=1792098224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0uSM/A3oRPIUcCVkMNaXKAYlboH4f+zE5JovH6Ln9w=;
        b=2l83wRAtm9lzji1OICOvmDNnif/smQcpr3D451rIGmC6Iksc9XT+6JQKI/oWVTbxlF
         sYgytsdFJqrPwIacuifLcnUa+u8u10bVHmbATicKs7d6Q8ExHtcqNL9n9puvYs1CrYLD
         ZfJpcC2Yvi0ot7amgFBB7zoV/3mlsGBC4Fl6/55XKOvBCMzg1YQfxo9K+sOaQZwpmkPZ
         +gsgUCho81Gqef/rpcoc+sROa4yqcyepOi1MB+ordVmLq9TBzRTBDPyvwZorHgPjHV1i
         /YUPPdgwFkOxdtZ4RqwbksefRfzRijPCGZUFW/RYxr/MxLVbdD5O2PqqZ4xmP3qTd82F
         5mCg==
X-Forwarded-Encrypted: i=1; AKwUvByWigm6/BRztZOveC3dXVWw50yqd3SNLhrO4ovZiqCJj4llVOVM7Jmcsh4L4ssP0PU+JmR2IhI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgVX6grmR4pl7Oxb7I0rN1TpIEb8kAMTj5t4D3pyb44but1iyW
	MFNMk56/kU1++VwH0yjIUMYy1oWozPSFyxW/ED43q3iFV1O+CgtLEV4DlXzNCnYV8LI=
X-Gm-Gg: AYBFou3lGC17pNELZVvosZGS30tyYBF/I4ApvyRuK4Y8+d0SbI19OOmid7cPkYHL+yy
	sONM0gfn6Z1dXRX+JzlfmRmSwU1PMEGfVtWCQ47/K0RPd++pdbVKLHeoIs2VsaxNxGEPsxvEuF1
	VAmx8741OdEGz9xZ9sEl1kwWREErTRPaxCQB/1NsxQTFRlaFlb5P5Fn4jmozxerSjcNIl9xOVEY
	wA/iqGsULjvZWrSSwSmd/yNPGxnJMFJgzRBdAC4sxnfxP0u9y/sKzEamRlcN1azzuEL14B3Unte
	B3ihLesyKNIDgzMtLAP46O3Deg35AgfV7QjzwoZO8NWoEeRoRsnmnswpA6G3PP2k5qkcMFpf0Jf
	JSILkTK++eGjAvhkS8dY+BYAwWOx6aautyN5qydrpDChyBZjnsN76KcXBIXysep3tqnr6FbjRAz
	tmmQPtjByyMmNEgNKu/iuhVsyoj0IrxPeakyF9D0LsUDVWDEhphxuSuCht/6d+eKF3VeRKh636a
	xzl3FvDrXEAfiU=
X-Received: by 2002:a05:6214:ca3:b0:919:952d:7ff9 with SMTP id 6a1803df08f44-919978f7ebamr126853616d6.57.1791493423774;
        Thu, 08 Oct 2026 14:03:43 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550d394bsm79796d6.41.2026.10.08.14.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:03:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:57 +0000
Subject: [PATCH net-next v2 10/10] net: skbuff: don't reset truesize in
 skb_condense() if the pull fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-10-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1285;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=G4GQSS/z86H6HrzRjtGCGkhfNcr1ZqkSUEOCEKTi8N4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD7QXznJXVwY4tvhlA2g/ntlgNB9z4EYJ24pFBre8ehTYCPfcNpsZClmKSf0INhwTvOUpctCjRC
 vzNH0Zo1blA8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_condense() pulls all of the frag data into the head and then sets
truesize to cover just the head, but it ignores the return value of
__pskb_pull_tail().  If the pull failed, the frags would still be
attached and truesize would undercount them.

It can't fail today.  The caller has checked that the head has room,
that the skb isn't cloned and that the frags are readable, and pulling
all of data_len eats every frag_list skb whole, so nothing is
allocated.  Check the result anyway and leave the skb alone on
failure, so this stays correct if any of that changes.  Use
__skb_linearize(), which is what this pull is.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f798118df112..556d37981f0f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7158,7 +7158,8 @@ void skb_condense(struct sk_buff *skb)
 			return;
 
 		/* Nice, we can free page frag(s) right now */
-		__pskb_pull_tail(skb, skb->data_len);
+		if (__skb_linearize(skb))
+			return;
 	}
 	/* At this point, skb->truesize might be over estimated,
 	 * because skb had a fragment, and fragments do not tell

-- 
2.55.0

