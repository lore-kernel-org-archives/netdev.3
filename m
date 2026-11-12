Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493160;
	b=Vv9GD2LefrhhrJbpfpg6X2uS4Fg1r2NpffhJKuxOYPIcYIU0f1G0rimWBvXzsTA5XU5+
	 qoehDOx4INXe6sd70PnBG1n7bCRCFSlQaGIEQSxMIE37cw7O7o2g4B+pcMAlv0U800bhr
	 nCragYVaHEhwurs8fwRTjK5IuSo9LwzBs/6wqSDhJwMr24JZb7n4ZcpA+JzjLvpUGR/mx
	 uvQFxzMUlO9TZEtO1RH7gdEYU+d506rw7SnIUkYf1UpJpw+tND1e9ZTD8lawgOP8PgVzZ
	 cLJJdWYHoT91RECypQNaGJIWeJZs7iXnX4q7Q5Ti4lxNpLrJnYtiOTgpl9vGxSp9K9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
	b=Lc64I2MTo5ELWIfgwjExqGwZIoScor2wUwSuBIfRsjziCIh2oNXPl81z2t8Rd0QQmdBk
	 RiXLkg0vAJBsWQAw30cdaXjQ5c/O4Ypn71B/ME10f97tPkiRQrd/TfW3i/PoKTDZ8oLL4
	 OVT+Zo5trY08+/KkvzN/cq13yfY4nU8Vp07tB36mYXKg6B3n5mZlqnbqFxU51j2X0PNZd
	 JLfymgYB8v3osZD7KTbK4chpp9NIKagxSnQjKWEfET0nOdWR09g/VUFUFEUJZoXGYkLJy
	 SVgBDTEApRgZFjFELCMUEIFSx07RUL8P0Kr/E89iCt1nvHCLcDn9onW9QVA+HdX2+oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n740z2IW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69D606F905
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B69D606F905
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n740z2IW
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4ad89c49e0dso1378292fac.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:19:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794493158; cv=none;
        d=google.com; s=arc-20260327;
        b=nPMioD5I6zByF5b8orIdYbLQflQ58GzCtuawNdb6CNrOtli80QYb4hFG4SoWKyj8X1
         R7NPkLbXYh56orb8cY7m1M85ShqSyNywfc9pz+8zdR9QIz3wgkgkeSlHGj09biauezvd
         bkn0MNNhM0Srm0M78heZDeO7YwUZNPueca3moOMJZbUkX9clrLclw7BCMGEopro0bCqu
         nmy6/L3mhfhabXVoiiL3/+aRa6745J2mB6XddfVQokRIbSW59njzLICaSrp7z2lo9uPb
         BxL8vc3nPOiJdhep8TRKBkU12eNcgLgdj2RvFyfe654QmGr3dDUSWa0A9oklJbC/5xMJ
         2PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        fh=H5OzmLa64kgijBvfNV92fKZbMcaxbaBBBb+j2T6ocXQ=;
        b=bI0uT74R4YVTfwl4CbEfQes3zlaEJiluaxpNNCVW6ok6f2ZuAaXU5eBiuorYw4/4LD
         wHxNccFkUC1abMjqOfQeE7hER0bS3XS1+KQnJVbnla5KGayKArQsvkbwmlY08QQ8bLUu
         TF9b2qWdytDsX6zZOFV8nhpcgAvz/wpB6BU5pvJO+mtJmrlRO9p9VKvI1ve30z2Gy+2l
         Q7RxjHDIvYAJLxL90O6lpcj1Gxg8ebKfn1aKVpO0IWpjyH8YMipO/bSiwe2z3sK9XonF
         3DVfx8CTbOp5n1XqaHg5/PZzV6f625LY60u4szt0E+0Zw2rVzO9h1XiUb7FI4n9cDf23
         HGsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493158; x=1795097958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        b=n740z2IWYCmLBpYIgW448OkK5o3ft2gBxMpiTJ48LxTVxlMv+7UQabzWl8F6WGKYQa
         XOfd8zRj83llakPGeaGvKqWA1+fkHDUv6vc50OyrXLWCPWh6/t8U6bdPN9+S3G1DjowB
         lj02JtRwQz4UnVKEsAv+Apof0XrKarU3AkD0puPyB+s2T18f7BeAZe/GWMdgaSvY4NLa
         mpjbtSeIuZPbTZJz+aluoECSmzpKAziUUS83YuZBggqNkBcaBQ9Ob+mKPtJP5/y3xtWK
         Yboa6/x23UgnFTTfsxFTFIRiSHJ3qlAt+HzWqjptrbJHXV601r5hfhzHbCGQR7h3YTJ6
         L2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493158; x=1795097958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        b=f9jj0ZPk8k5MJXOlzEIECSDCBShlBejR07fcGWfl2AhJKKKM6O8S7ddCad4FqGVkiS
         uNLpK7R03ixYH1N6LKWzs8ELg9DPYGvyGCmRp8q2movx89OAn5cWq7GkALrgtX0upe3U
         ZSwPtYBXDD4GTF8W9PunVC0IX0vEoEMRWK/YiOY3de8MepkB6C+RRX5L2BXD4K1t5WH+
         iaF4iVcCR4H7XF/kDoQP8cQ5Q5Bvs0tyuy29QmpvIQUC99TrxH2JK4DXk+ZxLSfJpxwH
         In945w+qfo2DbFt1GJ5dyZjoTnOvNs1lYLeM44fool7sW12Ycr5I1iQfxcPfhvTuu5b3
         6w4Q==
