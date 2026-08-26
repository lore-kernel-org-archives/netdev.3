Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570861FBC8C
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734056; cv=none; b=SfNeBAxcJZOvJnTuCCcthHlXBUmTOHgfbKkbmWO8nWTwEBtbv5cyq7d7+H4sOGajLvDcxqpEIDm2b7TcqCS5InsFcV70yue6Fj5i0xjxC6rn4BE3yrshIYV76sSEslETR2YT/+HnNBMN1yZ4ws2clMa/EKoN2x/j6Z2awrlupKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734056; c=relaxed/simple;
	bh=2Xy+lK5nUQA7bE5BLRPy6Ns7v7CgSgCc2oMnH+OiQR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htmnk7ao57EdP/9xQdL6mn8ZbiWRUJs5aST987kwla2rL3PuDJFsqBw0AJAk7GVUAJhSyY0UlWhaWPxTXZq7r1b6urF+8F68m+JnQh75eNNa1CGC0tl+7qMzYOnjlw42TvTToP0s9JXSbEjSKZvZ5gKgIgFpOVMmyQgqUsRhz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE3yrnYc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE3yrnYc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so10210805e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787734052; x=1788338852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=voSEcyyZv+wWEV6hLUEFNxNUBpCUyY/69hHl4M1p5Bc=;
        b=PE3yrnYcAg0GuNfZylry9xDSKo73qwVBvQshDTxi0cIh8yXSHLdbOz/raxYLXkCjyQ
         UixqO75/c0AdU7gEjzIZIk1M/L+4hiVAeQChntfYaw5YUv2ICFfQd4hw5tVtIZNhnQeZ
         jCYqEVxHe4jaStFk62GoQPtlIQaEeoq8jEz8hJXhh6Fzp0u6udcMRazQ/ooeukzhf7nb
         pHbqCmbxfdBQ8i/6GU98lKGLL9/FZ3vvBJ3UxnwItMqZhrn04XwlYAMWWN71gZmF+j7l
         3hG2mQEKqJG2AUomyuCIU0DBmYDZ9U6phMy3R3ZJRXlWSNwe4MZkEZtCeGUR+DGLVDZ0
         BmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734052; x=1788338852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voSEcyyZv+wWEV6hLUEFNxNUBpCUyY/69hHl4M1p5Bc=;
        b=ALPq+lce/eq6Lwa5YfrfsVf+UJx8FmqquUA4WVv5+gzjjAZihghp7j5Misd4O6Ot3u
         y0PN3U/QqzN7qyBOdodenoFqjh1f6GEMhyRCCST8tXT03s3wA65mZl15rMZv6WEi5Ohc
         33qQRokBVsDHr0dtgHQeq+ajv5hwzukAPbE32pk2mU/RDT5vYQDjTQwZBzggLQXViM5v
         tqzoFcK3+vGNNZzVXE7Ad8azYozGDanXDFYPlk8fwKVqJN5447CAuCTBsGXJoketnxOt
         035vT0gmCSGHxXe9tFx+bMm/LfH/40/q/aNVjDlzxcSp8F152PzVzP/KKqGb0G+BLMBN
         R0iA==
X-Forwarded-Encrypted: i=1; AHgh+RoaZvL5ycDuz6RzPUi1OzJBRgXM1FUZA6zZCn7uXUqt1Ys2JndB+GW1wGBtJZ2qZc5R4UVi4a8=@vger.kernel.org
X-Gm-Message-State: AFuF++lus6v3LEd2xH+BhR0SwlE0tGbTNNzaEuqUE7Vhm+nerlK9XUdo
	nsUlL455bPPBFQK+B7j0hE7owOHrFHCm8VSbx74dgFVYzCN+Tw1FKHnZ
X-Gm-Gg: AR+sD11Pl9dCtUkLD4/10+2cjCmpwNZSamf2VrtWslBYYZeB50IF40/e121PD/peEGs
	n9PEsXRAWvTuIPhmwtst1JKA0FUYfSCupASl8Gyg/1SgkrvCbFzw1IGzM4rA5Fjl6/b5X3FW8+O
	p3ymOXFnJmXDtN80vA1I5bn6vp0emGHFRYK6phAYeRAT/SWo6KLHHjhCXDayIaaThPgYPJfcTqq
	7cbVjZj08MPyJBgKPFQH4xkdVNzbwHWbC504M0VDsjCJoj1oRAtS2wX8LHN/RECA2WYw149M260
	v7YxzCANJaJPqF6cYJJv3WVS3WHhb+4ztTYpPEQg4HSQOVCwL2B9h9LWFT/Tk+0M8DneoxXIdSO
	zRiRyh3OeHxBsNz6ULCelcex+9uiqssmrPun79ryyEdzSX8ry88WofYWvkPyTBEWDUcyUPu1QIU
	1kIFMerNlbB8Z9Uao2IXP3UnAv0waPo9ENjfRrihq2SH4rJ2qK2HaJnUNG/cfyWIj9BQH/FPKC8
	oTda3Y=
X-Received: by 2002:a05:600c:528a:b0:499:8afd:4a9f with SMTP id 5b1f17b1804b1-499d62cce7dmr151488465e9.0.1787734051586;
        Wed, 26 Aug 2026 01:47:31 -0700 (PDT)
Received: from cedric-laptop ([195.225.166.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28f5e2fsm1914240f8f.33.2026.08.26.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:47:31 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:47:29 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>
Cc: 
	Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>, cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v8 2/3] net: dsa: mv88e6xxx: use the hw tx queues
Message-ID: <yj5gjell4ovjsqesxmvbfrd7qxt7hj673qvbgxeywpo32loow2@il3z6cfkpluh>
References: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
 <20260811-net-next-mv88e6xxx-cbs-v8-2-10d0baab2905@luminex.be>
 <20260817105024.65be6d55@kernel.org>
 <hgrxt3hlj6i7rcg7jxgyxzrxw6knk2eqykpiq7lgpu3zshprqq@ranq77v7pxbv>
 <20260818074508.26e626b4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818074508.26e626b4@kernel.org>

On Tue, Aug 18, 2026 at 07:45:08AM -0700, Jakub Kicinski wrote:
> On Tue, 18 Aug 2026 10:59:35 +0200 Cedric Jehasse wrote:
> > > Pretending that a DSA device has multiple Tx queues _from the stack_
> > > makes no sense. You should be offloading PRIO as the root qdisc,
> > > like mlxsw does. Then the rate limiters should be attached as children
> > > of PRIO.  
> > 
> > This patch follows what the implementation i found in other dsa drivers.
> > mlxsw seems to be the only driver handling TC_SETUP_QDISC_PRIO.
> > Wouldn't that mean setting up cbs for a mv88e6xxx switch would use different
> > tc commands than setting it up for another dsa switch (prio vs mqprio)?
> > Is your comment specific to this driver, or for dsa drivers in general?
> 
> Maybe Vladimir can comment why he picked mqprio. He probably explained
> it to me and I forgot.
> 
> My mental model is that mqprio offload is for the host ("NIC", IOW host
> traffic egress). But if you're configuring a switch where most of the
> traffic is internally forwarded within the ASIC. We should have a way
> to report stats and offload status. There's no need to pretend we have
> multiple host queues and waste memory.

I've found a similar patch from Vladimir for sja1105, but did't find an
explanation for picking mqprio:
https://lore.kernel.org/netdev/20200527165527.1085151-1-olteanv@gmail.com/
Note: the tc commands in Vladimir's patch are similar to the ones in this
patch (no offload on mqprio, offload on cbs).
