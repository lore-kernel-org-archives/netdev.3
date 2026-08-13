Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA64746C1
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623396; cv=none; b=PlwVmh+zJ1EVaZTlxWJ/Hrxd1UmBazhZ9kF150z2Jyu+azB/xEvcAtkmJ6kVTxgeRF4LOE+gXtH85z2IgC6ri6POnpUBe3nFVtWuoE1XttmN8D5syAPxrCDEXQgwGIeglKeYEGkABi2vTH5P4KVlIztafEMDQt5H7Ew9jq3YQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623396; c=relaxed/simple;
	bh=vZMp/jhSedRjYjERTnbU5fu00RU6pQDbC5U3lAgvHAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrELqBFSV1F7Zm9ytRziLd2kKk4twXzaU4oEIpKtrnCkxLJT2FGd8sumrVAl+v/rJGDAN1E3aHZoFihSmYUq3ZOnP8Lpnl4ZuC7TnQ43iCIQJhKgk+NbTmL92TP4xbKlLBgeQ2z8TE8lwyE4ihE1PUN/f2FDiOlOsveCHRLfuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so455297e0c.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 05:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623393; x=1787228193;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eUEz9MmS/ZMTpS71m//GPTdjmhNSfvkvxegoNqBBD7k=;
        b=O7aF7kQbJvnlxb+GlcopnQcoAfZJlEDwuOoKeG9zODgfyhMZGTcfFwcFtewtCJfHai
         J9UxZ5iwudMi64Q8g8mPUmYOs9oa4bRfZSxcS6KaodrNfBsxDaR2IrCQLQ4xj7ONWuQ3
         T1hved4R1gZUqMRUJ+gq91liHtCoE2PNuelriz311iP60fYaKKw/8goEl7LJLDIfkYXj
         NT1lOM451+Kd+8yKZEFo/xVnHCS6a9a90wvR690tkhjWFx79cNkWF1rPpyC5Pn5leqKR
         x9T3JE+9YaIePUmDy92M6gU+js1RNIKm6c0tbw+LvHW9znCrVQ+HLB6RZ+dLi2EVF/gi
         CHPg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8GAxeVh9OU63cMwUbnyCoYVAuGO2R/q6stKODty7c3TJnAu2WQEVEyo1AvG75jYr0YAsNjUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63CH5YqZQ0TioL/AFvoPPVi6nt7S3jMYDYmX6AAvENvKfWxPC
	3Kwkl00pVV5z1n4hVC5VAgaZm1eslGyl651dq/A5g36TDPI9av2bQDUwH4rp5e/s
X-Gm-Gg: AR+sD10JWRfclo6QG43pIPnATtlHpD9j1KP5hPEuMXRkskUeTCn77RBM+U+MJ3jDrMr
	b9WjCDZjYCuWjOnX46OoKEIa9c2q0tDk0azMZWNs8+4LcP5THUwXXtsL9o5AJI9qvA4KvFFzUZF
	eCCFPzFgkywFcOy7/V8+ADKj5Mj9tIqPdp90F4ySR24rU5felkk+6ng986QzVDQkzWZg4/LdRxR
	IecAPhHpI1yP7+Wn/TMJy/eZAPZ7JsiBbMrnaqFCvLh9LsagLn6fZH4mjnztbFuwUXqcSXr4dVL
	lWjBGTHn/ampDfC40FC/xqe/mtazODY0Ebv36UsJreHj4Rp+GWdclTOEXtfj8s7BYg0Xe+bJz6u
	CM1RCqFCOjiXArzWs8Q5eoxddSt73Kda0suS35ZVauON4A9jC8QbaCMQc5ShBYVqTp0fhc+w0Ct
	nbcUa15otMdBl2nXM0pxFyJtwn94xD4xX9iSNxhyjU8GrZa2WPIZ0/X1QvbIfUDAyol1i28uHxh
	oFphEQ2oAdM/qsP8pb3O+xHnA==
X-Received: by 2002:a05:6122:1802:b0:5bf:b497:87c3 with SMTP id 71dfb90a1353d-5c5796fe6d0mr799058e0c.0.1786623393394;
        Thu, 13 Aug 2026 05:16:33 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c57be263d4sm628969e0c.12.2026.08.13.05.16.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 05:16:32 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-977258a75d9so404718241.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 05:16:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr9cyMAoh4JDkBFtYXkVG6RjjFBeI1CXv8Nr2HFDk5AnWIv6Uor4emX2FJ44k/2TsCNlvcHCLo=@vger.kernel.org
X-Received: by 2002:a05:6102:4495:b0:74d:cef6:af78 with SMTP id
 ada2fe7eead31-76db6082df7mr1479352137.7.1786623392340; Thu, 13 Aug 2026
 05:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813111121.1672-1-manushprajwal555@gmail.com>
In-Reply-To: <20260813111121.1672-1-manushprajwal555@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Aug 2026 14:16:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0H-uj4VYdrsFT2ThRdEhX6Tu9V-A+gdonxGXU0OvENQ@mail.gmail.com>
X-Gm-Features: AUfX_mw2ew-azI0O3O_fm2ZjSGzSevwqJHtDqQb4wOTW-IKRVJm0PT7TTvi78Ig
Message-ID: <CAMuHMdX0H-uj4VYdrsFT2ThRdEhX6Tu9V-A+gdonxGXU0OvENQ@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: renesas: rswitch: fix device_node refcount
 leak in rswitch_get_port_node()
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manush,

Thanks for your patch!

On Thu, 13 Aug 2026 at 13:11, Manush Prajwal <manushprajwal555@gmail.com> wrote:
> On an of_property_read_u32() failure, rswitch_get_port_node() sets
> port to NULL and jumps to the out label before releasing the

s/before/without/?

> reference the for_each_available_child_of_node() iterator was holding
> on it. Once port is overwritten with NULL, that reference can never be
> released since out: only puts "ports", the parent node. Call
> of_node_put(port) before clearing it.
>
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

For the actual code change:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
