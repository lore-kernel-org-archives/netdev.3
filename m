Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3B34404E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693987; cv=none; b=fv0TPSfkZARWBxlEyI0/ZClZUJ2SvsQN5lUmfaMPauPFcfj0PE1PQERB3dzmfuXSxMNtZYgtvkyRYaP37/bXOPA/b3ZgGtM7i2vKZN/3q4duaimjhlOEFNduaxgoi17tiHBxFS+BBGNb0TO+UJIli6H8LUD5vlZf1tkVfajOcgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693987; c=relaxed/simple;
	bh=H+L3QTFFkyCFXwrBvc0mOg6GVJz81+DSixh03RV0aKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxCiZMURTXh1J1XVE0et56iZr5R23O69/KHkTPS/cgjmgkgxP24DaUa/Ux/ke8NpKU7SaACazdk0TlnHQtVKIzX3CXaeIbGHztE0zf2tUXM6f6DTw319jsNiOUpdgfqzTlUT2speJYWjsw0VIz0NgykU6y5GsTyDdb48zy1kVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMtsaBpl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaibKQi6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMtsaBpl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaibKQi6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786693985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBgk91sGaugiFnpdKSnVzGaySlJCzjj+raiMAVYJqa0=;
	b=KMtsaBplfarol0WkJai7Tffqts6cAqP6TjPQ+pm0sHRAHb348oQ6gL2UIgGJntHfYFITlc
	tvMxw5an/s8Yubpm8Oj0NpEafmX8RFVlMl+Q8qF5mw4TyRymmW9RTFdLXrOYWzDdSwkUBy
	tcrP+LfF45xLByNV3qXkvtXJju8eqXY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-zFGxPmNRPk6kByT2lDqclw-1; Fri, 14 Aug 2026 03:52:52 -0400
X-MC-Unique: zFGxPmNRPk6kByT2lDqclw-1
X-Mimecast-MFC-AGG-ID: zFGxPmNRPk6kByT2lDqclw_1786693972
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fecbb553bso619067f8f.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786693972; x=1787298772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBgk91sGaugiFnpdKSnVzGaySlJCzjj+raiMAVYJqa0=;
        b=CaibKQi6Z2Cjpv5z+P01h6ZWOJt/krxFAdig4XJwVq2jxrSVMB0fck7ke4TrXpJHq3
         KE9c0bTsp0+7s8hI3bq4AO7S9kzCquI/V1eej7Th05+xozWGVmKT/VxWQXVmatBWSnf5
         GVjKYPvWB2g/SQhtgIym6+CfAn1W0EkdO4sPktLWtryo4h/sfmmKubiZ+wkPmMfc/17/
         1NlGf1RUFu5ntXPMebygayoqcfsMQnZ1iQYHI9xEvR0BJ/PmPSTV8Bd1F8Z1YQ779PP/
         PmOgSJ+IDy/0VCvoTHdUAlobXDZt2+5bId/IWCIe02v3XJ9csz5tVFDk93aXFsGJU/C9
         dptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693972; x=1787298772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBgk91sGaugiFnpdKSnVzGaySlJCzjj+raiMAVYJqa0=;
        b=lhotvS1iTwXtu2Cy5GVZOjpP+xvWgMkh7a3+dbKTfWh8lcH1TXyKqN27ppnPHz+QT6
         3ueayJt84O3Ion22ByTApgA78/PAMi2ujwjQfU347tZKiG3xCBW46ZWwaEddebg8iCuL
         0cK5qSkDyHFBC/6HI9LVO+XQP8zNy6p8oLH0Q8pSTiSMjoIL25TG4dCMy9XA/qvWXwM5
         a0U5u09gQL/Sh0e8/S0NhzdGXnWfJWIK6yYShsl/uSamPIrmdjoq8sjiCclAWicQyHEP
         j8nE3TA/IRrEV74uxm0pHqlIe3tIjIjIUkgRZm7Sd+1ZdgmcbHI4xGcz1f0MFto74vM7
         VphQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3AFD3Rp0nJL8f4tphMClwRz6uVJENHp+qHK5gfYEghVsVzs7Fqugshv1EqDlQEWzKkSLFV60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+YyslVXoRtaxENKeNJHXMXtkBPJAb86UkrMS7hr3SCLLKqvJ
	cSiwRyN8HDTi7jvSGx8X0GyM4HDJ8zIXZeHkmRbQOVoyhkM0iFXglGDePcob7yJiWFPqd8YJBkf
	SGna/VtwMhlVfRhFfYtrpBUCDhz30EAa5xIczPmJqV+sOnTKb2iixNEOMBg==
X-Gm-Gg: AR+sD11qrA4vfXzYXycyqPzojrKZ63PP4/Bp6KXTUxoxIRPKk+S0CFtlhCqHKbOYi/n
	p6mgdqBNotoinkp6BHUBOEVxaiGD+kp2Pf38oLfag29azudfrQJaRrq7422arLvoMwWY30f/yYR
	uGUOOeT0L3eN3IyqWke4euQyCbaWDmLlIPYYkHWHTI4tmVn27uC4tDnRDi1uTMcqXDvXpoBuFG/
	7huWODlpnqym49lMBDaHpN4eRRMtfz64fA1jcibk7/PM8cS6SG/gSY5UgUngZNujcDWl8OaYjuT
	Lf9QySdiNDfgCVDlL13TO8ZeuRBJSXGYSURSwB77OBwgphCduw4i/6jGXO8+t7YM34+LurcjWTb
	kmrooA5gmJzqqDNTM6Zsm9PTdo//qF8Gm+NXRNEyRgjyqy0hCvAT8
X-Received: by 2002:a05:600c:1da8:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4998798467amr50729635e9.12.1786693971597;
        Fri, 14 Aug 2026 00:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4998798467amr50729125e9.12.1786693971141;
        Fri, 14 Aug 2026 00:52:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d33asm33182265e9.10.2026.08.14.00.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:52:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:52:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Message-ID: <an7JAlFpRVOiC4WQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>

On Fri, Aug 14, 2026 at 03:29:00PM +0800, Jia Jia wrote:
>vhost-vsock leaves the device IOTLB attached when userspace clears
>VIRTIO_F_ACCESS_PLATFORM. It also replaces an existing IOTLB with an
>empty one whenever a later feature update keeps ACCESS_PLATFORM enabled.
>
>Patch 1 adds a common vhost helper that detaches the device IOTLB from
>all virtqueues, clears their metadata caches, drops queued IOTLB miss
>messages, and frees the old table after all virtqueues have released
>their pointers.

In the v3 you mentioned that this could be used also in vhost-net and 
maybe vhost-scsi. Would it be better to include the other patches in 
this series as well, since we're basically fixing the same issues, or 
have they already been merged?

Thanks,
Stefano

>
>Patch 2 uses the helper when vhost-vsock clears ACCESS_PLATFORM. The
>acked_features update remains in the vhost-vsock-specific loop.
>
>Patch 3 avoids replacing an existing IOTLB when ACCESS_PLATFORM remains
>enabled across a feature update.
>
>Changes since v3:
>- move the IOTLB teardown helper from vhost-vsock into common vhost code
>- keep acked_features updates in the backend-specific loop
>- add the common helper as a separate first patch
>
>Jia Jia (3):
>  vhost: add helper to clear device IOTLB
>  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
>  vhost/vsock: keep IOTLB across feature updates
>
> drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
> drivers/vhost/vhost.h |  1 +
> drivers/vhost/vsock.c |  7 ++++++-
> 3 files changed, 31 insertions(+), 1 deletion(-)
>
>-- 
>2.34.1
>

