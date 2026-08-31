Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494F44CAE4
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186649; cv=none; b=HpK/2FErBrWPtxBZ120zHa5WaQ7xpniTEVK4u71YN9xkB+ACfOrBwP4KdYIy9Qvz1B8o4CidD5NEOVvZl7sPHwR9n1mPfzA8pYjwMPo22syQuRK+roJzJ37VQKDJlq6LSl0KOOn7wYgrzWjw4NI8q6P6ZMiMVMAyV8V/6LhfqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186649; c=relaxed/simple;
	bh=u3dgwxIw+0DmelYeYTKjtyYkNOzEMEXvs0AujSPDSFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTs8mHDZOCZpfGiFk7jl7/RFwJGT6i3rKRen85JmtTTLb6mDNFXDDAxqnE3aAjyZtctUbxvzmG/vzF4PxKhLeR3lUwL1MIuVG+kR+Df8+1a0EJuLmtpb7M4sC7Y74iADSPPsts7qcdbvlXlaO2EcHw6SBuZXt3E7DGHuCxTT/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ack07PSA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ack07PSA"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52fbb20c30eso35692181cf.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1788186647; x=1788791447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxM2GgazObY4pny7CjicJsoYJzAciykbqLiuPBKukrM=;
        b=ack07PSA6cyT0+9KaocQoUzn8v9nzOs74NFCUwGvt9C3wAykR19h2NZayTngob5dhO
         jpYJnY8jlAbsU3qRvZe/aK4iQEA04cjvlMvYradenxGsFs710aJdxehTJeWj9ZmS5+y4
         Mx+MvUCeKa932hM1i/DoO0tYcCtj9OVHnPeuLlXnxuHs6Q1NHPPuR4CHRH5Tyev6LJ2x
         OMKhl/e+e0hXVhBfJF+NaV0ltmIVBj6F/MtJqIGXzGLpzxjzbh8IAvmWjODAoRqloTak
         9k8NgSyCa8A6iTVf1RlCoByP9uiKBbhEEQqP5vg3YRQAlb2WHgJ1ok08wjHe9yD/lD/D
         AGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788186647; x=1788791447;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxM2GgazObY4pny7CjicJsoYJzAciykbqLiuPBKukrM=;
        b=R07gl1sJNa9YNYI+lOovYKJdyBYbcRqchIkhSB6b+KfTOsqX0GLn5sZAQhtO+E5IPN
         Xc6mARWBa21QD/lpv4ZdeBbGLDP7KkKyFgkG2O35xZsGJZSBQM/XdZGHmNYOcTeQlgCL
         xba0LOAe7ABzSYOtz1kcJhKqMoWQ8bujila07anod2Ne5j3Soqsx7RnsSWwGql0nTXcS
         Lq0fsX56vNYfC3ehguDo1zxN0UbSesxNYJy+4B+EIHOJ5N51pTD6Mrm2dqZaIjItL5jy
         vVz0GuQB80HJQ9mH8sIKXa09WD3gzTs6XseOwCW7EFPLAwVeS3rNmw3/PKgtUUTG7y3p
         oLjg==
X-Forwarded-Encrypted: i=1; AHgh+Rrxqpuch5KsFNhwPgUF1JlnLPo69ORqGFGaEFpbF8nr5XhuD2PQ4PNxi0X/rs7ysFeS/RLGH/A=@vger.kernel.org
X-Gm-Message-State: AFuF++m7UF58JpEXzSx+REOFUSoYDCbzICTvaK4k7Qw9hDY1UtM4HSgV
	PYArDhXYGOVIyqpzWlKPkKrjYL0QZZtT9M9Ybw4JGbvVK2pw9TAAM0Q5Hr0dawShrg==
X-Gm-Gg: AR+sD122knbT+yXiYj+AUYTiiQjU31/bkaW6nisfM4k9aRubbk4eLeqTgrVA/5IM7ir
	ysQK2GOhKXlNv57nMX1fOS71lp9lCQ9eogRDni7UvVkGzrKgMKXLBZ0OsT+brQcCFrSDRsZeBJS
	x9Q60EACZjTSOa3f2VH4ETOc8U2OsjOHN/xUMEKc3WQp2vDbhbVKR9OZZn6euUmtQHD9ZuZYqpt
	EFf2kAZBVQGWY2teMjbolHfJaKALAfSUN+iOPh4TuGFHHCpEPMOfu5wPyRSx7huxUE+Y1USJBEW
	IFOLqYqFAjDUvZY2vX1Pc/vanmCchFmVp2/9pVbYq+mMlHRyA5DuSxx/78Gg7g504oXN3O3ijEk
	e+t0nITt4r8DKzOlDP5d+hiJyobUjADjKWeeBiE5CVMpNJG1xbk0sIfsePTPj0lIE+urW1gDKGs
	6avE/9VyWD2Dhs1cQjWPg61tQ8RwnGtn3YXZNozRCxGuyehRDiXa8SKjOFwwDmiqGUd7SSSAoj8
	LbjGEQ8SJJlfTotvQ==
X-Received: by 2002:a05:622a:2598:b0:51c:1532:ae93 with SMTP id d75a77b69052e-53021cb99c7mr18496681cf.26.1788186646408;
        Mon, 31 Aug 2026 07:30:46 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4515130sm85355856d6.39.2026.08.31.07.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:30:45 -0700 (PDT)
Date: Mon, 31 Aug 2026 10:30:43 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Chas Williams <3chas3@gmail.com>,
	Duncan Sands <duncan.sands@free.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	accessrunner-general@lists.sourceforge.net,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] USB: usbfs: replace __get_free_page() with kmalloc()
Message-ID: <8cbe558e-7f53-4ce4-be8e-52fdba9105d4@rowland.harvard.edu>
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
 <20260830-usb-v1-1-aa349c302246@kernel.org>
 <ea165ff8-cda2-4fed-9354-1d14ac2d87ca@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea165ff8-cda2-4fed-9354-1d14ac2d87ca@suse.com>

On Mon, Aug 31, 2026 at 03:27:07PM +0200, Oliver Neukum wrote:
> On 30.08.26 10:10, Mike Rapoport (Microsoft) wrote:
> > do_proc_control() allocates a temporary buffer for the data stage of a
> > control transfer issued from userspace.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> 
> You are breaking the calculation. A page has a size of exactly
> PAGE_SIZE. A kmalloced object of PAGE_SIZE is larger. That is
> a bad idea.

By "the calculation", are you referring to the 
usbfs_increase_memory_usage() call in do_proc_control()?

The overhead in kmalloc allocations doesn't really matter for this 
purpose -- it can be considered a rounding error.  Besides, we don't 
know how big the overhead is, so we can't account for it.  You can see 
that in the same call, we don't try to account for the overhead involved 
in usb_alloc_urb() or kmalloc_obj() either.

I'd say there's nothing wrong with this patch.

Alan Stern
