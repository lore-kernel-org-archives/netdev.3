Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4D233149
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105311; cv=pass; b=Qe1EezlSP0UmYhAhq9M/9HWYelVyjj56/nnMck3GVD7aPeBjckR9GNeLi5nba7CrkRVYfi/B3vmdr1/vbZifCg1zu5LL3wKkcMYIjQdaynn6YE7PoQ1kKdRi7cnIun0NXzusq38t+XRuk4PbISuvh9t5qPaaFhMlZFS2CvcI7SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105311; c=relaxed/simple;
	bh=t/n84oizsmqf30Qmzu71biJDzzYUFf3OYTLdCk6ENu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTt+fto9DO49Wl5mRSSjpR1q6O2BllT6OSAVBsZcvU09HQIyLrpK1ad/8hJXI1NgBYen6rBzMse36dBBpVC4VJcNRtnUMpQgRRpY71Mfi+Ht+7SL7i8Ae4d6AADB0asGWYjACgXps3h/KHgQNHahe2CD88W8a+ISYRx9mgGSf10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDFFpk3l; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDFFpk3l"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso383770a91.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 02:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791105310; cv=none;
        d=google.com; s=arc-20260327;
        b=BntjfkAbGEUTLCXABMww4p2MtBxilH4Qg5sfFSxpl4lSleGHWhc4e4piLrjR+cX7ln
         22jyeGaWj4QWmd7n9Yse19rjbcCicZwOH1ku333iDTB+E9/9MX/+7oautN2JKhjHhuCp
         pHsPFxzBzq2SiK/QiS1/mA+EonJP70oUHuXb0WlHDc7/hKLzozrL8HX4mDRdfA8lOcxR
         22hU9MqM9BkrGNCxBmy0hkKTGv4fqQ7Oia5hMs7w9Nk687klEEMDHx01vYpM851gniJt
         iTfa9TpRWwRBEAS+hVxJW2RXWl4NpV/XClX1Ms5yv65zoVD+rLRgnNY80mkncFm+Fgve
         bwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kaMhgqh0cNyzIJvdM7MdSJL/gkpQL52j+U/jEExbMjs=;
        fh=B4hEMvay3OKQsWqh5+dhTFdYTISsslShT3SHNhkPjr8=;
        b=GbmiHd1Y5GbDi+nZMazY3xegDfeNWWUqEFv5Y/06IxGrpYKPepE9h7ItuEkCbGEwIS
         /IJvE6K5rNql78wDW6YDWvS6BdxhqJ3LT9rv4kIMYYmM2karlqnnKAMd41X9GmI326JX
         bamQjgQ1Nq/DiPZ+dleNGf6oGmHLpEwki5UfKWFTtG28lc6rs26S4ulA5eBwz4dAnb5e
         Ctj/hs4IaMUWzmMCoRcKAW708LxBLHA48mF7CfPyiGQubpKpz+xxZt4WhVCDqkWpEOH6
         he00/uIGvJzJDxUB1lF5N49NLKXzaOt1DHHAw93uttg/JPjQGDr297zwqxwPNh41Os53
         lOPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791105310; x=1791710110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kaMhgqh0cNyzIJvdM7MdSJL/gkpQL52j+U/jEExbMjs=;
        b=XDFFpk3lPoJkVJWIf1wXLbSoEYqk9fpO4H1N+Fudy5xgeOHUMsLPvSZ+L4U39y+wPY
         urxf6CuDd9dMS20bIG3ZwnPehHVUcNquv79hggpTBcmM5ZpwW+nCHAkaWy+4XGZoBHMO
         4R2GIXs7LWgUBgHf+ZVe8Nz1lrKgCm057DopRvVzaLb1JqqQPcNvW6EDP2VFesftZP5N
         TJNde97Fa6D5E9fb6e84rnZDF6gWEkdlpc/tgPAZVz5HLkYJot94YfakfvbfeJikINkI
         /4eXxy1/AoRtjM876zUIT8VS2y0zoGrF33XMVHpNxsSYeLhaABeZRJXwRnstDbVNzHM4
         GYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791105310; x=1791710110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kaMhgqh0cNyzIJvdM7MdSJL/gkpQL52j+U/jEExbMjs=;
        b=VWWcVCFDhMyV5BPBbPbXBRoDKm+yU4cwv0O7mubvmew/RgajhbKnpWaKa86u5YYFQ2
         nAUplSSPYIcw1dz+sQfDg2Qt55WI0dKusIZx0qSId56HT4ER3r1iDP3Y98QQWbDqeK5P
         MTlgN4e+WEzWttRYnyyJF+PNo0nd+s5JvAoxSKKO3crTXUMio0rKO+bhnUqY7/9oY4hV
         Ri1N7qMxmTMPR1/dfYOkX7+omSndsW0fo74Pke3U74ZceBl86NVXxGvtt4bxf6fnQHe3
         xNz3QNEakp3EZLs6xipMShRzpC6tXUdghZCOmtbz0kxaPGp2HkV8RE8Xi0f8sxEQ5MPu
         0ziQ==
