Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8A565105
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002526; cv=pass; b=NDQtOKcYDzEDy4ajk/OX/j3q+aUh+5ie0DWyxdA9qs2XxfY4q/BPWmmZfNq6lTYUd/qBmSe6nU06s/hBGOOBlW83sILnkmFdnoqzMO5PoQ3hnPBCmxIvtpXOj0MYrcrAkqA2LfQwyVpeZkS5QRg4RynjaRj42Gu3oMwCJUWGjGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002526; c=relaxed/simple;
	bh=0+JRXvl/R9u5pNiuiBxqdsVIx1pGWTS2oCduhPjMn+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFBv2XNsECXT+XrDWUFLGyWAz/uqoDbmin3yJUgv7g9VWu7KLHMkptQ1/UzPmTcmXaHyJnzJw1CQxTJ/gKc67UkiSnQLdp0S4Lh1/aQbBImzszCJ+e2hxJt+2Quo+FyNQ/soNdjV5Sp8eCvR+SIgJJ+0RVEB40cEXUtkNqygEfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGOzOT6p; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGOzOT6p"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so237205ad.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792002523; cv=none;
        d=google.com; s=arc-20260327;
        b=DJogu6yTm745WmSJXKnL10XQ9y/o50g6cFAJ9p8UpwvGHmn4B1whQqxR2vDULyGnkJ
         leviDpdevmU2lGde2bc6MAsk8ubFXzlyqBZkOr101YAMmeNoTBRM+ybKnMcmFgB4XZZV
         cTCrn4h/F58dkOgIORM06bc/OLNs3tdcAhHGk6nKWJr1u6Z7JU3Q0wV1qPOYtUsPCxWY
         Tc44hKAKK+HyG/QxN3wEIupE6UmFrIIp0DOETA8IHfrx4Z7oh8B4qWyK0bipGlCBssWl
         SefL/VynSrY94ZWRWHgWR21jfR6tvolu0uZSp9PHoz83zmTI6cTfKoGpI7c3olXccw+w
         H6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0+JRXvl/R9u5pNiuiBxqdsVIx1pGWTS2oCduhPjMn+0=;
        fh=3J2MqcGlNt+uCAM5LlTZjXqtL0xDGQqVvCUEeRZPU3E=;
        b=XXUQggMBmLrDDN8YR94v16X0+FBKcunFJ9LmKl3HnxkRGg2sMK127Q0BSWgN5I897L
         nXmA29Qd+KqIbbd/TkdEFYXlqBMnQsji5C99RBQ9sMQGd3f+Xm9rjpPPjajsQxnF/GDq
         8SHcxo+FiY8p6zkqKalEEXegkNtb7fb4ElvPkeYk7qgEzW7zStE/Ii07hpSMYg/McrRH
         b2UT4R3rjJsvEguk8wJ65B9/SUkhOrkvOK0gDBskbNXKxEEAVbtJe/Ouh0wMrUGQ5bP9
         /WnJr1K4q4Kgu1Vmzkid4dQRgHpHIr7JHik8a/bcjyNsQBaiPoRzc2N+7xdKApE9xFkR
         Clnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792002523; x=1792607323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0+JRXvl/R9u5pNiuiBxqdsVIx1pGWTS2oCduhPjMn+0=;
        b=BGOzOT6pQv0mFri/8RH7QoElgFXhyBZG1RjsW5RNYxkdnYukiZrxD76D4K0ytM+r52
         YWjLYG+apmfLHG0e+NB8Bg1EBhaRj0TA1Gw8w/EtBKLwzAM/acQ2Ni9PHaL6bSsgUZNq
         9Jq5OxfuVQ+vtOumR1rHLjcnA6RE/utxHHLV8jMsDqeOSkTKB0FZ3ImfPmWxwgMmDRes
         dtimwJnMsjMisKDvBcSxx9qJ6EG1vKKThKHkQZBPxACg9Y8axR3Gx56HlJWPJpy8mTZk
         LazNQcFbkaSmmFxdnGtU82jIY6+d+efUIDiXskLm55S+u6cQfV2px5nEE3i66EVvITQ7
         0hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792002523; x=1792607323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+JRXvl/R9u5pNiuiBxqdsVIx1pGWTS2oCduhPjMn+0=;
        b=zqSM68KztMPGHoWQQ8T8tPJ0GAbJ4MLf7ZZtkgTixhQG934Y3YGu8N6ljoMX5gKnhk
         m2RVij3EOTGK3CHRPmAVnmDS+ESk5Gkg+fkEhfB/WjaRzbR3rwHbLoqgBfxcb6aN2cyK
         65KbK4lyR9ld37vew7ignbNUCOtmRBtJL4uswK/cs9lqHxWCYzjd58J7TKUSJ1Lh99Bb
         DBeDZ449DyAxpYWPfT30eS7IIocAxjW8GfYKHces8nJ/avqYmkY2UMZgxcRiBpmRVB1y
         dKTQlrL+4lN3XdBzTKJaRsMVQa9ooAFVVqhouvErFeXP/EJtPnco09ZXh6TlNOE7Fr8G
         SIlw==
