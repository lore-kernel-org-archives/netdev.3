Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CE568530
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001969; cv=none; b=cxRNn+cLkcF3m8PbXsUnnOhF6QN1mmSXoTzFYMGkDmbuAKHgK1YDNEddagBhsVNB+jMTCvbBrBVtsyy1Zgvd8aYfLDKTj2fHxoITndbyh5XBfGH6a76ysemTE8aaXvSg5HgBrpOxQN/g8/ny/zimCO50ZDB1l8647oQpCFQ7W6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001969; c=relaxed/simple;
	bh=xLy4bwJA3p4oGwSxkOP7algz00ABvvlb2hL7FQ0tbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEBZ0uZaSVDZLFQCA6NsBV5FD051X9JZenj4E8lptBQpdEZjkBHjcl4lMySK3bA1wtTtYotkjDi47fP3MvC1wqQXeJr9GLpnvLBlDtRhTcB7+9IqkTrWRWb1RwnGyzjFqwAbF6gEisPe85fj4YFKGTesiB0JE8KtQ55w+FAtL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=mcxCiTw4; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="mcxCiTw4"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917a64f28d0so84255586d6.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792001967; x=1792606767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d7wsO3zLWdRB4GlI02kHERXU64Q1Nav35BL5ro5gRHk=;
        b=mcxCiTw4lZJIh8U/OXoB6J70gl5U4J2msmzGl7f4VpgSa4sFZb2o+FzALZjjUAC0Ng
         Dy8VvO5LTI32n46fuv1RfgQ9Zkv2rv3SFX3o/m9O7OhKnePyftas/KdC7zytsgpJh4xJ
         ci2OI8Gy0Jwz4wExAWokrjz3PXfDwTsHdAEmDHpDBmheddrni//eLjLBHY1lPVDvnh4N
         TtsKzcF/WE7VMKVA7tdwO//4VSaNqC4GTlIl/tjOBX/uOzsTbanWVGX6iSrQ3JZ/0OsZ
         495mYKhcx45g8VLDctwl3rnIkhbi2Qb3JON5fBw9wllPBl2J2XWDlmVaIgMVD1V8KsiP
         YkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001967; x=1792606767;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d7wsO3zLWdRB4GlI02kHERXU64Q1Nav35BL5ro5gRHk=;
        b=hfd5hG8PijF+29Qyi2TpFZMGDvPdQnmJVtGhWhmB4f4bib0k7wrBKbf6AD7QihB2G7
         fjKSRU5sX3KAjqsfe7EZ0cS3b3Mh6qX4LJQIgRL81/JGx9SOg51VogNexBD61HOoTW6t
         5Sk4+zFNgBbUI/XGQ1WTZibfktZCsul5A4RkWP8j3ZjC5ulk3j38O2p++u467yL20p3T
         wbQ7mBB6q+Ne7jKJxtyHdE3GUjExwYLc/xk4ql/o65xoZWyRD8dCKHUP5kFsdJaIXd92
         c4eK4q5n9d+JuJuWBUawfHziz/gGYKXc77agDAe5FEqKBGFWDkzTnwB1o2Xj6WLG+MCn
         CmAw==
X-Forwarded-Encrypted: i=1; AKwUvBwPnJ4GOP+GAd+d+h0vZcLstRBsgwCUgi+Bv52n6kMCRa9Pe2a/ZSrO47kEo2B3z4tsK9Rok64=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiyTECoRfVYqDZfGHkrGT9Kx8HC3Od0aYXWH5NtLCH57yvoGhi
	UzAEzYCK7JYX/fWKn38daU2cPPCQvg3lO9zvIiWPpkrUhzPtocDJAHnRlGTcD9XKWRA=
X-Gm-Gg: AYBFou3qEyBCJom4u3AlLj/85apr765GbBoUaD4Ll3RZHkoiLyJwbpudX5kWmqqnrKc
	TeO61VZSn5M+KwA63vsbKZ7qjbiQoh9PFiBGxG+hzGV6b1XZ7stxCtyFc5cnYMmTI3DNel9Pja5
	64Z54GhAcVxYRGrIyYVzFSwuhW5iKUf06h6j5laQzheIclkysUiwXjRMq2h3GQhwwDXl+iMB7gA
	H5zbSjqEnkXU3yY29C9y+gNIbrOUZ1EyLQtN/9w5VeuL+UZSodDQRAf9fy3oyOQtC1JHoPbsK0p
	tYABn0ojYBO6XZBlcxldlqFkMk6BcbiSFH+tlyOZ6raD93mC+kXUgjH4nyYu0xELJyXC0VzJZtn
	IkWewOZqVBUXAa0eQmHIUlVENOc6adn65P4uKLJif76eSbK/j4E1Mdq800z+b4eM6dZBq0YJpLy
	U/m341EXdyfgCuLI5kubaC2t/uTJSfu5D9WIcSgK2OIbmSODHkq/6V4uq5uZ/EKeCGqoj/nadPx
	g4ROPMkw8LPRdQ=
X-Received: by 2002:a05:620a:2728:b0:93d:23d5:32fd with SMTP id af79cd13be357-93ec1499888mr2303090585a.27.1792001967385;
        Wed, 14 Oct 2026 11:19:27 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef508205csm553393285a.35.2026.10.14.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:19:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report
 unreadable frags
Date: Wed, 14 Oct 2026 18:17:01 +0000
Message-ID: <179200182107330.2.7762063370688204320@toxicpanda.com>
In-Reply-To: <179199883858343.2.17884063473154560573@toxicpanda.com>
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
 <20261014135154.05de968e@pumpkin>
 <179198668564919.2.10323410751655182155@toxicpanda.com>
 <20261014173042.0a74a25d@pumpkin>
 <CAEzrpqd9Pna32K8i5Ug3tP+ZiRa7-0GmyX+sn=OwbZ_3osEAsQ@mail.gmail.com>
 <179199883858343.2.17884063473154560573@toxicpanda.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, Oct 14, 2026 at 05:27:18PM +0000, Josef Bacik wrote:
> So 0 can't mean failure here without changing checksums, and v3 will
> keep the explicit error return from v2.

Scratch the v3.  With the code staying the same, all it would add is the
reproduction details from my reply to netdev-bot, and v2 still applies
cleanly to net.  So v2 is the version to take as is.

Thanks,
Josef
