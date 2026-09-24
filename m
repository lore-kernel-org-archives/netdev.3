Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D3471406
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249010; cv=none; b=ML+l+N4VUWHeSr8AOG9o8hIPUhmBbNiwpdYBROCf5zVXL+syLlSCM0xMjY8lx0npHznHI+h6WupQJbWpdbd0XzAuhls0T6NnKoDRrQVc8EuIxe4YVMhs3queRPa3dq+NdtfdMB7KMk9UYoBStKAhcuHTUsg97legJJj25qxtVJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249010; c=relaxed/simple;
	bh=tZUd4B+l/yWunNQIY+ZJIho41qAzK/3+syJlrXZunwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9n+VTlQaYdbGxYFp4t7z+be6gs30evi9bPint0z+ceuW8WKDmIMuF7Li4/9vEN9KdmZzp8OYQLw75ek0iX4KxXLkc7MsA3OR8/mfH5IKh+eWGfnBfbezJZfLGfuBNbbETYIDEdtjqBJoHq4JiSS779wwtGvPowhkY5eZkb5CtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8dzwZOP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrUB5/lJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8dzwZOP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrUB5/lJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790249005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+uE5rBvrti+pPPlj185x2L2aTe3IHJgFjAYd6EKuC0=;
	b=f8dzwZOPsIL1iP/0uJpLzLodSrarTypSJsKko0zt9RD3HcvfynZQDzY0sVa4+ybEr7xHBl
	uQwj7zbFWj5j18m+hTbakeWbxTuuxQK/Bw5Mnmy2gZrGacVBZnsaOYTwOy9ANi2fO/JH0H
	Gfz5mqtFjYQfj20TPexKPLnrDIbGTF4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-XjlDRy5lPgyiX8JTcBqFfQ-1; Thu, 24 Sep 2026 07:23:24 -0400
X-MC-Unique: XjlDRy5lPgyiX8JTcBqFfQ-1
X-Mimecast-MFC-AGG-ID: XjlDRy5lPgyiX8JTcBqFfQ_1790249003
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso23602815e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790249003; x=1790853803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+uE5rBvrti+pPPlj185x2L2aTe3IHJgFjAYd6EKuC0=;
        b=QrUB5/lJdzhqAqElYsCYl8E/DVBdYOgQPudGrV2EHr8gz830M1jxltfkj6VblBnEcG
         kvUT99gOR+ZifCA8vjFCrS9QruEmUPXjWo7iz4qJ2P8O4Nmdx9NFqTKijoTjRKDVfdpw
         77gEDBDo5qV3bPCptCMxSfzhVjd6t1uAO+kGsoDQnQMqn+666URx5VdWOmlU+deuCa94
         YdybIc9o7myK9jfzK9MfTds5grDVP8FiXETehLS2h9j5Njy4jPHX/VL/6HcChycGIHFS
         6ncPmEvaxjWZBlU+Q6BrSXV8nqwYO5jlAqfUfmERjpCwAilklCUpjXzouavuMHL7l9qm
         aqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249003; x=1790853803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+uE5rBvrti+pPPlj185x2L2aTe3IHJgFjAYd6EKuC0=;
        b=H1alLuQ1ecqAUBE+80lVjNMiRVOQumeBa7mB3pfoN84WPshqWynGvhG3/ERtCXr+Rw
         wynOQ6bDWYeixdJdTmxHe5xrG9jS63bG6/9sJQN6d7KnTqYkWvZfnLbrOTj6UO2E/jXF
         afqmhGpqin77sTf6VwHuw6TRi96WtCoPYUZ8udBYjcKHiXMQ3QZMawwq+zeZaZNc3+ka
         CxMsRC/nsFa4pp0Ibj0ZQTodwIr2tndXwjvDLH2ZVjdUa+dk/+WUJEPDFcOafRC6LniI
         xwLbSKPJJ5B8k7Ep/8J3vglvnwz4kQJSOpH2nkQk4TfPLFeaTp41r6O5+X2315JwvTfr
         b7Wg==
X-Forwarded-Encrypted: i=1; AKwUvByuKnGCi9L+yLzjFyo6VFdNtMWroybdO0dX6S7AD/b7KFeqq++geX2lyhlcZthB5d/cVtygwGk=@vger.kernel.org
X-Gm-Message-State: AFuF++lryeZIww2/Ba23p2EhnFYYwC9ek58VJPxciTuUdrVhVIGeUyDq
	1jldAl3Iyu9QOpZESxjtSUrMo2ZODy8b2eFo+n4u+EI55sDczMLA29FmfO0KGu+Oq2thKKBXiG7
	GhfVUySeoa5ECkB3WgCMSwAPjNZKroWtL33sETkQ7sZf9us7xuvgaIwhjWw==
X-Gm-Gg: AYBFou3q/ES5DvTFEVEkOiNttYYVLo/mwThHa0DggD3LnwcwK4lwUOBYbvc7VwuNJ/b
	J/IfJND0xI7/+x4cTOvHYxnYoynkjtciI1Z+DJin4k9rzQAgZstKxgOkV4DIsYB2J2I6SeAVt/e
	EVaxNw2HC/sYmH2wrtOvgz/CSLFmQqk80jUrC74USGyr5Xt7ix0Xw/5hqFOMitdddE/KBmyjf4c
	jAVFbc3kTXlqWW4UUbszA/sPC6ez3dpGbFBsFcf9bQS4tfLK01xW3NbIcyQyKIGZTYBOtpLgKBw
	0xDM4ltMLjG+xGiDgNWVhVbkHS6rieZCCl8rgiNN5VztE0qyX2rV0JoeziwErBWCfOMJJJj8qOs
	goZybrqzpkwZhDnQEFknmOCt72wFILwW/xb2nFLPado3bWS8S9tboOz5vuUKduf9eb2DKoj3FkQ
	==
X-Received: by 2002:a05:6000:705:b0:487:bef:31cb with SMTP id ffacd0b85a97d-488716ca7e9mr3595362f8f.22.1790249003228;
        Thu, 24 Sep 2026 04:23:23 -0700 (PDT)
X-Received: by 2002:a05:6000:705:b0:487:bef:31cb with SMTP id ffacd0b85a97d-488716ca7e9mr3595325f8f.22.1790249002827;
        Thu, 24 Sep 2026 04:23:22 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c64dsm14440667f8f.21.2026.09.24.04.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 04:23:22 -0700 (PDT)
Message-ID: <b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
Date: Thu, 24 Sep 2026 13:23:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-09-18 (i40e)
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: maciej.fijalkowski@intel.com, zhaochenguang@kylinos.cn,
 magnus.karlsson@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, horms@kernel.org,
 kerneljasonxing@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org
References: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 23:24, Tony Nguyen wrote:
> Maciej fixes various issues with VSI setup, cleanup, and rebuild paths.
> Notably, keeping q_vector allocation synchronized with channel-count
> changes to prevent threaded NAPI reconfiguration failures.
> 
> Chenguang Zhao fixes AF_XDP multi-buffer handling by correctly copying
> and attaching fragments and cleaning up on allocation failure.
> 
> The following are changes since commit 46bc52d13594848023e681860df8700c8db14354:
>    ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE
It looks like clashiko has found a few serious regressions, worth a respin.

/P

