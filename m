Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3C3DA5B8
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261181; cv=none; b=e8+hz5iaI1BpltfVLTaPKU94NUJKpx9Za+nOW4hdCdDxm2O3qG4QxMKIhpbUBBi0ABZE7BLhAv0KeDRVbMGj3msRoGFfEdVFlGs3mZPBB1LIyTlZNtdbpcXYLes8zH/ZKyrZm2D5KtUHFESfc/lWfzFN68PaIi2VPVprkr2MknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261181; c=relaxed/simple;
	bh=IofWqYiHDWhFr0zIVM8MdhQyNn1QLhfX+auNiT3zh/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDWqaEtdhyhMOknsTo+wLhHmJfTjysVebgSvapk6HLERGBEV0CwHK36vuhvOEx5wto89Nip4laeC9qTjuQvuY5Shhsf0LQZ2PI2VvjM7W2WArYfGRyg6pVe9oqsrpneV3FNYIPYL9OMFmK2mGEd2UWxBXGq/WljZZVzV2P9iAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGj28pBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGj28pBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5AD1F000E9;
	Thu, 20 Aug 2026 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261179;
	bh=EJm42cpCRuG3bXvLbuPKKTeTlwdly0Orvz0U3cxfAs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iGj28pBraCH9XEcdGcYK4e1FbykoSBlMXFgyTPAjwGSBg6oi+QZ9zNJILXZcZ1IaT
	 V8TGaKh8pxQ7Z4W9eJHozHUpLrIxBy1DOpEPXc6Le09Tvj9bh4GEvGe996GHatGu3H
	 2rE+k6NdZSaXxgEaHmz74dcejwiF95YQ0bIDZJuQQ+cjYAidUHRFuXxbl+bQEJSpxB
	 Apb6ziP+YN5uRY7xnPC3WwroOXq1WL5FTbuXuijKs/rPnQq5STPfXGc/5l3LU1g9i8
	 RfFhX8lVFbiWVKUMvOyTLi/2Ye8AXGJgenxD6T2tn8khISvSR+1uEMcrVLYYtEdc07
	 RJcSffWh7kiRg==
Date: Thu, 20 Aug 2026 14:26:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Cohen <michael.cohen3@mail.huji.ac.il>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, Tamir Shahar <tamir.shahar1@gmail.com>, Amit Klein
 <amit.klein@mail.huji.ac.il>
Subject: Re: [PATCH net] tcp: reject completely old segments during sequence
 validation
Message-ID: <20260820142618.7378ac15@kernel.org>
In-Reply-To: <20260818205230.1146138-1-michael.cohen3@mail.huji.ac.il>
References: <20260818205230.1146138-1-michael.cohen3@mail.huji.ac.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 23:52:30 +0300 Michael Cohen wrote:
> tcp_sequence() rejects an incoming segment when end_seq is before
> rcv_wup. Since end_seq is one past the last sequence number consumed by
> the segment, this misses the boundary case where end_seq is equal to
> rcv_wup.
> 
> A segment that consumes sequence space and has end_seq equal to rcv_wup
> is therefore allowed to reach later processing, including ACK handling,
> even though it should be rejected as a completely old segment.
> 
> Reject this boundary case while retaining the existing behavior for
> segments that consume no sequence space.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
> Reported-by: Tamir Shahar <tamir.shahar1@gmail.com>
> Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
> Signed-off-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>

CI says the AccECN cases need to be adjusted.
Example failure output (tcp_accecn_synack_rexmit.pkt):

  tcp_accecn_synack_rexmit.pkt:15: error handling packet: live packet field
    tcp_ece: expected: 0 (0x0) vs actual: 1 (0x1)
  script packet:  0.104 .W  1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
  actual packet:  0.102 .EA 1:1(0) ack 1 win 1050 <ECN e1b 1 ceb 0 e0b 1,nop>

The AccECN tests expect the kernel to observe and react to the retransmitted
SYN-ACK, but the new boundary rejection prevents that.
