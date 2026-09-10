Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2A3D9DC5
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074397; cv=none; b=XaXGc/yCG8oD5RrsoKtXUydalJVUbUM2buyG+aEBRvGhTyQNNOKSCQHlkyKSCJX6HLN+Y8reOjOASDuSJz26Q8tW5aAo8QP6GGNEeWr4VLHZQPBiY4u2ZqDtA1HEPw8vC4xItPqPG8baTqkem/JpF3QXSTlGnZB7J0ErzK/v40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074397; c=relaxed/simple;
	bh=VDPrQ6rvANCWQzB4x8X9HLIRs4IEDTr08YDsjMGRXIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xousu6KO/mqVrVBidOP/SL3brgkvkGFGE5Y2ekwBwTxZPMoN0EXREvkXNK/oZg+EA3Xjsxox6g9UQ+xJukiRTOnjDhytT4/oRl45EF079Slb5PML0vyD7tVinlhiRWeZeq+a2QWOzT7Y8hz3LkTspoMrcnrJ7PfYgfucDy0s010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6aqQpKs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6aqQpKs"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so199200f8f.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789074391; x=1789679191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zC/TwPpzsaghSj/8QRD9k+IasDdKbL8GKT8smkkknMk=;
        b=j6aqQpKsy7MMVuX8kcnqQOgvL2NBMTQWYj0hHNNiLniFZlL3gZBkfC4iP3vBUkeAmc
         WnazSJMLZEX6By+VyRfrB/HFQgc01SIaXqX+LVAyOxLi4aZEYpexCM8rMwH0yprfg+eR
         4/APBVyrQHtUHv6Ugh0Zt1E4Fep0Inr5EciP9bVkOpYv7hgItkA5sYVbXeGXUYz9QzgJ
         w6sqDwnBof0MdUAR0U8ffRRx3Z/7ya7ekNvD6Ih44xVY+r2P4BsQJm0KCugU5K3z0Reg
         AeQzDvymzJ+rYfBtceo5llFE0n/qtnHNMX1pB+uUOt+70crk5CENeZO/FoZXIN+B4Nsy
         ewzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074391; x=1789679191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zC/TwPpzsaghSj/8QRD9k+IasDdKbL8GKT8smkkknMk=;
        b=k2pSM2FRnYyhtoWwZjsXAChHbDC5/Ve7ZdnkM33SG1t5nKHc+TzJ2QC5WdVuJOgc4Q
         KLM3+M3H7Qvha/VIwMiTM7plXnyJdUmCjj4KfBOWqA4RX8qAMoAIdOmO4syZVEg2DWs3
         zkNDArk/mzEgqxBwZmMWGsENd52js8yqv7E0bWf/dmT0v2gyuxZzjiByASYYGKjCwJp+
         07T3eJ5ce1DttHjbUQtH/6c5vlTRScJpJUGbJiOpTEyt9L8v5WSAV+V3QBKZXkGCuXAt
         XRCv/ir7CWtr3dH9MtbAZIXzc7zTsK/LyVuhkcSQEVp/kpDji8jcfQMhnqGWWVMkTu/S
         UQSg==
X-Forwarded-Encrypted: i=1; AKwUvBxC1hhPkLmRdDchv3dpHubymEYrwlFb4QKVQ5OjP7OyRO43tY/UymkVfzbvZS23bmIuUrE4QJc=@vger.kernel.org
X-Gm-Message-State: AFuF++mLYWa3Em9UgE3KVTv8dbx3nFB/gwf8ZZTWCQuSErRiaSysQxtQ
	4BMPyT/TTvmFp0nm3OVSBnOy4g+tJ3P0fYdddHSEOH32XZZNpYEZ+wo=
X-Gm-Gg: AYBFou338JNo1Zy87cFeQpSb6yjkEZrN57QIjMCqJovCMEoUz3uKnejKMcPqu3OJTKO
	YfbhG1WAWYQlaFyhGkT6YxkEI0LvzRirmMxqywGb2crfzfV7DULS3kyn3DKYmlD9SVKrMr8SgGe
	8KU4ruAuWBv7NgiJfgRGvCmpxHU9ZqNtd16zEHqbqM82nEt3WVzBnTKgtTlC5NauW8c6BO+NEA5
	SlQlrjjof5zvM49vmnV1vbVDViP0uRUWBAF9dm6orhuSwIcQdEMNi1CzJzabQR6QiZ+TwS9UaFt
	0Us6+XzLmKjPR+BhMHfjG9dEzbYSDJG7kozYD40In0axx3BaMSCrzIlZVQ9RqT5ty5ktO1PMwye
	9/LcrCy+9tiO4NgCtSpobG5pU4G+pk06+rFeGruKnMun0WNDPyCV+YdVzgkLwgKi0HHQPIUNakt
	TEua+W0DcnNJvAYVJ7NWpcj7n4eRDmPtX9z3LDOo2p3xigV9C1Ln3YDbbnFXbe6yBhCH3jpmFV
X-Received: by 2002:a05:6000:2f86:b0:486:e73e:abe5 with SMTP id ffacd0b85a97d-486eb2e269amr1118040f8f.10.1789074390922;
        Thu, 10 Sep 2026 14:06:30 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb330bdcsm1196375f8f.13.2026.09.10.14.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:06:30 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: Re: [PATCH net v3 1/2] net: airoha: handle RX_NO_CPU_DSCP interrupt, not just RX_DONE
Date: Fri, 11 Sep 2026 00:06:21 +0100
Message-ID: <20260910230621.730983-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903173355.62780188@kicinski-fedora-PF5CM1Y0>
References: <cover.1788286284.git.sochnev.v.74@gmail.com> <17f1beec505b87a4acf16557386a978c98f94b97.1788286284.git.sochnev.v.74@gmail.com> <20260903173355.62780188@kicinski-fedora-PF5CM1Y0>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since you're not sure you should probably add a timer to retry
> later? Maybe the IRQ is not needed at all, you could just check 
> on allocation failure if the right is completely drained or have 
> a periodic task a'la fbnic_napi_depletion_check()

No timer either: the depletion path is not the one being hit. Please drop
this patch.

Instrumented builds logged zero NO_CPU_DSCP events across every run, with
REG_INT_ENABLE(bank0, 1) reading 0x839F839F, so the bit was unmasked for
ring 4. page_pool_dev_alloc_frag() never failed and q->queued never
reached zero, so the ring never enters the state this patch handles.
Images with and without it stalled identically.

The stall was RX rings smaller than 32 descriptors, fixed by 2/2 of this
series, e84b89f17a12 ("net: airoha: grow the small RX rings"). Details in
my report on the cover thread.

airoha_irq_handler() does discard the NO_CPU_DSCP bits, so handling them
may still be right, but I have no measurement showing it matters and will
not claim one.
