Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CB335081
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703611; cv=none; b=ux7oUb1LZn5dRUYyjydrwlmLGr9G5r5ZuaLB+pCH7KzDI+cJsPd04fYC+vCPv1ry+pKABqEhybczsJI8gbjeyfHq/hPJjVRcZ/08KxAomL1iIIF4C1qJ4mRUzC5gvHOwuuvYcKm3ysDEVJ7qnkDimXJjxMfZOQDOTIdpx6SK3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703611; c=relaxed/simple;
	bh=PFVmj3wg7i5RLRoiMygNxFHiRuKHl3fDkfLH6PUFNMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYztX/2VAHapqgxChnDbnMTYcQhRmdkiPgg3dFJc0q/RxlRKA2koQqrXFwGsG+cwrL/u37Tc3yqjabMnBnz70nyBptoHwabLotrDBFMgSWn3B3bXAC0I8CTceq+lD0+DElw5sTkH8VlZrlWZUPIdm60yIK+iYE+PXawy2WwWHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BI/Pn3gI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BI/Pn3gI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UT3UX+BhCHFvVpv2R2yyOC3sJNzabMmhRqPV2ECO9GA=;
	b=BI/Pn3gIJW7g/UIMxcyyvCddqKHhI3xwiWJhXfAyyKgJ8OktMC1n28zfE8Pr2HT/sYTt9e
	Z/lRJ+otSEjhl0vR4fBNNDY0YtKiuE4acDlxJVSmd8iM9CTrN6IPvreZCSAPjSLykFk+e7
	7NrixZRlniSYsCHIDDvh10nYqjBB8J8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-IX1mGp4-PhWqurOb3hRbGw-1; Thu,
 29 Jan 2026 11:20:04 -0500
X-MC-Unique: IX1mGp4-PhWqurOb3hRbGw-1
X-Mimecast-MFC-AGG-ID: IX1mGp4-PhWqurOb3hRbGw_1769703600
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A9971954204;
	Thu, 29 Jan 2026 16:20:00 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3DE81955F43;
	Thu, 29 Jan 2026 16:19:56 +0000 (UTC)
Date: Thu, 29 Jan 2026 17:19:53 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 8/9] hsr: Update PRP duplicate discard KUnit
 test for new algorithm
Message-ID: <aXuIqWm9Aiu_f4vg@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <e1e0065cd9ff84a970625d77300ba028392981c4.1769093335.git.fmaurer@redhat.com>
 <20260129151241.44i6yt-r@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129151241.44i6yt-r@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jan 29, 2026 at 04:12:41PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-22 15:57:03 [+0100], Felix Maurer wrote:
> > With the new duplicate discard algorithm from the earlier patches, the
> > KUnit test for the algorithm needs to be updated. The updates are done in a
> > way to match the original intends pretty closely. Currently, there is much
> > knowledge about the actual algorithm baked into the tests (especially the
> > expectations) which may need some redesign in the future.
>
> So the below isn't new but I wasn't aware we have this kunit thing
> earlier. It triggers even before your series, just differently now. The
> problem seems to be that node member isn't properly initialized. So
> lockep complains:
>
> | 1..1
> |     KTAP version 1
> |     # Subtest: prp_duplicate_discard
> |     # module: prp_dup_discard_test
> |     1..5
> | INFO: trying to register non-static key.
> | The code is fine but needs lockdep annotation, or maybe
> | you didn't initialize this object before use?
> | turning off the locking correctness validator.
> …
> |  lock_acquire+0xc8/0x210
> |  rt_spin_lock+0x2e/0x1e0
> |  hsr_check_duplicate+0x40/0xb0
> |  prp_dup_discard_forward+0x30/0x180 [prp_dup_discard_test]
>
> It needs:
>
> diff --git a/net/hsr/prp_dup_discard_test.c b/net/hsr/prp_dup_discard_test.c
> index a7a5beb52d62f..2ab346d920bbd 100644
> --- a/net/hsr/prp_dup_discard_test.c
> +++ b/net/hsr/prp_dup_discard_test.c
> @@ -27,6 +27,7 @@ static struct prp_test_data *build_prp_test_data(struct kunit *test)
>  					     GFP_ATOMIC);
>  	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data);
>  	xa_init(&data->node.seq_blocks);
> +	spin_lock_init(&data->node.seq_out_lock);
>
>  	data->frame.node_src = &data->node;
>  	data->frame.port_rcv = &data->port_rcv;

Thanks, I'll add it!

   Felix

> Sebastian

