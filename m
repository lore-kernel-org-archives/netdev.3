Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3F1DFFB
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753286; cv=none; b=m1ZhXBaxCIKMlH2zO3AWihDSc6EY1yJ5Sfj5JGJ9i95w7mw9F/6E/kIrEeD2pZJNSBU9cTOkdkGZZxlhYX0ioREuTlmLqR9+Wq7qQSy461SPXtaPNnj22gH9uB2ctZErmD5p48UKxCT8kcDdYrx5GwPZYoqghBipsjeacAZjqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753286; c=relaxed/simple;
	bh=WGhUEMZJwtV+YhtkO9VJacDbNj8JfZs3tY3cSu/1nwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Et2XMRf2aHEPOaf0ZsgSDmOiSWK5Vx7tGioIDVI2W+8dslwkIpejdaoCB60DXDo32Bqy1jdWbUb7lMcGqazPBrsVwBUe2/JCcBZW/G/0SIibIRVO7txKHK3k/tAgurq+C78XjW1HBpbl+BbOJrLSqA5hLyHkkQWeiZ9Okd4InDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vqfgfwmx; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vqfgfwmx"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954fe32d6eso8377425e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785753283; x=1786358083; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrGZH1Bic7OrH5NVQ3GPF6/SmqVayjDt/OQQQF3cjOM=;
        b=Vqfgfwmx4jy0deU2Q2CwMJVOyASPYvwgRD8xQqJvrn0j/VJSMbvZ/4BbtOHR4ITDYv
         DQNe1F+kn0L0P0a0ur3XfjT+wWkzUlpomt+jGIZzt5Tvxx5qo189hCIcOLCiMFowRSEv
         rMlE6TkLfYtBQxx37JUa0TBYQj7+/LUF2+/Br4j0ucYelRtCojorVXHGuEH2VPfwQ7kL
         9ixIqkWbCFmqIJhyzv+jWmocPYMcIwcB8hxfqzm7v9AE7qhfGXbkRou3biugXDeX7Nn0
         xChmowJJuxJwEDlYcEVMk2P4Ja4++mkSzWU8K8HbXmt/ogaEjeVU+cw6Gtz5Xsy/RbTj
         NY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785753283; x=1786358083;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nrGZH1Bic7OrH5NVQ3GPF6/SmqVayjDt/OQQQF3cjOM=;
        b=GpffT83scGYdCLEfcSEHts3g+LJhJYPXCph/NsgFDu6aRfAroVo5RHAfx4jIGX8iEy
         TjFV/ROvcbZvdlR7J309dv4P+Tg4phKVjo+jAsXAc76tOlw2n8cXFUE1rIRPbT+txrbL
         AOy+IG4W9JEPPh9DD370XHnbSZ2m7EcBsJ7oWW+kRK6IeD05SioaPmwJjjUskLyaSjB+
         gpQTTiu+Wj2WukK+l2UH1a2PG3MerfPUWwM4e7KdTjDWEngGVWph4udh2eV/B4D7rZKB
         zsudvh46PCKAiqbsIeQY/D/c4kPwqBWa0WEoLnq8fUsAoP3pkcyaUdE8JLnz5e+kPLk/
         VG5A==
X-Forwarded-Encrypted: i=1; AHgh+RrHVBhdTtNYrP22rnUkhH++qlAQ4QxkjyGAnJbEcXH6Nu+UUBDvInCuv347RoX647zYri0Yd1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTer9ymawSxCIuT+gayFPjAn6FvE4EuvwbY3tb8u963iDuM1XA
	ndn5idviPykLwTl93oIMiRhquI2ELRKIqNisPRUESYIimMa0dKyHRcUYkKXxI9aIPdqnG1QXy2o
	ixDpmllHwq/P0dDW9dw==
X-Received: from wmaq1.prod.google.com ([2002:a05:600c:6c81:b0:493:ed72:8dad])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6092:b0:497:ff28:6deb with SMTP id 5b1f17b1804b1-4980c64b8bfmr238017025e9.11.1785753282903;
 Mon, 03 Aug 2026 03:34:42 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:34:42 +0000
In-Reply-To: <20260802215459.2769283-5-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-5-surenb@google.com>
Message-ID: <anBuwuiOBKXJwnhT@google.com>
Subject: Re: [PATCH v3 4/5] binder: Remove mmap_lock fallback
From: Alice Ryhl <aliceryhl@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 02, 2026 at 02:54:58PM -0700, Suren Baghdasaryan wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Previously, the per-VMA locking could fail in the face of writers
> which necessitate a fallback to mmap_lock. The new
> vma_start_read_unlocked() will wait for writers instead of failing.
> 
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
