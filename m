Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963164D8DA0
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221898; cv=none; b=lINf//n/Ip3lG1f9skqDABlNfueGijcH4GW+bKCpYDey01htUOe0bO3eQG7TujTnTr7pRkhaYgoNqwwPByy9qd0puyzk1H6jW/7ubu/ubuGVcXDdZfV2H4kGCkfxTICN3h7iK9kQXNL1UdjZFW7TxyU+D+73n+oLBmHV+5cL5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221898; c=relaxed/simple;
	bh=56cPUhnYKFpPjDZdkQQvRj7byuhsc5ATQUH3g9x7yko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU8w3k3Yp4v8jUnCEsLty33YUUcLffLisTC+uSBpLpwwo9svodb08sPwJjZsgxHacodYDR9G4g7XMw4NgAedUu+a77uu9B1SOMFFMywUyYlBqg5LwOXPd78hXaXwMc492EH9BunSnmlDcekv58fUWINt7Ta/R0I/8yuTcpqoVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=zXcudfo/; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="zXcudfo/"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso1389330a91.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 10:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791221896; x=1791826696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TGZol1/fhURXbJL0Orn0Yq+qAJxRjq98rgjNeuFqBTY=;
        b=zXcudfo/D469zyJUkvs59A92/v2vR3LqCiaJbZ8B9L+m97WPNoTvt1pHKRvkZ95UXP
         Tm5pSrCrB+e6fkj5iY8B1hg1btrw7hKSQeDPVoSGFu6YbjymDTQwo5l5tM60UOmLiIZ4
         8gbb8L0E0xnoohTEwvlK27W/rnCtkuoMKffLUBui+DRPe20W9Oa/yIBTU14VaGZzq4jm
         wTjJqcd8SmL2zzsw1zU5/xm5KIQF1/KD7r6oa4WMdD4DZABYrN0HjKUYeEJ/+UJFPz0C
         0g4N0ILi6MFfsEnL9WEfKC04SEaWkLOUK0mQeBNeet2RM56mnWhk72htO1KA01Qi+t2E
         Rivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791221896; x=1791826696;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TGZol1/fhURXbJL0Orn0Yq+qAJxRjq98rgjNeuFqBTY=;
        b=h1wpOWGBAVdatdinpAalLm8fh5IWpREu0CXtWPZxa4XxIOUYF1h2wKp7aViL88z6Qr
         XIyq3QA/S6qdI9rTJPlLR1Juizg1LySGDPSCS0JyF4NurrLsm/L3zAH4wxHW7QcCu1lV
         60OnVAKXC0LxsYInQAc4qtoembpa4p9K5X76m4TKHtT+k/kXTjRvoJnWDK+mcQH3Dmrk
         ngu1/0CetU5PGTrDoyaKKxzYYTgO7Z2NnyJhLq2TieHaUNq+CW41FA+mFZuUbEHlSgqt
         xiX/f7WzWqjXzEEZW9TOkBlD/uNbLq++OLUmf3768h2MlRAfSji8UQ6XY9pCR/vUjWz0
         EoIg==
X-Forwarded-Encrypted: i=1; AKwUvBx58ksPiq/pEP0NZFjVE9T3OQjSeSJP1w5/InaG2AoTVC4lv7NGVAUHKewTmzw4onDQjZnsGEA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5n43BJ/F4G7+Eu2SOZM5MTqILU1Kj/g7Axe9I0GI8v9Wqzt83
	nz+cFwBpuU8j0JCwZ1/pQCMCpNDnDpPO4ebR8HsgDhLKQ19wytXRwQcuDiJEY/8iLQ4c0qeBqDg
	s7u1c
