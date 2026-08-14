Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A718D636
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669534; cv=none; b=X4dv7H8bdvLccWRGpln2pwaQKmewlc+872EzeMmWJiWZMrYxERDGONOjGcs8EizBIy3G8ncz5crMgFn+lFVAFdFD2GBu+sduU7FnK6xX6J5IVqLJ21svLIAcx7QVtVHNriKum3Nz8tJ6IWzmKUlxBtm5Gm8h+fQhG+qL5aEW7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669534; c=relaxed/simple;
	bh=5wopqXQQTitJ4kiUoXjA3wrt5w/XRVQlGiApMt3/t6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrKr1iVYUQvi2TBe7QA8QcFBdrpP21jRI/yiSs7hHzbLiGdy7pp5s8YJUyVrjM1Y1WV5wRhjBYbSqjDOlsPbktbRoA98slpVH+Tv72gihUFDNkDH0psecdL40+eSpUIVQ8MWHpOWxD2DZGuVXQdmRcDKIUwubl1G4ribMLtOCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8tUtPQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8tUtPQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9816F1F000E9;
	Fri, 14 Aug 2026 01:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786669532;
	bh=7iUYHczkM8ggxniKLtcHr2bhd+vgzUTFNILXhpxAeg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V8tUtPQGR/8qdh+OMCCst5huDIIjOuZs9sMrFEUBobOgVgae+xOGmnr4iEzixXvx7
	 ySTDeV7Jm2KpgIb4NMmwfTuahMybH8nE66j1DV/F/aao6QQ7bG3IgZW+DABwsiOj7m
	 T8uw/pWPbOQGaUQV0q/l0QaYK607AUv0TW3UTWR9OeVBRxRM/UOcAA6LkFU/wbqlm9
	 /ri0kHam+z7lHH6tAygaIiKMdQuAwMd6op3Hc25wScEs1lI/UiQBZy5Ff83D1vDGz9
	 TvrtwjevLo925327sxFkp2fJOaOubz98nl4Krbclx3zk6hZhSGrOEF0kFDxcfbx74Y
	 eF3MbIr99njJQ==
Date: Thu, 13 Aug 2026 18:05:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6] net: airoha: npu: use coherent DMA for mailbox
 messages
Message-ID: <20260813180532.3683abc7@kernel.org>
In-Reply-To: <20260809152813.585797-1-pawlik.dan@gmail.com>
References: <20260809152813.585797-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  9 Aug 2026 17:28:13 +0200 Daniel Pawlik wrote:
> Commit 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox
> buffer") switched airoha_npu_send_msg() to DMA_BIDIRECTIONAL so
> non-coherent CPUs invalidate caches before reading NPU GET responses.
>=20
> On EN7581 + MT7996 that change regresses probe: the mailbox completes
> successfully, but WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0 and
> mt76 never binds NPU offload. Healthy boards report 0.1111.

This sounds very odd. Is the DMA API broken on the platforms you are
testing? The code looks correct as is.

FWIW here's what GPT suggests:

  Indeed, HEAD^ uses the DMA API correctly:
  DMA_BIDIRECTIONAL map/unmap must make the NPU response visible to the CPU.

  The important wrinkle is that, on arm64, these small kzalloc() buffers are
  forced through SWIOTLB when mapped bidirectionally. DMA_TO_DEVICE did not
  bounce them. HEAD switches to coherent memory and therefore bypasses SWIO=
TLB
  entirely. That suggests the actual problem is one of:

  - SWIOTLB memory is outside the NPU=E2=80=99s real DMA aperture.
  - The platform=E2=80=99s dma-ranges/DMA mask does not describe that apert=
ure.
  - SWIOTLB copyback or cache handling is broken.

  Using coherent memory for a mailbox is reasonable, but this patch masks t=
hat
  underlying problem rather than explaining it. Before accepting it, I would
  test a cacheline-aligned, rounded-size streaming buffer with
  DMA_BIDIRECTIONAL, while programming the original payload length into the
  mailbox. If that works, it strongly implicates the SWIOTLB/platform setup.

We can take a revert of the patch under Fixes if it's urgent.
The real fix requires a deeper investigation.
--=20
pw-bot: cr
