Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993164CDDE1
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659613; cv=none; b=XBxEEp0u4ESoZ5vBV6F+fUW/KGX0Pn8Y2yNqR1/gmaXsyvCRimcDogfdqErAmq4hHZrVnCnz0icjK3c/kPGP5GCQlWsweLEcFGy7oMxHuSLifyKu7DwJbh21VWPRY+DM1vKqc7rqku0I8GPnpEbeNuzUDPvuvZYAt4y3JwDAveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659613; c=relaxed/simple;
	bh=ZEPRZWQSbrRLK6spoQmF7XlsJWpr55fNU8xc6W79Ubc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVXEpIusaWTuR3leIQKsw4fit8Zc33H2pyOe5oyOfIihSQtxL5SVUpu7M6mKtCAFvrE78Yi1n8AWc7umUqmbsWEO6MapAyO/Oe581SJOVvlJs8s0qc/mGJ+jp/uhRo41+7etQEM0vd04VpMZL41RGIDdEjnh12hX+Vze+xvBZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1Z7TWC2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMahKYlr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1Z7TWC2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMahKYlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789659597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksHKsD+rPQygiKBYrLWLevL1zmQIyZm3/sEyFnk8qqU=;
	b=E1Z7TWC2wbaPU8BywJLek7nEPK/uL3+2kCsZ/xJolYQC/tDTJgHGO8Qv5st6I4drPtMv5Y
	I25bndemQogU9YPiICcl3FwqxknyQHSy4PefE9uz2j0JmDOcy85P7sk+FDfWz3EhRPM76f
	h6RDIcuVAldwypiufidLLj5tR54wb20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-sFLHX6mvOjeXhbXbtjFVLQ-1; Thu, 17 Sep 2026 11:39:56 -0400
X-MC-Unique: sFLHX6mvOjeXhbXbtjFVLQ-1
X-Mimecast-MFC-AGG-ID: sFLHX6mvOjeXhbXbtjFVLQ_1789659595
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e735659b7so7917705e9.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789659595; x=1790264395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ksHKsD+rPQygiKBYrLWLevL1zmQIyZm3/sEyFnk8qqU=;
        b=WMahKYlr8SHBNP9db6ucA3iSYIUTZ4J4k1H0JUESmdhX8B8hYBwYp7sFxgG+Y9hW7q
         g0TFR5wwYNP3Xj8EOPljrdx662E4aFX4Wed23IKjfm1Sj59HprszncIuvdii9eILKHsp
         FIT7PlS7yI8aRvUsJt3nF5SpBG8smY1E7TvchLOazrsOZiqT+plwA2dUsx3PbpISsDY7
         ULUg998+mA38mas80VN/BUBJ8JOPDaY1+Af2whpv5BH3/5mZTQM29WOquyFqrmJZcC0s
         RvIayahvrCQBGVG8RV92Cok1EHt7KSXdZzFTC7SXfVqTpc4GDWJXtIXfpml6idvd6vS/
         ouCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659595; x=1790264395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksHKsD+rPQygiKBYrLWLevL1zmQIyZm3/sEyFnk8qqU=;
        b=fm3Ag56U6DtrtCdnjMUwfWPdDX2VSKZeZVnLR+ldcdIhYcUN6kyDMj+m6Du31PWFBm
         d1ziDsz2anpbaa5ue3lYI4G/X1Mxv+4hgiKfm67prxpj0tAnouSGgKj3DmTHQlRHYTJz
         EsWSzNOokhcpt+LUIhWGR81E3MNjMNZc6Yy0y2ZKw9vCA6ONE9A3F+Pq+90sxY2Q5iq7
         0iaWOPbC4uy7A2J1oKJ36SNKg3WV0eoWkDga8l1KVxnVY2qqcRNnAlrtA7+mMoP2FTZP
         2Rd6BLyfKax7ewzxiJvkbFon/sPiL1EXX4812zogsFBjEsjr8P4qx40Pfa6saqPIvcwP
         LjdA==
