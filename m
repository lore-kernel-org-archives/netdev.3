Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36143E3DBE
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711673; cv=none; b=cYDaK03dxZP1uK2mrEPNok5vJVGsatcR5slTHkWPfFnNtjQDCmCutrs7IkZ6QyAzSnCIyeNCzKppex/sYbKHgoxDagmCYV94U52zo4yNNnsqoXaoCdDcT7l4uRVpZ1ZE/NT4NJHFPP/1Q7c5fMkByTMuAiDvROzNOQCIGbYmFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711673; c=relaxed/simple;
	bh=sHMU9orKt+3dFz7svwzy6sHxokwx9yHspoPZi9pCSqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVPcp6nbkYCKZH4r6yznCBih1kt31TroFfCT7oXqsNmhmM17640PIRceone+rA/aoFpfc4vctMyqMwscO7H6TUHPWDH+vIhlwXTmH5WbOJKD8rFD3UWo/cupcN5TlidHOhWypCBjuWy3c3SOZIusKu4nEjmUttOX0pmhyE/mkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWoqrEje; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWPNkyaD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWoqrEje";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWPNkyaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784711670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COubnejOb/3v47cpwE+v+WjurVSix4Lp7TgAJigf9YY=;
	b=OWoqrEjezHL3Tj8vluIiW5nbZ2c4syPaDnUMa/welSn2ixzN3Lhm84b8jtZUBfjyP1O93T
	IrsV2oyL7jGSCbANWMIyuT0g+wQCj4pP0wsT3p0Dwx0ByujfHtYP5IRAPG6ltyBcgyOfEz
	pt+7jhgzjXuGih2f3giBIrEfmzBDahA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-nmlXUYm1NKiWz4VB9Asx5A-1; Wed, 22 Jul 2026 05:14:28 -0400
X-MC-Unique: nmlXUYm1NKiWz4VB9Asx5A-1
X-Mimecast-MFC-AGG-ID: nmlXUYm1NKiWz4VB9Asx5A_1784711667
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-474170b59dfso7419403f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784711667; x=1785316467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COubnejOb/3v47cpwE+v+WjurVSix4Lp7TgAJigf9YY=;
        b=hWPNkyaDEFJEKapwJ9fmMDKRMqZvCAauA7pN2YDBaiQccPZSS587ZAX3WOkkvWRKNl
         FcgCGdcrOvp0+h4dyM3vhPPV8lkr2Ybd4SnxfP2EQIEde/fvM5GnjCzeIIkD8rhjUTHe
         kWZcyn10bSU5XSdU37Ozp8EfeSIL6s4N3zAA0Jrj1gJ3ji/3e6uRQEcCo6i9O/luCRsE
         loCJ6FpMHTXza/4MaZIja4eJcJUHJOkypf3F4OxHznF6VnoS82phR1RHhFuspmtK+Wq7
         WKWACUOkgCamqUTCNmi5P3nmjs4h+Ftgt1LlrHEGvJMSWBDozaeILE5LwIAwSbcQsMjk
         JX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711667; x=1785316467;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COubnejOb/3v47cpwE+v+WjurVSix4Lp7TgAJigf9YY=;
        b=GPcPMUp+nqcc2IvSxhUabfsXdXJTjXdz9tGJLjef+Dm92xmN20Is448s31HsH1M7iZ
         7iy7DLIx+fZCeOgn85i2F9/nYkSC5O33stxZnt3nGSV89uwTHA994Rp+tSwoHTlqT3Vb
         e3fiQgIjVA7fBpPLkN2lrYgnlzMKATnEcVCsjINBsy5gY1cET56LFBTpUQcI5ojC22cP
         SVqWxhCM0iUAfcLptHHgYeEsDQjxu7QUW8rrKunas4gDYB8J/9ILz3jkEtcMr7EpKqwc
         SBa+ZlMqHg7Foeh9L18Edx/UrlX2JR7uhZBtBJtaKYsh95NMgIPLXJDJBADVcALTODt4
         vKWQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQgf6CaxdSrif1oILAJi3d8LvGtt2YtxNS1P8Ivo0ih1ympFMTaoisLeE7X0UPHowD7IBszM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp24VHHdj/t3bJEN1morOwl9mPTgAqKy3A2P17fPBlygl7oyMG
	o8PG+Sdib38HeJBupTqfEi/h7AT9W2LCASRcWixcCl7dqZcLjQpSuowIteiQ6lOG5UOh+ZG0gl2
	j65/rK1o+pZPYCWY23xB9X4gdnV+R/8U13qx7VyLF2GbOIFZtUx3zbNyoMA==
X-Gm-Gg: AR+sD10mZyT/PXH/TEvDxL2WtR2dpMRfrKC4G//QJa5b7Unif+0MaGXOyxukSt2re8s
	aVL3uhxDlbppjtPTT2rfuLAepr0r8+otNqt7YyW9VzIiJScVk3zMunlQuEkaFCj1he/FG9z+g2K
	RD0mqpcWOxA1Wg3EiWCbAYuE/x7KSHmc0SRKRolXeQeSC8dnxg95gLSCnbubgNZNBBMhwt6gFZA
	o+C+rXXDOfl6dp3SR1ogT2ej3qVWtsraKxaBg0wUCSmRJToDN0yYpqNI082MbVZFREuSerlewP0
	v03mHxfl+PeeG8jTclAIbEc2rcamr0+2egrtcGzOK7C9q9VhsUT2bJ8Ih+OgMHHmzy3MHfOQkfF
	VurJR9vTAomfrBzEZYo070IwGAyWoPUtWmSASJvw+HK4SzaIEuw==
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr15702380f8f.3.1784711667421;
        Wed, 22 Jul 2026 02:14:27 -0700 (PDT)
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr15702319f8f.3.1784711666793;
        Wed, 22 Jul 2026 02:14:26 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f8635c8d7sm3212686f8f.21.2026.07.22.02.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:14:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:14:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 2/5] vhost/vsock: suppress EHOSTUNREACH fast-fail
 during CPR pause
Message-ID: <amCJ4x8EGtHjVRM7@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-3-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:38PM +0300, Andrey Drobyshev wrote:
>Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
>immediately when guest isn't ready") added a fast-fail in
>vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
>until the destination calls SET_RUNNING(1).  The fast-fail condition checks
>whether device's backends are dropped, and if they're, the guest is
>considered to be not ready.
>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.
>
>Add an 'ever_started' flag which is set once in vhost_vsock_start() and is
>never cleared.  The behaviour changes to:
>
>  * When device was never started -> flag is unset -> no listener can
>    exist yet -> fast-fail;
>  * Once the device starts -> flag is set -> we don't fast-fail ->
>    we queue and preserve during any later stop / CPR pause.
>
>The VHOST_RESET_OWNER ioctl is implemented in a following patch, and
>without RESET_OWNER the problem we fix here isn't manifesting - thus
>this patch is a preparation to support RESET_OWNER.
>
>Important caveat: after the first start, a connect during any stopped
>window is queued instead of fast-failed.  That was the behaviour before
>the patch bb26ed5f3a8b, and we're restoring it now.  However we still
>keep the behaviour originally intended by that commit (i.e. fast-fail if
>there's no real listener yet) while fixing the CPR path.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

