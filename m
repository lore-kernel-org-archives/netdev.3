Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111315350B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220539; cv=none; b=bZAFp/zL+Q2ZAV//mOPabdEVNySaLt9VFaGKbpKbURtFQW5H5kAT8LWoQgew9QFVQj3jnCHkk5VU8/gn2Y0A0bJL2bNgZqqgBOxSFqWrrwdoIi70ntm8s3gtKYGUXZ0pxWlaRbcUzeLmZOZvX7d4ivKcDOv9k5ll2hixcEaFRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220539; c=relaxed/simple;
	bh=998FNxn0ZJwzCIzGEHQSyAioUYH2GLPFWbSOsSZUURw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=F/VXYNXMMTdVUGRqrkqyVBj7raXKdNOALDRwPP/0QxySRhJwkqBccexLqWgKP/H5tNWQmQywcLKj+DQYLQWYJgkEi7jxBHi5vQerIAuE4krfWMLck/6EsXDODsfkrGMezUIrXB0rGGK/v8tQjEObfLiXM+DvkcpSlQ1Wqx21iTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZqJi8Jl; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZqJi8Jl"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-67561cbafd0so1743286d50.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220537; x=1791825337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GiMc97/Iy0RVOFN6ykyk8XCmXGkN1FTr+5lXo5/eSk4=;
        b=XZqJi8Jlr0a5iFqv2jXPXVMwV8vSgpkSet4rAuGkz+CVq6X4ov8obxKAygbLlmB/Oz
         cFZAeMGStXX/hNR419JYeWkp+D1q9Hrp2gkhMemE8zRxoPRLIidqFzDG638jQxtfG5Zr
         rlmRNmtAQYaU7hfqRDPDhZjXmXgvATcdLedJKo3f0e7B+IbJWgt1rcF6bWh8vV91m3Kr
         bgAGUmXiUkcCRyqs2mB3t5Y7Qld6xhYanUL3DYBwHcKdHC1WYnENjLTLYLrz688cTwXc
         WRo+k/Lvfw1WzopUABk2rgzYx+rnKqXSvRjSFFvQ0ISw8/mEaux+BU41pZ4mRUk8HymF
         NQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220537; x=1791825337;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GiMc97/Iy0RVOFN6ykyk8XCmXGkN1FTr+5lXo5/eSk4=;
        b=Fa10Zfb+qEwYyHEz3flWTtl5xA7ss6BA8lIwlyvb+HkjgdNYN/ktW5E7m0W2zmBm4X
         gF5T4hLEXHnKoLomnEQD/0EunNSbKNJBZiyBz6HvDN+zxmjzbm2W2wqlOhT94xqTMQbn
         QCXc+RQzddHe1WUJYnpyEbEFTQEF0vr/QI5lcl2RV5/j3VspsEWc4ZvdZHKy6DoWpeqN
         meK3jscwIGgUinMk1IUgHRS+V42OhpOGBm/VA/jiyxq9VcN0HlO+oxrdrpejT5g5eAP0
         7H5TvgCRWzoTxfKUNzinZ2hQHDDaFUAKDRPK3X4aDvlR6VHmGDTGzXo5MoLvSivkSC8S
         bOMw==
X-Forwarded-Encrypted: i=1; AKwUvBxulZ+u4OTIOEXuUGoqMi7OsIlSp3SvXju/fYGKQxvKhwN41jv/BPLCSW94ir7vQD30b4kLf1A=@vger.kernel.org
X-Gm-Message-State: AFq9FYISw7qHMEjqIVW8fgMDLtHGHAzp1605vhrnJSiUv5EkZDA8rOrX
	N2izUWc3vYwzPzxSJgGtF6+vFkgdwuvTWjPYFYGyt+q1hiEWXy/CX9Ix
X-Gm-Gg: AYBFou3R1dKozz7AeY/RV0aOIYuu1Y8dLScc95k0hcpQxhxqz/gpyBeyV4umkIHlyEH
	OYvN524XRvmWqyqnAExym2Tm9yDSupXMF6XDeRgZtBeR0T6Kx4xWU2qKDuiQfIHiwUwMPVNsnTN
	hxwnMbRClGcuvSR7sMC+IM7OMce7k6rbPtz3PjJKzjW+mPhu/AcAvGllTgyH9bqVhPYwmt8u7VR
	HV5NVW6HYa3YFiFbUczHRBQMNu1vs5uxDuf3a3YqiNl/76cylbYfk7PiOcYAvp6LxgCRUdh9I8O
	Ok3OERCEVmneVjZJLncxY1h5DWdOoPb25Wmc4hrA64Y8DyWmeHvLQHk9kgRxd0avW1MK6JE7lrs
	nP/hxLvtVpRQUeiIgbyPw2RZf+Abqhew4rlP1ZGKty6YjOja7YoWPs7DwzDuabif7AkadWeqnsR
	i87lVCfxUZoFDInBlFuak9yABxJT3z0sz7+N1S4fPk0RZnhcua23uTIoZsFrTBQXu3p1CRliYo6
	ScBoSTDOsUzJmqVA38MWO/E9LHTasQ11rcNQIjvpAXsyYbmGlarAFpE3hMjgDg=
X-Received: by 2002:a05:690e:e8a:b0:677:a816:4bbd with SMTP id 956f58d0204a3-677af52917cmr4014487d50.51.1791220536664;
        Mon, 05 Oct 2026 10:15:36 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b1b585sm3432802d50.5.2026.10.05.10.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:15:35 -0700 (PDT)
Date: Mon, 05 Oct 2026 13:15:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Umang Pokhriyal <umangpokhriyall@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2caa30c4a0ad5@gmail.com>
In-Reply-To: <20261005061236.22907-1-umangpokhriyall@gmail.com>
References: <willemdebruijn.kernel.3720fccc8b4e4@gmail.com>
 <20261005061236.22907-1-umangpokhriyall@gmail.com>
Subject: Re: [PATCH net-next v2] tap: report IFF_DETACH_QUEUE in TUNGETIFF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Umang Pokhriyal wrote:
> Willem de Bruijn wrote:
> > I suppose we want tap to expose this state through TUNGETIFF, like tun,
> > because applications already use that?
> 
> Yes. CRIU reads IFF_DETACH_QUEUE from TUNGETIFF when it dumps a tun
> file, and Cloud Hypervisor did the same until it found that macvtap
> reports every queue as attached. Code written for tun's queue API gets
> the wrong answer on macvtap, even though macvtap accepts the same
> TUNSETQUEUE.
> 
> > Else cleaner than working around bits would be a whole new TUNGETQUEUE
> > call to match TUNSETQUEUE. Rather than to squish this into TUNGETIFF,
> > while that has no equivalent in TUNSETIFF.
> >
> > But, that approach does not help existing applications.
> 
> Right, those applications would have to be changed to use a new
> TUNGETQUEUE.
> 
> Thanks for taking another look.

Thanks for verifying.

Reviewed-by: Willem de Bruijn <willemb@google.com>