X-Forwarded-Encrypted: i=1; AKwUvBzMOwPxweHFI7N9gfHtAzFYNF51k6GiJBzv+6pTHj2GX2BS8oYjSFePw9WXZq+Gep2GuNetaIs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL45+Sb/xfO/knx9Rm3+0bjShpgwMEqyfzSkHGKDKcB93H7WfyE
	zasvIChbfgFuhWswGbINghd0EbbxHcajgzJlFbJkDdexuFREyx5RaSlML13DxnRTekOdE0UIz14
	AWqlkgkuOs38r3dFMkjEuFlP0hk67Zag4pOP1mO69
X-Gm-Gg: AYBFou0+yThHxsl7OXH12U1FeZwBiEUs4gPqPlLrB+E51WMzhVTp9sCjGjxdhOZ4N6g
	vIplD3QB3iweLqy25L3wSzJNL7WBlGejx+F2tjUmRXMdZpIBG0qhRm552zOu+KYl4r2w8RTJzCq
	fP2SuFfxQdywxiDT4x4EJ/ZntMXLXj8S7nG2Ncrt8KW7hmPHTW7wNTIJkOb6OZiHq/gtE7D+428
	l8oSbuwiHfv9Oz0hvCa5NhWpPXFApZPwBLF56wbD8USDbEnzxNO5el6VF9gUOSBaE8DvYcKWGDI
	gWVQOH+pYs3r6qy1MNLvNnkRxF+YXBkdzecrW84L3kFq5fzs1HfKGJzC
X-Received: by 2002:a17:902:e944:b0:2e5:4604:c37a with SMTP id
 d9443c01a7336-2e87e303708mr18554105ad.18.1792002521805; Wed, 14 Oct 2026
 11:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <20261003212241.3432303-20-lrizzo@google.com>
 <52a702a4-14eb-4617-bd29-e3140fd36780@nvidia.com> <afff5a1f-000a-4216-b4df-dd3d0406047c@nvidia.com>
In-Reply-To: <afff5a1f-000a-4216-b4df-dd3d0406047c@nvidia.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 14 Oct 2026 20:28:05 +0200
X-Gm-Features: AclHuK-6TbXuD5dQp6Q_-RxWjRRPPqkpIpvGcrKlslQ4aEjsOkMcO7VIrHzh1iI
Message-ID: <CAMOZA0K4ZV53pE41AKoKz1g2wz3YENBz=HVoXng=RZbGyN3ssg@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 19/22] net/mlx5e: Use DMA_PMD memory for tx header
 bounce buffers
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
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

On Wed, Oct 14, 2026 at 7:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>

> > On 03.10.26 23:22, Luigi Rizzo wrote:

> > Why are only headers considered for bouncing? Because they have the
> > highest mapping overhead?
>
> I meant to say headers and small packets.

Headers have a high cost for the map/unmap (especially in strict iommu mode=
),
and also cause significant IOTLB thrashing, because they come from skb_head
that is not pre-mapped. The impact of IOTLB thrashing depends on
the hardware and load but they consume one IOTLB entry per packet with
almost non-existent recycling.

In the following version I have modified the slub and skb allocator to
feed skb head from DMA_PMD memory, which removes the need
for header bounce buffers. It is a compromise (the skb head includes
skb_shinfo, which we may not always want to expose to the device),
but gives an option to those who want it, and in that case drivers
that use pagepool can get all the benefits of DMA_PMD with zero
modifications.

> > Note that TSO/GSO packets will copy the header inline in the WQE
> > already. But not for small packets.

Yes additional bounce buffers are not needed on hardware that are
essentially using the WQE as a bounce buffer. I'll double check the patch
(mechanically generated).

Small packets should not be too problematic, as long as they come from
fragments allocated during the copy_from_user.

cheers
luigi
