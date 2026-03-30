Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF997324B31
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882169; cv=none; b=hXaLCfOf0HdzGMCT/rQlhfyOmlBy1GkExpbs+b/WjLZmqTFAUaEqjCp4YZ+OVpQ1uSzkAfJpG9hXNXdoY5NVCOkn7QDOED82Ruk7rplyqmXYC4v8QswohPsVSgSez5keDq2C97G8wEMcw2pCDbeZrye0RoUhYgKj6Pg7xVLNMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882169; c=relaxed/simple;
	bh=z0T1XJu8Unvxzqpx9fqCDccZQn33T8hhs6JtyW6uAhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4iQ6au7fcIbY+gX0hMxJtn08z2xMaVT7pVIi91PxF0oKO/PrrJzJk00rxr6WSENXts2TDsGh3rVao7uVhzdKAJOAliskIjnDkmK0TKtLRvMqZTimdsp+Z3OYiNGLpDr0pRMl+TW5NQ73LccH59LRv8SrcIIoxujciOUZBhrbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=aKgXXmpd; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aKgXXmpd"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128e4d0cc48so5437304c88.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774882167; x=1775486967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kX6VYdvkK3WSV5D/nj33iayP7yFolCU3O0urfzHGZg=;
        b=aKgXXmpdhbWr9rnQWOdbysT9lgxRTLqT/XkczBntyeKBHuiB2q14J7EEXoc+2cJoWv
         ettb3670BSjvENcvhBHK1XMDOmh2PyMuNIXdSPuEOBDQQFWStf8/+jbcB86gE57d/Ltw
         FaMblQVQAnxNOyga83xEIOEOgFL2O7v6i7HtEwDMYm0w+pZGEqT+zx/rNLlI3aZAS995
         +OzFyVlRynRw+pbn3OAgGRz9ny3Xd6LZwQztcFVOQlJuqP7Om07TTuxJjMCeYUabU+G4
         NALckN4RR1l90x0kU4gEngbk991dU8B597Sz2KuZbn5M4yd5/BhCX2MgYLe/a/5F+RVV
         mQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882167; x=1775486967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kX6VYdvkK3WSV5D/nj33iayP7yFolCU3O0urfzHGZg=;
        b=MkqP15YG5u7LIJMVXQ1FZolgqv8wzbP9BpllYruezJ79/nvL0+0YLuis/FbXlZxF6h
         EtK8ArfSos27aU6jI85DP4M89A3N160t1YQGcmv/9REaRr20HI3CcAPXE1QArJbcbgTb
         7xATNyDjDeDkg0rz7Q6QENZtooi9HD0apQ5v0c02v10Kl2HXeIoL4lhdzWfI46siXvBq
         j6VFzJY4nn5jVG3+eGaB1kav1yj6561+E5ikHj8bbvAOvYH7EwOrTnWHjrfHQ3r2/dpl
         vAJvm5M0SjrE1KS2Xw3JH3Dy5iWUIUrQV+fVw+LzwdEvyhsR7hL4FQDDixpL/kYJUqGU
         KFXw==
X-Gm-Message-State: AOJu0Yz00VWwuBO0uFAZ6T4a4sZAVmLkBqF4RTxq8YIkVm4tAGgAZ7zS
	MAQE4foEN30EFldhIu/TlcxsnCAeBXmcNMOzZB8gJxnXv9kmT3jblSZ976ju5VBVjKY=
X-Gm-Gg: ATEYQzxtCow6GQw5VNFiXlnnHsQ2XS45um0yLYq9kL2BIutr9E3E10T9N3FXCvtk3B+
	WqNXpJ2Q/vKkTLMISXwTFO/fEShoA418F2BW2ZszPbGjVxcug+hhjvxaRvzM+KEkSgg5saM6QKr
	lPxKxxollIoVV0Og13ujMmZep1Sh0UXS5GJ3GfVBmoEkTv5HmTXUfCjYMWN27H0L17qXO8J+ns8
	JV5JnEoB1z/oTvg9DOjupt65Vs6/1MVEFLzkuMWZMQsUlDXXRkKAfNIN4Vhc/9D8n2/CQNI7xGJ
	yBM0uCaN9a0avgkt8hKMLo1OPqR9PbhGEMn7/9RmrGpCukFU7k4c/qhKXiVft57S0zdc0cuBu9C
	E53Gkz2Nw7Qm3b7BsPUopmO9Zb9aLe8HTWZnUIHL/w8IjniwUvE53ZtfLfBO7dv9brqcbnkKPaQ
	r+4OeZ93wH6DJiP9gGIluDlprvSBlp8cj/XN8=
X-Received: by 2002:a05:7022:698a:b0:128:cc63:82f0 with SMTP id a92af1059eb24-12ab28cb76cmr6908852c88.25.1774882166723;
        Mon, 30 Mar 2026 07:49:26 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm11502593c88.7.2026.03.30.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:49:26 -0700 (PDT)
Date: Mon, 30 Mar 2026 07:49:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] net/sched: netem: cleanups and
 improvements
Message-ID: <20260330074923.6f4795f4@phoenix.local>
In-Reply-To: <4400db54-aaf0-4cc4-98b5-bdee35e29cce@redhat.com>
References: <20260328182704.456993-1-stephen@networkplumber.org>
	<4400db54-aaf0-4cc4-98b5-bdee35e29cce@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:16:21 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 3/28/26 7:26 PM, Stephen Hemminger wrote:
> > Cleanup and improvement patches for netem, done as follow-on
> > to the bug fix series found during AI-assisted review.
> > 
> > - replace pr_info() with netlink extack error reporting
> > - validate slot min/max delay range on configuration
> > - fix slot delay calculation overflow for large ranges
> > - remove unused loss model struct fields
> > - remove stale VERSION string
> > - add per-impairment extended statistics (delayed, dropped,
> >   corrupted, duplicated, reordered, ecn_marked)
> > 
> > The xstats patch requires a corresponding iproute2 change
> > to display the new counters in tc -s qdisc show. This will go
> > as separate patch after this.
> > 
> > Stephen Hemminger (6):
> >   net/sched: netem: replace pr_info with netlink extack error messages
> >   net/sched: netem: check for invalid slot range
> >   net/sched: netem: fix slot delay calculation overflow
> >   net/sched: netem: remove unused loss model fields
> >   net/sched: netem: remove useless VERSION
> >   net/sched: netem: add per-impairment extended statistics
> > 
> >  include/uapi/linux/pkt_sched.h |   9 +++
> >  net/sched/sch_netem.c          | 120 ++++++++++++++++++++++-----------
> >  2 files changed, 89 insertions(+), 40 deletions(-)  
> 
> I wild guess this is causing TDC failures:
> 
> # not ok 364 8c17 - Test netem's recursive duplicate
> # Value doesn't match: bytes: 294 != 196
> # Matching against output: {'kind': 'netem', 'handle': '1:', 'root':
> True, 'refcnt': 2, 'options': {'limit': 1, 'duplicate': {'duplicate': 1,
> 'correlation': 0}, 'seed': 6495514880116664183, 'ecn': False, 'gap': 0},
> 'bytes': 196, 'packets': 2, 'drops': 1, 'overlimits': 0, 'requeues': 0,
> 'backlog': 0, 'qlen': 0}
> 
> Possibly patch 6/6 needs to update the expected netem output accordingly?!?
> 
> Also there are a is a checkpatch issue on patch 2/6 (empty line between
> fixes tag and SoB). Tentatively set this revision to 'changes requested'.
> 
> /P
> 

The other patches from Jamal should go in that fix the duplicate loop
stuff.
