Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E03BA25B
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836610; cv=none; b=rr5ZdGzLPuBi6Q2KyuvUiTAMuuqvcC0rS54coL4clb4/VkcBHKjbOUDV4RbQLekVO8L4T0IsvSEuMmK2zgmjjw08f/+NdAO6/jqmcwRvhM0tOoUkjWLGeLe8LI2OmzDuP7kW9HPf/iGIpa91+HlWnm3/Y+MYHPEWRBTMHiaGWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836610; c=relaxed/simple;
	bh=4C0FenBlKdMfYcukbw1u+9HyE9KEWSAVZT2pNCv6zuI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=UG/sgGoWSi2f81v8zdg5DGtBMFbvVLWa/evqVCOXGH1OtxqzLmPfX0nu82kB4+3pVFPJCx4fC/P4QfR6sbL87KOzyJFoJTXAGkc2SH5/DAxBUXlOZqiA7+daVETM9tgMpbhWI2EHstUGY3zNJ2H7mfYUoNWsWVP9T8ltSiHqOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFMdpwbm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFMdpwbm"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b9b190easo4970933f8f.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773836607; x=1774441407; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4C0FenBlKdMfYcukbw1u+9HyE9KEWSAVZT2pNCv6zuI=;
        b=iFMdpwbmir4JR4Xj11VpeVK+TTUvJP05jUmoE4d9rUgt/rFYDhaVxV5ajrVMKQoQ+s
         wtpJweALQNRwD3UJm0DzinkZw98iJkwddRJm3ZhVubpMK4N9YpRDqde/oZuJh7Jnfq5D
         I46OocjoSdW176sbgov6uQQ71ffOtXkdK0ljHD1qVOYhKuIIeGaYvH1EeHI7LgHX60D0
         ycayw5uoYywXUAGjNjLU/D25Bo87Zxgngs1vgicLwvBqG1juQDNQrifTEHSwrNO7UEbg
         TjDEsoMPg++OjhIad46C6/ePT7hh4wZZdsWLevVqUhIBBX3sEW1mBRu9AFQMWKp/iGnr
         AIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773836607; x=1774441407;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4C0FenBlKdMfYcukbw1u+9HyE9KEWSAVZT2pNCv6zuI=;
        b=hQ+q73buxC3jXtTyQVLmPcd2zLGr2r0FtHjJaGZJTGfFAa283SHdyv75clRBWX4org
         03eqwXn2jmzTQTPttU6W2Fmmrikg9sRCv8rpOTip5cY6M85M6QolGDAxM7TWcB8RgcFz
         2ch4RnmxcYJnQ4543gX00dZAcFo4x4i3Ixl8FaObAf4hygOVCGwL9gLiIvzIHOoL2znT
         g5cayT/fmDMKFgAOEKTWOWOGHqsoMMDCMUBx2D362SnfEU+iMoy7avPS5x7UybAt38Up
         kQPh65o0I0wGNoLBxt1VNxa0MCuxjXsFFnBfDIREUMwFE56hUwoBDLUTbg1cBqVcvVfG
         l9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5rlnrwGNrZN4mBhz9sxPPFgj49JvsortM/zyhn5uxMJDN2PWRHdA7Vo3KbeeDlS2xObzxARo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxUG5way1LlMfI0phHWiXVx9z/Sr6IQVX5qYKqhaKVqS6U1Od
	j91SqzBs0F7dxnz4Xyoyy/0u6eJsrGbfvbHkNilgr+9/O0HKBQ/zPTEh
X-Gm-Gg: ATEYQzwr09yoG67RM6mA69YXQ92Zmw/p72UDY7Pk7jXBtTTghMdmIuDqfTv+k0Z5jfn
	366SETsIPfYgUx6/kAcVNiSxgP/diQm/cTkw+JXv4KDbF3DQ0CAYDwYMji1ZeuyTg/G6Q17J4gy
	qKCFb+nCEMxENBLmZE6uuBIY2d/yN94BN0Y4y5wjGWOt9E3rOXmkj30FkoYUMCgFdM5oHo/83N/
	Z49NJV6Nyv4Y135sxLwzK9fQ9xhBWzkLCl3O8q97mEcwwcYnUxA1ElQBVPO1Rjix8SInyvcMYoE
	uTAo3tgS+1EycRwC0ry/gHB5MXP51XpopgUxgsjUCgBFrUlASmt8kKdHRf87YMLjT8WRlVSqDbW
	mm9qDMd1eDBZeEBnIZIM27ac8+w/7ykcxebAZIzo+FYgFoQOKFkEXiz466AwANIe8z+TEKwC5CN
	vttoPJrmv7V+Id1xh1pnxL2+XGKg==
X-Received: by 2002:a05:6000:4008:b0:43b:42d3:31ac with SMTP id ffacd0b85a97d-43b5264dc3bmr5081888f8f.0.1773836606582;
        Wed, 18 Mar 2026 05:23:26 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852ab3sm7793952f8f.12.2026.03.18.05.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:23:26 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  shuah@kernel.org,  sdf@fomichev.me,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: rework policy access to support
 recursion
In-Reply-To: <20260313232047.2068518-1-kuba@kernel.org>
Date: Mon, 16 Mar 2026 11:31:56 +0000
Message-ID: <m2tsugj9hv.fsf@gmail.com>
References: <20260313232047.2068518-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Donald points out that the current naive implementation using dicts
> breaks if policy is recursive (child nest uses policy idx already
> used by its parent).
>
> Lean more into the NlPolicy class. This lets us "render" the policy
> on demand, when user accesses it. If someone wants to do an infinite
> walk that's on them :) Show policy info as attributes of the class
> and use dict format to descend into sub-policies for extra neatness.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
