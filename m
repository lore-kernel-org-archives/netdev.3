Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629032;
	b=ZeuPPPXwCj+Io6qjK/BEyWDBy9JtCizvadPqEnGEBqKmf+cG4ELDxcHvzwh9xu7SbPcd
	 /cdY5cYinA+PwqaZqQsl10u7TxTS7vVi0OeXz/o4N++WQA4Yr8ohK4uWNZFP+uhMZ/UJf
	 48MimioBSpa8ugaJyC05IJHAkaReKzMqSw0RcASwa2Qmgxj7aRb1Ckyng56lx8w2HyTQZ
	 WhSBw7WjJXxEenp2bu6bjERv9WELSU/riIngNCkGUBnJosWKIGfuZT14y0Wx42zdAnEVb
	 Q9uXIjrVFZyx/cGu4hU/NDKYzFQuTuuxYKxuqG7TDnNnAtnm58lIhSD6k6pe6cTLJjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629032;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=QvbUFZWu8pYQBg/xVe0XKv0sbdjk8adIbsMJZdbK3Ms=;
	b=41A0we+Xe5slU5+yyVK3iyA1kHYsCDGMow20vyZkhZrwik0AviRUpgIb4ENGnh1rWUco
	 OfoGOy3vHtXzZ7kaZvOJBrLwfWeejcfWTUNtSvG7TXGvqbcnB4RqUDfGJg6U6UXT6wdNI
	 eZfaprb6XXiNCjBkJPKi/a9GrumMJMBURypPJYISTZcIfk05sD5KRy1sksIBYZqbeLY5V
	 e2W/XWHanr3QCPa+2eGLsIL6bodTYDQ/XMjkkw3Pp3IvHsc79/i1dwAxoPiA/Juz2WFak
	 PyostCxMKPuFmv9KFFS/KwCEiavCyuUXxecA4q1R4hFUe+qnY/lcGN3A8Q+JVIjVaTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fenli8hp;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D5606A33B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 681D5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fenli8hp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793629030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvbUFZWu8pYQBg/xVe0XKv0sbdjk8adIbsMJZdbK3Ms=;
	b=Fenli8hpgLmAfubKgyYwzjtMM+RFXlTdPl3Fg3Rp8AfK5n84I4eAEr/KY5thJJ2k3Yhqhd
	7HwSUAUoVcYdpeLihl+J4Bc4HnkUmm8ksef2wB/pIib9ST/Lkl0MmbtZVVuXDO95j6JGJr
	qY9K+Tb0wzzNl2OTRC/xj1dHEbCCrQQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-UDbS-RyhMrOS0-zEUYGx_Q-1; Mon,
 02 Nov 2026 09:17:08 -0500
X-MC-Unique: UDbS-RyhMrOS0-zEUYGx_Q-1
X-Mimecast-MFC-AGG-ID: UDbS-RyhMrOS0-zEUYGx_Q_1793629028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E30751956073
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:17:07 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 796C31956087
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:17:07 +0000 (UTC)
Message-ID: <45d1b182-8374-4144-ba4c-e68bf0187be1@redhat.com>
Date: Mon, 2 Nov 2026 15:17:06 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] devlink: param: do not dereference a
 missing param item
To: netdev@vger.kernel.org
References: <20261102131505.611343-1-xiaolinkui@126.com>
 <20261102131505.611343-2-xiaolinkui@126.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261102131505.611343-2-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/2/26 14:15, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> devl_param_value_changed() looks the param item up by id and only warns
> when the lookup fails. devlink_param_notify() is called with the result
> regardless, and devlink_nl_param_fill() dereferences param_item->param
> in its very first statement, so a driver that passes a param_id which is
> not registered on this instance turns the warning into a NULL pointer
> dereference.
> 
> Every other user of devlink_param_find_by_id() handles the NULL result:
> devlink_param_unregister() and devl_param_driverinit_value_set() return
> right after the same warning, devl_param_driverinit_value_get() returns
> -EINVAL. Do the same here so that a bogus param_id costs a warning
> instead of an oops.
> 
> Fixes: ea601e170988 ("devlink: Add devlink notifications support for params")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/
> Link: https://lore.kernel.org/r/20261030033332.3685172-2-xiaolinkui@126.com
> ---
> v2: reposted against net-next at Simon's suggestion; no code change.
Reviewed-by: Ivan Vecera <ivecera@redhat.com>

