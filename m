Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0C4CCDCA
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249136; cv=pass; b=hx3Pf6snamSHfW1Cm9efArLbOYoTKvi78i0MxrXtmYLxrvkkZa+J7jZq7KnCZcR5tMCE+ABImv+fsplb/MmebHASi0y0gdHeZWNGtUZiEwBLdgT5RXh8wzaC8pNwcN8uKJ8FDjkJEsIKjduE9xMv8ibpqKmD2PlleD7UXllWqZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249136; c=relaxed/simple;
	bh=f2SvoaHMBY+e2yeANZCKiFHFNFiVIrmBjpjE6bEI1SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9Z59xrbp1B77ZIz/zObyNvJlcClmyMcEN0OR5eAqGC36VZTUju8+ti5aqWtOK6Hovae9yxtJTNKrr2cbgeSfMqmHcG0BSd/MDq4JIviUNnAph9EAHYDeBeBONW2rjt19Sx8mCakUin3o0Hw79CI5/tTU+goLn1M/dgTTb94Oe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzNv2LKG; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzNv2LKG"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so28482381fa.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 00:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788249133; cv=none;
        d=google.com; s=arc-20260327;
        b=Dw8NTBlSJafRAZOT0+1z5Ef2wmRAiqcv+584SwnNGhGPxsN6U0Y2FA8S4H9t2Lgzkh
         oejwJqFvvagCjoe464RUHt2TsPZa8oESkXj1dM2QyKp7rrZNjwVtb2o0vOGXMWCevI4s
         wZqnctvfgj4spWAlvo0+LHF7PEjxjEoR+xJzWPGfNznNlIB1wSaZ/EI1GawfsOQr2P7P
         2btA5U77tjZTpJ7bDKkQdo8D35j3oP8F2LT1DshrhDA621M+JcIrge9PCTBO+ZTUTgE0
         CSC6xbv1q39s+cJ2E1zmSN0R7O0tCICbB2039+Gf3nRYmYH1jH/6SH5CBmxLnpTNDQ6k
         xy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2SvoaHMBY+e2yeANZCKiFHFNFiVIrmBjpjE6bEI1SM=;
        fh=ArQV1EkStDqwEArEdPb9AZuADN4e1n9QhI7eAcRm2ZE=;
        b=Z8mufmwHJ8OSEVdKNala2I2q+elrKJQO6f4ECSWtkTt7F76t5blufHxvj1AqTj9O8k
         xGQrGQLbP2Tl4793kAESUszPWvGKVzEeuG1WktIN9fJO3sdYy+y9TQqp3o3dpGQkpidH
         6hp0mN9Xc9cQrffCx6KJKdlld19XUT1enXBdV03pMU63K+PqWDKPRgkX3h2HcsEccv9w
         ffO6iCAa0YPKg/l+oaQMMaTDWd0+3YMqn4yBfQMQESdvqn7tRncf3l7g0Wkw0yEuaogH
         6fd6dkpMiiIfe33cBPK1wUy5KiUhvXkQcYcH3n4jVn3PvYW+MiVRotCD3i4Tbo5obfcu
         PbEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788249133; x=1788853933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2SvoaHMBY+e2yeANZCKiFHFNFiVIrmBjpjE6bEI1SM=;
        b=qzNv2LKGDZvj1zdDnLPE3PAKVegxutlBKDQwTM9GCP3UqCwBSX+A6UQsJeGw6XfpZV
         2lyPZW9CWeoCRZyBjg1QU/pt0u8PCkWBgSCE2g7VJQ4Pp8l2ET0Z8ITCsGLC6htCbNIN
         MO1uAztFG/KUoEqc1cpnhVFIWyd7w+fqytXQObDRg2cQKpaHyYd50rUlis/accxvFy27
         RRHSEi1DVTv7tszhx6foujhzCbxNJVB/ZWJeFsLeyavfS+jkAZwEtflJdBMKMSci0kLx
         RVt3BwmDu4/CXmikNeo6tvAKrvARpKffgwg8yVChVAPwqgB6R2GYZXRDcokIaeaWkA1j
         hihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249133; x=1788853933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2SvoaHMBY+e2yeANZCKiFHFNFiVIrmBjpjE6bEI1SM=;
        b=VYXtRG2yNHZUxeho/4CStpYFeJU712N83H8S4v4p2TjbuQAoqYJySLGN5kPQLv7PBj
         vRcQ2A2WaIzYUL0DGhRrs9WmZZJ6HW4yPe5oUioHzBlnofMRXKdqFhX3MqR2El7tfbkm
         6FYiLV/Az8XZ88zj5IgK2kxTlKtapRR/FP7Sswcp6qNAdBw+tB9o1azXdZJl/AI00luQ
         +P2dAp2croKjh/YhANwdU+a0MKvpF9Lxvdt7bfltxllOQ2UI1wg8iBP94ZF3yUPoq1O8
         CXVIqSmLtRWVGIEDRNY6mSs+IVC0YpgOl9ckPooKIwOVsgxgDH5neV2DgezwuCaCFIWl
         QZGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxj0LX0Oa668hcECwjN3CXZ2Z/KA7BnGddKG1GcJhoXWAEptIpKM0QZo9tQKxxgBYxfUXOy6+I=@vger.kernel.org
