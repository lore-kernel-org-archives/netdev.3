Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE54F93A1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975961; cv=pass; b=WcUzoYRajaq/mqQuMqqY67j7cSpi1ggllxJqTC7BOPzTiAHjc8KHBSLNtc0qeIOCcI5X/1+QEuagZvixVo3pp3YCbUyy6rNrv7UY/rSMJWzmU+ZF3TmZDIn84aNCs4cwlxgJuNVl8uAxNVCn6A+b4dzN+uoiTfdVhTfp1WRTwXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975961; c=relaxed/simple;
	bh=oKg3O/9qWwL0S/n8isR5H6f1yss4N5Cz6zPMHFWqGP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKWMzCEDlfyBo7Mmg97c52RJjmUPPEQL/lW6CIw8ZHWQaIMBjLedc4iP544yM9NjlorRo/8uDIsKgeJ4dQLQl2+MWS3XWasRn5bffviGUoiNndecFxvig+SSbsmvh5+9lpAozYzEiv3S8mHM1UP37r1Uiaw+RV60UkViC4pkpDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJ3g7cjH; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJ3g7cjH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db33db4de9so212895ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791975956; cv=none;
        d=google.com; s=arc-20260327;
        b=no1PEm7hoMQYcVDoNXeBSj6Ezb6WrwFyyJY5muRuleRiDFtjbmc+3bITHcpJc9jmMp
         cQ3tstUrH+hizQFqUALaBd1Hwm8OtP3G+AUDTU4QQGgSDRip1H+DcgcrWmPeX1tB7NEj
         odt/rlOtRoIAY8bJ8+8aHYfJvUW3RCNmqsSvy2zS3GxwTZ8H/TVevpwC1ga68HAP62FK
         evUDJ7VvkW4UJVUKgNI4Gknb7ysd8Et2zU1VVhwjIATdnr/4xjEr5hSvsb6vOYrQmxzq
         7qn/yO8DxLOS607tPfEKKwsjxrgP33vd2JdzbDoZBuy3uD4avxdUm9YGd8p2MpozH/r6
         lxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKg3O/9qWwL0S/n8isR5H6f1yss4N5Cz6zPMHFWqGP4=;
        fh=G2l1CK7l8QdhedNP3xUIwRuOUTJj7rbulXui+np4Wzc=;
        b=ZqyEbkWis3mlnkOn8m6YQJg+sF3t4LE6d/PiJKQKA5QHuTO7R+PWdsDpydOcVyElyf
         XT6hKKSHFkI9/avW1BewXhHOQ1505IZBTR0IRjwubwz2cDkJu6P+k6PkG9q05XgXVXA4
         bjeGRNx338IlZJpEBpBnFkaqW9KG/tHe85GrYOcx2sDpu1DMhnCYgNrO2LtWHBqATcEI
         1PvPwpNzoZZfuaZGhe2GLPLeB9shwSYbUI8K3RmVeqj1zmS7uJ9uIz/tQDxk5AIbu3gL
         VFsE15LYl/Nr4UC0XmqyisoUIERFjDePLMgSkOjcDQpMIB7U1hr8tbVTSb6ovTjh7o0i
         ehdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791975956; x=1792580756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oKg3O/9qWwL0S/n8isR5H6f1yss4N5Cz6zPMHFWqGP4=;
        b=YJ3g7cjHMpm7TU8HvtpzJwSEN8H+q5OGe6ySUTtM/H6A5nduWlRHZJ/SoYWbknr+oR
         WxXylTt012xWuCK43avh36CpAlVfVM6XDBxYX6A/UiyHUWj/onilcDN02WyBWqGR/0LS
         wjto/T9bbfmolLeCoL7fKfNIvcgGp9bnyGaRh4bDWRIulY4qtm+Ao241Awqxve9VsSDB
         X4bq0qbqIAFVwVOLKmcgnLrqp1H9qRdoL0RT/fv3cseDN/64Zy4hhpvjccBUSeJmLjh8
         NVF16ZbmlIzEmI8pWK2ESTshLeWphtqx7OLEINl26D25miLzIV9jyp0gQdRfPeqAbv4G
         8Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975956; x=1792580756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKg3O/9qWwL0S/n8isR5H6f1yss4N5Cz6zPMHFWqGP4=;
        b=BXUVUQ3JaV8JszwiOJk5mPyOS7VRLKKCsed40BiEE5OrvZ0Hm26cPmWFTEWr6LtvAc
         RtkdMLtno+uvqHbUOdiJRPqQc5rn4+8M2660KF+M48V8uZVAmbX3zX26Xr/VawsNMrLi
         Z4lHwxQ1W0LRRs62IhgEGDwfjpliprgXiwJCFoVvne9ntEy3GF9+7QUcOdVLSj8Y1INB
         zYTVRR7IWG2f6X+u3RSBw+tHDaKJkt7T3JTyrR582P3VzLfebgUyzYXBMBrWmiXGJw77
         iX0b/F3rMQNaCzti2T34PGS6cC2t7o2gcNZxCauEGIzTpoRuhFba1mP7+dEp4IpMUy0+
         Evnw==
