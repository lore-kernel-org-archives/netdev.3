Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9638838B
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077857; cv=none; b=XK7FrrmuxIKmpQi0WL96zwwMRlvxV13W4KcFPdaQn+BoWom6Wnr12XmqQgmEIsPszfz+wO4+W5p3WThHvnJts2FCwPGDPx82o5u4o6gR6oiPXTkdUqFsbC+HnRm173g+/+LyCtO8oGCwhNVy01PEXDYbFBCWFfbdeon9jUY4Jtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077857; c=relaxed/simple;
	bh=Vpg1SAbV+OBv9XruLKGqKVEqdfAjpddHK3qKRpVtsw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xsn9vFSW40x3pBudZal5UeQv1gq3yWmDpYjiSQxRX39CVZ41ZHy7weNZUYb9h/pkSgwpGx4DWNmN0oPt8147++titYcKMh72YFn99XS6Zeb1dQPe6WIFXEEDSvkoTb6MdWM59sCxBsCScD3EMPCXiBqUyziuZ6hZmR8PZgNRuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=dJBgLw+B; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="dJBgLw+B"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50baf2df711so1636481cf.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1775077854; x=1775682654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMu03LY0qCZzLGL1WuHCBvpS1SQA/t8qDMGzWzp1NCk=;
        b=dJBgLw+BB3jfBvA8NLrPAYVnQLpuJ3+zTIF6+ymFcgcgMtRDoboXJqGdJnJqaDal4O
         Mrx160xQBK/ME+ulwgnduBmoyEITw2wU98llFc3XykLXIY0Qo31O71UVa/gAzq1YoIet
         tt8P4Vt7Ftrym7t7Pdj309GUTza9xPIC1ZFGVN4rKR5dF/yNdNs55IkyUJsA9cJ9YwY/
         JywJtrMzgfooRsacQAlzDD+btSfbDqOoVw217wiph9dKmDe1vJvNgopK3brE3d+D3BcP
         kJIGbxbwvw2NtnVJemBVuQghE4h3beyM7KkFQFNPu/IdqUbl6ohG5fRGT73vEHFfoPhC
         wB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077854; x=1775682654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMu03LY0qCZzLGL1WuHCBvpS1SQA/t8qDMGzWzp1NCk=;
        b=MzbOK0CrSrcwc7IPPmtmdEtQF5LlFPKBzw7ng7emrvMHLTqIRzBKcWHzXamlPD7VnO
         E517kwzwmbE8eQBa6XLL06MfWPF/gO17LyQ6dEpMnJDiI4lo2TybrJL+O4CYGGqmp7dx
         3UoDdaR94T0oPRiEZnzDVtu8q/uLewondiHYweJUoZtJg0/eFsBBuzhNVgHZU6sSxt9q
         hB48nLcrTdDQJzx8gF2rTdXU4IwfIRuW4LHo1Zc5bQ8J3FHYPj61dL65K/saurPRzclx
         DtM/vku3D53Z16ksO0SPdHwDNAtKpYyKrpW4fNwgWxaXP9iH2t0Z/aS1xKxpZNVHAJn/
         fRuw==
X-Forwarded-Encrypted: i=1; AJvYcCU8XLWOua9nZIoZH2q7QgsJJBRJAAmu4yh+4x0iaLIO0u1hkxid6jXvjrOCX3URiFFvHkA1wmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnW7DmVuHISM2U30Ji39VePo54F719+womYSthQRQdsh1kNgZ
	EZuQ/7RPOm6MI4fotvOcbxyxTRg6WMBmh0xhGQfkhmRIAu1DCmakBeacVZx445vRg5w=
X-Gm-Gg: ATEYQzzqRki0VEyRufypJ/A/+aOKs2hiDf0OmqcWQN87i+iOd1H+N82S0RdPC4oa6nN
	kWk1MKh5KMbukm8ScWyNIFkb+GDVtOJfimzYObOOq+Wf806uFe4W/atiW+rFnFVhdS2ChUZqj+f
	eHluWhFXrNDWFVdREdrg4yf8recGDbiPUgULL3XtuSvMFep6pQFc3ISRLTAB4d2F8rShLMC98FH
	H8ajMEqj43TnHpvTKTj+l+1hJagRtPAw4xjd3KeqvgeIvW+ENoIjJmWRJ6B0UIq3YKrjsJhR+Qs
	ONThXAUYUEnFlKcEgMsg9sJ4bGuNgineOLtDBwyPbQpOxOzVisGdU2Et4hDbhuoSWAG901wwtmV
	D7k5IoygSkn28OHuYrC72DxM1CiMaQDQ5NrkchNlxO8giuCluwGVd/LFLXb4blUL95nEUsydvt5
	GfYc1bEUL0KvpWxSOgq1BKlDxpjQLITd8N
X-Received: by 2002:ac8:5781:0:b0:509:14f6:9841 with SMTP id d75a77b69052e-50d4bb2f25cmr17195691cf.31.1775077853897;
        Wed, 01 Apr 2026 14:10:53 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593331651sm6771496d6.10.2026.04.01.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:10:53 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:10:52 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, riel@surriel.com, kuba@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/vmpressure: skip socket pressure for costly order
 reclaim
Message-ID: <ac2J3Jfh_Q57vHRH@cmpxchg.org>
References: <20260401203752.643259-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401203752.643259-1-jp.kobryn@linux.dev>

On Wed, Apr 01, 2026 at 01:37:52PM -0700, JP Kobryn (Meta) wrote:
> @@ -307,7 +308,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  
>  		level = vmpressure_calc_level(scanned, reclaimed);
>  
> -		if (level > VMPRESSURE_LOW) {
> +		if (level > VMPRESSURE_LOW && order <= PAGE_ALLOC_COSTLY_ORDER) {

I think a comment would be in, ahem, order.

Once we go above COSTLY_ORDER, reclaim relies heavily on compaction to
make progress. Reclaim efficiency was never a great proxy for pressure
to begin with, but it's outright misleading with these high
orders. Don't throttle sockets because somebody is attempting
something crazy like an order-7 and predictably struggling.