X-Gm-Gg: AYBFou1KjpekvzK0bXj4kv6BzuqrD9jz0TkaT4x5WtHmzMn/RMM2LZHWo5BE8CFA/J7
	44k4s2VwfWjPRfwYhEMjYydZ/mFv3sdnkGHrtJirlidVmN8Lb9SJmlJkVi1AP9Y1z1XUmiKyrt7
	nL1Y13uV96MjlNrLRytXji6hrcdJVxNapMWuyrOSJP9VNvgtfwvBSytnxhg0DuAK5HfRebOXCiU
	/zb29FQl6Zi7EQJ5OHNA/mbEMXvg6jNlFPQECxzV37Ig6PJMGYkRdP7BcAcYFX+mK/ESxvK47Sz
	Rvkdh4JceA22i2VyxLuQm8u9i79KXU33/AqvziZXdwpW3wP/DmCj4ZIvliZ42XR6enhfQHZapo/
	0Z/HXZFSne8OIHmAJJSuPC2/j+qRJs40nds8KXgvxeUTVMMD0S5WV1C/9QR1KCG56OJrOLKyu4Q
	2+QQrMWOS4Og7h1RA4HwhpLVZieM16BWteAl6n03oLhLnIA+8gZ/msQwVADWcABFIVbMFanguA3
	ZoIeJgpAxnGVsK9Fdj1Pck=
X-Received: by 2002:a17:90b:3849:b0:3a0:8050:2ed1 with SMTP id 98e67ed59e1d1-3a6ced936bfmr10618539a91.63.1791221895412;
        Mon, 05 Oct 2026 10:38:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543e8478sm462854a91.17.2026.10.05.10.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:38:14 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:38:13 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Stefan Fleischmann <sfle@kth.se>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
Message-ID: <asPghf8DPk5pOczz@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@kernel.org>,
	Stefan Fleischmann <sfle@kth.se>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	regressions@lists.linux.dev
References: <20261004122616.56714cbd@nargothrond>
 <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>

On Sun, Oct 04, 2026 at 01:46:08PM +0200, Eric Dumazet wrote:
> 
> 
> On 10/4/26 12:26, Stefan Fleischmann wrote:
> > Hi,
> > 
> > I have bisected a regression introduced in kernel 6.18.51 (and 7.2.3).
> > The issue is still present in 6.18.55 and 7.2.9. Verified by reverting
> > 1517d1996b52 (the equivalent of 447cbe95ebb9 in the 6.18 branch) on top
> > of 6.18.51 and 6.18.55.
> > 
> > The hardware is a Dell R640 server with Intel Xeon Silver 4210 and
> > Broadcom BCM57412 NetXtreme-E NIC.
> > 
> > The network interface is configured as an untagged interface and has a
> > couple of tagged VLAN interfaces configured on top. All of these are
> > used by LXC containers with Macvlan.
> > 
> > The interface comes up fine after boot, but after some time (anywhere
> > between 2 to 40 minutes) I see a DMA error in the kernel log (attached),
> > and the driver ends up tearing down the interface. It can be brought up
> > again after that, but it will hit a DMA error again after a while and
> > the interface goes down again.
> > 
> > I'm happy to provide more debug info if needed, or test patches.
> 
> Hi Stefan,
> 
> Thanks for the bisect and detailed report.
> 
> Notice that 0xfc499000 is on an exact 4KB page boundary. This points to a
> DMA read overrun where the Broadcom DMA engine reads past the end of a
> buffer mapped in page 0xfc498xxx into the adjacent unmapped page 0xfc499000.
> 
> Have you tried a recent net kernel ?
> 
> Could you please test whether disabling TSO or hardware VLAN offload
> prevents the crash? (maybe adding one option at a time)
> 
>   # ethtool -K eno1np0 tso off
> 
>   # ethtool -K eno1np0 tx-vlan-offload off
> 
> Adding Joe to this thread, because some parts in
> tso_dma_map_init() or tso_start() might have bugs.

Thanks for adding me and debugging this.

We've been hitting a similar read fault for a very long time I've had trouble
tracking down (it's been reproducing since at least kernel 6.9, long before my
SW USO changes).

In the case I am tracking, it seems to reproduce (fairly rarely) and seems to
be caused by a tcpv6 TSO packet with a read fault in the last page of a 32k
frag. I have yet to find a reproducer for my issue, though :(

I'll try this patch, but IIUC padding only applies to frames under 52 bytes,
so I'm not sure if it's the same bug I have been searching for.
