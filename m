Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9DD233929
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434244; cv=none; b=WXkPW7WQUpOa2RjGPR53Rz3uLLktlqgT/SwOVOB4heEV5bswGZctiKGzY2XV2SIhBedAK/WKBQKcEHPTdbVa7Bo+Ln5PzTN0Wi75FPvXYv4YOOuiAMX+AzofjGJCuZ4x137Tm0FMMhvOa/wVVQI6k/OcY14juLP0DvUSsWEV9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434244; c=relaxed/simple;
	bh=7kp8EGRBrhZ32ZvIQKcmCAPVBz+tqwSufBs6jCIhNSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXRdPOr8vMcHnM/U2zdc9a1McESEjfWAuDf6LZSh20JKV8kNyW+au7JGXkG/EooCjwW7nyCg5NqyfiIFvZDLbGGJrow+0FYXjX/f6WuQy59gFBzLuyQ6yocGjmM7nxECfnK55wiKMcMeMSLCU9pFlQ3lGFOp6DDQzerbV/G17Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Owb9IIk0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Owb9IIk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788434240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3uIweTN+GL3lGO6nJKB5zda8xrKhC7vEbdOiUsM8rw=;
	b=Owb9IIk08uGtbAFPgzfFe1d0LSwVSShlnLFDhCejTaXfBhGxuAQOmQioppUuO6l85h8Bbi
	3x2Vtp43GlbMO5A++qpFPlWGpkMSK+SKcCNF+N+BVX0TzzeCGNpVbyfe3qAN05hZQwKRIt
	fKYpyHXF0K+UD3j26k+CkQmdFSW/394=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-pdZTU2-bOvWCddabah8Fyg-1; Thu,
 03 Sep 2026 07:17:17 -0400
X-MC-Unique: pdZTU2-bOvWCddabah8Fyg-1
X-Mimecast-MFC-AGG-ID: pdZTU2-bOvWCddabah8Fyg_1788434235
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CB711944DF5;
	Thu,  3 Sep 2026 11:17:14 +0000 (UTC)
Received: from griffin (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8C2D18005AD;
	Thu,  3 Sep 2026 11:17:09 +0000 (UTC)
Date: Thu, 3 Sep 2026 13:17:07 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Fourie Zhang <littleddfu@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Aaron Conole <aconole@redhat.com>, Ilya Maximets
 <i.maximets@ovn.org>, dev@openvswitch.org, stable@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, Fourie Zhang
 <fouriezhang@tencent.com>
Subject: Re: [PATCH net v2] net: mpls: clear inner_protocol when the last
 label is popped
Message-ID: <20260903131707.53a58c79@griffin>
In-Reply-To: <20260902092719.2874481-1-fouriezhang@tencent.com>
References: <20260902092719.2874481-1-fouriezhang@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed,  2 Sep 2026 17:27:12 +0800, Fourie Zhang wrote:
> Fixes: 48d2ab609b6b ("net: mpls: Fixups for GSO")
> Cc: stable@vger.kernel.org
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>

Acked-by: Jiri Benc <jbenc@redhat.com>

