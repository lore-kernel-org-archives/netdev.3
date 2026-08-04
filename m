Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276532B10D
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814790; cv=none; b=Fhk39SlJm1HOrZzg+eDRfyCz1+A2NOX46Vs+tpl/u3XsAGBiaTf2/HK/gacnQRAWIAv627C52uVAbTRoyEYKeiL2ab6emBq+fgBUenUMH9bnUnJkCHgHQWqjGfs7R6HlvSyDb0ehbx7q8SK6RBl1hsHLAwdveN+x2f+75H1BVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814790; c=relaxed/simple;
	bh=vC4qQclBoV67ud2evHeSbDFkaZmPoEXMBUWK5AoYXEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYPd9pdhIFDb2uxSi7H9fZXzFjRK3o1Oj8QwUNCB+r2U7XLFfVqLL2Kj1b+IBaXBIRIodvfl5B7byN0PTU56s5Fro8N+2Nk/+zff5MDex6Jvx7Nky1SrdkZXcPUz4IvF4Q8H9/78Fzbmawe0RpWMiof/v9dJxR/f6Wwd5n6hgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Juk83/iO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeLwA2vK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Juk83/iO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeLwA2vK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785814788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diYn9AH5DOp5LofRkeGafvYOwV70LwGGTt9FgR+upFQ=;
	b=Juk83/iOdm0tjHtFCgUmf5Klhrj8uE5QeKkrODXz3iqDV1szgft0SGbIgt2KBavmJFPFCP
	1h0RXKJ8783kGOvkIzzRAcma5EDT00isVUvp9m85YGOcK6TOXEnq40XkYL7pi4FGKWzyvy
	jinodFs57F1V/q+Vtjvuhp9/Xr6SDwg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-BFfTmsacM7aSrKMmTK5FVA-1; Mon, 03 Aug 2026 23:39:46 -0400
X-MC-Unique: BFfTmsacM7aSrKMmTK5FVA-1
X-Mimecast-MFC-AGG-ID: BFfTmsacM7aSrKMmTK5FVA_1785814786
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15e82278cbso334494066b.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785814786; x=1786419586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=diYn9AH5DOp5LofRkeGafvYOwV70LwGGTt9FgR+upFQ=;
        b=KeLwA2vK3RZo27HZPVubdSmwRL0xIBz119y5Vq7xH3jZFqXyqktSwargQSQrSlBucx
         uxv79aGqfx+actWpsxMaj0XZ3Yzexl/Lf7ljqnFot2hChf17qqgsX9hwdH1+j1suxxE/
         NhMhEYfFPQhkMgIvHBnZ+AfVQf4WXBMfSCoBlnnIvYdVqTnibHtwsGrxnk/TuQU49z4p
         2XFhAIPATmmsA5PWKwCz/ZSyMZnOv0PDDzt699oQywO59x+A0177013ovKZ2af0iT1Uu
         MWeE09ukGQmq3LGhc7SVtfG3+60c4q2Lrcq7oUXqYh/7i3ctCnRsvdYzoohB0S+iOerf
         /Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785814786; x=1786419586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diYn9AH5DOp5LofRkeGafvYOwV70LwGGTt9FgR+upFQ=;
        b=AydcHhBBpnMlhsw6xrrMFo0Tb99790FyBlllJOLTDUgRITGX8cJEnFKdpeeMGi+B+i
         IRNXcG7Jdlmbx+D7xMOkUuxVrd8DM62D6PvUN+bFqeD5+i3X/lCr26pdH/O1TMfhp7Bu
         vfCbcHOJUc/HPd5+Zvn5g9i/3iLGeKbw3Bd7F37I8foSAO6/V2J5g3bK34pgrpq4OM7s
         38C1WJlqClZ4w6XV2tT6agTcPZVrztjyFAvpYCx6VrWi1eXSgg1FcLSx5BPHUNfp1EiG
         l3GzPfI9Zrh7ekG6Wb02Q/rUkZDIXUXS7+Mt7yqS2SLxsSzeiL7BpA+xBEDWhlzdglom
         FWYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlsfAmpMx49GTosWUdI8WURBUmTwKn0fCGKP/A9xKDenSSjh4bDixpI2mohhCjwdCP5Yv4y48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtz4f3UJP8+7Zfp91p761x0M6bU2NjCXoDXJ2Hs0bvU2fYAV9o
	xtXNeG5U+n7SF5h3aeu8j8N9yhMMs+BAcdfrH9VFfmn+1GTMCLz8v09cTnv2tGtMj22hlvvrpIJ
	X5g+iaOcsXF2mgDRICpdNyimWOGHikKwfdh5fhf3LsdFvmBezzCkyzE8D3Q==
X-Gm-Gg: AR+sD12nXVrtDcMQw3d4G8LoeKpl0pirv60kKnKF6Al9XGRrowfLB51XOWx+T/+i0e1
	24T2pBlr1nvrnksbwdr1wRTCTXdzmkRlPngO59/ujASlneM24CPvQW7CB6B1KwF4eKtVzcn4nwU
	KytL4Al2DnGlxsVz8cuaoceKKA7kyvHzrshNXLJf4JRmOLE9brq7rOpAmZNy4vSPbudA2Pew9ce
	67tqxXYTOYmcaKn7jVB7h/a/r7G/XjwkjjJaBr/WF7jix/BWEGflzw3YTRR8EWtmKYbcuQzI/iM
	xFFXUROku48ino8IZsI9ZQVkTEq04/EoS/YfBKKSSpNl+uSjvkCorc5An5E1lJp3z6lN
X-Received: by 2002:a17:907:1c22:b0:c15:d4f8:dade with SMTP id a640c23a62f3a-c1fe7eebb0amr1148197066b.2.1785814785650;
        Mon, 03 Aug 2026 20:39:45 -0700 (PDT)
X-Received: by 2002:a17:907:1c22:b0:c15:d4f8:dade with SMTP id a640c23a62f3a-c1fe7eebb0amr1148193466b.2.1785814785204;
        Mon, 03 Aug 2026 20:39:45 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c93a87sm631061866b.18.2026.08.03.20.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:39:43 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:39:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Jia Jia <physicalmtea@gmail.com>, jasowangio@gmail.com,
	pbonzoni@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
Message-ID: <20260803233841-mutt-send-email-mst@kernel.org>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
 <20260723105451.1563439-1-physicalmtea@gmail.com>
 <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>

On Mon, Aug 03, 2026 at 07:02:43PM -0500, Mike Christie wrote:
> On 7/23/26 5:54 AM, Jia Jia wrote:
> > The owner must keep the old mappings valid until the ioctl returns.
> > Remapping or dropping them from another userspace thread before then is
> > outside the lifetime assumption of this transition barrier.
> 
> Ok I get it now. For some reason I thought that was valid.
> 
> For the patch we don't want to flush if vhost_dev_ioctl fails
> and there's no reason to flush for operations like
> VHOST_GET_FORK_FROM_OWNER or VHOST_SET_OWNER.
> 
> Could vhost_dev_ioctl return when a flush is needed?

I agree but also this is consistent with all other vhost
devices.

So I'm taking v2 of this, and we can iterate to optimize
all devices with patches on top.

-- 
MST