X-Gm-Message-State: AFuF++kqwgS2HlVk+KJf4IGmVKYGMH6jibEEWDNVJpPaZRSbR8ZMhbES
	ubjxy0/nFHtxjPYAM54KcHN69UzT9H9Xnpxzg94TVmFQIugdC9rzZAks7kmX12PSAR/yarwoIaS
	3ivBTmTrFF2tYcEwHVM5DUNaJ3P45KWo=
X-Gm-Gg: AYBFou1DwbYz+z+G0DLqw5yWZ0+QSGbYH87fBJm/Rng5RArKxYm8gSwBacVRiD4eSDI
	Yv+K0RikvkepB5rwwdGydRv/k2TeUW+8SMFxaPe3JAhpjIlpuHaNuZzRaPgHvG/oIAKKJUic2iC
	0e0BUVpRep2+iZg6IftynDKrzzoM79Ir8w1LhPD5lWNAsbWmpmRB8UiYHfJCcMVjSq1YvC9VSb4
	3kOd2gw2/FjrYq1Ej+IUwVhQIe6Difus9N9uAWl/5xwnX27/LQP1BscUa6rCXAvh5782S+tl+9e
	S4uzXE4vjvjMPkFUHIDG8rjkiixrtibbIr0xIkJtvmKXQ80bGd1jq2Ir6zIojqjZyXk6qYd37Br
	RYphV/wEfF1iMJ5rAhj3VwhUoZbB0CMhGZSDhUESOefk4pssDCxDIUGcGZw==
X-Received: by 2002:a05:651c:19a8:b0:3a3:364:f789 with SMTP id
 38308e7fff4ca-3a3396a1515mr14100661fa.13.1788249132694; Tue, 01 Sep 2026
 00:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826012052.51028-1-kerneljasonxing@gmail.com> <20260831170241.42be3376@kernel.org>
In-Reply-To: <20260831170241.42be3376@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 1 Sep 2026 15:51:34 +0800
X-Gm-Features: AcwNN1V51y4KlWVOYUVZKbQZ-CUBVvL-G8CKpu_Nc1ByFljrfLbX5o3XONxfAYM
Message-ID: <CAL+tcoA43QntBFMCXcK5z5YPpRKKY5QDV7fv0zLhrL32trvWqA@mail.gmail.com>
Subject: Re: [PATCH net] xsk: set network header on skb at generic transmit
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 26 Aug 2026 09:20:52 +0800 Jason Xing wrote:
> > Fix this by calling skb_reset_network_header() in the common path to
> > cover both the copy and the zerocopy cases, so that network_header
> > points at skb->data and skb_network_offset() returns 0.
>
> But you're setting it to start of the frame so most likely L2.
> AF_PACKET seems to probe to find the true network header.

They differ in this aspect. Because AF_XDP unlike AF_PACKET doesn't
take the responsibility to insert a L2 header for the data that
application tries to transfer.

Probably you refer to transport header (skb_probe_transport_header).

> IDK. At the very least the commit message should be explaining
> why the fix is right instead of the slop explaining the path
> that triggers the crash.

Thanks for the suggestion. I'm going to add the comparison and more
detailed sentences about this.

V2 is coming soon.

Thanks,
Jason

> --
> pw-bot: cr
