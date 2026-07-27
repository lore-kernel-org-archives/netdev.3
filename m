Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F5429CC1
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184492; cv=none; b=ChwAgXphhqN/1Wfd1FK7XYRrHovYo9Rd8HdQn6pUNmRIP0SZjpb43p9O3BmdP6L3CG+UCjLNlcUr3AOYA8Zf4v19p47L3Z8zaKz9ZDgFfZ7K5B1IV1Vt/mDVW5BSsR+GVrlGD3/E3m0MRdnmkSUlIksZagz69esYFnsDJMCx/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184492; c=relaxed/simple;
	bh=7IcSSq/oRQup2PVUjuxDergGM3+BFa1+1MfDls8LKoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JDSCvERrxl3A0Y0QpPt+62xXf4UQLzgaJIjCH2ev9lXujx1JTQvnJky+tZxDiMDbQ/YeBqRwH7v1gPp3K9RSQW29z6Jvn+mcTme8YEzJCNosG5WlKt2JCaBS7Cvo7da2DDEwiFUF4bJcfoMVRDRMhQCb8BTmLRgrTK1Rr8gkSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdvTD6Qh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdvTD6Qh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785184489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbht9hnAqPfmz+672SjRRE7PLFc9j+t7J4LxXeoF9v0=;
	b=EdvTD6QhDZyxVp116tCHJz9zMvrHAU0PyYwMW4pvZTs201f+FH71KHvWR47cqRlGfJ5+GX
	7DdobsF4LslMxWOxMuy2DDMVd1OoDu5lyQomdxdAU6qdmD/9GkybJ5oGW4Uo8NfgcYvpZy
	9WYj8QQmuafD+O02bN6jx3lSSVOM5sk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-OlFlIRk5Nzif375CnaTTpQ-1; Mon,
 27 Jul 2026 16:34:46 -0400
X-MC-Unique: OlFlIRk5Nzif375CnaTTpQ-1
X-Mimecast-MFC-AGG-ID: OlFlIRk5Nzif375CnaTTpQ_1785184484
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 921EF180087C;
	Mon, 27 Jul 2026 20:34:44 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8B4A18005B3;
	Mon, 27 Jul 2026 20:34:42 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: i.maximets@ovn.org
Cc: netdev@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [net,2/2] net: openvswitch: fix skb leak on flow key update
 failure during ct
In-Reply-To: <20260727181851.306076-3-i.maximets@ovn.org>
References: <20260727181851.306076-1-i.maximets@ovn.org>
 <20260727181851.306076-3-i.maximets@ovn.org>
Date: Mon, 27 Jul 2026 16:34:41 -0400
Message-ID: <f7t1pcoxjby.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Ilya Maximets <i.maximets@ovn.org> writes:

> ovs_ct_execute() always steals or frees the skb on failure while
> ovs_flow_key_update() does not.  So, if it fails and we return right
> away, the skb ends up leaked.
> 
> Fix that by breaking instead and letting the common error handling
> code at the bottom of the loop to free the skb properly.
> 
> This is a very unlikely scenario as it requires the packet to become
> unparseable by applying a set of actions on a previously parseable skb,
> but should be fixed nevertheless.
> 
> Reported by Sashiko.
> 
> Fixes: ec0d043d05e6 ("openvswitch: Ensure flow is valid before executing ct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/actions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Aaron Conole <aconole@redhat.com>