X-Forwarded-Encrypted: i=1; AKwUvByCLji1FLHtvMHRhaGc15gQeJvhNKjx69zl/aYdPYWr2Anqv6N4BGk5y5wHpECtcE94cq6tonY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMtaXb8lmhFA8eEZz5FlWvO/6Z6WBfpymS91NaBAjtDkjYnlQQ
	RzZcEVIUDZWNXIIMic0ju8ZAKbrvernc/ZrtpzxB3ixr0Gd6xE5wFM+TuUGhrQ6YWyUxRFZdlxF
	J3LX+p6NGw88Wd5opTY8aFWDM22B/ELE=
X-Gm-Gg: AYBFou0PJqnCupB067JQ6zQ45MkMQsfv9t6v38DNn8A3AQtKvO8cUKRGHxHt+XpleU/
	liq3ME6CPfLiQPBEWqz+Hj4CuDn96TVhKtAdJwO3GYsPCfIQEn5b1DRj6FJV0KrXZohHyiYdiF9
	b/BPqhfDJjo759oj9Nr9SMGCTMSEW4BqZAA+5vi1RlV+QWgd50uvNyK8TeN9jm8DB9aPprmFrRJ
	EEZrZux+xkeFWJxW7er+VFOBZG7vIgfzKlPaS/3l2J0lc7Bf/NYzngqMCZEo4FmgFfd7s44Z2It
	/0yKu+Qg56Kt3efWzxoHqDKPC4FJI80RfqNh2xXhlwzvRFpJJ5Ln+g==
X-Received: by 2002:a17:90b:2548:b0:3a0:d651:3957 with SMTP id
 98e67ed59e1d1-3a7873ac66fmr3158501a91.35.1791105309539; Sun, 04 Oct 2026
 02:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <20261003212241.3432303-2-lrizzo@google.com>
 <7ce092a4-5c85-4391-809a-3d04b638a722@infradead.org>
In-Reply-To: <7ce092a4-5c85-4391-809a-3d04b638a722@infradead.org>
From: Luigi Rizzo <rizzo.unipi@gmail.com>
Date: Sun, 4 Oct 2026 11:14:58 +0200
X-Gm-Features: AclHuK-h1jLN5HUM25V1KDJrvXlK_1XFkjlYVZ2OmcSjQmXYi39ZO7A1D8RAYWw
Message-ID: <CA+hQ2+ieCiXpnRzv7t003cHKG-YL+jSOSgVO_KavGEkbKfOeuw@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 01/22] iommu/dma: introduce CONFIG_DMA_PMD and
 metadata table
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Luigi Rizzo <lrizzo@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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

On Sat, Oct 3, 2026 at 11:44=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 10/3/26 2:22 PM, Luigi Rizzo wrote:
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 6e07bd69467a3..1bb347fd9da4a 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -158,6 +158,38 @@ config IOMMU_DMA
> >       select NEED_SG_DMA_LENGTH
> >       select NEED_SG_DMA_FLAGS if SWIOTLB
> >
> > +# PMD_SIZE IOMMU backing for DMA-coherent devices
> > +config DMA_PMD
...
> > +       Costs 128KB of metadata per GB of DMA_PMD buffers, allocated on=
 demand.
>
> Paragraph 1 of the patch description says 64KB per 1GB, not 128KB.
> Or am I mixing things up?

256B per 2MB page, 128KB per 1GB is the correct version.
The number in the patch description is a leftover from an earlier
version, I will update.

cheers
luigi