X-Gm-Message-State: APuU4Z+oPXuC9wBuYazHyD9l+eupX22RYprPpZ6mdHKAKbEdmhn23M4K
	ZO278UpWKq8htnQnu6E8xIfO5eiKu1sn9vYc8W9c97JThcCp/L+OPVrYypNPMmUyZJ6eK/SH89x
	gk5cOU57Mm6mqyOWWV+44A6f1SyyvKaM=
X-Gm-Gg: AYBFou13ImC42e5vC0zBYSpk6G3EDSvjU4ZtowH7ChyUrBjGRY+R51jSIHEQ9+YCVFb
	sGpBqT0dzOO+EraspPLLNSDMQ8Mc1TzN00So0fr3Dit7BoZ28M6RcCc6iczAc2YtcaTPxjSZHeI
	0SO4bjnpybmesvZnO6c+IcsHoXyA8kyRzxleytIshKkom3D3mlZpSgaFY0t4uWpSzQwhQ7ua4Kn
	86/4XwjLgE9n5r6myLD17gc/MdYo+78vC/HJ1qD80IXPKkWITMLx5LThv40nxP8letttlA7fsWU
	8H0D4o+hkwdnQgFycSdiTyDgQEc/AzGKeXU9RM6W6sjTgGgDtJSgxnu+Wel9AE0+TznJGZiAHVn
	Hz9fWbRhjMWgiRjafNvLHbmrF3rX8PUPgg2VLOK2F6I4WRqjf1YR/OXAItVKypevW/eX1
X-Received: by 2002:a05:6870:8186:b0:4ad:8800:b277 with SMTP id
 586e51a60fabf-4ae46b9f2famr4644533fac.24.1794493157905; Thu, 12 Nov 2026
 06:19:17 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112091451.22969-1-amaan.cheval@gmail.com> <179447532371.2168702.1261444176228225499@kernel.org>
In-Reply-To: <179447532371.2168702.1261444176228225499@kernel.org>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Thu, 12 Nov 2026 19:49:06 +0530
X-Gm-Features: AclHuK-8r8_CUyAx0z3-RpELzn7MRNMdR_7wvQomD_xLmxRhfmXb6fT2JGFsk1A
Message-ID: <CAG+wEg0k_VuhZ5Y4zPyUvaTmK-erV6=A6TDmFS5E9Ycu5B1Rcw@mail.gmail.com>
Subject: Re: [PATCH net v6 0/2] gve: fix RX page refcount overflow with the
 pagecnt bias
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com, 
	przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 2:52=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>

Patch 2's bug was triggered at runtime; patch 1's was not.

Patch 2 (the refcount overflow) was reproduced on gVNIC with the splice(2)
relay proxy described in its commit message, on GQI-QPL (n2-standard-8,
6.12.113 and v7.3 mainline) and on DQO-RDA (c3-standard-4, 6.12.113,
where DQO-RDA still used the bias). On the stock driver ~78 of 100
downloads through the proxy failed with EIO on GQI-QPL and ~39 of 100
on DQO-RDA, and tee() of the pipe failed with EFAULT; with the patch 100
of 100 completed. Harshitha also ran the reproducer on an N4 VM in
DQO-QPL mode, the one format I could not test myself, and gave a
Tested-by on v2:
https://lore.kernel.org/netdev/CAEAWyHfCM_ZesnChP71AQvxjM4MASwukesgzuWCYECt=
s7jiNhA@mail.gmail.com/

Kernel messages on the stock driver:

  WARNING: CPU: 5 PID: 1198138 at net/core/skbuff.c:7324
skb_splice_from_iter+0x118/0x300
  RDX: 0000000080000000 RSI: ff34c0bcc1881c00 RDI: ff89153145163c60

RDX is the page's refcount at the sendpage_ok() check: INT_MAX + 1.
With tee():

  WARNING: CPU: 7 PID: 3008617 at include/linux/mm.h:1456
generic_pipe_buf_get+0x51/0x60

And on GQI, once the pinned page comes back around the ring:

  Pagecount should never be less than the bias.
  WARNING: CPU: 0 ... gve_rx.c:507 gve_rx_can_recycle_buffer+0x58/0x70 [gve=
]
   gve_rx_poll ... gve_napi_poll ... __napi_poll ... net_rx_action
  gve 0000:00:04.0: Performing reset

The reset recovered on its own within 1-10 s each time and recurred for
as long as the pinning workload ran. The reproducer, full traces and the
kprobe measurements of the refcounts are at the Link in patch 2:
https://github.com/AmaanC/kernel-bias

Patch 1 (refuse XDP on DQO-QPL and GQI-RDA) is from code reading, not
from a crash. The DQO-QPL use-after-free on an XDP_REDIRECT to a copy-mode
AF_XDP socket was raised by Sashiko on an earlier version and I confirmed
the path through gve_xdp_done_dqo(), xdp_do_redirect() and xsk_rcv(); the
GQI-RDA NULL write came from Sashiko's review of v5 and the FIFO
allocation in gve_tx_alloc_ring_gqi(). I have not run XDP traffic on
either format and have not reproduced either crash. Patch 1 is in the
series because patch 2 makes that path matter: with the bias at
USHRT_MAX the driver hands its last reference to the consumer once every
65535 handoffs instead of once every INT_MAX, so a copy-mode AF_XDP
redirect on DQO-QPL would free a page still mapped in the QPL within
seconds rather than, in practice, never.

What I did confirm is the attach itself: on an n4-standard-4 whose gVNIC
runs in DQO-QPL (queue format 4), Debian's 7.2.11 kernel accepts a
native XDP attach once HW-GRO is off, Rx buffers are 2048 bytes and the
queues are 2/2 to get past the driver's other checks, which is what
patch 1 closes.

Thanks,
Amaan

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
