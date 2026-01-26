Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72C344029
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445703; cv=none; b=e1j87B8cY9NufV/k2K1Wx/k70zgIBocTYbac7pt4IJ3M2tqbI53ESmdlM6DtkLCkdO+l4BIPjLtiBR5Bv4irSuWxrfN8MY2quTEEaF62CXOopCCxxXvwCniR62C39xhoV/kbIjF++MVytBzXuXQTsrDCtNssno5FQ4QIWoUrrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445703; c=relaxed/simple;
	bh=8yoM3+JoKX/J9QDS4HwajBIfb+G9TUqyNd63YSi5fTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlMJAfyje2NyO5R0UMP6GpqCu88xsbgOaukJ5KrZJezhV/rPboITKjxS3csF6scvNJF8wXUecIaCpJER0gd7JNjuc2dk7gM1xICByJwmmx2NoWCgWgH4lE6NTfzelRQEByy6Zo2aIhk5+wd22AiRtZAV28SnrgpyWowE7+4qsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WW/xyn0r; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WW/xyn0r"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4327555464cso3203927f8f.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769445700; x=1770050500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEUrHNK8dWefUqOs00hvfwKIFD0uk17xYeaKpauo658=;
        b=WW/xyn0r2OskO1/gzWNoULgDe2kdC0eHk8bhHWXchpqj6zBf/26ldY8HjHl/v+zfKq
         0qzUPWlXUqmkd09XTetXlHKx+7HC6pXXogPKuOmnKvpxpo8uT1gS2ldSwn0+aY6O3zXv
         h4u28Zn2G+3wOJKfpnm0NJLdQ9RlpUGvGRv+J9GzTaSPIcAl7PT+NbuvAF13p7AvUCps
         HQUsFJA9gGnmG+46x+XVjR+e/k9QQB5OdIVD1VfeWImnSfxGSdfEeYyD+7A84RHrUs6Y
         +XsYMZpdegAEXSTsvZ0x4GU1LO33SWaRjXInzhh+Aa6FFN1CV/9RrMu25lmu96Z4WiHq
         WHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445700; x=1770050500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEUrHNK8dWefUqOs00hvfwKIFD0uk17xYeaKpauo658=;
        b=ZqOpOa6c6ugvxJTjPZKQgLzddlSDnc7TP6iiK/SOwPTwqhCNY/0PCo1v/lbW3uF+yv
         sNp6wxJkRNguitolWzZjS4vLhnzZtUo45A1vZeA/vcQsShMBt43s0hdbIlgkKknUOtsV
         8JxzryNwhFwc1djLjOafnPWWTqPDOBo6qWNvCa6DiEgahncuyGwqMLvGcyKcaDdMVndG
         jokW45jQe6hGSH2j8Oi/OPDUHa1hZqSXIiNcoBHMKbqSNpkjvUt65ep/G423DMOup3NC
         WXcCP6bq+BwMQQzJJVr6L+vlB369M0t5H+DpgnV3F4KWvm57TjH1+3wVIc3ugGSin7I5
         auxA==
X-Forwarded-Encrypted: i=1; AJvYcCUWNjPhZZ74aIw/NwA86ROJncVCv6R90BZVVZj33Uptg3kjkho2h4xQvmmdxWMo832/8wa/nis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BDQqbmUxjKpKvWmXuFt7Lr01/IiSkZSumV3243/1mzLcq5Iw
	S7QYUkxQu1KZPaosfD/PgL2hrLA3Cya0RlVE3GKLuCTro4ejPN95TykZ8TZz+m9p7OQ=
X-Gm-Gg: AZuq6aKGvV36v1tmbhDWVUTs/soGqQwLNxZd9hbMcYkQ4wewas6n9jFPCJTVg8uoZrS
	tMDfHs5Lm6Do5mA9ItzAZHV7C08j0uYPmFBRM7b+fDKGT3gkwKeewP4Ey+jgMa+FYuhRJs/WvpV
	Dbkps3A/ifyyPHz7n3r+4200nfwf6lU9kWtxTCkFiPVJZ52DC/WBkOZRmNI/0xFvRZ7AzfLKTDa
	8P8RUejc8Ik6kM/jSwc5rKWy2Pge+n9UuzBrE6zMJ6lcIYyrL31TS2A6xQD89CSyG/Sy/w36pVO
	pIfZYkvr2BPWKUYIF1SvRsqxLjlqIi1/L4zqu5t6/8aYGAm00RdJcLfhiamK2DauFXzowtNG/zF
	AhGzZ90xh3hnJ5Uja7wqEOnoO6EKaSxR6N/44igshwXkXJlMCT+66dphS1fQxL93m3SCEIxIGug
	zSklCHR+C5QiIBgvzZN8kt6v5J
X-Received: by 2002:a05:6000:4212:b0:435:95ce:84cd with SMTP id ffacd0b85a97d-435ca39bd3emr10384617f8f.54.1769445699664;
        Mon, 26 Jan 2026 08:41:39 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f74b15sm31194587f8f.35.2026.01.26.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:41:39 -0800 (PST)
Date: Mon, 26 Jan 2026 17:41:38 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/33] memcg: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXeZQoSHJ9QX7B6W@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125224541.50226-4-frederic@kernel.org>

On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> runtime. In order to synchronize against memcg workqueue to make sure
> that no asynchronous draining is pending or executing on a newly made
> isolated CPU, target and queue a drain work under the same RCU critical
> section.
> 
> Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> workqueue flush will also be issued in a further change to make sure
> that no work remains pending after a CPU has been made isolated.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  mm/memcontrol.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be810c1fbfc3..2289a0299331 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
>  	return flush;
>  }
>  
> +static void schedule_drain_work(int cpu, struct work_struct *work)
> +{
> +	/*
> +	 * Protect housekeeping cpumask read and work enqueue together
> +	 * in the same RCU critical section so that later cpuset isolated
> +	 * partition update only need to wait for an RCU GP and flush the
> +	 * pending work on newly isolated CPUs.
> +	 */
> +	guard(rcu)();
> +	if (!cpu_is_isolated(cpu))
> +		schedule_work_on(cpu, work);

Shouldn't this in the guarded rcu section?
-- 
Michal Hocko
SUSE Labs