X-Forwarded-Encrypted: i=1; AKwUvBxpQnObUs6uDEhYscquLY/+Q9tn0B///Drnle6BpsFBJAAZBf2ZOlQR2di48GRYRXvIvfcnzQk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2x7kCxGzFKIngWjdiwtTGtV+tBBSX7h1tRQZ7WGNfk5rFAZJd
	1cADqzqBdFhmL8n7FnnEbxNpW/fJ/+3X8mYz7jueMFovJeX4f0H2wFaipzSfQ1aQlz0WjwmL3XR
	jkbndI2N0jPvyN2/aEqPdlng3oUqYnqIDaBoVokU0
X-Gm-Gg: AYBFou2j7MLQj/B1k2yCruBZ91zhNeo+c1fAP1DVF9OBnx0AZJPI7EbvYydPl5GffbQ
	+LuXIjpUNJgAKqUZgDC0cKIZOJ4qbEWrCvtIAaQqmufEQmz3ZcI3MQK7fSzIMZAhanK0maXo6jA
	Hl19QCqNVUQQy4gi0D25fvRpsYVrGW51NqwGy9UlBfH1CyDOeSauwUuAkNgjyh+Qshwx+nOhxdU
	JKfedBntkkXGpBOtB0CNUJbF/R25+qtO2UEWRLOcZQiQR/ocWn4tmzqv0A1wVkrGmbr2F93mPgK
	7iPcFs0kITWqqPEpgvsgVhgn8jwzgKfa+Ul9W1iVSuWhO5rgOVZk1ve8
X-Received: by 2002:a17:903:1a2b:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2e939d0f5c2mr3033515ad.12.1791975955291; Wed, 14 Oct 2026
 04:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <4fda41ed-741b-4c5f-ae83-e3ea5a447441@arm.com>
 <75c229ef-ae41-4072-9c90-98d4779c52bf@kernel.org>
In-Reply-To: <75c229ef-ae41-4072-9c90-98d4779c52bf@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 14 Oct 2026 13:05:18 +0200
X-Gm-Features: AclHuK8XP34mfrE8lQUslMQMNc1nPr8ujKpQNMaoAI_u53qDQl4REr9J8L8QdAk
Message-ID: <CAMOZA0L6hWd=PYLF2PkYwMG11JCson6Wp4Fy9B3k3VC0Vt2R0w@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:48=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/13/26 12:42, Robin Murphy wrote:
> > On 12/10/2026 8:43 pm, David Hildenbrand (Arm) wrote:
> >> On 10/12/26 16:45, Luigi Rizzo wrote:
> >>> On Mon, Oct 12, 2026 at 3:51=E2=80=AFPM David Hildenbrand (Arm)
> >>> <david@kernel.org> wrote:
> >>>
> >>> I had to call it something... an earlier prototype used the name IOMM=
U_2M,
> >>> but I didn't want to suggest that the design was limited to 2M (it is=
 not).
> >>>
> >>> Aside from the name, the _current_ prototype restricts to 2M allocati=
ons,
> >>> exactly because too large units are expensive and wasteful.
> >>>
> >>> In the code, decoupling the allocation size from the PMD size is triv=
ial.
> >>
> >> Yeah, we should do that.
> >>
> >> We should probably just find a way to describe that this is a POOL tha=
t focuses
> >> on physical contiguity in some configured granularity.
> > And since it's intended for DMA we could call it dma_pool and oh look i=
t already
> > exists...
>
> Heh, I did have "DMA_POOL" in mind when writing my reply.

which confirms that naming is one of the hardest problems in CS...
Let's try to figure out a good name before renaming everything.


> > Sure the current implementation is capped at PAGE_SIZE for allocation (=
and thus
> > mapping too), but I don't see why that couldn't just be made more flexi=
ble.
>
> That intuitively sounds like the right direction.

Point taken, I will decouple the allocaiton size from PMD_SIZE this in
the next iteration.

I have also followed up on most of Pranjal's feedback (stricter error check=
ing,
compact IOVA ranges, opt-in per destination on the tx path...) .

I am also looking at reducing some inefficiencies (e.g. pagepool already ca=
ches,
and allocations of new pages are relatively rare, so there is not much
of a point
of having a dma_pmd_pool per queue; and on the tx side, something similar t=
o the
percpu page cache to reduce locking costs when a page is allocated on one C=
PU
and freed on a different one)

cheers
luigi
