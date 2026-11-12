Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479623;
	b=xBW+RzKQEe1nfwtYfHJJmpim0dqv8XXZmyib4eyW2apevYYL0o0IDUSi2wqXG3UN9SCW
	 tbDa92CO2zlHtOH0HJ9tU2qKBbDgtsSH32fI17optSI4DNgOLX+19nH18UPiY4pROPvyC
	 IgRvP+FOX/5RCbSizDfxLpkAGfeW1lpyZNQ/dTrPekny/niXqDunFdmPJLSL/csQuwVHI
	 hN9L4fncO2u35PiBIMyOzFPvEOX7Pggxz3//6jCnFzhZGTeIG4hepfU5auFQehENdjZzt
	 V5/ZuOPGcS7Y7NolYUFwUQoJoiCUd7j0QLCE1feuz7MCLBjst18EV8vY+Dwcqe4zbBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479623;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=rbpDRtvLispEaOOAEmO0b3GpRQQvbfSOyhL5a902KuA=;
	b=OS7Kun7CYkfyrxZbioEd8O0ASEywuYvdi5bezUyo1CLHcdezi+mS0oNFbwwq9h+s3SFb
	 W4zykaqOl5NX467m2fLBVDbJj58G7o6FmGa1qxBlagd/4O0Cmdy439ltM0mj6Fk0+f/vg
	 0JE9/lMHVLe3q6R+Cpvv/sQvhHm6pIH1lip8PPXpYJZYOdKMHAvJhIIg6fQ3Z+kjV+pg4
	 cfN6KpCqmW31dFrT4rA11v1q9PLhIEl4U6l3IgRvqmKP09igDM9oyhjtfBrcluF0vpm86
	 6Me2gy/LYjsIPSRWCu2r6H9UBgTctucr9wT2ksIS2Kd4n/PuMmElXLdMGHZDhUGtQrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FItSruet;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01501606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01501606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FItSruet
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794479622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbpDRtvLispEaOOAEmO0b3GpRQQvbfSOyhL5a902KuA=;
	b=FItSruetWsn8WCHhJUlLI103QKp/Gac7iDkAjNDULgAN7rwjgnVHvZj+mSuDR8THGVsb7s
	chvkljXuSLqhaV2p+zpYNQyPOcT/uf8MujYh/feLDgkPqhhAbv0v1CCRZGJ9AkOKCv7SqH
	qGvr43+zIQUs2iEv+PPep5CrNbXJ20w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-b0Vy4GskNz-5COo0zZuYaQ-1; Thu,
 12 Nov 2026 05:33:38 -0500
X-MC-Unique: b0Vy4GskNz-5COo0zZuYaQ-1
X-Mimecast-MFC-AGG-ID: b0Vy4GskNz-5COo0zZuYaQ_1794479616
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 970B71954223;
	Thu, 12 Nov 2026 10:33:36 +0000 (UTC)
Received: from jbenc-thinkpadp1gen4i.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BA061800543;
	Thu, 12 Nov 2026 10:33:34 +0000 (UTC)
Date: Thu, 12 Nov 2026 11:33:32 +0100
From: Jiri Benc <jbenc@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 1/2] nsh: limit recursion in nsh_gso_segment()
Message-ID: <20261112113332.157fc4fe@jbenc-thinkpadp1gen4i.rmtcz.csb>
In-Reply-To: <20261112102001.3744643-2-edumazet@kernel.org>
References: <20261112102001.3744643-1-edumazet@kernel.org>
	<20261112102001.3744643-2-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, 12 Nov 2026 11:20:00 +0100, Eric Dumazet wrote:
> Use gso_recursion_inc_test(), added in commit 006c8b834aed ("net: gso:
> limit recursive IP-in-IP segmentation"), with the same limit as IPv4
> and IPv6. The counter is shared with them: a packet with four NSH
> headers in front of an IPv4 header is still segmented, one more NSH
> header and it is dropped.
> 
> The NSH -> ETH_P_TEB -> NSH route is covered as well, as each round
> goes through nsh_gso_segment().
> 
> Fixes: c411ed854584 ("nsh: add GSO support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179443691180.2199510.148246238688217560@kernel.org/
> Cc: Jiri Benc <jbenc@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Jiri Benc <jbenc@redhat.com>

Thanks for the fix!

 Jiri

