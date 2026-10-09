Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6933EEAC1
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524399; cv=none; b=Ebx4Y1zI42SG0zTzvMlqY9pHW+n6utPXdvpEuzd3SUNxyp3RyJT40Xf1ZSC/gzLnUT6OC01x/xJ7a5/Ctd91nmbJZelBpgmE5fN9v4rAyrd6Ac+VgtrITt2L3/YOT3lLYtyy9Zx5ybR7Ao57NgEQJ+AExz08ro7XDP5JWnZlEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524399; c=relaxed/simple;
	bh=+C3cHbNsomd6RYHV2leUz9PmRIt9GWQW8XPR1zddbC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1tYH86miKUqqHPnl5+ujyHu+oBT7FkYz2uy34UQfFXPtPB5g5C/F1jJZB25UcHhzOjncw8IVNkJtRRKMf366w8OYSOYJIZofqqASZFJhdLLKegpDYGEoBahzu/GD1oMwee2JC7aEO0UJqXwmGdGPUdcWPsMAM58svn7YwrRsZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peq0V2s5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peq0V2s5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d560775ca2so19272615ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791524397; x=1792129197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eV75knIz8MqpcmByph/prlZc4FrjYSgYZQ1PpGGXuRs=;
        b=peq0V2s5mW0i5AIdFX64cviFI9moKVD5n+FFn3+2a47asYsuKaOn76waN6jcWC6sB0
         xWtRdzlqIj568L5drK7QYxd9sbITgpUByTV9MzSlYFTHH3G98amne1i/sfuMnnSrIVDf
         liXYjgurC5pQvrcvf+D5ZEmWAvcNCkqOnbwYHaZULsdU6dYruwdmU6jt007r8Vpt5bkM
         NcWqKG+OEO5JJW/r+g5WGiIS3x9FZoSEvNwU78zwhvWS6aWlpftXLQoEH+pjVEcozUwR
         f6VKFLf4r1tnxHb2S193uPBF2iIue2y5p+L8fcAHaInjkEbBHsDESVoCvbZbv5JkdfyG
         HknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791524397; x=1792129197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eV75knIz8MqpcmByph/prlZc4FrjYSgYZQ1PpGGXuRs=;
        b=VGYzVct23VptCYckJaCdVTj9JM3SCm6AhjnZTHh310o0Tyc0V/UUhVKt6of1DeZy9n
         OVJ8sFBsOjpJqNrauFtKjHKHbDC/gQQHlxbCM7qZk6VmctxvmT99NRvhdt6x2a/hZG3Y
         FrmJwM/o9pGvmPBYbOIilfKnBC1Zdbizy+Ri/XTWbfoC6FsG7urRRkUyE+MQNccaB6Wz
         VkF270IwiKjvWFpcxbgHacaYrx7LxSjmWEpR1Dc2Pu7AvEDsy7/iM/qBcJqSlgMjgGun
         hi23P3ahNN8L2ipLl9v1QhDnrmO2BrSElGrHXZh0BN1LcS/z0NLoRhQ4qRYH+F1NLd/r
         I4yg==
X-Forwarded-Encrypted: i=1; AKwUvBzQZQKSZObZgLzvl2bV4fUvQtMPNgMHWSC3kc9XvBXIMnvqtZeNrVIqZR9b5i/a3Ec+AdGFT6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiPgD+k4X7/SveJml0oQWs5XWfjteEfFMG71CuNMt2BXAQpxcT
	769twUz9rRA6uyRKAD/xYSwOyWdfRc8cTX+7k7XldDN5drrMnJkhnG+x
X-Gm-Gg: AYBFou3LK0um3v3WyaMCGoenngMHsFGYWJJizY5u8hO6ctNeX8IPAxlggoRm21fN94g
	JcSa4xa4F7EcwUpZMclhojkpuE/OSzq2AToQdyWpDuZg4Rs7zolprSDKYUpAVAj7xR7r5YLW0E7
	cxR0nMVxmCoTsq+qwnZf5BHh55lfH1xXhJ7+sNeA5QfRwLKZ4CmaLPg2E0HCwCEI8M+boIqNy78
	6ocWJNBMd/SjM3C9OJT+fsoyhali63p4ezeeoZIvh+1f2Yq2aqVp/QMYEJprDM05V8YRIjvVgGf
	BHJERtFNo+0bs8jXMGiFcv0S3QgIAur8zcLdLpfYKcMSljmZYSnvK1zvfkXLJoi1aMXDBTrd5gO
	qtDHxN0OS7ls/JrbhPTp2Zb28tJjgytenCeBpe/FpJph/eiavj2/uHBXXNLWuXu5mSd9TbzqyWc
	XlifwWyPRGmATt9mGNeRK1auoyhXRC1xOSTgjpSA5c0rQbY6Vz4raTIevChCoDWZg=
X-Received: by 2002:a17:903:32ca:b0:2e8:480:2bac with SMTP id d9443c01a7336-2e842bc1398mr6838005ad.25.1791524397317;
        Thu, 08 Oct 2026 22:39:57 -0700 (PDT)
Received: from dev ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8e11sm3741575ad.57.2026.10.08.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:39:54 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stefano.salsano@uniroma2.it
Subject: Re: [PATCH net-next 1/2] seg6: skip the route refcount in seg6_lookup_any_nexthop()
Date: Fri,  9 Oct 2026 14:39:49 +0900
Message-ID: <20261009053832.seg6-lookup-noref-v1-reply-dac23740@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261009024341.687e7226cd6abca80e779fda@uniroma2.it>
References: <20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com> <20261005-seg6-lookup-noref-v1-1-092e84774e80@gmail.com> <20261009024341.687e7226cd6abca80e779fda@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit

On Fri, Oct 09, 2026 at 02:43:41AM +0200, Andrea Mayer wrote:
> One possibility would be to split it into two functions, conceptually
> similar to ip6_route_output_flags() and ip6_route_output_flags_noref(): a
> noref primitive for the callers in the seg6local input path, and a
> refcounted wrapper around the primitive, which bpf_push_seg6_encap() would
> call. The split would put the contract in the name and fix the
> use-after-free above.

Thanks for reproducing it with KASAN.  I agree, and v2 will do that
split: seg6_lookup_nexthop() will still attach a refcounted dst to the
skb for filter.c, and only the seg6local input actions will use the
noref variant.  The lifetime of the dst from the exported helper then
does not change, so its declarations need no update.  The commit
message of patch 1/2 will also drop the claim that every caller runs
in the receive path.

pw-bot: cr