X-Forwarded-Encrypted: i=1; AKwUvBx7To2yS3W9+TDElBEJe8qVM73U74EDitwOxUWpMALbj7KUb6QtwCBL9sPnuUGKo0bqlybhd5w=@vger.kernel.org
X-Gm-Message-State: AFuF++kDqpOkfrnDCkQX6gaVAvTFjItGaukn3F6xvTVKR5V5qqrxviid
	rZwXwzUT6vq5r+ZAHzQvUdGfcrmaLovZNXDnqfhNTZjxOkutH+bk+gW5gqOlQM6T5KWc/Ls5iMd
	ruCRLbQFSGOgDNmVYhMgdRzqjvGXaRUfphaxXHB/Ze/i8LqWqSyqvykcIMQ==
X-Gm-Gg: AYBFou0zOYmUi6VgTiqyDZs6Hnjo2SlWVnO/22AenJea3Gu7rulFhEFsqz2RiSsv6oA
	VwNV8flZZ9UxG60+51UHQhS3zVWjg9SMYcTIClg4WFAwI1svgpTHt/lZFC4GrNuGPtt22bFyuan
	PTMG0HEdLJ/TVUiHWpF18pOL8gtk9QoWdctVdiV61PbwM5pLygCykGkY5qFmMpQV0QizukrxdeT
	boxoZNb83mjQogdDIqsUuSngX0pWZcFqDXZbTNfh/PRo0SvPeLjco55RzPywI5RQ/X6fjIKeegM
	g1mQoGPlfREyKzXZGOb6CUD1I4K2d2kSdyUrRGIwpartXOIWKYFxef7bjS0ywm9/+KVezK9o84m
	oZ8rgN+5cT+Nman5KFIWNfl4=
X-Received: by 2002:a05:600c:4e86:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49eb72f3d08mr88668535e9.10.1789659595170;
        Thu, 17 Sep 2026 08:39:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4e86:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49eb72f3d08mr88668225e9.10.1789659594734;
        Thu, 17 Sep 2026 08:39:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf342a0sm16364931f8f.24.2026.09.17.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:39:53 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:39:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER
 and CPR migration
Message-ID: <20260917113941-mutt-send-email-mst@kernel.org>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260730194858-mutt-send-email-mst@kernel.org>
 <f8646e25-7e81-4f19-aecc-a040caac1103@virtuozzo.com>
 <ea805767-9e3f-455a-a4d6-828063aaf2f4@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea805767-9e3f-455a-a4d6-828063aaf2f4@virtuozzo.com>

On Mon, Sep 14, 2026 at 12:09:35PM +0300, Andrey Drobyshev wrote:
> On 7/31/26 11:31 AM, Andrey Drobyshev wrote:
> > On 7/31/26 2:49 AM, Michael S. Tsirkin wrote:
> >> On Fri, Jul 24, 2026 at 02:45:37PM +0300, Andrey Drobyshev wrote:
> >>> v5 -> v6:
> >>>
> >>>   * Patch 4:
> >>>     - make sync+flush conditional by adding a bool 'sync' param to the
> >>>       chain, as suggested by Michael:
> >>>         vhost_dev_reset_owner()
> >>>           vhost_dev_cleanup()
> >>>             vhost_workers_free()
> >>>
> >>>     - reword commit message and comment;
> >>>     - drop Fixes;
> >>>
> >>>   * Patch 5:
> >>>     - add 'sync' param to vhost_dev_reset_owner() call.
> >>>
> >>> v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com
> >>
> >> does not apply for me is this for net next?
> >> in that case
> >>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>
> > 
> > The series is based on tag v7.2-rc1.  However I think the reason it
> > doesn't apply is you already have v5 of this series queued in
> > mst/linux-next, commits ddb0918e36c4^..ad5b642c84d0, with your S-o-b.
> > 
> > So you might roll it back and take v6 instead (only commits 4 and 5
> > differ), or leave v5 in the tree, or I can send you v5->v6 difference
> > separately.  Whichever you prefer.
> 
> Friendly ping.
> 
> I noticed that these patches were queued in your linux-next tree, but
> got dropped afterwards and never made it to your last PR (used to be
> ddb0918e36c4^..ad5b642c84d0).  To be clear: the series targets your
> vhost tree, not net-next tree.  Since it applies cleanly on your current
> vhost branch - please let me know if it's ready or there's smth else
> that should be fixed.
> 
> Thanks,
> Andrey

I'll put this in next, thanks!

