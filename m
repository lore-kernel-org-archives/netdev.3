Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648733D1CC5
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690915; cv=none; b=lxjCmVretCYGR3dsIdzPMUFd+HAp18mozcDzS24K+Aj0qrRR1L3l6auUSUIyp35pHtyp0u4UlgU7B5skFnuKpmUpfgxD6NN22QqN01VT0maPI6HfBvaU47LdlNbPRNkU6xLQZAJfDFVlL5sMxAVRK4vrqt/cXWZJVN/MTQIH+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690915; c=relaxed/simple;
	bh=U24iLOn5ceW/2lhbjmUxhZCsfbLS5rY8hugeyKJcx5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGkEArZ3RN2xhmZL9FmsO0X/L/l04+t6m9EcPXTbJNno+c5BWFqo+CdU45PN4LNabAEJ20LKbjv9frXANbpU7qQP36wBoejcWf7bj2jazfdQpkHdRBrMDM2LvBSOZ5tYNSUQYxRfvn2ycAtD53wqQthxOQgVs0fC6JgrHDXVZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fchduj1y; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fchduj1y"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso4707226a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784690914; x=1785295714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lqR1pQ6AMxguaF3FILwkKo0jVgND2IUORkim80828fE=;
        b=fchduj1yGMDp4aPP3Za3+IcQiHKN23+1owRMB1OtNvjOJ8fnf37p+v3ZUjpEW/fucW
         4UMdcg5k7CKStvGoe0WAZ6z0CBwBfUkCu8Prp1OqEdiUcUx1CHqGwQH5uCKpqAtMehs4
         So+ILBoYO0m5/MK7vjrbUX8Rnp4WENxyOfcP4AVrbaWsqMBbcSHhqTwaibe0p8rWbrLG
         K1w2x7plyP9grlqm/7/zBZOOd3bNDCOILIk9hIuCd4k0w6i1NOpbkmx5L+7BHzq5ul3D
         PEePd1stkvJF7FaDCrsce+paH2PSCt8AfJpBzTs+IP6EdX1GPEythUKb5PWub+P57LdV
         GvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784690914; x=1785295714;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqR1pQ6AMxguaF3FILwkKo0jVgND2IUORkim80828fE=;
        b=P9oCM6ypHkilxf9S2Fv6PO3Xqftot729Ks6mxfEYgZ8RDCVkh6xLNY+HQ3grzvCH3/
         uji/bSidYL8z9e63ev5j6QSVeZH9EHCCTm7jhzP2YvDT18mnOrvcVDiTKOqTjS/2H00u
         MU0vgjbMb/0T91e7jNfv6Y3YGgEgH15yGbLa2pogv+SE0+XdA0yhJthA/DlQaZZKfp1p
         i7XnYoJugAc3kDAp5vEOX7VUeVYpPOtOW2re1mfqHIDi1d/9mKsnScCinSMcLiqMnQqi
         ArGfjT8ThtCpc/HUXHynerjaiyC4GVZJunGZxoRgNPsoipIJsc7QV1cvSSzB6h6J+vXs
         RFLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3px4U4Lsyz6ziCl9sksQqGbUyFR9PFJQMrVFZsLWPu+7Lw6D2w2/qT1c30r7fBLYy0KqvU3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkAENwKAchdzz5nHxmzV5bZXUeEzTAm+76RFkEE+pZ28SqbAA
	6q0fKDdEC/xIJ1N/Y74eLJjqxPwGHUdyFJVU93VVIJCoe/RkGaq3klH5
X-Gm-Gg: AR+sD134n9ah+jVniMVgU+wAdpDqMRZUNAA+xO58yW6HDKKhH6IKwd4fKmoDAoB42mu
	uUxHOTAbn0wM6qIcGcrgndqqGVeYarNmr93mOBvjb/tWnRJRIKmpuERLtVFuOPx9RNt5qnYXbe+
	s1r+sohtXl8z3dDfpw+g/aGEOtGweyygAAtDvTUDlchWi1ybW9lkx+gFaewUU2HSwxHuUV4K18m
	6FjA00lqTgmoPbun07jFtKDTqpTC1cONTVd07qPtMwTsfBpdLEAvo89d1p/a5L6YUPHchUKtgv3
	JuhsjuBlo6h8+EBD/uOzLipiUoVt5vu7LLtFa7YVfjCbbjC79e89vzRPpgP6UDV1gci/U9IW3eh
	Mn5rk1Sm202OW+6HaD7Dw0dpwG/1mxnEzphDOz8xYtoMlsTcJyEQOLyO3fVez5tRhlV/OmRMg9c
	if6sI6bwKiOv3P4GQ2eLkGQSJek4Y+LF+KBFbwPaGeXYSSeQ==
X-Received: by 2002:a17:90b:2805:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-38ea33d3ebcmr1920262a91.3.1784690913704;
        Tue, 21 Jul 2026 20:28:33 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea7b43214sm284134a91.16.2026.07.21.20.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 20:28:33 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: Re: [PATCH net-next v3 0/3] net: nexthop: per-nexthop UDP dst port for fdb (VXLAN) nexthops
Date: Wed, 22 Jul 2026 03:28:21 +0000
Message-ID: <20260722032821.30166-1-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721180525.197d9a47@kernel.org>
References: <20260721-b4-vxlan-fdb-port-v3-0-9aa0a543a78a@gmail.com> <20260721180525.197d9a47@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 18:05:25 -0700 Jakub Kicinski wrote:
> On Tue, 21 Jul 2026 22:29:49 +0000 Jack Ma wrote:
> > A matching iproute2 change (the `ip nexthop ... fdb port N` keyword) is posted
> > separately to the iproute2 list.
>
> Where is that?

Apologies -- that was premature wording in the cover letter; the iproute2
patch had not actually gone out yet.  It is posted now:

  [PATCH iproute2-next] ip nexthop: support fdb destination port
  https://lore.kernel.org/netdev/20260722-b4-vxlan-fdb-port-iproute2-v1-1-45199b1ee240@gmail.com/

Thanks,
Jack
