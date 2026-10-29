Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278844;
	b=BbY5Xvrv/67dgP6qW5ovlCOXVfGwFiz0vihrqb7QlvgPY+Oqk/MMwNC3hwagtehK7lE3
	 IHWpoCfQkjw2qQEvhhh2o7WML3y+NpCJdTuoyMQ4W+FJviTuT95/lQh3c4N4e/t6IWpgw
	 9ZvR7kmsaHwCUlF9qbA2M6+Tc/E7WgGq8ivsxoVyaYzgqpCXiETxem8EJkHxjrG4ZK6v7
	 3IU+0HrVl4unMJTTacy+SCUSPvGKUlb6jzDtYrDZwRCTJY4qGS/UoNuXBrFmPL83IUkDy
	 nVP4GY2LiN4YDzUqyuTqdwyBXQ+zHPabECDsSqzlwnu2CA33hHQsLXzKzO1ZPJddiIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=ZFxy9GtFL12rPAidw+29M+i4TMk6Yq8XwEtjbHmgAOTLdNV0Zhsq4Dt5Dx8yxG8TfIqE
	 mPCLlHBPwbd6kRhJ62QqmHHHQTtAak+HeD/b8Q6GEQ+kCH5PG5lS+xEZ6aLFDLv/+rJge
	 aIULafxKfCxaPLyIUrHuEBi6J6kQCfWDvyxn3HP++tW29Lyyt/eaKyY+Y2ETf5i0DQ9NV
	 MwuyFaeBGu19IvED8ReecY4TURNRElT88KhlUFgbLSeManylq9ey16UIxYI+Dcs6ghNXd
	 RwBL+j0O1aX8luTuTQAisyfhAJesD6H1KdEOkP8QqKloCAZ/5ZHq/68Q6SZQ2XoJumg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYEbjCGw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A28606A320
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYEbjCGw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996181F031E4;
	Thu, 29 Oct 2026 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793278844;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MYEbjCGw9WWUDVH0xQDa/TG8wsxd9kUD+LFzRnxuH8pCUM4jlzXLIz+Ftsjfv4msl
	 6vvJ3/cF79kKDtfyzdUYyV3DuG0oiPRabFmffE6x1n84roHTNtu44xskw7FMEkbiYb
	 3UktIywSO4A00dbPvSNXO72w4qfhG+JUOhLrkgvPCG2mPYdfzNcR5UBVuj1sxnDwhk
	 XRNPr7Kmpjy0u9FEHj3dZ1WgXIibcYE7pAOFQHwvATwCECB4Bmu7JmXchJsg4Q2njd
	 9TfJtd60diBdzxoroqgn9r/Qvm5KLktXhST3VE/S/ZEY1eQnu6di7g3fActGkTddJZ
	 xKQJAaTrQYMAQ==
From: netdev-bot+sinfo@kernel.org
To: shaos <shawnq1@163.com>
Cc: jhs@mojatatu.com, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_csum: guard skb pull length overflow
Date: Thu, 29 Oct 2026 13:00:43 +0000
Message-ID: <179327884310.3327.9062445856146813053@kernel.org>
In-Reply-To: <20261029125754.3835541-1-shawnq1@163.com>
References: 
 <CAM0EoMnP3VkEV6fOAMdZ9ma9egUpV4AFfB+44k4VD7jx2dHPNA@mail.gmail.com>
 <20261029125754.3835541-1-shawnq1@163.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
