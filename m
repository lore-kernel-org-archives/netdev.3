Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8B3E1CEF
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349405; cv=none; b=Yd2ns51oHW9Omk2DXb0daW9Y1YYdjWZqgSci2F6Ysi5YmSZDiZnq+IR8ozDwWSpZUSGG1hbiCDE4L4ZfbjKLEw6Ar6aPHT2k4k5RSclvcJk6O1dn9E8+E7PnKKmtY44ncdZ4dZFBWLNCCnx6NuBAzN1rJ/nUm+O2+jd4eQt3WCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349405; c=relaxed/simple;
	bh=Rh1vgYbukgGycrzHGH8cwNVmcXUbb/k0vTFxH+uWsOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KI3tRf9jnnM7CO/14QWFYjGhv0YpRg0ARRrcRcGv58ESX0/2kIkyXco3Lf8xR21vu92vj94KYJHtDG6kQP2psSAn19DYxNW69HVaOpsqS3zp2U8GKnfTVSOUSaLLOcgAbc8mKZZhAvASwet7enuTDuvKiannr8mFRFa+8JyKJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPaxA1+j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPaxA1+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783349403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iy7BN6o8CJa8VD49+oAWt1VcR6U5zC7d9Pjayl7vxeU=;
	b=JPaxA1+j/VzfSrQP+7nnWR7k2aBvVKb1WZRPtSl0ptP/r8xgijFta/e8WXMPdgzp0H91l0
	x4GRZwaoTxFIihHPk8aahHyVbCA4+XvsVGMPN8rolSlVHPikQRYfWBMBN24eFz+tyqwoli
	GywOycb/3R7W/t2traMZFHzn3EcQsTA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-zjKFGZzlO6-asScH71gwLA-1; Mon,
 06 Jul 2026 10:49:59 -0400
X-MC-Unique: zjKFGZzlO6-asScH71gwLA-1
X-Mimecast-MFC-AGG-ID: zjKFGZzlO6-asScH71gwLA_1783349397
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E6591955D8F;
	Mon,  6 Jul 2026 14:49:57 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04A7D3000B52;
	Mon,  6 Jul 2026 14:49:54 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org, kylebot@openai.com
Subject: Re: [PATCH net-next v3] selftests/net/openvswitch: add output
 truncation test
In-Reply-To: <20260702074926.1174810-1-houminxi@gmail.com> (Minxi Hou's
	message of "Thu, 2 Jul 2026 03:49:26 -0400")
References: <20260702074926.1174810-1-houminxi@gmail.com>
Date: Mon, 06 Jul 2026 10:49:53 -0400
Message-ID: <f7t33xw2mwe.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Minxi Hou <houminxi@gmail.com> writes:

> Add test_trunc exercising the OVS_ACTION_ATTR_TRUNC action. The test
> verifies truncation limits in four steps: reject trunc(1) and
> trunc(13) which are below ETH_HLEN, confirm normal forwarding works,
> apply trunc(14) which truncates packets to the Ethernet header and
> verify ping fails, then restore normal forwarding and verify recovery.
>
> The kernel requires max_len >= ETH_HLEN (14 bytes). trunc(14) sets
> OVS_CB(skb)->cutlen so pskb_trim strips the IP payload at output
> time; the receiver drops the runt frame and no echo reply is
> generated.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

NB: There is a note from Sashiko on this about a pre-existing issue with
trunc() action.  That issue was discussed a bit offline, and I think
someone/someprocess is going to submit a patch upstream "soon."  That
said, as with all actions related security issues in OVS, they require
giving a process CAP_NET_ADMIN, which is quite a powerful capability and
generally not advised for the average user.

